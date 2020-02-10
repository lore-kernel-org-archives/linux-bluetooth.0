Return-Path: <SRS0=FZvY=36=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B474DC352A4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Feb 2020 21:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7651E2072C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Feb 2020 21:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiI5Jbgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBJVOD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:14:03 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46509 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJVOC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Feb 2020 16:14:02 -0500
Received: by mail-oi1-f196.google.com with SMTP id a22so10603288oid.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2020 13:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/OJX83D+Or1dYiKaw59kNKInehLXdL0t8F+jfCVvvco=;
        b=FiI5Jbgp/UV8U6bMSktCUQvrHP95QjgzoxXZgiJvZSOyN8fafP/H1grJedwcJ0+Xc6
         Ca9ZqqgxEHWcKxqMdIq/orzMLIXQfV+Lf6khuZ8tIeA0Ncn7X9ixO0RJgl4nmH92DpGh
         oK1qxnzuRvvfuW4MyscZHqwY9G8C+G0E9TzsRJnG95dzB/TCx7SevzcAf1hMW5w56ixL
         e+iKC9y8VhP8fiUzk6vd6exn+qSli0YQXlEfWGUOi15O6voF3JstA5KNvBAO4waLPvJD
         xgNLnE9W3wGICM2ZPsOdatUnHmoFhovAE6JpldTvDCnrHOoa059PaZTN5d4m4PziTYSw
         XhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OJX83D+Or1dYiKaw59kNKInehLXdL0t8F+jfCVvvco=;
        b=cAPetZelAXbCitpX6JC56XR8aTSIlO+FiC9Sdq+TIQ5Fikjsrd9NAf3XykaZjcOdtm
         U33DdwucMu0R5+1lVW9ZpEeQwe4DsAukyAQ+JOqblrCsg9mLqXSWdY1sAMffjp1ANzL7
         G5F1FKWGQ9WjvO3cfNGT2qRIVEYz845ufA2kPM2g/bvds3FKBqaOHCcEiN6jt/Tg8uD5
         Zv6OTvzM9DpYCSVV4vl/tsSUEGU2MlyB/ECBeoidVgx2LOSkNyGYchwIL1XwMETlzgqI
         NcAstqED/Og8YEnZR99Z/Ccu19T9beTKbXjjhHwjos3O79cQqfwHrSgOLkEpPBuuUSMG
         KeEA==
X-Gm-Message-State: APjAAAUYE3n5knzflHZRbx2vI0PJdsj+K5GkPkCYUKB65M5VV+WauLdi
        JaZ+d+NJkl7WsiGkXPHQHMhK9+zdVvkKEfvY2S2Z7Q==
X-Google-Smtp-Source: APXvYqy7MvAYh3QMEAur8nRkG7cnGjWXf7dsXGgLgFyuGIdYBu7B3fjIwhllJJIRjKWWaLRuOmPvz2mjusgyNG3FxMk=
X-Received: by 2002:a05:6808:98e:: with SMTP id a14mr696036oic.8.1581369241111;
 Mon, 10 Feb 2020 13:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20200207190055.15249-1-luiz.dentz@gmail.com> <13F78412-516A-4383-AD3F-F15296AA747B@holtmann.org>
In-Reply-To: <13F78412-516A-4383-AD3F-F15296AA747B@holtmann.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 10 Feb 2020 13:13:49 -0800
Message-ID: <CABBYNZJZZVzWe3CueUfNYUn8LJVTZinD7oSszPTbNBpTha4L3g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add BT_PHY socket option
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Sat, Feb 8, 2020 at 12:32 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Luiz,
>
> > This adds BT_PHY socket option (read-only) which can be used to read
> > the PHYs in use by the underline connection.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> > include/net/bluetooth/bluetooth.h | 17 ++++++
> > include/net/bluetooth/hci_core.h  |  2 +
> > net/bluetooth/hci_conn.c          | 88 +++++++++++++++++++++++++++++++
> > net/bluetooth/l2cap_sock.c        | 13 +++++
> > net/bluetooth/sco.c               | 13 +++++
> > 5 files changed, 133 insertions(+)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > index e42bb8e03c09..1576353a2773 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -121,6 +121,23 @@ struct bt_voice {
> >
> > #define BT_SNDMTU             12
> > #define BT_RCVMTU             13
> > +#define BT_PHY                       14
> > +
> > +#define BT_PHY_BR_1M_1SLOT   0x00000001
> > +#define BT_PHY_BR_1M_3SLOT   0x00000002
> > +#define BT_PHY_BR_1M_5SLOT   0x00000004
> > +#define BT_PHY_EDR_2M_1SLOT  0x00000008
> > +#define BT_PHY_EDR_2M_3SLOT  0x00000010
> > +#define BT_PHY_EDR_2M_5SLOT  0x00000020
> > +#define BT_PHY_EDR_3M_1SLOT  0x00000040
> > +#define BT_PHY_EDR_3M_3SLOT  0x00000080
> > +#define BT_PHY_EDR_3M_5SLOT  0x00000100
> > +#define BT_PHY_LE_1M_TX              0x00000200
> > +#define BT_PHY_LE_1M_RX              0x00000400
> > +#define BT_PHY_LE_2M_TX              0x00000800
> > +#define BT_PHY_LE_2M_RX              0x00001000
> > +#define BT_PHY_LE_CODED_TX   0x00002000
> > +#define BT_PHY_LE_CODED_RX   0x00004000
> >
> > __printf(1, 2)
> > void bt_info(const char *fmt, ...);
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index 89ecf0a80aa1..dcc0dc6e2624 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1477,6 +1477,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
> > struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
> >                            const void *param, u32 timeout);
> >
> > +u32 hci_conn_get_phy(struct hci_conn *conn);
> > +
> > /* ----- HCI Sockets ----- */
> > void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
> > void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 87691404d0c6..9ff2611b272f 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1725,3 +1725,91 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
> >
> >       return hchan;
> > }
> > +
> > +u32 hci_conn_get_phy(struct hci_conn *conn)
> > +{
> > +     u32 phys = 0;
> > +
> > +     hci_dev_lock(conn->hdev);
> > +
> > +     switch (conn->type) {
> > +     case SCO_LINK:
> > +             phys |= BT_PHY_BR_1M_1SLOT;
> > +
> > +             break;
>
> something is missing here. The SCO links can also be 3 and 5 slots.

I couldn't find any information regarding the slot for HV1, HV2, HV3
and DV so I assume they were all using 1 slot.

> > +
> > +     case ACL_LINK:
> > +             phys |= BT_PHY_BR_1M_1SLOT;
> > +
> > +             if (conn->pkt_type & (HCI_DM3 | HCI_DH3))
> > +                     phys |= BT_PHY_BR_1M_3SLOT;
> > +
> > +             if (conn->pkt_type & (HCI_DM5 | HCI_DH5))
> > +                     phys |= BT_PHY_BR_1M_5SLOT;
> > +
> > +             if (!(conn->pkt_type & HCI_2DH1))
> > +                     phys |= BT_PHY_EDR_2M_1SLOT;
> > +
> > +             if (!(conn->pkt_type & HCI_2DH3))
> > +                     phys |= BT_PHY_EDR_2M_3SLOT;
> > +
> > +             if (!(conn->pkt_type & HCI_2DH5))
> > +                     phys |= BT_PHY_EDR_2M_5SLOT;
> > +
> > +             if (!(conn->pkt_type & HCI_3DH1))
> > +                     phys |= BT_PHY_EDR_3M_1SLOT;
> > +
> > +             if (!(conn->pkt_type & HCI_3DH3))
> > +                     phys |= BT_PHY_EDR_3M_3SLOT;
> > +
> > +             if (!(conn->pkt_type & HCI_3DH5))
> > +                     phys |= BT_PHY_EDR_3M_5SLOT;
> > +
> > +             break;
> > +
> > +     case ESCO_LINK:
> > +             phys |= BT_PHY_BR_1M_1SLOT;
> > +
> > +             if (!(conn->pkt_type & (ESCO_EV4 | ESCO_EV5)))
> > +                     phys |= BT_PHY_BR_1M_3SLOT;
> > +
> > +             if (!(conn->pkt_type & ESCO_2EV3))
> > +                     phys |= BT_PHY_EDR_2M_1SLOT;
> > +
> > +             if (!(conn->pkt_type & ESCO_2EV5))
> > +                     phys |= BT_PHY_EDR_2M_3SLOT;
> > +
> > +             if (!(conn->pkt_type & ESCO_3EV3))
> > +                     phys |= BT_PHY_EDR_3M_1SLOT;
> > +
> > +             if (!(conn->pkt_type & ESCO_3EV5))
> > +                     phys |= BT_PHY_EDR_3M_3SLOT;
> > +
> > +             break;
> > +
> > +     case LE_LINK:
> > +             if (conn->le_tx_phy & HCI_LE_SET_PHY_1M)
> > +                     phys |= BT_PHY_LE_1M_TX;
> > +
> > +             if (conn->le_rx_phy & HCI_LE_SET_PHY_1M)
> > +                     phys |= BT_PHY_LE_1M_RX;
> > +
> > +             if (conn->le_tx_phy & HCI_LE_SET_PHY_2M)
> > +                     phys |= BT_PHY_LE_2M_TX;
> > +
> > +             if (conn->le_rx_phy & HCI_LE_SET_PHY_2M)
> > +                     phys |= BT_PHY_LE_2M_RX;
> > +
> > +             if (conn->le_tx_phy & HCI_LE_SET_PHY_CODED)
> > +                     phys |= BT_PHY_LE_CODED_TX;
> > +
> > +             if (conn->le_rx_phy & HCI_LE_SET_PHY_CODED)
> > +                     phys |= BT_PHY_LE_CODED_RX;
> > +
> > +             break;
> > +     }
> > +
> > +     hci_dev_unlock(conn->hdev);
> > +
> > +     return phys;
> > +}
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index 390a9afab647..3df4a7cf85a3 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -499,6 +499,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
> >       struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> >       struct bt_security sec;
> >       struct bt_power pwr;
> > +     u32 phys;
> >       int len, err = 0;
> >
> >       BT_DBG("sk %p", sk);
> > @@ -603,6 +604,18 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
> >                       err = -EFAULT;
> >               break;
> >
> > +     case BT_PHY:
> > +             if (sk->sk_state == BT_CONNECTED) {
> > +                     err = -EINVAL;
> > +                     break;
> > +             }
> > +
> > +             phys = hci_conn_get_phy(chan->conn->hcon);
> > +
> > +             if (put_user(phys, (u32 __user *) optval))
> > +                     err = -EFAULT;
> > +             break;
> > +
> >       default:
> >               err = -ENOPROTOOPT;
> >               break;
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index b91d6b440fdf..95fdfa4b9b62 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -922,6 +922,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
> >       struct sock *sk = sock->sk;
> >       int len, err = 0;
> >       struct bt_voice voice;
> > +     u32 phys;
> >
> >       BT_DBG("sk %p", sk);
> >
> > @@ -956,6 +957,18 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
> >
> >               break;
> >
> > +     case BT_PHY:
> > +             if (sk->sk_state == BT_CONNECTED) {
> > +                     err = -EINVAL;
> > +                     break;
> > +             }
> > +
> > +             phys = hci_conn_get_phy(sco_pi(sk)->conn->hcon);
> > +
> > +             if (put_user(phys, (u32 __user *) optval))
> > +                     err = -EFAULT;
> > +             break;
> > +
> >       default:
> >               err = -ENOPROTOOPT;
> >               break;
>
> Regards
>
> Marcel
>


-- 
Luiz Augusto von Dentz
