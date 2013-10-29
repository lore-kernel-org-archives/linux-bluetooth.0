Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [RFC v2 05/15] Bluetooth: Make find_conn_param() helper non-local
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383053160-10175-6-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 30 Oct 2013 00:33:07 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <8D23C0CD-D9D3-4D4C-B616-2652E9F79CF3@holtmann.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org> <1383053160-10175-6-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch makes the find_conn_param() helper non-local by adding the
> hci_ prefix and declaring it in hci_core.h. This helper will be used
> in hci_conn.c to get the connection parameters when establishing
> connections.
> 
> Since hci_find_conn_param() returns a reference to the hci_conn_param
> object, it was added a refcount to hci_conn_param to control its
> lifetime. This way, we avoid bugs such as use-after-free.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h |  5 +++++
> net/bluetooth/hci_core.c         | 45 ++++++++++++++++++++++++++++++++++------
> 2 files changed, 44 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 22d16d9..64911aa 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -378,6 +378,8 @@ struct hci_chan {
> };
> 
> struct hci_conn_params {
> +	struct kref refcount;
> +
> 	struct list_head list;
> 
> 	bdaddr_t addr;
> @@ -767,6 +769,9 @@ int hci_add_conn_params(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
> 			u16 conn_interval_max);
> void hci_remove_conn_params(struct hci_dev *hdev, bdaddr_t *addr,
> 			    u8 addr_type);
> +struct hci_conn_params *hci_find_conn_params(struct hci_dev *hdev,
> +					   bdaddr_t *addr, u8 addr_type);
> +void hci_conn_params_put(struct hci_conn_params *params);
> 
> int hci_uuids_clear(struct hci_dev *hdev);
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index fa41a58..0a278da 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2771,8 +2771,33 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
> 	return mgmt_device_unblocked(hdev, bdaddr, type);
> }
> 
> -static struct hci_conn_params *find_conn_params(struct hci_dev *hdev,
> -						bdaddr_t *addr, u8 addr_type)
> +static void hci_conn_params_get(struct hci_conn_params *params)
> +{
> +	kref_get(&params->refcount);
> +}

Lets have return hci_conn_params_get the structure itself and give it the parameters we are looking for. So it is essentially the lookup function. That is how it is used anyway.

> +
> +static void release_hci_conn_params(struct kref *kref)
> +{
> +	struct hci_conn_params *params = container_of(kref,
> +						    struct hci_conn_params,
> +						    refcount);
> +
> +	kfree(params);
> +}
> +
> +void hci_conn_params_put(struct hci_conn_params *params)
> +{
> +	kref_put(&params->refcount, release_hci_conn_params);
> +}
> +
> +/* Lookup hci_conn_params in hdev->conn_params list.
> + *
> + * Return a reference to hci_conn_params object with refcount incremented.
> + * The caller should drop its reference by using hci_conn_params_put(). If
> + * hci_conn_params is not found, NULL is returned.
> + */
> +struct hci_conn_params *hci_find_conn_params(struct hci_dev *hdev,
> +					     bdaddr_t *addr, u8 addr_type)
> {
> 	struct hci_conn_params *params;
> 
> @@ -2784,6 +2809,8 @@ static struct hci_conn_params *find_conn_params(struct hci_dev *hdev,
> 		if (params->addr_type != addr_type)
> 			continue;
> 
> +		hci_conn_params_get(params);
> +
> 		rcu_read_unlock();
> 		return params;
> 	}
> @@ -2798,14 +2825,18 @@ int hci_add_conn_params(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
> {
> 	struct hci_conn_params *params;
> 
> -	params = find_conn_params(hdev, addr, addr_type);
> -	if (params)
> +	params = hci_find_conn_params(hdev, addr, addr_type);
> +	if (params) {
> +		hci_conn_params_put(params);
> 		return -EEXIST;
> +	}
> 
> 	params = kmalloc(sizeof(*params), GFP_KERNEL);
> 	if (!params)
> 		return -ENOMEM;
> 
> +	kref_init(&params->refcount);
> +
> 	bacpy(&params->addr, addr);
> 	params->addr_type = addr_type;
> 	params->auto_connect = auto_connect;
> @@ -2827,20 +2858,22 @@ static void __remove_conn_params(struct hci_conn_params *params)
> 	list_del_rcu(&params->list);
> 	synchronize_rcu();
> 
> -	kfree(params);
> +	hci_conn_params_put(params);
> }
> 
> void hci_remove_conn_params(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
> {
> 	struct hci_conn_params *params;
> 
> -	params = find_conn_params(hdev, addr, addr_type);
> +	params = hci_find_conn_params(hdev, addr, addr_type);
> 	if (!params)
> 		return;
> 
> 	hci_dev_lock(hdev);
> 	__remove_conn_params(params);
> 	hci_dev_unlock(hdev);
> +
> +	hci_conn_params_put(params);
> }

Regards

Marcel

