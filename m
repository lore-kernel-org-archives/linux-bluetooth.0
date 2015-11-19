Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH] net: bluetooth: remove unneeded variable in l2cap_stream_rx
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20151119120509.GA8228@jci-VirtualBox>
Date: Thu, 19 Nov 2015 14:20:39 +0100
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <C96C768A-5ECB-45E6-9040-B11FB53AF403@holtmann.org>
References: <20151119120509.GA8228@jci-VirtualBox>
To: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prasanna,

> Remove unneeded variable used to store return value.
> Error reported by coccicheck.
> 
> Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
> ---
> net/bluetooth/l2cap_core.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

