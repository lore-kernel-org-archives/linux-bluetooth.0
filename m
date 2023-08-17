Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E3CFC64EDA
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 21:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355388AbjHQVkK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 17:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355387AbjHQVjp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 17:39:45 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D65E4F
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 14:39:42 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9a828c920so4069301fa.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 14:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692308381; x=1692913181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=khg/U9vjOnhBLq4bnmieJn9ynYBEyiLd//uWmpccIOI=;
        b=cuD3DbKEtQv/9Xi/cNAipLFzzd5cxCg7VtLy628pvZAj1wxfPUm8jhUUiwUf+DnTJn
         PjQUjI0D43haSTWwsJHZxtIstWFWmqJ5zDOeXCTvjrkjwHvsvoHznI43xLOv4Bj4WRhC
         JtN8OI6Wdn0cFnh16176fEr1UBCjj8VdkULgdnaFJ8XYiot6x1EpN43WrJTICnbbrkWp
         sFw/LYCxGFmn4lQnljUyAevzULJ+2yHKCRIr1JigawUW8q4ja5JvHibxGTY/++BuIexb
         /6gi8z7Y1eeqL0u40rSvtM8Um9aWRGEWleXYhIY84RhL0SCo4R8KPkpsAn/JBKyMVrLL
         OCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692308381; x=1692913181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khg/U9vjOnhBLq4bnmieJn9ynYBEyiLd//uWmpccIOI=;
        b=MJU0OBDxjwbiSEc1sYMHVVqKpd9vUvN9OAOeaAIpf1btjxJ1sIMUhUnBvQgFJDwzz2
         7nV1kaOSOY8QKEed8Vg2bunp83S9sJdtVPGL1oVC7bxEUERE01AB/7jcdKt4EYFEzuF/
         fLV1+7duyL5RXH9q4FH6HgSiLD7n81ocf71/2egZKMkWn5rR2ZzXgmcP7bh7h+SE3JGe
         KDyPTjiTpST9UIHSqs3c7BRtQjNY5a27NDoAZSDqtpZ2saaA8DfJoiagRSAfusLenlx2
         Hxr3Sl6Yd0Lrj6QXMt2brJA9JJGRNnsZxIzpy+eMDcM0fQFLy7paKeYfW0FiyB+iULXD
         vZ3w==
X-Gm-Message-State: AOJu0YwX2F5+wZJVjvq0zNLHdW+9IiGjXvtQkBkDyDL1N+MaK2txUbDz
        rYiO9C3Mwg98vFh/L7QUDyWUeskRNTekbnpgpvY=
X-Google-Smtp-Source: AGHT+IEbslZRaAzbkQF+9R91SXg7hUBVIecnVPDAgHSNb07T/jqaRtyXZKb0auidXCK4TQsBw+tnX7ngwFmCiscf0o0=
X-Received: by 2002:a2e:880a:0:b0:2b5:bc27:d6eb with SMTP id
 x10-20020a2e880a000000b002b5bc27d6ebmr401167ljh.8.1692308380746; Thu, 17 Aug
 2023 14:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230817064427.3647-1-iulia.tanasescu@nxp.com>
 <20230817064427.3647-2-iulia.tanasescu@nxp.com> <071e0fe0c5bfdba995edbd95db3cb6ea62010135.camel@iki.fi>
In-Reply-To: <071e0fe0c5bfdba995edbd95db3cb6ea62010135.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 17 Aug 2023 14:39:28 -0700
Message-ID: <CABBYNZJOXwSbF9h2jeXwZWwPnsrUi-VbB1GjQGsYnw+t5p3FLw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] Bluetooth: ISO: Use defer setup to separate PA
 sync and BIG sync
To:     Pauli Virtanen <pav@iki.fi>
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Thu, Aug 17, 2023 at 1:26=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> to, 2023-08-17 kello 09:44 +0300, Iulia Tanasescu kirjoitti:
> > This commit implements defer setup support for the Broadcast Sink
> > scenario: By setting defer setup on a broadcast socket before calling
> > listen, the user is able to trigger the PA sync and BIG sync procedures
> > separately.
> >
> > This is useful if the user first wants to synchronize to the periodic
> > advertising transmitted by a Broadcast Source, and trigger the BIG sync
> > procedure later on.
> >
> > If defer setup is set, once a PA sync established event arrives, a new
> > hcon is created and notified to the ISO layer. A child socket associate=
d
> > with the PA sync connection will be added to the accept queue of the
> > listening socket.
> >
> > Once the accept call returns the fd for the PA sync child socket, the
> > user should call read on that fd. This will trigger the BIG create sync
> > procedure, and the PA sync socket will become a listening socket itself=
.
> >
> > When the BIG sync established event is notified to the ISO layer, the
> > bis connections will be added to the accept queue of the PA sync parent=
.
> > The user should call accept on the PA sync socket to get the final bis
> > connections.
> >
> > Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > ---
> >  include/net/bluetooth/hci_core.h |  30 +++++-
> >  net/bluetooth/hci_conn.c         |  13 ++-
> >  net/bluetooth/hci_event.c        |  41 +++++++-
> >  net/bluetooth/hci_sync.c         |  15 +++
> >  net/bluetooth/iso.c              | 160 ++++++++++++++++++++++++-------
> >  5 files changed, 218 insertions(+), 41 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index c53d74236e3a..6fb055e3c595 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -978,6 +978,8 @@ enum {
> >       HCI_CONN_CREATE_CIS,
> >       HCI_CONN_BIG_SYNC,
> >       HCI_CONN_BIG_SYNC_FAILED,
> > +     HCI_CONN_PA_SYNC,
> > +     HCI_CONN_PA_SYNC_FAILED,
> >  };
> >
> >  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
> > @@ -1300,7 +1302,7 @@ static inline struct hci_conn *hci_conn_hash_look=
up_big_any_dst(struct hci_dev *
> >               if (c->type !=3D ISO_LINK)
> >                       continue;
> >
> > -             if (handle =3D=3D c->iso_qos.bcast.big) {
> > +             if (handle !=3D BT_ISO_QOS_BIG_UNSET && handle =3D=3D c->=
iso_qos.bcast.big) {
> >                       rcu_read_unlock();
> >                       return c;
> >               }
> > @@ -1311,6 +1313,29 @@ static inline struct hci_conn *hci_conn_hash_loo=
kup_big_any_dst(struct hci_dev *
> >       return NULL;
> >  }
> >
> > +static inline struct hci_conn *
> > +hci_conn_hash_lookup_pa_sync(struct hci_dev *hdev, __u8 big)
> > +{
> > +     struct hci_conn_hash *h =3D &hdev->conn_hash;
> > +     struct hci_conn  *c;
> > +
> > +     rcu_read_lock();
> > +
> > +     list_for_each_entry_rcu(c, &h->list, list) {
> > +             if (c->type !=3D ISO_LINK ||
> > +                     !test_bit(HCI_CONN_PA_SYNC, &c->flags))
> > +                     continue;
> > +
> > +             if (c->iso_qos.bcast.big =3D=3D big) {
> > +                     rcu_read_unlock();
> > +                     return c;
> > +             }
> > +     }
> > +     rcu_read_unlock();
> > +
> > +     return NULL;
> > +}
> > +
> >  static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_d=
ev *hdev,
> >                                                       __u8 type, __u16 =
state)
> >  {
> > @@ -1435,7 +1460,8 @@ struct hci_conn *hci_connect_bis(struct hci_dev *=
hdev, bdaddr_t *dst,
> >                                __u8 data_len, __u8 *data);
> >  int hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst, __u8 dst_t=
ype,
> >                      __u8 sid, struct bt_iso_qos *qos);
> > -int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qo=
s,
> > +int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon=
,
> > +                        struct bt_iso_qos *qos,
> >                          __u16 sync_handle, __u8 num_bis, __u8 bis[]);
> >  int hci_conn_check_link_mode(struct hci_conn *conn);
> >  int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 95339623883c..8b0c8e631324 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -734,6 +734,7 @@ struct iso_list_data {
> >       };
> >       int count;
> >       bool big_term;
> > +     bool pa_sync_term;
> >       bool big_sync_term;
> >  };
> >
> > @@ -807,7 +808,10 @@ static int big_terminate_sync(struct hci_dev *hdev=
, void *data)
> >       if (d->big_sync_term)
> >               hci_le_big_terminate_sync(hdev, d->big);
> >
> > -     return hci_le_pa_terminate_sync(hdev, d->sync_handle);
> > +     if (d->pa_sync_term)
> > +             return hci_le_pa_terminate_sync(hdev, d->sync_handle);
> > +
> > +     return 0;
> >  }
> >
> >  static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct h=
ci_conn *conn)
> > @@ -823,6 +827,7 @@ static int hci_le_big_terminate(struct hci_dev *hde=
v, u8 big, struct hci_conn *c
> >
> >       d->big =3D big;
> >       d->sync_handle =3D conn->sync_handle;
> > +     d->pa_sync_term =3D test_and_clear_bit(HCI_CONN_PA_SYNC, &conn->f=
lags);
> >       d->big_sync_term =3D test_and_clear_bit(HCI_CONN_BIG_SYNC, &conn-=
>flags);
> >
> >       ret =3D hci_cmd_sync_queue(hdev, big_terminate_sync, d,
> > @@ -2099,7 +2104,8 @@ int hci_pa_create_sync(struct hci_dev *hdev, bdad=
dr_t *dst, __u8 dst_type,
> >       return hci_cmd_sync_queue(hdev, create_pa_sync, cp, create_pa_com=
plete);
> >  }
> >
> > -int hci_le_big_create_sync(struct hci_dev *hdev, struct bt_iso_qos *qo=
s,
> > +int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon=
,
> > +                        struct bt_iso_qos *qos,
> >                          __u16 sync_handle, __u8 num_bis, __u8 bis[])
> >  {
> >       struct _packed {
> > @@ -2115,6 +2121,9 @@ int hci_le_big_create_sync(struct hci_dev *hdev, =
struct bt_iso_qos *qos,
> >       if (err)
> >               return err;
> >
> > +     if (hcon)
> > +             hcon->iso_qos.bcast.big =3D qos->bcast.big;
> > +
> >       memset(&pdu, 0, sizeof(pdu));
> >       pdu.cp.handle =3D qos->bcast.big;
> >       pdu.cp.sync_handle =3D cpu_to_le16(sync_handle);
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 559b6080706c..b4b72070f5f6 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -6581,20 +6581,39 @@ static void hci_le_pa_sync_estabilished_evt(str=
uct hci_dev *hdev, void *data,
> >       struct hci_ev_le_pa_sync_established *ev =3D data;
> >       int mask =3D hdev->link_mode;
> >       __u8 flags =3D 0;
> > +     struct hci_conn *bis;
> >
> >       bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
> >
> > -     if (ev->status)
> > -             return;
> > -
> >       hci_dev_lock(hdev);
> >
> >       hci_dev_clear_flag(hdev, HCI_PA_SYNC);
> >
> >       mask |=3D hci_proto_connect_ind(hdev, &ev->bdaddr, ISO_LINK, &fla=
gs);
> > -     if (!(mask & HCI_LM_ACCEPT))
> > +     if (!(mask & HCI_LM_ACCEPT)) {
> >               hci_le_pa_term_sync(hdev, ev->handle);
> > +             goto unlock;
> > +     }
> > +
> > +     if (!(flags & HCI_PROTO_DEFER))
> > +             goto unlock;
> > +
> > +     /* Add connection to indicate the PA sync event */
> > +     bis =3D hci_conn_add(hdev, ISO_LINK, BDADDR_ANY,
> > +                        HCI_ROLE_SLAVE);
> >
> > +     if (!bis)
> > +             goto unlock;
> > +
> > +     if (ev->status)
> > +             set_bit(HCI_CONN_PA_SYNC_FAILED, &bis->flags);
> > +     else
> > +             set_bit(HCI_CONN_PA_SYNC, &bis->flags);
> > +
> > +     /* Notify connection to iso layer */
> > +     hci_connect_cfm(bis, ev->status);
> > +
> > +unlock:
> >       hci_dev_unlock(hdev);
> >  }
> >
> > @@ -7045,6 +7064,7 @@ static void hci_le_big_sync_established_evt(struc=
t hci_dev *hdev, void *data,
> >  {
> >       struct hci_evt_le_big_sync_estabilished *ev =3D data;
> >       struct hci_conn *bis;
> > +     struct hci_conn *pa_sync;
> >       int i;
> >
> >       bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
> > @@ -7055,6 +7075,15 @@ static void hci_le_big_sync_established_evt(stru=
ct hci_dev *hdev, void *data,
> >
> >       hci_dev_lock(hdev);
> >
> > +     if (!ev->status) {
> > +             pa_sync =3D hci_conn_hash_lookup_pa_sync(hdev, ev->handle=
);
> > +             if (pa_sync)
> > +                     /* Also mark the BIG sync established event on th=
e
> > +                      * associated PA sync hcon
> > +                      */
> > +                     set_bit(HCI_CONN_BIG_SYNC, &pa_sync->flags);
> > +     }
> > +
> >       for (i =3D 0; i < ev->num_bis; i++) {
> >               u16 handle =3D le16_to_cpu(ev->bis[i]);
> >               __le32 interval;
> > @@ -7068,6 +7097,10 @@ static void hci_le_big_sync_established_evt(stru=
ct hci_dev *hdev, void *data,
> >                       bis->handle =3D handle;
> >               }
> >
> > +             if (ev->status !=3D 0x42)
> > +                     /* Mark PA sync as established */
> > +                     set_bit(HCI_CONN_PA_SYNC, &bis->flags);
> > +
> >               bis->iso_qos.bcast.big =3D ev->handle;
> >               memset(&interval, 0, sizeof(interval));
> >               memcpy(&interval, ev->latency, sizeof(ev->latency));
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index d10a0f36b947..0cb780817198 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -5384,6 +5384,21 @@ int hci_abort_conn_sync(struct hci_dev *hdev, st=
ruct hci_conn *conn, u8 reason)
> >               err =3D hci_reject_conn_sync(hdev, conn, reason);
> >               break;
> >       case BT_OPEN:
> > +             hci_dev_lock(hdev);
> > +
> > +             /* Cleanup bis or pa sync connections */
> > +             if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->f=
lags) ||
> > +                 test_and_clear_bit(HCI_CONN_PA_SYNC_FAILED, &conn->fl=
ags)) {
> > +                     hci_conn_failed(conn, reason);
> > +             } else if (test_bit(HCI_CONN_PA_SYNC, &conn->flags) ||
> > +                        test_bit(HCI_CONN_BIG_SYNC, &conn->flags)) {
> > +                     conn->state =3D BT_CLOSED;
> > +                     hci_disconn_cfm(conn, reason);
> > +                     hci_conn_del(conn);
> > +             }
> > +
> > +             hci_dev_unlock(hdev);
> > +             return 0;
>
> Note the hci_disconnect_all_sync changes in 45c37c4e9c9aab5b now
> require the conn is deleted in all cases, the above probably results to
> busy loop if non-ISO broadcast conn is in BT_OPEN when controller is
> supended.

Yep, I wonder if we could just keep doing hci_conn_failed, it seems
the only difference seem that hci_disconn_cfm must be called in
certain cases where PA or BIG is being setup over hci_connnect_cfm
which is already handled by hci_conn_failed.

>
> >       case BT_BOUND:
> >               hci_dev_lock(hdev);
> >               hci_conn_failed(conn, reason);
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index 6b66d6a88b9a..9879f2349d48 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -51,6 +51,7 @@ static void iso_sock_kill(struct sock *sk);
> >  /* iso_pinfo flags values */
> >  enum {
> >       BT_SK_BIG_SYNC,
> > +     BT_SK_PA_SYNC,
> >  };
> >
> >  struct iso_pinfo {
> > @@ -75,6 +76,8 @@ static struct bt_iso_qos default_qos;
> >
> >  static bool check_ucast_qos(struct bt_iso_qos *qos);
> >  static bool check_bcast_qos(struct bt_iso_qos *qos);
> > +static bool iso_match_sid(struct sock *sk, void *data);
> > +static void iso_sock_disconn(struct sock *sk);
> >
> >  /* ---- ISO timers ---- */
> >  #define ISO_CONN_TIMEOUT     (HZ * 40)
> > @@ -598,6 +601,15 @@ static void iso_sock_cleanup_listen(struct sock *p=
arent)
> >               iso_sock_kill(sk);
> >       }
> >
> > +     /* If listening socket stands for a PA sync connection,
> > +      * properly disconnect the hcon and socket.
> > +      */
> > +     if (iso_pi(parent)->conn && iso_pi(parent)->conn->hcon &&
> > +         test_bit(HCI_CONN_PA_SYNC, &iso_pi(parent)->conn->hcon->flags=
)) {
> > +             iso_sock_disconn(parent);
> > +             return;
> > +     }
> > +
> >       parent->sk_state  =3D BT_CLOSED;
> >       sock_set_flag(parent, SOCK_ZAPPED);
> >  }
> > @@ -619,6 +631,16 @@ static void iso_sock_kill(struct sock *sk)
> >       sock_put(sk);
> >  }
> >
> > +static void iso_sock_disconn(struct sock *sk)
> > +{
> > +     sk->sk_state =3D BT_DISCONN;
> > +     iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
> > +     iso_conn_lock(iso_pi(sk)->conn);
> > +     hci_conn_drop(iso_pi(sk)->conn->hcon);
> > +     iso_pi(sk)->conn->hcon =3D NULL;
> > +     iso_conn_unlock(iso_pi(sk)->conn);
> > +}
> > +
> >  static void __iso_sock_close(struct sock *sk)
> >  {
> >       BT_DBG("sk %p state %d socket %p", sk, sk->sk_state, sk->sk_socke=
t);
> > @@ -631,20 +653,19 @@ static void __iso_sock_close(struct sock *sk)
> >       case BT_CONNECT:
> >       case BT_CONNECTED:
> >       case BT_CONFIG:
> > -             if (iso_pi(sk)->conn->hcon) {
> > -                     sk->sk_state =3D BT_DISCONN;
> > -                     iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
> > -                     iso_conn_lock(iso_pi(sk)->conn);
> > -                     hci_conn_drop(iso_pi(sk)->conn->hcon);
> > -                     iso_pi(sk)->conn->hcon =3D NULL;
> > -                     iso_conn_unlock(iso_pi(sk)->conn);
> > -             } else {
> > +             if (iso_pi(sk)->conn->hcon)
> > +                     iso_sock_disconn(sk);
> > +             else
> >                       iso_chan_del(sk, ECONNRESET);
> > -             }
> >               break;
> >
> >       case BT_CONNECT2:
> > -             iso_chan_del(sk, ECONNRESET);
> > +             if (iso_pi(sk)->conn->hcon &&
> > +                 (test_bit(HCI_CONN_PA_SYNC, &iso_pi(sk)->conn->hcon->=
flags) ||
> > +                 test_bit(HCI_CONN_PA_SYNC_FAILED, &iso_pi(sk)->conn->=
hcon->flags)))
> > +                     iso_sock_disconn(sk);
> > +             else
> > +                     iso_chan_del(sk, ECONNRESET);
> >               break;
> >       case BT_DISCONN:
> >               iso_chan_del(sk, ECONNRESET);
> > @@ -1139,6 +1160,29 @@ static void iso_conn_defer_accept(struct hci_con=
n *conn)
> >       hci_send_cmd(hdev, HCI_OP_LE_ACCEPT_CIS, sizeof(cp), &cp);
> >  }
> >
> > +static void iso_conn_big_sync(struct sock *sk)
> > +{
> > +     int err;
> > +     struct hci_dev *hdev;
> > +
> > +     hdev =3D hci_get_route(&iso_pi(sk)->dst, &iso_pi(sk)->src,
> > +                          iso_pi(sk)->src_type);
> > +
> > +     if (!hdev)
> > +             return;
> > +
> > +     if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
> > +             err =3D hci_le_big_create_sync(hdev, iso_pi(sk)->conn->hc=
on,
> > +                                          &iso_pi(sk)->qos,
> > +                                          iso_pi(sk)->sync_handle,
> > +                                          iso_pi(sk)->bc_num_bis,
> > +                                          iso_pi(sk)->bc_bis);
> > +             if (err)
> > +                     bt_dev_err(hdev, "hci_le_big_create_sync: %d",
> > +                                err);
> > +     }
> > +}
> > +
> >  static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
> >                           size_t len, int flags)
> >  {
> > @@ -1151,8 +1195,15 @@ static int iso_sock_recvmsg(struct socket *sock,=
 struct msghdr *msg,
> >               lock_sock(sk);
> >               switch (sk->sk_state) {
> >               case BT_CONNECT2:
> > -                     iso_conn_defer_accept(pi->conn->hcon);
> > -                     sk->sk_state =3D BT_CONFIG;
> > +                     if (pi->conn->hcon &&
> > +                         test_bit(HCI_CONN_PA_SYNC, &pi->conn->hcon->f=
lags)) {
> > +                             iso_conn_big_sync(sk);
> > +                             sk->sk_state =3D BT_LISTEN;
> > +                             set_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags=
);
> > +                     } else {
> > +                             iso_conn_defer_accept(pi->conn->hcon);
> > +                             sk->sk_state =3D BT_CONFIG;
> > +                     }
> >                       release_sock(sk);
> >                       return 0;
> >               case BT_CONNECT:
> > @@ -1513,11 +1564,17 @@ static bool iso_match_big(struct sock *sk, void=
 *data)
> >       return ev->handle =3D=3D iso_pi(sk)->qos.bcast.big;
> >  }
> >
> > +static bool iso_match_pa_sync_flag(struct sock *sk, void *data)
> > +{
> > +     return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
> > +}
> > +
> >  static void iso_conn_ready(struct iso_conn *conn)
> >  {
> > -     struct sock *parent;
> > +     struct sock *parent =3D NULL;
> >       struct sock *sk =3D conn->sk;
> > -     struct hci_ev_le_big_sync_estabilished *ev;
> > +     struct hci_ev_le_big_sync_estabilished *ev =3D NULL;
> > +     struct hci_ev_le_pa_sync_established *ev2 =3D NULL;
> >       struct hci_conn *hcon;
> >
> >       BT_DBG("conn %p", conn);
> > @@ -1529,15 +1586,32 @@ static void iso_conn_ready(struct iso_conn *con=
n)
> >               if (!hcon)
> >                       return;
> >
> > -             ev =3D hci_recv_event_data(hcon->hdev,
> > -                                      HCI_EVT_LE_BIG_SYNC_ESTABILISHED=
);
> > -             if (ev)
> > +             if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags) ||
> > +                 test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
> > +                     ev =3D hci_recv_event_data(hcon->hdev,
> > +                                              HCI_EVT_LE_BIG_SYNC_ESTA=
BILISHED);
> > +
> > +                     /* Get reference to PA sync parent socket, if it =
exists */
> >                       parent =3D iso_get_sock_listen(&hcon->src,
> >                                                    &hcon->dst,
> > -                                                  iso_match_big, ev);
> > -             else
> > +                                                  iso_match_pa_sync_fl=
ag, NULL);
> > +                     if (!parent && ev)
> > +                             parent =3D iso_get_sock_listen(&hcon->src=
,
> > +                                                          &hcon->dst,
> > +                                                          iso_match_bi=
g, ev);
> > +             } else if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags) ||
> > +                             test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->=
flags)) {
> > +                     ev2 =3D hci_recv_event_data(hcon->hdev,
> > +                                               HCI_EV_LE_PA_SYNC_ESTAB=
LISHED);
> > +                     if (ev2)
> > +                             parent =3D iso_get_sock_listen(&hcon->src=
,
> > +                                                          &hcon->dst,
> > +                                                          iso_match_si=
d, ev2);
> > +             }
> > +
> > +             if (!parent)
> >                       parent =3D iso_get_sock_listen(&hcon->src,
> > -                                                  BDADDR_ANY, NULL, NU=
LL);
> > +                                                     BDADDR_ANY, NULL,=
 NULL);
> >
> >               if (!parent)
> >                       return;
> > @@ -1554,11 +1628,17 @@ static void iso_conn_ready(struct iso_conn *con=
n)
> >               iso_sock_init(sk, parent);
> >
> >               bacpy(&iso_pi(sk)->src, &hcon->src);
> > -             iso_pi(sk)->src_type =3D hcon->src_type;
> > +
> > +             /* Convert from HCI to three-value type */
> > +             if (hcon->src_type =3D=3D ADDR_LE_DEV_PUBLIC)
> > +                     iso_pi(sk)->src_type =3D BDADDR_LE_PUBLIC;
> > +             else
> > +                     iso_pi(sk)->src_type =3D BDADDR_LE_RANDOM;
> >
> >               /* If hcon has no destination address (BDADDR_ANY) it mea=
ns it
> > -              * was created by HCI_EV_LE_BIG_SYNC_ESTABILISHED so we n=
eed to
> > -              * initialize using the parent socket destination address=
.
> > +              * was created by HCI_EV_LE_BIG_SYNC_ESTABILISHED or
> > +              * HCI_EV_LE_PA_SYNC_ESTABLISHED so we need to initialize=
 using
> > +              * the parent socket destination address.
> >                */
> >               if (!bacmp(&hcon->dst, BDADDR_ANY)) {
> >                       bacpy(&hcon->dst, &iso_pi(parent)->dst);
> > @@ -1566,13 +1646,21 @@ static void iso_conn_ready(struct iso_conn *con=
n)
> >                       hcon->sync_handle =3D iso_pi(parent)->sync_handle=
;
> >               }
> >
> > +             if (ev2 && !ev2->status) {
> > +                     iso_pi(sk)->sync_handle =3D iso_pi(parent)->sync_=
handle;
> > +                     iso_pi(sk)->qos =3D iso_pi(parent)->qos;
> > +                     iso_pi(sk)->bc_num_bis =3D iso_pi(parent)->bc_num=
_bis;
> > +                     memcpy(iso_pi(sk)->bc_bis, iso_pi(parent)->bc_bis=
, ISO_MAX_NUM_BIS);
> > +             }
> > +
> >               bacpy(&iso_pi(sk)->dst, &hcon->dst);
> >               iso_pi(sk)->dst_type =3D hcon->dst_type;
> >
> >               hci_conn_hold(hcon);
> >               iso_chan_add(conn, sk, parent);
> >
> > -             if (ev && ((struct hci_evt_le_big_sync_estabilished *)ev)=
->status) {
> > +             if ((ev && ((struct hci_evt_le_big_sync_estabilished *)ev=
)->status) ||
> > +                 (ev2 && ev2->status)) {
> >                       /* Trigger error signal on child socket */
> >                       sk->sk_err =3D ECONNREFUSED;
> >                       sk->sk_error_report(sk);
> > @@ -1630,7 +1718,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_=
t *bdaddr, __u8 *flags)
> >       if (ev1) {
> >               sk =3D iso_get_sock_listen(&hdev->bdaddr, bdaddr, iso_mat=
ch_sid,
> >                                        ev1);
> > -             if (sk)
> > +             if (sk && !ev1->status)
> >                       iso_pi(sk)->sync_handle =3D le16_to_cpu(ev1->hand=
le);
> >
> >               goto done;
> > @@ -1638,16 +1726,21 @@ int iso_connect_ind(struct hci_dev *hdev, bdadd=
r_t *bdaddr, __u8 *flags)
> >
> >       ev2 =3D hci_recv_event_data(hdev, HCI_EVT_LE_BIG_INFO_ADV_REPORT)=
;
> >       if (ev2) {
> > +             /* Try to get PA sync listening socket, if it exists */
> >               sk =3D iso_get_sock_listen(&hdev->bdaddr, bdaddr,
> > -                                      iso_match_sync_handle, ev2);
> > +                                             iso_match_pa_sync_flag, N=
ULL);
> > +             if (!sk)
> > +                     sk =3D iso_get_sock_listen(&hdev->bdaddr, bdaddr,
> > +                                              iso_match_sync_handle, e=
v2);
> >               if (sk) {
> >                       int err;
> >
> >                       if (ev2->num_bis < iso_pi(sk)->bc_num_bis)
> >                               iso_pi(sk)->bc_num_bis =3D ev2->num_bis;
> >
> > -                     if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)=
->flags)) {
> > -                             err =3D hci_le_big_create_sync(hdev,
> > +                     if (!test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flag=
s) &&
> > +                         !test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)=
->flags)) {
> > +                             err =3D hci_le_big_create_sync(hdev, NULL=
,
> >                                                            &iso_pi(sk)-=
>qos,
> >                                                            iso_pi(sk)->=
sync_handle,
> >                                                            iso_pi(sk)->=
bc_num_bis,
> > @@ -1699,12 +1792,13 @@ static void iso_connect_cfm(struct hci_conn *hc=
on, __u8 status)
> >
> >       BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst, status)=
;
> >
> > -     /* Similar to the success case, if HCI_CONN_BIG_SYNC_FAILED is se=
t,
> > -      * queue the failed bis connection into the accept queue of the
> > -      * listening socket and wake up userspace, to inform the user abo=
ut
> > -      * the BIG sync failed event.
> > +     /* Similar to the success case, if HCI_CONN_BIG_SYNC_FAILED or
> > +      * HCI_CONN_PA_SYNC_FAILED is set, queue the failed connection
> > +      * into the accept queue of the listening socket and wake up
> > +      * userspace, to inform the user about the event.
> >        */
> > -     if (!status || test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) =
{
> > +     if (!status || test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags) |=
|
> > +         test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags)) {
> >               struct iso_conn *conn;
> >
> >               conn =3D iso_conn_add(hcon);
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
