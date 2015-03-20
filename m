Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH v1] Bluetooth: add macro for exposing quirks
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426742499-14185-1-git-send-email-jpawlowski@google.com>
Date: Thu, 19 Mar 2015 18:59:03 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <89BCCE0D-8AB7-464D-A904-207FEDC2AE2B@holtmann.org>
References: <1426742499-14185-1-git-send-email-jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

> This patch adds macro for exposing quirks through debugfs. Exposing
> quirks would be useful for making quirk dependent BlueZ tests using
> vhci. Currently there is no way to test that. It might be also
> useful for manual testing.
> 
> This patch also uses this macro to expose first two quirks.
> 
> Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
> ---
> net/bluetooth/hci_debugfs.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 44 insertions(+)
> 
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index 0818fab..fd39422 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -28,6 +28,43 @@
> 
> #include "hci_debugfs.h"
> 
> +#define DEFINE_QUIRK_ATTRIBUTE(ATTRIBUTE_NAME, QUIRK_NAME)		      \
> +static int QUIRK_NAME##_set(void *data, u64 val)			      \
> +{									      \
> +	struct hci_dev *hdev = data;					      \
> +									      \
> +	if (val != 0 && val != 1)					      \
> +		return -EINVAL;						      \
> +									      \
> +	/* don't modify quirk if controller is powered */		      \
> +	if (hdev_is_powered(hdev)) {					      \
> +		BT_ERR("Cannot modify quirk when controller is powered");     \
> +		return -EINVAL;						      \
> +	}								      \
> +									      \
> +	hci_dev_lock(hdev);						      \
> +	if (val == 0)							      \
> +		clear_bit(QUIRK_NAME, &hdev->quirks);			      \
> +	else								      \
> +		set_bit(QUIRK_NAME, &hdev->quirks);			      \
> +									      \
> +	hci_dev_unlock(hdev);						      \
> +	return 0;							      \
> +}									      \
> +									      \
> +static int QUIRK_NAME##_get(void *data, u64 *val)			      \
> +{									      \
> +	struct hci_dev *hdev = data;					      \
> +									      \
> +	hci_dev_lock(hdev);						      \
> +	*val = test_bit(QUIRK_NAME, &hdev->quirks);			      \
> +	hci_dev_unlock(hdev);						      \
> +	return 0;							      \
> +}									      \
> +									      \
> +DEFINE_SIMPLE_ATTRIBUTE(ATTRIBUTE_NAME, QUIRK_NAME##_get,		      \
> +			QUIRK_NAME##_set, "%llu\n")			      \
> +

so I would actually prefer if we use struct file_operations here and also use strtobool. Something similar to what we are doing for force_static_address and other fields.

Then you will also see that we are using HCI_UP to even prevent this when using legacy ioctl and power up a controller via hciconfig hci0 up.

> static int features_show(struct seq_file *f, void *ptr)
> {
> 	struct hci_dev *hdev = f->private;
> @@ -277,6 +314,9 @@ static const struct file_operations sc_only_mode_fops = {
> 	.llseek		= default_llseek,
> };
> 
> +DEFINE_QUIRK_ATTRIBUTE(hci_quirk_sdf_fops, HCI_QUIRK_STRICT_DUPLICATE_FILTER);
> +DEFINE_QUIRK_ATTRIBUTE(hci_quirk_sd_fops, HCI_QUIRK_SIMULTANEOUS_DISCOVERY);
> +

I had to think hard what sdf and sd stands for. That is so no intuitive

So what I would do is expose with simpler names like for example quirk_strict_duplicate_filter_ops and quirk_simultaneous_discovery_ops. That way it is pretty much in line with what we do for all the other debugfs entries. If these names are too long, then we have too see what we can do about it.

void hci_debugfs_create_common(struct hci_dev *hdev)
> {
> 	debugfs_create_file("features", 0444, hdev->debugfs, hdev,
> @@ -308,6 +348,10 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
> 	if (lmp_sc_capable(hdev) || lmp_le_capable(hdev))
> 		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
> 				    hdev, &sc_only_mode_fops);
> +	debugfs_create_file("HCI_QUIRK_STRICT_DUPLICATE_FILTER", 0644,
> +			    hdev->debugfs, hdev, &hci_quirk_sdf_fops);
> +	debugfs_create_file("HCI_QUIRK_SIMULTANEOUS_DISCOVERY", 0644,
> +			    hdev->debugfs, hdev, &hci_quirk_sd_fops);

The debugfs file entry is something that I expect to be "quirk_strict_duplicate_filter". And not an all uppercase "shouting" file.

Regards

Marcel

