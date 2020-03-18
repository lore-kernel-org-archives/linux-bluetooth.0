Return-Path: <SRS0=jOg2=5D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C4BC5ACD6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 16:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C776720753
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Mar 2020 16:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrDakjx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgCRQ64 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:58:56 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37416 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCRQ6z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Mar 2020 12:58:55 -0400
Received: by mail-oi1-f195.google.com with SMTP id w13so26532565oih.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2020 09:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zedymcLfm2GxMe6xzaR2P2G74am7Xc/JSeGLtXW7ruI=;
        b=QrDakjx9hp4QpmcjNlWmv22kKE1VxFJexd2V071vPVGT52qW/cqHs2T2xUhi055uSs
         6xjEkjcJZ45EEJJ4Xt1fhdMuzgNSVGScWDrmrKf8HNQxg1HPJwfXFV4Oz5BpdP2uCR2P
         /q3byBthkSZ2RJJVm9QQcllqVnhkUy0ZoT9Ywm2oM7IqgXf2ftTlKIcYyxEJIP5uOwNR
         YDb8tTY1q4N1QxKee1pIruK0qzpf6qVy1i8G5vKibFZgcZ2Os5D7hAkkh7/kn2T1TGOl
         RHIpWP32LK1k9PKb74vwf7NpdGC5r81UifiLdX4wsxPSvXILLq0ySyr5z9EbV3A3agkE
         tfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zedymcLfm2GxMe6xzaR2P2G74am7Xc/JSeGLtXW7ruI=;
        b=V45Klt8oR7FigNk1lBbZjhZ3FYOlfVQW7ca02Q7/wVwR+wo+CnhFcd4nVlkUckSaHU
         v3Yf/UYHwXgRDHLubghB9ITYeesxFzbzvSjUzLU4tpOhaKj3/BF4tzPBd50YbfGNpNVc
         KjrhcYQidNfwKXH+40kGgQelgH5lsjm0SHuxd9+stn2GH03LyDz67xqITUjin8J7s+rj
         k2DFmBLO/y6GF9OpjR9oUSUnaczGbwuMgQ5LdRUYfOf7YVhQUXfRe/jGt7q7TreGJ3G2
         NH9DWwAKU8W+5ccn3J+YwkuhZ26RnBWwDE3B4QcsL6p/FGX20O1gwHm9elZmI+7bnw/x
         VfeA==
X-Gm-Message-State: ANhLgQ24P8YLJKVul8+1E03Az2vBEpoQ++cHpgv/UmCklKIruD0jBCnl
        J6sGrmvJdZ838aPEOAGltfA2pJvTfVurnQHKyoFw8Q==
X-Google-Smtp-Source: ADFU+vvvD++BzGY3VqvKbXzobxndeumNZ1Ri+y0eiVnXGlLKF78iDNlscX4CYjHk94Xif8iWpTYJXw0aex3BqCUwBx0=
X-Received: by 2002:aca:b1d5:: with SMTP id a204mr3883578oif.82.1584550734390;
 Wed, 18 Mar 2020 09:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200312222454.5079-1-luiz.dentz@gmail.com> <20200312222454.5079-2-luiz.dentz@gmail.com>
 <F140112C-C0CA-4894-9CD9-48EA67705879@holtmann.org>
In-Reply-To: <F140112C-C0CA-4894-9CD9-48EA67705879@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 18 Mar 2020 09:58:42 -0700
Message-ID: <CABBYNZ+bx1O6E9GR+fVPfhEfrOLA=DFT9nGjaauwDDwoV1uBwA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED connections
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Wed, Mar 18, 2020 at 4:13 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Luiz,
>
> > This uses the DEFER_SETUP flag to group channels with
> > L2CAP_CREDIT_BASED_CONNECTION_REQ.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/l2cap.h |   5 ++
> > net/bluetooth/l2cap_core.c    | 130 +++++++++++++++++++++++++++++++---
> > net/bluetooth/l2cap_sock.c    |  13 ++--
> > 3 files changed, 133 insertions(+), 15 deletions(-)
> >
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2ca=
p.h
> > index 537aaead259f..dada14d0622c 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -47,6 +47,7 @@
> > #define L2CAP_DEFAULT_ACC_LAT         0xFFFFFFFF
> > #define L2CAP_BREDR_MAX_PAYLOAD               1019    /* 3-DH5 packet *=
/
> > #define L2CAP_LE_MIN_MTU              23
> > +#define L2CAP_ECRED_CONN_SCID_MAX    5
> >
> > #define L2CAP_DISC_TIMEOUT            msecs_to_jiffies(100)
> > #define L2CAP_DISC_REJ_TIMEOUT                msecs_to_jiffies(5000)
> > @@ -660,6 +661,7 @@ struct l2cap_ops {
> >       void                    (*suspend) (struct l2cap_chan *chan);
> >       void                    (*set_shutdown) (struct l2cap_chan *chan)=
;
> >       long                    (*get_sndtimeo) (struct l2cap_chan *chan)=
;
> > +     struct pid              *(*get_peer_pid) (struct l2cap_chan *chan=
);
>
> I would move this support into a separate patch. I think that can be appl=
ied independently.

Will do.

> >       struct sk_buff          *(*alloc_skb) (struct l2cap_chan *chan,
> >                                              unsigned long hdr_len,
> >                                              unsigned long len, int nb)=
;
> > @@ -983,6 +985,9 @@ void l2cap_chan_set_defaults(struct l2cap_chan *cha=
n);
> > int l2cap_ertm_init(struct l2cap_chan *chan);
> > void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
> > void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)=
;
> > +typedef void (*l2cap_chan_func_t)(struct l2cap_chan *chan, void *data)=
;
> > +void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
> > +                  void *data);
> > void l2cap_chan_del(struct l2cap_chan *chan, int err);
> > void l2cap_send_conn_req(struct l2cap_chan *chan);
> > void l2cap_move_start(struct l2cap_chan *chan);
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 5e6e35ab44dd..20c1d5f9c238 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -678,6 +678,29 @@ void l2cap_chan_del(struct l2cap_chan *chan, int e=
rr)
> > }
> > EXPORT_SYMBOL_GPL(l2cap_chan_del);
> >
> > +static void __l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func=
_t func,
> > +                           void *data)
> > +{
> > +     struct l2cap_chan *chan;
> > +
> > +     list_for_each_entry(chan, &conn->chan_l, list) {
> > +             func(chan, data);
> > +     }
> > +}
> > +
> > +void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
> > +                  void *data)
> > +{
> > +     if (!conn)
> > +             return;
> > +
> > +     mutex_lock(&conn->chan_lock);
> > +     __l2cap_chan_list(conn, func, data);
> > +     mutex_unlock(&conn->chan_lock);
> > +}
> > +
> > +EXPORT_SYMBOL_GPL(l2cap_chan_list);
> > +
> > static void l2cap_conn_update_id_addr(struct work_struct *work)
> > {
> >       struct l2cap_conn *conn =3D container_of(work, struct l2cap_conn,
> > @@ -1356,29 +1379,77 @@ static void l2cap_le_connect(struct l2cap_chan =
*chan)
> >                      sizeof(req), &req);
> > }
> >
> > -static void l2cap_ecred_connect(struct l2cap_chan *chan)
> > -{
> > -     struct l2cap_conn *conn =3D chan->conn;
> > +struct l2cap_ecred_conn_data {
> >       struct {
> >               struct l2cap_ecred_conn_req req;
> > -             __le16 scid;
> > +             __le16 scid[5];
> >       } __packed pdu;
> > +     struct l2cap_chan *chan;
> > +     struct pid *pid;
> > +     int count;
> > +};
> > +
> > +static void l2cap_ecred_defer_connect(struct l2cap_chan *chan, void *d=
ata)
> > +{
> > +     struct l2cap_ecred_conn_data *conn =3D data;
> > +     struct pid *pid;
> > +
> > +     if (chan =3D=3D conn->chan)
> > +             return;
> > +
> > +     if (!test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
> > +             return;
> > +
> > +     pid =3D chan->ops->get_peer_pid(chan);
> > +
> > +     /* Only add deferred channels with the same PID/PSM */
> > +     if (conn->pid !=3D pid || chan->psm !=3D conn->chan->psm || chan-=
>ident ||
> > +         chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL || chan->state !=3D BT=
_CONNECT)
> > +             return;
> > +
> > +     if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
> > +             return;
> > +
> > +     /* Set the same ident so we can match on the rsp */
> > +     chan->ident =3D conn->chan->ident;
> > +
> > +     /* Include all channels deferred */
> > +     conn->pdu.scid[conn->count] =3D cpu_to_le16(chan->scid);
> > +
> > +     conn->count++;
> > +}
> > +
> > +static void l2cap_ecred_connect(struct l2cap_chan *chan)
> > +{
> > +     struct l2cap_conn *conn =3D chan->conn;
> > +     struct l2cap_ecred_conn_data data;
> > +
> > +     if (test_bit(FLAG_DEFER_SETUP, &chan->flags))
> > +             return;
> >
> >       if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
> >               return;
> >
> >       l2cap_ecred_init(chan, 0);
> >
> > -     pdu.req.psm     =3D chan->psm;
> > -     pdu.req.mtu     =3D cpu_to_le16(chan->imtu);
> > -     pdu.req.mps     =3D cpu_to_le16(chan->mps);
> > -     pdu.req.credits =3D cpu_to_le16(chan->rx_credits);
> > -     pdu.scid        =3D cpu_to_le16(chan->scid);
> > +     data.pdu.req.psm     =3D chan->psm;
> > +     data.pdu.req.mtu     =3D cpu_to_le16(chan->imtu);
> > +     data.pdu.req.mps     =3D cpu_to_le16(chan->mps);
> > +     data.pdu.req.credits =3D cpu_to_le16(chan->rx_credits);
> > +     data.pdu.scid[0]     =3D cpu_to_le16(chan->scid);
> >
> >       chan->ident =3D l2cap_get_ident(conn);
> > +     data.pid =3D chan->ops->get_peer_pid(chan);
> > +
> > +     data.count =3D 1;
> > +     data.chan =3D chan;
> > +     data.pid =3D chan->ops->get_peer_pid(chan);
> > +
> > +     __l2cap_chan_list(conn, l2cap_ecred_defer_connect, &data);
> >
> >       l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_CONN_REQ,
> > -                    sizeof(pdu), &pdu);
> > +                    sizeof(data.pdu.req) + data.count * sizeof(__le16)=
,
> > +                    &data.pdu);
> > }
> >
> > static void l2cap_le_start(struct l2cap_chan *chan)
> > @@ -7694,6 +7765,29 @@ static bool is_valid_psm(u16 psm, u8 dst_type) {
> >       return ((psm & 0x0101) =3D=3D 0x0001);
> > }
> >
> > +struct l2cap_chan_data {
> > +     struct l2cap_chan *chan;
> > +     struct pid *pid;
> > +     int count;
> > +};
> > +
> > +static void l2cap_chan_by_pid(struct l2cap_chan *chan, void *data)
> > +{
> > +     struct l2cap_chan_data *d =3D data;
> > +
> > +     if (chan =3D=3D d->chan)
> > +             return;
> > +
> > +     /* Only count deferred channels with the same PID/PSM */
> > +     if (d->pid !=3D chan->ops->get_peer_pid(chan) ||
> > +         !test_bit(FLAG_DEFER_SETUP, &chan->flags) ||
> > +         chan->psm !=3D d->chan->psm || chan->ident ||
> > +         chan->state !=3D BT_CONNECT)
> > +             return;
> > +
> > +     d->count++;
> > +}
> > +
> > int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
> >                      bdaddr_t *dst, u8 dst_type)
> > {
> > @@ -7813,6 +7907,22 @@ int l2cap_chan_connect(struct l2cap_chan *chan, =
__le16 psm, u16 cid,
> >               goto done;
> >       }
> >
> > +     if (chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) {
> > +             struct l2cap_chan_data data;
> > +
> > +             data.chan =3D chan;
> > +             data.pid =3D chan->ops->get_peer_pid(chan);
> > +             data.count =3D 0;
> > +
> > +             l2cap_chan_list(conn, l2cap_chan_by_pid, &data);
> > +             /* Check if there isn't too many channels being connected=
 */
> > +             if (!(data.count < L2CAP_ECRED_CONN_SCID_MAX - 1)) {
> > +                     hci_conn_drop(hcon);
> > +                     err =3D -EPROTO;
> > +                     goto done;
> > +             }
> > +     }
> > +
> >       mutex_lock(&conn->chan_lock);
> >       l2cap_chan_lock(chan);
> >
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 40fb10b591bd..e43a90e05972 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -549,11 +549,6 @@ static int l2cap_sock_getsockopt(struct socket *so=
ck, int level, int optname,
> >               break;
> >
> >       case BT_DEFER_SETUP:
> > -             if (sk->sk_state !=3D BT_BOUND && sk->sk_state !=3D BT_LI=
STEN) {
> > -                     err =3D -EINVAL;
> > -                     break;
> > -             }
> > -
>
> I removing this really a good idea. I think it is not really so bad to fo=
rce at least BT_BOUND so that a local controller has been at least somehow =
selected. Just doing setsockopt(DEFER_SETUP) and then connect() seems weird=
. Let us force the application to at least bind the local controller for th=
is specific usage. They can still bind with BDADDR_ANY, but that gives us a=
 bit cleaner state handling.

Right, for some odd reason I remember this check being specific for
listen only but in fact it should work with l2cap-tester as it does
bind before doing BT_DEFER_SETUP.

>
> >               if (put_user(test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flag=
s),
> >                            (u32 __user *) optval))
> >                       err =3D -EFAULT;
> > @@ -1504,6 +1499,13 @@ static long l2cap_sock_get_sndtimeo_cb(struct l2=
cap_chan *chan)
> >       return sk->sk_sndtimeo;
> > }
> >
> > +static struct pid *l2cap_sock_get_peer_pid_cb(struct l2cap_chan *chan)
> > +{
> > +     struct sock *sk =3D chan->data;
> > +
> > +     return sk->sk_peer_pid;
> > +}
> > +
> > static void l2cap_sock_suspend_cb(struct l2cap_chan *chan)
> > {
> >       struct sock *sk =3D chan->data;
> > @@ -1525,6 +1527,7 @@ static const struct l2cap_ops l2cap_chan_ops =3D =
{
> >       .suspend                =3D l2cap_sock_suspend_cb,
> >       .set_shutdown           =3D l2cap_sock_set_shutdown_cb,
> >       .get_sndtimeo           =3D l2cap_sock_get_sndtimeo_cb,
> > +     .get_peer_pid           =3D l2cap_sock_get_peer_pid_cb,
> >       .alloc_skb              =3D l2cap_sock_alloc_skb_cb,
> > };
>
> Regards
>
> Marcel
>


--=20
Luiz Augusto von Dentz
