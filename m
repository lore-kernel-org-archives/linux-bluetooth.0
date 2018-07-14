Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: [PATCH v5 1/7] dt-bindings: net: bluetooth: Add
 mediatek-bluetooth
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <d8a5b34513cf2187a2b23a513feaa358d719bc14.1531150733.git.sean.wang@mediatek.com>
Date: Sat, 14 Jul 2018 18:26:24 +0200
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <7E55939D-7F8A-4832-9DD5-EFB3B19ACF0B@holtmann.org>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <d8a5b34513cf2187a2b23a513feaa358d719bc14.1531150733.git.sean.wang@mediatek.com>
To: sean.wang@mediatek.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sean,

> Add binding document for a SoC built-in device using MediaTek protocol.
> Which could be found on MT7622 SoC or other similar MediaTek SoCs.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> .../devicetree/bindings/net/mediatek-bluetooth.txt | 35 ++++++++++++++++++++++
> 1 file changed, 35 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> new file mode 100644
> index 0000000..1335429
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> @@ -0,0 +1,35 @@
> +MediaTek SoC built-in Bluetooth Devices
> +==================================
> +
> +This device is a serial attached device to BTIF device and thus it must be a
> +child node of the serial node with BTIF. The dt-bindings details for BTIF
> +device can be known via Documentation/devicetree/bindings/serial/8250.txt.
> +
> +Required properties:
> +
> +- compatible:	Must be one of
> +		  "mediatek,mt7622-bluetooth"": for MT7622 SoC

this does not match with the example below. And one of, should be normally be a list.

> +- clocks:	Should be the clock specifiers corresponding to the entry in
> +		clock-names property.
> +- clock-names:	Should contain "ref" entries.
> +- power-domains: Phandle to the power domain that the device is part of
> +
> +Example:
> +
> +	btif: serial@1100c000 {
> +		compatible = "mediatek,mt7622-btif",
> +			     "mediatek,mtk-btif";
> +		reg = <0 0x1100c000 0 0x1000>;
> +		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_LOW>;
> +		clocks = <&pericfg CLK_PERI_BTIF_PD>;
> +		clock-names = "main";
> +		reg-shift = <2>;
> +		reg-io-width = <4>;
> +
> +		bluetooth {
> +			compatible = "mediatek,mt7622-bluetooth";
> +			power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
> +			clocks = <&clk25m>;
> +			clock-names = "ref";
> +		};
> +	};

Regards

Marcel
