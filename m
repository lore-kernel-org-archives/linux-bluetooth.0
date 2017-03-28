Return-Path: <bjorn.andersson@linaro.org>
Date: Mon, 27 Mar 2017 22:49:22 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: David Miller <davem@davemloft.net>
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
	k.eugene.e@gmail.com, kvalo@codeaurora.org, andy.gross@linaro.org,
	david.brown@linaro.org, arnd@arndb.de,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] soc: qcom: smd: Transition client drivers from smd
 to rpmsg
Message-ID: <20170328054922.GH70446@Bjorns-MacBook-Pro-2.local>
References: <20170322215733.GH20094@minitux>
 <20170323.165613.802100008000968298.davem@davemloft.net>
 <20170327225836.GL20094@minitux>
 <20170327.160400.1285256003980361221.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170327.160400.1285256003980361221.davem@davemloft.net>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon 27 Mar 16:04 PDT 2017, David Miller wrote:

> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> Date: Mon, 27 Mar 2017 15:58:37 -0700
> 
> > I'm sorry, but I can't figure out how to reproduce this.
> 
> All of my builds are "make allmodconfig" so it should be easy to reproduce.

Thanks, turns out that while it was possible to select CONFIG_SMD_RPM
and CONFIG_QCOM_WCNSS_CTRL drivers/soc/Makefile does not traverse into
qcom/ unless CONFIG_ARCH_QCOM was set.

So I just sent out version 2 of the three patches, where I add an
explicit dependency on ARCH_QCOM for those two options.

Regards,
Bjorn
