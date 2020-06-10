Return-Path: <SRS0=8+Sx=7X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70165C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 13:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DB42067B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 Jun 2020 13:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lIVMTIwD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbgFJNeD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgFJNeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Jun 2020 09:34:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB3BC03E96B
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 06:34:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c17so2467233lji.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2020 06:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSitkLLaYPJFBxLeOYoj3Bnf0moKxdCbMeSJehuWSco=;
        b=lIVMTIwD2nbLABefuI2iffU2IrWVrl6EM7eb6YI/jh6sgZJngZMqM6CD+LhkpZh7qU
         KohIEmHlct8tIH2555pE3DEDcHcmIurDR4TXcSelXDrmRFDLHHk1bYEdOYLPRJUnUdXC
         XdxYOeZ9QW7fqhveSVfXy/Fh0GOkMP5nqg8HUJC8kLu/KBGncp36KExXw15d+llmopoM
         rdqpYVOHMs/FNwsyLPlcK1l5BVx193QFAAuc3zybKX25eLAcVmdS7pulYYvM+aVzsHuT
         lzprp6oPFyTK77R53A0gjBVoauChNI/5gdrg7AJrJloYFnVzhO7omvy+R2uKMxDpHmXk
         V/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSitkLLaYPJFBxLeOYoj3Bnf0moKxdCbMeSJehuWSco=;
        b=DuTs6YD4XehsV2dXGn4ov0HTN448bZGfN6uZ8zdLjvdl2ofbbLrBURjWr9Y259Ww17
         QmLmRCwk7W8bWQ9QXmVsGKLT8mCkBAReb6RmvO56JBHc7XaF76pdPJ3VHcUfgLS/T0gD
         HHtKfAvWoBetrqck/sR4LzFY49LqhOM80snRn0rQTuQF0hPLZ94iK6tRgoxYaXY29lhL
         sQlSNRmAwoFye/aay1zVfQOn1WCW4ih34u8U7D79GB1228OaLd0RYo09OwAdbU5HDLTU
         DpEjz8NxaJrW7NTjamc0mJ5UwFnaO0+8qP/2H9gcialxjqPiA2oeRplRfZBgFiOkZ7Gm
         OXlw==
X-Gm-Message-State: AOAM533ZcRpYzOS3FOWXaIjNu63HbdNym/bRKjDdbKq3b+40dQQTo0qx
        Br/IANM8wgQoRdGXKhyu22+E/84xWqsi8x7L4xi+ew==
X-Google-Smtp-Source: ABdhPJzcgzzpoNhtwg9jg+QgQPD2sSBjy1gqdgDifUI74XAezMPorl5/zWnWsFWe+qROag0Jjur7/Ikk3yT+/LnVUPg=
X-Received: by 2002:a2e:b04c:: with SMTP id d12mr1680761ljl.256.1591796040247;
 Wed, 10 Jun 2020 06:34:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200603145121.124842-1-alainm@chromium.org> <DCF83E8F-62CC-49F8-B660-0AFEDBED5F02@holtmann.org>
 <CALWDO_VHTT4V5GvPFtSZcW5Xce8oTSaLNdNQ1gNd=hyCaBX-yg@mail.gmail.com>
In-Reply-To: <CALWDO_VHTT4V5GvPFtSZcW5Xce8oTSaLNdNQ1gNd=hyCaBX-yg@mail.gmail.com>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Wed, 10 Jun 2020 09:33:47 -0400
Message-ID: <CALWDO_Vynv46nYHC-cEb0tL0doDMHzqQG+rCYAi+vRe886earg@mail.gmail.com>
Subject: Re: [PATCH v2] sco:Add support for BT_PKT_STATUS CMSG data
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Resending in plaintext.


On Wed, Jun 10, 2020 at 9:33 AM Alain Michaud <alainmichaud@google.com> wrote:
>
> Hi Marcel
>
> On Wed, Jun 10, 2020 at 4:25 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>>
>> Hi Alain,
>>
>> > This change adds support for reporting the BT_PKT_STATUS to the socket
>> > CMSG data to allow the implementation of a packet loss correction on
>> > erronous data received on the SCO socket.
>> >
>> > The patch was partially developed by Marcel Holtmann and validated by
>> > Hsin-yu Chao
>> >
>> > Signed-off-by: Alain Michaud <alainm@chromium.org>
>> >
>> > ---
>> >
>> > include/net/bluetooth/bluetooth.h |  8 +++++++
>> > include/net/bluetooth/sco.h       |  3 +++
>> > net/bluetooth/af_bluetooth.c      |  3 +++
>> > net/bluetooth/hci_core.c          |  1 +
>> > net/bluetooth/sco.c               | 35 +++++++++++++++++++++++++++++++
>> > 5 files changed, 50 insertions(+)
>>
>> I already had this patch in my tree for testing, but then realized that I gave you a bad example on how to handle this.
>>
>> So we should not use the same constants for CMSG and socket options. Fundamentally the socket semantics use SO_foo for enabling an aux data transmission and they use SCM_bar for the CMSG portion.
>>
>> >
>> > diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
>> > index 3fa7b1e3c5d9..85e6c5754448 100644
>> > --- a/include/net/bluetooth/bluetooth.h
>> > +++ b/include/net/bluetooth/bluetooth.h
>> > @@ -147,6 +147,8 @@ struct bt_voice {
>> > #define BT_MODE_LE_FLOWCTL    0x03
>> > #define BT_MODE_EXT_FLOWCTL   0x04
>> >
>> > +#define BT_PKT_STATUS          16
>> > +
>> > __printf(1, 2)
>> > void bt_info(const char *fmt, ...);
>> > __printf(1, 2)
>> > @@ -275,6 +277,7 @@ struct bt_sock {
>> >       struct sock *parent;
>> >       unsigned long flags;
>> >       void (*skb_msg_name)(struct sk_buff *, void *, int *);
>> > +     void (*skb_put_cmsg)(struct sk_buff *, struct msghdr *, struct sock *);
>> > };
>> >
>> > enum {
>> > @@ -324,6 +327,10 @@ struct l2cap_ctrl {
>> >       struct l2cap_chan *chan;
>> > };
>> >
>> > +struct sco_ctrl {
>> > +     u8      pkt_status;
>> > +};
>> > +
>> > struct hci_dev;
>> >
>> > typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
>> > @@ -350,6 +357,7 @@ struct bt_skb_cb {
>> >       u8 incoming:1;
>> >       union {
>> >               struct l2cap_ctrl l2cap;
>> > +             struct sco_ctrl sco;
>> >               struct hci_ctrl hci;
>> >       };
>> > };
>> > diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
>> > index f40ddb4264fc..7f0d7bdc53f6 100644
>> > --- a/include/net/bluetooth/sco.h
>> > +++ b/include/net/bluetooth/sco.h
>> > @@ -46,4 +46,7 @@ struct sco_conninfo {
>> >       __u8  dev_class[3];
>> > };
>> >
>> > +/* CMSG flags */
>> > +#define SCO_CMSG_PKT_STATUS  0x0001
>> > +
>> > #endif /* __SCO_H */
>> > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
>> > index 3fd124927d4d..d0abea8d08cc 100644
>> > --- a/net/bluetooth/af_bluetooth.c
>> > +++ b/net/bluetooth/af_bluetooth.c
>> > @@ -286,6 +286,9 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>> >               if (msg->msg_name && bt_sk(sk)->skb_msg_name)
>> >                       bt_sk(sk)->skb_msg_name(skb, msg->msg_name,
>> >                                               &msg->msg_namelen);
>> > +
>> > +             if (bt_sk(sk)->skb_put_cmsg)
>> > +                     bt_sk(sk)->skb_put_cmsg(skb, msg, sk);
>> >       }
>> >
>> >       skb_free_datagram(sk, skb);
>> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
>> > index 51d399273276..7b5e46198d99 100644
>> > --- a/net/bluetooth/hci_core.c
>> > +++ b/net/bluetooth/hci_core.c
>> > @@ -4549,6 +4549,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
>> >
>> >       if (conn) {
>> >               /* Send to upper protocol */
>> > +             bt_cb(skb)->sco.pkt_status = flags & 0x03;
>> >               sco_recv_scodata(conn, skb);
>> >               return;
>> >       } else {
>> > diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
>> > index c8c3d38cdc7b..f6b54853e547 100644
>> > --- a/net/bluetooth/sco.c
>> > +++ b/net/bluetooth/sco.c
>> > @@ -66,6 +66,7 @@ struct sco_pinfo {
>> >       bdaddr_t        dst;
>> >       __u32           flags;
>> >       __u16           setting;
>> > +     __u32           cmsg_mask;
>> >       struct sco_conn *conn;
>> > };
>> >
>> > @@ -449,6 +450,15 @@ static void sco_sock_close(struct sock *sk)
>> >       sco_sock_kill(sk);
>> > }
>> >
>> > +static void sco_skb_put_cmsg(struct sk_buff *skb, struct msghdr *msg,
>> > +                          struct sock *sk)
>> > +{
>> > +     if (sco_pi(sk)->cmsg_mask & SCO_CMSG_PKT_STATUS)
>> > +             put_cmsg(msg, SOL_BLUETOOTH, BT_PKT_STATUS,
>>
>> This needs an extra BT_SCM_PKT_STATUS constant.
>
> Since we don't have this name space defined yet, I'm assuming I just start with 01 for this.
>>
>>
>> > +                      sizeof(bt_cb(skb)->sco.pkt_status),
>> > +                      &bt_cb(skb)->sco.pkt_status);
>> > +}
>> > +
>> > static void sco_sock_init(struct sock *sk, struct sock *parent)
>> > {
>> >       BT_DBG("sk %p", sk);
>> > @@ -457,6 +467,8 @@ static void sco_sock_init(struct sock *sk, struct sock *parent)
>> >               sk->sk_type = parent->sk_type;
>> >               bt_sk(sk)->flags = bt_sk(parent)->flags;
>> >               security_sk_clone(parent, sk);
>> > +     } else {
>> > +             bt_sk(sk)->skb_put_cmsg = sco_skb_put_cmsg;
>> >       }
>> > }
>> >
>> > @@ -846,6 +858,18 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
>> >               sco_pi(sk)->setting = voice.setting;
>> >               break;
>> >
>> > +     case BT_PKT_STATUS:
>> > +             if (get_user(opt, (u32 __user *)optval)) {
>> > +                     err = -EFAULT;
>> > +                     break;
>> > +             }
>> > +
>> > +             if (opt)
>> > +                     sco_pi(sk)->cmsg_mask |= SCO_CMSG_PKT_STATUS;
>> > +             else
>> > +                     sco_pi(sk)->cmsg_mask &= ~SCO_CMSG_PKT_STATUS;
>> > +             break;
>> > +
>> >       default:
>> >               err = -ENOPROTOOPT;
>> >               break;
>> > @@ -923,6 +947,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
>> >       int len, err = 0;
>> >       struct bt_voice voice;
>> >       u32 phys;
>> > +     u32 pkt_status;
>>
>> Lets follow the example of SO_TIMESTAMP and use int here and convert it to a bool meaning. Since the BT_PKT_STATUS really is just suppose to enable / disable sending the packet status.
>
> I get that SO_TIMESTAMP uses a signed integer here, but I'm not quite sure what benefit it provides, especially when simply using it as a boolean value.
>>
>>
>> >
>> >       BT_DBG("sk %p", sk);
>> >
>> > @@ -969,6 +994,16 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
>> >                       err = -EFAULT;
>> >               break;
>> >
>> > +     case BT_PKT_STATUS:
>> > +             if (sco_pi(sk)->cmsg_mask & SCO_CMSG_PKT_STATUS)
>> > +                     pkt_status = 1;
>> > +             else
>> > +                     pkt_status = 0;
>> > +
>> > +             if (put_user(pkt_status, (u32 __user *)optval))
>> > +                     err = -EFAULT;
>> > +             break;
>> > +
>> >       default:
>> >               err = -ENOPROTOOPT;
>> >               break;
>>
>> Regards
>>
>> Marcel
>>
