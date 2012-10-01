Return-Path: <cyrus@holtmann.org>
Date: Mon, 1 Oct 2012 12:04:15 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH -next] bluetooth: fix printk format warnings
Message-ID: <20121001150415.GK15463@joana>
References: <20120928165112.6b0f5328b72428799c3f995d@canb.auug.org.au>
 <5068F597.9020403@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5068F597.9020403@xenotime.net>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Randy,

* Randy Dunlap <rdunlap@xenotime.net> [2012-09-30 18:44:55 -0700]:

> From: Randy Dunlap <rdunlap@xenotime.net>
> 
> Fix printk format warnings in net/bluetooth/:
> 
> net/bluetooth/hci_event.c:886:3: warning: format '%ld' expects type 'long int', but argument 2 has type 'size_t'
> net/bluetooth/hci_event.c:886:3: warning: format '%ld' expects type 'long int', but argument 3 has type 'size_t'
> net/bluetooth/a2mp.c:386:2: warning: format '%lu' expects type 'long unsigned int', but argument 4 has type 'unsigned int'
> 
> Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
> M:	Marcel Holtmann <marcel@holtmann.org>
> M:	Gustavo Padovan <gustavo@padovan.org>
> M:	Johan Hedberg <johan.hedberg@gmail.com>
> L:	linux-bluetooth@vger.kernel.org
> ---
>  net/bluetooth/a2mp.c      |    2 +-
>  net/bluetooth/hci_event.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

This is fixed on bluetooth-next already, thanks for the patch anyway.

	Gustavo
