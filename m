Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1524579073-21572-2-git-send-email-bgodavar@codeaurora.org>
Date: Tue, 24 Apr 2018 17:17:04 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
        linux-arm-msm@vger.kernel.org, hemantg@codeaurora.org
Message-Id: <2323BE2D-D0C7-465B-B156-D8DFE4A01BF2@holtmann.org>
References: <1524579073-21572-1-git-send-email-bgodavar@codeaurora.org>
 <1524579073-21572-2-git-send-email-bgodavar@codeaurora.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Balakrishna,,

> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
> .../devicetree/bindings/net/qualcomm-bluetooth.txt | 39 ++++++++++++++++++----
> 1 file changed, 32 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 0ea18a5..c81ac04 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -1,21 +1,32 @@
> -Qualcomm Bluetooth Chips
> ----------------------
> +Qualcomm Technologies Inc Bluetooth Chips
> +-----------------------------------------
> 
> This documents the binding structure and common properties for serial
> -attached Qualcomm devices.
> +attached Qualcomm Technologies Inc devices.
> 
> -Serial attached Qualcomm devices shall be a child node of the host UART
> -device the slave device is attached to.
> +Serial attached Qualcomm Technologies Inc devices shall be a child node
> +of the host UART device the slave device is attached to.

please skip these naming changes. Next week the company is named Qualcomm Something and I have no fun in entertaining changes around that. We also call it Intel and Broadcom and not their full legal entity names.

> 
> Required properties:
>  - compatible: should contain one of the following:
>    * "qcom,qca6174-bt"
> +   * "qcom,wcn3990-bt"
> 
> Optional properties:
>  - enable-gpios: gpio specifier used to enable chip
>  - clocks: clock provided to the controller (SUSCLK_32KHZ)
> -
> -Example:
> + - vddpa-supply: Bluetooth VDD PA regulator handle
> + - vddio-supply: Bluetooth VDD IO regulator handle
> + - vddldo-supply: Bluetooth VDD LDO regulator handle. Kept under optional
> +		  parameters as some of the chipsets doesn't require ldo or
> +		  it may use from same vddio.
> + - vddxtal-supply: Bluetooth VDD XTAL regulator handle
> + - vddcore-supply: Bluetooth VDD CORE regulator handle
> + - vddpwd-supply: Chip power down gpio is required when bluetooth module
> +		  and other modules like wifi co-exist in a singe chip and
> +		  shares a common gpio to bring chip out of reset.
> +
> +Examples:
> 
> serial@7570000 {
> 	label = "BT-UART";
> @@ -28,3 +39,17 @@ serial@7570000 {
> 		clocks = <&divclk4>;
> 	};
> };
> +
> +serial@898000 {
> +	label = "BT-UART";
> +	status = "okay";
> +
> +	bluetooth: bt_wcn3990 {
> +		compatible = "qca,wcn3990-bt";
> +		vddio-supply = <&pm8998_s3>;
> +		vddxtal-supply = <&pm8998_s5>;
> +		vddcore-supply = <&pm8998_l7>;
> +		vddpa-supply = <&pm8998_l17>;
> +		vddldo-supply = <&pm8998_l25>;
> +	};
> +};

Regards

Marcel

