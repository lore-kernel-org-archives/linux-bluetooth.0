Return-Path: <robherring2@gmail.com>
Date: Mon, 25 Jun 2018 08:58:37 -0600
From: Rob Herring <robh@kernel.org>
To: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, mka@chromium.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, rtatiya@codeaurora.org,
	hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 1/7] dt-bindings: net: bluetooth: Add device tree
 bindings for QTI chip wcn3990
Message-ID: <20180625145837.GA21153@rob-hp-laptop>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
 <20180625134013.19684-2-bgodavar@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180625134013.19684-2-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Jun 25, 2018 at 07:10:07PM +0530, Balakrishna Godavarthi wrote:
> This patch enables regulators for the Qualcomm Bluetooth wcn3990
> controller.
> 
> Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
> ---
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
>  .../bindings/net/qualcomm-bluetooth.txt       | 30 +++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> index 0ea18a53cc29..c2b09dd2bf31 100644
> --- a/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt
> @@ -10,12 +10,23 @@ device the slave device is attached to.
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
> + - vddio-supply: Bluetooth VDD IO regulator handle.
> + - vddxtal-supply: Bluetooth VDD XTAL regulator handle.
> + - vddpa-supply: Bluetooth VDD PA regulator handle.
> + - vddldo-supply: Bluetooth VDD LDO regulator handle.
> + - vddcore-supply: Bluetooth VDD CORE regulator handle.
> + - max-speed: Maximum operating speed of the chip.

This shouldn't be per compatible really. The definition here is wrong 
too. You should know the max baud for the chip based on the compatible. 
This property is for when the max is less than the max of either the 
chip or host UART.

Rob
