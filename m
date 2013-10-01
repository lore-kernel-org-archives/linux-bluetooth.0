Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC 3/3] Bluetooth: Add a new mgmt_set_bredr command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380640922-18647-4-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 1 Oct 2013 18:08:37 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <3BDB2D49-6C05-4929-9435-97BE02C55342@holtmann.org>
References: <1380640922-18647-1-git-send-email-johan.hedberg@gmail.com> <1380640922-18647-4-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch introduces a new mgmt command for enabling/disabling BR/EDR
> functionality. This can be convenient when one wants to make a dual-mode
> controller behave like a single-mode one. The command is only available
> for dual-mode controllers and requires that LE is enabled before using
> it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/mgmt.h |   2 +
> net/bluetooth/mgmt.c         | 122 +++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 124 insertions(+)
> 
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 421d763..7347df8 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -354,6 +354,8 @@ struct mgmt_cp_set_device_id {
> 
> #define MGMT_OP_SET_ADVERTISING		0x0029
> 
> +#define MGMT_OP_SET_BREDR		0x002A
> +
> #define MGMT_EV_CMD_COMPLETE		0x0001
> struct mgmt_ev_cmd_complete {
> 	__le16	opcode;
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index eea0b97..6405406 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -75,6 +75,7 @@ static const u16 mgmt_commands[] = {
> 	MGMT_OP_UNBLOCK_DEVICE,
> 	MGMT_OP_SET_DEVICE_ID,
> 	MGMT_OP_SET_ADVERTISING,
> +	MGMT_OP_SET_BREDR,
> };
> 
> static const u16 mgmt_events[] = {
> @@ -3259,6 +3260,126 @@ unlock:
> 	return err;
> }
> 
> +static void set_no_scan(struct hci_request *req)
> +{
> +	struct hci_dev *hdev = req->hdev;
> +	u8 scan = 0x00;
> +
> +	if (!test_bit(HCI_ISCAN, &hdev->flags) &&
> +	    !test_bit(HCI_PSCAN, &hdev->flags))
> +		return;

this one needs a comment on why we do it this way. I had to read it twice to get it.

> +
> +	hci_req_add(req, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
> +}
> +
> +static void set_bredr_complete(struct hci_dev *hdev, u8 status)
> +{
> +	struct pending_cmd *cmd;
> +
> +	BT_DBG("status 0x%02x", status);
> +
> +	hci_dev_lock(hdev);
> +
> +	cmd = mgmt_pending_find(MGMT_OP_SET_BREDR, hdev);
> +	if (!cmd)
> +		goto unlock;
> +
> +	if (status) {
> +		u8 mgmt_err = mgmt_status(status);
> +
> +		/* We need to restore the flag if related HCI commands
> +		 * failed.
> +		 */
> +		change_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
> +
> +		cmd_status(cmd->sk, cmd->index, cmd->opcode, mgmt_err);
> +	} else {
> +		send_settings_rsp(cmd->sk, MGMT_OP_SET_BREDR, hdev);
> +	}

Who is sending the new settings event when this succeeds?

> +
> +	mgmt_pending_remove(cmd);
> +
> +unlock:
> +	hci_dev_unlock(hdev);
> +}
> +
> +static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
> +{
> +	struct mgmt_mode *cp = data;
> +	struct pending_cmd *cmd;
> +	struct hci_request req;
> +	u8 val, enabled;
> +	int err;
> +
> +	BT_DBG("request for %s", hdev->name);
> +
> +	if (!lmp_bredr_capable(hdev) || !lmp_le_capable(hdev))
> +		return cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
> +				  MGMT_STATUS_REJECTED);
> +
> +	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
> +		return cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
> +				  MGMT_STATUS_REJECTED);
> +
> +	if (cp->val != 0x00 && cp->val != 0x01)
> +		return cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
> +				  MGMT_STATUS_INVALID_PARAMS);

As already pointed out, copy & paste mistake here.

In addition we might either want to reject this command when HCI_HS_ENABLED or maybe even better also disable HS at the same time. I prefer just disabling HS since we do a similar thing with discoverable when turning off connectable.

The same applies to connectable and advertising and fast connectable. I think these settings need to be cleared as well. Essentially all settings that require BR/EDR need to be cleared.

> +
> +	hci_dev_lock(hdev);
> +
> +	val = !!cp->val;
> +	enabled = test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
> +
> +	if (!hdev_is_powered(hdev) || val == enabled) {
> +		bool changed = false;
> +
> +		if (val != test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
> +			change_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
> +			changed = true;
> +		}
> +
> +		err = send_settings_rsp(sk, MGMT_OP_SET_BREDR, hdev);
> +		if (err < 0)
> +			goto unlock;
> +
> +		if (changed)
> +			err = new_settings(hdev, sk);
> +
> +		goto unlock;
> +	}

I keep seeing this snippet over and over again. And actually the check if changed is done twice here. First we check if val == enabled and then we check it again and set changed = true. This looks a bit redundant.

What we should do is run the check for if the value actually changed and if not, just send the response and exit. And only then do the check for the case when the controller is not powered.

> +
> +	if (mgmt_pending_find(MGMT_OP_SET_BREDR, hdev)) {
> +		err = cmd_status(sk, hdev->id, MGMT_OP_SET_BREDR,
> +				 MGMT_STATUS_BUSY);
> +		goto unlock;
> +	}
> +
> +	cmd = mgmt_pending_add(sk, MGMT_OP_SET_BREDR, hdev, data, len);
> +	if (!cmd) {
> +		err = -ENOMEM;
> +		goto unlock;
> +	}
> +
> +	change_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
> +
> +	hci_req_init(&req, hdev);
> +
> +	if (val)
> +		set_bredr_scan(&req);
> +	else
> +		set_no_scan(&req);
> +
> +	hci_update_ad(&req);
> +
> +	err = hci_req_run(&req, set_bredr_complete);
> +	if (err < 0)
> +		mgmt_pending_remove(cmd);
> +
> +unlock:
> +	hci_dev_unlock(hdev);
> +	return err;
> +}
> +
> static void fast_connectable_complete(struct hci_dev *hdev, u8 status)
> {
> 	struct pending_cmd *cmd;

On a total unrelated note, why is the fast connectable code at the bottom. I think that should be rearranged to be in the same order as the opcodes.

> @@ -3472,6 +3593,7 @@ static const struct mgmt_handler {
> 	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
> 	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
> 	{ set_advertising,        false, MGMT_SETTING_SIZE },
> +	{ set_bredr,              false, MGMT_SETTING_SIZE },
> };

Regards

Marcel

