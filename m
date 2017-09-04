Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] Bluetooth: btqcomsmd: BD address setup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1504509480-14082-1-git-send-email-loic.poulain@linaro.org>
Date: Mon, 4 Sep 2017 09:39:53 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org
Message-Id: <B03B0FB0-08E0-4031-9E3D-FE2B7BBAF373@holtmann.org>
References: <1504509480-14082-1-git-send-email-loic.poulain@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>,
        Rob Herring <robh@kernel.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Bluetooth BD address can be retrieved in the same way as
> for wcnss-wlan MAC address. This patch mainly stores the
> local-mac-address property and sets the BD address during
> hci device setup.
> 
> If the default BD address is detected, mark the device as
> unconfigured.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
> drivers/bluetooth/btqcomsmd.c | 63 +++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 63 insertions(+)
> 
> v2: Set device as unconfigured if default address detected
>     Add warning if BD addr retrieved from DT
> 
> diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
> index d00c4fd..e07df69 100644
> --- a/drivers/bluetooth/btqcomsmd.c
> +++ b/drivers/bluetooth/btqcomsmd.c
> @@ -15,6 +15,8 @@
> #include <linux/module.h>
> #include <linux/slab.h>
> #include <linux/rpmsg.h>
> +#include <linux/of.h>
> +
> #include <linux/soc/qcom/wcnss_ctrl.h>
> #include <linux/platform_device.h>
> 
> @@ -23,9 +25,12 @@
> 
> #include "btqca.h"
> 
> +#define BDADDR_QCOMSMD (&(bdaddr_t) {{0xAD, 0x5A, 0x00, 0x00, 0x00, 0x00}})
> +
> struct btqcomsmd {
> 	struct hci_dev *hdev;
> 
> +	const bdaddr_t *addr;

so lets use bdaddr here. And frankly I would really just use bdaddr_t bdaddr here. You have to swap the address anyway since we use local-mac-address.

Unless of course we start using local-bd-address as DT property. Remember that even a WiFi address must be different from a Bluetooth address. You can not use the same. So the boot loader needs to understand that this is the Bluetooth address and not the WiFi address.

> 	struct rpmsg_endpoint *acl_channel;
> 	struct rpmsg_endpoint *cmd_channel;
> };
> @@ -100,6 +105,58 @@ static int btqcomsmd_close(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +static int btqcomsmd_setup(struct hci_dev *hdev)
> +{
> +	struct btqcomsmd *btq = hci_get_drvdata(hdev);
> +	struct hci_rp_read_bd_addr *bda;
> +	struct sk_buff *skb;
> +
> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +	kfree_skb(skb);
> +
> +	if (btq->addr) {
> +		bdaddr_t bdaddr;
> +
> +		/* Having a unique BD address is critical, the retrieved address
> +		 * coming from the local-mac-address device-tree property must
> +		 * be provisioned with a valid per-device address.
> +		 * Usually, this address is added to the DT by the bootloader
> +		 * which has access to the provisioned data.
> +		 */
> +		bt_dev_warn(hdev, "BD address %pM coming from device-tree might"
> +			    " be invalid or non-unique", btq->addr);

I would bt_dev_info this first of all. And then just use “Configuring address %pM from device tree”.

If the user did everything right, they don’t want to be reminded about they might did it wrong. If it is configured, then just use it. The only thing that I want is an entry in dmesg that this happened and what address was retrieved from DT.

> +
> +		/* btq->addr stored with most significant byte first */
> +		baswap(&bdaddr, btq->addr);
> +		qca_set_bdaddr_rome(hdev, &bdaddr);
> +	}
> +
> +	skb = __hci_cmd_sync(hdev, HCI_OP_READ_BD_ADDR, 0, NULL,
> +			     HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +
> +	if (skb->len != sizeof(*bda)) {
> +		bt_dev_err(hdev, "Device address length mismatch");
> +		kfree_skb(skb);
> +		return -EIO;
> +	}
> +
> +	/* Mark the controller with invalid BD address flag if the
> +	 * returned address is the default one (00:00:00:00:5A:AD).
> +	 */
> +	bda = (struct hci_rp_read_bd_addr *)skb->data;
> +	if (!bacmp(&bda->bdaddr, BDADDR_QCOMSMD)) {
> +		bt_dev_err(hdev, "Found invalid qcomsmd default address %pMR",
> +			   BDADDR_QCOMSMD);
> +		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> +	}

Skip this whole charade. If the local-mac-address is not provided in DT, then just set HCI_QUIRK_INVALID_BDADDR. As far as I understand it, SMD devices never have a persistent storage for the address.

> +
> +	return 0;
> +}
> +
> static int btqcomsmd_probe(struct platform_device *pdev)
> {
> 	struct btqcomsmd *btq;
> @@ -123,6 +180,11 @@ static int btqcomsmd_probe(struct platform_device *pdev)
> 	if (IS_ERR(btq->cmd_channel))
> 		return PTR_ERR(btq->cmd_channel);
> 
> +	btq->addr = of_get_property(pdev->dev.of_node, "local-mac-address",
> +				    &ret);
> +	if (ret != sizeof(bdaddr_t))
> +		btq->addr = NULL;
> +

I would swap it right here into the proper format, and then use a bacmp BDADDR_ANY comparison above to check if an address was provided.

> 	hdev = hci_alloc_dev();
> 	if (!hdev)
> 		return -ENOMEM;
> @@ -135,6 +197,7 @@ static int btqcomsmd_probe(struct platform_device *pdev)
> 	hdev->open = btqcomsmd_open;
> 	hdev->close = btqcomsmd_close;
> 	hdev->send = btqcomsmd_send;
> +	hdev->setup = btqcomsmd_setup;
> 	hdev->set_bdaddr = qca_set_bdaddr_rome;
> 
> 	ret = hci_register_dev(hdev);

What I am missing is an entry in Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt. And that one should include all the warnings around the uniqueness of the BD Address. Also of course if we keep using local-mac-address as name, then it reverse nature. Preferable with an example of aa:bb:.. notation vs the [ ] binary in DT.

Frankly, I would also introduce local-bd-address since while they might come from the same IEEE allocation space, they are a bit different in nature of it byte ordering and notation.

Regards

Marcel

