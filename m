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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB047C352A5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Feb 2020 21:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3F82070A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Feb 2020 21:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghgX0cNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgBJV1J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:27:09 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46378 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbgBJV1I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Feb 2020 16:27:08 -0500
Received: by mail-oi1-f194.google.com with SMTP id a22so10642927oid.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Feb 2020 13:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DwZlpLxkiOd+oz6TJKNmw+YhCgLGbwz/FAmP8MftcdA=;
        b=ghgX0cNi2xX8mz33xjmyEvinKNy1vTNjg72KSH8r4cs0Spmp8Qh/blT0IYljYrxuQg
         zHELccWvBaY1gjTGqXOw1N/5+buM8Mw0WWcwm8417PLLSP/P117wMoAksgXDbq1XR0qJ
         KwLLnLuRcNkFvATDzA5Bp5r0+w0s+VV3EjwFSAadYpOmkLe40gVIemk6TYfzBPAz1gNJ
         QcFq/DUxHnrGykvmuxP0w4YpTtu7sopKj3f7QDssZDW9y38nAV7scH93kptEzXh396Gk
         tEKxvLDB0eoupJ/2l13MJn1GiTXkL1+2tyqes+U0RkImUH3WOQk+R8uUeTfJ5KoQ1KII
         oG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwZlpLxkiOd+oz6TJKNmw+YhCgLGbwz/FAmP8MftcdA=;
        b=D7LjQPuofYOtzmL2BGL0yTbNp9WwcYwEULkMrkcj4eOsNFJDAJiX0R5WhxUmDYXtNA
         uSD6hf2VWZicM9a7RWYL0wdcZBm23FYv/Wta7Y4F4ybCnDIBbRmqpPmiEYeP/GoqL+D7
         HDWlulx5xlCTgUCU2vpJBoUl9kLaPkt/POz67C0P1Caf2q2QUV2hf4bnV5++1MX07Lv0
         Aw8vNzxqXxK4wL+Krz/lhYWk4zdpdmQJcfQBuMBbs7UWgO91g45JrTuUswfSv/+fFrRU
         b1RH8sBSnf5RGMeTqlT8uJX78LtDvJe7B7wsj8BAsS+KXlbx9X3aAivpXOOoeIQ9ABqS
         b23g==
X-Gm-Message-State: APjAAAVmiWmeS1Fr+65xwSnFyIfCR7fIuovMrcByqasF2LYEr6y8/6gh
        eyLG9NO2gy/7+Y7exf5NS9cuk1xNxV98NfcR345vQsvi
X-Google-Smtp-Source: APXvYqyEllXIBYA6MDKNICWTato3sug2hFYI4Qx3GkXspPxiI2YqopW9adPIQQTB91O1MvZsXRjfTUpZ/YAbfdTZxJ8=
X-Received: by 2002:aca:ab51:: with SMTP id u78mr766876oie.21.1581370027311;
 Mon, 10 Feb 2020 13:27:07 -0800 (PST)
MIME-Version: 1.0
References: <20200207190055.15249-1-luiz.dentz@gmail.com> <13F78412-516A-4383-AD3F-F15296AA747B@holtmann.org>
 <CABBYNZJZZVzWe3CueUfNYUn8LJVTZinD7oSszPTbNBpTha4L3g@mail.gmail.com>
In-Reply-To: <CABBYNZJZZVzWe3CueUfNYUn8LJVTZinD7oSszPTbNBpTha4L3g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 10 Feb 2020 13:26:54 -0800
Message-ID: <CABBYNZ+MqBhjwCaU7UmezrT8nZ9h5WUZ4Fmrq+cXE_mQSy1E4g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Add BT_PHY socket option
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Feb 10, 2020 at 1:13 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Marcel,
>
> On Sat, Feb 8, 2020 at 12:32 AM Marcel Holtmann <marcel@holtmann.org> wrote:
> >
> > Hi Luiz,
> >
> > > This adds BT_PHY socket option (read-only) which can be used to read
> > > the PHYs in use by the underline connection.
> > >
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > > include/net/bluetooth/bluetooth.h | 17 ++++++
> > > include/net/bluetooth/hci_core.h  |  2 +
> > > net/bluetooth/hci_conn.c          | 88 +++++++++++++++++++++++++++++++
> > > net/bluetooth/l2cap_sock.c        | 13 +++++
> > > net/bluetooth/sco.c               | 13 +++++
> > > 5 files changed, 133 insertions(+)
> > >
> > > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > > index e42bb8e03c09..1576353a2773 100644
> > > --- a/include/net/bluetooth/bluetooth.h
> > > +++ b/include/net/bluetooth/bluetooth.h
> > > @@ -121,6 +121,23 @@ struct bt_voice {
> > >
> > > #define BT_SNDMTU             12
> > > #define BT_RCVMTU             13
> > > +#define BT_PHY                       14
> > > +
> > > +#define BT_PHY_BR_1M_1SLOT   0x00000001
> > > +#define BT_PHY_BR_1M_3SLOT   0x00000002
> > > +#define BT_PHY_BR_1M_5SLOT   0x00000004
> > > +#define BT_PHY_EDR_2M_1SLOT  0x00000008
> > > +#define BT_PHY_EDR_2M_3SLOT  0x00000010
> > > +#define BT_PHY_EDR_2M_5SLOT  0x00000020
> > > +#define BT_PHY_EDR_3M_1SLOT  0x00000040
> > > +#define BT_PHY_EDR_3M_3SLOT  0x00000080
> > > +#define BT_PHY_EDR_3M_5SLOT  0x00000100
> > > +#define BT_PHY_LE_1M_TX              0x00000200
> > > +#define BT_PHY_LE_1M_RX              0x00000400
> > > +#define BT_PHY_LE_2M_TX              0x00000800
> > > +#define BT_PHY_LE_2M_RX              0x00001000
> > > +#define BT_PHY_LE_CODED_TX   0x00002000
> > > +#define BT_PHY_LE_CODED_RX   0x00004000
> > >
> > > __printf(1, 2)
> > > void bt_info(const char *fmt, ...);
> > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > > index 89ecf0a80aa1..dcc0dc6e2624 100644
> > > --- a/include/net/bluetooth/hci_core.h
> > > +++ b/include/net/bluetooth/hci_core.h
> > > @@ -1477,6 +1477,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
> > > struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
> > >                            const void *param, u32 timeout);
> > >
> > > +u32 hci_conn_get_phy(struct hci_conn *conn);
> > > +
> > > /* ----- HCI Sockets ----- */
> > > void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
> > > void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
> > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > index 87691404d0c6..9ff2611b272f 100644
> > > --- a/net/bluetooth/hci_conn.c
> > > +++ b/net/bluetooth/hci_conn.c
> > > @@ -1725,3 +1725,91 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
> > >
> > >       return hchan;
> > > }
> > > +
> > > +u32 hci_conn_get_phy(struct hci_conn *conn)
> > > +{
> > > +     u32 phys = 0;
> > > +
> > > +     hci_dev_lock(conn->hdev);
> > > +
> > > +     switch (conn->type) {
> > > +     case SCO_LINK:
> > > +             phys |= BT_PHY_BR_1M_1SLOT;
> > > +
> > > +             break;
> >
> > something is missing here. The SCO links can also be 3 and 5 slots.
>
> I couldn't find any information regarding the slot for HV1, HV2, HV3
> and DV so I assume they were all using 1 slot.

It is actually 1 slot, see:

BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 2, Part B
page 471
Table 6.2: Packets defined for synchronous, asynchronous, and CSB
logical transport types

>
> > > +
> > > +     case ACL_LINK:
> > > +             phys |= BT_PHY_BR_1M_1SLOT;
> > > +
> > > +             if (conn->pkt_type & (HCI_DM3 | HCI_DH3))
> > > +                     phys |= BT_PHY_BR_1M_3SLOT;
> > > +
> > > +             if (conn->pkt_type & (HCI_DM5 | HCI_DH5))
> > > +                     phys |= BT_PHY_BR_1M_5SLOT;
> > > +
> > > +             if (!(conn->pkt_type & HCI_2DH1))
> > > +                     phys |= BT_PHY_EDR_2M_1SLOT;
> > > +
> > > +             if (!(conn->pkt_type & HCI_2DH3))
> > > +                     phys |= BT_PHY_EDR_2M_3SLOT;
> > > +
> > > +             if (!(conn->pkt_type & HCI_2DH5))
> > > +                     phys |= BT_PHY_EDR_2M_5SLOT;
> > > +
> > > +             if (!(conn->pkt_type & HCI_3DH1))
> > > +                     phys |= BT_PHY_EDR_3M_1SLOT;
> > > +
> > > +             if (!(conn->pkt_type & HCI_3DH3))
> > > +                     phys |= BT_PHY_EDR_3M_3SLOT;
> > > +
> > > +             if (!(conn->pkt_type & HCI_3DH5))
> > > +                     phys |= BT_PHY_EDR_3M_5SLOT;
> > > +
> > > +             break;
> > > +
> > > +     case ESCO_LINK:
> > > +             phys |= BT_PHY_BR_1M_1SLOT;
> > > +
> > > +             if (!(conn->pkt_type & (ESCO_EV4 | ESCO_EV5)))
> > > +                     phys |= BT_PHY_BR_1M_3SLOT;
> > > +
> > > +             if (!(conn->pkt_type & ESCO_2EV3))
> > > +                     phys |= BT_PHY_EDR_2M_1SLOT;
> > > +
> > > +             if (!(conn->pkt_type & ESCO_2EV5))
> > > +                     phys |= BT_PHY_EDR_2M_3SLOT;
> > > +
> > > +             if (!(conn->pkt_type & ESCO_3EV3))
> > > +                     phys |= BT_PHY_EDR_3M_1SLOT;
> > > +
> > > +             if (!(conn->pkt_type & ESCO_3EV5))
> > > +                     phys |= BT_PHY_EDR_3M_3SLOT;
> > > +
> > > +             break;
> > > +
> > > +     case LE_LINK:
> > > +             if (conn->le_tx_phy & HCI_LE_SET_PHY_1M)
> > > +                     phys |= BT_PHY_LE_1M_TX;
> > > +
> > > +             if (conn->le_rx_phy & HCI_LE_SET_PHY_1M)
> > > +                     phys |= BT_PHY_LE_1M_RX;
> > > +
> > > +             if (conn->le_tx_phy & HCI_LE_SET_PHY_2M)
> > > +                     phys |= BT_PHY_LE_2M_TX;
> > > +
> > > +             if (conn->le_rx_phy & HCI_LE_SET_PHY_2M)
> > > +                     phys |= BT_PHY_LE_2M_RX;
> > > +
> > > +             if (conn->le_tx_phy & HCI_LE_SET_PHY_CODED)
> > > +                     phys |= BT_PHY_LE_CODED_TX;
> > > +
> > > +             if (conn->le_rx_phy & HCI_LE_SET_PHY_CODED)
> > > +                     phys |= BT_PHY_LE_CODED_RX;
> > > +
> > > +             break;
> > > +     }
> > > +
> > > +     hci_dev_unlock(conn->hdev);
> > > +
> > > +     return phys;
> > > +}
> > > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > > index 390a9afab647..3df4a7cf85a3 100644
> > > --- a/net/bluetooth/l2cap_sock.c
> > > +++ b/net/bluetooth/l2cap_sock.c
> > > @@ -499,6 +499,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
> > >       struct l2cap_chan *chan = l2cap_pi(sk)->chan;
> > >       struct bt_security sec;
> > >       struct bt_power pwr;
> > > +     u32 phys;
> > >       int len, err = 0;
> > >
> > >       BT_DBG("sk %p", sk);
> > > @@ -603,6 +604,18 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
> > >                       err = -EFAULT;
> > >               break;
> > >
> > > +     case BT_PHY:
> > > +             if (sk->sk_state == BT_CONNECTED) {
> > > +                     err = -EINVAL;
> > > +                     break;
> > > +             }
> > > +
> > > +             phys = hci_conn_get_phy(chan->conn->hcon);
> > > +
> > > +             if (put_user(phys, (u32 __user *) optval))
> > > +                     err = -EFAULT;
> > > +             break;
> > > +
> > >       default:
> > >               err = -ENOPROTOOPT;
> > >               break;
> > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > index b91d6b440fdf..95fdfa4b9b62 100644
> > > --- a/net/bluetooth/sco.c
> > > +++ b/net/bluetooth/sco.c
> > > @@ -922,6 +922,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
> > >       struct sock *sk = sock->sk;
> > >       int len, err = 0;
> > >       struct bt_voice voice;
> > > +     u32 phys;
> > >
> > >       BT_DBG("sk %p", sk);
> > >
> > > @@ -956,6 +957,18 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
> > >
> > >               break;
> > >
> > > +     case BT_PHY:
> > > +             if (sk->sk_state == BT_CONNECTED) {
> > > +                     err = -EINVAL;
> > > +                     break;
> > > +             }
> > > +
> > > +             phys = hci_conn_get_phy(sco_pi(sk)->conn->hcon);
> > > +
> > > +             if (put_user(phys, (u32 __user *) optval))
> > > +                     err = -EFAULT;
> > > +             break;
> > > +
> > >       default:
> > >               err = -ENOPROTOOPT;
> > >               break;
> >
> > Regards
> >
> > Marcel
> >
>
>
> --
> Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
