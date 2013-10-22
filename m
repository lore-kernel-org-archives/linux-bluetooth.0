Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 Oct 2013 10:29:30 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Add function name to debug prints
Message-ID: <20131022072930.GA10844@x220.p-661hnu-f1>
References: <1382425751-9018-1-git-send-email-jukka.rissanen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382425751-9018-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

On Tue, Oct 22, 2013, Jukka Rissanen wrote:
> the debug prints are quite useless without the function name.
> Without this patch one sees lot of "hci0" lines which is not
> very helpful.
> 
> Cheers,
> Jukka
> 
>  include/net/bluetooth/bluetooth.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index bf2ddff..0b1eacd 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -122,7 +122,7 @@ int bt_err(const char *fmt, ...);
>  
>  #define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
>  #define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
> -#define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
> +#define BT_DBG(fmt, ...)	pr_debug("%s():" fmt "\n", __FUNCTION__, ##__VA_ARGS__)

This shouldn't be necessary since you can ask the function name to be
printed using standard dynamic debug control syntax, e.g:

echo "file hci_event.c +pf" > /sys/kernel/debug/dynamic_debug/control

Johan
