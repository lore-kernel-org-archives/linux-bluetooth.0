Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 3/4] Bluetooth: Fix Remove Device to wait for HCI before sending cmd_complete
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418981017-10462-4-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 19 Dec 2014 11:10:43 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A59BB1C9-C4D1-4046-8C62-227DF0C47400@holtmann.org>
References: <1418981017-10462-1-git-send-email-johan.hedberg@gmail.com> <1418981017-10462-4-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch updates the Remove Device mgmt command handler to use a
> hci_request to wait for HCI command completion before notifying user
> space of the mgmt command completion. This way we ensure that once the
> mgmt command returns all HCI commands triggered by it have also
> completed.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 49 +++++++++++++++++++++++++++++++++++++++++++------
> 1 file changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 7efdeb3cf224..ab3dae3076d7 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5522,16 +5522,47 @@ static void device_removed(struct sock *sk, struct hci_dev *hdev,
> 	mgmt_event(MGMT_EV_DEVICE_REMOVED, hdev, &ev, sizeof(ev), sk);
> }
> 
> +static void remove_device_complete(struct hci_dev *hdev, u8 status)
> +{
> +	struct pending_cmd *cmd;
> +
> +	BT_DBG("status 0x%02x", status);
> +
> +	hci_dev_lock(hdev);
> +
> +	cmd = mgmt_pending_find(MGMT_OP_REMOVE_DEVICE, hdev);
> +	if (!cmd)
> +		goto unlock;
> +
> +	cmd->cmd_complete(cmd, mgmt_status(status));
> +	mgmt_pending_remove(cmd);
> +
> +unlock:
> +	hci_dev_unlock(hdev);
> +}
> +
> static int remove_device(struct sock *sk, struct hci_dev *hdev,
> 			 void *data, u16 len)
> {
> 	struct mgmt_cp_remove_device *cp = data;
> +	struct pending_cmd *cmd;
> +	struct hci_request req;
> 	int err;
> 
> 	BT_DBG("%s", hdev->name);
> 
> +	hci_req_init(&req, hdev);
> +
> 	hci_dev_lock(hdev);
> 
> +	cmd = mgmt_pending_add(sk, MGMT_OP_REMOVE_DEVICE, hdev, data, len);
> +	if (!cmd) {
> +		err = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	cmd->cmd_complete = addr_cmd_complete;
> +
> 	if (bacmp(&cp->addr.bdaddr, BDADDR_ANY)) {
> 		struct hci_conn_params *params;
> 		u8 addr_type;
> @@ -5555,7 +5586,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
> 				goto unlock;
> 			}
> 
> -			hci_update_page_scan(hdev, NULL);
> +			hci_update_page_scan(hdev, &req);

so it seems we have done this at least once before. This does not mean that I start to like it now. Especially since now we are adding hci_request pointers to almost all of them now.

I have the feeling we need to fix hci_update_page_scan first to only take the hci_request pointer. We really could just do these two:

	hci_update_page_scan(struct hci_dev *);
	__hci_update_page_scan(struct hci_request *);

And then of course similar things with the other ones.

Regards

Marcel

