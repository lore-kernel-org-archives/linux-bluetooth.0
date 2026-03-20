Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E8D3BBA16
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 14:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015209; cv=pass; b=RKNIcPQoVb2iKsq7q6rno3W/mvB9sopzOSgaC0+PBQJ4pZFMV0W/9RHH1H8KaRC0KwVtPYGN5/pd9VqDac0jckkP1bPePC0YsAMsMciJCt0H+kU59ZupDzI3vfWmrAIsLqNNzDwrJe5M1Q2KQsT3urdGKfmYiWPVAdqYpZJ0kEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015209; c=relaxed/simple;
	bh=SXKYz3VDv8TKDUnwL3YYc25AC4oGQyXpui046etb3ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfhDAX98E10eunKMleqBz2v0EjTMwW/xAEmHukKJwtj1AvLpIGjmYo8xNUXsnaF+ohUMp9LmIXw3LLg5e+pxoJNgFpMzwy1ELT/hGB1AtoxQHRW9rr9iSw4nVVm8M0hlFK9MkWpJjDHsfRzaPjcL65QDFBoZ43nmwr1Ajod+JTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJBNDT5g; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJBNDT5g"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64c9a6d7f81so579665d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 07:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774015201; cv=none;
        d=google.com; s=arc-20240605;
        b=VRSMOldfBfztlky2P/wGDf/v+aFlLkar95kilsTudg4/90nH4iqH1VLvIn5L0wPba4
         ivl94cGaWpt2u8nMM9b/aMdtQiQA1CWvTzIf3ZAH3U6EsLLZ6r2adUJeNmSr5uKQ8CpS
         Qxfb23e7Qgcu9SiwMzPYiJQb7t+gzjBT5/zjaHTUvs7bf5AmpQ31trrreWeo+P31RbOF
         z/TGAKK4VmPbQKiMSzItp1Xzms+dIFDt7DjdAgqw2hJ4V62uPTVK58ldVjPq+sE9CIx/
         5MgX1HQLhDi1p/5Zivv7tGReTWzk9Q58kh+yTFAHRdDvoR9VHh7IdDPsYx3Z5cCVOPV0
         ZGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KQ9jLGOSl8+l27j5Vz4ediKGfPfCRBzhCYelPhQqizo=;
        fh=tU9MxSekwlnkVe/kwsuL5HsnmCLxauicOHjxRvS138U=;
        b=hT0tIzajv9/bTu7ltM87PSGPgMgvfw6RnBR5eZtvE7DNCyUmjPGu1RJlodFZ3HjDB4
         tABHGVLitrQ6eTH7LqANzwId9iGyqQ0IFQ7A50u35CWUXxQFD9aqQHG4T2h4eoh0waE9
         bq64ZV2/uz5MR9GQ69BJtAVJbR/JkXoCRexih8PuTyA5OE9ETtcFF6flLEjxfNG8KvB5
         DncI694FkjLgJfgSA+m8UbhalO16DXHhXneOvviNaOQ+JwtErT3OSCCPJbLNho+nXlpn
         9igNQaY+dhKE7iBTyiq6xBX9KBmst9xNG18izMvvDrhzponKN1I+9EpHog5O86usUXOr
         +IKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774015201; x=1774620001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQ9jLGOSl8+l27j5Vz4ediKGfPfCRBzhCYelPhQqizo=;
        b=WJBNDT5gOAdzuz6Q38u2y2/qWB2B4qhVz1zBz3hjVhdKxqFv5Cp8E0DnyBS139azVp
         YB7Bb0W1PI1IHuO6OSowrwTetA5dblttBvQVGL7PkC2UnjVJLNuqxjwR7XF9hLf+PNKv
         1ErxuUi1EjQvfOsx2S78JXApuFMvFZgtYQokXM08wtEMxhLPuK9Hbqkd/nqGLJ2mhl1l
         2+AXVk8jMklAIz9vaPzJ3Y06S110Pl3p9aRnXGXm+PsXRRPgQnnK/GE/jLj6rNDVRHtq
         px1SWOtBB6+Rifh55YjcgT5/7gvuC2ZHRu/p96FKsIvO8jpqYW9JNknVN0j1icmD8W9/
         cBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774015201; x=1774620001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KQ9jLGOSl8+l27j5Vz4ediKGfPfCRBzhCYelPhQqizo=;
        b=gle8s7kvKFAC0UQ4fpdFjNaOBebBElNWdrvtkTvKhU/gu/A+pbvV/zpKGml7EeYVae
         ufO7RDOa9dry7nfV0/vhieS0RxOu9eZaPaiX3QMvJaosDPqrhzRZGH3rdKU1Uk21t+kg
         3ownze36YeFJB+IgGWrRuJ1MpZwF0PNK1wJ1Df3NBjNf4xL6IV2a9TafrHJc9CpHlUJf
         4b4l4ZhlY82t48mABiaQaKBwIOoJzJEcRTpdjYO3Lm4QL3bUs7iPr0Rcyfuok+pC6aCt
         WXFSAzzNX92V4p0MX0qhmKT0vU8++puvNukhR0BfSuAKmwxekap/PALJSVIOS1ohbqYu
         8x7w==
X-Forwarded-Encrypted: i=1; AJvYcCV1eaDEGdiWBWPPYvrc/VTPzIcrQvhQ8AFUv2x1TLkHn7Te/KptLG4sKZkf38ZNrNV3BOJHGQnrNw6WqDPlOHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzClLuGWra6EsRgQCr3iWB8cyOn0jSiloM/Vk7kkm3dKsP2iYxk
	9rk1wsO3oVJFvPdO3YOaZAo9DVITqJiIFrddoObJpzeOfRnr1KBWBFXMm2JicNidi0AhECTrkRC
	Ck4Tv6flEVMDyJzBhupCSTQVxrgtCuAn2+WP9
X-Gm-Gg: ATEYQzwZkNjC19u+j400cCW/j8rL5Iqas/uuUgbMQxE8+ErAbd02c9haBCIg3JxeO4N
	uFaIK5P0+n0+vyFNGDLnIs7N8rxeSg7W+j5HG9tqykO7RGDro5LkdgH5DWT2A9zdwowynmmS/mQ
	2XLxEQqxe39Em1bZbtGYSVB7iXKRoYIaSmzlnjwp/8h0i369Lp/5xVQ52R59gBXdMr9oddskEZ4
	4lGhehwR5JU301QQ1lMV5/oXrzrY384b4PHg5suLWMrXXz86BxX+SikrUf18N11CcRovWTVZ75+
	QQcibI59s+fYqJn4BM8qu8YYVhnvQdOZMjJz3lF7SJg/ZCykPsNzH9PyZzUI5a7QK/VB6A==
X-Received: by 2002:a53:b455:0:b0:64a:edf2:e769 with SMTP id
 956f58d0204a3-64eaa6b89e5mr2389426d50.10.1774015201249; Fri, 20 Mar 2026
 07:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab0yX61gGSlEaMEF@v4bel>
In-Reply-To: <ab0yX61gGSlEaMEF@v4bel>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 20 Mar 2026 09:59:50 -0400
X-Gm-Features: AaiRm51fzlYomGVBhl1hNn19OxuDsw9d_flO-noJj0Qt9B3TO9YEvZwsZBipF4U
Message-ID: <CABBYNZL0t9dvLcoxdAXCb37EdTU3+iEkpicSSz=w0iBJi5=P=w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix use-after-free in l2cap_chan_timeout
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hyunwoo,

On Fri, Mar 20, 2026 at 7:41=E2=80=AFAM Hyunwoo Kim <imv4bel@gmail.com> wro=
te:
>
> l2cap_chan_timeout() reads chan->conn without holding any lock and
> without taking a reference on the connection. If l2cap_conn_del()
> frees the connection concurrently, mutex_lock(&conn->lock) operates
> on freed memory. Additionally, the existing NULL check early return
> leaks the channel reference held by the timer.
>
> Fix the root cause by disabling channel timers when the channel is
> being destroyed. Use disable_delayed_work() in l2cap_chan_del() to
> prevent timers from being rearmed, and disable_delayed_work_sync()
> in l2cap_conn_del() to ensure running timer work has completed
> before the connection is freed.
>
> The sync cannot be done directly inside l2cap_chan_del() because it
> would deadlock in three independent ways: (1) l2cap_chan_timeout()
> can call l2cap_chan_close() -> l2cap_chan_del(), so syncing chan_timer
> would wait for itself; (2) callers hold conn->lock while
> l2cap_chan_timeout() acquires it; (3) callers hold chan->lock while
> the ERTM timer functions acquire it. Therefore, the sync is
> performed in l2cap_conn_del() after releasing conn->lock.
>
> Also fix the reference leak on the !conn early return path in
> l2cap_chan_timeout().
>
> Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
> Changes in v2:
> - Moved the fix from l2cap_chan_timeout() to l2cap_chan_del()/l2cap_conn_=
del() to address the root cause instead of adding locking in the callback
> - Used disable_delayed_work()/disable_delayed_work_sync() to prevent time=
r rearming and ensure completion, as suggested by Luiz
> - Applied the fix to all four channel timers (chan_timer, retrans_timer, =
monitor_timer, ack_timer)
> - Removed l2cap_conn_get()/l2cap_conn_put() and the lock reordering that =
caused a circular locking dependency in v1
> - v1: https://lore.kernel.org/all/abwSxg_C6n8Avid3@v4bel/
> ---
>  net/bluetooth/l2cap_core.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 5deb6c4f1e41..c08478e4512b 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -411,8 +411,10 @@ static void l2cap_chan_timeout(struct work_struct *w=
ork)
>
>         BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
>
> -       if (!conn)
> +       if (!conn) {
> +               l2cap_chan_put(chan);
>                 return;
> +       }
>
>         mutex_lock(&conn->lock);
>         /* __set_chan_timer() calls l2cap_chan_hold(chan) while schedulin=
g
> @@ -649,6 +651,11 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err=
)
>         struct l2cap_conn *conn =3D chan->conn;
>
>         __clear_chan_timer(chan);
> +       /* Prevent the timer from being rearmed since the channel is abou=
t
> +        * to be destroyed. Running timer work will be synced by
> +        * l2cap_conn_del() after releasing conn->lock.
> +        */
> +       disable_delayed_work(&chan->chan_timer);

Hmm, so we can't use the _sync version because it could be pending on
conn->lock while this could be called from l2cap_conn_del? I wonder if
we should clarify the comment or if we actually need to mark the
l2cap_chan as deleted/disconnected or something, perhaps via state,
also we may want to return something like -EINPROGRESS if a timer
could not be disabled which would indicate to the likes of
l2cap_conn_del that it need a cleanup.

>         BT_DBG("chan %p, conn %p, err %d, state %s", chan, conn, err,
>                state_to_string(chan->state));
> @@ -688,6 +695,10 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err=
)
>                 __clear_retrans_timer(chan);
>                 __clear_monitor_timer(chan);
>                 __clear_ack_timer(chan);
> +               /* Prevent the ERTM timers from being rearmed. */
> +               disable_delayed_work(&chan->retrans_timer);
> +               disable_delayed_work(&chan->monitor_timer);
> +               disable_delayed_work(&chan->ack_timer);


l2cap_clear_timer drops the reference if the timer was cancelled, so I
think we will need to check the return of disable as well, or create a
function like l2cap_disable_timer, that said Id return something to
indicate that l2cap_chan_del didn't cleanup everything.

>                 skb_queue_purge(&chan->srej_q);
>
> @@ -1742,6 +1753,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, i=
nt err)
>  {
>         struct l2cap_conn *conn =3D hcon->l2cap_data;
>         struct l2cap_chan *chan, *l;
> +       LIST_HEAD(del_list);
>
>         if (!conn)
>                 return;
> @@ -1780,7 +1792,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, i=
nt err)
>                 chan->ops->close(chan);
>
>                 l2cap_chan_unlock(chan);
> -               l2cap_chan_put(chan);

Let's populate the del_list only with channels that actually had a
pending timer.

> +               list_add_tail(&chan->list, &del_list);
>         }
>
>         if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
> @@ -1791,6 +1803,20 @@ static void l2cap_conn_del(struct hci_conn *hcon, =
int err)
>
>         hcon->l2cap_data =3D NULL;
>         mutex_unlock(&conn->lock);
> +
> +       /* Disable and sync-wait for any running channel timer work witho=
ut
> +        * holding conn->lock to avoid AB-BA deadlock with
> +        * l2cap_chan_timeout() which acquires conn->lock.
> +        */
> +       list_for_each_entry_safe(chan, l, &del_list, list) {
> +               disable_delayed_work_sync(&chan->chan_timer);
> +               disable_delayed_work_sync(&chan->retrans_timer);
> +               disable_delayed_work_sync(&chan->monitor_timer);
> +               disable_delayed_work_sync(&chan->ack_timer);
> +               list_del(&chan->list);
> +               l2cap_chan_put(chan);
> +       }

It might be better to place the disable sync-wait on
l2cap_chan_destroy then since l2cap_chan_del is not garanteed to do
it, which means l2cap_chan_put is not safe to be called with
conn->lock, but I guess it was never really safe since if we destroy
the chan while a timer is pending/running it would cause an UAF

>         l2cap_conn_put(conn);
>  }
>
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
