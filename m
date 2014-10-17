Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH] Bluetooth: 6lowpan: remove unnecessary codes in give_skb_to_upper
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1413426115-17077-1-git-send-email-roy.qing.li@gmail.com>
Date: Fri, 17 Oct 2014 16:11:20 +0200
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <9FCEFAB8-51BA-4CA6-A677-A7E2B95FF623@holtmann.org>
References: <1413426115-17077-1-git-send-email-roy.qing.li@gmail.com>
To: roy.qing.li@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Roy,

> From: Li RongQing <roy.qing.li@gmail.com>
> 
> netif_rx() only returns NET_RX_DROP and NET_RX_SUCCESS, not returns
> negative value
> 
> Signed-off-by: Li RongQing <roy.qing.li@gmail.com>
> ---
> net/bluetooth/6lowpan.c |    9 +--------
> 1 file changed, 1 insertion(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

