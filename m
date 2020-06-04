Return-Path: <SRS0=9nD+=7R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A703C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 01:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57CB02064C
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jun 2020 01:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwYfPTnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgFDBFX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 21:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgFDBFW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 21:05:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5AAC03E96D
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 18:05:22 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z9so5107084ljh.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 18:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aEW8CSnqLt0ByqIztHacT6pj3gDme1nZRXZg7ECFEBU=;
        b=gwYfPTnFYqzXGgIlGuy2NmV8V5ImDiK3Gi1A0liwhcoYOvY2Q8pOrBg1BzDDLT+MSi
         T4FXqPdxgvvEpqQMnTOXXLKYJ/m4tu8CWlocMht2rw2CtD7vdZ6cBNKCu2qkY44FMDG6
         RLkVw1wwpx+s0PLGPbv6L7xargpQVhVjDxmlQEgizsZXqRoCOoJDkAFFwzKuoxIPbZtq
         pljfKGqWctKO67Nio7Y0KZilcdvfOX5VNJUCwxxOUtwSqGYCYtPvwxoq3nb7mvmlqt1G
         QV7D6Lnj3mt7O9GvagtzersQRY/cvjniugWhFHidp7SWi/AdX91wmqXBfvx3rsc+wAWs
         cuxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aEW8CSnqLt0ByqIztHacT6pj3gDme1nZRXZg7ECFEBU=;
        b=i2+9LYU7hwIk9s7FXa2x4D2YxfmzW+RITJXK9+azZ1wBCWbA2R6yyR/VFAMm915YIL
         psKZdetl+H4dcwE5KsetM1eh8h0v5fOCNJw9y6TSfZppnoEvsbCuY1pj1osfdrUwFLnH
         S8LEFUeEcHyrNABGTMHOYY8aT1ULiyIwPrhsxO34kp0qMyDBDCty9G4szRoYX6DKZ7XE
         1k7MXSLuEm4ZhJO98eVg4vTc2/c9tLlahxo1uLEE32VfXiV4Y58yRs3Fe4b1wC1T/1FR
         5HRYiejkpHDvPI4vA33NBGw5awQFxbS9lpV7eO3dt5+IJqkO0mR8zSvWUb8fh76rq0tK
         MtqQ==
X-Gm-Message-State: AOAM5307y0F7uEMffWoBY0kC5GwWomtyS30wIrHiPis2YPxc6J/QR74c
        cA8oRxiXxDRFliZ/cWlUrjaXGDjuNKlfvz9xpu6G+4uw/bA=
X-Google-Smtp-Source: ABdhPJyaKwNLU0jSBW8PoZ1l0HnJ9t2foPZbMepeXxvCubjiN2G1Ac8e9fyxzuYnTtaIK1hPRLgKtP4hV+QwRqpArJY=
X-Received: by 2002:a2e:b04c:: with SMTP id d12mr803676ljl.256.1591232720342;
 Wed, 03 Jun 2020 18:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200603145205.125167-1-alainm@chromium.org> <CABBYNZ+Os=u4=r+mSq+C9nRyN=PC6Yk7GNTGhto_2-TBmHxdRQ@mail.gmail.com>
 <CALWDO_V4Gy+3m1uznc3ZeGugpJqV94WOkvdZE1hs8izKU1q7=w@mail.gmail.com> <CABBYNZ+UmGfM5CqZKV71-e1bRtrLZ76a8B_1bh+DANf=2wTrdw@mail.gmail.com>
In-Reply-To: <CABBYNZ+UmGfM5CqZKV71-e1bRtrLZ76a8B_1bh+DANf=2wTrdw@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 3 Jun 2020 21:05:08 -0400
Message-ID: <CALWDO_X0BuQ+6UnPOnnpFmEXHSXRDEfAhTG=OjQaoJ14m0vhfQ@mail.gmail.com>
Subject: Re: [PATCH v3] sco:Add support for BT_PKT_STATUS CMSG data
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

HI Luiz,


On Wed, Jun 3, 2020 at 8:56 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Alain,
>
> On Wed, Jun 3, 2020 at 5:34 PM Alain Michaud <alainmichaud@google.com> wrote:
> >
> > Hi Luiz
> >
> > On Wed, Jun 3, 2020 at 5:15 PM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Alain, Marcel,
> > >
> > > On Wed, Jun 3, 2020 at 7:56 AM Alain Michaud <alainm@chromium.org> wrote:
> > > >
> > > > This change adds support for reporting the BT_PKT_STATUS to the socket
> > > > CMSG data to allow the implementation of a packet loss correction on
> > > > erronous data received on the SCO socket.
> > > >
> > > > The patch was partially developed by Marcel Holtmann and validated by
> > > > Hsin-yu Chao
> > > >
> > > > Signed-off-by: Alain Michaud <alainm@chromium.org>
> > > >
> > > > ---
> > > >
> > > >  include/net/bluetooth/bluetooth.h |  8 +++++++
> > > >  include/net/bluetooth/sco.h       |  3 +++
> > > >  net/bluetooth/af_bluetooth.c      |  3 +++
> > > >  net/bluetooth/hci_core.c          |  1 +
> > > >  net/bluetooth/sco.c               | 35 +++++++++++++++++++++++++++++++
> > > >  5 files changed, 50 insertions(+)
> > > >
> > > > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> > > > index 3fa7b1e3c5d9..85e6c5754448 100644
> > > > --- a/include/net/bluetooth/bluetooth.h
> > > > +++ b/include/net/bluetooth/bluetooth.h
> > > > @@ -147,6 +147,8 @@ struct bt_voice {
> > > >  #define BT_MODE_LE_FLOWCTL     0x03
> > > >  #define BT_MODE_EXT_FLOWCTL    0x04
> > > >
> > > > +#define BT_PKT_STATUS          16
> > > > +
> > > >  __printf(1, 2)
> > > >  void bt_info(const char *fmt, ...);
> > > >  __printf(1, 2)
> > > > @@ -275,6 +277,7 @@ struct bt_sock {
> > > >         struct sock *parent;
> > > >         unsigned long flags;
> > > >         void (*skb_msg_name)(struct sk_buff *, void *, int *);
> > > > +       void (*skb_put_cmsg)(struct sk_buff *, struct msghdr *, struct sock *);
> > > >  };
> > > >
> > > >  enum {
> > > > @@ -324,6 +327,10 @@ struct l2cap_ctrl {
> > > >         struct l2cap_chan *chan;
> > > >  };
> > > >
> > > > +struct sco_ctrl {
> > > > +       u8      pkt_status;
> > > > +};
> > > > +
> > > >  struct hci_dev;
> > > >
> > > >  typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
> > > > @@ -350,6 +357,7 @@ struct bt_skb_cb {
> > > >         u8 incoming:1;
> > > >         union {
> > > >                 struct l2cap_ctrl l2cap;
> > > > +               struct sco_ctrl sco;
> > > >                 struct hci_ctrl hci;
> > > >         };
> > > >  };
> > > > diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
> > > > index f40ddb4264fc..7f0d7bdc53f6 100644
> > > > --- a/include/net/bluetooth/sco.h
> > > > +++ b/include/net/bluetooth/sco.h
> > > > @@ -46,4 +46,7 @@ struct sco_conninfo {
> > > >         __u8  dev_class[3];
> > > >  };
> > > >
> > > > +/* CMSG flags */
> > > > +#define SCO_CMSG_PKT_STATUS    0x0001
> > > > +
> > >
> > > I wonder if we can make this generic since ISO also has similar status
> > > of received packets so I was hoping I could reuse the same flag to
> > > indicate we want packet status to be transmitted with cmsg. Maybe have
> > > it as BT_CMSG_PKT_STATUS?
> > I think CMSG flags will be different based on the socket types.  I
> > agree it's possible some will be shared between SCO and ISO, but I
> > would hesitate to make this generic to BT since it doesn't apply to
> > all BT sockets.  This also isn't exposed to external components
> > either, it's sort of a SCO internal implementation detail more than
> > anything.  ISO could have something similar and likely other flags...
>
> I was thinking that the flag could be the same just the content is
> different based on the socket type that way there is not even a chance
> of using a flag that is only suppose to work with certain socket type,
> BT_PKT_STATUS naming itself since to be generic enough so I wonder if
> the change of namespace does really make sense given that I could
> enable that on ISO socket but then I would have to add a separate flag
> for it? It is probably not a big deal we have been moving away from
> protocol specific options ever since we started using  BT_ namespace
> for socket options.
If this was a client facing option, I think I'd agree and would want
to have something that is aligned at the SCO/ISO Api surface, but
given that this is an internal implementation flag within the sco
implementation (set in sco's setsockopt), the reusability doesn't seem
to be worth while.  That being said, I don't feel that strongly about
this so if you feel strongly I'll happily change it as you suggested.

>
> >
> > >
> > > >  #endif /* __SCO_H */
> > > > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> > > > index 3fd124927d4d..d0abea8d08cc 100644
> > > > --- a/net/bluetooth/af_bluetooth.c
> > > > +++ b/net/bluetooth/af_bluetooth.c
> > > > @@ -286,6 +286,9 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> > > >                 if (msg->msg_name && bt_sk(sk)->skb_msg_name)
> > > >                         bt_sk(sk)->skb_msg_name(skb, msg->msg_name,
> > > >                                                 &msg->msg_namelen);
> > > > +
> > > > +               if (bt_sk(sk)->skb_put_cmsg)
> > > > +                       bt_sk(sk)->skb_put_cmsg(skb, msg, sk);
> > > >         }
> > > >
> > > >         skb_free_datagram(sk, skb);
> > > > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > > > index 51d399273276..7b5e46198d99 100644
> > > > --- a/net/bluetooth/hci_core.c
> > > > +++ b/net/bluetooth/hci_core.c
> > > > @@ -4549,6 +4549,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
> > > >
> > > >         if (conn) {
> > > >                 /* Send to upper protocol */
> > > > +               bt_cb(skb)->sco.pkt_status = flags & 0x03;
> > > >                 sco_recv_scodata(conn, skb);
> > > >                 return;
> > > >         } else {
> > > > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> > > > index c8c3d38cdc7b..f6b54853e547 100644
> > > > --- a/net/bluetooth/sco.c
> > > > +++ b/net/bluetooth/sco.c
> > > > @@ -66,6 +66,7 @@ struct sco_pinfo {
> > > >         bdaddr_t        dst;
> > > >         __u32           flags;
> > > >         __u16           setting;
> > > > +       __u32           cmsg_mask;
> > > >         struct sco_conn *conn;
> > > >  };
> > > >
> > > > @@ -449,6 +450,15 @@ static void sco_sock_close(struct sock *sk)
> > > >         sco_sock_kill(sk);
> > > >  }
> > > >
> > > > +static void sco_skb_put_cmsg(struct sk_buff *skb, struct msghdr *msg,
> > > > +                            struct sock *sk)
> > > > +{
> > > > +       if (sco_pi(sk)->cmsg_mask & SCO_CMSG_PKT_STATUS)
> > > > +               put_cmsg(msg, SOL_BLUETOOTH, BT_PKT_STATUS,
> > > > +                        sizeof(bt_cb(skb)->sco.pkt_status),
> > > > +                        &bt_cb(skb)->sco.pkt_status);
> > > > +}
> > > > +
> > > >  static void sco_sock_init(struct sock *sk, struct sock *parent)
> > > >  {
> > > >         BT_DBG("sk %p", sk);
> > > > @@ -457,6 +467,8 @@ static void sco_sock_init(struct sock *sk, struct sock *parent)
> > > >                 sk->sk_type = parent->sk_type;
> > > >                 bt_sk(sk)->flags = bt_sk(parent)->flags;
> > > >                 security_sk_clone(parent, sk);
> > > > +       } else {
> > > > +               bt_sk(sk)->skb_put_cmsg = sco_skb_put_cmsg;
> > > >         }
> > > >  }
> > > >
> > > > @@ -846,6 +858,18 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
> > > >                 sco_pi(sk)->setting = voice.setting;
> > > >                 break;
> > > >
> > > > +       case BT_PKT_STATUS:
> > > > +               if (get_user(opt, (u32 __user *)optval)) {
> > > > +                       err = -EFAULT;
> > > > +                       break;
> > > > +               }
> > > > +
> > > > +               if (opt)
> > > > +                       sco_pi(sk)->cmsg_mask |= SCO_CMSG_PKT_STATUS;
> > > > +               else
> > > > +                       sco_pi(sk)->cmsg_mask &= ~SCO_CMSG_PKT_STATUS;
> > > > +               break;
> > > > +
> > > >         default:
> > > >                 err = -ENOPROTOOPT;
> > > >                 break;
> > > > @@ -923,6 +947,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
> > > >         int len, err = 0;
> > > >         struct bt_voice voice;
> > > >         u32 phys;
> > > > +       u32 pkt_status;
> > > >
> > > >         BT_DBG("sk %p", sk);
> > > >
> > > > @@ -969,6 +994,16 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
> > > >                         err = -EFAULT;
> > > >                 break;
> > > >
> > > > +       case BT_PKT_STATUS:
> > > > +               if (sco_pi(sk)->cmsg_mask & SCO_CMSG_PKT_STATUS)
> > > > +                       pkt_status = 1;
> > > > +               else
> > > > +                       pkt_status = 0;
> > > > +
> > > > +               if (put_user(pkt_status, (u32 __user *)optval))
> > > > +                       err = -EFAULT;
> > > > +               break;
> > > > +
> > > >         default:
> > > >                 err = -ENOPROTOOPT;
> > > >                 break;
> > > > --
> > > > 2.27.0.rc2.251.g90737beb825-goog
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
>
>
>
> --
> Luiz Augusto von Dentz
