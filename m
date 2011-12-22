Return-Path: <cyrus@holtmann.org>
Date: Thu, 22 Dec 2011 14:25:08 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: AMP: physical link struct definitions
Message-ID: <20111222122506.GA30914@aemeltch-MOBL1>
References: <1324551986-29431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1324551986-29431-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1324551986-29431-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Dec 22, 2011 at 01:06:07PM +0200, Emeltchenko Andrei wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Define physical link structure

This is actually RFC not patch.

Best regards 
Andrei Emeltchenko 

> ---
>  include/net/bluetooth/a2mp.h     |   10 +++++
>  include/net/bluetooth/hci_core.h |    3 ++
>  net/bluetooth/a2mp.c             |   72 ++++++++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_core.c         |    1 +
>  4 files changed, 86 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/a2mp.h b/include/net/bluetooth/a2mp.h
> index b1612aa..f4d2f0b 100644
> --- a/include/net/bluetooth/a2mp.h
> +++ b/include/net/bluetooth/a2mp.h
> @@ -122,6 +122,16 @@ struct a2mp_physlink_rsp {
>  #define A2MP_STATUS_PHYS_LINK_EXISTS		0x05
>  #define A2MP_STATUS_SECURITY_VIOLATION		0x06
>  
> +struct phy_link {
> +	struct list_head	list;
> +	__u8			handle;
> +	__u16			state;
> +	__u8			amp_role;
> +	struct hci_dev		*hdev;
> +	struct amp_assoc	rem_assoc;
> +	atomic_t		refcnt;
> +};
> +
>  void amp_mgr_get(struct amp_mgr *mgr);
>  int amp_mgr_put(struct amp_mgr *mgr);
>  
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 74e2953..6cd728a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -135,7 +135,10 @@ struct amp_assoc {
>  struct hci_dev {
>  	struct list_head list;
>  	struct mutex	lock;
> +	struct list_head phy_links;
> +
>  	atomic_t	refcnt;
> +	rwlock_t	phy_link_lock;
>  
>  	char		name[8];
>  	unsigned long	flags;
> diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
> index ebaec0b..35c3d87 100644
> --- a/net/bluetooth/a2mp.c
> +++ b/net/bluetooth/a2mp.c
> @@ -605,3 +605,75 @@ void a2mp_exit(void)
>  	destroy_workqueue(a2mp_workqueue);
>  #endif
>  }
> +
> +/* Physical Link interface */
> +static inline void phylink_hold(struct phy_link *plink)
> +{
> +	atomic_inc(&plink->refcnt);
> +}
> +
> +static inline void phylink_put(struct phy_link *plink)
> +{
> +	if (atomic_dec_and_test(&plink->refcnt))
> +		kfree(plink);
> +}
> +
> +static struct phy_link *hci_phylink_add(struct hci_dev *hdev, __u8 handle,
> +			__u8 amp_role, __u8 *rem_assoc, __u16 assoc_size)
> +
> +{
> +	struct phy_link *plink;
> +
> +	BT_DBG("handle %d", handle);
> +
> +	plink = kzalloc(sizeof(*plink), GFP_KERNEL);
> +	if (!plink)
> +		return NULL;
> +
> +	plink->handle = handle;
> +	plink->hdev = hdev;
> +	plink->amp_role = amp_role;
> +
> +	plink->rem_assoc.len = min_t(__u16, assoc_size, HCI_MAX_AMP_ASSOC_SIZE);
> +	memcpy(plink->rem_assoc.data, rem_assoc, plink->rem_assoc.len);
> +
> +	plink->state = BT_OPEN;
> +
> +	write_lock(&hdev->phy_link_lock);
> +	list_add(&plink->list, &hdev->phy_links);
> +	write_unlock(&hdev->phy_link_lock);
> +
> +	atomic_set(&plink->refcnt, 1);
> +
> +	return plink;
> +}
> +
> +static void hci_phylink_del(struct hci_dev *hdev, struct phy_link *plink)
> +{
> +	BT_DBG("phylink %p", plink);
> +
> +	write_lock(&hdev->phy_link_lock);
> +	list_del(&plink->list);
> +	write_unlock(&hdev->phy_link_lock);
> +
> +	phylink_put(plink);
> +}
> +
> +static inline struct phy_link *hci_phylink_lookup_handle(struct hci_dev *hdev,
> +								__u8 handle)
> +{
> +	struct phy_link *plink;
> +
> +	BT_DBG("");
> +
> +	read_lock(&hdev->phy_link_lock);
> +	list_for_each_entry(plink, &hdev->phy_links, list) {
> +		if (plink->handle == handle) {
> +			read_unlock(&hdev->phy_link_lock);
> +			return plink;
> +		}
> +	}
> +	read_unlock(&hdev->phy_link_lock);
> +
> +	return NULL;
> +}
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index b031c7a..74f8819 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1522,6 +1522,7 @@ int hci_register_dev(struct hci_dev *hdev)
>  
>  	atomic_set(&hdev->refcnt, 1);
>  	mutex_init(&hdev->lock);
> +	rwlock_init(&hdev->phy_link_lock);
>  
>  	hdev->flags = 0;
>  	hdev->dev_flags = 0;
> -- 
> 1.7.4.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
