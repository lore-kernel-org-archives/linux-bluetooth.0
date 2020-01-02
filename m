Return-Path: <SRS0=Qv9v=2X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F49C2D0C2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 17:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC2BA21582
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 17:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dv4eDW3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgABR7a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:59:30 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45486 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727755AbgABR7a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jan 2020 12:59:30 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so58019897otp.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2020 09:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZWyy8HbMfg3rrzbup8n1LY4TMLq8EO7riOX5eoG3n58=;
        b=dv4eDW3EUh2RrGBgFS7UmIdvF6/Qa1q1jwGxRxgLsi6Rqo7lL2bDk38nCaxUzjsx0z
         /Q3bkORD76QXe2BQ17/5NkMHhz5Sewlj1VuZDhlUfxRGlaahmu1nHSIHbkG85GPOcf52
         8/e0j9VvfN3lI8rxtu/77NWJc9r3D7pEcB8X7mMtEDIEg6jfw9iElC2ymcum6c8czcz1
         PHAqQkEG9YprB0olQ2+m9KVafnqBL3gaKeLB9qoEf2d7MGINWo2XpXkQSaE8joKWlFjA
         9uPm4/ABG2KLbbhW2z26H+8tECwMj3mCS+2tVuZNHp78UYnGpbguqxafm4/TTY9cPeoM
         DI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZWyy8HbMfg3rrzbup8n1LY4TMLq8EO7riOX5eoG3n58=;
        b=Hj0GBQD/XIcVVxJM6cjKADz1qoQyAP8sFAedtGWiWWNc8c2M7HY8UNw5EgF1YxSrcJ
         VRxbjYluUNH8Pj05z4aj2EJhddh6wmcb5EPM5fOhu0L/JGIVtp+OBp3jvhHjBNaxLF1E
         JwYiKFs5yHxL4x14YzGeGXzzza2ZReXc4S37gvVhGif19HdvyZj/UhCg20Op9js51jJw
         184jUszd0XWIu0jeBl9scuPU7PVOttVExJLYJfWziQXYlzlW1aMjd8QX6CGuLSUPpYsh
         uBlua7NQliY2uZ0ZUoedS2gsA8no9tx2/v7I5aCl6ad0slCwMYXl3RXah7S3E6MDtijy
         dPSw==
X-Gm-Message-State: APjAAAU86jGnoh+xafmsXAp371dfsAN7/sUIA5ZTCxQpVOl9JIVHdBgO
        Vc8MiRhoxXR87QXVMjTuHVaOrnTRy3GqPIs9tswOoD8Y
X-Google-Smtp-Source: APXvYqwCKFGiLro68yKMoljfn1byn1layZB8ubLKs+kCHjz7GmI0TVLVS4VFDDiIIRes30Rzff7Mzora646Xcao81oI=
X-Received: by 2002:a9d:6d10:: with SMTP id o16mr95514231otp.28.1577987968580;
 Thu, 02 Jan 2020 09:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20200102172447.18574-1-luiz.dentz@gmail.com> <20200102172447.18574-2-luiz.dentz@gmail.com>
 <CABBYNZJXvmF8j8Fd=zkr0a83RQ52OeEcbTJk-bgk3R9Ofzq8AA@mail.gmail.com> <20200102175000.wefojdsgqo7q35pt@pali>
In-Reply-To: <20200102175000.wefojdsgqo7q35pt@pali>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Jan 2020 09:59:16 -0800
Message-ID: <CABBYNZKoOk8u8i24bo1JW0UXD+e=F2DxjQ4FBv-FM=XYNpMwxg@mail.gmail.com>
Subject: Re: [RFC 2/2] Bluetooth: Add BT_PHYS socket option
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali.

On Thu, Jan 2, 2020 at 9:50 AM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote=
:
>
> On Thursday 02 January 2020 09:36:06 Luiz Augusto von Dentz wrote:
> > Hi Pali,
> >
> > On Thu, Jan 2, 2020 at 9:24 AM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > >
> > > This adds BT_PHYS socket option which can be used to read the PHYs in
> > > use by the underline connection.
> > >
> > > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > ---
> > >  include/net/bluetooth/bluetooth.h | 17 ++++++++
> > >  include/net/bluetooth/hci_core.h  |  2 +
> > >  net/bluetooth/hci_conn.c          | 64 +++++++++++++++++++++++++++++=
++
> > >  net/bluetooth/l2cap_sock.c        | 13 +++++++
> > >  net/bluetooth/sco.c               | 13 +++++++
> > >  5 files changed, 109 insertions(+)
> > >
> > > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetoot=
h/bluetooth.h
> > > index e42bb8e03c09..69c0e7eb26d9 100644
> > > --- a/include/net/bluetooth/bluetooth.h
> > > +++ b/include/net/bluetooth/bluetooth.h
> > > @@ -121,6 +121,23 @@ struct bt_voice {
> > >
> > >  #define BT_SNDMTU              12
> > >  #define BT_RCVMTU              13
> > > +#define BT_PHYS                        14
> > > +
> > > +#define BT_PHY_BR_1M_1SLOT     0x00000001
> > > +#define BT_PHY_BR_1M_3SLOT     0x00000002
> > > +#define BT_PHY_BR_1M_5SLOT     0x00000004
> > > +#define BT_PHY_EDR_2M_1SLOT    0x00000008
> > > +#define BT_PHY_EDR_2M_3SLOT    0x00000010
> > > +#define BT_PHY_EDR_2M_5SLOT    0x00000020
> > > +#define BT_PHY_EDR_3M_1SLOT    0x00000040
> > > +#define BT_PHY_EDR_3M_3SLOT    0x00000080
> > > +#define BT_PHY_EDR_3M_5SLOT    0x00000100
> > > +#define BT_PHY_LE_1M_TX                0x00000200
> > > +#define BT_PHY_LE_1M_RX                0x00000400
> > > +#define BT_PHY_LE_2M_TX                0x00000800
> > > +#define BT_PHY_LE_2M_RX                0x00001000
> > > +#define BT_PHY_LE_CODED_TX     0x00002000
> > > +#define BT_PHY_LE_CODED_RX     0x00004000
> >
> > This might be of your interest since you wanted to know what packet
> > size to use, we might use this to adjust the MTU automatically instead
> > of always using 672 so we maximize the throughput if the socket owner
> > has not set a MTU on its own.
>
> Great! Thank you for information.
>
> Would getsockopt(sock, SOL_L2CAP, L2CAP_OPTIONS, ...) call returns also
> adjusted MTU value?

Afaik BT_SNDMTU/BT_RCVMTU are the options that shall be used to adjust
the MTU, what Im suggesting is to do it automatically if the socket
owner has not set anything, perhaps you are asking if that would be
possible to read the default MTU, yes that would work exactly as it is
right now so we don't have to change anything in userspace, though the
is another detail to consider that is if the MTU actually fits into
the HCI buffer otherwise we would have to fragment the packets in
multiple HCI fragments which kind defeat the purpose of having such
big MTU, for LE is actually simpler since we have the actual MTU used
in the connection.

> > >  __printf(1, 2)
> > >  void bt_info(const char *fmt, ...);
> > > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth=
/hci_core.h
> > > index faebe3859931..03cf3f0f22b9 100644
> > > --- a/include/net/bluetooth/hci_core.h
> > > +++ b/include/net/bluetooth/hci_core.h
> > > @@ -1467,6 +1467,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, _=
_u16 opcode);
> > >  struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 p=
len,
> > >                              const void *param, u32 timeout);
> > >
> > > +u32 hci_conn_get_phys(struct hci_conn *conn);
> > > +
> > >  /* ----- HCI Sockets ----- */
> > >  void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
> > >  void hci_send_to_channel(unsigned short channel, struct sk_buff *skb=
,
> > > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > > index 87691404d0c6..386e6b0bd2ab 100644
> > > --- a/net/bluetooth/hci_conn.c
> > > +++ b/net/bluetooth/hci_conn.c
> > > @@ -1725,3 +1725,67 @@ struct hci_chan *hci_chan_lookup_handle(struct=
 hci_dev *hdev, __u16 handle)
> > >
> > >         return hchan;
> > >  }
> > > +
> > > +u32 hci_conn_get_phys(struct hci_conn *conn)
> > > +{
> > > +       u32 phys =3D 0;
> > > +
> > > +       hci_dev_lock(conn->hdev);
> > > +
> > > +       switch (conn->type) {
> > > +       case ACL_LINK:
> > > +       case SCO_LINK:
> > > +               phys |=3D BT_PHY_BR_1M_1SLOT;
> > > +
> > > +               if (conn->pkt_type & (HCI_DM3 | HCI_DH3))
> > > +                       phys |=3D BT_PHY_BR_1M_3SLOT;
> > > +
> > > +               if (conn->pkt_type & (HCI_DM5 | HCI_DH5))
> > > +                       phys |=3D BT_PHY_BR_1M_5SLOT;
> > > +
> > > +               if (!(conn->pkt_type & HCI_2DH1))
> > > +                       phys |=3D BT_PHY_EDR_2M_1SLOT;
> > > +
> > > +               if (!(conn->pkt_type & HCI_2DH3))
> > > +                       phys |=3D BT_PHY_EDR_2M_3SLOT;
> > > +
> > > +               if (!(conn->pkt_type & HCI_2DH5))
> > > +                       phys |=3D BT_PHY_EDR_2M_5SLOT;
> > > +
> > > +               if (!(conn->pkt_type & HCI_3DH1))
> > > +                       phys |=3D BT_PHY_EDR_3M_1SLOT;
> > > +
> > > +               if (!(conn->pkt_type & HCI_3DH3))
> > > +                       phys |=3D BT_PHY_EDR_3M_3SLOT;
> > > +
> > > +               if (!(conn->pkt_type & HCI_3DH5))
> > > +                       phys |=3D BT_PHY_EDR_3M_5SLOT;
> > > +
> > > +               break;
> > > +
> > > +       case LE_LINK:
> > > +               if (conn->le_tx_phy & HCI_LE_SET_PHY_1M)
> > > +                       phys |=3D BT_PHY_LE_1M_TX;
> > > +
> > > +               if (conn->le_rx_phy & HCI_LE_SET_PHY_1M)
> > > +                       phys |=3D BT_PHY_LE_1M_RX;
> > > +
> > > +               if (conn->le_tx_phy & HCI_LE_SET_PHY_2M)
> > > +                       phys |=3D BT_PHY_LE_2M_TX;
> > > +
> > > +               if (conn->le_rx_phy & HCI_LE_SET_PHY_2M)
> > > +                       phys |=3D BT_PHY_LE_2M_RX;
> > > +
> > > +               if (conn->le_tx_phy & HCI_LE_SET_PHY_CODED)
> > > +                       phys |=3D BT_PHY_LE_CODED_TX;
> > > +
> > > +               if (conn->le_rx_phy & HCI_LE_SET_PHY_CODED)
> > > +                       phys |=3D BT_PHY_LE_CODED_RX;
> > > +
> > > +               break;
> > > +       }
> > > +
> > > +       hci_dev_unlock(conn->hdev);
> > > +
> > > +       return phys;
> > > +}
> > > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > > index a7be8b59b3c2..fb011c6c67be 100644
> > > --- a/net/bluetooth/l2cap_sock.c
> > > +++ b/net/bluetooth/l2cap_sock.c
> > > @@ -499,6 +499,7 @@ static int l2cap_sock_getsockopt(struct socket *s=
ock, int level, int optname,
> > >         struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
> > >         struct bt_security sec;
> > >         struct bt_power pwr;
> > > +       u32 phys;
> > >         int len, err =3D 0;
> > >
> > >         BT_DBG("sk %p", sk);
> > > @@ -603,6 +604,18 @@ static int l2cap_sock_getsockopt(struct socket *=
sock, int level, int optname,
> > >                         err =3D -EFAULT;
> > >                 break;
> > >
> > > +       case BT_PHYS:
> > > +               if (sk->sk_state =3D=3D BT_CONNECTED) {
> > > +                       err =3D -EINVAL;
> > > +                       break;
> > > +               }
> > > +
> > > +               phys =3D hci_conn_get_phys(chan->conn->hcon);
> > > +
> > > +               if (put_user(phys, (u32 __user *) optval))
> > > +                       err =3D -EFAULT;
> > > +               break;
> > > +
> > >         default:
> > >                 err =3D -ENOPROTOOPT;
> > >                 break;
> > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > index b91d6b440fdf..dcd297f2acc6 100644
> > > --- a/net/bluetooth/sco.c
> > > +++ b/net/bluetooth/sco.c
> > > @@ -922,6 +922,7 @@ static int sco_sock_getsockopt(struct socket *soc=
k, int level, int optname,
> > >         struct sock *sk =3D sock->sk;
> > >         int len, err =3D 0;
> > >         struct bt_voice voice;
> > > +       u32 phys;
> > >
> > >         BT_DBG("sk %p", sk);
> > >
> > > @@ -956,6 +957,18 @@ static int sco_sock_getsockopt(struct socket *so=
ck, int level, int optname,
> > >
> > >                 break;
> > >
> > > +       case BT_PHYS:
> > > +               if (sk->sk_state =3D=3D BT_CONNECTED) {
> > > +                       err =3D -EINVAL;
> > > +                       break;
> > > +               }
> > > +
> > > +               phys =3D hci_conn_get_phys(sco_pi(sk)->conn->hcon);
> > > +
> > > +               if (put_user(phys, (u32 __user *) optval))
> > > +                       err =3D -EFAULT;
> > > +               break;
> > > +
> > >         default:
> > >                 err =3D -ENOPROTOOPT;
> > >                 break;
> > > --
> > > 2.21.0
> > >
> >
> >
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com



--=20
Luiz Augusto von Dentz
