Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: linux-next: Tree for Oct 9 (bluetooth/bpa10x.c)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5617DFFF.90702@infradead.org>
Date: Fri, 9 Oct 2015 17:51:36 +0200
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Message-Id: <5B7CD6D9-14D0-4080-AD8D-FC9BEE3B813F@holtmann.org>
References: <20151009172448.6aed0174@canb.auug.org.au> <5617DFFF.90702@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Randy,

>> Changes since 20151008:
>> 
> 
> on i386:
> 
> warning: (BT_HCIBPA10X) selects BT_HCIUART_H4 which has unmet direct dependencies (NET && BT && BT_HCIUART)
> 
> drivers/built-in.o: In function `bpa10x_rx_complete':
> bpa10x.c:(.text+0x2ac5e2): undefined reference to `h4_recv_buf'

already noticed that issue. Fix for it has already been applied to bluetooth-next tree.

Regards

Marcel

