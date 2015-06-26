Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v1 1/2] Bluetooth: Move address type check for hci_conn_params
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1435188850-14969-1-git-send-email-jpawlowski@google.com>
Date: Fri, 26 Jun 2015 20:44:13 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D6AFDC25-610D-4DC4-9252-9A6D995FC5FA@holtmann.org>
References: <1435188850-14969-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> When using "add device" mgmt command to add devices to whitelist, only
> identity addresses are allowed. This restriction is enforced in methods
> manipulating hci_conn_params. This patch removes those checks, and
> instead add a check inside "add device" command implementation.
> 
> Reason behind that is hci_conn_params structure will be internally used
> for other addresses in upcoming patches modifying connection procedure.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> net/bluetooth/hci_core.c | 11 -----------
> net/bluetooth/mgmt.c     |  7 +++++++
> 2 files changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 2f8fb33..bc43b64 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2822,10 +2822,6 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
> {
> 	struct hci_conn_params *params;
> 
> -	/* The conn params list only contains identity addresses */
> -	if (!hci_is_identity_address(addr, addr_type))
> -		return NULL;
> -
> 	list_for_each_entry(params, &hdev->le_conn_params, list) {
> 		if (bacmp(&params->addr, addr) == 0 &&
> 		    params->addr_type == addr_type) {
> @@ -2842,10 +2838,6 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
> {
> 	struct hci_conn_params *param;
> 
> -	/* The list only contains identity addresses */
> -	if (!hci_is_identity_address(addr, addr_type))
> -		return NULL;
> -
> 	list_for_each_entry(param, list, action) {
> 		if (bacmp(&param->addr, addr) == 0 &&
> 		    param->addr_type == addr_type)
> @@ -2861,9 +2853,6 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
> {
> 	struct hci_conn_params *params;
> 
> -	if (!hci_is_identity_address(addr, addr_type))
> -		return NULL;
> -
> 	params = hci_conn_params_lookup(hdev, addr, addr_type);
> 	if (params)
> 		return params;
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 7998fb2..a7d1b33 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -6226,6 +6226,13 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
> 	else
> 		auto_conn = HCI_AUTO_CONN_REPORT;
> 
> +	/* Allow only identity addresses */

I would not mind if you are a bit more verbose with the comment on why we are checking this here and not later on.

> +	if (!hci_is_identity_address(&cp->addr.bdaddr, addr_type)) {
> +		err = cmd->cmd_complete(cmd, MGMT_STATUS_FAILED);
> +		mgmt_pending_remove(cmd);
> +		goto unlock;
> +	}
> +

I also think we now need to add this check to remove_device() as well since that previously used hci_conn_params_lookup and we want to ensure that errors are correct.

Can you please make sure we have enough mgmt-tester test case coverage for the Add Device and Remove Device commands so that we can ensure nothing changed from an API point of view.

Regards

Marcel

