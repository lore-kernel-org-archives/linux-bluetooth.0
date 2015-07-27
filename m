Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH 1/2] Bluetooth: btbcm: Fix coding style
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1438005639-3838-1-git-send-email-frederic.danis@linux.intel.com>
Date: Mon, 27 Jul 2015 16:58:59 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E793661E-6DA6-418B-A8FA-BBF6F6ACC1B6@holtmann.org>
References: <1438005639-3838-1-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> space required after that close brace '}'
> reported by checkpatch.pl
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/btbcm.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 9ceb8ac..9d699dd 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -32,8 +32,8 @@
> 
> #define VERSION "0.1"
> 
> -#define BDADDR_BCM20702A0 (&(bdaddr_t) {{0x00, 0xa0, 0x02, 0x70, 0x20, 0x00}})
> -#define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
> +#define BDADDR_BCM20702A0 (&(bdaddr_t){ {0x00, 0xa0, 0x02, 0x70, 0x20, 0x00} })
> +#define BDADDR_BCM4324B3 (&(bdaddr_t){ {0x00, 0x00, 0x00, 0xb3, 0x24, 0x43} })

lets drop this patch. I am not going to listen to checkpatch.pl in this case.

Regards

Marcel

