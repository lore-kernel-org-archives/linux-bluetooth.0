Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] bluetooth: bt3c_cs: clean up bt3c_cs driver code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20151001125557.GA4143@jci-VirtualBox>
Date: Thu, 1 Oct 2015 15:23:24 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <6E72450D-94E9-4918-8F6F-871AFB52E2D9@holtmann.org>
References: <20151001125557.GA4143@jci-VirtualBox>
To: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prasanna,

> Patch fixes the checkpatch warnings:
> - use linux/io.h instead of asm/io.h
> - NULL comparison could be re-written
> 
> Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
> ---
> drivers/bluetooth/bt3c_cs.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

the patch does not apply to bluetooth-next tree.

Regards

Marcel

