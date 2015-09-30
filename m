Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] bluetooth: btuart_cs: remove obsolete header
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150930122722.GA5186@jci-VirtualBox>
Date: Wed, 30 Sep 2015 15:27:01 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <D68DBA2D-D75C-42AD-A7B2-95514A6F183C@holtmann.org>
References: <20150930122722.GA5186@jci-VirtualBox>
To: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prasanna,

> Use <linux/io.h> instead of <asm/io.h>, fixes checkpatch
> Warning;
> 
> Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
> ---
> drivers/bluetooth/btuart_cs.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

