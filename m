Return-Path: <cyrus@holtmann.org>
Date: Wed, 31 Oct 2012 16:21:57 -0200
From: Gustavo Padovan <gustavo@padovan.org>
To: Syam Sidhardhan <s.syam@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/5] Bluetooth: Remove unnecessary include export.h
Message-ID: <20121031182157.GC1679@joana>
References: <1350999140-7481-1-git-send-email-s.syam@samsung.com>
 <1350999140-7481-2-git-send-email-s.syam@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1350999140-7481-2-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syam,

* Syam Sidhardhan <s.syam@samsung.com> [2012-10-23 19:02:17 +0530]:

> For files only using THIS_MODULE and/or EXPORT_SYMBOL, map
> them onto including export.h -- or if the file isn't even
> using those, then just delete the include.
> 
> Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
> ---
>  net/bluetooth/bnep/netdev.c |    1 -
>  net/bluetooth/hci_event.c   |    1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/net/bluetooth/bnep/netdev.c b/net/bluetooth/bnep/netdev.c
> index 98f86f9..e58c8b3 100644
> --- a/net/bluetooth/bnep/netdev.c
> +++ b/net/bluetooth/bnep/netdev.c
> @@ -25,7 +25,6 @@
>     SOFTWARE IS DISCLAIMED.
>  */
>  
> -#include <linux/export.h>
>  #include <linux/etherdevice.h>
>  
>  #include <net/bluetooth/bluetooth.h>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 82e478a..110006a 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -24,7 +24,6 @@
>  
>  /* Bluetooth HCI event handling. */
>  
> -#include <linux/export.h>
>  #include <asm/unaligned.h>
>  
>  #include <net/bluetooth/bluetooth.h>

I don't see any build failure coming from this, patch is applied to
bluetooth-next. Thanks.

	Gustavo
