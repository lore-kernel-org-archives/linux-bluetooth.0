Return-Path: <SRS0=WaXy=Z7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17958C43603
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 18:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF183205C9
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Dec 2019 18:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F42eA9iO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLISil (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:38:41 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:45246 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfLISil (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Dec 2019 13:38:41 -0500
Received: by mail-lj1-f171.google.com with SMTP id d20so16780047ljc.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2019 10:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PeAqo29fqh1AWlEY2gl8T2c6VjSyTTWygbCf42QGr68=;
        b=F42eA9iOmEsBWj/1j9uRUAl5JDmIe0YELYLjAi195qquvuFTXLPI5EjF3BLzf8pzV4
         0l1MiBOg2/aMb8I8siJwpbPB7l7MlgYGKrxPPCundv5F5bEKSDj/Xku73tsxiA8L/0Fg
         DMR1qXTqHi2+tYdIvF5dFJyhvChKQsMhuL9vOH0pU/baYvaqrvhbtsZhWZT5I6/kxfwq
         k1Ez1j1AfpOuLf091iZYU1GC6+MXa/oBYS98/TcxfB/pPX0PHssD1t1nSpul/mrrRwFN
         0zOIb4LL1EkXeGQCbzb/vprXIoYgMvvaeBSotDeLt/eOH8Squ6wsro+Fv12BxyJLX8Py
         8zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PeAqo29fqh1AWlEY2gl8T2c6VjSyTTWygbCf42QGr68=;
        b=o4+kCa+R0yKP85klE4yCsD0HeQykpyyjVuT8NEaDlVVzd271qKnqlBUai4+w2EC2gE
         3F1gOl2gKAJSwhjQO6EE/sWmNKcfh3bUlIRlOGxTyGKC+IEQTKf3BYw54wGyD83BfMnv
         Jk2ygpi8BilzMRNP2LBlKMCCaKMPxOfydM+T2mhdeV49mFKI/eTIIRF5dIBzXMFK5oH2
         judvDuANwS9y7Yze6RV45hL/Xm4iijH3BS//4W8n5yGO2bjGcq9SOTp7wHr4gDjo7i7C
         CIjb8jDOaHWJC95zLrn0dVqNYChAp3YaboVtJH3nmOYWqkZMlvrRpBzODejo23qB+CAs
         3ukg==
X-Gm-Message-State: APjAAAX2LGQLblGbPN+tSOZoEauBCM5VHwFkSN2UPj1rFrEbhIm7a5rr
        6BMlRCvr0y9hBuO7O+dfWB1x0iCxUzZT1ozuZGIKJA==
X-Google-Smtp-Source: APXvYqy48u8gYEZLn64VXeD1/fQdDiG8bsMc1eKH6BHd40hqUvs/fROWealIT6LGQqvhcOTXPQXcglId75sF5vlISFY=
X-Received: by 2002:a2e:9e55:: with SMTP id g21mr17278627ljk.245.1575916717890;
 Mon, 09 Dec 2019 10:38:37 -0800 (PST)
MIME-Version: 1.0
References: <20191205170645.117976-1-alainm@chromium.org> <7930629A-7A57-40F8-BA68-D1730D0BCEC6@holtmann.org>
In-Reply-To: <7930629A-7A57-40F8-BA68-D1730D0BCEC6@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Mon, 9 Dec 2019 13:38:26 -0500
Message-ID: <CALWDO_XqGvxVdQ+q=BE63zGo0O=5w3q2JgT2h4Y+qwhrTwKERQ@mail.gmail.com>
Subject: Re: [RFC v2] Implementation of MGMT_OP_SET_BLOCKED_KEYS.
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Marcel.

I believe I have addressed all your feedback here.  Will send a patch
after some additional testing.

Thanks,
Alain

On Sun, Dec 8, 2019 at 4:45 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Alain,
>
> > Here's a newer version with most of your feedback addressed.  Others
> > responses sent inline in the v1.
>
> so lets put a proper commit message with all the details here. Don=E2=80=
=99t forget the Signed-off-by.
>
> >
> > ---
> > include/net/bluetooth/hci_core.h |  9 +++++
> > include/net/bluetooth/mgmt.h     | 17 ++++++++++
> > net/bluetooth/hci_core.c         | 56 ++++++++++++++++++++++++++++++--
> > net/bluetooth/mgmt.c             | 51 +++++++++++++++++++++++++++++
> > net/bluetooth/smp.c              |  8 +++++
> > 5 files changed, 138 insertions(+), 3 deletions(-)
>
> And comments for the reviewer can go here.
>
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index b689aceb636b..e9a789e11493 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -118,6 +118,13 @@ struct bt_uuid {
> >       u8 svc_hint;
> > };
> >
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
> > @@ -397,6 +404,7 @@ struct hci_dev {
> >       struct list_head        le_conn_params;
> >       struct list_head        pend_le_conns;
> >       struct list_head        pend_le_reports;
> > +     struct list_head        blocked_keys;
> >
> >       struct hci_dev_stats    stat;
> >
> > @@ -1121,6 +1129,7 @@ struct smp_irk *hci_find_irk_by_addr(struct hci_d=
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
> > index 9cee7ddc6741..c9b1d39d6d6c 100644
> > --- a/include/net/bluetooth/mgmt.h
> > +++ b/include/net/bluetooth/mgmt.h
> > @@ -654,6 +654,23 @@ struct mgmt_cp_set_phy_confguration {
> > } __packed;
> > #define MGMT_SET_PHY_CONFIGURATION_SIZE       4
> >
> > +#define MGMT_OP_SET_BLOCKED_KEYS     0x0046
> > +
> > +#define HCI_BLOCKED_KEY_TYPE_LINKKEY 0x00
> > +#define HCI_BLOCKED_KEY_TYPE_LTK             0x01
> > +#define HCI_BLOCKED_KEY_TYPE_IRK             0x02
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
> > index 9e19d5a3aac8..52e7bf295a51 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2311,6 +2311,35 @@ void hci_smp_irks_clear(struct hci_dev *hdev)
> >       }
> > }
> >
> > +static void hci_blocked_keys_clear(struct hci_dev *hdev)
> > +{
> > +     struct blocked_key *b;
> > +
> > +     list_for_each_entry_rcu(b, &hdev->blocked_keys, list) {
> > +             list_del_rcu(&b->list);
> > +             kfree_rcu(b, rcu);
> > +     }
> > +}
> > +
> > +bool hci_is_blocked_key(struct hci_dev *hdev, u8 type, u8 val[16])
> > +{
> > +     bool blocked =3D false;
> > +     struct blocked_key *b;
> > +
> > +     rcu_read_lock();
> > +     list_for_each_entry(b, &hdev->blocked_keys, list) {
> > +             if (b->type =3D=3D type &&
> > +                             !memcmp(b->val, val, sizeof(b->val))) {
>
> Indentation error.
>
> > +                     blocked =3D true;
> > +                     goto done;
>
> Isn=E2=80=99t break; enough here and we avoid the label.
>
> > +             }
> > +     }
> > +
> > +done:
> > +     rcu_read_unlock();
> > +     return blocked;
> > +}
> > +
> > struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdad=
dr)
> > {
> >       struct link_key *k;
> > @@ -2319,6 +2348,16 @@ struct link_key *hci_find_link_key(struct hci_de=
v *hdev, bdaddr_t *bdaddr)
> >       list_for_each_entry_rcu(k, &hdev->link_keys, list) {
> >               if (bacmp(bdaddr, &k->bdaddr) =3D=3D 0) {
> >                       rcu_read_unlock();
> > +
> > +                     if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE=
_LINKKEY,
> > +                                             k->val)) {
> > +                             WARN_ONCE(1, "Key blocked for %pMR", &k->=
bdaddr);
>
> I just realized that I gave bad advice. WARN_ONCE is not going to do the =
right job. If we have multiple keys in our list it will only ever warn for =
the initial one.
>
> So it might be better to create a new bt_warn_ratelimited and use that on=
e.
>
> > +
> > +                             /* The device may have refreshed it to a =
new one which
> > +                              * would imply a second key is in the lis=
t */
> > +                             continue;
>
> I am not sure this actually helps. The keys are created by a key agreemen=
t function. I would really just ignore this possibility. If the key refresh=
 procedure is used, you can not guess the next key.
>
> > +                     }
> > +
> >                       return k;
> >               }
> >       }
> > @@ -2387,6 +2426,12 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hde=
v, bdaddr_t *bdaddr,
> >
> >               if (smp_ltk_is_sc(k) || ltk_role(k->type) =3D=3D role) {
> >                       rcu_read_unlock();
> > +
> > +                     if (hci_is_blocked_key(hdev, HCI_BLOCKED_KEY_TYPE=
_LTK, k->val)) {
> > +                             WARN_ONCE(1, "Key blocked for %pMR", &k->=
bdaddr);
>
> See comment above with bt_warn_ratelimited.
>
> > +                             return NULL;
> > +                     }
> > +
> >                       return k;
> >               }
> >       }
> > @@ -2548,10 +2593,13 @@ int hci_remove_link_key(struct hci_dev *hdev, b=
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
>
> I am still not convinced here. If we have more than one link key for a gi=
ven address, we do have a problem. We should check that this doesn=E2=80=99=
t happen in the first place.
>
> >
> >       return 0;
> > }
> > @@ -3244,6 +3292,7 @@ struct hci_dev *hci_alloc_dev(void)
> >       INIT_LIST_HEAD(&hdev->pend_le_reports);
> >       INIT_LIST_HEAD(&hdev->conn_hash.list);
> >       INIT_LIST_HEAD(&hdev->adv_instances);
> > +     INIT_LIST_HEAD(&hdev->blocked_keys);
> >
> >       INIT_WORK(&hdev->rx_work, hci_rx_work);
> >       INIT_WORK(&hdev->cmd_work, hci_cmd_work);
> > @@ -3443,6 +3492,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
> >       hci_bdaddr_list_clear(&hdev->le_resolv_list);
> >       hci_conn_params_clear_all(hdev);
> >       hci_discovery_filter_clear(hdev);
> > +     hci_blocked_keys_clear(hdev);
> >       hci_dev_unlock(hdev);
> >
> >       hci_dev_put(hdev);
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index acb7c6d5643f..6fb4ce768863 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -106,6 +106,7 @@ static const u16 mgmt_commands[] =3D {
> >       MGMT_OP_START_LIMITED_DISCOVERY,
> >       MGMT_OP_READ_EXT_INFO,
> >       MGMT_OP_SET_APPEARANCE,
> > +     MGMT_OP_SET_BLOCKED_KEYS,
> > };
>
> Once this patch has made it upstream, you might also want to send a patch=
 to increase the minor version for mgmt interface. While we don=E2=80=99t a=
ctually use it, it is an extra precaution to allow distinguishing kernel re=
lease if ever needed. And I think the last time I added new commands, I tot=
ally forgot it.
>
> >
> > static const u16 mgmt_events[] =3D {
> > @@ -3531,6 +3532,55 @@ static int set_phy_configuration(struct sock *sk=
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
> > +         ((len - offsetof(struct mgmt_cp_set_blocked_keys, keys)) %
> > +                     sizeof(struct mgmt_blocked_key_info))) {
>
> So I have no idea what the indentation rule is for this. Can we introduce=
 a helper macro for this?
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
> > +             for (i =3D 0; i < keys->key_count; ++i) {
> > +                     bool already_blocked =3D false;
> > +                     struct blocked_key *b;
> > +
> > +                     list_for_each_entry(b, &hdev->blocked_keys, list)=
 {
> > +                             if (keys->keys[i].type =3D=3D b->type &&
> > +                                     !memcmp(keys->keys[i].val, b->val=
,
> > +                                                     sizeof(keys->keys=
[i].val))) {
> > +                                     already_blocked =3D true;
> > +                                     break;
> > +                             }
> > +                     }
> > +
> > +                     if (already_blocked)
> > +                             continue;
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
>
> Lets avoid the extra { } and the indentation.
>
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
> > @@ -6914,6 +6964,7 @@ static const struct hci_mgmt_handler mgmt_handler=
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
>
> Please fix the indentation here.
>
> > +             return SMP_INVALID_PARAMS;
> > +
> >       SMP_ALLOW_CMD(smp, SMP_CMD_MASTER_IDENT);
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
>
> Same as above.
>
> > +             return SMP_INVALID_PARAMS;
> > +
> >       SMP_ALLOW_CMD(smp, SMP_CMD_IDENT_ADDR_INFO);
> >
> >       skb_pull(skb, sizeof(*info));
>
> Regards
>
> Marcel
>
