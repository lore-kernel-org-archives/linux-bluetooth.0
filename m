Return-Path: <robherring2@gmail.com>
Date: Wed, 13 Sep 2017 11:21:47 -0500
From: Rob Herring <robh@kernel.org>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, bjorn.andersson@linaro.org
Subject: Re: [PATCH v5 2/3] dt-bindings: soc: qcom: Add local-bd-address
 property to WCNSS-BT
Message-ID: <20170913162147.chbv4yhcoqiuddbv@rob-hp-laptop>
References: <1504637923-21652-1-git-send-email-loic.poulain@linaro.org>
 <1504637923-21652-2-git-send-email-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1504637923-21652-2-git-send-email-loic.poulain@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Sep 05, 2017 at 08:58:42PM +0200, Loic Poulain wrote:
> Add optional local-bd-address property which is a 6-byte array
> storing the assigned BD address. Since having a unique BD address
> is critical, a per-device property value should be allocated.
> This property is usually added by the boot loader which has access
> to the provisioned data.
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
> 
>  Documentation/devicetree/bindings/soc/qcom/qcom,wcnss.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
