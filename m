Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v4 1/5] Bluetooth: Add BT_WARN and bt_dev_warn logging macros
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1442305868-6203-2-git-send-email-frederic.danis@linux.intel.com>
Date: Wed, 16 Sep 2015 04:47:10 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1181A545-6999-4587-B813-D0F86ADD58C4@holtmann.org>
References: <1442305868-6203-1-git-send-email-frederic.danis@linux.intel.com> <1442305868-6203-2-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Add warning logging macros to bluetooth subsystem logs.
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> include/net/bluetooth/bluetooth.h | 3 +++
> 1 file changed, 3 insertions(+)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index fcf2ae7..27a3f16 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -125,11 +125,14 @@ __printf(1, 2)
> void bt_err(const char *fmt, ...);
> 
> #define BT_INFO(fmt, ...)	bt_info(fmt "\n", ##__VA_ARGS__)
> +#define BT_WARN(fmt, ...)	pr_warn(fmt "\n", ##__VA_ARGS__)

any reason why you didn't create a bt_warn instead here? That why we have the proper pr_fmt set with the Bluetooth: prefix.

> #define BT_ERR(fmt, ...)	bt_err(fmt "\n", ##__VA_ARGS__)
> #define BT_DBG(fmt, ...)	pr_debug(fmt "\n", ##__VA_ARGS__)
> 
> #define bt_dev_info(hdev, fmt, ...)				\
> 	BT_INFO("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
> +#define bt_dev_warn(hdev, fmt, ...)				\
> +	BT_WARN("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
> #define bt_dev_err(hdev, fmt, ...)				\
> 	BT_ERR("%s: " fmt, (hdev)->name, ##__VA_ARGS__)
> #define bt_dev_dbg(hdev, fmt, ...)				\

Regards

Marcel

