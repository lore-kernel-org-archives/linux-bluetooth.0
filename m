Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D543F9F4
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 14:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563029; cv=none; b=OH5NEe8wE4KaCdOp/U+7m8qvuqAuHFyWD22k1wdIXfruufzv1TI2+u39dQaOD9GqFR1MkCfIXD6r2O6rKxlk5tlO8de6xre5nn+T2konXkO+fCBo/O+kBxgNiFFktfLZLZXhY1YLpK8RHlfh6VLHhP7U+lVYqlEfeXr55evGFA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563029; c=relaxed/simple;
	bh=YNYWTWPLIuoFdIWTdMu0tlC8cm4Cl0p2z6N343pV+g0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X577rlawhcJLylj0h73a17gyMESQo/ktEbMAy6Js5qRV10VACPKa409LBtW4K3rGRt/htRl/zniQhUrkLnv4I2WswW4e54AggCT22m2XFkEw6Q/6xPXkX9RH2CS36EbKxDa4CUXAw7CfDrqgGFl9SMrngyXSyagw7GaR/wtbkHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f7YFf/y+; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7YFf/y+"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d2305589a2so67876391fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Mar 2024 06:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709563025; x=1710167825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fgip60pRQeSzTekBFMIfLN6nBHBQEyiJpEMDK3N5ZJE=;
        b=f7YFf/y++EbVfcZ9XfCeuQpQDU7x4xX4BrzlepILxmHJcnAtuom28LNJT1UH0h7T95
         I/WDgEZQtUP8SUlAZemKBtKLarZC5C0sT4bRS9uai/2/flOGLVNUPNEHe9O15c663u6C
         5UXMBkBDG6G0I9HntwxVN3/12fZlKLOaBBv9Gjbhg5tpIX2iocy/Vvn3YKBIUpEwzMB3
         TLNWO4nq23sUR6F6h4z4/9Ag3QaNraGyVlWDcn/k7wG8ThvlcLSOzIAl01L+Z5njJANi
         PvQOgqdjVen1KPjsYVZwMHsfjdlxw5HtYVm3lvRFggxfZUvFcwFnQL1b2Hw4s4oo8v/k
         OlGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709563025; x=1710167825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fgip60pRQeSzTekBFMIfLN6nBHBQEyiJpEMDK3N5ZJE=;
        b=OEyJUaGNyWTOPqmZ+O1a25M7XlF33wU+hjq8+MjIBBbhbQwd4oxAHdx13+7jlhcQUS
         Tblfnuer5ZumcK5u0GyoVrvfCtKof/RbgQHIH5ONhH8X1/zi3SospxnX+Zh1UINIkd0P
         0vlmcNdE6UTr5TOxIaVzc4+YVtQap4Kr3xrw7QBrpr7itPOOsR1N+wAtC/gUHsv/T3We
         r+21j6rlNpcVslYgPYifGTELi1nZYnM5rA3WBrsjKn86sIFVc1bm5dmmwqumRk2tOVrh
         9hWjKs61MeSWlkUunuaFY3tDIBs+sJicawuU/iiFdGOHZ1YLUJ1NQ2T+Tmd5sxmxFgQb
         TcnQ==
X-Gm-Message-State: AOJu0Yw7+fLAIh+HIFYb5L+aIxnf2QE9jpkKWm9SSI/sSUuPCcn2eBGM
	X/9JmbNyYlV87Xg3ixvqugrsX+dNzl5Zrq0FQ+TEFCEppRYNyc8pSxI4NoChfkQMqnesAHlwpbe
	5cuSFctl6a9RyrudTZ3f1LeGIfko=
X-Google-Smtp-Source: AGHT+IGHKjv4fdV1SPSJNeCQwijpiLc9NYaU3PTzK4NXw7PqCstA4cIMhUDDnlKXSmjCJlwUL1CnTkBtrHBkJY91/Cs=
X-Received: by 2002:a2e:a0cd:0:b0:2d2:f148:29fc with SMTP id
 f13-20020a2ea0cd000000b002d2f14829fcmr5937640ljm.12.1709563024937; Mon, 04
 Mar 2024 06:37:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1709409547.git.pav@iki.fi> <d19187ab9842df2565d1d82beb171a8967d2ea94.1709409547.git.pav@iki.fi>
In-Reply-To: <d19187ab9842df2565d1d82beb171a8967d2ea94.1709409547.git.pav@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 4 Mar 2024 09:36:52 -0500
Message-ID: <CABBYNZJXpL1ALKmqq2uwGHM1mm6LvPPUAOYEoJiJuz4U_nfMbQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] Bluetooth: add support for skb TX timestamping
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Sat, Mar 2, 2024 at 3:08=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Support enabling TX timestamping for some skbs, and track them until
> packet completion.  Generate SCM_TSTAMP_SCHED when sending to driver,
> and SCM_TSTAMP_SND at packet completion.
>
> Make the default situation with no TX timestamping more efficient by
> only counting packets in the queue when there is nothing to track.  When
> there is something to track, we need to make clones, since the driver
> may modify sent skbs.

Great work, really nice to see how this is shaping up.

> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>  include/net/bluetooth/hci_core.h | 12 +++++
>  net/bluetooth/hci_conn.c         | 78 ++++++++++++++++++++++++++++++++
>  net/bluetooth/hci_core.c         |  5 ++
>  net/bluetooth/hci_event.c        |  4 ++
>  4 files changed, 99 insertions(+)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 56fb42df44a3..51b556612a6b 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -267,6 +267,12 @@ struct adv_info {
>         struct delayed_work     rpa_expired_cb;
>  };
>
> +struct tx_comp_queue {
> +       struct sk_buff_head queue;
> +       unsigned int extra;
> +       unsigned int tracked;
> +};
> +
>  #define HCI_MAX_ADV_INSTANCES          5
>  #define HCI_DEFAULT_ADV_DURATION       2
>
> @@ -763,6 +769,8 @@ struct hci_conn {
>         struct sk_buff_head data_q;
>         struct list_head chan_list;
>
> +       struct tx_comp_queue tx_comp_queue;

I'd go with tx_q just to be short.

> +
>         struct delayed_work disc_work;
>         struct delayed_work auto_accept_work;
>         struct delayed_work idle_work;
> @@ -1546,6 +1554,10 @@ void hci_conn_enter_active_mode(struct hci_conn *c=
onn, __u8 force_active);
>  void hci_conn_failed(struct hci_conn *conn, u8 status);
>  u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle);
>
> +void hci_conn_tx_comp_queue(struct hci_conn *conn, struct sk_buff *skb);
> +void hci_conn_tx_comp_dequeue(struct hci_conn *conn);

I'd drop the comp term here, so just hci_conn_tx_queue and
hci_conn_tx_dequeue since we want to do it no matter if the skb was
marked to be tracked or not.

> +void hci_tx_timestamp(struct sk_buff *skb, const struct sockcm_cookie *s=
ockc);
> +
>  /*
>   * hci_conn_get() and hci_conn_put() are used to control the life-time o=
f an
>   * "hci_conn" object. They do not guarantee that the hci_conn object is =
running,
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 3ad74f76983b..f44d4b8fa0c6 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -27,6 +27,7 @@
>
>  #include <linux/export.h>
>  #include <linux/debugfs.h>
> +#include <linux/errqueue.h>
>
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -973,6 +974,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, i=
nt type, bdaddr_t *dst,
>         }
>
>         skb_queue_head_init(&conn->data_q);
> +       skb_queue_head_init(&conn->tx_comp_queue.queue);
>
>         INIT_LIST_HEAD(&conn->chan_list);
>         INIT_LIST_HEAD(&conn->link_list);
> @@ -1117,6 +1119,7 @@ void hci_conn_del(struct hci_conn *conn)
>         }
>
>         skb_queue_purge(&conn->data_q);
> +       skb_queue_purge(&conn->tx_comp_queue.queue);
>
>         /* Remove the connection from the list and cleanup its remaining
>          * state. This is a separate function since for some cases like
> @@ -2928,3 +2931,78 @@ int hci_abort_conn(struct hci_conn *conn, u8 reaso=
n)
>
>         return hci_cmd_sync_queue_once(hdev, abort_conn_sync, conn, NULL)=
;
>  }
> +
> +void hci_tx_timestamp(struct sk_buff *skb, const struct sockcm_cookie *s=
ockc)
> +{
> +       /* This shall be called on a single skb of those generated by use=
r
> +        * sendmsg(), and only when the sendmsg() does not return error t=
o
> +        * user. This is required for keeping the tskey that increments h=
ere in
> +        * sync with possible sendmsg() counting by user.
> +        */
> +
> +       if (!skb || !sockc)
> +               return;
> +
> +       skb_setup_tx_timestamp(skb, sockc->tsflags);
> +}
> +
> +void hci_conn_tx_comp_queue(struct hci_conn *conn, struct sk_buff *skb)
> +{
> +       struct tx_comp_queue *comp =3D &conn->tx_comp_queue;
> +       bool track =3D false;
> +
> +       if (skb->sk) {
> +               if (skb_shinfo(skb)->tx_flags & SKBTX_SCHED_TSTAMP)
> +                       __skb_tstamp_tx(skb, NULL, NULL, skb->sk,
> +                                       SCM_TSTAMP_SCHED);
> +
> +               if (skb_shinfo(skb)->tx_flags & SKBTX_SW_TSTAMP)
> +                       track =3D true;
> +       }
> +
> +       /* If nothing is tracked, just count extra skbs at the queue head=
 */
> +       if (!track && !comp->tracked) {
> +               comp->extra++;
> +               return;
> +       }
> +
> +       if (track) {
> +               skb =3D skb_clone_sk(skb);
> +               if (!skb)
> +                       return;
> +
> +               comp->tracked++;
> +       } else {
> +               skb =3D skb_clone(skb, GFP_KERNEL);
> +               if (!skb)
> +                       return;
> +       }

Do we really need clones here? Can we just have references or that
doesn't work because the skb could be put in another queue by the
driver which would screw our own queuing?

> +       skb_queue_tail(&comp->queue, skb);
> +}
> +
> +void hci_conn_tx_comp_dequeue(struct hci_conn *conn)
> +{
> +       struct tx_comp_queue *comp =3D &conn->tx_comp_queue;
> +       struct sk_buff *skb;
> +
> +       /* If there are tracked skbs, the counted extra go before dequeui=
ng real
> +        * skbs, to keep ordering. When nothing is tracked, the ordering =
doesn't
> +        * matter so dequeue real skbs first to get rid of them ASAP.
> +        */
> +       if (comp->extra && (comp->tracked || skb_queue_empty(&comp->queue=
))) {
> +               comp->extra--;
> +               return;
> +       }
> +
> +       skb =3D skb_dequeue(&comp->queue);
> +       if (!skb)
> +               return;
> +
> +       if (skb->sk) {
> +               comp->tracked--;
> +               skb_tstamp_tx(skb, NULL);
> +       }
> +
> +       kfree_skb(skb);
> +}
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index df3aa41e376d..f4af6e99d798 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3715,6 +3715,8 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
>                         hci_conn_enter_active_mode(chan->conn,
>                                                    bt_cb(skb)->force_acti=
ve);
>
> +                       hci_conn_tx_comp_queue(chan->conn, skb);
> +
>                         hci_send_frame(hdev, skb);
>                         hdev->acl_last_tx =3D jiffies;
>
> @@ -3876,6 +3878,9 @@ static void hci_sched_iso(struct hci_dev *hdev)
>         while (*cnt && (conn =3D hci_low_sent(hdev, ISO_LINK, &quote))) {
>                 while (quote-- && (skb =3D skb_dequeue(&conn->data_q))) {
>                         BT_DBG("skb %p len %d", skb, skb->len);
> +
> +                       hci_conn_tx_comp_queue(conn, skb);
> +
>                         hci_send_frame(hdev, skb);
>
>                         conn->sent++;

I'd assume we should be doing the same for SCO_LINK, or that was
intentionally left out? Perhaps it would be better to have something
like hci_conn_send_frame as a helper function that does take care of
updating whatever needs to be updated before calling hci_send_frame.

> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index bffd2c7ff608..f56211d8ff7a 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4438,6 +4438,7 @@ static void hci_num_comp_pkts_evt(struct hci_dev *h=
dev, void *data,
>                 struct hci_comp_pkts_info *info =3D &ev->handles[i];
>                 struct hci_conn *conn;
>                 __u16  handle, count;
> +               unsigned int i;
>
>                 handle =3D __le16_to_cpu(info->handle);
>                 count  =3D __le16_to_cpu(info->count);
> @@ -4448,6 +4449,9 @@ static void hci_num_comp_pkts_evt(struct hci_dev *h=
dev, void *data,
>
>                 conn->sent -=3D count;
>
> +               for (i =3D 0; i < count; ++i)
> +                       hci_conn_tx_comp_dequeue(conn);
> +
>                 switch (conn->type) {
>                 case ACL_LINK:
>                         hdev->acl_cnt +=3D count;
> --
> 2.44.0

Btw, one thing that might be great to have is the timestamp
information also forward to the monitor with use of SCM, btmon already
does track the NOCP event and print the amount of time it took but
that is probably no as precise as doing this in kernel, besides it
doesn't


--=20
Luiz Augusto von Dentz
