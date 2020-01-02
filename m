Return-Path: <SRS0=Qv9v=2X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CF9C2D0C2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 17:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D22C206E6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jan 2020 17:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXtjKlq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgABRgU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jan 2020 12:36:20 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33285 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgABRgT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jan 2020 12:36:19 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so36098574otp.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jan 2020 09:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n7Suy5vm7eNETKI9A6AINZMUiCvIq8nyXo0HCt+zKP8=;
        b=HXtjKlq1jsrjoLsiorB8J3pxdvE1zHIta1XdTHa2wyVwinm8p79R27QcACVqS0PbxR
         WFky8Hx9Bh5bH03BhvBvrEgQr0QblJHN7Kok9ccnfrHf1zGjQx/Mv84EeFD7kLoXB7u2
         JSwYRzJ5MBuyL162jH8TbKgkAhZuLxEbSgL+9w63l3e4G6854bADn/NE1NfszTrG1jgM
         HORp6akjkAjCK59GSnL6zr3GHk1ols2bAfBtuK7XscLmwCsrNzZLlAdq5QpBtT6ttF4R
         63LrsHMTgjOGGW97kYfeZ4MWDH2ql7Wdr+TpXwyvgBsG6FXxI0g5Owjim0Xc6T+6+G3z
         xkuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7Suy5vm7eNETKI9A6AINZMUiCvIq8nyXo0HCt+zKP8=;
        b=CO3EQkLVbkVAkKwBFK9b7K5ACGLTQWd3ZCmZ3jjGBXenS1F+XjnSAoeQVKR8lvtJ6C
         CzRMZ9KvenDXoCKJwmjEjmC2twGalrPZHs6TRTvM/+vamIE9dEwXglGl6wMabmAgDBsb
         dfSIxldHOT15zX80SbgxET+t53nawQvKBkT6z0nEmJyh7WTWQeExcAivaaxTkMAFLdjI
         vO3Y3dUeCqUSCh7KplCX5LIwaUlan7Wm4IkIa0SHhYDZWlCwMQ8kscSUTTwydFp069oq
         byxTNAL8Xj2aYJbwwSrVzj7NiS08mMZ2uLj4FA7C3uZQ2ZK1X8IA/F/C1ZzpYhLD4Zhp
         4IwQ==
X-Gm-Message-State: APjAAAWuPXrXnV/ZJIeD2fiie6ES+McSHmAelIgbyCgs4FLriAGEG1SG
        +h1nucE0G+neHAAJCnw/mVsJCL1As4+hzmaKtwGt0nJ2
X-Google-Smtp-Source: APXvYqxWdkGjfCgja2QIX+kDjX5bdjHkoGSR576NeqGZS/y3xo4NBiJi/zFOV2aYFiyjxciVp10ugKOUocCIhJttJZc=
X-Received: by 2002:a9d:6d10:: with SMTP id o16mr95414476otp.28.1577986578189;
 Thu, 02 Jan 2020 09:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20200102172447.18574-1-luiz.dentz@gmail.com> <20200102172447.18574-2-luiz.dentz@gmail.com>
In-Reply-To: <20200102172447.18574-2-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Jan 2020 09:36:06 -0800
Message-ID: <CABBYNZJXvmF8j8Fd=zkr0a83RQ52OeEcbTJk-bgk3R9Ofzq8AA@mail.gmail.com>
Subject: Re: [RFC 2/2] Bluetooth: Add BT_PHYS socket option
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pali,

On Thu, Jan 2, 2020 at 9:24 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This adds BT_PHYS socket option which can be used to read the PHYs in
> use by the underline connection.
>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  include/net/bluetooth/bluetooth.h | 17 ++++++++
>  include/net/bluetooth/hci_core.h  |  2 +
>  net/bluetooth/hci_conn.c          | 64 +++++++++++++++++++++++++++++++
>  net/bluetooth/l2cap_sock.c        | 13 +++++++
>  net/bluetooth/sco.c               | 13 +++++++
>  5 files changed, 109 insertions(+)
>
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index e42bb8e03c09..69c0e7eb26d9 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -121,6 +121,23 @@ struct bt_voice {
>
>  #define BT_SNDMTU              12
>  #define BT_RCVMTU              13
> +#define BT_PHYS                        14
> +
> +#define BT_PHY_BR_1M_1SLOT     0x00000001
> +#define BT_PHY_BR_1M_3SLOT     0x00000002
> +#define BT_PHY_BR_1M_5SLOT     0x00000004
> +#define BT_PHY_EDR_2M_1SLOT    0x00000008
> +#define BT_PHY_EDR_2M_3SLOT    0x00000010
> +#define BT_PHY_EDR_2M_5SLOT    0x00000020
> +#define BT_PHY_EDR_3M_1SLOT    0x00000040
> +#define BT_PHY_EDR_3M_3SLOT    0x00000080
> +#define BT_PHY_EDR_3M_5SLOT    0x00000100
> +#define BT_PHY_LE_1M_TX                0x00000200
> +#define BT_PHY_LE_1M_RX                0x00000400
> +#define BT_PHY_LE_2M_TX                0x00000800
> +#define BT_PHY_LE_2M_RX                0x00001000
> +#define BT_PHY_LE_CODED_TX     0x00002000
> +#define BT_PHY_LE_CODED_RX     0x00004000

This might be of your interest since you wanted to know what packet
size to use, we might use this to adjust the MTU automatically instead
of always using 672 so we maximize the throughput if the socket owner
has not set a MTU on its own.

>  __printf(1, 2)
>  void bt_info(const char *fmt, ...);
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index faebe3859931..03cf3f0f22b9 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1467,6 +1467,8 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
>  struct sk_buff *hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
>                              const void *param, u32 timeout);
>
> +u32 hci_conn_get_phys(struct hci_conn *conn);
> +
>  /* ----- HCI Sockets ----- */
>  void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb);
>  void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 87691404d0c6..386e6b0bd2ab 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -1725,3 +1725,67 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle)
>
>         return hchan;
>  }
> +
> +u32 hci_conn_get_phys(struct hci_conn *conn)
> +{
> +       u32 phys = 0;
> +
> +       hci_dev_lock(conn->hdev);
> +
> +       switch (conn->type) {
> +       case ACL_LINK:
> +       case SCO_LINK:
> +               phys |= BT_PHY_BR_1M_1SLOT;
> +
> +               if (conn->pkt_type & (HCI_DM3 | HCI_DH3))
> +                       phys |= BT_PHY_BR_1M_3SLOT;
> +
> +               if (conn->pkt_type & (HCI_DM5 | HCI_DH5))
> +                       phys |= BT_PHY_BR_1M_5SLOT;
> +
> +               if (!(conn->pkt_type & HCI_2DH1))
> +                       phys |= BT_PHY_EDR_2M_1SLOT;
> +
> +               if (!(conn->pkt_type & HCI_2DH3))
> +                       phys |= BT_PHY_EDR_2M_3SLOT;
> +
> +               if (!(conn->pkt_type & HCI_2DH5))
> +                       phys |= BT_PHY_EDR_2M_5SLOT;
> +
> +               if (!(conn->pkt_type & HCI_3DH1))
> +                       phys |= BT_PHY_EDR_3M_1SLOT;
> +
> +               if (!(conn->pkt_type & HCI_3DH3))
> +                       phys |= BT_PHY_EDR_3M_3SLOT;
> +
> +               if (!(conn->pkt_type & HCI_3DH5))
> +                       phys |= BT_PHY_EDR_3M_5SLOT;
> +
> +               break;
> +
> +       case LE_LINK:
> +               if (conn->le_tx_phy & HCI_LE_SET_PHY_1M)
> +                       phys |= BT_PHY_LE_1M_TX;
> +
> +               if (conn->le_rx_phy & HCI_LE_SET_PHY_1M)
> +                       phys |= BT_PHY_LE_1M_RX;
> +
> +               if (conn->le_tx_phy & HCI_LE_SET_PHY_2M)
> +                       phys |= BT_PHY_LE_2M_TX;
> +
> +               if (conn->le_rx_phy & HCI_LE_SET_PHY_2M)
> +                       phys |= BT_PHY_LE_2M_RX;
> +
> +               if (conn->le_tx_phy & HCI_LE_SET_PHY_CODED)
> +                       phys |= BT_PHY_LE_CODED_TX;
> +
> +               if (conn->le_rx_phy & HCI_LE_SET_PHY_CODED)
> +                       phys |= BT_PHY_LE_CODED_RX;
> +
> +               break;
> +       }
> +
> +       hci_dev_unlock(conn->hdev);
> +
> +       return phys;
> +}
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index a7be8b59b3c2..fb011c6c67be 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -499,6 +499,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
>         struct l2cap_chan *chan = l2cap_pi(sk)->chan;
>         struct bt_security sec;
>         struct bt_power pwr;
> +       u32 phys;
>         int len, err = 0;
>
>         BT_DBG("sk %p", sk);
> @@ -603,6 +604,18 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname,
>                         err = -EFAULT;
>                 break;
>
> +       case BT_PHYS:
> +               if (sk->sk_state == BT_CONNECTED) {
> +                       err = -EINVAL;
> +                       break;
> +               }
> +
> +               phys = hci_conn_get_phys(chan->conn->hcon);
> +
> +               if (put_user(phys, (u32 __user *) optval))
> +                       err = -EFAULT;
> +               break;
> +
>         default:
>                 err = -ENOPROTOOPT;
>                 break;
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index b91d6b440fdf..dcd297f2acc6 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -922,6 +922,7 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
>         struct sock *sk = sock->sk;
>         int len, err = 0;
>         struct bt_voice voice;
> +       u32 phys;
>
>         BT_DBG("sk %p", sk);
>
> @@ -956,6 +957,18 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname,
>
>                 break;
>
> +       case BT_PHYS:
> +               if (sk->sk_state == BT_CONNECTED) {
> +                       err = -EINVAL;
> +                       break;
> +               }
> +
> +               phys = hci_conn_get_phys(sco_pi(sk)->conn->hcon);
> +
> +               if (put_user(phys, (u32 __user *) optval))
> +                       err = -EFAULT;
> +               break;
> +
>         default:
>                 err = -ENOPROTOOPT;
>                 break;
> --
> 2.21.0
>


-- 
Luiz Augusto von Dentz
