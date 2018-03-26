Return-Path: <robherring2@gmail.com>
Date: Mon, 26 Mar 2018 17:23:33 -0500
From: Rob Herring <robh@kernel.org>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Brown <david.brown@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
Message-ID: <20180326222333.mety3fcwcgcfcaqv@rob-hp-laptop>
References: <20180320032331.29865-1-thierry.escande@linaro.org>
 <20180320032331.29865-3-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180320032331.29865-3-thierry.escande@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Mar 20, 2018 at 04:23:30AM +0100, Thierry Escande wrote:
> Add binding document for serial bluetooth chips using Qualcomm protocol.
> 
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
> ---
> 
> v5:
> - Rename 'bt-disable-n' gpio as 'enable'
> 
> v4:
> - Move bt-disable-n-gpios to required properties section
> - Add clocks and pinctrl-0 as required properties
> 
> v3: no change
> v2: no change
> 
>  .../devicetree/bindings/net/qualcomm-bluetooth.txt | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/qualcomm-bluetooth.txt

Reviewed-by: Rob Herring <robh@kernel.org>
