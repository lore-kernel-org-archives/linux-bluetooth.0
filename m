Return-Path: <mka@chromium.org>
Date: Thu, 2 Aug 2018 12:39:17 -0700
From: Matthias Kaehlcke <mka@chromium.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, thierry.escande@linaro.org,
	rtatiya@codeaurora.org, hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v13 1/7] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
Message-ID: <20180802193917.GP68975@google.com>
References: <20180802190732.4811-1-bgodavar@codeaurora.org>
 <20180802190732.4811-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20180802190732.4811-2-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Aug 03, 2018 at 12:37:26AM +0530, Balakrishna Godavarthi wrote:
> This patch enables regulators for the Qualcomm Bluetooth wcn3990
> controller.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> ---
> Changes in v13:
>  * Segregated optional and required properties for wcn3990.
> ---
>  .../bindings/net/qualcomm-bluetooth.txt       | 29 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 0ea18a53cc29..824c0e23c544 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -10,12 +10,25 @@ device the slave device is attached to.
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
> +Required properties for compatible string qcom,wcn3990-bt:
> +
> + - vddio-supply: VDD_IO supply regulator handle.
> + - vddxo-supply: VDD_XO supply regulator handle.
> + - vddrf-supply: VDD_RF supply regulator handle.
> + - vddch0-supply: VDD_CH0 supply regulator handle.
> +
> +Optional properties for compatible string qcom,wcn3990-bt:
> +
> + - max-speed: see Documentation/devicetree/bindings/serial/slave-device.txt
> +
> +Examples:
>  
>  serial@7570000 {
>  	label = "BT-UART";
> @@ -28,3 +41,15 @@ serial@7570000 {
>  		clocks = <&divclk4>;
>  	};
>  };
> +
> +serial@898000 {
> +	bluetooth {
> +		compatible = "qcom,wcn3990-bt";
> +
> +		vddio-supply = <&vreg_s4a_1p8>;
> +		vddxo-supply = <&vreg_l7a_1p8>;
> +		vddrf-supply = <&vreg_l17a_1p3>;
> +		vddch0-supply = <&vreg_l25a_3p3>;
> +		max-speed = <3200000>;
> +	};
> +};

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
