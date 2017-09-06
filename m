Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v6 3/3] Bluetooth: btqcomsmd: retrieve BD address from DT
 property
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1504699898-28011-3-git-send-email-loic.poulain@linaro.org>
Date: Wed, 6 Sep 2017 19:24:37 +0200
Cc: Rob Herring <robh+dt@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        bjorn.andersson@linaro.org
Message-Id: <AD664D12-31A5-456B-9971-4A76BDC32BA3@holtmann.org>
References: <1504699898-28011-1-git-send-email-loic.poulain@linaro.org>
 <1504699898-28011-3-git-send-email-loic.poulain@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Retrieve BD address from the local-bd-address property.
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
> v5: remove 2/3 merged in bluetooth-next tree
>     Add bluetooth.txt for common BT bindings
>     expect local-bd-address in little-endian format
> v6: use of_property_read_u8_array instead of of_get_property
> 
> drivers/bluetooth/btqcomsmd.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
> index bd810d0..b5716f0 100644
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
> @@ -156,6 +158,15 @@ static int btqcomsmd_probe(struct platform_device *pdev)
> 	if (IS_ERR(btq->cmd_channel))
> 		return PTR_ERR(btq->cmd_channel);
> 
> +	/* The local-bd-address property is usually injected by the
> +	 * bootloader which has access to the allocated BD address.
> +	 */
> +	if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
> +				       (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
> +		BT_INFO("BD address %pMR retrieved from device-tree",
> +			&btq->bdaddr);
> +	}

any reason you are not using bt_dev_info here? I think it would be important to print the device information prefix.

Otherwise the patch set looks good to me. However I would prefer if we get an ack from Rob.

Regards

Marcel

