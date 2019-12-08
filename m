Return-Path: <SRS0=rPQ+=Z6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03E3C43603
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Dec 2019 09:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 986A4206D6
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Dec 2019 09:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfLHJpi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Dec 2019 04:45:38 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:34675 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfLHJph (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Dec 2019 04:45:37 -0500
Received: from marcel-macbook.holtmann.net (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 8BC34CED0A;
        Sun,  8 Dec 2019 10:54:45 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [RFC v2] Implementation of MGMT_OP_SET_BLOCKED_KEYS.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20191205170645.117976-1-alainm@chromium.org>
Date:   Sun, 8 Dec 2019 10:45:34 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <7930629A-7A57-40F8-BA68-D1730D0BCEC6@holtmann.org>
References: <20191205170645.117976-1-alainm@chromium.org>
To:     Alain Michaud <alainm@chromium.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

> Here's a newer version with most of your feedback addressed.  Others
> responses sent inline in the v1.

so lets put a proper commit message with all the details here. Don’t forget the Signed-off-by.

> 
> ---
> include/net/bluetooth/hci_core.h |  9 +++++
> include/net/bluetooth/mgmt.h     | 17 ++++++++++
> net/bluetooth/hci_core.c         | 56 ++++++++++++++++++++++++++++++--
> net/bluetooth/mgmt.c             | 51 +++++++++++++++++++++++++++++
> net/bluetooth/smp.c              |  8 +++++
> 5 files changed, 138 insertions(+), 3 deletions(-)

And comments for the reviewer can go here.

> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index b689aceb636b..e9a789e11493 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -118,6 +118,13 @@ struct bt_uuid {
> 	u8 svc_hint;
> };
> 
> +struct blocked_key {
> +	struct list_head list;
> +	struct rcu_head rcu;
> +	u8 type;
> +	u8 val[16];
> +};
> +
> struct smp_csrk {
> 	bdaddr_t bdaddr;
> 	u8 bdaddr_type;
> @@ -397,6 +404,7 @@ struct hci_dev {
> 	struct list_head	le_conn_params;
> 	struct list_head	pend_le_conns;
> 	struct list_head	pend_le_reports;
> +	struct list_head	blocked_keys;
> 
> 	struct hci_dev_stats	stat;
> 
> @@ -1121,6 +1129,7 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
> struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
> 			    u8 addr_type, u8 val[16], bdaddr_t *rpa);
> void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type);
> +bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16]);
> void hci_smp_irks_clear(struct hci_dev *hdev);
> 
> bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
> index 9cee7ddc6741..c9b1d39d6d6c 100644
> --- a/include/net/bluetooth/mgmt.h
> +++ b/include/net/bluetooth/mgmt.h
> @@ -654,6 +654,23 @@ struct mgmt_cp_set_phy_confguration {
> } __packed;
> #define MGMT_SET_PHY_CONFIGURATION_SIZE	4
> 
> +#define MGMT_OP_SET_BLOCKED_KEYS	0x0046
> +
> +#define HCI_BLOCKED_KEY_TYPE_LINKKEY	0x00
> +#define HCI_BLOCKED_KEY_TYPE_LTK		0x01
> +#define HCI_BLOCKED_KEY_TYPE_IRK		0x02
> +
> +struct mgmt_blocked_key_info {
> +	__u8 type;
> +	__u8 val[16];
> +} __packed;
> +
> +struct mgmt_cp_set_blocked_keys {
> +	__le16 key_count;
> +	struct mgmt_blocked_key_info keys[0];
> +} __packed;
> +#define MGMT_OP_SET_BLOCKED_KEYS_SIZE 0
> +
> #define MGMT_EV_CMD_COMPLETE		0x0001
> struct mgmt_ev_cmd_complete {
> 	__le16	opcode;
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 9e19d5a3aac8..52e7bf295a51 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2311,6 +2311,35 @@ void hci_smp_irks_clear(struct hci_dev *hdev)
> 	}
> }
> 
> +static void hci_blocked_keys_clear(struct hci_dev *hdev)
> +{
> +	struct blocked_key *b;
> +
> +	list_for_each_entry_rcu(b, &hdev->blocked_keys, list) {
> +		list_del_rcu(&b->list);
> +		kfree_rcu(b, rcu);
> +	}
> +}
> +
> +bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16])
> +{
> +	bool blocked = false;
> +	struct blocked_key *b;
> +
> +	rcu_read_lock();
> +	list_for_each_entry(b, &hdev->blocked_keys, list) {
> +		if (b->type == type &&
> +				!memcmp(b->val, val, sizeof(b->val))) {

Indentation error.

> +			blocked = true;
> +			goto done;

Isn’t break; enough here and we avoid the label.

> +		}
> +	}
> +
> +done:
> +	rcu_read_unlock();
> +	return blocked;
> +}
> +
> struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
> {
> 	struct link_key *k;
> @@ -2319,6 +2348,16 @@ struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
> 	list_for_each_entry_rcu(k, &hdev->link_keys, list) {
> 		if (bacmp(bdaddr, &k->bdaddr) == 0) {
> 			rcu_read_unlock();
> +
> +			if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_LINKKEY,
> +						k->val)) {
> +				WARN_ONCE(1, "Key blocked for %pMR", &k->bdaddr);

I just realized that I gave bad advice. WARN_ONCE is not going to do the right job. If we have multiple keys in our list it will only ever warn for the initial one.

So it might be better to create a new bt_warn_ratelimited and use that one.

> +
> +				/* The device may have refreshed it to a new one which
> +			 	 * would imply a second key is in the list */
> +				continue;

I am not sure this actually helps. The keys are created by a key agreement function. I would really just ignore this possibility. If the key refresh procedure is used, you can not guess the next key.

> +			}
> +
> 			return k;
> 		}
> 	}
> @@ -2387,6 +2426,12 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
> 
> 		if (smp_ltk_is_sc(k) || ltk_role(k->type) == role) {
> 			rcu_read_unlock();
> +
> +			if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_LTK, k->val)) {
> +				WARN_ONCE(1, "Key blocked for %pMR", &k->bdaddr);

See comment above with bt_warn_ratelimited.

> +				return NULL;
> +			}
> +
> 			return k;
> 		}
> 	}
> @@ -2548,10 +2593,13 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
> 	if (!key)
> 		return -ENOENT;
> 
> -	BT_DBG("%s removing %pMR", hdev->name, bdaddr);
> +	do {
> +		BT_DBG("%s removing %pMR", hdev->name, bdaddr);
> 
> -	list_del_rcu(&key->list);
> -	kfree_rcu(key, rcu);
> +		list_del_rcu(&key->list);
> +		kfree_rcu(key, rcu);
> +		key = hci_find_link_key(hdev, bdaddr);
> +	} while (key);

I am still not convinced here. If we have more than one link key for a given address, we do have a problem. We should check that this doesn’t happen in the first place.

> 
> 	return 0;
> }
> @@ -3244,6 +3292,7 @@ struct hci_dev *hci_alloc_dev(void)
> 	INIT_LIST_HEAD(&hdev->pend_le_reports);
> 	INIT_LIST_HEAD(&hdev->conn_hash.list);
> 	INIT_LIST_HEAD(&hdev->adv_instances);
> +	INIT_LIST_HEAD(&hdev->blocked_keys);
> 
> 	INIT_WORK(&hdev->rx_work, hci_rx_work);
> 	INIT_WORK(&hdev->cmd_work, hci_cmd_work);
> @@ -3443,6 +3492,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
> 	hci_bdaddr_list_clear(&hdev->le_resolv_list);
> 	hci_conn_params_clear_all(hdev);
> 	hci_discovery_filter_clear(hdev);
> +	hci_blocked_keys_clear(hdev);
> 	hci_dev_unlock(hdev);
> 
> 	hci_dev_put(hdev);
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index acb7c6d5643f..6fb4ce768863 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -106,6 +106,7 @@ static const u16 mgmt_commands[] = {
> 	MGMT_OP_START_LIMITED_DISCOVERY,
> 	MGMT_OP_READ_EXT_INFO,
> 	MGMT_OP_SET_APPEARANCE,
> +	MGMT_OP_SET_BLOCKED_KEYS,
> };

Once this patch has made it upstream, you might also want to send a patch to increase the minor version for mgmt interface. While we don’t actually use it, it is an extra precaution to allow distinguishing kernel release if ever needed. And I think the last time I added new commands, I totally forgot it.

> 
> static const u16 mgmt_events[] = {
> @@ -3531,6 +3532,55 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
> 	return err;
> }
> 
> +static int set_blocked_keys(struct sock *sk, struct hci_dev *hdev, void *data,
> +			  u16 len)
> +{
> +	int err = MGMT_STATUS_SUCCESS;
> +
> +	if (len < sizeof (struct mgmt_cp_set_blocked_keys) ||
> +	    ((len - offsetof(struct mgmt_cp_set_blocked_keys, keys)) %
> +			sizeof(struct mgmt_blocked_key_info))) {

So I have no idea what the indentation rule is for this. Can we introduce a helper macro for this?

> +		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_BLOCKED_KEYS,
> +				MGMT_STATUS_INVALID_PARAMS, NULL, 0);
> +	}
> +
> +	hci_dev_lock(hdev);
> +	{
> +		struct mgmt_cp_set_blocked_keys *keys = data;
> +		int i;
> +		for (i = 0; i < keys->key_count; ++i) {
> +			bool already_blocked = false;
> +			struct blocked_key *b;
> +
> +			list_for_each_entry(b, &hdev->blocked_keys, list) {
> +				if (keys->keys[i].type == b->type &&
> +					!memcmp(keys->keys[i].val, b->val,
> +							sizeof(keys->keys[i].val))) {
> +					already_blocked = true;
> +					break;
> +				}
> +			}
> +
> +			if (already_blocked)
> +				continue;
> +
> +			b = kzalloc(sizeof(*b), GFP_KERNEL);
> +			if (!b) {
> +				err = MGMT_STATUS_NO_RESOURCES;
> +				break;
> +			}
> +
> +			b->type = keys->keys[i].type;
> +			memcpy(b->val, keys->keys[i].val, sizeof(b->val));
> +			list_add_rcu(&b->list, &hdev->blocked_keys);
> +		}
> +	}

Lets avoid the extra { } and the indentation.

> +	hci_dev_unlock(hdev);
> +
> +	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_BLOCKED_KEYS,
> +				err, NULL, 0);
> +}
> +
> static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
> 				         u16 opcode, struct sk_buff *skb)
> {
> @@ -6914,6 +6964,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
> 	{ set_appearance,	   MGMT_SET_APPEARANCE_SIZE },
> 	{ get_phy_configuration,   MGMT_GET_PHY_CONFIGURATION_SIZE },
> 	{ set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
> +	{ set_blocked_keys,	   MGMT_OP_SET_BLOCKED_KEYS_SIZE },
> };
> 
> void mgmt_index_added(struct hci_dev *hdev)
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index 6b42be4b5861..f61c78d81168 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -2453,6 +2453,10 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
> 	if (skb->len < sizeof(*rp))
> 		return SMP_INVALID_PARAMS;
> 
> +	if (hci_is_blocked_key(conn->hcon->hdev, HCI_BLOCKED_KEY_TYPE_LTK,
> +			rp->ltk))

Please fix the indentation here.

> +		return SMP_INVALID_PARAMS;
> +
> 	SMP_ALLOW_CMD(smp, SMP_CMD_MASTER_IDENT);
> 
> 	skb_pull(skb, sizeof(*rp));
> @@ -2509,6 +2513,10 @@ static int smp_cmd_ident_info(struct l2cap_conn *conn, struct sk_buff *skb)
> 	if (skb->len < sizeof(*info))
> 		return SMP_INVALID_PARAMS;
> 
> +	if (hci_is_blocked_key(conn->hcon->hdev, HCI_BLOCKED_KEY_TYPE_IRK,
> +			info->irk))

Same as above.

> +		return SMP_INVALID_PARAMS;
> +
> 	SMP_ALLOW_CMD(smp, SMP_CMD_IDENT_ADDR_INFO);
> 
> 	skb_pull(skb, sizeof(*info));

Regards

Marcel

