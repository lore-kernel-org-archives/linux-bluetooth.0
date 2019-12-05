Return-Path: <SRS0=lPNB=Z3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8AAC43603
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Dec 2019 15:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD484224F8
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Dec 2019 15:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqqMpm9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfLEPTc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Dec 2019 10:19:32 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46691 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbfLEPTc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Dec 2019 10:19:32 -0500
Received: by mail-lj1-f196.google.com with SMTP id z17so3960560ljk.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Dec 2019 07:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MAQdg5NyHb7CkpBNpDDL7iuookjPL8ZPyLGS2yxjSQU=;
        b=FqqMpm9BTSLlHNpepvcCD4foiQ+eYXy3lm1J0dthfaY3aSDjyvWl1xYMiNrN8qIb1R
         038ogv11OWjnXbSGlDp5/63JqacwLslT0MRQmnr/tgcVU9FIcX0nIB3PvsR5s61EMsQY
         Mch2cL3T+0z/rx02ZZIczJcV8GIHEzFSh+PmmnjqZ29W/8FujkOwyfsX4MqtRLHTWYW+
         Qpx8oNEry3LrCCGugGMyE+4wcU4KITFDbH2Hg3iuOv3qxpMqOzEZcfm1LWkaMvtHRwPa
         ysNoTl6GLn/uveJsqLFLv5Nu9QrxlUsite5m54kQ7Y4+JQBCZDHQL+5CkqLsTT0jER/M
         qE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MAQdg5NyHb7CkpBNpDDL7iuookjPL8ZPyLGS2yxjSQU=;
        b=KkrwHuJ+P6gr4TNHQNQSNHicYhjyfDlidSrLNyqI/zO14VNuCINvqIbILh0ktS8Rpe
         hCmXwxZr6PkD8H7pVpNowdoC5iICgTaNB+Qyoj7BWL0QfhHymZ7521EdZSd/UkQxVlww
         QgJhP8I2LYZnzsC9Qe5YsRF7SKTJKgBd0Q3P7BQKYXhcJu7FLahc1krpFb1t21slsWJV
         DmFtKvc0HwXX44i5aFqkwIWIY1LaJtIbxasCoyWW+lNkqYAUPV6i9JOlPsjax5y9FwKa
         1HoX26a421HmpbPrnqBnp/UvjHKBDKG5sS/Fta5QWjwFc+nT24LYN2HOJxwHLrn7VwbT
         621g==
X-Gm-Message-State: APjAAAVmocpb0+yFwBxs9soQGRW6Ra0MhNt00cAxSe2Pfcj/EVVzaXj7
        +T8eazeq484criNKXOWGwt1+uZFw0CU6BnwdAqBXwg==
X-Google-Smtp-Source: APXvYqzF1ADNAXiW9R2p+jAk269y3X2TGjz2wYObWkzuoL4ZT2p1EXLy0yGSD1DsDP74+5zpVXyQ/RHtr6dwVWMEL3o=
X-Received: by 2002:a2e:9f52:: with SMTP id v18mr5191292ljk.30.1575559166721;
 Thu, 05 Dec 2019 07:19:26 -0800 (PST)
MIME-Version: 1.0
References: <20191204013407.30221-1-alainm@chromium.org> <202D87A7-8F03-4343-B0F3-1788C9CC6EEE@holtmann.org>
In-Reply-To: <202D87A7-8F03-4343-B0F3-1788C9CC6EEE@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Thu, 5 Dec 2019 10:19:14 -0500
Message-ID: <CALWDO_Vpq37zpzTGYm7NhyuXEJMngqs+pxCAFqF8pEJGXDanCw@mail.gmail.com>
Subject: Re: [RFC] Implementation of MGMT_OP_SET_BLOCKED_KEYS.
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for the feedback Marcel.  v2 is on the way shortly.


On Thu, Dec 5, 2019 at 2:51 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > Would love comments on this.  Corresponding user mode changes also
> > submitted for comments.
> >
> > ---
> > include/net/bluetooth/hci_core.h | 15 ++++++++++
> > include/net/bluetooth/mgmt.h     | 13 +++++++++
> > net/bluetooth/hci_core.c         | 50 ++++++++++++++++++++++++++++++--
> > net/bluetooth/mgmt.c             | 50 ++++++++++++++++++++++++++++++++
> > net/bluetooth/smp.c              |  8 +++++
> > 5 files changed, 133 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index b689aceb636b..4de9e3a21e7d 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -118,6 +118,19 @@ struct bt_uuid {
> >       u8 svc_hint;
> > };
> >
> > +enum hci_blocked_key_type {
> > +     HCI_BLOCKED_KEY_TYPE_LINKKEY    =3D 0x00,
> > +     HCI_BLOCKED_KEY_TYPE_LTK                =3D 0x01,
> > +     HCI_BLOCKED_KEY_TYPE_IRK                =3D 0x02,
> > +};
>
> we are not using really using enum that much in this part of the code. Al=
so this should go into mgmt.h actually.
[alain] Ack.  Changed into #defines and moved to mgmt.h following
existing patterns.
>
> > +
> > +struct blocked_key {
> > +     struct list_head list;
> > +     struct rcu_head rcu;
> > +     u8 type;
> > +     u8 val[16];
> > +};
> > +
> > struct smp_csrk {
> >       bdaddr_t bdaddr;
> >       u8 bdaddr_type;
> > @@ -397,6 +410,7 @@ struct hci_dev {
> >       struct list_head        le_conn_params;
> >       struct list_head        pend_le_conns;
> >       struct list_head        pend_le_reports;
> > +     struct list_head        blocked_keys;
> >
> >       struct hci_dev_stats    stat;
> >
> > @@ -1121,6 +1135,7 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_d=
ev *hdev, bdaddr_t *bdaddr,
> > struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
> >                           u8 addr_type, u8 val[16], bdaddr_t *rpa);
> > void hci_remove_irk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_typ=
e);
> > +bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16]);
> > void hci_smp_irks_clear(struct hci_dev *hdev);
> >
> > bool hci_bdaddr_is_paired(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 ty=
pe);
> > diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.=
h
> > index 9cee7ddc6741..3d780da835fc 100644
> > --- a/include/net/bluetooth/mgmt.h
> > +++ b/include/net/bluetooth/mgmt.h
> > @@ -654,6 +654,19 @@ struct mgmt_cp_set_phy_confguration {
> > } __packed;
> > #define MGMT_SET_PHY_CONFIGURATION_SIZE       4
> >
> > +#define MGMT_OP_SET_BLOCKED_KEYS     0x0046
> > +
> > +struct mgmt_blocked_key_info {
> > +     __u8 type;
> > +     __u8 val[16];
> > +} __packed;
> > +
> > +struct mgmt_cp_set_blocked_keys {
> > +     __le16 key_count;
> > +     struct mgmt_blocked_key_info keys[0];
> > +} __packed;
> > +#define MGMT_OP_SET_BLOCKED_KEYS_SIZE 0
> > +
> > #define MGMT_EV_CMD_COMPLETE          0x0001
> > struct mgmt_ev_cmd_complete {
> >       __le16  opcode;
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 9e19d5a3aac8..e72434258c39 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2311,6 +2311,16 @@ void hci_smp_irks_clear(struct hci_dev *hdev)
> >       }
> > }
> >
> > +void hci_blocked_keys_clear(struct hci_dev *hdev)
> > +{
> > +     struct blocked_key *b;
> > +
> > +     list_for_each_entry_rcu(b, &hdev->blocked_keys, list) {
> > +             list_del_rcu(&b->list);
> > +             kfree_rcu(b, rcu);
> > +     }
> > +}
> > +
>
> This can be static, right?
[alain] Ack. Fixed.  I'll send another patch to fix the other
functions I used to follow the pattern.
>
> > struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdad=
dr)
> > {
> >       struct link_key *k;
> > @@ -2319,6 +2329,12 @@ struct link_key *hci_find_link_key(struct hci_de=
v *hdev, bdaddr_t *bdaddr)
> >       list_for_each_entry_rcu(k, &hdev->link_keys, list) {
> >               if (bacmp(bdaddr, &k->bdaddr) =3D=3D 0) {
> >                       rcu_read_unlock();
> > +
> > +                     if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE=
_LINKKEY, k->val))
> > +                             /* The device may have refreshed it to a =
new one which
> > +                              * would imply a second key is in the lis=
t */
> > +                             continue;
> > +
>
> In this case put the { } around to make it clear where the body is. I kno=
w that the compiler doesn=E2=80=99t need it, but for the human it is easier=
 to read. Or alternatively put the comment above the if clause.
[alain] Ack. Fixed.
>
> I would additionally maybe add a warn_once() here.
[alain] Ack. Added.
>
> Now coming to read the comment again, I do not get it. What has the key r=
efresh to do with this?
[alain] This is very much theoretical, but technically, it is possible
that a new link key was added between the time the device was
originally connected and the time the key was blocked by userland.
The end result is that there could be more than one key into the
store.   The code will continue in case a second key is available for
the same device.
>
> >                       return k;
> >               }
> >       }
> > @@ -2387,6 +2403,10 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hde=
v, bdaddr_t *bdaddr,
> >
> >               if (smp_ltk_is_sc(k) || ltk_role(k->type) =3D=3D role) {
> >                       rcu_read_unlock();
> > +
> > +                     if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE=
_LTK, k->val))
> > +                             return NULL;
> > +
>
> Same as above, I would add a warn_once.
[alain] Ack, Added.
>
> >                       return k;
> >               }
> >       }
> > @@ -2540,6 +2560,25 @@ struct smp_irk *hci_add_irk(struct hci_dev *hdev=
, bdaddr_t *bdaddr,
> >       return irk;
> > }
> >
> > +bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16])
> > +{
> > +     bool blocked =3D false;
> > +     struct blocked_key *b;
> > +
> > +     rcu_read_lock();
> > +     list_for_each_entry(b, &hdev->blocked_keys, list) {
> > +             if (b->type =3D=3D type &&
> > +                             !memcmp(b->val, val, sizeof(b->val))) {
> > +                     blocked =3D true;
> > +                     goto done;
> > +             }
> > +     }
> > +
> > +done:
> > +     rcu_read_unlock();
> > +     return blocked;
> > +}
>
> Lets move this above its users.
[alain] Ack. Moved.
>
> > +
> > int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
> > {
> >       struct link_key *key;
> > @@ -2548,10 +2587,13 @@ int hci_remove_link_key(struct hci_dev *hdev, b=
daddr_t *bdaddr)
> >       if (!key)
> >               return -ENOENT;
> >
> > -     BT_DBG("%s removing %pMR", hdev->name, bdaddr);
> > +     do {
> > +             BT_DBG("%s removing %pMR", hdev->name, bdaddr);
> >
> > -     list_del_rcu(&key->list);
> > -     kfree_rcu(key, rcu);
> > +             list_del_rcu(&key->list);
> > +             kfree_rcu(key, rcu);
> > +             key =3D hci_find_link_key(hdev, bdaddr);
> > +     } while (key);
> >
>
> I don=E2=80=99t understand this change. Also this has nothing to do with =
this patch.
[alain] This is also related to the possibility that more than one key
is in the list if the original was blocked and a new one is generated.
The block in hci_find_linkkey will return NULL even if a key is
potentially in the list.  This change will ensure that all are
deleted.

>
> >       return 0;
> > }
> > @@ -3244,6 +3286,7 @@ struct hci_dev *hci_alloc_dev(void)
> >       INIT_LIST_HEAD(&hdev->pend_le_reports);
> >       INIT_LIST_HEAD(&hdev->conn_hash.list);
> >       INIT_LIST_HEAD(&hdev->adv_instances);
> > +     INIT_LIST_HEAD(&hdev->blocked_keys);
> >
> >       INIT_WORK(&hdev->rx_work, hci_rx_work);
> >       INIT_WORK(&hdev->cmd_work, hci_cmd_work);
> > @@ -3443,6 +3486,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
> >       hci_bdaddr_list_clear(&hdev->le_resolv_list);
> >       hci_conn_params_clear_all(hdev);
> >       hci_discovery_filter_clear(hdev);
> > +     hci_blocked_keys_clear(hdev);
> >       hci_dev_unlock(hdev);
> >
> >       hci_dev_put(hdev);
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index acb7c6d5643f..f45475a7c854 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -106,6 +106,7 @@ static const u16 mgmt_commands[] =3D {
> >       MGMT_OP_START_LIMITED_DISCOVERY,
> >       MGMT_OP_READ_EXT_INFO,
> >       MGMT_OP_SET_APPEARANCE,
> > +     MGMT_OP_SET_BLOCKED_KEYS,
> > };
> >
> > static const u16 mgmt_events[] =3D {
> > @@ -3531,6 +3532,54 @@ static int set_phy_configuration(struct sock *sk=
, struct hci_dev *hdev,
> >       return err;
> > }
> >
> > +static int set_blocked_keys(struct sock *sk, struct hci_dev *hdev, voi=
d *data,
> > +                       u16 len)
> > +{
> > +     int err =3D MGMT_STATUS_SUCCESS;
> > +
> > +     if (len < sizeof (struct mgmt_cp_set_blocked_keys) ||
> > +             ((len - offsetof(struct mgmt_cp_set_blocked_keys, keys)) =
%
> > +                     sizeof(struct mgmt_blocked_key_info))) {
>
> The indentation is wrong here. Maybe we need to create a macro for this s=
ince we have multiple cases checking the size of these kind of structures.
[alain] Ack.  Sorry, still learning the linux kernel style with tabs and al=
l :)
>
> > +             return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_BLOCKE=
D_KEYS,
> > +                             MGMT_STATUS_INVALID_PARAMS, NULL, 0);
> > +     }
> > +
> > +     hci_dev_lock(hdev);
> > +     {
> > +             struct mgmt_cp_set_blocked_keys *keys =3D data;
> > +             int i;
>
> Just put these variable at the top. I am all for reducing the scope, but =
you pay for it with another indentation.
[alain] Is this a general practice or part of some general guidance?
I mean reduced scope is less valuable than a reduced indentation?

>
> > +             for (i =3D 0; i < keys->key_count; ++i) {
> > +                     bool alreadyBlocked =3D false;
> > +                     struct blocked_key *b;
>
> So after variable declaration, we normally have an empty line. And camel =
case variable names are not used.
[alain] Ack, fixed.
>
> > +                     list_for_each_entry(b, &hdev->blocked_keys, list)=
 {
> > +                             if (keys->keys[i].type =3D=3D b->type &&
> > +                                     !memcmp(keys->keys[i].val, b->val=
,
> > +                                                     sizeof(keys->keys=
[i].val))) {
> > +                                     alreadyBlocked =3D true;
> > +                                     break;
> > +                             }
> > +                     }
> > +
> > +                     if (alreadyBlocked)
> > +                             continue;
>
> However, I would not even bother to check for duplicates. If there is a d=
uplicate loaded by userspace, so be it.
[alain] This seems to be a relatively small code footprint to avoid
wasting kernel memory no?
>
> > +
> > +                     b =3D kzalloc(sizeof(*b), GFP_KERNEL);
> > +                     if (!b) {
> > +                             err =3D MGMT_STATUS_NO_RESOURCES;
> > +                             break;
> > +                     }
> > +
> > +                     b->type =3D keys->keys[i].type;
> > +                     memcpy(b->val, keys->keys[i].val, sizeof(b->val))=
;
> > +                     list_add_rcu(&b->list, &hdev->blocked_keys);
> > +             }
> > +     }
> > +     hci_dev_unlock(hdev);
> > +
> > +     return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_BLOCKED_KEYS,
> > +                             err, NULL, 0);
> > +}
> > +
> > static void read_local_oob_data_complete(struct hci_dev *hdev, u8 statu=
s,
> >                                        u16 opcode, struct sk_buff *skb)
> > {
> > @@ -6914,6 +6963,7 @@ static const struct hci_mgmt_handler mgmt_handler=
s[] =3D {
> >       { set_appearance,          MGMT_SET_APPEARANCE_SIZE },
> >       { get_phy_configuration,   MGMT_GET_PHY_CONFIGURATION_SIZE },
> >       { set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
> > +     { set_blocked_keys,        MGMT_OP_SET_BLOCKED_KEYS_SIZE },
> > };
> >
> > void mgmt_index_added(struct hci_dev *hdev)
> > diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> > index 6b42be4b5861..f61c78d81168 100644
> > --- a/net/bluetooth/smp.c
> > +++ b/net/bluetooth/smp.c
> > @@ -2453,6 +2453,10 @@ static int smp_cmd_encrypt_info(struct l2cap_con=
n *conn, struct sk_buff *skb)
> >       if (skb->len < sizeof(*rp))
> >               return SMP_INVALID_PARAMS;
> >
> > +     if (hci_is_blocked_key(conn->hcon->hdev, HCI_BLOCKED_KEY_TYPE_LTK=
,
> > +                     rp->ltk))
> > +             return SMP_INVALID_PARAMS;
> > +
> >       SMP_ALLOW_CMD(smp, SMP_CMD_MASTER_IDENT);
>
> Now this is a good question. Should we allow pairing with a blocked LTK a=
nd then just refuse to establish the link later like we do with BR/EDR or f=
orcefully refuse it. This is for legacy pairing only anyway where the LTKs =
are distributed.
[alain] From a user experience standpoint, I'd argue it is probably
better to fail the pairing so the user is aware that something is
wrong, rather than succeeding pairing then letting the device in a
state where it will never work.
>
> >
> >       skb_pull(skb, sizeof(*rp));
> > @@ -2509,6 +2513,10 @@ static int smp_cmd_ident_info(struct l2cap_conn =
*conn, struct sk_buff *skb)
> >       if (skb->len < sizeof(*info))
> >               return SMP_INVALID_PARAMS;
> >
> > +     if (hci_is_blocked_key(conn->hcon->hdev, HCI_BLOCKED_KEY_TYPE_IRK=
,
> > +                     info->irk))
> > +             return SMP_INVALID_PARAMS;
> > +
>
> Same here. In addition, we might want to skip using a blacked IRK if it g=
ets loaded via Load Identity Resolving Keys. Right now an already establish=
ed black listed IRK will be used.
[alain] I had actually considered adding the block in hci_find_irk_by*
but figured that given it's not a security issue but rather a privacy
issue for the device itself, I didn't block it thinking it's probably
best for the system to be able to resovle the key, but then fail the
connection so the user at least understand that the system is able to
see the device, but not connect to it.  I'm open to feedback on this
since I don't feel particularly strong either way.
>
> >       SMP_ALLOW_CMD(smp, SMP_CMD_IDENT_ADDR_INFO);
> >
> >       skb_pull(skb, sizeof(*info));
>
> Maybe instead of checking the keys all the time, we should just remove th=
em from kernel memory. So when we do a Load Blocked Keys, we go through our=
 list of known keys and purge the blocked ones. In addition when Loading IR=
K, LTK, LK we checked against the blocked list and don=E2=80=99t add the on=
es on the list.
[alain] I think this might be at the expense of considering the device
as not paired which I don't know if it has other implications.  I
propose we keep using this strategy and if the list of blocked keys
becomes too large, we can use this to optimize the kernel memory
usage.
>
> And we let pairing succeed, but don=E2=80=99t store the keys. This might =
be a bit of a problem since we tell userspace about pairing success by send=
ing it the key to store. I am open for thoughts.
[alain] See comment above.  The design was primarily motivated to
allow the user to know that something is up with the device during
pairing rather than leaving the device in a state where it looks
paired but will never work.
>
> Regards
>
> Marcel
>
