Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH 1/3] dt-bindings: Add optional nvmem MAC address bindings
 to ti,wlink-st
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1512357682-8911-2-git-send-email-david@lechnology.com>
Date: Mon, 4 Dec 2017 07:50:30 +0100
Cc: devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <7A28F1AF-A691-4261-83A0-01C14148EE98@holtmann.org>
References: <1512357682-8911-1-git-send-email-david@lechnology.com>
 <1512357682-8911-2-git-send-email-david@lechnology.com>
To: David Lechner <david@lechnology.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> This adds optional nvmem consumer properties to the ti,wlink-st device tree
> bindings to allow specifying the Bluetooth MAC address.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> Documentation/devicetree/bindings/net/ti,wilink-st.txt | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,wilink-st.txt b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
> index 1649c1f..24eb897 100644
> --- a/Documentation/devicetree/bindings/net/ti,wilink-st.txt
> +++ b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
> @@ -32,6 +32,8 @@ Optional properties:
>    See ../clocks/clock-bindings.txt for details.
>  - clock-names : Must include the following entry:
>    "ext_clock" (External clock provided to the TI combo chip).
> + - nvmem-cells: phandle to nvmem data cell that contains a MAC address
> + - nvmem-cell-names: "mac-address" (required when nvmem-cells is specified)

lets call these “bt-address” since they are not really MAC addresses. They have special formatting etc. Also I prefer that the actual format on how they are stored is described. See Documentation/devicetree/bindings/net/bluetooth.txt for an example.

> Example:
> 
> @@ -43,5 +45,7 @@ Example:
> 		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> 		clocks = <&clk32k_wl18xx>;
> 		clock-names = "ext_clock";
> +		nvmem-cells: <&mac_address>
> +		nvmem-cell-names "mac-address"
> 	};
> };

Regards

Marcel

