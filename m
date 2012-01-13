Return-Path: <cyrus@holtmann.org>
Message-ID: <4F10998B.5000805@codeaurora.org>
Date: Fri, 13 Jan 2012 12:52:27 -0800
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/8] Bluetooth: Use the updated key structures for handling
 LTKs
References: <1326483580-11243-1-git-send-email-vinicius.gomes@openbossa.org> <1326483580-11243-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1326483580-11243-5-git-send-email-vinicius.gomes@openbossa.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On 1/13/2012 11:39 AM, Vinicius Costa Gomes wrote:
> This updates all the users of the older way, that was using the
> link_keys list to store the SMP keys, to use the new way.
>
> This includes defining new types for the keys, we have a type for each
> combination of STK/LTK and Master/Slave.
>
> Signed-off-by: Vinicius Costa Gomes<vinicius.gomes@openbossa.org>
> ---
>   include/net/bluetooth/hci_core.h |   11 +++--
>   net/bluetooth/hci_core.c         |   79 ++++++++++++++++++--------------------
>   net/bluetooth/hci_event.c        |    9 +++-
>   net/bluetooth/smp.c              |   38 +++++++++++-------
>   4 files changed, 73 insertions(+), 64 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 9d77a66..7ce25ad 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -651,12 +651,13 @@ int hci_link_keys_clear(struct hci_dev *hdev);
>   struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
>   int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
>   			bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
> -struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
> -struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
> -					bdaddr_t *bdaddr, u8 type);
> -int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
> -			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16]);
> +struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
> +int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
> +				int new_key, u8 authenticated, 	u8 tk[16],
> +				u8 enc_size, u16 ediv, u8 rand[8]);
>   int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
> +struct smp_ltk *hci_find_ltk_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
> +								u8 addr_type);
>   int hci_smp_ltks_clear(struct hci_dev *hdev);
>
>   int hci_remote_oob_data_clear(struct hci_dev *hdev);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 3b5902d..5f41e74 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1222,41 +1222,40 @@ static int hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
>   	return 0;
>   }
>
> -struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
> +/* If the returned key is a STK it should be free'd by the caller */
> +struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
>   {
> -	struct link_key *k;
> -
> -	list_for_each_entry(k,&hdev->link_keys, list) {
> -		struct key_master_id *id;
> +	struct smp_ltk *k, *tmp;
>
> -		if (k->type != HCI_LK_SMP_LTK)
> +	list_for_each_entry_safe(k, tmp,&hdev->ltks, list) {
> +		if (k->ediv != ediv ||
> +				memcmp(rand, k->rand, sizeof(k->rand)))
>   			continue;
>
> -		if (k->dlen != sizeof(*id))
> -			continue;
> +		/* The STK should only be used once, no need to keep it */
> +		if (k->type&  HCI_SMP_STK)
> +			list_del(&k->list);

Is HCI_SMP_STK a mask?  Shouldn't this be an equality test?

>
> -		id = (void *)&k->data;
> -		if (id->ediv == ediv&&
> -				(memcmp(rand, id->rand, sizeof(id->rand)) == 0))
> -			return k;
> +		return k;
>   	}
>
>   	return NULL;
>   }
>   EXPORT_SYMBOL(hci_find_ltk);
>
> -struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
> -					bdaddr_t *bdaddr, u8 type)
> +struct smp_ltk *hci_find_ltk_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
> +								u8 addr_type)
>   {
> -	struct link_key *k;
> +	struct smp_ltk *k;
>
> -	list_for_each_entry(k,&hdev->link_keys, list)
> -		if (k->type == type&&  bacmp(bdaddr,&k->bdaddr) == 0)
> +	list_for_each_entry(k,&hdev->ltks, list)
> +		if (addr_type == k->bdaddr_type&&
> +					bacmp(bdaddr,&k->bdaddr) == 0)
>   			return k;
>
>   	return NULL;
>   }
> -EXPORT_SYMBOL(hci_find_link_key_type);
> +EXPORT_SYMBOL(hci_find_ltk_addr);
>
>   int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
>   				bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len)
> @@ -1313,40 +1312,36 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
>   	return 0;
>   }
>
> -int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
> -			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16])
> +int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
> +				int new_key, u8 authenticated, 	u8 tk[16],
> +				u8 enc_size, u16 ediv, u8 rand[8])
>   {
> -	struct link_key *key, *old_key;
> -	struct key_master_id *id;
> -	u8 old_key_type;
> +	struct smp_ltk *key, *old_key;
>
> -	BT_DBG("%s addr %s", hdev->name, batostr(bdaddr));
> +	if (!(type&  HCI_SMP_STK)&&  !(type&  HCI_SMP_LTK))
> +		return 0;

And here.

>
> -	old_key = hci_find_link_key_type(hdev, bdaddr, HCI_LK_SMP_LTK);
> -	if (old_key) {
> +	old_key = hci_find_ltk_addr(hdev, bdaddr, addr_type);
> +	if (old_key)
>   		key = old_key;
> -		old_key_type = old_key->type;
> -	} else {
> -		key = kzalloc(sizeof(*key) + sizeof(*id), GFP_ATOMIC);
> +	else {
> +		key = kzalloc(sizeof(*key), GFP_ATOMIC);
>   		if (!key)
>   			return -ENOMEM;

Looks like some whitespace issues.

> -		list_add(&key->list,&hdev->link_keys);
> -		old_key_type = 0xff;
> +		list_add(&key->list,&hdev->ltks);
>   	}
>
> -	key->dlen = sizeof(*id);
> -
>   	bacpy(&key->bdaddr, bdaddr);
> -	memcpy(key->val, ltk, sizeof(key->val));
> -	key->type = HCI_LK_SMP_LTK;
> -	key->pin_len = key_size;
> -
> -	id = (void *)&key->data;
> -	id->ediv = ediv;
> -	memcpy(id->rand, rand, sizeof(id->rand));
> +	key->bdaddr_type = addr_type;
> +	memcpy(key->val, tk, sizeof(key->val));
> +	key->authenticated = authenticated;
> +	key->ediv = ediv;
> +	key->enc_size = enc_size;
> +	key->type = type;
> +	memcpy(key->rand, rand, sizeof(key->rand));
>
> -	if (new_key)
> -		mgmt_new_link_key(hdev, key, old_key_type);
> +	if (!new_key)
> +		return 0;
>
>   	return 0;
>   }
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 94a9ca2..750fc0c 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3227,7 +3227,7 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
>   	struct hci_cp_le_ltk_reply cp;
>   	struct hci_cp_le_ltk_neg_reply neg;
>   	struct hci_conn *conn;
> -	struct link_key *ltk;
> +	struct smp_ltk *ltk;
>
>   	BT_DBG("%s handle %d", hdev->name, cpu_to_le16(ev->handle));
>
> @@ -3243,10 +3243,15 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
>
>   	memcpy(cp.ltk, ltk->val, sizeof(ltk->val));
>   	cp.handle = cpu_to_le16(conn->handle);
> -	conn->pin_length = ltk->pin_len;
> +
> +	if (ltk->authenticated)
> +		conn->sec_level = BT_SECURITY_HIGH;
>
>   	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp),&cp);
>
> +	if (ltk->type&  HCI_SMP_STK)
> +		kfree(ltk);
> +
>   	hci_dev_unlock(hdev);
>
>   	return;
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index b7f2fd1..7bc82e4 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -472,8 +472,9 @@ static void random_work(struct work_struct *work)
>   		memset(stk + smp->enc_key_size, 0,
>   				SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
>
> -		hci_add_ltk(hcon->hdev, 0, conn->dst, smp->enc_key_size,
> -							ediv, rand, stk);
> +		hci_add_ltk(hcon->hdev, conn->dst, hcon->dst_type,
> +						HCI_SMP_STK_SLAVE, 0, 0, stk,
> +						smp->enc_key_size, ediv, rand);
>   	}
>
>   	return;
> @@ -698,12 +699,10 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
>
>   static u8 smp_ltk_encrypt(struct l2cap_conn *conn)
>   {
> -	struct link_key *key;
> -	struct key_master_id *master;
> +	struct smp_ltk *key;
>   	struct hci_conn *hcon = conn->hcon;
>
> -	key = hci_find_link_key_type(hcon->hdev, conn->dst,
> -						HCI_LK_SMP_LTK);
> +	key = hci_find_ltk_addr(hcon->hdev, conn->dst, hcon->dst_type);
>   	if (!key)
>   		return 0;
>
> @@ -711,10 +710,8 @@ static u8 smp_ltk_encrypt(struct l2cap_conn *conn)
>   					&hcon->pend))
>   		return 1;
>
> -	master = (void *) key->data;
> -	hci_le_start_enc(hcon, master->ediv, master->rand,
> -						key->val);
> -	hcon->enc_key_size = key->pin_len;
> +	hci_le_start_enc(hcon, key->ediv, key->rand, key->val);
> +	hcon->enc_key_size = key->enc_size;
>
>   	return 1;
>
> @@ -817,13 +814,19 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
>   {
>   	struct smp_cmd_master_ident *rp = (void *) skb->data;
>   	struct smp_chan *smp = conn->smp_chan;
> +	struct hci_dev *hdev = conn->hcon->hdev;
> +	struct hci_conn *hcon = conn->hcon;
> +	u8 authenticated;
>
>   	skb_pull(skb, sizeof(*rp));
>
> -	hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->enc_key_size,
> -						rp->ediv, rp->rand, smp->tk);
> -
> +	hci_dev_lock(hdev);
> +	authenticated = (conn->hcon->sec_level == BT_SECURITY_HIGH);
> +	hci_add_ltk(conn->hcon->hdev, conn->dst, hcon->dst_type,
> +					HCI_SMP_LTK, 1, authenticated, smp->tk,
> +					smp->enc_key_size, rp->ediv, rp->rand);
>   	smp_distribute_keys(conn, 1);
> +	hci_dev_unlock(hdev);
>
>   	return 0;
>   }
> @@ -933,6 +936,8 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
>   	if (*keydist&  SMP_DIST_ENC_KEY) {
>   		struct smp_cmd_encrypt_info enc;
>   		struct smp_cmd_master_ident ident;
> +		struct hci_conn *hcon = conn->hcon;
> +		u8 authenticated;
>   		__le16 ediv;
>
>   		get_random_bytes(enc.ltk, sizeof(enc.ltk));
> @@ -941,8 +946,11 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
>
>   		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc),&enc);
>
> -		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->enc_key_size,
> -						ediv, ident.rand, enc.ltk);
> +		authenticated = hcon->sec_level == BT_SECURITY_HIGH;
> +		hci_add_ltk(conn->hcon->hdev, conn->dst, hcon->dst_type,
> +					HCI_SMP_LTK_SLAVE, 1, authenticated,
> +					enc.ltk, smp->enc_key_size,
> +					ediv, ident.rand);
>
>   		ident.ediv = cpu_to_le16(ediv);
>


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
