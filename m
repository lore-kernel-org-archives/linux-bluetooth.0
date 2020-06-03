Return-Path: <SRS0=Vaj6=7Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE65C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 21:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F9C12077D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Jun 2020 21:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYGfBn8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgFCVPI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jun 2020 17:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCVPI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jun 2020 17:15:08 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48538C08C5C0
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2020 14:15:08 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id s21so3140882oic.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2020 14:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPw3S1zerV4eP1bQBWpe94Vh6YJh1xoA4dN2/uw/KGE=;
        b=IYGfBn8d3V/5lnjAFthMGXZuvawbeAhe1yrDGGNA0Ozkx+12F5il/2+4uy4PeIn8h8
         govorKhfyl4D2UQKRyj1n3xkoIPmg4QqkxG0QBku0LxbTO7Hz5sYChugV5vgze3cp7GG
         2mx42077vbypsP8xMa6McDyIUhu0aZicNWyep+u2aADfbXBUpefuKzQZXU0EH8L1yInK
         dUQDt+D9d667BRjNoll1YqiVYSLglB6x5s0pTFald0MKsS/unbtsvrd1wB2gd2WyBbnW
         a3KG0Cw1ThJscHWjN2FSusTFwdk+CpdcYZ985iM68Hi6ptvhsIcff+alR4t/6X9kSN9T
         jIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPw3S1zerV4eP1bQBWpe94Vh6YJh1xoA4dN2/uw/KGE=;
        b=nbPluGHM42/mkDWFL6q4bbNkH60Xa68aSfyhqPIgMVlxfxkcnVuDfK83FmiAgzDP9C
         nGjOj+xTiB0K8H+kEWBcIhtTJatwdNxMqodHfOKPmMYn9SJ38U5e26PZL03k0jCcNgno
         A3I4n1BwpOLY/qlf+ReFE7p7ofIuDeIvkqgh3tIYjK9Q9LD/RoM6u/oXcaC1eWc8b8hE
         L16Cd/6AbLnVedFkK1FymVXb8DtzzX7C4npbiAkskvtg/gaJ0qiP7Q7//7POnHGv6LIZ
         cVGTbmKEd53p2nRw7MMQhU7G3wPeqv8pwxsKkkGdfHzTZfCofdZiWvIZ+4DljLr5YK2Q
         iBkQ==
X-Gm-Message-State: AOAM530l2Gn+haKUW7dIZ8G+KZytbN17fAhYTeKYoaH1sWEkoUVqQSlH
        gftC1sNT5VWlybnlCYWPqZ6WehgSLLv7zCsu1jZJF8u2
X-Google-Smtp-Source: ABdhPJz1OoA5ayuSitsyuNU8oE2vPJcDD18ubFWJG1wjLL8uJs7AFjGJaRCBos6dKKR5mxvE9wNhdFh1fWfDYVTFU20=
X-Received: by 2002:aca:b5d5:: with SMTP id e204mr1159158oif.108.1591218906856;
 Wed, 03 Jun 2020 14:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200603145205.125167-1-alainm@chromium.org>
In-Reply-To: <20200603145205.125167-1-alainm@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Jun 2020 14:14:55 -0700
Message-ID: <CABBYNZ+Os=u4=r+mSq+C9nRyN=PC6Yk7GNTGhto_2-TBmHxdRQ@mail.gmail.com>
Subject: Re: [PATCH v3] sco:Add support for BT_PKT_STATUS CMSG data
To:     Alain Michaud <alainm@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain, Marcel,

On Wed, Jun 3, 2020 at 7:56 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This change adds support for reporting the BT_PKT_STATUS to the socket
> CMSG data to allow the implementation of a packet loss correction on
> erronous data received on the SCO socket.
>
> The patch was partially developed by Marcel Holtmann and validated by
> Hsin-yu Chao
>
> Signed-off-by: Alain Michaud <alainm@chromium.org>
>
> ---
>
>  include/net/bluetooth/bluetooth.h |  8 +++++++
>  include/net/bluetooth/sco.h       |  3 +++
>  net/bluetooth/af_bluetooth.c      |  3 +++
>  net/bluetooth/hci_core.c          |  1 +
>  net/bluetooth/sco.c               | 35 +++++++++++++++++++++++++++++++
>  5 files changed, 50 insertions(+)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 3fa7b1e3c5d9..85e6c5754448 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -147,6 +147,8 @@ struct bt_voice {
>  #define BT_MODE_LE_FLOWCTL     0x03
>  #define BT_MODE_EXT_FLOWCTL    0x04
>
> +#define BT_PKT_STATUS          16
> +
>  __printf(1, 2)
>  void bt_info(const char *fmt, ...);
>  __printf(1, 2)
> @@ -275,6 +277,7 @@ struct bt_sock {
>         struct sock *parent;
>         unsigned long flags;
>         void (*skb_msg_name)(struct sk_buff *, void *, int *);
> +       void (*skb_put_cmsg)(struct sk_buff *, struct msghdr *, struct sock *);
>  };
>
>  enum {
> @@ -324,6 +327,10 @@ struct l2cap_ctrl {
>         struct l2cap_chan *chan;
>  };
>
> +struct sco_ctrl {
> +       u8      pkt_status;
> +};
> +
>  struct hci_dev;
>
>  typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
> @@ -350,6 +357,7 @@ struct bt_skb_cb {
>         u8 incoming:1;
>         union {
>                 struct l2cap_ctrl l2cap;
> +               struct sco_ctrl sco;
>                 struct hci_ctrl hci;
>         };
>  };
> diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
> index f40ddb4264fc..7f0d7bdc53f6 100644
> --- a/include/net/bluetooth/sco.h
> +++ b/include/net/bluetooth/sco.h
> @@ -46,4 +46,7 @@ struct sco_conninfo {
>         __u8  dev_class[3];
>  };
>
> +/* CMSG flags */
> +#define SCO_CMSG_PKT_STATUS    0x0001
> +

I wonder if we can make this generic since ISO also has similar status
of received packets so I was hoping I could reuse the same flag to
indicate we want packet status to be transmitted with cmsg. Maybe have
it as BT_CMSG_PKT_STATUS?

>  #endif /* __SCO_H */
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 3fd124927d4d..d0abea8d08cc 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -286,6 +286,9 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>                 if (msg->msg_name && bt_sk(sk)->skb_msg_name)
>                         bt_sk(sk)->skb_msg_name(skb, msg->msg_name,
>                                                 &msg->msg_namelen);
> +
> +               if (bt_sk(sk)->skb_put_cmsg)
> +                       bt_sk(sk)->skb_put_cmsg(skb, msg, sk);
>         }
>
>         skb_free_datagram(sk, skb);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 51d399273276..7b5e46198d99 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -4549,6 +4549,7 @@ static void hci_scodata_packet(struct hci_dev *hdev, struct sk_buff *skb)
>
>         if (conn) {
>                 /* Send to upper protocol */
> +               bt_cb(skb)->sco.pkt_status = flags & 0x03;
>                 sco_recv_scodata(conn, skb);
>                 return;
>         } else {
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index c8c3d38cdc7b..f6b54853e547 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -66,6 +66,7 @@ struct sco_pinfo {
>         bdaddr_t        dst;
>         __u32           flags;
>         __u16           setting;
> +       __u32           cmsg_mask;
>         struct sco_conn *conn;
>  };
>
> @@ -449,6 +450,15 @@ static void sco_sock_close(struct sock *sk)
>         sco_sock_kill(sk);
>  }
>
> +static void sco_skb_put_cmsg(struct sk_buff *skb, struct msghdr *msg,
> +                            struct sock *sk)
> +{
> +       if (sco_pi(sk)->cmsg_mask & SCO_CMSG_PKT_STATUS)
> +               put_cmsg(msg, SOL_BLUETOOTH, BT_PKT_STATUS,
> +                        sizeof(bt_cb(skb)->sco.pkt_status),
> +                        &bt_cb(skb)->sco.pkt_status);
> +}
> +
>  static void sco_sock_init(struct sock *sk, struct sock *parent)
>  {
>         BT_DBG("sk %p", sk);
> @@ -457,6 +467,8 @@ static void sco_sock_init(struct sock *sk, struct sock *parent)
>                 sk->sk_type = parent->sk_type;
>                 bt_sk(sk)->flags = bt_sk(parent)->flags;
>                 security_sk_clone(parent, sk);
> +       } else {
> +               bt_sk(sk)->skb_put_cmsg = sco_skb_put_cmsg;
>         }
>  }
>
> @@ -846,6 +858,18 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
>                 sco_pi(sk)->setting = voice.setting;
>                 break;
>
> +       case BT_PKT_STATUS:
> +               if (get_user(opt, (u32 __user *)optval)) {
> +                       err = -EFAULT;
> +                       break;
> +               }
> +
> +               if (opt)
> +                       sco_pi(sk)->cmsg_mask |= SCO_CMSG_PKT_STATUS;
> +               else
> +                       sco_pi(sk)->cmsg_mask &= ~SCO_CMSG_PKT_STATUS;
> +               break;
> +
>         default:
>                 err = -ENOPROTOOPT;
>                 break;
> @@ -923,6 +947,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
>         int len, err = 0;
>         struct bt_voice voice;
>         u32 phys;
> +       u32 pkt_status;
>
>         BT_DBG("sk %p", sk);
>
> @@ -969,6 +994,16 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
>                         err = -EFAULT;
>                 break;
>
> +       case BT_PKT_STATUS:
> +               if (sco_pi(sk)->cmsg_mask & SCO_CMSG_PKT_STATUS)
> +                       pkt_status = 1;
> +               else
> +                       pkt_status = 0;
> +
> +               if (put_user(pkt_status, (u32 __user *)optval))
> +                       err = -EFAULT;
> +               break;
> +
>         default:
>                 err = -ENOPROTOOPT;
>                 break;
> --
> 2.27.0.rc2.251.g90737beb825-goog
>


-- 
Luiz Augusto von Dentz
