Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [RFC 5/5] Bluetooth: Manually enable or disable 6LoWPAN between devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1382511164-1989-6-git-send-email-jukka.rissanen@linux.intel.com>
Date: Wed, 23 Oct 2013 14:09:29 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8DA477A4-B5C7-4CE2-8929-3AE3DBD10744@holtmann.org>
References: <1382511164-1989-1-git-send-email-jukka.rissanen@linux.intel.com> <1382511164-1989-6-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> This is a temporary patch where user can manually enable or
> disable BT LE 6LoWPAN functionality between devices.
> Eventually the connection is established automatically if
> the devices are advertising suitable capability and this patch
> can be removed.
> 
> If you have two devices with these BT addresses
>        device1  00:11:22:33:44:55
>        device2  66:77:88:99:00:11
> 
> First add the desired devices manually into kernel
> 
> root@dev1# echo 66:77:88:99:00:11 > /sys/kernel/debug/bluetooth/hci0/ble6lowpan
> root@dev2# echo 00:11:22:33:44:55 > /sys/kernel/debug/bluetooth/hci0/ble6lowpan
> 
> then connect the devices
> 
> root@dev1# hciconfig hci0 leadv
> root@dev2# hcitool lecc 00:11:22:33:44:55
> 
> if the connection is established, then you can send IPv6 packets
> between these two systems using the link local addresses
> 
> root@dev1# ping6 fe80::6477:88ff:fe99:0011
> root@dev2# ping6 fe80::211:22ff:fe33:4455
> 
> By default 6LoWPAN connection is not established between devices,
> so you need to add the MAC addresses manually into the
> /sys/kernel/debug/bluetooth/hci0/ble6lowpan file.
> If you want to prevent further connections you can remove
> MAC address from the debugfs file like this
> echo "00:11:22:33:44:55 d" > /sys/kernel/debug/bluetooth/hci0/ble6lowpan
> Rebooting or unloading the bluetooth kernel module will also clear the
> settings from the kernel.
> ---
> net/bluetooth/ble_6lowpan.c | 164 ++++++++++++++++++++++++++++++++++++++++++++
> net/bluetooth/ble_6lowpan.h |   1 +
> net/bluetooth/hci_core.c    |   4 ++
> net/bluetooth/l2cap_core.c  |  12 ++--
> 4 files changed, 174 insertions(+), 7 deletions(-)
> 
> diff --git a/net/bluetooth/ble_6lowpan.c b/net/bluetooth/ble_6lowpan.c
> index 44d65b3..0baf211 100644
> --- a/net/bluetooth/ble_6lowpan.c
> +++ b/net/bluetooth/ble_6lowpan.c
> @@ -12,6 +12,7 @@
> */
> 
> #include <linux/version.h>
> +#include <linux/debugfs.h>
> #include <linux/bitops.h>
> #include <linux/if_arp.h>
> #include <linux/netdevice.h>
> @@ -1535,6 +1536,169 @@ static struct notifier_block ble_6lowpan_dev_notifier = {
> 	.notifier_call = ble_6lowpan_device_event,
> };
> 
> +static LIST_HEAD(user_enabled);
> +DEFINE_RWLOCK(user_enabled_list_lock);
> +
> +struct ble_6lowpan_enabled {
> +	__u8 dev_name[HCI_MAX_NAME_LENGTH];
> +	bdaddr_t addr;
> +	struct list_head list;
> +};
> +
> +bool ble_6lowpan_is_enabled(struct hci_dev *hdev, bdaddr_t *dst)
> +{
> +	struct ble_6lowpan_enabled *entry, *tmp;
> +	bool found = false;
> +
> +	write_lock(&user_enabled_list_lock);
> +	list_for_each_entry_safe(entry, tmp, &user_enabled, list) {
> +		if (!strncmp(entry->dev_name, hdev->dev_name,
> +				HCI_MAX_NAME_LENGTH) &&
> +				!bacmp(dst, &entry->addr)) {
> +			found = true;
> +			break;
> +		}
> +	}
> +	write_unlock(&user_enabled_list_lock);
> +
> +	/* Check also the device list just in case we removed the
> +	 * device from debugfs before disconnecting.
> +	 */
> +	if (!found) {
> +		struct ble_6lowpan_dev_record *entry, *tmp;
> +		struct ble_6lowpan_dev_info *info;
> +
> +		write_lock(&net_dev_list_lock);
> +		list_for_each_entry_safe(entry, tmp,
> +					&ble_6lowpan_devices,
> +					list) {
> +			info = ble_6lowpan_dev_info(entry->dev);
> +			if (info->conn->hcon->hdev == hdev &&
> +						!bacmp(&info->addr, dst)) {
> +				found = true;
> +				break;
> +			}
> +		}
> +		write_unlock(&net_dev_list_lock);
> +	}
> +
> +	return found;
> +}
> +
> +static int ble_6lowpan_debugfs_show(struct seq_file *f, void *p)
> +{
> +	struct ble_6lowpan_enabled *entry, *tmp;
> +
> +	write_lock(&user_enabled_list_lock);
> +	list_for_each_entry_safe(entry, tmp, &user_enabled, list)
> +		seq_printf(f, "%pMR\n", &entry->addr);
> +
> +	write_unlock(&user_enabled_list_lock);
> +
> +	return 0;
> +}
> +
> +static int ble_6lowpan_debugfs_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, ble_6lowpan_debugfs_show, inode->i_private);
> +}
> +
> +static ssize_t ble_6lowpan_writer(struct file *fp,
> +				const char __user *user_buffer,
> +                                size_t count, loff_t *position)
> +{
> +#define MAC_STR_LEN 17
> +	char mac_buf[MAC_STR_LEN + 1];
> +	ssize_t ret;
> +	bool delete_mode = false;
> +
> +        if(count > (MAC_STR_LEN + 1))
> +		delete_mode = true;
> +	else if (count < MAC_STR_LEN)
> +		return count;
> +
> +	BT_DBG("count %zd mode %d", count, delete_mode);
> +
> +	memset(mac_buf, 0, MAC_STR_LEN + 1);
> +        ret = simple_write_to_buffer(mac_buf, MAC_STR_LEN, position,
> +							user_buffer, count);
> +	if (ret > 0) {

You need to get rid of this nesting. 

	if (ret < 0)
		return ret;

> +		struct ble_6lowpan_enabled *entry = NULL, *tmp;
> +		bdaddr_t bdaddr;
> +
> +		if (sscanf(mac_buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx",
> +				&bdaddr.b[5], &bdaddr.b[4],
> +				&bdaddr.b[3], &bdaddr.b[2],
> +				&bdaddr.b[1], &bdaddr.b[0]) != 6)
> +			return -EINVAL;
> +
> +		BT_DBG("user %pMR", &bdaddr);
> +
> +		write_lock(&user_enabled_list_lock);
> +		list_for_each_entry_safe(entry, tmp, &user_enabled, list) {
> +			if (!bacmp(&entry->addr, &bdaddr)) {
> +				struct hci_dev *hdev = fp->f_inode->i_private;
> +
> +				if (!strncmp(entry->dev_name, hdev->dev_name,
> +						HCI_MAX_NAME_LENGTH) &&
> +								delete_mode) {
> +					break;
> +				} else {
> +					ret = -EEXIST;
> +					break;
> +				}
> +			}
> +		}
> +		write_unlock(&user_enabled_list_lock);
> +
> +		if (ret > 0) {

And here as well. If you keep nesting, you cramp everything into 20 characters and it becomes unreadable.

> +			struct hci_dev *hdev = fp->f_inode->i_private;
> +
> +			if (delete_mode) {
> +				write_lock(&user_enabled_list_lock);
> +				list_del(&entry->list);
> +				kfree(entry);
> +				write_unlock(&user_enabled_list_lock);
> +			} else {
> +				entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> +				if (!entry)
> +					return -ENOMEM;
> +
> +				strncpy(entry->dev_name, hdev->dev_name,
> +					HCI_MAX_NAME_LENGTH);
> +				entry->addr = bdaddr;
> +
> +				write_lock(&user_enabled_list_lock);
> +				INIT_LIST_HEAD(&entry->list);
> +				list_add(&entry->list, &user_enabled);
> +				write_unlock(&user_enabled_list_lock);
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static const struct file_operations ble_6lowpan_debugfs_fops = {
> +	.open		= ble_6lowpan_debugfs_open,
> +	.read		= seq_read,
> +	.write		= ble_6lowpan_writer,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static struct dentry *ble_6lowpan_debugfs;
> +
> +void ble_6lowpan_add_debugfs(struct hci_dev *hdev)
> +{
> +	if (hdev->debugfs) {

	if (!hdev->debugs)
		return;

> +		ble_6lowpan_debugfs = debugfs_create_file("ble6lowpan", 0644,

Use 6lowpan as name.

> +			hdev->debugfs, hdev, &ble_6lowpan_debugfs_fops);
> +		if (!ble_6lowpan_debugfs)
> +			BT_ERR("Failed to create 6LoWPAN debug file");

Don't bother with an error code here. We removed all of these. They are pointless and debugfs failures are not really failures.

> +	}
> +}
> +
> int ble_6lowpan_init(void)
> {
> 	int err;
> diff --git a/net/bluetooth/ble_6lowpan.h b/net/bluetooth/ble_6lowpan.h
> index 7975a55..047b8b7 100644
> --- a/net/bluetooth/ble_6lowpan.h
> +++ b/net/bluetooth/ble_6lowpan.h
> @@ -23,5 +23,6 @@ int ble_6lowpan_del_conn(struct l2cap_conn *conn);
> int ble_6lowpan_init(void);
> void ble_6lowpan_cleanup(void);
> bool ble_6lowpan_is_enabled(struct hci_dev *hdev, bdaddr_t *dst);
> +void ble_6lowpan_add_debugfs(struct hci_dev *hdev);
> 
> #endif /* __BLE_LOWPAN_H */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 6ccc4eb..d0db818 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -34,6 +34,8 @@
> #include <net/bluetooth/bluetooth.h>
> #include <net/bluetooth/hci_core.h>
> 
> +#include "ble_6lowpan.h"
> +
> static void hci_rx_work(struct work_struct *work);
> static void hci_cmd_work(struct work_struct *work);
> static void hci_tx_work(struct work_struct *work);
> @@ -1406,6 +1408,8 @@ static int __hci_init(struct hci_dev *hdev)
> 				    hdev, &conn_max_interval_fops);
> 	}
> 
> +	ble_6lowpan_add_debugfs(hdev);
> +
> 	return 0;
> }

I wonder if the list of enabled IPv6 devices should be actually part of hci_core.c. And we just have functions for it to call it. At the end of the day, we might just have a UUID in the advertising data and that will be in hci_core.c anyway.

> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index fb1a49c..e3b30dd 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -6542,11 +6542,6 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
> 	return exact ? lm1 : lm2;
> }
> 
> -static bool is_ble_6lowpan(void)
> -{
> -	return false;
> -}
> -
> void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
> {
> 	struct l2cap_conn *conn;
> @@ -6558,7 +6553,9 @@ void l2cap_connect_cfm(struct hci_conn *hcon, u8 status)
> 		if (conn) {
> 			l2cap_conn_ready(conn);
> 
> -			if (hcon->type == LE_LINK && is_ble_6lowpan())
> +			if (hcon->type == LE_LINK &&
> +					ble_6lowpan_is_enabled(hcon->hdev,
> +								&hcon->dst))
> 				ble_6lowpan_add_conn(conn);
> 		}

We have an l2cap_le_conn_ready function just for LE GATT. Maybe that should be used instead.

> 	} else {
> @@ -6581,7 +6578,8 @@ void l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
> {
> 	BT_DBG("hcon %p reason %d", hcon, reason);
> 
> -	if (hcon->type == LE_LINK && is_ble_6lowpan())
> +	if (hcon->type == LE_LINK && ble_6lowpan_is_enabled(hcon->hdev,
> +							&hcon->dst))
> 		ble_6lowpan_del_conn(hcon->l2cap_data);
> 
> 	l2cap_conn_del(hcon, bt_to_errno(reason));

Regards

Marcel

