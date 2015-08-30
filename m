Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 2/2] Bluetooth: hci_intel: Introduce LPM support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1440848299-856-2-git-send-email-loic.poulain@intel.com>
Date: Sun, 30 Aug 2015 14:01:21 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <063D367A-BFBA-4440-9157-19CCD1CD53B5@holtmann.org>
References: <1440848299-856-1-git-send-email-loic.poulain@intel.com> <1440848299-856-2-git-send-email-loic.poulain@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Enable controller Low-Power-Mode if we have a pdev to manage host
> wake-up. Once LPM is enabled, controller notifies its TX status via
> a vendor specific packet (tx_idle/tx_active).
> tx_active means that there is more data upcoming from controller.
> tx_idle means that controller can be put in suspended state.
> 
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
> v2: coding style, spin_lock restructuring
> v3: rebase
> 
> drivers/bluetooth/hci_intel.c | 95 +++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 92 insertions(+), 3 deletions(-)

small tip with git format-patch -v3 and you get [PATCH v3] entry added automatically. No editing from hand needed.

> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 1ec2205..30dce61 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -44,6 +44,20 @@
> #define STATE_FIRMWARE_LOADED	2
> #define STATE_FIRMWARE_FAILED	3
> #define STATE_BOOTING		4
> +#define STATE_LPM_ENABLED	5
> +#define STATE_TX_ACTIVE		6
> +
> +#define HCI_LPM_PKT 0xf1
> +#define HCI_LPM_MAX_SIZE 10
> +#define HCI_LPM_HDR_SIZE HCI_EVENT_HDR_SIZE
> +
> +#define LPM_OP_TX_NOTIFY 0x00
> +
> +struct hci_lpm_pkt {
> +	__u8 opcode;
> +	__u8 dlen;
> +	__u8 data[0];
> +} __packed;
> 
> struct intel_device {
> 	struct list_head list;
> @@ -316,11 +330,14 @@ static int intel_setup(struct hci_uart *hu)
> {
> 	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
> 					  0x00, 0x08, 0x04, 0x00 };
> +	static const u8 lpm_param[] = { 0x03, 0x07, 0x01, 0x0b };
> 	struct intel_data *intel = hu->priv;
> +	struct intel_device *idev = NULL;
> 	struct hci_dev *hdev = hu->hdev;
> 	struct sk_buff *skb;
> 	struct intel_version *ver;
> 	struct intel_boot_params *params;
> +	struct list_head *p;
> 	const struct firmware *fw;
> 	const u8 *fw_ptr;
> 	char fwname[64];
> @@ -680,6 +697,37 @@ done:
> 
> 	BT_INFO("%s: Device booted in %llu usecs", hdev->name, duration);
> 
> +	/* Enable LPM if matching pdev with wakeup enabled */
> +	spin_lock(&intel_device_list_lock);
> +	list_for_each(p, &intel_device_list) {
> +		struct intel_device *dev = list_entry(p, struct intel_device,
> +						      list);
> +		if (hu->tty->dev->parent != dev->pdev->dev.parent)
> +			continue;
> +
> +		if (device_may_wakeup(&dev->pdev->dev))
> +			idev = dev;
> +
> +		break;
> +	}

I reworked this one to make it easier to read.

        list_for_each(p, &intel_device_list) { 
                struct intel_device *dev = list_entry(p, struct intel_device,
                                                      list);                     
                if (hu->tty->dev->parent == dev->pdev->dev.parent) {
                        if (device_may_wakeup(&dev->pdev->dev)) 
                                idev = dev;
                        break;
                }       
        }

This makes it a lot easier to digest the intention that you are looking for a matching device and then check that it may wakeup. Otherwise you have this dangling break statement and have to understand why it is actually correct.

And with that change the patch has been applied to bluetooth-next tree.

Regards

Marcel

