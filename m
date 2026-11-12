Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794500487;
	b=zPZXl3nBrn4M00nNBMAFiSKYj5aCNXgW9bPDzu8OoTdcwwTuTuoFwM+Ss+hAULmasaSn
	 OKUqPsq2ie7ey14EVWY+CqlPeCYa9lxSaf1CitkABse4StDESMrB4Cj2D7xQmHCCFYHl0
	 LQbXHysVaO3oxXG0RGPHLoobZQT61KdEwg5PMShPq4bEXMImSgPMVOYHx8bunLWhuRImM
	 /TSAgbdFyMCZC56GRqgpJQsKTCw5Hz44ORkp2kl3QxXJXMnAqUqQvfo799tD3G4C/0Ydn
	 zXZuZMvNgSpMp9sUcmlCPHpPN47QCgWlEuWXsld+vR5kCOXkVoySyvtbQdAAw7cE2XQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794500487;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=RLQi/vTbJrGVtxoXuyTDdwQHhyYYkYUbhVIpuJfkYTs=;
	b=wyKa0qXn4LSrbnQlCGkI40Tnc2jpHDuAC7zz9sWU1E9km38Az/jRA6YxhMGSW+cpmVvA
	 XZj4iZqtX1tkmzZVgLenESvcIkWmkLAaG1uOKAhf3XjltC3ZEYiD33i6+RKwXzLiWaWmS
	 LD85RNBkfsBQO8kCNm632o8J3bVsJHS+wV2hicq+BpbW2RXN1h+79m0BnP0qlSkmg0eTt
	 ENKvOdV6KKTi97DiGGCDD4C0+i0qnT+dF58/B4LlxQGi6HXBVmwRIvO6NVRjA6YqfNi5h
	 EuYL1TFeM6+S3U3Zh2Upd5t+k7+e158oJsSzGcxRsWj8kT7hvWrYkDuGhfk0qlzjGyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hF1F9YDa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B0A606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 16:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82B0A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hF1F9YDa
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8446af403b5so2678149a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 08:21:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794500485; cv=none;
        d=google.com; s=arc-20260327;
        b=ldJjdVmojMVUUEhnouJS4mLtboLKgKdmkeVvLt+WTd4X10WYELl3aVMY9FVC/Sd6ha
         2kqDbB3qmBvXY/2bJfB35ljaxcJgOokN3avzMYl22TTiOxqYFTraYR3SyMbYQLTq38uw
         u7SsbIB2W2WB+Vk7mqLc3OLkG6xtJvKM8BOkLEV+s+H0f8fl7vw5eadQRpjrITeB/0RX
         c9V6sGKHMdk5zGmqM+j44mTpfIWmEPuBs5tm+QjPJmTCrRlDjY07c8ps6BUSGHVZuMQK
         Wj/DxrYBmRa3eajBz1nRFTTv1A6uTTaMY48sv2zGyn7BQf7BAdOANLkHir8cYMvcsUzM
         zk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RLQi/vTbJrGVtxoXuyTDdwQHhyYYkYUbhVIpuJfkYTs=;
        fh=LUWgbrUuhMtahyXO6QT454ErJE9yEFx36d0SI3GxXhQ=;
        b=JlldXlZAvAIIMorVQ85hE2JHB9peVc8LY8KbT3NxfEbe4klMQAS23qNKfzw3ajjCtn
         YiCr3pBDIFvZrNsjqiOu1LaQW+lhiGsSaJyDB/Q5CYtQL1xoijI0/3JQDy3o9nSZY7q5
         tBuYej/HIw02tZ91TZHNAP0amDYV9roG3wJv/pJdV5QK96tUOyetNsZ39y/25FgfUrqf
         n+ox9Q7sKjqf2SwRBtWGpams8Rtb0vG3HjOMKWp0BAH6IoL9dvUkuKokDHb9bGxXmWB4
         gaGwjDo+are3CbaDoOs3vngMrGr1wzSVBD/BYlySLzFHyS4Z62KkR4lPrvIauv/C6htQ
         rSxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794500485; x=1795105285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RLQi/vTbJrGVtxoXuyTDdwQHhyYYkYUbhVIpuJfkYTs=;
        b=hF1F9YDaQe9YFqYjRXzh60umFNzxNOQ0OBP0K/+FKQXjEBydwvSBpgWZDIGUV7D6mw
         qnIUUyCKANmOzCIbbtWZhGP2AJeI5mX67WmJos95HqM44ba594jyU3ewvxOdZx4gCeWC
         Vov0K+s7XzMmdxoMBSK0xKRU+EIWIvHsz2/XV7263Z9mvQ+OzMbJ2qq30fQEzmiMDw7f
         OMogPlbnW76j0iM2BgDbnIJkSiVhQ1JjBUoqJs60RYMs2I4+IUDufCfQ9it4epwOey+j
         F6emlALnKcIsBq5utsBA6SDuIEL8Y0wNumruJnYlDoOOxlP8ThnwAQhhntd5eW+X2B1T
         ZgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794500485; x=1795105285;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RLQi/vTbJrGVtxoXuyTDdwQHhyYYkYUbhVIpuJfkYTs=;
        b=m2xuG0YSWVgtYO266YJsNnx1qpcRu++YQ64FrYP26xbF+UkT5LPvWKndwT/j2SAqir
         IzBeXXQgG+iAyzmVT0cLnuBJnpEjkQcZpLLZ+w40kTciMB82hxnC7jzIA1a4Bm/rqmmF
         QEPu/cGIbGxu8Hiyx8dQgCnbwdD4QxL6xt+e9SHsnxpbES3+wuWQw1O+sxFqQQaJTrQZ
         D8RJwK94gRmNWtXlA3aeiupkTETtYcyViIX4D/a2B2UGPp565PbiXToFaHoNHd+QTFgx
         lMvdQSAOgx5mOEaRf70oDUSPmC8LaFE2U3PkVZqHA0BgDkhNUODzZddH+6wckqZ1XX+n
         yjXg==
X-Gm-Message-State: APuU4Z877hEKDuCipirjrP/VQOdSs5bpW/0PctLLzwstGsWOAcJ/PV1G
	8KCtYwofcxayDX24I7gTtniRpzFiOHYA9Fv0JI1MPZznhIgqqOy/t+DQHhn/2EojSzJirPiZEaI
	6Pty6B6tfhe+DiMoAIQieJR2ALR4c/m4=
X-Gm-Gg: AYBFou3qkORqcw90K1BYGgj5mytB6H5cjKnioKzQ7c4yKxGf8RjkDO0bNz4P4vumwJf
	gPaCs5KMIkQVq9/itcziSL0prz/aofWmqLki+eHNNf+miMtp/ft574+Rb2kJ0iYgLbpCztxoyCr
	eMCLOCXPlQeTYuaH6X8YE9UQKok3vIYj6uloa/GxHeyBgXlNTUmil+dzlwLjulGgNGDM6ZA8e06
	KztYrFbhnzaXBZ1n6JEKhlWClrDEyuLQjC0isY4v/O7G8tXfwlI0/R+azXtlm05kT8eg12hxS9O
	to9MW1YcCZGH8fVJ2MpjbO5Gdb/q/N5tw0/bMVMnDsxLUza4x+ngSFypjodbbEc4T3JUhUKd+tb
	FUPKItcfC2Av3Jy2+CEM+d8PRbjsLTlulY18RToJrEnc38T+JZB1xgKPd3NljMIB9DTptjdTIBd
	UC2NuSoKj8u6XVrxU6DuA9Ta3yzUZ7vny+reHmJUS60z801Ku6kx4R3MtzI2g=
X-Received: by 2002:a05:6808:1807:b0:4d6:9293:9b54 with SMTP id
 5614622812f47-56b98620b96mr5424658b6e.60.1794500485079; Thu, 12 Nov 2026
 08:21:25 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013031943.489829-1-cochcoder@proton.me> <20261015052751.137705-1-cochcoder@proton.me>
 <20261015181624.48318-1-cochcoder@proton.me> <20261106021723.631339-1-cochcoder@proton.me>
 <20261106045515.853897-1-cochcoder@proton.me> <20261106173948.596166-1-cochcoder@proton.me>
 <20261107023556.1475788-1-cochcoder@proton.me> <20261107071634.2237059-1-cochcoder@proton.me>
 <20261112023025.187702-1-cochcoder@proton.me>
In-Reply-To: <20261112023025.187702-1-cochcoder@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 12 Nov 2026 11:21:12 -0500
X-Gm-Features: AclHuK-UgjSZ5tyRWYWnWewlIyqr-pSfj0F1YnDCzE5qDlD5Z3t3R7y39MnZ9hI
Message-ID: <CABBYNZLhJS6mMF-=yvofP+dkE2ayxGt=KtZLhdM7=n3aJ9r4zQ@mail.gmail.com>
Subject: Re: [RFC PATCH v9 1/2] Bluetooth: L2CAP: Keep credits from completing
 security upgrades
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Wed, Nov 11, 2026 at 9:30=E2=80=AFPM Kyle Pepper <cochcoder@proton.me> w=
rote:
>
> Retain LE and ECRED credits without sending queued data or resuming
> connected sockets while a security upgrade is pending. Guard the shared
> send path and deferred acceptance, and preserve the requested level.
>
> Finish pending upgrades from referenced connection work outside the
> security callback's list walk. Keep failures terminal across later
> confirmations and notify pending channels when local SMP pairing fails.
> Use a dedicated unbound queue so management replies can report failure
> while the device queue drains. Drain it before L2CAP exits and release
> it if socket initialization fails. Ignore detached or powered-down links.
>
> Serialize BT_SECURITY with SMP receive under the connection lock and
> with management failures under the device lock. Take the device,
> connection, channel and socket locks in order. Record a failure generatio=
n
> on each request so delayed failure work leaves newer requests alone.
> Publish the failing generation in the consumed atomic and compare request
> generations with signed subtraction. Skip zero when the counter wraps.
> Keep EBUSY for channels with their own upgrade already pending.
>
> HCI confirmations describe the current ACL link. A failed encryption even=
t
> can disconnect it, so pending requests still fail regardless of their
> local SMP generation. The powered-down check is advisory; HCI separately
> guards transmit admission while draining and flushes connections on close=
.
>
> Check every deferred ECRED sibling before responding. Reject the whole
> batch on failure even if a child has already become BT_CONNECTED while
> waiting for the response. Include a zero destination CID for each refused
> channel. Close rejected children under a temporary reference, using child
> socket lock nesting, so unaccepted sockets release their ownership.
> Normal incoming ECRED channels enter BT_CONNECT2 only with deferred setup=
.
> For a synthetic child without that flag or an identifier, delete locally;
> there is no pending deferred response to send. Choose this fallback befor=
e
> batch handling, avoiding a channel read after rejected children close.
>
> Wake deferred sockets after successful security even with no initial
> credits. Consume and return deferred batch errors. Preserve a pending
> security rejection through teardown without masking unrelated socket
> errors, and clear security and suspension state when removing a channel.

This patch is bad; it mixes several things, introduces yet another
workqueue and causes l2cap-tester to fail.

> Assisted-by: LLM
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
> v9: copy options before locking; reject failed deferred batches before
> resume. Rebase on current bluetooth-next, preserving the short security
> option ABI and MIC requirements introduced by EKS support.
> Previous v8: https://lore.kernel.org/linux-bluetooth/20261107071634.22370=
59-1-cochcoder@proton.me/
>
> CI checker repair: https://lore.kernel.org/linux-bluetooth/20261112022417=
.185349-1-cochcoder@proton.me/
> CI tester repair: https://lore.kernel.org/linux-bluetooth/20261112022508.=
185512-1-cochcoder@proton.me/
>
>  include/net/bluetooth/l2cap.h |   7 +
>  net/bluetooth/l2cap_core.c    | 235 ++++++++++++++++++++++++++++++++--
>  net/bluetooth/l2cap_sock.c    | 176 ++++++++++++++++---------
>  net/bluetooth/smp.c           |   1 +
>  4 files changed, 347 insertions(+), 72 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index cf5c2df68..ce5c21f43 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -620,6 +620,7 @@ struct l2cap_chan {
>         void                    *data;
>         const struct l2cap_ops  *ops;
>         struct mutex            lock;
> +       unsigned int            security_generation;
>  };
>
>  struct l2cap_conn {
> @@ -645,6 +646,9 @@ struct l2cap_conn {
>         struct sk_buff_head     pending_rx;
>         struct work_struct      pending_rx_work;
>         bool                    pending_rx_blocked __guarded_by(&lock);
> +       struct work_struct      security_work;
> +       atomic_t                security_failed;
> +       atomic_t                security_generation;
>
>         struct delayed_work     id_addr_timer;
>
> @@ -767,6 +771,8 @@ enum {
>         FLAG_ECRED_CONN_REQ_SENT,
>         FLAG_ECRED_RECONF_REQ_SENT,
>         FLAG_PENDING_SECURITY,
> +       FLAG_SECURITY_CFM,
> +       FLAG_SECURITY_FAILED,
>         FLAG_HOLD_HCI_CONN,
>         FLAG_DEL,
>  };
> @@ -993,6 +999,7 @@ void l2cap_chan_busy(struct l2cap_chan *chan, int bus=
y);
>  void l2cap_chan_rx_avail(struct l2cap_chan *chan, ssize_t rx_avail);
>  void l2cap_chan_req_mic_len(struct l2cap_chan *chan, struct hci_conn *hc=
on);
>  int l2cap_chan_check_security(struct l2cap_chan *chan, bool initiator);
> +void l2cap_security_failed(struct l2cap_conn *conn);
>  void l2cap_chan_set_defaults(struct l2cap_chan *chan, struct l2cap_chan =
*pchan);
>  int l2cap_ertm_init(struct l2cap_chan *chan);
>  void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 09ff32394..8a2a99084 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -59,6 +59,8 @@ static void l2cap_tx(struct l2cap_chan *chan, struct l2=
cap_ctrl *control,
>  static void l2cap_retrans_timeout(struct work_struct *work);
>  static void l2cap_monitor_timeout(struct work_struct *work);
>  static void l2cap_ack_timeout(struct work_struct *work);
> +static void l2cap_security_work(struct work_struct *work);
> +static struct workqueue_struct *l2cap_security_wq;
>  static void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
>         __must_hold(&chan->lock) __must_hold(&chan->conn->lock);
>
> @@ -705,11 +707,14 @@ void l2cap_chan_del(struct l2cap_chan *chan, int er=
r)
>         lockdep_assert(!chan->conn || lockdep_is_held(&chan->conn->lock))=
;
>
>         __clear_chan_timer(chan);
> +       clear_bit(FLAG_PENDING_SECURITY, &chan->flags);
> +       clear_bit(FLAG_SECURITY_CFM, &chan->flags);
>
>         BT_DBG("chan %p, err %d, state %s", chan, err,
>                state_to_string(chan->state));
>
>         chan->ops->teardown(chan, err);
> +       clear_bit(FLAG_SECURITY_FAILED, &chan->flags);
>
>         if (!test_and_set_bit(FLAG_DEL, &chan->flags)) {
>                 /* Delete from channel list */
> @@ -877,6 +882,13 @@ static void __l2cap_chan_close(struct l2cap_chan *ch=
an, int reason)
>
>         case BT_CONNECTED:
>         case BT_CONFIG:
> +               if (chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL && chan->ide=
nt &&
> +                   test_bit(FLAG_DEFER_SETUP, &chan->flags) &&
> +                   !test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags)) {
> +                       l2cap_chan_ecred_connect_reject(chan);
> +                       break;
> +               }
> +
>                 if (chan->chan_type =3D=3D L2CAP_CHAN_CONN_ORIENTED) {
>                         __set_chan_timer(chan, chan->ops->get_sndtimeo(ch=
an));
>                         l2cap_send_disconn_req(chan, reason);
> @@ -894,7 +906,11 @@ static void __l2cap_chan_close(struct l2cap_chan *ch=
an, int reason)
>                                         l2cap_chan_le_connect_reject(chan=
);
>                                         break;
>                                 case L2CAP_MODE_EXT_FLOWCTL:
> -                                       l2cap_chan_ecred_connect_reject(c=
han);
> +                                       if (chan->ident &&
> +                                           test_bit(FLAG_DEFER_SETUP, &c=
han->flags))
> +                                               l2cap_chan_ecred_connect_=
reject(chan);
> +                                       else
> +                                               l2cap_chan_del(chan, reas=
on);
>                                         return;
>                                 }
>                         }
> @@ -2711,6 +2727,9 @@ static void l2cap_le_flowctl_send(struct l2cap_chan=
 *chan)
>
>         BT_DBG("chan %p", chan);
>
> +       if (test_bit(FLAG_PENDING_SECURITY, &chan->flags))
> +               return;
> +
>         while (chan->tx_credits && !skb_queue_empty(&chan->tx_q)) {
>                 l2cap_do_send(chan, skb_dequeue(&chan->tx_q));
>                 chan->tx_credits--;
> @@ -4043,8 +4062,13 @@ static void l2cap_ecred_list_defer(struct l2cap_ch=
an *chan, void *data)
>  {
>         int *result =3D data;
>
> -       if (*result || test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
> +       if (*result < 0 || test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flag=
s))
> +               return;
> +
> +       if (test_bit(FLAG_SECURITY_FAILED, &chan->flags)) {
> +               *result =3D -ECONNREFUSED;
>                 return;
> +       }
>
>         switch (chan->state) {
>         case BT_CONNECT2:
> @@ -4052,6 +4076,8 @@ static void l2cap_ecred_list_defer(struct l2cap_cha=
n *chan, void *data)
>                 (*result)++;
>                 return;
>         case BT_CONNECTED:
> +               if (test_bit(FLAG_PENDING_SECURITY, &chan->flags))
> +                       (*result)++;
>                 return;
>         default:
>                 /* If not connected or pending accept it has been refused=
 */
> @@ -4140,10 +4166,16 @@ static void l2cap_ecred_rsp_defer(struct l2cap_ch=
an *chan, void *data)
>                 rsp->pdu.rsp.result =3D cpu_to_le16(L2CAP_CR_LE_NO_MEM);
>
>         /* Include all channels pending with the same ident */
> -       if (!rsp->pdu.rsp.result)
> +       if (!rsp->pdu.rsp.result) {
>                 rsp_flex->dcid[rsp->count++] =3D cpu_to_le16(chan->scid);
> -       else
> -               l2cap_chan_del(chan, ECONNRESET);
> +       } else {
> +               if (rsp->count < ARRAY_SIZE(rsp->pdu.scid))
> +                       rsp_flex->dcid[rsp->count++] =3D 0;
> +               l2cap_chan_del(chan, rsp->pdu.rsp.result =3D=3D
> +                             cpu_to_le16(L2CAP_CR_LE_AUTHORIZATION) ?
> +                             ECONNREFUSED : ECONNRESET);
> +               chan->ops->close(chan);
> +       }
>
>  done:
>         if (locked)
> @@ -5464,6 +5496,11 @@ static inline int l2cap_le_credits(struct l2cap_co=
nn *conn,
>
>         l2cap_chan_lock(chan);
>
> +       if (chan->state !=3D BT_CONNECTED ||
> +           (chan->mode !=3D L2CAP_MODE_LE_FLOWCTL &&
> +            chan->mode !=3D L2CAP_MODE_EXT_FLOWCTL))
> +               goto unlock;
> +
>         max_credits =3D LE_FLOWCTL_MAX_CREDITS - chan->tx_credits;
>         if (credits > max_credits) {
>                 BT_ERR("LE credits overflow");
> @@ -5477,6 +5514,9 @@ static inline int l2cap_le_credits(struct l2cap_con=
n *conn,
>
>         chan->tx_credits +=3D credits;
>
> +       if (test_bit(FLAG_PENDING_SECURITY, &chan->flags))
> +               goto unlock;
> +
>         /* Resume sending */
>         l2cap_le_flowctl_send(chan);
>
> @@ -7618,6 +7658,8 @@ static struct l2cap_conn *l2cap_conn_add(struct hci=
_conn *hcon)
>
>         skb_queue_head_init(&conn->pending_rx);
>         INIT_WORK(&conn->pending_rx_work, process_pending_rx);
> +       INIT_WORK(&conn->security_work, l2cap_security_work);
> +       atomic_set(&conn->security_failed, 0);
>         INIT_DELAYED_WORK(&conn->id_addr_timer, l2cap_conn_update_id_addr=
);
>
>         conn->disc_reason =3D HCI_ERROR_REMOTE_USER_TERM;
> @@ -8070,6 +8112,128 @@ static inline void l2cap_check_encryption(struct =
l2cap_chan *chan, u8 encrypt)
>         }
>  }
>
> +static void l2cap_queue_security(struct l2cap_conn *conn)
> +{
> +       l2cap_conn_get(conn);
> +       /* Management process replies can fail SMP while the device queue=
 drains;
> +        * this work cannot depend on admission to that draining queue.
> +        */
> +       if (!queue_work(l2cap_security_wq, &conn->security_work))
> +               l2cap_conn_put(conn);
> +}
> +
> +void l2cap_security_failed(struct l2cap_conn *conn)
> +{
> +       unsigned int generation;
> +
> +       if (conn->hcon->type !=3D LE_LINK)
> +               return;
> +
> +       /* SMP producers serialize on the fixed channel lock. */
> +       lockdep_assert_held(&conn->smp->lock);
> +
> +       /* Zero means no failure queued, including after generation wrap.=
 */
> +       generation =3D atomic_inc_return(&conn->security_generation);
> +       if (!generation)
> +               generation =3D atomic_inc_return(&conn->security_generati=
on);
> +       atomic_set(&conn->security_failed, generation);
> +       l2cap_queue_security(conn);
> +}
> +
> +static void l2cap_security_work(struct work_struct *work)
> +{
> +       struct l2cap_conn *conn =3D container_of(work, struct l2cap_conn,
> +                                           security_work);
> +       struct hci_conn *hcon =3D conn->hcon;
> +       struct l2cap_chan *chan, *next;
> +       unsigned int generation;
> +
> +       hci_dev_lock(hcon->hdev);
> +       /* HCI_UP is advisory; device close flushes connections after cle=
aring it.
> +        * TX admission during drain is guarded separately by hci_sched_t=
x().
> +        */
> +       if (hcon->l2cap_data !=3D conn || !test_bit(HCI_UP, &hcon->hdev->=
flags))
> +               goto done;
> +
> +       mutex_lock(&conn->lock);
> +
> +       generation =3D atomic_xchg(&conn->security_failed, 0);
> +       if (generation) {
> +               list_for_each_entry(chan, &conn->chan_l, list) {
> +                       l2cap_chan_lock(chan);
> +                       if ((chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
> +                            chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) &&
> +                           test_bit(FLAG_PENDING_SECURITY, &chan->flags)=
 &&
> +                           (s32)(generation - chan->security_generation)=
 > 0) {
> +                               set_bit(FLAG_SECURITY_FAILED, &chan->flag=
s);
> +                               set_bit(FLAG_SECURITY_CFM, &chan->flags);
> +                       }
> +                       l2cap_chan_unlock(chan);
> +               }
> +       }
> +
> +       for (;;) {
> +               chan =3D NULL;
> +               list_for_each_entry(next, &conn->chan_l, list) {
> +                       if (test_and_clear_bit(FLAG_SECURITY_CFM, &next->=
flags)) {
> +                               chan =3D next;
> +                               break;
> +                       }
> +               }
> +               if (!chan)
> +                       break;
> +
> +               /* Batch rejection may delete siblings, so restart the wa=
lk. */
> +               l2cap_chan_hold(chan);
> +               l2cap_chan_lock(chan);
> +               lockdep_assert_held(&chan->conn->lock);
> +               if (!test_bit(FLAG_PENDING_SECURITY, &chan->flags) ||
> +                   (chan->state !=3D BT_CONNECTED && chan->state !=3D BT=
_CONFIG &&
> +                    chan->state !=3D BT_CONNECT2))
> +                       goto next;
> +
> +               if (test_bit(FLAG_SECURITY_FAILED, &chan->flags) ||
> +                   !test_bit(HCI_CONN_ENCRYPT, hcon->flags) ||
> +                   !smp_sufficient_security(hcon, chan->sec_level, SMP_A=
LLOW_STK) ||
> +                   !l2cap_check_enc_key_size(hcon, chan) ||
> +                   !l2cap_check_mic_len(hcon, chan)) {
> +                       set_bit(FLAG_SECURITY_FAILED, &chan->flags);
> +                       __l2cap_chan_close(chan, ECONNREFUSED);
> +                       chan->ops->close(chan);
> +                       goto next;
> +               }
> +
> +               clear_bit(FLAG_PENDING_SECURITY, &chan->flags);
> +               chan->sec_level =3D hcon->sec_level;
> +
> +               if (chan->state =3D=3D BT_CONNECT2) {
> +                       chan->ops->resume(chan);
> +                       goto next;
> +               }
> +
> +               if (chan->state =3D=3D BT_CONNECTED &&
> +                   chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL &&
> +                   test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
> +                       __l2cap_ecred_conn_rsp_defer(chan);
> +                       if (test_bit(FLAG_DEL, &chan->flags))
> +                               goto next;
> +               }
> +
> +               l2cap_le_flowctl_send(chan);
> +               if (chan->tx_credits)
> +                       chan->ops->resume(chan);
> +               l2cap_check_encryption(chan, 1);
> +next:
> +               l2cap_chan_unlock(chan);
> +               l2cap_chan_put(chan);
> +       }
> +
> +       mutex_unlock(&conn->lock);
> +done:
> +       hci_dev_unlock(hcon->hdev);
> +       l2cap_conn_put(conn);
> +}
> +
>  static void l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encr=
ypt)
>         __must_hold(&hcon->hdev->lock)
>  {
> @@ -8084,6 +8248,8 @@ static void l2cap_security_cfm(struct hci_conn *hco=
n, u8 status, u8 encrypt)
>         mutex_lock(&conn->lock);
>
>         list_for_each_entry(chan, &conn->chan_l, list) {
> +               bool le_flowctl, pending_le;
> +
>                 l2cap_chan_lock(chan);
>
>                 lockdep_assert_held(&chan->conn->lock);
> @@ -8091,7 +8257,13 @@ static void l2cap_security_cfm(struct hci_conn *hc=
on, u8 status, u8 encrypt)
>                 BT_DBG("chan %p scid 0x%4.4x state %s", chan, chan->scid,
>                        state_to_string(chan->state));
>
> -               if (!status && encrypt)
> +               le_flowctl =3D hcon->type =3D=3D LE_LINK &&
> +                            (chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
> +                             chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL);
> +               pending_le =3D le_flowctl &&
> +                            test_bit(FLAG_PENDING_SECURITY, &chan->flags=
);
> +
> +               if (!status && encrypt && !pending_le)
>                         chan->sec_level =3D hcon->sec_level;
>
>                 if (!__l2cap_no_conn_pending(chan)) {
> @@ -8099,9 +8271,49 @@ static void l2cap_security_cfm(struct hci_conn *hc=
on, u8 status, u8 encrypt)
>                         continue;
>                 }
>
> +               /* HCI reports the current link state. Encryption failure=
 can
> +                * disconnect that link, regardless of the SMP request ge=
neration.
> +                */
> +               if (pending_le && (chan->state =3D=3D BT_CONNECTED ||
> +                                  chan->state =3D=3D BT_CONFIG ||
> +                                  chan->state =3D=3D BT_CONNECT2)) {
> +                       if (status || !encrypt ||
> +                           !smp_sufficient_security(hcon, chan->sec_leve=
l,
> +                                                   SMP_ALLOW_STK) ||
> +                           !l2cap_check_enc_key_size(hcon, chan) ||
> +                           !l2cap_check_mic_len(hcon, chan)) {
> +                               set_bit(FLAG_SECURITY_FAILED, &chan->flag=
s);
> +                       }
> +                       set_bit(FLAG_SECURITY_CFM, &chan->flags);
> +                       l2cap_queue_security(conn);
> +                       l2cap_chan_unlock(chan);
> +                       continue;
> +               }
> +
>                 if (!status && (chan->state =3D=3D BT_CONNECTED ||
>                                 chan->state =3D=3D BT_CONFIG)) {
> -                       chan->ops->resume(chan);
> +                       /* A deferred multi-channel ECRED connection may =
have
> +                        * released one accepted channel into BT_CONNECTE=
D while
> +                        * its batch still shares an ident with pending s=
iblings.
> +                        * Its security-failure close rejects that whole =
batch and
> +                        * unlinks those channels from conn->chan_l; do n=
ot run it
> +                        * directly while this traversal holds chan and t=
he list.
> +                        */
> +                       if (chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL && c=
han->ident &&
> +                           test_bit(FLAG_DEFER_SETUP, &chan->flags) &&
> +                           !test_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->fl=
ags) &&
> +                           (chan->sec_level =3D=3D BT_SECURITY_HIGH ||
> +                            chan->sec_level =3D=3D BT_SECURITY_FIPS) &&
> +                           !encrypt) {
> +                               set_bit(FLAG_PENDING_SECURITY, &chan->fla=
gs);
> +                               set_bit(FLAG_SECURITY_FAILED, &chan->flag=
s);
> +                               set_bit(FLAG_SECURITY_CFM, &chan->flags);
> +                               l2cap_queue_security(conn);
> +                               l2cap_chan_unlock(chan);
> +                               continue;
> +                       }
> +                       if (!le_flowctl || chan->tx_credits)
> +                               chan->ops->resume(chan);
>                         l2cap_check_encryption(chan, encrypt);
>                         l2cap_chan_unlock(chan);
>                         continue;
> @@ -8430,9 +8642,15 @@ int __init l2cap_init(void)
>  {
>         int err;
>
> +       l2cap_security_wq =3D alloc_workqueue("l2cap_sec", WQ_UNBOUND, 0)=
;
> +       if (!l2cap_security_wq)
> +               return -ENOMEM;
> +
>         err =3D l2cap_init_sockets();
> -       if (err < 0)
> +       if (err < 0) {
> +               destroy_workqueue(l2cap_security_wq);
>                 return err;
> +       }
>
>         hci_register_cb(&l2cap_cb);
>
> @@ -8449,6 +8667,7 @@ void l2cap_exit(void)
>  {
>         debugfs_remove(l2cap_debugfs);
>         hci_unregister_cb(&l2cap_cb);
> +       destroy_workqueue(l2cap_security_wq);
>         l2cap_cleanup_sockets();
>  }
>
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 400c167a9..8c63610f1 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -929,12 +929,59 @@ static int l2cap_set_mode(struct l2cap_chan *chan, =
u8 mode)
>         return 0;
>  }
>
> +static int l2cap_sock_set_security(struct sock *sk, struct l2cap_chan *c=
han,
> +                                  const struct bt_security *sec)
> +       __must_hold(&chan->lock)
> +{
> +       struct l2cap_conn *conn;
> +
> +       conn =3D l2cap_chan_conn(chan);
> +       if ((chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
> +            chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) &&
> +           test_bit(FLAG_PENDING_SECURITY, &chan->flags))
> +               return -EBUSY;
> +
> +       chan->sec_level =3D sec->level;
> +       chan->mic_len =3D sec->mic_len;
> +       if (!conn)
> +               return 0;
> +
> +       lockdep_assert_held(&conn->lock);
> +       lockdep_assert_held(&conn->hcon->hdev->lock);
> +       chan->security_generation =3D atomic_read(&conn->security_generat=
ion);
> +
> +       if (chan->scid =3D=3D L2CAP_CID_ATT) {
> +               l2cap_chan_req_mic_len(chan, conn->hcon);
> +               if (smp_conn_security(conn->hcon, sec->level))
> +                       return -EINVAL;
> +
> +               set_bit(FLAG_PENDING_SECURITY, &chan->flags);
> +               sk->sk_state =3D BT_CONFIG;
> +               chan->state =3D BT_CONFIG;
> +       } else if ((sk->sk_state =3D=3D BT_CONNECT2 &&
> +                   test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) ||
> +                  sk->sk_state =3D=3D BT_CONNECTED) {
> +               if (!l2cap_chan_check_security(chan, true)) {
> +                       if (conn->hcon->type =3D=3D LE_LINK &&
> +                           (chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
> +                            chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL))
> +                               set_bit(FLAG_PENDING_SECURITY, &chan->fla=
gs);
> +                       set_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
> +               } else {
> +                       sk->sk_state_change(sk);
> +               }
> +       } else {
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static int l2cap_sock_setsockopt(struct socket *sock, int level, int opt=
name,
>                                  sockptr_t optval, unsigned int optlen)
>  {
>         struct sock *sk =3D sock->sk;
>         struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
> -       struct bt_security sec;
>         struct bt_power pwr;
>         struct l2cap_conn *conn;
>         int err =3D 0;
> @@ -950,79 +997,62 @@ static int l2cap_sock_setsockopt(struct socket *soc=
k, int level, int optname,
>         if (level !=3D SOL_BLUETOOTH)
>                 return -ENOPROTOOPT;
>
> -       l2cap_chan_lock(chan);
> -       lock_sock(sk);
> +       if (optname =3D=3D BT_SECURITY) {
> +               struct bt_security sec =3D { .level =3D BT_SECURITY_LOW }=
;
> +               bool have_conn;
>
> -       switch (optname) {
> -       case BT_SECURITY:
>                 if (chan->chan_type !=3D L2CAP_CHAN_CONN_ORIENTED &&
>                     chan->chan_type !=3D L2CAP_CHAN_FIXED &&
> -                   chan->chan_type !=3D L2CAP_CHAN_RAW) {
> -                       err =3D -EINVAL;
> -                       break;
> -               }
> +                   chan->chan_type !=3D L2CAP_CHAN_RAW)
> +                       return -EINVAL;
>
> -               /* mic_len was added at the end of struct bt_security, so
> -                * accept the shorter struct as well, leaving mic_len uns=
et.
> -                */
> -               if (optlen < offsetofend(struct bt_security, key_size)) {
> -                       err =3D -EINVAL;
> -                       break;
> -               }
> +               /* Keep accepting the struct size used before mic_len was=
 added. */
> +               if (optlen < offsetofend(struct bt_security, key_size))
> +                       return -EINVAL;
>
> -               err =3D copy_struct_from_sockptr(&sec, sizeof(sec), optva=
l,
> -                                              optlen);
> +               err =3D copy_struct_from_sockptr(&sec, sizeof(sec), optva=
l, optlen);
>                 if (err)
> -                       break;
> -
> -               if (sec.level < BT_SECURITY_LOW ||
> -                   sec.level > BT_SECURITY_FIPS) {
> -                       err =3D -EINVAL;
> -                       break;
> -               }
> +                       return err;
>
> -               /* BLUETOOTH CORE SPECIFICATION Version 7.0 | Vol 4,
> -                * Part E, Section 7.7.8: MIC_Length 0x00 is 32 bits,
> -                * 0x01 is 64 bits and 0x02 is 128 bits; all other
> -                * values are reserved for future use.
> -                */
> -               if (sec.mic_len > 0x02) {
> -                       err =3D -EINVAL;
> -                       break;
> -               }
> +               if (sec.level < BT_SECURITY_LOW || sec.level > BT_SECURIT=
Y_FIPS)
> +                       return -EINVAL;
>
> -               chan->sec_level =3D sec.level;
> -               chan->mic_len =3D sec.mic_len;
> +               /* MIC length encodings 0, 1 and 2 mean 32, 64 and 128 bi=
ts. */
> +               if (sec.mic_len > 0x02)
> +                       return -EINVAL;
>
> +               l2cap_chan_lock(chan);
>                 conn =3D l2cap_chan_conn(chan);
> -               if (!conn)
> -                       break;
> +               if (!conn) {
> +                       lock_sock(sk);
> +                       err =3D l2cap_sock_set_security(sk, chan, &sec);
> +                       release_sock(sk);
> +                       l2cap_chan_unlock(chan);
> +                       return err;
> +               }
> +               l2cap_conn_get(conn);
> +               l2cap_chan_unlock(chan);
>
> -               /* change security for LE channels */
> -               if (chan->scid =3D=3D L2CAP_CID_ATT) {
> -                       l2cap_chan_req_mic_len(chan, conn->hcon);
> -                       if (smp_conn_security(conn->hcon, sec.level)) {
> -                               err =3D -EINVAL;
> -                               break;
> -                       }
> +               /* SMP receive holds conn->lock; management holds hdev->l=
ock. */
> +               hci_dev_lock(conn->hcon->hdev);
> +               have_conn =3D l2cap_chan_lock_conn(chan);
>
> -                       set_bit(FLAG_PENDING_SECURITY, &chan->flags);
> -                       sk->sk_state =3D BT_CONFIG;
> -                       chan->state =3D BT_CONFIG;
> +               lock_sock(sk);
> +               if (l2cap_chan_conn(chan) !=3D conn)
> +                       err =3D -ENOTCONN;
> +               else
> +                       err =3D l2cap_sock_set_security(sk, chan, &sec);
> +               release_sock(sk);
> +               l2cap_chan_unlock_conn(chan, have_conn);
> +               hci_dev_unlock(conn->hcon->hdev);
> +               l2cap_conn_put(conn);
> +               return err;
> +       }
>
> -               /* or for ACL link */
> -               } else if ((sk->sk_state =3D=3D BT_CONNECT2 &&
> -                           test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags=
)) ||
> -                          sk->sk_state =3D=3D BT_CONNECTED) {
> -                       if (!l2cap_chan_check_security(chan, true))
> -                               set_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags)=
;
> -                       else
> -                               sk->sk_state_change(sk);
> -               } else {
> -                       err =3D -EINVAL;
> -               }
> -               break;
> +       l2cap_chan_lock(chan);
> +       lock_sock(sk);
>
> +       switch (optname) {
>         case BT_DEFER_SETUP:
>                 if (sk->sk_state !=3D BT_BOUND && sk->sk_state !=3D BT_LI=
STEN) {
>                         err =3D -EINVAL;
> @@ -1284,11 +1314,23 @@ static int l2cap_sock_defer(struct sock *sk)
>                 if (!have_conn) {
>                         release_sock(sk);
>                         err =3D -ENOTCONN;
> +               } else if ((chan->mode =3D=3D L2CAP_MODE_LE_FLOWCTL ||
> +                           chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) &&
> +                          test_bit(FLAG_PENDING_SECURITY, &chan->flags))=
 {
> +                       release_sock(sk);
> +                       err =3D -EAGAIN;
>                 } else if (chan->mode =3D=3D L2CAP_MODE_EXT_FLOWCTL) {
>                         sk->sk_state =3D BT_CONNECTED;
>                         chan->state =3D BT_CONNECTED;
>                         release_sock(sk);
>                         __l2cap_ecred_conn_rsp_defer(chan);
> +                       lock_sock(sk);
> +                       if (sk->sk_state =3D=3D BT_CLOSED) {
> +                               err =3D sock_error(sk);
> +                               if (!err)
> +                                       err =3D -ECONNRESET;
> +                       }
> +                       release_sock(sk);
>                 } else if (bdaddr_type_is_le(chan->src_type)) {
>                         sk->sk_state =3D BT_CONNECTED;
>                         chan->state =3D BT_CONNECTED;
> @@ -1393,7 +1435,7 @@ static void l2cap_sock_kill(struct sock *sk)
>         /* Take lock to synchronize against access without owning sk->sk_=
socket,
>          * eg. in l2cap_sock_cleanup_listen(). proto_ops etc. don't need =
lock.
>          */
> -       lock_sock(sk);
> +       lock_sock_nested(sk, L2CAP_NESTING_NORMAL);
>         l2cap_sock_put_chan(sk);
>         release_sock(sk);
>
> @@ -1758,6 +1800,7 @@ static void l2cap_sock_teardown_cb(struct l2cap_cha=
n *chan, int err)
>         lock_sock_nested(sk, atomic_read(&chan->nesting));
>
>         parent =3D bt_sk(sk)->parent;
> +       clear_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
>
>         switch (chan->state) {
>         case BT_OPEN:
> @@ -1774,7 +1817,9 @@ static void l2cap_sock_teardown_cb(struct l2cap_cha=
n *chan, int err)
>                 sk->sk_state =3D BT_CLOSED;
>                 chan->state =3D BT_CLOSED;
>
> -               sk->sk_err =3D err;
> +               if (!test_bit(FLAG_SECURITY_FAILED, &chan->flags) ||
> +                   READ_ONCE(sk->sk_err) !=3D ECONNREFUSED)
> +                       WRITE_ONCE(sk->sk_err, err);
>
>                 if (parent) {
>                         /*
> @@ -1810,8 +1855,11 @@ static void l2cap_sock_state_change_cb(struct l2ca=
p_chan *chan, int state,
>
>         sk->sk_state =3D state;
>
> -       if (err)
> -               sk->sk_err =3D err;
> +       if (err) {
> +               WRITE_ONCE(sk->sk_err, err);
> +               clear_bit(BT_SK_SUSPEND, &bt_sk(sk)->flags);
> +               sk->sk_state_change(sk);
> +       }
>
>         release_sock(sk);
>  }
> diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
> index f8f86b8f7..0c52a819d 100644
> --- a/net/bluetooth/smp.c
> +++ b/net/bluetooth/smp.c
> @@ -785,6 +785,7 @@ static void smp_failure(struct l2cap_conn *conn, u8 r=
eason)
>                              &reason);
>
>         mgmt_auth_failed(hcon, HCI_ERROR_AUTH_FAILURE);
> +       l2cap_security_failed(conn);
>
>         if (chan->data)
>                 smp_chan_destroy(conn);
>


--=20
Luiz Augusto von Dentz
