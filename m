Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: qcom: Add local-bd-address
 property to WCNSS-BT
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1504607164-12645-1-git-send-email-loic.poulain@linaro.org>
Date: Tue, 5 Sep 2017 13:54:24 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        bjorn.andersson@linaro.org
Message-Id: <F3742D76-DDB2-4D25-B7BB-62BD18175C4E@holtmann.org>
References: <1504607164-12645-1-git-send-email-loic.poulain@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> Add optional local-bd-address property which is a 6-byte array
> storing the assigned BD address. Since having a unique BD address
> is critical, a per-device property value should be allocated.
> This property is usually added by the boot loader which has access
> to the provisioned data.
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
> Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt | 6 ++++++
> 1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt
> index 4ea39e9186a7..1edfcdc6e267 100644
> --- a/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt
> +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt
> @@ -37,6 +37,12 @@ The following properties are defined to the bluetooth node:
> 	Definition: must be:
> 		    "qcom,wcnss-bt"
> 
> +- local-bd-address:
> +	Usage: optional
> +	Value type: <u8 array>
> +	Definition: should specify the unique 6-byte BD address assigned to the
> +		    BT controller. Usually added at runtime by the boot loader.
> +

as mentioned in my other email, I would really add an example on how to format this. Especially since these are formatted in little-endian order. So adding an example of “00:11:22:33:44:55” string representation on how it converts to [ 55 44 33 22 11 00 ] would be super helpful.

It might also be useful to create a generic bluetooth.txt similar to ethernet.txt. And then just reference it from here.

Of course we need to have Rob sign off on this and also make sure the boot loader people get this done correctly.

Regards

Marcel

