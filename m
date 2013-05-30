Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v2] Bluetooth: Fix mgmt handling of power on failures
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1369810289-5090-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 30 May 2013 10:55:56 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6D7361BA-24A0-49D5-AA04-C04C7E1101A1@holtmann.org>
References: <1369724867-31011-1-git-send-email-johan.hedberg@gmail.com> <1369810289-5090-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If hci_dev_open fails we need to ensure that the corresponding
> mgmt_set_powered command gets an appropriate response. This patch fixes
> the missing response by adding a new mgmt_set_powered_failed function
> that's used to indicate a power on failure to mgmt. Since a situation

might want to fix this typo.

> with the device being rfkilled may require special handling in user
> space the patch uses a new dedicated mgmt status code for this.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Cc: stable@vger.kernel.org
> ---
> v2: Added dedicated mgmt error for the ERFKILL case
> 
> include/net/bluetooth/hci_core.h |    1 +
> include/net/bluetooth/mgmt.h     |    1 +
> net/bluetooth/hci_core.c         |    6 +++++-
> net/bluetooth/mgmt.c             |   21 +++++++++++++++++++++
> 4 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 606615c..f77885e 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1118,6 +1118,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
> int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
> int mgmt_index_added(struct hci_dev *hdev);
> int mgmt_index_removed(struct hci_dev *hdev);
> +int mgmt_set_powered_failed(struct hci_dev *hdev, int err);
> int mgmt_powered(struct hci_dev *hdev, u8 powered);
> int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
> int mgmt_connectable(struct hci_dev *hdev, u8 connectable);
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 22980a7..9944c3e 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -42,6 +42,7 @@
> #define MGMT_STATUS_NOT_POWERED		0x0f
> #define MGMT_STATUS_CANCELLED		0x10
> #define MGMT_STATUS_INVALID_INDEX	0x11
> +#define MGMT_STATUS_RFKILLED		0x12
> 
> struct mgmt_hdr {
> 	__le16	opcode;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 21ad85d..d7c2dbd 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1598,11 +1598,15 @@ static const struct rfkill_ops hci_rfkill_ops = {
> static void hci_power_on(struct work_struct *work)
> {
> 	struct hci_dev *hdev = container_of(work, struct hci_dev, power_on);
> +	int err;
> 
> 	BT_DBG("%s", hdev->name);
> 
> -	if (hci_dev_open(hdev->id) < 0)
> +	err = hci_dev_open(hdev->id);
> +	if (err < 0) {
> +		mgmt_set_powered_failed(hdev, err);
> 		return;
> +	}
> 
> 	if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
> 		queue_delayed_work(hdev->req_workqueue, &hdev->power_off,
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 5cd3aee..fedc539 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3533,6 +3533,27 @@ new_settings:
> 	return err;
> }
> 
> +int mgmt_set_powered_failed(struct hci_dev *hdev, int err)
> +{
> +	struct pending_cmd *cmd;
> +	u8 status;
> +
> +	cmd = mgmt_pending_find(MGMT_OP_SET_POWERED, hdev);
> +	if (!cmd)
> +		return -ENOENT;
> +
> +	if (err == -ERFKILL)
> +		status = MGMT_STATUS_RFKILLED;
> +	else
> +		status = MGMT_STATUS_FAILED;
> +
> +	err = cmd_status(cmd->sk, hdev->id, MGMT_OP_SET_POWERED, status);
> +
> +	mgmt_pending_remove(cmd);
> +
> +	return err;
> +}
> +
> int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
> {
> 	struct cmd_lookup match = { NULL, hdev };

We do not need to do this in this patch, but I think we need to get rid of all the return values for the status notification functions. Since we never use them, it is pointless to keep them around. Or are we doing anything useful with them.

Anyhow, this patch is fine with me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

