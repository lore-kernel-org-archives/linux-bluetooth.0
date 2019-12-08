Return-Path: <SRS0=rPQ+=Z6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC14C43603
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Dec 2019 08:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5023220637
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 Dec 2019 08:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725878AbfLHIuy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 Dec 2019 03:50:54 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:35218 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfLHIuy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 Dec 2019 03:50:54 -0500
Received: from marcel-macbook.holtmann.net (p4FF9F0D1.dip0.t-ipconnect.de [79.249.240.209])
        by mail.holtmann.org (Postfix) with ESMTPSA id 57111CED09;
        Sun,  8 Dec 2019 10:00:00 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [RFC] Implementation of MGMT_OP_SET_BLOCKED_KEYS.
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALWDO_Vpq37zpzTGYm7NhyuXEJMngqs+pxCAFqF8pEJGXDanCw@mail.gmail.com>
Date:   Sun, 8 Dec 2019 09:50:48 +0100
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <EFFE342A-5977-4750-8E9B-7F40C2E6DD2C@holtmann.org>
References: <20191204013407.30221-1-alainm@chromium.org>
 <202D87A7-8F03-4343-B0F3-1788C9CC6EEE@holtmann.org>
 <CALWDO_Vpq37zpzTGYm7NhyuXEJMngqs+pxCAFqF8pEJGXDanCw@mail.gmail.com>
To:     Alain Michaud <alainmichaud@google.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

>>> Would love comments on this.  Corresponding user mode changes also
>>> submitted for comments.
>>> 
>>> ---
>>> include/net/bluetooth/hci_core.h | 15 ++++++++++
>>> include/net/bluetooth/mgmt.h     | 13 +++++++++
>>> net/bluetooth/hci_core.c         | 50 ++++++++++++++++++++++++++++++--
>>> net/bluetooth/mgmt.c             | 50 ++++++++++++++++++++++++++++++++
>>> net/bluetooth/smp.c              |  8 +++++
>>> 5 files changed, 133 insertions(+), 3 deletions(-)
>>> 
>>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>>> index b689aceb636b..4de9e3a21e7d 100644
>>> --- a/include/net/bluetooth/hci_core.h
>>> +++ b/include/net/bluetooth/hci_core.h
>>> @@ -118,6 +118,19 @@ struct bt_uuid {
>>>      u8 svc_hint;
>>> };
>>> 
>>> +enum hci_blocked_key_type {
>>> +     HCI_BLOCKED_KEY_TYPE_LINKKEY    = 0x00,
>>> +     HCI_BLOCKED_KEY_TYPE_LTK                = 0x01,
>>> +     HCI_BLOCKED_KEY_TYPE_IRK                = 0x02,
>>> +};
>> 
>> we are not using really using enum that much in this part of the code. Also this should go into mgmt.h actually.
> [alain] Ack.  Changed into #defines and moved to mgmt.h following
> existing patterns.
>> 
>>> +
>>> +struct blocked_key {
>>> +     struct list_head list;
>>> +     struct rcu_head rcu;
>>> +     u8 type;
>>> +     u8 val[16];
>>> +};
>>> +
>>> struct smp_csrk {
>>>      bdaddr_t bdaddr;
>>>      u8 bdaddr_type;
>>> @@ -397,6 +410,7 @@ struct hci_dev {
>>>      struct list_head        le_conn_params;
>>>      struct list_head        pend_le_conns;
>>>      struct list_head        pend_le_reports;
>>> +     struct list_head        blocked_keys;
>>> 
>>>      struct hci_dev_stats    stat;
>>> 
>>> @@ -1121,6 +1135,7 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
>>> struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
>>>                          u8 addr_type, u8 val[16], bdaddr_t *rpa);
>>> void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type);
>>> +bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16]);
>>> void hci_smp_irks_clear(struct hci_dev *hdev);
>>> 
>>> bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
>>> diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
>>> index 9cee7ddc6741..3d780da835fc 100644
>>> --- a/include/net/bluetooth/mgmt.h
>>> +++ b/include/net/bluetooth/mgmt.h
>>> @@ -654,6 +654,19 @@ struct mgmt_cp_set_phy_confguration {
>>> } __packed;
>>> #define MGMT_SET_PHY_CONFIGURATION_SIZE       4
>>> 
>>> +#define MGMT_OP_SET_BLOCKED_KEYS     0x0046
>>> +
>>> +struct mgmt_blocked_key_info {
>>> +     __u8 type;
>>> +     __u8 val[16];
>>> +} __packed;
>>> +
>>> +struct mgmt_cp_set_blocked_keys {
>>> +     __le16 key_count;
>>> +     struct mgmt_blocked_key_info keys[0];
>>> +} __packed;
>>> +#define MGMT_OP_SET_BLOCKED_KEYS_SIZE 0
>>> +
>>> #define MGMT_EV_CMD_COMPLETE          0x0001
>>> struct mgmt_ev_cmd_complete {
>>>      __le16  opcode;
>>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>>> index 9e19d5a3aac8..e72434258c39 100644
>>> --- a/net/bluetooth/hci_core.c
>>> +++ b/net/bluetooth/hci_core.c
>>> @@ -2311,6 +2311,16 @@ void hci_smp_irks_clear(struct hci_dev *hdev)
>>>      }
>>> }
>>> 
>>> +void hci_blocked_keys_clear(struct hci_dev *hdev)
>>> +{
>>> +     struct blocked_key *b;
>>> +
>>> +     list_for_each_entry_rcu(b, &hdev->blocked_keys, list) {
>>> +             list_del_rcu(&b->list);
>>> +             kfree_rcu(b, rcu);
>>> +     }
>>> +}
>>> +
>> 
>> This can be static, right?
> [alain] Ack. Fixed.  I'll send another patch to fix the other
> functions I used to follow the pattern.
>> 
>>> struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
>>> {
>>>      struct link_key *k;
>>> @@ -2319,6 +2329,12 @@ struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
>>>      list_for_each_entry_rcu(k, &hdev->link_keys, list) {
>>>              if (bacmp(bdaddr, &k->bdaddr) == 0) {
>>>                      rcu_read_unlock();
>>> +
>>> +                     if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_LINKKEY, k->val))
>>> +                             /* The device may have refreshed it to a new one which
>>> +                              * would imply a second key is in the list */
>>> +                             continue;
>>> +
>> 
>> In this case put the { } around to make it clear where the body is. I know that the compiler doesn’t need it, but for the human it is easier to read. Or alternatively put the comment above the if clause.
> [alain] Ack. Fixed.
>> 
>> I would additionally maybe add a warn_once() here.
> [alain] Ack. Added.
>> 
>> Now coming to read the comment again, I do not get it. What has the key refresh to do with this?
> [alain] This is very much theoretical, but technically, it is possible
> that a new link key was added between the time the device was
> originally connected and the time the key was blocked by userland.
> The end result is that there could be more than one key into the
> store.   The code will continue in case a second key is available for
> the same device.

since with BR/EDR they keys are always a result of a key agreement function, I think this is just that. Frankly you will not be able to end up with a LK blacklist. Same as for LE pairing with ECDH, you will not end up with a LTK blacklist. This is pretty much just LE legacy pairing LTKs and IRKs.

So for the keys are a generated by a key agreement function, lets not go overboard. Even the re-keying will be safe.

The only case where you can have this for LK and LTK if they are distributed out-of-band (without the spec defined out-of-band pairing) and systems just using that key. I have not seen a system doing that in all the years.

>> 
>>>                      return k;
>>>              }
>>>      }
>>> @@ -2387,6 +2403,10 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
>>> 
>>>              if (smp_ltk_is_sc(k) || ltk_role(k->type) == role) {
>>>                      rcu_read_unlock();
>>> +
>>> +                     if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE_LTK, k->val))
>>> +                             return NULL;
>>> +
>> 
>> Same as above, I would add a warn_once.
> [alain] Ack, Added.
>> 
>>>                      return k;
>>>              }
>>>      }
>>> @@ -2540,6 +2560,25 @@ struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
>>>      return irk;
>>> }
>>> 
>>> +bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16])
>>> +{
>>> +     bool blocked = false;
>>> +     struct blocked_key *b;
>>> +
>>> +     rcu_read_lock();
>>> +     list_for_each_entry(b, &hdev->blocked_keys, list) {
>>> +             if (b->type == type &&
>>> +                             !memcmp(b->val, val, sizeof(b->val))) {
>>> +                     blocked = true;
>>> +                     goto done;
>>> +             }
>>> +     }
>>> +
>>> +done:
>>> +     rcu_read_unlock();
>>> +     return blocked;
>>> +}
>> 
>> Lets move this above its users.
> [alain] Ack. Moved.
>> 
>>> +
>>> int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
>>> {
>>>      struct link_key *key;
>>> @@ -2548,10 +2587,13 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
>>>      if (!key)
>>>              return -ENOENT;
>>> 
>>> -     BT_DBG("%s removing %pMR", hdev->name, bdaddr);
>>> +     do {
>>> +             BT_DBG("%s removing %pMR", hdev->name, bdaddr);
>>> 
>>> -     list_del_rcu(&key->list);
>>> -     kfree_rcu(key, rcu);
>>> +             list_del_rcu(&key->list);
>>> +             kfree_rcu(key, rcu);
>>> +             key = hci_find_link_key(hdev, bdaddr);
>>> +     } while (key);
>>> 
>> 
>> I don’t understand this change. Also this has nothing to do with this patch.
> [alain] This is also related to the possibility that more than one key
> is in the list if the original was blocked and a new one is generated.
> The block in hci_find_linkkey will return NULL even if a key is
> potentially in the list.  This change will ensure that all are
> deleted.

With my comment above, I think we can even neglect this one as well.

>> 
>>>      return 0;
>>> }
>>> @@ -3244,6 +3286,7 @@ struct hci_dev *hci_alloc_dev(void)
>>>      INIT_LIST_HEAD(&hdev->pend_le_reports);
>>>      INIT_LIST_HEAD(&hdev->conn_hash.list);
>>>      INIT_LIST_HEAD(&hdev->adv_instances);
>>> +     INIT_LIST_HEAD(&hdev->blocked_keys);
>>> 
>>>      INIT_WORK(&hdev->rx_work, hci_rx_work);
>>>      INIT_WORK(&hdev->cmd_work, hci_cmd_work);
>>> @@ -3443,6 +3486,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
>>>      hci_bdaddr_list_clear(&hdev->le_resolv_list);
>>>      hci_conn_params_clear_all(hdev);
>>>      hci_discovery_filter_clear(hdev);
>>> +     hci_blocked_keys_clear(hdev);
>>>      hci_dev_unlock(hdev);
>>> 
>>>      hci_dev_put(hdev);
>>> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
>>> index acb7c6d5643f..f45475a7c854 100644
>>> --- a/net/bluetooth/mgmt.c
>>> +++ b/net/bluetooth/mgmt.c
>>> @@ -106,6 +106,7 @@ static const u16 mgmt_commands[] = {
>>>      MGMT_OP_START_LIMITED_DISCOVERY,
>>>      MGMT_OP_READ_EXT_INFO,
>>>      MGMT_OP_SET_APPEARANCE,
>>> +     MGMT_OP_SET_BLOCKED_KEYS,
>>> };
>>> 
>>> static const u16 mgmt_events[] = {
>>> @@ -3531,6 +3532,54 @@ static int set_phy_configuration(struct sock *sk, struct hci_dev *hdev,
>>>      return err;
>>> }
>>> 
>>> +static int set_blocked_keys(struct sock *sk, struct hci_dev *hdev, void *data,
>>> +                       u16 len)
>>> +{
>>> +     int err = MGMT_STATUS_SUCCESS;
>>> +
>>> +     if (len < sizeof (struct mgmt_cp_set_blocked_keys) ||
>>> +             ((len - offsetof(struct mgmt_cp_set_blocked_keys, keys)) %
>>> +                     sizeof(struct mgmt_blocked_key_info))) {
>> 
>> The indentation is wrong here. Maybe we need to create a macro for this since we have multiple cases checking the size of these kind of structures.
> [alain] Ack.  Sorry, still learning the linux kernel style with tabs and all :)
>> 
>>> +             return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_BLOCKED_KEYS,
>>> +                             MGMT_STATUS_INVALID_PARAMS, NULL, 0);
>>> +     }
>>> +
>>> +     hci_dev_lock(hdev);
>>> +     {
>>> +             struct mgmt_cp_set_blocked_keys *keys = data;
>>> +             int i;
>> 
>> Just put these variable at the top. I am all for reducing the scope, but you pay for it with another indentation.
> [alain] Is this a general practice or part of some general guidance?
> I mean reduced scope is less valuable than a reduced indentation?

This more a personal taste. I am a big fan of readable code and let the compiler do the optimization. We want to stay below 80 chars in width. And that means you have only 6 indentation. I also prefer limited multi-line function calls. So if you look at the codebase right now, we have preferred keeping code as less indented as possible to allow for an easy read-flow through a function.

> 
>> 
>>> +             for (i = 0; i < keys->key_count; ++i) {
>>> +                     bool alreadyBlocked = false;
>>> +                     struct blocked_key *b;
>> 
>> So after variable declaration, we normally have an empty line. And camel case variable names are not used.
> [alain] Ack, fixed.
>> 
>>> +                     list_for_each_entry(b, &hdev->blocked_keys, list) {
>>> +                             if (keys->keys[i].type == b->type &&
>>> +                                     !memcmp(keys->keys[i].val, b->val,
>>> +                                                     sizeof(keys->keys[i].val))) {
>>> +                                     alreadyBlocked = true;
>>> +                                     break;
>>> +                             }
>>> +                     }
>>> +
>>> +                     if (alreadyBlocked)
>>> +                             continue;
>> 
>> However, I would not even bother to check for duplicates. If there is a duplicate loaded by userspace, so be it.
> [alain] This seems to be a relatively small code footprint to avoid
> wasting kernel memory no?

Sure, but the main user is bluetoothd and I assume you got the code right there. If there is another userspace around and too stupid to get this right, they most likely will fix it quickly.

>> 
>>> +
>>> +                     b = kzalloc(sizeof(*b), GFP_KERNEL);
>>> +                     if (!b) {
>>> +                             err = MGMT_STATUS_NO_RESOURCES;
>>> +                             break;
>>> +                     }
>>> +
>>> +                     b->type = keys->keys[i].type;
>>> +                     memcpy(b->val, keys->keys[i].val, sizeof(b->val));
>>> +                     list_add_rcu(&b->list, &hdev->blocked_keys);
>>> +             }
>>> +     }
>>> +     hci_dev_unlock(hdev);
>>> +
>>> +     return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_BLOCKED_KEYS,
>>> +                             err, NULL, 0);
>>> +}
>>> +
>>> static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
>>>                                       u16 opcode, struct sk_buff *skb)
>>> {
>>> @@ -6914,6 +6963,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
>>>      { set_appearance,          MGMT_SET_APPEARANCE_SIZE },
>>>      { get_phy_configuration,   MGMT_GET_PHY_CONFIGURATION_SIZE },
>>>      { set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
>>> +     { set_blocked_keys,        MGMT_OP_SET_BLOCKED_KEYS_SIZE },
>>> };
>>> 
>>> void mgmt_index_added(struct hci_dev *hdev)
>>> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
>>> index 6b42be4b5861..f61c78d81168 100644
>>> --- a/net/bluetooth/smp.c
>>> +++ b/net/bluetooth/smp.c
>>> @@ -2453,6 +2453,10 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
>>>      if (skb->len < sizeof(*rp))
>>>              return SMP_INVALID_PARAMS;
>>> 
>>> +     if (hci_is_blocked_key(conn->hcon->hdev, HCI_BLOCKED_KEY_TYPE_LTK,
>>> +                     rp->ltk))
>>> +             return SMP_INVALID_PARAMS;
>>> +
>>>      SMP_ALLOW_CMD(smp, SMP_CMD_MASTER_IDENT);
>> 
>> Now this is a good question. Should we allow pairing with a blocked LTK and then just refuse to establish the link later like we do with BR/EDR or forcefully refuse it. This is for legacy pairing only anyway where the LTKs are distributed.
> [alain] From a user experience standpoint, I'd argue it is probably
> better to fail the pairing so the user is aware that something is
> wrong, rather than succeeding pairing then letting the device in a
> state where it will never work.

In principle I am with you. However I also prefer that BR/EDR and LE works similar. If we behave a certain way on one bearer, we should do the same on the other. So how does this compare in this case?

>> 
>>> 
>>>      skb_pull(skb, sizeof(*rp));
>>> @@ -2509,6 +2513,10 @@ static int smp_cmd_ident_info(struct l2cap_conn *conn, struct sk_buff *skb)
>>>      if (skb->len < sizeof(*info))
>>>              return SMP_INVALID_PARAMS;
>>> 
>>> +     if (hci_is_blocked_key(conn->hcon->hdev, HCI_BLOCKED_KEY_TYPE_IRK,
>>> +                     info->irk))
>>> +             return SMP_INVALID_PARAMS;
>>> +
>> 
>> Same here. In addition, we might want to skip using a blacked IRK if it gets loaded via Load Identity Resolving Keys. Right now an already established black listed IRK will be used.
> [alain] I had actually considered adding the block in hci_find_irk_by*
> but figured that given it's not a security issue but rather a privacy
> issue for the device itself, I didn't block it thinking it's probably
> best for the system to be able to resovle the key, but then fail the
> connection so the user at least understand that the system is able to
> see the device, but not connect to it.  I'm open to feedback on this
> since I don't feel particularly strong either way.

I would do it for practical reasons in this case. The storage for controller resolving is limited and I rather not waste space in the controller for a key that is blacklisted.

>> 
>>>      SMP_ALLOW_CMD(smp, SMP_CMD_IDENT_ADDR_INFO);
>>> 
>>>      skb_pull(skb, sizeof(*info));
>> 
>> Maybe instead of checking the keys all the time, we should just remove them from kernel memory. So when we do a Load Blocked Keys, we go through our list of known keys and purge the blocked ones. In addition when Loading IRK, LTK, LK we checked against the blocked list and don’t add the ones on the list.
> [alain] I think this might be at the expense of considering the device
> as not paired which I don't know if it has other implications.  I
> propose we keep using this strategy and if the list of blocked keys
> becomes too large, we can use this to optimize the kernel memory
> usage.

Fine. Just wanted to raise it.

>> 
>> And we let pairing succeed, but don’t store the keys. This might be a bit of a problem since we tell userspace about pairing success by sending it the key to store. I am open for thoughts.
> [alain] See comment above.  The design was primarily motivated to
> allow the user to know that something is up with the device during
> pairing rather than leaving the device in a state where it looks
> paired but will never work.

Fair point.

Regards

Marcel

