Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: expose quirks through debugfs
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1426657742-13963-1-git-send-email-jpawlowski@google.com>
Date: Wed, 18 Mar 2015 00:36:26 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A161469C-895B-40AC-A81F-5B7F2A59DABF@holtmann.org>
References: <1426657742-13963-1-git-send-email-jpawlowski@google.com>
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
> include/net/bluetooth/hci.h |  2 ++
> net/bluetooth/hci_debugfs.c | 29 +++++++++++++++++++++++++++++
> 2 files changed, 31 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 06e7eee..e9cec98 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -168,6 +168,8 @@ enum {
> 	 * during the hdev->setup vendor callback.
> 	 */
> 	HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
> +
> +	__HCI_NUM_QUIRKS
> };
> 
> /* HCI device flags */
> diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
> index 0818fab..0011d1e 100644
> --- a/net/bluetooth/hci_debugfs.c
> +++ b/net/bluetooth/hci_debugfs.c
> @@ -277,6 +277,33 @@ static const struct file_operations sc_only_mode_fops = {
> 	.llseek		= default_llseek,
> };
> 
> +static int quirks_set(void *data, u64 val)
> +{
> +	struct hci_dev *hdev = data;
> +
> +	if (val >= (1 << __HCI_NUM_QUIRKS))
> +		return -EINVAL;
> +
> +	hci_dev_lock(hdev);
> +	hdev->quirks = val;
> +	hci_dev_unlock(hdev);
> +
> +	return 0;
> +}
> +
> +static int quirks_get(void *data, u64 *val)
> +{
> +	struct hci_dev *hdev = data;
> +
> +	hci_dev_lock(hdev);
> +	*val = hdev->quirks;
> +	hci_dev_unlock(hdev);
> +
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(quirks_fops, quirks_get, quirks_set, "%llu\n");
> +
> void hci_debugfs_create_common(struct hci_dev *hdev)
> {
> 	debugfs_create_file("features", 0444, hdev->debugfs, hdev,
> @@ -308,6 +335,8 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
> 	if (lmp_sc_capable(hdev) || lmp_le_capable(hdev))
> 		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
> 				    hdev, &sc_only_mode_fops);
> +
> +	debugfs_create_file("quirks", 0644, hdev->debugfs, hdev, &quirks_fops);
> }

actually I do not like this solution. It is way too hackish since not all quirks are equal. Some of them can actually not be applied later on and some really need to be provided during hdev->setup. So I think we should focus on the ones that actually can change behavior at runtime.

So first of all, I think all quirk modifications need to be limited to when the controller is powered down. Doing this at runtime when the controller is doing actual HCI transaction is dangerous. It will cause state confusing and race conditions. I am not prepared at all to debug any of these.

Second we should have separate boolean debugfs entries for each quirk that is actually applicable. That makes it really easy to pick the right one without knowing all the magic bit positions.

I mean the goal should be that a user can go in and test if a quirk is causing a problem or if quirk might work. That way we can have people test stuff without asking them recompile the kernel. However they need to be able easily identify the quirk and echo its activation or deactivation into it.

Regards

Marcel

