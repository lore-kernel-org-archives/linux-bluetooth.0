Return-Path: <bjorn.andersson@linaro.org>
Date: Tue, 13 Mar 2018 10:25:36 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Andy Gross <andy.gross@linaro.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Brown <david.brown@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
Message-ID: <20180313172536.GT18510@minitux>
References: <20180313164444.19881-1-thierry.escande@linaro.org>
 <20180313164444.19881-3-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180313164444.19881-3-thierry.escande@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue 13 Mar 09:44 PDT 2018, Thierry Escande wrote:

> Add binding document for serial bluetooth chips using Qualcomm protocol.
> 
> Signed-off-by: Thierry Escande <thierry.escande@linaro.org>

Looks good, just two minor things.

[..]
> +Required properties:
> +
> + - compatible: should contain one of the following:
> +   * "qcom,qca6174-bt"
> +

You're missing the "susclk" clock.

> +Optional properties:
> +
> + - bt-disable-n-gpios: GPIO specifier, used to enable chip during probe

Is this really optional?

Regards,
Bjorn
