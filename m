Return-Path: <cyrus@holtmann.org>
Message-ID: <1416404595.9374.4.camel@sipsolutions.net>
Subject: Re: [PATCH] Bluetooth: btmrvl add firmware dump support
From: Johannes Berg <johannes@sipsolutions.net>
To: Amitkumar Karwar <akarwar@marvell.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, Xinming Hu
	 <huxm@marvell.com>, Cathy Luo <cluo@marvell.com>, Avinash Patil
	 <patila@marvell.com>
Date: Wed, 19 Nov 2014 14:43:15 +0100
In-Reply-To: <1416403887-9271-1-git-send-email-akarwar@marvell.com>
References: <1416403887-9271-1-git-send-email-akarwar@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2014-11-19 at 05:31 -0800, Amitkumar Karwar wrote:

> +static ssize_t btmrvl_fwdump_read(struct file *file, char __user *userbuf,
> +				  size_t count, loff_t *ppos)
> +{
> +	struct btmrvl_private *priv = file->private_data;
> +	ssize_t ret = 0;
> +
> +	btmrvl_firmware_dump(priv);

Might be better to do that on write.


> +		fw_dump_len += (strlen("========Start dump ") +
> +				strlen(entry->mem_name) +
> +				strlen("========\n") +
> +				(memory_size + 1) +
> +				strlen("\n========End dump========\n"));

I'd consider a binary file format.

You also need the select in the Kconfig as I pointed out before.

The more intended use case for this was to trigger it when the driver
detected a crash, but I guess a debugfs file works as well, just not
sure when you'd want it.

johannes
