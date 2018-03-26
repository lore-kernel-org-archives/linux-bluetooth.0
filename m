Return-Path: <bjorn.andersson@linaro.org>
Date: Tue, 27 Mar 2018 06:51:06 +0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Thierry Escande <thierry.escande@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Andy Gross <andy.gross@linaro.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Brown <david.brown@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
Message-ID: <20180326225106.GC1403@tuxbook-pro>
References: <20180320032331.29865-1-thierry.escande@linaro.org>
 <20180320032331.29865-3-thierry.escande@linaro.org>
 <FAC61078-6298-47A7-A51C-73D72BEF6E4A@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FAC61078-6298-47A7-A51C-73D72BEF6E4A@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue 20 Mar 23:58 HKT 2018, Marcel Holtmann wrote:
> > Signed-off-by: Thierry Escande <thierry.escande@linaro.org>
[..]
> > + - clocks: clock phandle for SUSCLK_32KHZ
> 
> if I compare this with broadcom-bluetooth.txt or ti-bluetooth.txt then
> besides compatible, everything else is optional. The
> nokia-bluetooth.txt has everything required, but that is also a really
> specific platform.
> 
> Can we be less restrictive for a QCA general purpose chip?
> 

The way we deal with this in other bindings is that we tie such
requirements to the compatible; i.e. we would say that qcom,qca6174-bt
requires a clock and we would have something like qcom,qca-bt that makes
it optional.

The beauty of this is that the driver will tell you if you forgot to
specify the clock when it actually is required, which saves you
considerable amount of debugging time.


NB. The way the bcm driver handles this is insufficient, as it treats
any error from clk_get as "there's no clock specified". The driver
should accept a clock not being specified, but should fail properly when
a clock is specified but can't be acquired (e.g. due to clk_get()
returning EPROBE_DEFER).

> > +
> > +Example:
> > +
> > +serial@7570000 {
> > +	pinctrl-names = "default", "sleep";
> > +	pinctrl-0 = <&blsp1_uart1_default>;
> > +	pinctrl-1 = <&blsp1_uart1_sleep>;
> > +
> > +	bluetooth {
> > +		compatible = "qcom,qca6174-bt";
> > +
> > +		enable-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
> > +
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&bt_en_pin_a>;
> 
> This one I do not understand and you might want to shed some light
> into why this is done that way.
> 

This is completely generic and only relates to getting the electrical
properties of the gpio pin set up correctly. So I would recommend that
we omit this from the binding and example (including the pinctrl
properties for the serial above).

Regards,
Bjorn
