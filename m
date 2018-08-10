Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] Bluetooth: Add definitions and track LE resolve list
 modification
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1531302639-16648-1-git-send-email-ankit.p.navik@intel.com>
Date: Fri, 10 Aug 2018 16:57:05 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        bharat.b.panda@intel.com
Message-Id: <3A49CC03-4429-4A38-B72C-20A7D6B3038F@holtmann.org>
References: <1531302639-16648-1-git-send-email-ankit.p.navik@intel.com>
To: Ankit Navik <ankit.p.navik@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ankit,

> Add the definitions for adding entries to the LE resolve list and
> removing entries from the LE resolve list. When the LE resolve list
> gets changed via HCI commands make sure that the internal storage of
> the resolve list entries gets updated.
> 
> Signed-off-by: Ankit Navik <ankit.p.navik@intel.com>
> ---
> include/net/bluetooth/hci.h      | 14 ++++++++++++
> include/net/bluetooth/hci_core.h |  5 +++-
> net/bluetooth/hci_core.c         |  9 +++++++-
> net/bluetooth/hci_event.c        | 49 +++++++++++++++++++++++++++++++++++++++-
> net/bluetooth/hci_sock.c         |  3 ++-
> net/bluetooth/mgmt.c             |  4 ++--
> 6 files changed, 78 insertions(+), 6 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 4af1a3a..1abcd14 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1490,6 +1490,20 @@ struct hci_cp_le_write_def_data_len {
> 	__le16	tx_time;
> } __packed;
> 
> +#define HCI_OP_LE_ADD_TO_RESOLV_LIST	0x2027
> +struct hci_cp_le_add_to_resolv_list {
> +	__u8	 bdaddr_type;
> +	bdaddr_t bdaddr;
> +	__u8	 peer_irk[16];
> +	__u8	 local_irk[16];
> +} __packed;
> +
> +#define HCI_OP_LE_DEL_FROM_RESOLV_LIST	0x2028
> +struct hci_cp_le_del_from_resolv_list {
> +	__u8	 bdaddr_type;
> +	bdaddr_t bdaddr;
> +} __packed;
> +
> #define HCI_OP_LE_CLEAR_RESOLV_LIST	0x2029
> 
> #define HCI_OP_LE_READ_RESOLV_LIST_SIZE	0x202a
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 3a1ae0d..9ab0fdf 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -101,6 +101,8 @@ struct bdaddr_list {
> 	struct list_head list;
> 	bdaddr_t bdaddr;
> 	u8 bdaddr_type;
> +	u8 peer_irk[16];
> +	u8 local_irk[16];
> };

this is a bit wasteful since now every address entry carries an extra 32 bytes. That is more than double what the struct is currently in size. I am not convinced that is a good idea.

> struct bt_uuid {
> @@ -1050,7 +1052,8 @@ static inline void hci_set_drvdata(struct hci_dev *hdev, void *data)
> 
> struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *list,
> 					   bdaddr_t *bdaddr, u8 type);
> -int hci_bdaddr_list_add(struct list_head *list, bdaddr_t *bdaddr, u8 type);
> +int hci_bdaddr_list_add(struct list_head *list, bdaddr_t *bdaddr, u8 type,
> +			u8 *peer_irk, u8 *local_irk);

Instead of doing this and changing every caller that really doesn’t care about IRKs, better have a new hci_bdaddr_list_add_with_irk or something like that.

> int hci_bdaddr_list_del(struct list_head *list, bdaddr_t *bdaddr, u8 type);
> void hci_bdaddr_list_clear(struct list_head *list);
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index af1675d..dcaef13 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2784,7 +2784,8 @@ void hci_bdaddr_list_clear(struct list_head *bdaddr_list)
> 	}
> }
> 
> -int hci_bdaddr_list_add(struct list_head *list, bdaddr_t *bdaddr, u8 type)
> +int hci_bdaddr_list_add(struct list_head *list, bdaddr_t *bdaddr, u8 type,
> +			u8 *peer_irk, u8 *local_irk)
> {
> 	struct bdaddr_list *entry;
> 
> @@ -2801,6 +2802,12 @@ int hci_bdaddr_list_add(struct list_head *list, bdaddr_t *bdaddr, u8 type)
> 	bacpy(&entry->bdaddr, bdaddr);
> 	entry->bdaddr_type = type;
> 
> +	if (peer_irk)
> +		memcpy(entry->peer_irk, peer_irk, 16);
> +
> +	if (local_irk)
> +		memcpy(entry->local_irk, local_irk, 16);
> +
> 	list_add(&entry->list, list);
> 
> 	return 0;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 3029d79..e8d6df9 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1239,7 +1239,7 @@ static void hci_cc_le_add_to_white_list(struct hci_dev *hdev,
> 		return;
> 
> 	hci_bdaddr_list_add(&hdev->le_white_list, &sent->bdaddr,
> -			   sent->bdaddr_type);
> +			   sent->bdaddr_type, NULL, NULL);
> }
> 
> static void hci_cc_le_del_from_white_list(struct hci_dev *hdev,
> @@ -1307,6 +1307,45 @@ static void hci_cc_le_write_def_data_len(struct hci_dev *hdev,
> 	hdev->le_def_tx_time = le16_to_cpu(sent->tx_time);
> }
> 
> +static void hci_cc_le_add_to_resolv_list(struct hci_dev *hdev,
> +					 struct sk_buff *skb)
> +{
> +	struct hci_cp_le_add_to_resolv_list *sent;
> +	__u8 status = *((__u8 *) skb->data);
> +
> +	BT_DBG("%s status 0x%2.2x", hdev->name, status);
> +
> +	if (status)
> +		return;
> +
> +	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_ADD_TO_RESOLV_LIST);
> +	if (!sent)
> +		return;
> +
> +	hci_bdaddr_list_add(&hdev->le_resolv_list, &sent->bdaddr,
> +				sent->bdaddr_type, sent->peer_irk,
> +				sent->local_irk);
> +}
> +
> +static void hci_cc_le_del_from_resolv_list(struct hci_dev *hdev,
> +					  struct sk_buff *skb)
> +{
> +	struct hci_cp_le_del_from_resolv_list *sent;
> +	__u8 status = *((__u8 *) skb->data);
> +
> +	BT_DBG("%s status 0x%2.2x", hdev->name, status);
> +
> +	if (status)
> +		return;
> +
> +	sent = hci_sent_cmd_data(hdev, HCI_OP_LE_DEL_FROM_RESOLV_LIST);
> +	if (!sent)
> +		return;
> +
> +	hci_bdaddr_list_del(&hdev->le_resolv_list, &sent->bdaddr,
> +			    sent->bdaddr_type);
> +}
> +
> static void hci_cc_le_clear_resolv_list(struct hci_dev *hdev,
> 				       struct sk_buff *skb)
> {
> @@ -3042,6 +3081,14 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
> 		hci_cc_le_write_def_data_len(hdev, skb);
> 		break;
> 
> +	case HCI_OP_LE_ADD_TO_RESOLV_LIST:
> +		hci_cc_le_add_to_resolv_list(hdev, skb);
> +		break;
> +
> +	case HCI_OP_LE_DEL_FROM_RESOLV_LIST:
> +		hci_cc_le_del_from_resolv_list(hdev, skb);
> +		break;
> +
> 	case HCI_OP_LE_CLEAR_RESOLV_LIST:
> 		hci_cc_le_clear_resolv_list(hdev, skb);
> 		break;
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 1506e16..1f6ae79 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -893,7 +893,8 @@ static int hci_sock_blacklist_add(struct hci_dev *hdev, void __user *arg)
> 
> 	hci_dev_lock(hdev);
> 
> -	err = hci_bdaddr_list_add(&hdev->blacklist, &bdaddr, BDADDR_BREDR);
> +	err = hci_bdaddr_list_add(&hdev->blacklist, &bdaddr, BDADDR_BREDR,
> +					NULL, NULL);
> 
> 	hci_dev_unlock(hdev);
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 8a80d48..a99b8dd 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -3791,7 +3791,7 @@ static int block_device(struct sock *sk, struct hci_dev *hdev, void *data,
> 	hci_dev_lock(hdev);
> 
> 	err = hci_bdaddr_list_add(&hdev->blacklist, &cp->addr.bdaddr,
> -				  cp->addr.type);
> +				  cp->addr.type, NULL, NULL);
> 	if (err < 0) {
> 		status = MGMT_STATUS_FAILED;
> 		goto done;
> @@ -5272,7 +5272,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
> 		}
> 
> 		err = hci_bdaddr_list_add(&hdev->whitelist, &cp->addr.bdaddr,
> -					  cp->addr.type);
> +					  cp->addr.type, NULL, NULL);
> 		if (err)
> 			goto unlock;

Regards

Marcel
