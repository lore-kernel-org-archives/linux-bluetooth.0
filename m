Return-Path: <bjorn.andersson@linaro.org>
Date: Tue, 13 Mar 2018 10:45:18 -0700
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
Subject: Re: [PATCH v2 3/3] Bluetooth: hci_qca: Add serdev support
Message-ID: <20180313174518.GU18510@minitux>
References: <20180313164444.19881-1-thierry.escande@linaro.org>
 <20180313164444.19881-4-thierry.escande@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180313164444.19881-4-thierry.escande@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue 13 Mar 09:44 PDT 2018, Thierry Escande wrote:
> @@ -50,6 +54,9 @@
>  #define IBS_TX_IDLE_TIMEOUT_MS		2000
>  #define BAUDRATE_SETTLE_TIMEOUT_MS	300
>  
> +/* divclk4 rate */

The clock is called "susclk" in the BT chip, "divclk4" is the board
specific name for the clock source.

> +#define DIVCLK4_RATE_32KHZ	32768
> +
>  /* HCI_IBS transmit side sleep protocol states */
>  enum tx_ibs_states {
>  	HCI_IBS_TX_ASLEEP,
> @@ -111,6 +118,12 @@ struct qca_data {
>  	u64 votes_off;
>  };
>  
> +struct qca_serdev {
> +	struct hci_uart	 serdev_hu;
> +	struct gpio_desc *bt_en;
> +	struct clk	 *divclk4;

Rename this to "susclk", or simply "clk".

> +};

Apart from this and Andy's comments this looks good.

Regards,
Bjorn
