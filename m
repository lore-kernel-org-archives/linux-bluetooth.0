Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v2 2/3] dt-bindings: Add optional nvmem BD address
 bindings to ti,wlink-st
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1512701860-8321-3-git-send-email-david@lechnology.com>
Date: Fri, 8 Dec 2017 09:08:36 +0100
Cc: devicetree <devicetree@vger.kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <DC2DEAE4-17F2-4512-B69C-4E4BC1C630D8@holtmann.org>
References: <1512701860-8321-1-git-send-email-david@lechnology.com>
 <1512701860-8321-3-git-send-email-david@lechnology.com>
To: David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,


> This adds optional nvmem consumer properties to the ti,wlink-st device tree
> bindings to allow specifying the BD address.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
> 
> v2 changes:
> * Renamed "mac-address" to "bd-address"
> * Fixed typos in example
> * Specify byte order of "bd-address"
> 
> Documentation/devicetree/bindings/net/ti,wilink-st.txt | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,wilink-st.txt b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
> index 1649c1f..a45a508 100644
> --- a/Documentation/devicetree/bindings/net/ti,wilink-st.txt
> +++ b/Documentation/devicetree/bindings/net/ti,wilink-st.txt
> @@ -32,6 +32,9 @@ Optional properties:
>    See ../clocks/clock-bindings.txt for details.
>  - clock-names : Must include the following entry:
>    "ext_clock" (External clock provided to the TI combo chip).
> + - nvmem-cells: phandle to nvmem data cell that contains a 6 byte BD address
> +   with the most significant byte first (big-endian).
> + - nvmem-cell-names: "bd-address" (required when nvmem-cells is specified)
> 
> Example:
> 
> @@ -43,5 +46,7 @@ Example:
> 		enable-gpios = <&gpio1 7 GPIO_ACTIVE_HIGH>;
> 		clocks = <&clk32k_wl18xx>;
> 		clock-names = "ext_clock";
> +		nvmem-cells = <&bd_address>;
> +		nvmem-cell-names = "bd-address”;

For me this looks good, but I like to get an extra ACK from Rob on this.

Regards

Marcel
