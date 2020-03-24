Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254D3C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 23:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC71820870
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 23:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDUgtaqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgCXXKP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 19:10:15 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42568 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgCXXKP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 19:10:15 -0400
Received: by mail-oi1-f194.google.com with SMTP id e4so327476oig.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2020 16:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UsQ0ShxzQxcustTXRyFI+CqaQiHbkHnUBCFYg+jAkH0=;
        b=mDUgtaqQ2iZbf2BAaVzKfmcNFHYBhVyKo0F8oy20aF+p9RXYfklD0xllPAWdqqb1LV
         lxjpfpz72YJ/Myx5s5BxdojYpJlF6IzIF3rrZSupa1eb89PUBp5QJVormv0auYEXrNW3
         mUN+Ny0dIj0NyrwxaGQ4vnl/1eS12ZgeUnSz6Wq7w5cDRd4U4qVn8hJTOyzwWxcEGkY2
         uLeyDI/s7qAlnnDJNlWoSFcsq0nb3JKYBAqVgqhboiLpRt1bCI5V1GfxXuw/ZmMr2/wK
         zRCGBu3wzJIkhIGt4Ec9aNu0B1BoxNanV6K/BgzPOI309TGyIMY73o4nWiikHaSAqhpS
         XvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UsQ0ShxzQxcustTXRyFI+CqaQiHbkHnUBCFYg+jAkH0=;
        b=ai4Rx27lckI4YOorUm6XkK1CVuzJWTEILuDYuFq6GLM8FoN1TPwC1YFyPQzfpEW7+w
         IqrDtWE6aZnFqTGKc3GUfAP5TU/4WwKwjSil6BFwjUZ1qrPBr9qk2+1QcLHsmSCZkRAn
         X9IJFhpJKUpwQ2ZidphKIl+5NlHecCCOxewv7pohQz7ouyo3ri+yaw0rEl/SwqUyRAhI
         VwFbAUTg1gAqgOsV9eKQjAoneSZmcP3x0RpJaoj4V0r709iyAi2LWXGFlaVEc++WRwD/
         1xjiF3cyNWHpirfcZ4feK1IniKAgAKqkQy78XnqtehWpE6OFJXnCikoqgwC2gPTxTOlr
         0lwg==
X-Gm-Message-State: ANhLgQ1k43vVfOW8CjBNkuZGf1EB78Pd1+pboUtVizRU6aLseaCl0rbC
        txjb5tRZX/IA97kEwWYuvl7TxHC4RE4hgaQlvCT9cQ==
X-Google-Smtp-Source: ADFU+vvWXyhb3diMmQjPvZoY8Pk9gxp971lxO1XrKyIe3R2TQJK6DTikncFW+3cGT9moltWtdfz2MMf9itlm524uGbs=
X-Received: by 2002:a54:4e13:: with SMTP id a19mr521077oiy.108.1585091413788;
 Tue, 24 Mar 2020 16:10:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200323203458.24733-1-luiz.dentz@gmail.com> <20200323203458.24733-3-luiz.dentz@gmail.com>
 <8BD7396B-9BEA-48DA-92A6-4863B72EBEEB@holtmann.org>
In-Reply-To: <8BD7396B-9BEA-48DA-92A6-4863B72EBEEB@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 24 Mar 2020 16:10:02 -0700
Message-ID: <CABBYNZLuZeEV_URWCTAvcJ=d-a-e5LTR2CkuvfEtkWqsJkikOA@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] Bluetooth: L2CAP: Use DEFER_SETUP to group ECRED connections
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Mar 24, 2020 at 1:47 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This uses the DEFER_SETUP flag to group channels with
> > L2CAP_CREDIT_BASED_CONNECTION_REQ.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/l2cap.h |   4 +
> > net/bluetooth/l2cap_core.c    | 136 +++++++++++++++++++++++++++++++---
> > 2 files changed, 130 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> > index 2d7d28474d34..dada14d0622c 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -47,6 +47,7 @@
> > #define L2CAP_DEFAULT_ACC_LAT         0xFFFFFFFF
> > #define L2CAP_BREDR_MAX_PAYLOAD               1019    /* 3-DH5 packet */
> > #define L2CAP_LE_MIN_MTU              23
> > +#define L2CAP_ECRED_CONN_SCID_MAX    5
> >
> > #define L2CAP_DISC_TIMEOUT            msecs_to_jiffies(100)
> > #define L2CAP_DISC_REJ_TIMEOUT                msecs_to_jiffies(5000)
> > @@ -984,6 +985,9 @@ void l2cap_chan_set_defaults(struct l2cap_chan *chan);
> > int l2cap_ertm_init(struct l2cap_chan *chan);
> > void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
> > void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
> > +typedef void (*l2cap_chan_func_t)(struct l2cap_chan *chan, void *data);
> > +void l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
> > +                  void *data);
> > void l2cap_chan_del(struct l2cap_chan *chan, int err);
> > void l2cap_send_conn_req(struct l2cap_chan *chan);
> > void l2cap_move_start(struct l2cap_chan *chan);
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index 5e6e35ab44dd..9f699d09d973 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -678,6 +678,29 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
> > }
> > EXPORT_SYMBOL_GPL(l2cap_chan_del);
> >
> > +static void __l2cap_chan_list(struct l2cap_conn *conn, l2cap_chan_func_t func,
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
> >       struct l2cap_conn *conn = container_of(work, struct l2cap_conn,
> > @@ -1356,29 +1379,79 @@ static void l2cap_le_connect(struct l2cap_chan *chan)
> >                      sizeof(req), &req);
> > }
> >
> > -static void l2cap_ecred_connect(struct l2cap_chan *chan)
> > -{
> > -     struct l2cap_conn *conn = chan->conn;
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
> > +static void l2cap_ecred_defer_connect(struct l2cap_chan *chan, void *data)
> > +{
> > +     struct l2cap_ecred_conn_data *conn = data;
> > +     struct pid *pid;
> > +
> > +     if (chan == conn->chan)
> > +             return;
> > +
> > +     if (!test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
> > +             return;
> > +
> > +     pid = chan->ops->get_peer_pid(chan);
> > +
> > +     /* Only add deferred channels with the same PID/PSM */
> > +     if (conn->pid != pid || chan->psm != conn->chan->psm || chan->ident ||
> > +         chan->mode != L2CAP_MODE_EXT_FLOWCTL || chan->state != BT_CONNECT)
> > +             return;
> > +
> > +     if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
> > +             return;
> > +
> > +     l2cap_ecred_init(chan, 0);
> > +
> > +     /* Set the same ident so we can match on the rsp */
> > +     chan->ident = conn->chan->ident;
> > +
> > +     /* Include all channels deferred */
> > +     conn->pdu.scid[conn->count] = cpu_to_le16(chan->scid);
> > +
> > +     conn->count++;
> > +}
> > +
> > +static void l2cap_ecred_connect(struct l2cap_chan *chan)
> > +{
> > +     struct l2cap_conn *conn = chan->conn;
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
> > -     pdu.req.psm     = chan->psm;
> > -     pdu.req.mtu     = cpu_to_le16(chan->imtu);
> > -     pdu.req.mps     = cpu_to_le16(chan->mps);
> > -     pdu.req.credits = cpu_to_le16(chan->rx_credits);
> > -     pdu.scid        = cpu_to_le16(chan->scid);
> > +     data.pdu.req.psm     = chan->psm;
> > +     data.pdu.req.mtu     = cpu_to_le16(chan->imtu);
> > +     data.pdu.req.mps     = cpu_to_le16(chan->mps);
> > +     data.pdu.req.credits = cpu_to_le16(chan->rx_credits);
> > +     data.pdu.scid[0]     = cpu_to_le16(chan->scid);
> >
> >       chan->ident = l2cap_get_ident(conn);
> > +     data.pid = chan->ops->get_peer_pid(chan);
> > +
> > +     data.count = 1;
> > +     data.chan = chan;
> > +     data.pid = chan->ops->get_peer_pid(chan);
> > +
> > +     __l2cap_chan_list(conn, l2cap_ecred_defer_connect, &data);
> >
> >       l2cap_send_cmd(conn, chan->ident, L2CAP_ECRED_CONN_REQ,
> > -                    sizeof(pdu), &pdu);
> > +                    sizeof(data.pdu.req) + data.count * sizeof(__le16),
> > +                    &data.pdu);
> > }
> >
> > static void l2cap_le_start(struct l2cap_chan *chan)
> > @@ -7694,6 +7767,33 @@ static bool is_valid_psm(u16 psm, u8 dst_type) {
> >       return ((psm & 0x0101) == 0x0001);
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
> > +     struct l2cap_chan_data *d = data;
> > +     struct pid *pid;
> > +
> > +     if (chan == d->chan)
> > +             return;
> > +
> > +     if (!test_bit(FLAG_DEFER_SETUP, &chan->flags))
> > +             return;
> > +
> > +     pid = chan->ops->get_peer_pid(chan);
> > +
> > +     /* Only count deferred channels with the same PID/PSM */
> > +     if (d->pid != pid || chan->psm != d->chan->psm || chan->ident ||
> > +         chan->mode != L2CAP_MODE_EXT_FLOWCTL || chan->state != BT_CONNECT)
> > +             return;
> > +
> > +     d->count++;
> > +}
> > +
> > int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
> >                      bdaddr_t *dst, u8 dst_type)
> > {
> > @@ -7813,6 +7913,22 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
> >               goto done;
> >       }
> >
> > +     if (chan->mode == L2CAP_MODE_EXT_FLOWCTL) {
> > +             struct l2cap_chan_data data;
> > +
> > +             data.chan = chan;
> > +             data.pid = chan->ops->get_peer_pid(chan);
> > +             data.count = 0;
> > +
> > +             l2cap_chan_list(conn, l2cap_chan_by_pid, &data);
>
> Put an empty line after this. It gives emphasis to the comment.
>
> > +             /* Check if there isn't too many channels being connected */
> > +             if (!(data.count < L2CAP_ECRED_CONN_SCID_MAX - 1)) {
>
> If (data.count > L2CAP_ECRED_CONN_SCID_MIX) ???

We need to take into account the chan itself is not part of the list
yet, so that means data.count + 1 or we initialize the it as 1 a
couple lines before, I will change the logic to use > operation.

> > +                     hci_conn_drop(hcon);
> > +                     err = -EPROTO;
> > +                     goto done;
> > +             }
> > +     }
> > +
> >       mutex_lock(&conn->chan_lock);
> >       l2cap_chan_lock(chan);
>
> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
