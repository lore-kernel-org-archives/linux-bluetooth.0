Return-Path: <bjorn.andersson@linaro.org>
Date: Wed, 6 Sep 2017 16:26:10 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: marcel@holtmann.org, robh+dt@kernel.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dt-bindings: net: document Bluetooth bindings in
 one place
Message-ID: <20170906232610.GG1165@minitux>
References: <1504699898-28011-1-git-send-email-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504699898-28011-1-git-send-email-loic.poulain@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed 06 Sep 05:11 PDT 2017, Loic Poulain wrote:

> In the same way as Ethernet, gather the Bluetooth related bindings in
> one file. Introduce the bluetooth-bd-address property which can be used
> to store the assigned BD address.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  v2: Set device as unconfigured if default address detected
>      Add warning if BD addr retrieved from DT
>  v3: if no addr retrieved from DT, unconditionally set
>      the invalid BD addr flag.
>      swap and set bdaddr in the platform probe
>  v4: Add dt-bindings documentation
>      split patch in two parts (setup, dt prop)
>      use local-bd-address name instead of local-mac-address
>  v5: remove 2/3 merged in bluetooth-next tree
>      Add bluetooth.txt for common BT bindings
>      expect local-bd-address in little-endian format
>  v6: use of_property_read_u8_array instead of of_get_property
> 
>  Documentation/devicetree/bindings/net/bluetooth.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth.txt b/Documentation/devicetree/bindings/net/bluetooth.txt
> new file mode 100644
> index 0000000..94797df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth.txt
> @@ -0,0 +1,5 @@
> +The following properties are common to the Bluetooth controllers:
> +
> +- local-bd-address: array of 6 bytes, specifies the BD address that was
> +  uniquely assigned to the Bluetooth device, formatted with least significant
> +  byte first (little-endian).

Is there a good reason for making this little endian?

Sure it's only going to be read and written by computers, but for anyone
reading the generated DT it sure looks like the values are reversed.

Regards,
Bjorn
