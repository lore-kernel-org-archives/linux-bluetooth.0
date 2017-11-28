Return-Path: <netdev-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v2 1/2] seq_file: Introduce DEFINE_SHOW_ATTRIBUTE() helper
 macro
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171123203605.44954-2-andriy.shevchenko@linux.intel.com>
Date: Tue, 28 Nov 2017 09:43:43 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Message-Id: <F129B4E0-91B1-4B7B-AF5D-A5EA29486A6E@holtmann.org>
References: <20171123203605.44954-1-andriy.shevchenko@linux.intel.com>
 <20171123203605.44954-2-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

> The DEFINE_SHOW_ATTRIBUTE() helper macro would be useful for current
> users, which are many of them, and for new comers to decrease code
> duplication.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> include/linux/seq_file.h | 13 +++++++++++++
> 1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> index c32929802c25..73adc12ab773 100644
> --- a/include/linux/seq_file.h
> +++ b/include/linux/seq_file.h
> @@ -144,6 +144,19 @@ void *__seq_open_private(struct file *, const struct seq_operations *, int);
> int seq_open_private(struct file *, const struct seq_operations *, int);
> int seq_release_private(struct inode *, struct file *);
> 
> +#define DEFINE_SHOW_ATTRIBUTE(__name)					      \
> +static int __name ## _open(struct inode *inode, struct file *file)	      \
> +{									      \
> +	return single_open(file, __name ## _show, inode->i_private);	      \
> +}									      \
> +									      \
> +static const struct file_operations __name ## _fops = {			      \
> +	.open		= __name ## _open,				      \
> +	.read		= seq_read,					      \
> +	.llseek		= seq_lseek,					      \
> +	.release	= single_release,				      \
> +}									      \
> +

can we define this in hci_debugfs.c first and get that patch merged into bluetooth-next. And only as a follow up patch try to generalize this in seq_file.h. I really don’t like to carry a patch for seq_file.h in the bluetooth-next tree.

Regards

Marcel
