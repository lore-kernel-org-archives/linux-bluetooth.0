Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v5 5/5] Bluetooth: 6LoWPAN: Remove network devices when unloading
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401721227-28439-6-git-send-email-jukka.rissanen@linux.intel.com>
Date: Tue, 3 Jun 2014 06:00:14 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C34E55F5-1E93-4AF5-82A5-7415974B0731@holtmann.org>
References: <1401721227-28439-1-git-send-email-jukka.rissanen@linux.intel.com> <1401721227-28439-6-git-send-email-jukka.rissanen@linux.intel.com>
To: Jukka Rissanen <jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jukka,

> When the module is unloaded, unregister the network device
> so that the system does not try to access non-existing device.
> 
> Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
> ---
> net/bluetooth/6lowpan.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 47 insertions(+)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index 90c64da..b2d1139 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -598,6 +598,17 @@ static void ifup(struct net_device *netdev)
> 	rtnl_unlock();
> }
> 
> +static void ifdown(struct net_device *netdev)
> +{
> +	int err;
> +
> +	rtnl_lock();
> +	err = dev_close(netdev);
> +	if (err < 0)
> +		BT_INFO("iface %s cannot be closed (%d)", netdev->name, err);
> +	rtnl_unlock();
> +}
> +
> static void do_notify_peers(struct work_struct *work)
> {
> 	struct lowpan_dev *dev = container_of(work, struct lowpan_dev,
> @@ -811,6 +822,8 @@ static void chan_close_cb(struct l2cap_chan *chan)
> 
> 		cancel_delayed_work_sync(&dev->notify_peers);
> 
> +		ifdown(dev->netdev);
> +
> 		if (!removed) {
> 			INIT_WORK(&entry->delete_netdev, delete_netdev);
> 			schedule_work(&entry->delete_netdev);
> @@ -1198,6 +1211,38 @@ static void cleanup_6lowpan(void)
> 		chan_close(listen_chan, 0);
> }
> 
> +static void disconnect_devices(void)
> +{
> +	struct lowpan_dev *entry, *tmp, *new_dev;
> +	struct list_head devices;
> +	unsigned long flags;
> +
> +	INIT_LIST_HEAD(&devices);
> +
> +	read_lock_irqsave(&devices_lock, flags);
> +
> +	list_for_each_entry_safe(entry, tmp, &bt_6lowpan_devices, list) {
> +		new_dev = kmalloc(sizeof(*new_dev), GFP_ATOMIC);
> +		if (!new_dev)
> +			break;
> +
> +		new_dev->netdev = entry->netdev;
> +		INIT_LIST_HEAD(&new_dev->list);
> +
> +		list_add(&new_dev->list, &devices);
> +	}
> +
> +	read_unlock_irqrestore(&devices_lock, flags);
> +
> +	list_for_each_entry_safe(entry, tmp, &devices, list) {
> +		ifdown(entry->netdev);
> +		BT_DBG("Unregistering netdev %s %p",
> +		       entry->netdev->name, entry->netdev);
> +		unregister_netdev(entry->netdev);
> +		kfree(entry);
> +	}

this whole copy the list first needs an explanation on why you are doing this. Since I am not getting it.

Regards

Marcel

