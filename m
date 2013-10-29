Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [RFC v2 04/15] Bluetooth: Introduce connection parameters list
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383053160-10175-5-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 30 Oct 2013 00:03:13 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <AB327233-41F1-4297-B222-6F027E7E1011@holtmann.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org> <1383053160-10175-5-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds to hdev the connection parameters list (hdev->
> conn_params). The elements from this list (struct hci_conn_params)
> contains the connection parameters (for now, minimum and maximum
> connection interval) that should be used during the connection
> establishment.
> 
> The struct hci_conn_params also defines the 'auto_connect' field
> which will be used to implement the auto connection mechanism.
> 
> Moreover, this patch adds helper functions to manipulate hdev->conn_
> params list. Some of these functions are also declared in hci_core.h
> since they will be used outside hci_core.c in upcoming patches.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h | 24 +++++++++++
> net/bluetooth/hci_core.c         | 86 ++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 110 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 037a7b5..22d16d9 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -271,6 +271,8 @@ struct hci_dev {
> 
> 	struct list_head	remote_oob_data;
> 
> +	struct list_head	conn_params;
> +

these bunch of empty lines between the list_head structs is actually bugging me. They are pointless and give no visual impact. We might want to remove them as well.

I would call it le_conn_params to make sure that it is for LE.

> 	struct hci_dev_stats	stat;
> 
> 	atomic_t		promisc;
> @@ -375,6 +377,22 @@ struct hci_chan {
> 	__u8		state;
> };
> 
> +struct hci_conn_params {
> +	struct list_head list;
> +
> +	bdaddr_t addr;
> +	u8 addr_type;
> +
> +	enum {
> +		HCI_AUTO_CONN_DISABLED,
> +		HCI_AUTO_CONN_ALWAYS,
> +		HCI_AUTO_CONN_LINK_LOSS,
> +	} auto_connect;
> +
> +	u16 conn_interval_min;
> +	u16 conn_interval_max;
> +};
> +
> extern struct list_head hci_dev_list;
> extern struct list_head hci_cb_list;
> extern rwlock_t hci_dev_list_lock;
> @@ -744,6 +762,12 @@ int hci_blacklist_clear(struct hci_dev *hdev);
> int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
> int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
> 
> +int hci_add_conn_params(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
> +			u8 auto_connect, u16 conn_interval_min,
> +			u16 conn_interval_max);
> +void hci_remove_conn_params(struct hci_dev *hdev, bdaddr_t *addr,
> +			    u8 addr_type);
> +

This is in violation with our other names. hci_conn_params_add might be better.

> int hci_uuids_clear(struct hci_dev *hdev);
> 
> int hci_link_keys_clear(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 6ccc4eb..fa41a58 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2771,6 +2771,90 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
> 	return mgmt_device_unblocked(hdev, bdaddr, type);
> }
> 
> +static struct hci_conn_params *find_conn_params(struct hci_dev *hdev,
> +						bdaddr_t *addr, u8 addr_type)
> +{

Don’t like this find naming. It is either a lookup operation or a get.

> +	struct hci_conn_params *params;
> +
> +	rcu_read_lock();
> +
> +	list_for_each_entry(params, &hdev->conn_params, list) {
> +		if (bacmp(&params->addr, addr))
> +			continue;
> +		if (params->addr_type != addr_type)
> +			continue;

> +
> +		rcu_read_unlock();
> +		return params;
> +	}
> +
> +	rcu_read_unlock();
> +	return NULL;
> +}
> +
> +int hci_add_conn_params(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
> +		       u8 auto_connect, u16 conn_interval_min,
> +		       u16 conn_interval_max)
> +{
> +	struct hci_conn_params *params;
> +
> +	params = find_conn_params(hdev, addr, addr_type);
> +	if (params)
> +		return -EEXIST;
> +
> +	params = kmalloc(sizeof(*params), GFP_KERNEL);
> +	if (!params)
> +		return -ENOMEM;
> +
> +	bacpy(&params->addr, addr);
> +	params->addr_type = addr_type;
> +	params->auto_connect = auto_connect;
> +	params->conn_interval_min = conn_interval_min;
> +	params->conn_interval_max = conn_interval_max;
> +
> +	hci_dev_lock(hdev);
> +	list_add_rcu(&params->list, &hdev->conn_params);
> +	hci_dev_unlock(hdev);
> +	return 0;
> +}
> +
> +/* Remove from hdev->conn_params and free hci_conn_params.
> + *
> + * This function requires the caller holds hdev->lock.
> + */
> +static void __remove_conn_params(struct hci_conn_params *params)
> +{
> +	list_del_rcu(&params->list);
> +	synchronize_rcu();
> +
> +	kfree(params);
> +}
> +
> +void hci_remove_conn_params(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
> +{
> +	struct hci_conn_params *params;
> +
> +	params = find_conn_params(hdev, addr, addr_type);
> +	if (!params)
> +		return;
> +
> +	hci_dev_lock(hdev);
> +	__remove_conn_params(params);
> +	hci_dev_unlock(hdev);
> +}
> +
> +/* Remove all elements from hdev->conn_params list.
> + *
> + * This function requires the caller holds hdev->lock.
> + */
> +static void __clear_conn_params(struct hci_dev *hdev)
> +{
> +	struct hci_conn_params *params, *tmp;
> +
> +	list_for_each_entry_safe(params, tmp, &hdev->conn_params, list)
> +		__remove_conn_params(params);
> +}
> +
> static void inquiry_complete(struct hci_dev *hdev, u8 status)
> {
> 	if (status) {
> @@ -2881,6 +2965,7 @@ struct hci_dev *hci_alloc_dev(void)
> 	INIT_LIST_HEAD(&hdev->link_keys);
> 	INIT_LIST_HEAD(&hdev->long_term_keys);
> 	INIT_LIST_HEAD(&hdev->remote_oob_data);
> +	INIT_LIST_HEAD(&hdev->conn_params);
> 	INIT_LIST_HEAD(&hdev->conn_hash.list);
> 
> 	INIT_WORK(&hdev->rx_work, hci_rx_work);
> @@ -3066,6 +3151,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
> 	hci_link_keys_clear(hdev);
> 	hci_smp_ltks_clear(hdev);
> 	hci_remote_oob_data_clear(hdev);
> +	__clear_conn_params(hdev);

Why is this one more special than the others.

> 	hci_dev_unlock(hdev);
> 
> 	hci_dev_put(hdev);

Regards

Marcel

