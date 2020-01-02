Return-Path: <SRS0=Qv9v=2X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65CAC3276C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 17:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7651B21582
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 17:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6/m42/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgABRuF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:50:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50869 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgABRuE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jan 2020 12:50:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so6272895wmb.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2020 09:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uVIdv9098vIY8E9G1WG6poh6dvcf0BpIk5+xL4wtYos=;
        b=s6/m42/0HsgE2n2ajIzStbGJfGv8uL2l8X55OXEcM9UGjYcc3IHRLremsKlbKLTlVS
         FruHDwtnDYiAylJAvENYovxYbIKu5O3BFZUJnTSrBdhh2+3lAdOGVYcSD7GsX9ch/80n
         n27L7xrrOz5TuR0o+sXPLQ9y+cACIflmZqTN9LW7Zpw50wv3MRRXO3pNRHPC5RlxUsg3
         PXEFP0UI3NwM+KMJ/0g6QdIjSL2b0lqBFGmHyDHNHws+WERkmYwDhD60qlcXRSakg4KV
         gUfuhoMLgVmDHi0N/GDMal1QOuZUNbpW/kXozVUSMYdORWmjyQNmRB2lpt17tzlXl8pQ
         mP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uVIdv9098vIY8E9G1WG6poh6dvcf0BpIk5+xL4wtYos=;
        b=WI4018jEK5ycVRf0I3bmuJ8xDUhtiOefYk6/M/z134lqhiNhHmwfvlpT19kT24kPeH
         4tbr3fgNhTnNeCFCnlZnE/9KUsfySTv63CRSGtgi3M3zVUSLFLpgKZr40N3z+RaXbyqr
         5Oz0+OD7bdVxuqZaXT9uogQIIvUC1dTDpkVWDnnjFOFHWmFfhfJd3Il/NP8nPkE3ZJ3O
         Wrqop0FF7MJUF01aDvt/lPZKdzKLWRVsy8/uyYmw7e8gxXnFdyF7i9K8dnHWYpOqY4pM
         MOArjSd4Hs+mMGjZWxDc6yztYxhgV1h+xytxNHfg3Jptc0D4FNjypjVHp83iG0eEmxa8
         +cpQ==
X-Gm-Message-State: APjAAAV2Xb90f1JrsO5BURf6Q6lBD/04DJLunTfEznUUJh5qpBbVAxUt
        e8AML5bMlx8cO9frciKfwV8=
X-Google-Smtp-Source: APXvYqz6I+nKnVNIeq5iVBJK3R+ZVtJiAwiq8mm0oDZrKiWUZmT2lWbpkZGSjRL/7IGmoJBwhVILHA==
X-Received: by 2002:a1c:145:: with SMTP id 66mr15791688wmb.11.1577987402047;
        Thu, 02 Jan 2020 09:50:02 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id e6sm55820305wru.44.2020.01.02.09.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 09:50:01 -0800 (PST)
Date:   Thu, 2 Jan 2020 18:50:00 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC 2/2] Bluetooth: Add BT_PHYS socket option
Message-ID: <20200102175000.wefojdsgqo7q35pt@pali>
References: <20200102172447.18574-1-luiz.dentz@gmail.com>
 <20200102172447.18574-2-luiz.dentz@gmail.com>
 <CABBYNZJXvmF8j8Fd=zkr0a83RQ52OeEcbTJk-bgk3R9Ofzq8AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="wchqarb65o7id6ap"
Content-Disposition: inline
In-Reply-To: <CABBYNZJXvmF8j8Fd=zkr0a83RQ52OeEcbTJk-bgk3R9Ofzq8AA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--wchqarb65o7id6ap
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 02 January 2020 09:36:06 Luiz Augusto von Dentz wrote:
> Hi Pali,
>=20
> On Thu, Jan 2, 2020 at 9:24 AM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This adds BT_PHYS socket option which can be used to read the PHYs in
> > use by the underline connection.
> >
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  include/net/bluetooth/bluetooth.h | 17 ++++++++
> >  include/net/bluetooth/hci_core.h  |  2 +
> >  net/bluetooth/hci_conn.c          | 64 +++++++++++++++++++++++++++++++
> >  net/bluetooth/l2cap_sock.c        | 13 +++++++
> >  net/bluetooth/sco.c               | 13 +++++++
> >  5 files changed, 109 insertions(+)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/=
bluetooth.h
> > index e42bb8e03c09..69c0e7eb26d9 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -121,6 +121,23 @@ struct bt_voice {
> >
> >  #define BT_SNDMTU              12
> >  #define BT_RCVMTU              13
> > +#define BT_PHYS                        14
> > +
> > +#define BT_PHY_BR_1M_1SLOT     0x00000001
> > +#define BT_PHY_BR_1M_3SLOT     0x00000002
> > +#define BT_PHY_BR_1M_5SLOT     0x00000004
> > +#define BT_PHY_EDR_2M_1SLOT    0x00000008
> > +#define BT_PHY_EDR_2M_3SLOT    0x00000010
> > +#define BT_PHY_EDR_2M_5SLOT    0x00000020
> > +#define BT_PHY_EDR_3M_1SLOT    0x00000040
> > +#define BT_PHY_EDR_3M_3SLOT    0x00000080
> > +#define BT_PHY_EDR_3M_5SLOT    0x00000100
> > +#define BT_PHY_LE_1M_TX                0x00000200
> > +#define BT_PHY_LE_1M_RX                0x00000400
> > +#define BT_PHY_LE_2M_TX                0x00000800
> > +#define BT_PHY_LE_2M_RX                0x00001000
> > +#define BT_PHY_LE_CODED_TX     0x00002000
> > +#define BT_PHY_LE_CODED_RX     0x00004000
>=20
> This might be of your interest since you wanted to know what packet
> size to use, we might use this to adjust the MTU automatically instead
> of always using 672 so we maximize the throughput if the socket owner
> has not set a MTU on its own.

Great! Thank you for information.

Would getsockopt(sock, SOL_L2CAP, L2CAP_OPTIONS, ...) call returns also
adjusted MTU value?

> >  __printf(1, 2)
> >  void bt_info(const char *fmt, ...);
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/h=
ci_core.h
> > index faebe3859931..03cf3f0f22b9 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1467,6 +1467,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u=
16 opcode);
> >  struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 ple=
n,
> >                              const void *param, u32 timeout);
> >
> > +u32 hci_conn_get_phys(struct hci_conn *conn);
> > +
> >  /* ----- HCI Sockets ----- */
> >  void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
> >  void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index 87691404d0c6..386e6b0bd2ab 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -1725,3 +1725,67 @@ struct hci_chan *hci_chan_lookup_handle(struct h=
ci_dev *hdev, __u16 handle)
> >
> >         return hchan;
> >  }
> > +
> > +u32 hci_conn_get_phys(struct hci_conn *conn)
> > +{
> > +       u32 phys =3D 0;
> > +
> > +       hci_dev_lock(conn->hdev);
> > +
> > +       switch (conn->type) {
> > +       case ACL_LINK:
> > +       case SCO_LINK:
> > +               phys |=3D BT_PHY_BR_1M_1SLOT;
> > +
> > +               if (conn->pkt_type & (HCI_DM3 | HCI_DH3))
> > +                       phys |=3D BT_PHY_BR_1M_3SLOT;
> > +
> > +               if (conn->pkt_type & (HCI_DM5 | HCI_DH5))
> > +                       phys |=3D BT_PHY_BR_1M_5SLOT;
> > +
> > +               if (!(conn->pkt_type & HCI_2DH1))
> > +                       phys |=3D BT_PHY_EDR_2M_1SLOT;
> > +
> > +               if (!(conn->pkt_type & HCI_2DH3))
> > +                       phys |=3D BT_PHY_EDR_2M_3SLOT;
> > +
> > +               if (!(conn->pkt_type & HCI_2DH5))
> > +                       phys |=3D BT_PHY_EDR_2M_5SLOT;
> > +
> > +               if (!(conn->pkt_type & HCI_3DH1))
> > +                       phys |=3D BT_PHY_EDR_3M_1SLOT;
> > +
> > +               if (!(conn->pkt_type & HCI_3DH3))
> > +                       phys |=3D BT_PHY_EDR_3M_3SLOT;
> > +
> > +               if (!(conn->pkt_type & HCI_3DH5))
> > +                       phys |=3D BT_PHY_EDR_3M_5SLOT;
> > +
> > +               break;
> > +
> > +       case LE_LINK:
> > +               if (conn->le_tx_phy & HCI_LE_SET_PHY_1M)
> > +                       phys |=3D BT_PHY_LE_1M_TX;
> > +
> > +               if (conn->le_rx_phy & HCI_LE_SET_PHY_1M)
> > +                       phys |=3D BT_PHY_LE_1M_RX;
> > +
> > +               if (conn->le_tx_phy & HCI_LE_SET_PHY_2M)
> > +                       phys |=3D BT_PHY_LE_2M_TX;
> > +
> > +               if (conn->le_rx_phy & HCI_LE_SET_PHY_2M)
> > +                       phys |=3D BT_PHY_LE_2M_RX;
> > +
> > +               if (conn->le_tx_phy & HCI_LE_SET_PHY_CODED)
> > +                       phys |=3D BT_PHY_LE_CODED_TX;
> > +
> > +               if (conn->le_rx_phy & HCI_LE_SET_PHY_CODED)
> > +                       phys |=3D BT_PHY_LE_CODED_RX;
> > +
> > +               break;
> > +       }
> > +
> > +       hci_dev_unlock(conn->hdev);
> > +
> > +       return phys;
> > +}
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index a7be8b59b3c2..fb011c6c67be 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -499,6 +499,7 @@ static int l2cap_sock_getsockopt(struct socket *soc=
k, int level, int optname,
> >         struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
> >         struct bt_security sec;
> >         struct bt_power pwr;
> > +       u32 phys;
> >         int len, err =3D 0;
> >
> >         BT_DBG("sk %p", sk);
> > @@ -603,6 +604,18 @@ static int l2cap_sock_getsockopt(struct socket *so=
ck, int level, int optname,
> >                         err =3D -EFAULT;
> >                 break;
> >
> > +       case BT_PHYS:
> > +               if (sk->sk_state =3D=3D BT_CONNECTED) {
> > +                       err =3D -EINVAL;
> > +                       break;
> > +               }
> > +
> > +               phys =3D hci_conn_get_phys(chan->conn->hcon);
> > +
> > +               if (put_user(phys, (u32 __user *) optval))
> > +                       err =3D -EFAULT;
> > +               break;
> > +
> >         default:
> >                 err =3D -ENOPROTOOPT;
> >                 break;
> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > index b91d6b440fdf..dcd297f2acc6 100644
> > --- a/net/bluetooth/sco.c
> > +++ b/net/bluetooth/sco.c
> > @@ -922,6 +922,7 @@ static int sco_sock_getsockopt(struct socket *sock,=
 int level, int optname,
> >         struct sock *sk =3D sock->sk;
> >         int len, err =3D 0;
> >         struct bt_voice voice;
> > +       u32 phys;
> >
> >         BT_DBG("sk %p", sk);
> >
> > @@ -956,6 +957,18 @@ static int sco_sock_getsockopt(struct socket *sock=
, int level, int optname,
> >
> >                 break;
> >
> > +       case BT_PHYS:
> > +               if (sk->sk_state =3D=3D BT_CONNECTED) {
> > +                       err =3D -EINVAL;
> > +                       break;
> > +               }
> > +
> > +               phys =3D hci_conn_get_phys(sco_pi(sk)->conn->hcon);
> > +
> > +               if (put_user(phys, (u32 __user *) optval))
> > +                       err =3D -EFAULT;
> > +               break;
> > +
> >         default:
> >                 err =3D -ENOPROTOOPT;
> >                 break;
> > --
> > 2.21.0
> >
>=20
>=20

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--wchqarb65o7id6ap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCXg4tQgAKCRCL8Mk9A+RD
UsFqAKC4a6v1d86jUi5S3BJRSLJCi6wKoQCguaU74sk4wOqWFNxwnm1qj0Uq2rs=
=ZprI
-----END PGP SIGNATURE-----

--wchqarb65o7id6ap--
