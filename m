Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH v7 5/5] Bluetooth: Manually enable or disable 6LoWPAN between devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1386675457-26024-6-git-send-email-jukka.rissanen@linux.intel.com>
Date: Tue, 10 Dec 2013 12:55:17 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <1B35DC15-DDEE-42A0-80CE-9F1310BF9044@holtmann.org>
References: <1386675457-26024-1-git-send-email-jukka.rissanen@linux.intel.com> <1386675457-26024-6-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> This is a temporary patch where user can manually enable or
> disable BT 6LoWPAN functionality between devices.
> Eventually the connection is established automatically if
> the devices are advertising suitable capability and this patch
> can be removed.
> 
> Before connecting the devices do this
> 
> echo 1 > /sys/kernel/debug/bluetooth/hci0/6lowpan
> 
> This enables 6LoWPAN support and creates the bt0 interface
> automatically when devices are finally connected.
> 
> Rebooting or unloading the bluetooth kernel module will also clear the
> settings from the kernel.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> net/bluetooth/hci_core.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 93 insertions(+)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8b8b5f8..e289072 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -636,6 +636,97 @@ static int conn_max_interval_get(void *data, u64 *val)
> DEFINE_SIMPLE_ATTRIBUTE(conn_max_interval_fops, conn_max_interval_get,
> 			conn_max_interval_set, "%llu\n");
> 
> +static LIST_HEAD(lowpan_user_enabled);
> +static DEFINE_RWLOCK(lowpan_enabled_lock);
> +
> +struct lowpan_enabled {
> +	__u8 dev_name[HCI_MAX_NAME_LENGTH];
> +	bool enabled;
> +	struct list_head list;
> +};
> +
> +static int lowpan_debugfs_show(struct seq_file *f, void *p)
> +{
> +	struct hci_dev *hdev = f->private;
> +
> +	if (test_bit(HCI_6LOWPAN_ENABLED, &hdev->dev_flags))
> +		seq_printf(f, "1\n");
> +	else
> +		seq_printf(f, "0\n");
> +
> +	return 0;
> +}

I think we should do Y and N here. Check how I implemented dut_mode. No need to use seq_printf here.

> +
> +static int lowpan_debugfs_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, lowpan_debugfs_show, inode->i_private);
> +}
> +
> +static ssize_t lowpan_writer(struct file *fp, const char __user *user_buffer,
> +			     size_t count, loff_t *position)
> +{
> +	struct hci_dev *hdev = fp->f_inode->i_private;
> +	struct lowpan_enabled *entry = NULL, *tmp;
> +	bool new_value, old_value;
> +	char buf[3] = { 0 };
> +	ssize_t ret;
> +
> +	BT_DBG("dev %s count %zd", hdev->dev_name, count);
> +
> +        ret = simple_write_to_buffer(buf, 2, position, user_buffer, count);

Spaces?

> +	if (ret <= 0)
> +		return ret;
> +
> +	if (strtobool(buf, &new_value) < 0)
> +		return -EINVAL;
> +
> +	ret = -ENOENT;
> +
> +	write_lock(&lowpan_enabled_lock);
> +	list_for_each_entry_safe(entry, tmp, &lowpan_user_enabled, list) {
> +		if (!strncmp(entry->dev_name, hdev->dev_name,
> +						HCI_MAX_NAME_LENGTH)) {
> +			old_value = entry->enabled;
> +			entry->enabled = new_value;
> +			ret = 0;
> +			break;
> +		}
> +	}
> +	write_unlock(&lowpan_enabled_lock);

Why are we testing the dev_name here and not dev_id?

> +
> +	if (ret == 0 && old_value == new_value)
> +		return count;
> +
> +	if (ret < 0) {
> +		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +		if (!entry)
> +			return -ENOMEM;
> +
> +		strncpy(entry->dev_name, hdev->dev_name, HCI_MAX_NAME_LENGTH);
> +		entry->enabled = new_value;
> +
> +		write_lock(&lowpan_enabled_lock);
> +		INIT_LIST_HEAD(&entry->list);
> +		list_add(&entry->list, &lowpan_user_enabled);
> +		write_unlock(&lowpan_enabled_lock);
> +	}
> +
> +	if (new_value == true)
> +		set_bit(HCI_6LOWPAN_ENABLED, &hdev->dev_flags);
> +	else
> +		clear_bit(HCI_6LOWPAN_ENABLED, &hdev->dev_flags);

I might be just missing something here, but do we need to track the list of enabled HCI controllers twice. The core tracks the controller list. We can just enumerate over it and flip the bit, right?

> +
> +	return count;
> +}
> +
> +static const struct file_operations lowpan_debugfs_fops = {
> +	.open		= lowpan_debugfs_open,
> +	.read		= seq_read,
> +	.write		= lowpan_writer,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> /* ---- HCI requests ---- */
> 
> static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
> @@ -1406,6 +1497,8 @@ static int __hci_init(struct hci_dev *hdev)
> 				    hdev, &conn_min_interval_fops);
> 		debugfs_create_file("conn_max_interval", 0644, hdev->debugfs,
> 				    hdev, &conn_max_interval_fops);
> +		debugfs_create_file("6lowpan", 0644, hdev->debugfs, hdev,
> +				    &lowpan_debugfs_fops);
> 	}

Regards

Marcel

