Return-Path: <bjorn.andersson@linaro.org>
Date: Wed, 14 Mar 2018 11:30:43 -0700
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
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: net: bluetooth: Add
 qualcomm-bluetooth
Message-ID: <20180314183043.GX18510@minitux>
References: <20180314155514.3374-1-thierry.escande@linaro.org>
 <20180314155514.3374-3-thierry.escande@linaro.org>
 <FF2E3FDE-76C5-477A-A904-32AC064297DA@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FF2E3FDE-76C5-477A-A904-32AC064297DA@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed 14 Mar 09:13 PDT 2018, Marcel Holtmann wrote:
> > +		bt-disable-n-gpios = <&pm8994_gpios 19 GPIO_ACTIVE_HIGH>;
> 
> can we use a common name here. I think that Nokia and Broadcom drivers
> define one. And if this is the enable/shutdown GPIO, we should name it
> consistently across all manufacturers. It essentially does the same on
> Bluetooth UART chips no matter what chip is behind them.
> 

Broadcomm has a device-wakup-gpios and Nokia has bluetooth-wakup-gpios.
It might be that these behave in the same way, but from the description
they only trigger the wakeup.

The reason for the proposed naming here is that the pin is named
"BT_DISABLE_N" in the datasheet.

Regards,
Bjorn
