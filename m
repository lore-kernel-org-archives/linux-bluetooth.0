Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v2 4/5] Bluetooth: btbcm: Split setup() function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1431008699-6419-4-git-send-email-frederic.danis@linux.intel.com>
Date: Thu, 7 May 2015 17:22:13 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6F8C6327-C7F0-4081-B3A8-8A3A609C915E@holtmann.org>
References: <1431008699-6419-1-git-send-email-frederic.danis@linux.intel.com> <1431008699-6419-4-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Split btbcm_setup_patchram in 3 functions : btbcm_setup_patchram,
> btbcm_patchram (already existing) and btbcm_setup_post.
> For UART controllers this will allow to reset speed to default one
> after firmware loading, which will have reseted controller speed to
> default one.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/btbcm.c   | 29 +++++++++++++++++------------
> drivers/bluetooth/btbcm.h   | 11 +++++++++--
> drivers/bluetooth/btusb.c   | 23 ++++++++++++++++++++++-
> drivers/bluetooth/hci_bcm.c | 19 ++++++++++++++++++-
> 4 files changed, 66 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index b258454..f2efbbd 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -277,9 +277,8 @@ static const struct {
> 	{ }
> };
> 
> -int btbcm_setup_patchram(struct hci_dev *hdev)
> +int btbcm_setup_patchram(struct hci_dev *hdev, char *fw_name, size_t len)

what is this len for? The fw_name is not a return value. I think the functions for doing the patchram should just get a firmware and then just do patchram.

> {
> -	char fw_name[64];
> 	u16 subver, rev, pid, vid;
> 	const char *hw_name = NULL;
> 	struct sk_buff *skb;
> @@ -319,8 +318,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
> 			}
> 		}
> 
> -		snprintf(fw_name, sizeof(fw_name), "brcm/%s.hcd",
> -			 hw_name ? : "BCM");
> +		snprintf(fw_name, len, "brcm/%s.hcd", hw_name ? : "BCM");
> 		break;
> 	case 1:
> 	case 2:
> @@ -340,7 +338,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
> 			}
> 		}
> 
> -		snprintf(fw_name, sizeof(fw_name), "brcm/%s-%4.4x-%4.4x.hcd",
> +		snprintf(fw_name, len, "brcm/%s-%4.4x-%4.4x.hcd",
> 			 hw_name ? : "BCM", vid, pid);
> 		break;
> 	default:
> @@ -351,9 +349,16 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
> 		hw_name ? : "BCM", (subver & 0x7000) >> 13,
> 		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
> 
> -	err = btbcm_patchram(hdev, fw_name);
> -	if (err == -ENOENT)
> -		return 0;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btbcm_setup_patchram);
> +
> +int btbcm_setup_post(struct hci_dev *hdev)
> +{
> +	struct sk_buff *skb;
> +	struct hci_rp_read_local_version *ver;
> +	u16 subver, rev;
> +	int err;
> 
> 	/* Reset */
> 	err = btbcm_reset(hdev);
> @@ -370,9 +375,9 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
> 	subver = le16_to_cpu(ver->lmp_subver);
> 	kfree_skb(skb);
> 
> -	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
> -		hw_name ? : "BCM", (subver & 0x7000) >> 13,
> -		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
> +	BT_INFO("%s: BCM (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
> +		(subver & 0x7000) >> 13, (subver & 0x1f00) >> 8,
> +		(subver & 0x00ff), rev & 0x0fff);
> 
> 	btbcm_check_bdaddr(hdev);
> 
> @@ -380,7 +385,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
> 
> 	return 0;
> }
> -EXPORT_SYMBOL_GPL(btbcm_setup_patchram);
> +EXPORT_SYMBOL_GPL(btbcm_setup_post);
> 
> int btbcm_setup_apple(struct hci_dev *hdev)
> {
> diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
> index eb6ab5f..73d92a2 100644
> --- a/drivers/bluetooth/btbcm.h
> +++ b/drivers/bluetooth/btbcm.h
> @@ -27,7 +27,8 @@ int btbcm_check_bdaddr(struct hci_dev *hdev);
> int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
> int btbcm_patchram(struct hci_dev *hdev, const char *firmware);
> 
> -int btbcm_setup_patchram(struct hci_dev *hdev);
> +int btbcm_setup_patchram(struct hci_dev *hdev, char *fw_name, size_t len);
> +int btbcm_setup_post(struct hci_dev *hdev);
> int btbcm_setup_apple(struct hci_dev *hdev);
> 
> #else
> @@ -47,7 +48,13 @@ static inline int btbcm_patchram(struct hci_dev *hdev, const char *firmware)
> 	return -EOPNOTSUPP;
> }
> 
> -static inline int btbcm_setup_patchram(struct hci_dev *hdev)
> +static inline int btbcm_setup_patchram(struct hci_dev *hdev, char *fw_name,
> +								size_t len)
> +{
> +	return 0;
> +}
> +
> +static int btbcm_setup_post(struct hci_dev *hdev)
> {
> 	return 0;
> }
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 77c1f8c..15225d9 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1333,6 +1333,27 @@ static int btusb_setup_bcm92035(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +#ifdef CONFIG_BT_HCIBTUSB_BCM
> +static int btusb_setup_bcm(struct hci_dev *hdev)
> +{
> +	char fw_name[64];
> +	int err;
> +
> +	err = btbcm_setup_patchram(hdev, fw_name, sizeof(fw_name));
> +	if (err)
> +		return err;
> +
> +	err = btbcm_patchram(hdev, fw_name);
> +	/* If there is no firmware (-ENOENT), discard the error and continue */
> +	if (err == -ENOENT)
> +		return 0;
> +
> +	err = btbcm_setup_post(hdev);
> +
> +	return err;
> +}
> +#endif
> +
> static int btusb_setup_csr(struct hci_dev *hdev)
> {
> 	struct hci_rp_read_local_version *rp;
> @@ -3132,7 +3153,7 @@ static int btusb_probe(struct usb_interface *intf,
> 
> #ifdef CONFIG_BT_HCIBTUSB_BCM
> 	if (id->driver_info & BTUSB_BCM_PATCHRAM) {
> -		hdev->setup = btbcm_setup_patchram;
> +		hdev->setup = btusb_setup_bcm;
> 		hdev->set_bdaddr = btbcm_set_bdaddr;
> 	}
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 1ec0b4a..0e77b9a 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -79,11 +79,28 @@ static int bcm_flush(struct hci_uart *hu)
> 
> static int bcm_setup(struct hci_uart *hu)
> {
> +	char fw_name[64];
> +	int err;
> +
> 	BT_DBG("hu %p", hu);
> 
> 	hu->hdev->set_bdaddr = btbcm_set_bdaddr;
> 
> -	return btbcm_setup_patchram(hu->hdev);
> +	err = btbcm_setup_patchram(hu->hdev, fw_name, sizeof(fw_name));
> +	if (err)
> +		return err;
> +
> +	err = btbcm_patchram(hu->hdev, fw_name);
> +	/* If there is no firmware (-ENOENT), discard the error and continue */
> +	if (err == -ENOENT)
> +		return 0;
> +
> +	if (hu->proto->default_speed)
> +		hci_uart_set_baudrate(hu, hu->proto->default_speed);
> +
> +	err = btbcm_setup_post(hu->hdev);
> +
> +	return err;
> }
> 
> static const struct h4_recv_pkt bcm_recv_pkts[] = {

Regards

Marcel

