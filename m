Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4 3/3] Bluetooth: btqcomsmd: retieve BD address from DT
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1504607164-12645-3-git-send-email-loic.poulain@linaro.org>
Date: Tue, 5 Sep 2017 14:13:20 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>, robh+dt@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, bjorn.andersson@linaro.org
Message-Id: <2C437D3D-FD64-456D-91D3-322220740A90@holtmann.org>
References: <1504607164-12645-1-git-send-email-loic.poulain@linaro.org>
 <1504607164-12645-3-git-send-email-loic.poulain@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Retrieve BD address from the DT local-bd-address property.
> This address must be unique and is usually added in the DT
> by the bootloader which has access to the provisioned data.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
> v2: Set device as unconfigured if default address detected
>     Add warning if BD addr retrieved from DT
> v3: if no addr retrieved from DT, unconditionally set
>     the invalid BD addr flag.
>     swap and set bdaddr in the platform probe
> v4: Add dt-bindings documentation
>     split patch in two parts (setup, dt prop)
>     use local-bd-address name instead of local-mac-address
> 
> drivers/bluetooth/btqcomsmd.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
> index c70fae75c4ad..08a83cb30af6 100644
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
> @@ -126,6 +128,7 @@ static int btqcomsmd_setup(struct hci_dev *hdev)
> 
> static int btqcomsmd_probe(struct platform_device *pdev)
> {
> +	const bdaddr_t *local_bd_addr;
> 	struct btqcomsmd *btq;
> 	struct hci_dev *hdev;
> 	void *wcnss;
> @@ -147,6 +150,18 @@ static int btqcomsmd_probe(struct platform_device *pdev)
> 	if (IS_ERR(btq->cmd_channel))
> 		return PTR_ERR(btq->cmd_channel);
> 
> +	/* The local-bd-address DT property is usually injected by the
> +	 * bootloader which has access to the allocated BD address.
> +	 */
> +	local_bd_addr = of_get_property(pdev->dev.of_node, "local-mac-address",
> +					&ret);
> +	if (local_bd_addr && ret == sizeof(bdaddr_t)) {
> +		/* local-bd-address stored with most significant byte first */
> +		baswap(&btq->bdaddr, local_bd_addr);

actually my preference would be really that the address is coming from DT in the right order. We are defining what local-bd-address means. So lets do that in Bluetooth specified order and not confuse people even more.

And btw. I am fine if you just use const bdaddr_t *bdaddr here as temporary variable name.

Regards

Marcel

