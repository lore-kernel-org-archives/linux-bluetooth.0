Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 2/2] Bluetooth: hci_intel: Add Device configuration
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1441380472-30636-2-git-send-email-loic.poulain@intel.com>
Date: Fri, 4 Sep 2015 08:39:20 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C6C89658-1B5A-48C4-BA38-02FA3F5B6970@holtmann.org>
References: <1441380472-30636-1-git-send-email-loic.poulain@intel.com> <1441380472-30636-2-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Apply DDC parameters once controller is in operational mode.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index b4dc3c5..8c9c2b6 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -542,7 +542,7 @@ static int intel_setup(struct hci_uart *hu)
> 	struct list_head *p;
> 	const struct firmware *fw;
> 	const u8 *fw_ptr;
> -	char fwname[64];
> +	char fwname[64], ddcname[64];
> 	u32 frag_len;
> 	ktime_t calltime, delta, rettime;
> 	unsigned long long duration;
> @@ -725,6 +725,10 @@ static int intel_setup(struct hci_uart *hu)
> 	snprintf(fwname, sizeof(fwname), "intel/ibt-11-%u.sfi",
> 		 le16_to_cpu(params->dev_revid));
> 
> +	/* Save the DDC file name for later */
> +	snprintf(ddcname, sizeof(fwname), "intel/ibt-11-%u.ddc",
> +		 le16_to_cpu(params->dev_revid));
> +

lets not introduce ddcname. Reuse fwname as we did in btusb.c And speaking of btusb.c, please also update that one to use the new function.

> 	err = request_firmware(&fw, fwname, &hdev->dev);
> 	if (err < 0) {
> 		bt_dev_err(hdev, "Failed to load Intel firmware file (%d)",
> @@ -927,6 +931,9 @@ done:
> 	set_bit(STATE_LPM_ENABLED, &intel->flags);
> 
> no_lpm:
> +	/* Ignore ddc error, device can work without DDC parameters */

	/* Ignore errors from DDC loading, device can work without DDC parameters */

> +	btintel_ddc_send(hdev, ddcname);
> +
> 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_CMD_TIMEOUT);
> 	if (IS_ERR(skb))
> 		return PTR_ERR(skb);

Regards

Marcel

