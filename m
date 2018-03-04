Return-Path: <bjorn.andersson@linaro.org>
Date: Sun, 4 Mar 2018 11:55:27 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>,
	Bluez mailing list <linux-bluetooth@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btqcomsmd: Fix channel open check
Message-ID: <20180304195527.GP93895@bjorns-mbp-2.lan>
References: <20180228001738.11131-1-bjorn.andersson@linaro.org>
 <1498F44F-02AE-4384-9227-0BABE3F4764E@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498F44F-02AE-4384-9227-0BABE3F4764E@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue 27 Feb 22:25 PST 2018, Marcel Holtmann wrote:
> > 	btq->cmd_channel = qcom_wcnss_open_channel(wcnss, "APPS_RIVA_BT_CMD",
> > 						   btqcomsmd_cmd_callback, btq);
> > -	if (IS_ERR(btq->cmd_channel))
> > -		return PTR_ERR(btq->cmd_channel);
> > +	if (!btq->cmd_channel)
> > +		return -ENOENT;
> 
> Any reason not to fix qcom_wcnss_open_channel to use PTR_ERR?
> 

Not that I can come up with, and obviously I did expect it to do so in
the past. I'll do that.

Thanks,
Bjorn
