Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH v8 5/5] Bluetooth: Manually enable or disable 6LoWPAN between devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1386689689-26550-6-git-send-email-jukka.rissanen@linux.intel.com>
Date: Wed, 11 Dec 2013 02:08:21 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <C2B7F81D-56D9-45D6-B1F4-DEABE726A56E@holtmann.org>
References: <1386689689-26550-1-git-send-email-jukka.rissanen@linux.intel.com> <1386689689-26550-6-git-send-email-jukka.rissanen@linux.intel.com>
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
> echo Y > /sys/kernel/debug/bluetooth/hci0/6lowpan
> 
> This enables 6LoWPAN support and creates the bt0 interface
> automatically when devices are finally connected.
> 
> Rebooting or unloading the bluetooth kernel module will also clear the
> settings from the kernel.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> net/bluetooth/hci_core.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 88 insertions(+)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8b8b5f8..924b87a 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -636,6 +636,92 @@ static int conn_max_interval_get(void *data, u64 *val)
> DEFINE_SIMPLE_ATTRIBUTE(conn_max_interval_fops, conn_max_interval_get,
> 			conn_max_interval_set, "%llu\n");
> 
> +static LIST_HEAD(lowpan_user_enabled);
> +static DEFINE_RWLOCK(lowpan_enabled_lock);
> +
> +struct lowpan_enabled {
> +	__u16 dev_id;
> +	bool enabled;
> +	struct list_head list;
> +};

I still do not get why we need this.

> +
> +static ssize_t lowpan_read(struct file *file, char __user *user_buf,
> +			   size_t count, loff_t *ppos)
> +{
> +	struct hci_dev *hdev = file->private_data;
> +	char buf[3];
> +
> +	buf[0] = test_bit(HCI_6LOWPAN_ENABLED, &hdev->dev_flags) ? 'Y': 'N';
> +	buf[1] = '\n';
> +	buf[2] = '\0';
> +	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
> +}
> +
> +static ssize_t lowpan_write(struct file *fp, const char __user *user_buffer,
> +			    size_t count, loff_t *position)
> +{
> +	struct hci_dev *hdev = fp->private_data;
> +	struct lowpan_enabled *entry = NULL, *tmp;
> +	bool new_value, old_value;
> +	char buf[32];
> +	size_t buf_size = min(count, (sizeof(buf)-1));
> +	ssize_t ret;
> +
> +	BT_DBG("dev %s count %zd", hdev->dev_name, count);
> +
> +	if (copy_from_user(buf, user_buffer, buf_size))
> +		return -EFAULT;
> +
> +	buf[buf_size] = '\0';
> +
> +	if (strtobool(buf, &new_value) < 0)
> +		return -EINVAL;
> +
> +	ret = -ENOENT;
> +
> +	write_lock(&lowpan_enabled_lock);
> +	list_for_each_entry_safe(entry, tmp, &lowpan_user_enabled, list) {
> +		if (entry->dev_id == hdev->id) {
> +			old_value = entry->enabled;
> +			entry->enabled = new_value;
> +			ret = 0;
> +			break;
> +		}
> +	}
> +	write_unlock(&lowpan_enabled_lock);
> +
> +	if (ret == 0 && old_value == new_value)
> +		return count;
> +
> +	if (ret < 0) {
> +		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +		if (!entry)
> +			return -ENOMEM;
> +
> +		entry->dev_id = hdev->id;
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

Why not just set or clear the HCI_6LOWPAN_ENABLED bit and be done with it.

Especially since the current code leaks memory. I do not see any function freeing it. Do I miss something so obvious here?

> +
> +	return count;
> +}
> +
> +static const struct file_operations lowpan_debugfs_fops = {
> +	.open		= simple_open,
> +	.read		= lowpan_read,
> +	.write		= lowpan_write,
> +	.llseek		= default_llseek,
> +};
> +
> /* ---- HCI requests ---- */
> 
> static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
> @@ -1406,6 +1492,8 @@ static int __hci_init(struct hci_dev *hdev)
> 				    hdev, &conn_min_interval_fops);
> 		debugfs_create_file("conn_max_interval", 0644, hdev->debugfs,
> 				    hdev, &conn_max_interval_fops);
> +		debugfs_create_file("6lowpan", 0644, hdev->debugfs, hdev,
> +				    &lowpan_debugfs_fops);
> 	}

Regards

Marcel

