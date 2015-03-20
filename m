Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v3] Bluetooth: expose quirks through debugfs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426875290-6622-1-git-send-email-jpawlowski@google.com>
Date: Fri, 20 Mar 2015 11:50:42 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B29B2C1F-A11E-4C75-9EE8-79A098B613A3@holtmann.org>
References: <1426875290-6622-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> This patch expose controller quirks through debugfs. It would be
> useful for BlueZ tests using vhci. Currently there is no way to
> test quirk dependent behaviour. It might be also useful for manual
> testing.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> net/bluetooth/hci_debugfs.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 59 insertions(+)
> 
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index 0818fab..466c3be 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -28,6 +28,54 @@
> 
> #include "hci_debugfs.h"
> 
> +#define DEFINE_QUIRK_ATTRIBUTE(__name, __quirk)				      \
> +static ssize_t __name ## _read(struct file *file,			      \
> +				char __user *user_buf,			      \
> +				size_t count, loff_t *ppos)		      \
> +{									      \
> +	struct hci_dev *hdev = file->private_data;			      \
> +	char buf[3];							      \
> +									      \
> +	buf[0] = test_bit(__quirk, &hdev->quirks) ? 'Y' : 'N';		      \
> +	buf[1] = '\n';							      \
> +	buf[2] = '\0';							      \
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);	      \
> +}									      \
> +									      \
> +static ssize_t __name ## _write(struct file *file,			      \
> +				 const char __user *user_buf,		      \
> +				 size_t count, loff_t *ppos)		      \
> +{									      \
> +	struct hci_dev *hdev = file->private_data;			      \
> +	char buf[32];							      \
> +	size_t buf_size = min(count, (sizeof(buf) - 1));		      \
> +	bool enable;							      \
> +									      \
> +	if (test_bit(HCI_UP, &hdev->flags))				      \
> +		return -EBUSY;						      \
> +									      \
> +	if (copy_from_user(buf, user_buf, buf_size))			      \
> +		return -EFAULT;						      \
> +									      \
> +	buf[buf_size] = '\0';						      \
> +	if (strtobool(buf, &enable))					      \
> +		return -EINVAL;						      \
> +									      \
> +	if (enable == test_bit(__quirk, &hdev->quirks))			      \
> +		return -EALREADY;					      \
> +									      \
> +	change_bit(__quirk, &hdev->quirks);				      \
> +									      \
> +	return count;							      \
> +}									      \
> +									      \
> +static const struct file_operations __name ## _fops = {			      \
> +	.open		= simple_open,					      \
> +	.read		= __name ## _read,				      \
> +	.write		= __name ## _write,				      \
> +	.llseek		= default_llseek,				      \
> +}									      \
> +
> static int features_show(struct seq_file *f, void *ptr)
> {
> 	struct hci_dev *hdev = f->private;
> @@ -277,6 +325,11 @@ static const struct file_operations sc_only_mode_fops = {
> 	.llseek		= default_llseek,
> };
> 
> +DEFINE_QUIRK_ATTRIBUTE(quirk_strict_duplicate_filter,
> +		       HCI_QUIRK_STRICT_DUPLICATE_FILTER);
> +DEFINE_QUIRK_ATTRIBUTE(quirk_simulteanous_discovery,
> +		       HCI_QUIRK_SIMULTANEOUS_DISCOVERY);
> +
> void hci_debugfs_create_common(struct hci_dev *hdev)
> {
> 	debugfs_create_file("features", 0444, hdev->debugfs, hdev,
> @@ -308,6 +361,12 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
> 	if (lmp_sc_capable(hdev) || lmp_le_capable(hdev))
> 		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
> 				    hdev, &sc_only_mode_fops);
> +	debugfs_create_file("quirk_strict_duplicate_filter", 0644,
> +			    hdev->debugfs, hdev,
> +			    &quirk_strict_duplicate_filter_fops);
> +	debugfs_create_file("quirk_simulteanous_discovery", 0644,
> +			    hdev->debugfs, hdev,
> +			    &quirk_simulteanous_discovery_fops);
> }

actually these are LE quirks and not common ones. Exposing them on BR/EDR only controllers makes no sense. I missed that one the first time around. I was going to mention it, but then I forgot.

You also misspelled the word simultaneous.

Since these two are so easy fixes, I just applied your patch to bluetooth-next and amended it. There was really no point in making you sending this again.

Regards

Marcel

