Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Oct 2012 14:22:16 +0800
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, bzhao@marvell.com
Subject: Re: [PATCH] Bluetooth: btmrv: Use %*ph specifier instead of
 print_hex_dump_bytes
Message-ID: <20121011062216.GA15051@joana>
References: <1349880093-23728-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349880093-23728-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-10-10 17:41:33 +0300]:

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Use standard print specifier and remove print_hex_dump_bytes call.
> Makes output more sensible:
> 
> ...
> [18809.401218] 00000000: 0b 00 00 fe 5b fc 01 f2 00 00 00    ....[......
> ...
> 
> would be changed to
> 
> ...
> [18809.401218] Bluetooth: hex: 0b 00 00 fe 5b fc 01 f2 00 00 00
> ...
> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> ---
>  drivers/bluetooth/btmrvl_sdio.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
