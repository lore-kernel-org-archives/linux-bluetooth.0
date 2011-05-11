Return-Path: <cyrus@holtmann.org>
Date: Wed, 11 May 2011 14:55:55 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Ruiyi Zhang <Ruiyi.zhang@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Allow unsegmented SDU retries on
 sock_queue_rcv_skb failure.
Message-ID: <20110511175555.GE22065@joana>
References: <1303990781-15538-1-git-send-email-Ruiyi.zhang@atheros.com>
 <1304657051-26453-1-git-send-email-Ruiyi.zhang@atheros.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304657051-26453-1-git-send-email-Ruiyi.zhang@atheros.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ruiyi,

* Ruiyi Zhang <Ruiyi.zhang@atheros.com> [2011-05-06 12:44:11 +0800]:

> In L2CAP_SDU_UNSEGMENTED case, if sock_queue_rcv_skb returns error,
> l2cap_ertm_reassembly_sdu should not return 0 so as to insert the
> skb into BUSY_QUEUE for later retries.
> 
> Signed-off-by: Ruiyi Zhang <Ruiyi.zhang@atheros.com>
> ---
>  net/bluetooth/l2cap_core.c |    6 +-----
>  1 files changed, 1 insertions(+), 5 deletions(-)

Patch has not applied upstream. Please rebase onto bluetooth-next. Thanks.

-- 
Gustavo F. Padovan
http://profusion.mobi
