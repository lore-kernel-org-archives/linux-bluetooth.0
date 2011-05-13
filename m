Return-Path: <cyrus@holtmann.org>
Date: Fri, 13 May 2011 16:33:26 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 02/12] Bluetooth: LE advertising cache
Message-ID: <20110513193326.GB5403@joana>
References: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
 <1304701521-26459-3-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304701521-26459-3-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2011-05-06 14:05:11 -0300]:

> This patch implements the LE advertising cache. It stores sensitive
> information (bdaddr and bdaddr_type so far) gathered from LE
> advertising report events.
> 
> Only advertising entries from connectables devices are added to the
> cache.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |   13 +++++++
>  net/bluetooth/hci_core.c         |   74 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 14cc324..65135f8 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -89,6 +89,12 @@ struct oob_data {
>  	u8 randomizer[16];
>  };
>  
> +struct adv_entry {
> +	struct list_head list;
> +	bdaddr_t bdaddr;
> +	u8 bdaddr_type;
> +};
> +
>  #define NUM_REASSEMBLY 4
>  struct hci_dev {
>  	struct list_head list;
> @@ -181,6 +187,8 @@ struct hci_dev {
>  
>  	struct list_head	remote_oob_data;
>  
> +	struct list_head	adv_entries;
> +
>  	struct hci_dev_stats	stat;
>  
>  	struct sk_buff_head	driver_init;
> @@ -526,6 +534,11 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
>  								u8 *randomizer);
>  int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
>  
> +int hci_adv_entries_clear(struct hci_dev *hdev);
> +struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr);
> +int hci_add_adv_entry(struct hci_dev *hdev,
> +					struct hci_ev_le_advertising_info *ev);

Rename this to hci_adv_add_entry()

> +
>  void hci_del_off_timer(struct hci_dev *hdev);
>  
>  void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index b6bda3f..0ba3c39 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1204,6 +1204,77 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
>  	return 0;
>  }
>  
> +int hci_adv_entries_clear(struct hci_dev *hdev)
> +{
> +	struct list_head *p, *n;
> +
> +	list_for_each_safe(p, n, &hdev->adv_entries) {

list_for_each_entry_safe() here.

> +		struct adv_entry *entry;
> +
> +		entry = list_entry(p, struct adv_entry, list);
> +
> +		list_del(p);
> +		kfree(entry);
> +	}
> +
> +	BT_DBG("%s adv cache cleared", hdev->name);
> +
> +	return 0;
> +}
> +
> +struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr)
> +{
> +	struct list_head *p;
> +
> +	list_for_each(p, &hdev->adv_entries) {

list_for_each_entry() here.

> +		struct adv_entry *entry;
> +
> +		entry = list_entry(p, struct adv_entry, list);
> +
> +		if (bacmp(bdaddr, &entry->bdaddr) == 0)
> +			return entry;
> +	}
> +
> +	return NULL;
> +}
> +
> +static inline int is_connectable_adv(u8 evt_type)
> +{
> +	if (evt_type == ADV_IND || evt_type == ADV_DIRECT_IND)
> +		return 1;
> +
> +	return 0;

You use this function just in one place, get rid of it.

> +}
> +
> +int hci_add_adv_entry(struct hci_dev *hdev,
> +					struct hci_ev_le_advertising_info *ev)
> +{
> +	struct adv_entry *entry;
> +
> +	if (!is_connectable_adv(ev->evt_type))
> +		return -EINVAL;
> +
> +	entry = hci_find_adv_entry(hdev, &ev->bdaddr);
> +	/* Only new entries should be added to adv_entries. So, if
> +	 * bdaddr was found, don't add it. */
> +	if (entry)
> +		return 0;

	if (hci_find_adv_entry())
		return 0;

-- 
Gustavo F. Padovan
http://profusion.mobi
