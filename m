Return-Path: <mka@chromium.org>
Date: Mon, 23 Jul 2018 15:32:36 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
	rtatiya@codeaurora.org, hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v10 1/7] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
Message-ID: <20180723223236.GN129942@google.com>
References: <20180720133243.6851-1-bgodavar@codeaurora.org>
 <20180720133243.6851-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180720133243.6851-2-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jul 20, 2018 at 07:02:37PM +0530, Balakrishna Godavarthi wrote:
> This patch enables regulators for the Qualcomm Bluetooth wcn3990
> controller.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v10:
>     * added entry for regulator currents
> 
> Changes in v9:
>     * updated with latest reg handle and names.
>     * updated max-speed definition. 
> 
> Changes in v8:
>     * Separated the optional entries between two chips
> 
> Changes in v7:
>     * no change.
> 
> Changes in v6:
> 
>     * Changed the oper-speed to max-speed.
> 
> Changes in v5:
> 
>     * Added entry for oper-speed and init-speed.
> 
> ---
>  .../bindings/net/qualcomm-bluetooth.txt       | 42 ++++++++++++++++++-
>  1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 0ea18a53cc29..ca04c4981048 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -10,12 +10,34 @@ device the slave device is attached to.
>  Required properties:
>   - compatible: should contain one of the following:
>     * "qcom,qca6174-bt"
> +   * "qcom,wcn3990-bt"
> +
> +Optional properties for compatible string qcom,qca6174-bt:
>  
> -Optional properties:
>   - enable-gpios: gpio specifier used to enable chip
>   - clocks: clock provided to the controller (SUSCLK_32KHZ)
>  
> -Example:
> +Optional properties for compatible string qcom,wcn3990-bt:
> +
> + - vddio-supply: Bluetooth wcn3990 VDD_IO supply regulator handle.
> + - vddxo-supply: Bluetooth wcn3990 VDD_XO supply regulator handle.
> + - vddrf-supply: Bluetooth wcn3990 VDD_RF supply regulator handle.
> + - vddch0-supply: Bluetooth wcn3990 VDD_CH0 supply regulator handle.
> +
> + - If WCN3990 is connected to platform where RPMH PMIC processor is used
> +   then the load values will be 1uA. if it is connected to platform where RPM
> +   PMIC processor is used then load value will be 10000 uA.
> +   if it is connected to different platform, where current values are fixed
> +   as in data sheet then below property are not required.

Please provide details why these magic values are needed for RPMh and
RPM PMICs.

For RPMh it looks like a value of 1uA would cause the regulator to
enter idle mode:

static int rpmh_regulator_vrm_set_load(struct regulator_dev *rdev, int load_uA)
{
	struct rpmh_vreg *vreg = rdev_get_drvdata(rdev);
	unsigned int mode;

	if (load_uA >= vreg->hw_data->hpm_min_load_uA)
		mode = REGULATOR_MODE_NORMAL;
	else
		mode = REGULATOR_MODE_IDLE;

	return rpmh_regulator_vrm_set_mode(rdev, mode);
}

https://patchwork.kernel.org/patch/10524299/

Is that really intended and if so why? It might make sense to save
power when really in idle mode, but I assume you somehow have to tell
the regulator to switch to normal mode when BT is used.

I also commented about this on patch "[7/7] Bluetooth: hci_qca: Add
support for Qualcomm Bluetooth chip wcn3990". I suggest to center the
discussion here and reply with a link to the other patch.
