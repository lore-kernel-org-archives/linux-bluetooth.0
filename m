Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v7 4/6] Bluetooth: btbcm: Add helper functions for UART setup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1432805106-25719-5-git-send-email-frederic.danis@linux.intel.com>
Date: Sat, 6 Jun 2015 07:41:48 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0B0AF92F-2965-4BA3-8509-92D5348CCD78@holtmann.org>
References: <1432805106-25719-1-git-send-email-frederic.danis@linux.intel.com> <1432805106-25719-5-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Firmware loading may reset the controller UART speed and needs to set
> host UART speed back to init speed.
> 
> UART drivers setup is split in 3 parts:
> - btbcm_initialize() resets the controller and returns the firmware
>  name based on controller revision and sub_version.
> - btbtcm_patchram() (already existing and public), which takes the
>  firmware name as parameter, requests the firmware and loads it to
>  the controller.
> - btbcm_finalize() which resets the controller, reads local version
>  and checks if the controller address is a default one or not.
> 
> Remove firmware name retrieval for UART controllers from
> btbcm_setup_patchram().
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/btbcm.c | 101 ++++++++++++++++++++++++++++++++++++++++------
> drivers/bluetooth/btbcm.h |  14 +++++++
> 2 files changed, 103 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index e90e6b8..d16878e 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -239,6 +239,95 @@ static const struct {
> 	{ }
> };
> 
> +int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len)
> +{
> +	u16 subver, rev;
> +	const char *hw_name = NULL;
> +	struct sk_buff *skb;
> +	struct hci_rp_read_local_version *ver;
> +	int i, err;
> +
> +	/* Reset */
> +	err = btbcm_reset(hdev);
> +	if (err)
> +		return err;
> +
> +	/* Read Local Version Info */
> +	skb = btbcm_read_local_version(hdev);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +
> +	ver = (struct hci_rp_read_local_version *)skb->data;
> +	rev = le16_to_cpu(ver->hci_rev);
> +	subver = le16_to_cpu(ver->lmp_subver);
> +	kfree_skb(skb);
> +
> +	/* Read Verbose Config Version Info */
> +	skb = btbcm_read_verbose_config(hdev);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +
> +	BT_INFO("%s: BCM: chip id %u", hdev->name, skb->data[1]);
> +	kfree_skb(skb);
> +
> +	switch ((rev & 0xf000) >> 12) {
> +	case 0:
> +	case 3:
> +		for (i = 0; bcm_uart_subver_table[i].name; i++) {
> +			if (subver == bcm_uart_subver_table[i].subver) {
> +				hw_name = bcm_uart_subver_table[i].name;
> +				break;
> +			}
> +		}
> +
> +		snprintf(fw_name, len, "brcm/%s.hcd", hw_name ? : "BCM");
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
> +		hw_name ? : "BCM", (subver & 0x7000) >> 13,
> +		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btbcm_initialize);
> +
> +int btbcm_finalize(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +	struct hci_rp_read_local_version *ver;
> +	u16 subver, rev;
> +	int err;
> +
> +	/* Reset */
> +	err = btbcm_reset(hdev);
> +	if (err)
> +		return err;
> +
> +	/* Read Local Version Info */
> +	skb = btbcm_read_local_version(hdev);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +
> +	ver = (struct hci_rp_read_local_version *)skb->data;
> +	rev = le16_to_cpu(ver->hci_rev);
> +	subver = le16_to_cpu(ver->lmp_subver);
> +	kfree_skb(skb);
> +
> +	BT_INFO("%s: BCM (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
> +		(subver & 0x7000) >> 13, (subver & 0x1f00) >> 8,
> +		(subver & 0x00ff), rev & 0x0fff);
> +
> +	btbcm_check_bdaddr(hdev);
> +
> +	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btbcm_finalize);
> +
> static const struct {
> 	u16 subver;
> 	const char *name;
> @@ -290,18 +379,6 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
> 	kfree_skb(skb);
> 
> 	switch ((rev & 0xf000) >> 12) {
> -	case 0:
> -	case 3:
> -		for (i = 0; bcm_uart_subver_table[i].name; i++) {
> -			if (subver == bcm_uart_subver_table[i].subver) {
> -				hw_name = bcm_uart_subver_table[i].name;
> -				break;
> -			}
> -		}
> -
> -		snprintf(fw_name, sizeof(fw_name), "brcm/%s.hcd",
> -			 hw_name ? : "BCM");
> -		break;

I took this hunk out since I am pretty sure I found an USB dongle that has this gotten wrong. Long term we will move over to a manifest file that will list modalias and firmware name. That way this becomes a detail of the linux-firmware tree and no longer a driver problem.

Regards

Marcel


