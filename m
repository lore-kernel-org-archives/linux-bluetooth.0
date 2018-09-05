Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Navik, Ankit P" <ankit.p.navik@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Panda, Bharat B" <bharat.b.panda@intel.com>,
        "Navik, Ankit P" <ankit.p.navik@intel.com>
Subject: RE: [PATCH v2] Bluetooth: Add definitions and track LE resolve list
 modification
Date: Wed, 5 Sep 2018 05:21:52 +0000
Message-ID: <2F886D5F95ED3A47BC8C177EADCD1CC7282A442D@BGSMSX104.gar.corp.intel.com>
References: <1534471159-26476-1-git-send-email-ankit.p.navik@intel.com>
 <2F886D5F95ED3A47BC8C177EADCD1CC72829EC38@BGSMSX104.gar.corp.intel.com>
In-Reply-To: <2F886D5F95ED3A47BC8C177EADCD1CC72829EC38@BGSMSX104.gar.corp.intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

soft reminder
 
> Soft reminder.
> 
> > Add the definitions for adding entries to the LE resolve list and
> > removing entries from the LE resolve list. When the LE resolve list
> > gets changed via HCI commands make sure that the internal storage of
> > the resolve list entries gets updated.
> >
> > Signed-off-by: Ankit Navik <ankit.p.navik@intel.com>
> > ---
> >  include/net/bluetooth/hci.h      | 14 +++++++++
> >  include/net/bluetooth/hci_core.h | 15 ++++++++++
> >  net/bluetooth/hci_core.c         | 63
> > ++++++++++++++++++++++++++++++++++++++++
> >  net/bluetooth/hci_event.c        | 47 ++++++++++++++++++++++++++++++
> >  4 files changed, 139 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index
> > 4af1a3a..1abcd14 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1490,6 +1490,20 @@ struct hci_cp_le_write_def_data_len {
> >  	__le16	tx_time;
> >  } __packed;
> >
> > +#define HCI_OP_LE_ADD_TO_RESOLV_LIST	0x2027
> > +struct hci_cp_le_add_to_resolv_list {
> > +	__u8	 bdaddr_type;
> > +	bdaddr_t bdaddr;
> > +	__u8	 peer_irk[16];
> > +	__u8	 local_irk[16];
> > +} __packed;
> > +
> > +#define HCI_OP_LE_DEL_FROM_RESOLV_LIST	0x2028
> > +struct hci_cp_le_del_from_resolv_list {
> > +	__u8	 bdaddr_type;
> > +	bdaddr_t bdaddr;
> > +} __packed;
> > +
> >  #define HCI_OP_LE_CLEAR_RESOLV_LIST	0x2029
> >
> >  #define HCI_OP_LE_READ_RESOLV_LIST_SIZE	0x202a
> > diff --git a/include/net/bluetooth/hci_core.h
> > b/include/net/bluetooth/hci_core.h
> > index 3a1ae0d..89580de 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -103,6 +103,14 @@ struct bdaddr_list {
> >  	u8 bdaddr_type;
> >  };
> >
> > +struct bdaddr_list_with_irk {
> > +	struct list_head list;
> > +	bdaddr_t bdaddr;
> > +	u8 bdaddr_type;
> > +	u8 peer_irk[16];
> > +	u8 local_irk[16];
> > +};
> > +
> >  struct bt_uuid {
> >  	struct list_head list;
> >  	u8 uuid[16];
> > @@ -1050,8 +1058,15 @@ static inline void hci_set_drvdata(struct
> > hci_dev *hdev, void *data)
> >
> >  struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *list,
> >  					   bdaddr_t *bdaddr, u8 type);
> > +struct bdaddr_list_with_irk *hci_bdaddr_list_lookup_with_irk(
> > +				    struct list_head *list, bdaddr_t *bdaddr,
> > +				    u8 type);
> >  int hci_bdaddr_list_add(struct list_head *list, bdaddr_t *bdaddr, u8
> > type);
> > +int hci_bdaddr_list_add_with_irk(struct list_head *list, bdaddr_t *bdaddr,
> > +					u8 type, u8 *peer_irk, u8 *local_irk);
> >  int hci_bdaddr_list_del(struct list_head *list, bdaddr_t *bdaddr, u8
> > type);
> > +int hci_bdaddr_list_del_with_irk(struct list_head *list, bdaddr_t *bdaddr,
> > +								u8 type);
> >  void hci_bdaddr_list_clear(struct list_head *list);
> >
> >  struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
> > diff -- git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index
> > af1675d..d74dd1c8 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2774,6 +2774,20 @@ struct bdaddr_list
> > *hci_bdaddr_list_lookup(struct list_head *bdaddr_list,
> >  	return NULL;
> >  }
> >
> > +struct bdaddr_list_with_irk *hci_bdaddr_list_lookup_with_irk(
> > +				struct list_head *bdaddr_list, bdaddr_t
> > *bdaddr,
> > +				u8 type)
> > +{
> > +	struct bdaddr_list_with_irk *b;
> > +
> > +	list_for_each_entry(b, bdaddr_list, list) {
> > +		if (!bacmp(&b->bdaddr, bdaddr) && b->bdaddr_type == type)
> > +			return b;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> >  void hci_bdaddr_list_clear(struct list_head *bdaddr_list)  {
> >  	struct bdaddr_list *b, *n;
> > @@ -2806,6 +2820,35 @@ int hci_bdaddr_list_add(struct list_head *list,
> > bdaddr_t *bdaddr, u8 type)
> >  	return 0;
> >  }
> >
> > +int hci_bdaddr_list_add_with_irk(struct list_head *list, bdaddr_t *bdaddr,
> > +					u8 type, u8 *peer_irk, u8 *local_irk) {
> > +	struct bdaddr_list_with_irk *entry;
> > +
> > +	if (!bacmp(bdaddr, BDADDR_ANY))
> > +		return -EBADF;
> > +
> > +	if (hci_bdaddr_list_lookup(list, bdaddr, type))
> > +		return -EEXIST;
> > +
> > +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
> > +	if (!entry)
> > +		return -ENOMEM;
> > +
> > +	bacpy(&entry->bdaddr, bdaddr);
> > +	entry->bdaddr_type = type;
> > +
> > +	if (peer_irk)
> > +		memcpy(entry->peer_irk, peer_irk, 16);
> > +
> > +	if (local_irk)
> > +		memcpy(entry->local_irk, local_irk, 16);
> > +
> > +	list_add(&entry->list, list);
> > +
> > +	return 0;
> > +}
> > +
> >  int hci_bdaddr_list_del(struct list_head *list, bdaddr_t *bdaddr, u8 type)  {
> >  	struct bdaddr_list *entry;
> > @@ -2825,6 +2868,26 @@ int hci_bdaddr_list_del(struct list_head *list,
> > bdaddr_t *bdaddr, u8 type)
> >  	return 0;
> >  }
> >
> > +int hci_bdaddr_list_del_with_irk(struct list_head *list, bdaddr_t *bdaddr,
> > +							u8 type)
> > +{
> > +	struct bdaddr_list_with_irk *entry;
> > +
> > +	if (!bacmp(bdaddr, BDADDR_ANY)) {
> > +		hci_bdaddr_list_clear(list);
> > +		return 0;
> > +	}
> > +
> > +	entry = hci_bdaddr_list_lookup_with_irk(list, bdaddr, type);
> > +	if (!entry)
> > +		return -ENOENT;
> > +
> > +	list_del(&entry->list);
> > +	kfree(entry);
> > +
> > +	return 0;
> > +}
> > +
> >  /* This function requires the caller holds hdev->lock */  struct
> > hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
> >  					       bdaddr_t *addr, u8 addr_type) diff
> --git
> > a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c index
> > 3029d79..188ab46 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -1307,6 +1307,45 @@ static void hci_cc_le_write_def_data_len(struct
> > hci_dev *hdev,
> >  	hdev->le_def_tx_time = le16_to_cpu(sent->tx_time);  }
> >
> > +static void hci_cc_le_add_to_resolv_list(struct hci_dev *hdev,
> > +					 struct sk_buff *skb)
> > +{
> > +	struct hci_cp_le_add_to_resolv_list *sent;
> > +	__u8 status = *((__u8 *) skb->data);
> > +
> > +	BT_DBG("%s status 0x%2.2x", hdev->name, status);
> > +
> > +	if (status)
> > +		return;
> > +
> > +	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_ADD_TO_RESOLV_LIST);
> > +	if (!sent)
> > +		return;
> > +
> > +	hci_bdaddr_list_add_with_irk(&hdev->le_resolv_list, &sent->bdaddr,
> > +				sent->bdaddr_type, sent->peer_irk,
> > +				sent->local_irk);
> > +}
> > +
> > +static void hci_cc_le_del_from_resolv_list(struct hci_dev *hdev,
> > +					  struct sk_buff *skb)
> > +{
> > +	struct hci_cp_le_del_from_resolv_list *sent;
> > +	__u8 status = *((__u8 *) skb->data);
> > +
> > +	BT_DBG("%s status 0x%2.2x", hdev->name, status);
> > +
> > +	if (status)
> > +		return;
> > +
> > +	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_DEL_FROM_RESOLV_LIST);
> > +	if (!sent)
> > +		return;
> > +
> > +	hci_bdaddr_list_del_with_irk(&hdev->le_resolv_list, &sent->bdaddr,
> > +			    sent->bdaddr_type);
> > +}
> > +
> >  static void hci_cc_le_clear_resolv_list(struct hci_dev *hdev,
> >  				       struct sk_buff *skb)
> >  {
> > @@ -3042,6 +3081,14 @@ static void hci_cmd_complete_evt(struct hci_dev
> > *hdev, struct sk_buff *skb,
> >  		hci_cc_le_write_def_data_len(hdev, skb);
> >  		break;
> >
> > +	case HCI_OP_LE_ADD_TO_RESOLV_LIST:
> > +		hci_cc_le_add_to_resolv_list(hdev, skb);
> > +		break;
> > +
> > +	case HCI_OP_LE_DEL_FROM_RESOLV_LIST:
> > +		hci_cc_le_del_from_resolv_list(hdev, skb);
> > +		break;
> > +
> >  	case HCI_OP_LE_CLEAR_RESOLV_LIST:
> >  		hci_cc_le_clear_resolv_list(hdev, skb);
> >  		break;
> > --
> > 1.9.1
> 
> Regards,
> Ankit

Regards,
Ankit
