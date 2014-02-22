Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 06/15] Bluetooth: Add skeleton for Set Privacy command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393088805-28658-7-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 22 Feb 2014 09:56:38 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <8689B3F8-FF88-49BF-A55F-2C04EA6748E3@holtmann.org>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com> <1393088805-28658-7-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds the basic skeleton for handing the Set Privacy mgmt
> command, including copying the value to hdev->irk and toggling the
> HCI_PRIVACY flag. The patch does not yet add any kind of RPA generation
> and HCI command sending.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 42 +++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 41 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 301b18a1c6a0..145254f84975 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -81,6 +81,7 @@ static const u16 mgmt_commands[] = {
> 	MGMT_OP_SET_SCAN_PARAMS,
> 	MGMT_OP_SET_SECURE_CONN,
> 	MGMT_OP_SET_DEBUG_KEYS,
> +	MGMT_OP_SET_PRIVACY,
> 	MGMT_OP_LOAD_IRKS,
> };
> 
> @@ -4187,6 +4188,45 @@ unlock:
> 	return err;
> }
> 
> +static int set_privacy(struct sock *sk, struct hci_dev *hdev, void *cp_data,
> +		       u16 len)
> +{
> +	struct mgmt_cp_set_privacy *cp = cp_data;
> +	bool changed;
> +	int err;
> +
> +	BT_DBG("request for %s", hdev->name);
> +
> +	if (!lmp_le_capable(hdev))
> +		return cmd_status(sk, hdev->id, MGMT_OP_SET_PRIVACY,
> +				  MGMT_STATUS_NOT_SUPPORTED);
> +
> +	if (cp->privacy != 0x00 && cp->privacy != 0x01)
> +		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEBUG_KEYS,
> +				  MGMT_STATUS_INVALID_PARAMS);

copy&paste error ;)

And I think this command should only be allowed when powered off. Same as we do for setting the static address. If you change the IRK, then you screw your peers over. Something we should not even consider allowing.

If you want to change your identity, then power down and power up. For LE only devices without a public address, they have to power down to change their static address (which will be the identity for them) anyway.

Regards

Marcel

