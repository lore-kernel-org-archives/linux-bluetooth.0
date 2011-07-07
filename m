Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v3 03/12] Bluetooth: Add functions to manipulate the
 link key list for SMP
From: Marcel Holtmann <marcel@holtmann.org>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 07 Jul 2011 10:09:11 +0200
In-Reply-To: <1309980187-14404-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1309547267-9514-4-git-send-email-vinicius.gomes@openbossa.org>
	 <1309980187-14404-1-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1310026154.21109.51.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

> As the LTK (the new type of key being handled now) has more data
> associated with it, we need to store this extra data and retrieve
> the keys based on that data.
> 
> Methods for searching for a key and for adding a new LTK are
> introduced here.
> 
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
>  include/net/bluetooth/hci_core.h |    5 +++
>  net/bluetooth/hci_core.c         |   73 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 78 insertions(+), 0 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index a3d49d8..353d4a9 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -552,6 +552,11 @@ int hci_link_keys_clear(struct hci_dev *hdev);
>  struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
>  int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
>  			bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
> +struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
> +struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
> +					bdaddr_t *bdaddr, u8 type);
> +int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
> +					__le16 ediv, u8 rand[8], u8 ltk[16]);
>  int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
>  
>  int hci_remote_oob_data_clear(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index cd59b84..1cf8b89 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1059,6 +1059,42 @@ static int hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
>  	return 0;
>  }
>  
> +struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
> +{
> +	struct link_key *k;
> +
> +	list_for_each_entry(k, &hdev->link_keys, list) {
> +		struct key_master_id *id;
> +
> +		if (k->type != HCI_LK_SMP_LTK)
> +			continue;
> +
> +		if (k->dlen != sizeof(*id))
> +			continue;
> +
> +		id = (void *) &k->data;
> +		if (id->ediv == ediv &&
> +				(memcmp(rand, id->rand, sizeof(id->rand)) == 0))
> +			return k;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL(hci_find_ltk);
> +
> +struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
> +					bdaddr_t *bdaddr, u8 type)
> +{
> +	struct link_key *k;
> +
> +	list_for_each_entry(k, &hdev->link_keys, list)
> +		if ((k->type == type) && (bacmp(bdaddr, &k->bdaddr) == 0))
> +			return k;

please just do if (k->type == type && bacmp(....) == 0). No need for the
extra braces.

> +	return NULL;
> +}
> +EXPORT_SYMBOL(hci_find_link_key_type);
> +
>  int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
>  				bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len)
>  {
> @@ -1114,6 +1150,43 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
>  	return 0;
>  }
>  
> +int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
> +					__le16 ediv, u8 rand[8], u8 ltk[16])
> +{
> +	struct link_key *key, *old_key;
> +	struct key_master_id *id;
> +	u8 old_key_type;
> +
> +	BT_DBG("%s addr %s", hdev->name, batostr(bdaddr));
> +
> +	old_key = hci_find_link_key_type(hdev, bdaddr, HCI_LK_SMP_LTK);
> +	if (old_key) {
> +		key = old_key;
> +		old_key_type = old_key->type;
> +	} else {
> +		key = kzalloc(sizeof(*key) + sizeof(*id), GFP_ATOMIC);
> +		if (!key)
> +			return -ENOMEM;
> +		list_add(&key->list, &hdev->link_keys);
> +		old_key_type = 0xff;
> +	}
> +
> +	key->dlen = sizeof(*id);
> +
> +	bacpy(&key->bdaddr, bdaddr);
> +	memcpy(key->val, ltk, sizeof(key->val));
> +	key->type = HCI_LK_SMP_LTK;
> +
> +	id = (void *) &key->data;
> +	id->ediv = ediv;
> +	memcpy(id->rand, rand, sizeof(id->rand));
> +
> +	if (new_key)
> +		mgmt_new_key(hdev->id, key, old_key_type);
> +
> +	return 0;
> +}
> +
>  int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
>  {
>  	struct link_key *key;


