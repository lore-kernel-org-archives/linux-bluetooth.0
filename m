Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DA3EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 19:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjF3Txf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 15:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjF3Txe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 15:53:34 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2117F107
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 12:53:32 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b698937f85so37265451fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688154810; x=1690746810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q1EAZGzx+DvPtIJcWIo6jaWT11lxZLzoBE0pOPBClsw=;
        b=bCUPIy9I8a2vg33iPUrzjR6TnqxTDbqhW1EG+Vw8wotTaYH8/J9X24EYqFop0Pv3y8
         Oo/VgZVGpnXB6gIH+YRZrSe87eaMh/oiKrOqOToy+bkvtIkGTx0f9JfTNUfsGmMymynB
         DT69UxoXwkZHls5eOErx2KOm/ioLtkkNl2rwuLc+noRFjlYE7fjTU4OsDboVux14sYuK
         hD9HNDDM+eE/4o5580OkIHyuqa8ytTsUq8C16Sly5GfwRz87dB+LM2et0KuMJdwIuQOO
         bWOyVSeqJ67kWCuawqRGw6BYSwwhvCvZSwI//AimjWdCKec/Qe80PW27b825I0MJQctL
         cxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688154810; x=1690746810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q1EAZGzx+DvPtIJcWIo6jaWT11lxZLzoBE0pOPBClsw=;
        b=JCRvIpP0YBVA6WiBknL8u7Ow+pEbgFG5l1d7fuGCgRfg4NRqEv/ZDRSp9uJhroy+DI
         NPCbvynjXP2VzP++iHP+atY8OOOCHZhhBz81PQVjU+japkU132AIWQC4IswKg74ful1A
         ykL4c3eXiYaBhmcxff0ZwBMewu+RHLK4RSBvaAA7JR5SFFQa76uRoyQs7+3Qk67TMPI8
         W9/eBi9V+KHMsa1/j0aSgtJfRj6Wp0NhkzAqtDJsCO094mH20welES+gmR695MO9TCzd
         0Fy1KwrE/FbrN1CZOMwIF5LEuaIBSdQweFsT7nnRG5aECCgpDb6ArWrVMDrCQkiRbbLR
         /AhQ==
X-Gm-Message-State: ABy/qLYRd+Uv7cgV1g8G0KXMqI29BrGtcmyR4vQmef3Ec9rdhg5bFi+d
        tW13Nv+raN3T4EDIYatsJUqDnfmmSgFAQ1pqkJQU2mju+hk=
X-Google-Smtp-Source: APBJJlEh21fSl4Zjd6hNvLEUHtCNKhXZc3uEku/YrsHr8ws8t+bDaUMC3KyHDyVIG7XWT5owPESRbQ7tlA2Yc0YO354=
X-Received: by 2002:a2e:9998:0:b0:2b3:4e76:9c6a with SMTP id
 w24-20020a2e9998000000b002b34e769c6amr2375306lji.39.1688154809968; Fri, 30
 Jun 2023 12:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <CABBYNZJY2Ht9b41dzGm1J0L+2XH=Jzf0a7hg50HsbTxrN4nDHg@mail.gmail.com>
 <20230630152723.302429-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230630152723.302429-1-iulia.tanasescu@nxp.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 30 Jun 2023 12:53:17 -0700
Message-ID: <CABBYNZL5Z8oxF36HEnOs3nEpK2Q71r9xXKy4hxdT5zYn_3F0Yw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: ISO: Notify user space about failed bis connections
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     andrei.istodorescu@nxp.com, claudia.rosu@nxp.com,
        linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Iulia,

On Fri, Jun 30, 2023 at 8:27=E2=80=AFAM Iulia Tanasescu <iulia.tanasescu@nx=
p.com> wrote:
>
> Hi Luiz,
>
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Thursday, June 29, 2023 9:58 PM
> > To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> > <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> > octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> > <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> > Andrei Istodorescu <andrei.istodorescu@nxp.com>
> > Subject: Re: [PATCH v2 1/1] Bluetooth: ISO: Notify user space about
> > failed bis connections
> >
> > Hi Iulia,
> >
> > On Wed, Jun 28, 2023 at 8:06 AM Iulia Tanasescu <iulia.tanasescu@nxp.co=
m>
> > wrote:
> > >
> > > Some use cases require the user to be informed if BIG synchronization
> > > fails. This commit makes it so that even if the BIG sync established
> > > event arrives with error status, a new hconn is added for each BIS,
> > > and the iso layer is notified about the failed connections.
> > >
> > > Unsuccesful bis connections will be marked using the
> > > HCI_CONN_BIG_SYNC_FAILED flag. From the iso layer, the POLLERR event
> > > is triggered on the newly allocated bis sockets, before adding them t=
o
> > > the accept list of the parent socket.
> > >
> > > From user space, a new fd for each failed bis connection will be
> > > obtained by calling accept. The user should check for the POLLERR
> > > event on the new socket, to determine if the connection was successfu=
l
> > > or not.
> > >
> > > The HCI_CONN_BIG_SYNC flag has been added to mark whether the BIG
> > sync
> > > has been successfully established. This flag is checked at bis
> > > cleanup, so the HCI LE BIG Terminate Sync command is only issued if
> > needed.
> > >
> > > The BT_SK_BIG_SYNC flag indicates if BIG create sync has been called
> > > for a listening socket, to avoid issuing the command everytime a
> > > BIGInfo advertising report is received.
> > >
> > > Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > > ---
> > >  include/net/bluetooth/hci_core.h | 25 ++++++++++++++++
> > >  net/bluetooth/hci_conn.c         | 50 +++++++++++++++++-------------=
--
> > >  net/bluetooth/hci_event.c        | 21 +++++++++++---
> > >  net/bluetooth/iso.c              | 37 ++++++++++++++++-------
> > >  4 files changed, 95 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/include/net/bluetooth/hci_core.h
> > > b/include/net/bluetooth/hci_core.h
> > > index 05a9b3ab3f56..f068a578ff59 100644
> > > --- a/include/net/bluetooth/hci_core.h
> > > +++ b/include/net/bluetooth/hci_core.h
> > > @@ -978,6 +978,8 @@ enum {
> > >         HCI_CONN_PER_ADV,
> > >         HCI_CONN_BIG_CREATED,
> > >         HCI_CONN_CREATE_CIS,
> > > +       HCI_CONN_BIG_SYNC,
> > > +       HCI_CONN_BIG_SYNC_FAILED,
> > >  };
> > >
> > >  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn) @@
> > > -1288,6 +1290,29 @@ static inline struct hci_conn
> > *hci_conn_hash_lookup_big(struct hci_dev *hdev,
> > >         return NULL;
> > >  }
> > >
> > > +static inline struct hci_conn *hci_conn_hash_lookup_big_any_dst(stru=
ct
> > hci_dev *hdev,
> > > +                                                       __u8 handle) =
{
> > > +       struct hci_conn_hash *h =3D &hdev->conn_hash;
> > > +       struct hci_conn  *c;
> > > +
> > > +       rcu_read_lock();
> > > +
> > > +       list_for_each_entry_rcu(c, &h->list, list) {
> > > +               if (c->type !=3D ISO_LINK)
> > > +                       continue;
> > > +
> > > +               if (handle =3D=3D c->iso_qos.bcast.big) {
> > > +                       rcu_read_unlock();
> > > +                       return c;
> > > +               }
> > > +       }
> > > +
> > > +       rcu_read_unlock();
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > >  static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci=
_dev
> > *hdev,
> > >                                                         __u8 type,
> > > __u16 state)  { diff --git a/net/bluetooth/hci_conn.c
> > > b/net/bluetooth/hci_conn.c index 47e7aa4d63a9..491ca8e876f0 100644
> > > --- a/net/bluetooth/hci_conn.c
> > > +++ b/net/bluetooth/hci_conn.c
> > > @@ -686,6 +686,19 @@ static void hci_conn_timeout(struct work_struct
> > *work)
> > >                 return;
> > >         }
> > >
> > > +       /* Cleanup bises that failed to be established */
> > > +       if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags=
)) {
> > > +               conn->state =3D BT_CLOSED;
> > > +               hci_disconn_cfm(conn, hci_proto_disconn_ind(conn));
> > > +               hci_conn_hash_del(conn->hdev, conn);
> > > +
> > > +               if (conn->cleanup)
> > > +                       conn->cleanup(conn);
> > > +
> > > +               hci_conn_put(conn);
> > > +               return;
> > > +       }
> >
> > I will be pushing some changes to how hci_abort_conn works, the code
> > above shall probably be done inside the likes of hci_conn_failed though=
 but
> > first we need to add support for BIS into hci_abort_conn_sync.
>
> Thank you, I submitted a new patch version with these updates.
>
> >
> > >         hci_abort_conn(conn, hci_proto_disconn_ind(conn));  }
> > >
> > > @@ -793,6 +806,7 @@ struct iso_list_data {
> > >         int count;
> > >         struct iso_cig_params pdu;
> > >         bool big_term;
> > > +       bool big_sync_term;
> > >  };
> > >
> > >  static void bis_list(struct hci_conn *conn, void *data) @@ -810,17
> > > +824,6 @@ static void bis_list(struct hci_conn *conn, void *data)
> > >         d->count++;
> > >  }
> > >
> > > -static void find_bis(struct hci_conn *conn, void *data) -{
> > > -       struct iso_list_data *d =3D data;
> > > -
> > > -       /* Ignore unicast */
> > > -       if (bacmp(&conn->dst, BDADDR_ANY))
> > > -               return;
> > > -
> > > -       d->count++;
> > > -}
> > > -
> > >  static int terminate_big_sync(struct hci_dev *hdev, void *data)  {
> > >         struct iso_list_data *d =3D data; @@ -873,31 +876,26 @@ stati=
c
> > > int big_terminate_sync(struct hci_dev *hdev, void *data)
> > >         bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", d->big,
> > >                    d->sync_handle);
> > >
> > > -       /* Check if ISO connection is a BIS and terminate BIG if ther=
e are
> > > -        * no other connections using it.
> > > -        */
> > > -       hci_conn_hash_list_state(hdev, find_bis, ISO_LINK, BT_CONNECT=
ED,
> > d);
> > > -       if (d->count)
> > > -               return 0;
> > > -
> > > -       hci_le_big_terminate_sync(hdev, d->big);
> > > +       if (d->big_sync_term)
> > > +               hci_le_big_terminate_sync(hdev, d->big);
> > >
> > >         return hci_le_pa_terminate_sync(hdev, d->sync_handle);  }
> > >
> > > -static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, u16
> > > sync_handle)
> > > +static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct
> > > +hci_conn *conn)
> > >  {
> > >         struct iso_list_data *d;
> > >         int ret;
> > >
> > > -       bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big,
> > sync_handle);
> > > +       bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big,
> > > + conn->sync_handle);
> > >
> > >         d =3D kzalloc(sizeof(*d), GFP_KERNEL);
> > >         if (!d)
> > >                 return -ENOMEM;
> > >
> > >         d->big =3D big;
> > > -       d->sync_handle =3D sync_handle;
> > > +       d->sync_handle =3D conn->sync_handle;
> > > +       d->big_sync_term =3D test_and_clear_bit(HCI_CONN_BIG_SYNC,
> > > + &conn->flags);
> > >
> > >         ret =3D hci_cmd_sync_queue(hdev, big_terminate_sync, d,
> > >                                  terminate_big_destroy); @@ -933,8
> > > +931,14 @@ static void bis_cleanup(struct hci_conn *conn)
> > >
> > >                 hci_le_terminate_big(hdev, conn);
> > >         } else {
> > > +               bis =3D hci_conn_hash_lookup_big_any_dst(hdev,
> > > +
> > > + conn->iso_qos.bcast.big);
> > > +
> > > +               if (bis)
> > > +                       return;
> > > +
> > >                 hci_le_big_terminate(hdev, conn->iso_qos.bcast.big,
> > > -                                    conn->sync_handle);
> > > +                                    conn);
> > >         }
> > >  }
> > >
> > > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > > index 77cbf13037b3..30d0a6631e17 100644
> > > --- a/net/bluetooth/hci_event.c
> > > +++ b/net/bluetooth/hci_event.c
> > > @@ -7039,9 +7039,6 @@ static void
> > hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
> > >                                 flex_array_size(ev, bis, ev->num_bis)=
))
> > >                 return;
> > >
> > > -       if (ev->status)
> > > -               return;
> > > -
> > >         hci_dev_lock(hdev);
> > >
> > >         for (i =3D 0; i < ev->num_bis; i++) { @@ -7065,9 +7062,25 @@
> > > static void hci_le_big_sync_established_evt(struct hci_dev *hdev, voi=
d
> > *data,
> > >                 bis->iso_qos.bcast.in.latency =3D le16_to_cpu(ev->int=
erval) * 125 /
> > 100;
> > >                 bis->iso_qos.bcast.in.sdu =3D le16_to_cpu(ev->max_pdu=
);
> > >
> > > -               hci_iso_setup_path(bis);
> > > +               if (!ev->status) {
> > > +                       set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
> > > +                       hci_iso_setup_path(bis);
> > > +               }
> > >         }
> > >
> > > +       /* In case BIG sync failed, notify each failed connection to
> > > +        * the user after all hci connections have been added
> > > +        */
> > > +       if (ev->status)
> > > +               for (i =3D 0; i < ev->num_bis; i++) {
> > > +                       u16 handle =3D le16_to_cpu(ev->bis[i]);
> > > +
> > > +                       bis =3D hci_conn_hash_lookup_handle(hdev,
> > > + handle);
> > > +
> > > +                       set_bit(HCI_CONN_BIG_SYNC_FAILED, &bis->flags=
);
> > > +                       hci_connect_cfm(bis, ev->status);
> > > +               }
> > > +
> > >         hci_dev_unlock(hdev);
> > >  }
> > >
> > > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c index
> > > 84d238d0639a..e0386b12ea4e 100644
> > > --- a/net/bluetooth/iso.c
> > > +++ b/net/bluetooth/iso.c
> > > @@ -48,6 +48,11 @@ static void iso_sock_kill(struct sock *sk);
> > > #define EIR_SERVICE_DATA_LENGTH 4  #define BASE_MAX_LENGTH
> > > (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH)
> > >
> > > +/* iso_pinfo flags values */
> > > +enum {
> > > +       BT_SK_BIG_SYNC,
> > > +};
> > > +
> > >  struct iso_pinfo {
> > >         struct bt_sock          bt;
> > >         bdaddr_t                src;
> > > @@ -58,7 +63,7 @@ struct iso_pinfo {
> > >         __u8                    bc_num_bis;
> > >         __u8                    bc_bis[ISO_MAX_NUM_BIS];
> > >         __u16                   sync_handle;
> > > -       __u32                   flags;
> > > +       unsigned long           flags;
> > >         struct bt_iso_qos       qos;
> > >         bool                    qos_user_set;
> > >         __u8                    base_len;
> > > @@ -1569,6 +1574,12 @@ static void iso_conn_ready(struct iso_conn
> > *conn)
> > >                 hci_conn_hold(hcon);
> > >                 iso_chan_add(conn, sk, parent);
> > >
> > > +               if (ev && ((struct hci_evt_le_big_sync_estabilished *=
)ev)->status)
> > {
> > > +                       /* Trigger error signal on child socket */
> > > +                       sk->sk_err =3D ECONNREFUSED;
> > > +                       sk->sk_error_report(sk);
> > > +               }
> > > +
> > >                 if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags=
))
> > >                         sk->sk_state =3D BT_CONNECT2;
> > >                 else
> > > @@ -1637,15 +1648,19 @@ int iso_connect_ind(struct hci_dev *hdev,
> > bdaddr_t *bdaddr, __u8 *flags)
> > >                         if (ev2->num_bis < iso_pi(sk)->bc_num_bis)
> > >                                 iso_pi(sk)->bc_num_bis =3D ev2->num_b=
is;
> > >
> > > -                       err =3D hci_le_big_create_sync(hdev,
> > > -                                                    &iso_pi(sk)->qos=
,
> > > -                                                    iso_pi(sk)->sync=
_handle,
> > > -                                                    iso_pi(sk)->bc_n=
um_bis,
> > > -                                                    iso_pi(sk)->bc_b=
is);
> > > -                       if (err) {
> > > -                               bt_dev_err(hdev, "hci_le_big_create_s=
ync: %d",
> > > -                                          err);
> > > -                               sk =3D NULL;
> > > +                       if (!test_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->fl=
ags)) {
> > > +                               set_bit(BT_SK_BIG_SYNC,
> > > + &iso_pi(sk)->flags);
> >
> > You can probably use test_and_set_bit instead above.
>
> I updated this as well.
>
> >
> > > +
> > > +                               err =3D hci_le_big_create_sync(hdev,
> > > +                                                            &iso_pi(=
sk)->qos,
> > > +                                                            iso_pi(s=
k)->sync_handle,
> > > +                                                            iso_pi(s=
k)->bc_num_bis,
> > > +                                                            iso_pi(s=
k)->bc_bis);
> > > +                               if (err) {
> > > +                                       bt_dev_err(hdev, "hci_le_big_=
create_sync: %d",
> > > +                                                  err);
> > > +                                       sk =3D NULL;
> > > +                               }
> > >                         }
> > >                 }
> > >         } else {
> > > @@ -1688,7 +1703,7 @@ static void iso_connect_cfm(struct hci_conn
> > > *hcon, __u8 status)
> > >
> > >         BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst,
> > > status);
> > >
> > > -       if (!status) {
> > > +       if (!status || test_bit(HCI_CONN_BIG_SYNC_FAILED,
> > > + &hcon->flags)) {
> >
> > Shouldn't it be !test_bit above?
>
> Here, if HCI_CONN_BIG_SYNC_FAILED is set, I want to reach iso_conn_ready,
> like it would be for the success case, so the failed bis connection will
> be added in the accept queue of the listening socket and it will be woken
> up in userspace, so the check should be positive.

Make sure you add a comment explaining this, since someone else may
think this is a bug as well.

> >
> > >                 struct iso_conn *conn;
> > >
> > >                 conn =3D iso_conn_add(hcon);
> > > --
> > > 2.34.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
> Regards,
> Iulia



--=20
Luiz Augusto von Dentz
