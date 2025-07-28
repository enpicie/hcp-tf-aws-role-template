# hcp-tf-aws-role-template

Template for configuration to create AWS IAM Role with permissions for AWS Resources.

**Values in this template have placeholders for AWS resources that should be replaced for the use case of repos using this template.**

Below is documentation that can be altered for specific use cases as well. Use this template as a starting point for provisioning new AWS Roles with specific permissions needed for Terraform runs.

## Usage

Call [action-workflow-hcp-terraform-var-set-attach](https://github.com/enpicie/action-workflow-hcp-terraform-var-set-attach) like this:

```yaml
- name: Attach Lambda+APIGateway Permissions Variable Set to this Workspace
  uses: chzylee/action-workflow-hcp-terraform-var-set-attach@v1.0.0
  with:
    tfc_organization: ${{ env.HCP_TERRAFORM_ORG }}
    tfc_workspace_id: ${{ steps.setup_workspace.outputs.workspace_id }}
    tfc_token: ${{ secrets.TF_API_TOKEN }}
    var_set_name: ${{ vars.AWS_TF_ROLE_VARSET_<RESOURCES>}}
```

This attaches the HCP Terraform Variable set referencing the permissions provisioned by this config to a workspace to allow Terraform to assume the role with these permissions.

### Explanation

- Terraform config provisions an AWS IAM Role allowing HCP Terraform runs to provision AWS resources
- The ARN for this role is stored in an HCP Terraform Variable Set for runs to use
- Variable Set name is pushed by this repo as an Org Actions Var in the owning organization `enpicie`

## Deployment

Pushing changes to the Actions pipeline or Terraform config triggers a GitHub Actions run that deploys the Terraform config via HCP Terraform.

There are no dev/prod environment distinctions in this config as the created IAM role and HCP resources will be provisioned in enpicie's singular AWS and HCP accounts respectively.

The pipeline will trigger on push to main.

## Setup

This config consumes the OIDC provider and IAM role with permissions to create IAM resources deployed via CloudFormation template in [aws-terraform-oidc-config](https://github.com/chzylee/aws-terraform-oidc-config).

Relevant inputs for this config are configured in [terraform.tfvars](./terraform.tfvars) for easy configurability.
