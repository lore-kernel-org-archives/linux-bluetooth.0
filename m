Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] Bluetooth: btqcomsmd: BD address setup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1504521784-9766-1-git-send-email-loic.poulain@linaro.org>
Date: Mon, 4 Sep 2017 13:28:11 +0200
Cc: linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org
Message-Id: <6989AC8D-D666-402E-A99E-930C0B007A9F@holtmann.org>
References: <1504521784-9766-1-git-send-email-loic.poulain@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Bluetooth BD address can be retrieved in the same way as
> for wcnss-wlan MAC address. This patch mainly stores the
> local-mac-address property and sets the BD address during
> hci device setup. If there is no such property, mark the
> device as unconfigured.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
> drivers/bluetooth/btqcomsmd.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 42 insertions(+)
> 
> v2: Set device as unconfigured if default address detected
>     Add warning if BD addr retrieved from DT
> v3: if no addr retrieved from DT, unconditionally set
>     the invalid BD addr flag.
>     swap and set bdaddr in the platform probe
> 
> diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
> index ef730c173d4b..37406a6aa1b5 100644
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
> @@ -26,6 +28,7 @@
> struct btqcomsmd {
> 	struct hci_dev *hdev;
> 
> +	bdaddr_t bdaddr;
> 	struct rpmsg_endpoint *acl_channel;
> 	struct rpmsg_endpoint *cmd_channel;
> };
> @@ -100,8 +103,35 @@ static int btqcomsmd_close(struct hci_dev *hdev)
> 	return 0;
> }
> 
> +static int btqcomsmd_setup(struct hci_dev *hdev)
> +{
> +	struct btqcomsmd *btq = hci_get_drvdata(hdev);
> +	struct sk_buff *skb;
> +
> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> +	if (IS_ERR(skb))
> +		return PTR_ERR(skb);
> +	kfree_skb(skb);
> +
> +	/* Device does not have persistent storage for BD address.
> +	 * Mark the device with invalid BD addr flag if no address
> +	 * retrieved from DT.
> +	 */
> +	if (!bacmp(&btq->bdaddr, BDADDR_ANY)) {
> +		bt_dev_err(hdev, "No BD address configured”);

remove that bt_dev_err. It is not an error and this one is clearly marked in mgmt API. So no need to print anything. This would be actually the normal operation.

> +		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> +		return 0;
> +	}
> +
> +	bt_dev_info(hdev, "BD address %pMR retrieved from device-tree",
> +		    &btq->bdaddr);

Actually you might want to move this bt_dev_info to the actual retrieval of the value.

> +
> +	return qca_set_bdaddr_rome(hdev, &btq->bdaddr);
> +}
> +
> static int btqcomsmd_probe(struct platform_device *pdev)
> {
> +	const bdaddr_t *local_addr;
> 	struct btqcomsmd *btq;
> 	struct hci_dev *hdev;
> 	void *wcnss;
> @@ -123,6 +153,17 @@ static int btqcomsmd_probe(struct platform_device *pdev)
> 	if (IS_ERR(btq->cmd_channel))
> 		return PTR_ERR(btq->cmd_channel);
> 
> +	/* Having a unique BD address is critical.
> +	 * Usually, the local-mac-address property is injected by
> +	 * the bootloader which has access to the provisioned data.
> +	 */
> +	local_addr = of_get_property(pdev->dev.of_node, "local-mac-address",
> +				    &ret);
> +	if (local_addr && ret == sizeof(bdaddr_t)) {
> +		/* local-mac-address stored with most significant byte first */
> +		baswap(&btq->bdaddr, local_addr);

So lets print the "BD address %pMR retrieved from device-tree” here.

Since I want to have a discussion about the naming, lets split this patch into two. Leave this hunk for the second patch. Then I can apply the first one and we can argue about the naming.

Also please don’t forget Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt file. We need to document things.

> +	}
> +
> 	hdev = hci_alloc_dev();
> 	if (!hdev)
> 		return -ENOMEM;
> @@ -135,6 +176,7 @@ static int btqcomsmd_probe(struct platform_device *pdev)
> 	hdev->open = btqcomsmd_open;
> 	hdev->close = btqcomsmd_close;
> 	hdev->send = btqcomsmd_send;
> +	hdev->setup = btqcomsmd_setup;
> 	hdev->set_bdaddr = qca_set_bdaddr_rome;
> 
> 	ret = hci_register_dev(hdev);

Regards

Marcel

