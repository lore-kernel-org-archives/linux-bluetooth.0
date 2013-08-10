Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [PATCH 3/6] Bluetooth: Set discovery parameters
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1376089954-13639-4-git-send-email-andre.guedes@openbossa.org>
Date: Sat, 10 Aug 2013 09:09:27 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <FE070485-AC61-4229-851F-9537CA50AB99@holtmann.org>
References: <1376089954-13639-1-git-send-email-andre.guedes@openbossa.org> <1376089954-13639-4-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds support for setting discovery parameters through
> debugfs filesystem.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_sysfs.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 90cb53b..17ebc4a 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -553,9 +553,52 @@ static int discovery_parameters_open(struct inode *inode, struct file *file)
> 	return single_open(file, discovery_parameters_show, inode->i_private);
> }
> 
> +static ssize_t discovery_parameters_write(struct file *file,
> +					  const char __user *data,
> +					  size_t count, loff_t *offset)
> +{
> +	struct seq_file *sfile = file->private_data;
> +	struct hci_dev *hdev = sfile->private;
> +	struct discovery_param param;
> +	char *buf;
> +	int n;
> +	ssize_t res = 0;
> +
> +	/* We don't allow partial writes */
> +	if (*offset != 0)
> +		return 0;
> +
> +	buf = kzalloc(count, GFP_KERNEL);
> +	if (!buf)
> +		return 0;
> +
> +	if (copy_from_user(buf, data, count))
> +		goto out;
> +
> +	memset(&param, 0, sizeof(param));
> +
> +	n = sscanf(buf, "%hhx %hx %hx %u %u %hhx %hhx",
> +		   &param.scan_type, &param.scan_interval, &param.scan_window,
> +		   &param.le_scan_duration, &param.interleaved_scan_duration,
> +		   &param.interleaved_inquiry_length,
> +		   &param.bredr_inquiry_length);

I am not a huge fan of this crazy. I need a manual to know exactly what to do here. That is just silly. Unless things are a bit self-explanatory on how you can tweak things, I am not really interested here.

Also intermixing LE with BR/EDR is a bit pointless here. I would prefer if they are separate and not that BR/EDR only controller exports LE knobs and and LE only controller exports BR/EDR knobs.

Regards

Marcel

