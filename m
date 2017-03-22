Return-Path: <andy.gross@linaro.org>
Date: Wed, 22 Mar 2017 16:52:24 -0500
From: Andy Gross <andy.gross@linaro.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Eugene Krasnikov <k.eugene.e@gmail.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	David Brown <david.brown@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@arndb.de>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, wcn36xx@lists.infradead.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH 1/3] soc: qcom: smd: Transition client drivers from smd
 to rpmsg
Message-ID: <20170322215224.GA22585@hector.attlocal.net>
References: <20170320233544.1656-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170320233544.1656-1-bjorn.andersson@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Mar 20, 2017 at 04:35:42PM -0700, Bjorn Andersson wrote:
> By moving these client drivers to use RPMSG instead of the direct SMD
> API we can reuse them ontop of the newly added GLINK wire-protocol
> support found in the 820 and 835 Qualcomm platforms.
> 
> As the new (RPMSG-based) and old SMD implementations are mutually
> exclusive we have to change all client drivers in one commit, to make
> sure we have a working system before and after this transition.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

For the qcom/smd parts:

Acked-by: Andy Gross <andy.gross@linaro.org>
