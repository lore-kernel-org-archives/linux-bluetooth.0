Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1457101018.3663.19.camel@linux.intel.com>
Subject: Re: [RFC 2/5] bluetooth: Implement Get Networks Management API
 command
From: Patrik Flykt <Patrik.Flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Date: Fri, 04 Mar 2016 16:16:58 +0200
In-Reply-To: <1457091644-21536-3-git-send-email-patrik.flykt@linux.intel.com>
References: <1457091644-21536-1-git-send-email-patrik.flykt@linux.intel.com>
	 <1457091644-21536-3-git-send-email-patrik.flykt@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2016-03-04 at 13:40 +0200, Patrik Flykt wrote:
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -31,6 +31,7 @@
>  #include <net/bluetooth/hci_core.h>
>  #include <net/bluetooth/hci_sock.h>
>  #include <net/bluetooth/l2cap.h>
> +#include <net/bluetooth/6lowpan.h>

And of course the header file gets left behind. I'll fix...

Cheers,

	Patrik

