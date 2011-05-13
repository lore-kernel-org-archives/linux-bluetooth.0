Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 May 2011 15:23:53 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ruiyi Zhang <Ruiyi.Zhang@Atheros.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3] Bluetooth: Allow unsegmented SDU retries on
 sock_queue_rcv_skb failure.
Message-ID: <20110513182353.GA5403@joana>
References: <1303990781-15538-1-git-send-email-Ruiyi.zhang@atheros.com>
 <1304657051-26453-1-git-send-email-Ruiyi.zhang@atheros.com>
 <20110511175555.GE22065@joana>
 <7f3edf43a88fbbcd8ef1797450b43eda889e2c9a.1305256769.git.Ruiyi.Zhang@Atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7f3edf43a88fbbcd8ef1797450b43eda889e2c9a.1305256769.git.Ruiyi.Zhang@Atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ruiyi,

* Ruiyi Zhang <Ruiyi.Zhang@Atheros.com> [2011-05-13 13:07:52 +0800]:

> In L2CAP_SDU_UNSEGMENTED case, if sock_queue_rcv_skb returns error,
> l2cap_ertm_reassembly_sdu should not return 0 so as to insert the
> skb into BUSY_QUEUE for later retries.
> 
> Signed-off-by: Ruiyi Zhang <Ruiyi.Zhang@Atheros.com>
> ---
>  net/bluetooth/l2cap_core.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
