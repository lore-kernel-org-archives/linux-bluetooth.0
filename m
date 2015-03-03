Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v2(sorta) 1/2] bluetooth: Add BT_{INFO,ERR,DBG}_RATELIMITED
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1424759141-17889-2-git-send-email-gmt@be-evil.net>
Date: Mon, 2 Mar 2015 17:07:00 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A0BC5B7E-9D0B-449B-ADF1-3F8D97827743@holtmann.org>
References: <1424759141-17889-1-git-send-email-gmt@be-evil.net> <1424759141-17889-2-git-send-email-gmt@be-evil.net>
To: "Gregory M. Turner" <gmt@be-evil.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gregory,

> Add ratelimited versions of the BT_{INFO,ERR,DBG} printk macros.
> 
> The assymetry with the existing _INFO and _ERR macros is because,
> afaics, those are special-cased as an object-file-size optimization.
> Duplicating that for the _RATELIMITED versions would clearly be a
> deoptimization until they got a few more consumers (currently only a
> single consumer is planned).
> 
> Signed-off-by: Gregory M. Turner <gmt@be-evil.net>
> ---
> include/net/bluetooth/bluetooth.h | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index e00455a..ec321f9 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -124,9 +124,12 @@ void bt_info(const char *fmt, ...);
> __printf(1, 2)
> void bt_err(const char *fmt, ...);
> 
> -#define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
> -#define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
> -#define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
> +#define BT_INFO(fmt, ...)		bt_info(fmt "\n", ##__VA_ARGS__)
> +#define BT_INFO_RATELIMITED(fmt, ...)	pr_info_ratelimited(fmt "\n", ##__VA_ARGS__)
> +#define BT_ERR(fmt, ...)		bt_err(fmt "\n", ##__VA_ARGS__)
> +#define BT_ERR_RATELIMITED(fmt, ...)	pr_err_ratelimited(fmt "\n", ##__VA_ARGS__)
> +#define BT_DBG(fmt, ...)		pr_debug(fmt "\n", ##__VA_ARGS__)
> +#define BT_DBG_RATELIMITED(fmt, ...)	pr_debug_ratelimited(fmt "\n", ##__VA_ARGS__)

I would prefer that you only introduce BT_ERR_RATELIMITED and we leave it at that. Since that is the only one we need anyway. And please do not re-indent the existing ones. Just keep them as they are.

Regards

Marcel

