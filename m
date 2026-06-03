Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55717E0E8
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780492598; cv=pass; b=tgyRg7bwykXANDWHuX/FEPysKGiaZqRApmTNkEUHh7/FxiqLGR2K817WWU5xoHgpAKxSh6UtpHBGywUeCOCo0iId6yOrW8YrOmADeGLFY97ceRM3UL1+7LBsvAXKaC6Pgqr79UsXaNReBQ9+iQjO+WUm9oglvAl4Cy7oItPe8pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780492598; c=relaxed/simple;
	bh=cNaZRaYNVbotiqeftdh2tXUrfem/yMoXoFcICFrpdHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XzaGOg4FmlwegTofAxK6aHrG60mexTtP1d/whfnYMP51Yad/tPR5XlkTMobQexTvNAYeTYYC+aDFzeOL+n4ni1d++y4N6y+FOqFIGRQUWUxWzqbU3B7lNyqkZY/MxemGSzCsSBcilDkuB3BLpFuIorN5tHE3DQ9XfeTprCfou5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TfhniITx; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TfhniITx"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-137335bc3caso11288648c88.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jun 2026 06:16:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780492596; cv=none;
        d=google.com; s=arc-20240605;
        b=djEkot0P1kOVleZQZexdhWE+aXcyzOW1Cz9kIXsw5Q8Q0qP8odNxZi7Z6eIkphDipi
         kwNdkTG6gHsaeAzrOUiegWPBaoGUxax73gNtK2Z8R3eF5+9szVEw5wJ1pHE9LeIQgUNb
         X5ixHm2PrORgwcnZwuKq6+ou55iUi+/UUbTvQTjepUo6Zo1lt0F3QqZj18qYmYvNye+1
         DckFJFtOWjtZ/UK60aDnZN+/2QlJOiDBbhlxf8ll5fVnMh6J7N7trtGLfhOixdL2OeeQ
         tJlUyKL4aRUJVpgmvszQGU1w8St+rihcKH1JZQ03wpyhTZn+SmxNdCXJ1gj3jQPAiNLb
         0ApA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4/LDPLcAVwSR2b5SqhhCH6zmznY4YB2j1xPm1amo8J4=;
        fh=/guXn8Tp4E7lpHhXvN2ajLOyf2f3geg1SO/3q7RkUVk=;
        b=aysSUV6nN4GP/iV+SYQOqBq8PWwwOVKrYWUI+C//3g09ux1zrEGI0miE+8284PMwFA
         gZO3CUaXa0zls7GAmLOhnhPH2ja3CKGyTs76Y3Ku2RSVx9hUyqAH6dcKC4DhAHAgyIHw
         eiWC+ExBVxl2IXJTLhjvkvYooM5oQhn3mbgexx8HP+RICwTzmlNUKEwOH3x2hBRxHoG/
         /+jKPWvO+wm0L5MArpLegvxsdsL73CMpoV5FKzdGfsj+CNFxa7tK3V2vNJh1ve5QdEWl
         7JprJvDh4cUilWqBgWu6UTqaPq0n1wxACqn7fALs7tpwN+FQkjXV8T3hkKbsfcibXkON
         roRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780492596; x=1781097396; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4/LDPLcAVwSR2b5SqhhCH6zmznY4YB2j1xPm1amo8J4=;
        b=TfhniITx9arE3gc52cLV8v+4DGEHeBpYw1+8FECve8qjOrA9AZf8ZRgtAnZAQyEury
         YdD+F7RlGuuLrKNaNBZ3ep1mhZQPVq5n3p/bBlNIdSYFPHXXxQb5aiEYqVZe4iBeYMbT
         5ZpOYpaY2qXpVXvZCjnUYYeUByErBhmtK0juRJYCzyDYs/NGzuqmiU2YDakwCSWDyQze
         1fk7u/tRJfwUw7nkRfDDOn5sNNM/MgiVtu3n+CpyLDleS7e8bn1GehJmyqsUE5ItlwaO
         2UsPi6cWwg8/Ag+5QxbNNJ+DuwqhoaR1Esm46WSuHpx3Jy8Jhzv34sxd+Ac+lJpSEgzE
         BJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780492596; x=1781097396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/LDPLcAVwSR2b5SqhhCH6zmznY4YB2j1xPm1amo8J4=;
        b=M0Sj6L8IdyGqufGql5vtVlYBU0pp+Z9sc2J6/ZOHUutRP7C29xzKzYHkBAzonAcjoF
         YN9LUPhC+vG4DHwJTOr0hDTv0Rq+nagDwphXXt0tZKe5jvybA4r82xOinJB7UVyC/MNc
         ecI73iBxB7SNXnvwqoFgDoqnKzS1Osn6uoftakJZoJpErKJ5ukjEGYAQHmsrcHat1N6z
         9/K7Iyom6LL1yMVUA7keRQmeNZlajDm3coqhRySNDqKRRBkqlwIvEbFS7M0kas8SuvLO
         FNL6GavdQZiCO1JQropeCtnuyaJhMO0dSceZg2czIx8XsjGAsQj9asfYWlp3CYgKiHs/
         CxhQ==
X-Forwarded-Encrypted: i=1; AFNElJ8FrNp5nAaKBSa6rflWtYqm+HoeFPNcbF9XJTM9Gq3y1qT8XI++teNN8CKkde7SHkkj7XMvPBoKHg1GtKb8U68=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1qBX/Zc5YWbPKsd66UlShfb7iLtFGIDmwmLf3xe5C8J6dfUtX
	wqa9bY6RuO6n145GYOfy8Tosi0+jZkRk8Cow+ubq0MaeDaPFrQen5+yTLeBBpS3F4rGgPOAKczg
	+glXeNqM+8YDkPsy8Vc/Cg0dOD2Gn/mcj2huP6a4r
X-Gm-Gg: Acq92OGZJpJCnRIzPhTlFoPZlPJhZtTTCHMO5AbEVTRUzu078bRa/nJRizrU3/nlmgH
	+VlyVaWInQ2jRHYDGH8pjo5Uf3++xU6XKAqX4rmt636cFturCX4NWP4Yj8NibzLrqxhXxBkWsQs
	2Wn0SSWIdf8nJIowYXG/YAv8Djbz1TKYAsXD647HHhFlPOrMUeRojVxMK1ee0dLH2gdNB74AqPJ
	UV+TJkPQY7/PzM2IDeB8pcFi+Rqo3lvQyXZWlDDu6cbnhi/r2RQT5qVtJj3PCRo8uzLpcY1vqgP
	SQh6E1MZubnFYnSGeil1W0V+921mtL0V7Cov9idAZxA7My90
X-Received: by 2002:a05:7022:6181:b0:137:9399:fc59 with SMTP id
 a92af1059eb24-137f6bdcbf7mr1212301c88.21.1780492594934; Wed, 03 Jun 2026
 06:16:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603123111.2334409-1-elver@google.com>
In-Reply-To: <20260603123111.2334409-1-elver@google.com>
From: Marco Elver <elver@google.com>
Date: Wed, 3 Jun 2026 15:15:58 +0200
X-Gm-Features: AVHnY4KuQXD3HrTxoWO5Tnzvr7x3SwPaXBWTAYTMTTrqkVyWiOEkQnfudggFSok
Message-ID: <CANpmjNPQCx8rynFhOUfqgagP-KBh0pJsXz6PQt6G3LomdzVJYw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix UAF in l2cap_chan_timeout
To: elver@google.com
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kasan-dev@googlegroups.com, stable@vger.kernel.org, 
	Siwei Zhang <oss@fourdim.xyz>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jun 2026 at 14:31, Marco Elver <elver@google.com> wrote:
>
> l2cap_chan_timeout() accesses chan->conn without holding a reference to
> the connection object. If l2cap_conn_del() races and tears down the
> connection while the timer is waiting for locks, it can result in a
> use-after-free when the timer wakes up and attempts to acquire
> conn->lock:
>
> | BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
> | BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]
> | BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
> | BUG: KASAN: slab-use-after-free in mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
> | Write of size 8 at addr ffff8881298d9550 by task kworker/2:1/83
> |
> | CPU: 2 UID: 0 PID: 83 Comm: kworker/2:1 Not tainted 7.1.0-rc6-next-20260601-dirty #6 PREEMPT(full)
> | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> | Workqueue: events l2cap_chan_timeout
> | Call Trace:
> |  <TASK>
> |  instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
> |  atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]
> |  __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
> |  mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
> |  l2cap_chan_timeout+0x5d/0x1b0 net/bluetooth/l2cap_core.c:422
> |  process_one_work kernel/workqueue.c:3326 [inline]
> |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> |  kthread+0x346/0x430 kernel/kthread.c:436
> |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> |  </TASK>
> |
> | Allocated by task 320:
> |  l2cap_conn_add+0xa7/0x820 net/bluetooth/l2cap_core.c:7075
> |  l2cap_connect_cfm+0xdb/0xd70 net/bluetooth/l2cap_core.c:7452
> |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
> |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
> |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> |  process_one_work kernel/workqueue.c:3326 [inline]
> |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> |  kthread+0x346/0x430 kernel/kthread.c:436
> |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> |
> | Freed by task 322:
> |  hci_disconn_cfm include/net/bluetooth/hci_core.h:2154 [inline]
> |  hci_conn_hash_flush+0x101/0x1f0 net/bluetooth/hci_conn.c:2736
> |  hci_dev_close_sync+0x889/0xde0 net/bluetooth/hci_sync.c:5405
> |  hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
> |  hci_unregister_dev+0x1f7/0x370 net/bluetooth/hci_core.c:2679
> |  vhci_release+0x12a/0x180 drivers/bluetooth/hci_vhci.c:690
> |  __fput+0x369/0x890 fs/file_table.c:510
> |  task_work_run+0x160/0x1d0 kernel/task_work.c:233
> |  get_signal+0xf5b/0x1120 kernel/signal.c:2810
> |  arch_do_signal_or_restart+0x4d/0x600 arch/x86/kernel/signal.c:337
> |  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
> |  exit_to_user_mode_loop+0x85/0x510 kernel/entry/common.c:98
> |  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
> |  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
> |  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
> |  do_syscall_64+0x263/0x3d0 arch/x86/entry/syscall_64.c:100
> |  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> |
> | Last potentially related work creation:
> |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
> |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
> |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> |  process_one_work kernel/workqueue.c:3326 [inline]
> |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> |  kthread+0x346/0x430 kernel/kthread.c:436
> |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> |
> | The buggy address belongs to the object at ffff8881298d9400
> |  which belongs to the cache kmalloc-512 of size 512
> | The buggy address is located 336 bytes inside of
> |  freed 512-byte region [ffff8881298d9400, ffff8881298d9600)
>
> Fix it by holding a reference to the connection when the channel timer
> is scheduled, and releasing it when the timer is either canceled or
> executes to completion.
>
> Since l2cap_chan_del() nullifies chan->conn to disassociate the channel
> during teardown, the timer handler might read NULL from chan->conn even
> if it held a reference. To address this, introduce a `timer_conn` field
> to `struct l2cap_chan` to store the connection pointer associated with
> the active timer. The timer handler uses this field to acquire locks and
> release the connection reference, and skips channel closing operations
> if chan->conn has already been nullified by teardown.
>
> Fixes: 75780ca4c6a8 ("Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()")
> Cc: <stable@vger.kernel.org>
> Cc: Siwei Zhang <oss@fourdim.xyz>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz
> Signed-off-by: Marco Elver <elver@google.com>

Sigh, Sashiko points out more problems here:
https://sashiko.dev/#/patchset/20260603123111.2334409-1-elver%40google.com

> Can this lockless read of chan->timer_conn cause a use-after-free or double
> free if another thread re-arms the timer concurrently?

I haven't analyzed this further yet, so consider this patch a
bug-report-only. If anyone finds a better fix sooner, please go ahead.

> ---
>  include/net/bluetooth/l2cap.h | 18 ++++++++++++++++--
>  net/bluetooth/l2cap_core.c    | 26 +++++++++++++++-----------
>  2 files changed, 31 insertions(+), 13 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index e0a1f2293679..83719777512e 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -514,6 +514,7 @@ struct l2cap_seq_list {
>
>  struct l2cap_chan {
>         struct l2cap_conn       *conn;
> +       struct l2cap_conn       *timer_conn; /* for chan_timer */
>         struct kref     kref;
>         atomic_t        nesting;
>
> @@ -835,6 +836,9 @@ static inline void l2cap_chan_unlock(struct l2cap_chan *chan)
>         mutex_unlock(&chan->lock);
>  }
>
> +struct l2cap_conn *l2cap_conn_get(struct l2cap_conn *conn);
> +void l2cap_conn_put(struct l2cap_conn *conn);
> +
>  static inline void l2cap_set_timer(struct l2cap_chan *chan,
>                                    struct delayed_work *work, long timeout)
>  {
> @@ -843,8 +847,13 @@ static inline void l2cap_set_timer(struct l2cap_chan *chan,
>
>         /* If delayed work cancelled do not hold(chan)
>            since it is already done with previous set_timer */
> -       if (!cancel_delayed_work(work))
> +       if (!cancel_delayed_work(work)) {
>                 l2cap_chan_hold(chan);
> +               if (work == &chan->chan_timer && chan->conn) {
> +                       l2cap_conn_get(chan->conn);
> +                       chan->timer_conn = chan->conn;
> +               }
> +       }
>
>         schedule_delayed_work(work, timeout);
>  }
> @@ -857,8 +866,13 @@ static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
>         /* put(chan) if delayed work cancelled otherwise it
>            is done in delayed work function */
>         ret = cancel_delayed_work(work);
> -       if (ret)
> +       if (ret) {
> +               if (work == &chan->chan_timer && chan->timer_conn) {
> +                       l2cap_conn_put(chan->timer_conn);
> +                       chan->timer_conn = NULL;
> +               }
>                 l2cap_chan_put(chan);
> +       }
>
>         return ret;
>  }
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index c4ccfbda9d78..491b03bf6903 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -406,7 +406,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
>  {
>         struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
>                                                chan_timer.work);
> -       struct l2cap_conn *conn = chan->conn;
> +       struct l2cap_conn *conn = chan->timer_conn;
>         int reason;
>
>         BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
> @@ -421,23 +421,27 @@ static void l2cap_chan_timeout(struct work_struct *work)
>          * this work. No need to call l2cap_chan_hold(chan) here again.
>          */
>         l2cap_chan_lock(chan);
> +       chan->timer_conn = NULL;
> +
> +       if (chan->conn) {
> +               if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
> +                       reason = ECONNREFUSED;
> +               else if (chan->state == BT_CONNECT &&
> +                        chan->sec_level != BT_SECURITY_SDP)
> +                       reason = ECONNREFUSED;
> +               else
> +                       reason = ETIMEDOUT;
>
> -       if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
> -               reason = ECONNREFUSED;
> -       else if (chan->state == BT_CONNECT &&
> -                chan->sec_level != BT_SECURITY_SDP)
> -               reason = ECONNREFUSED;
> -       else
> -               reason = ETIMEDOUT;
> -
> -       l2cap_chan_close(chan, reason);
> +               l2cap_chan_close(chan, reason);
>
> -       chan->ops->close(chan);
> +               chan->ops->close(chan);
> +       }
>
>         l2cap_chan_unlock(chan);
>         l2cap_chan_put(chan);
>
>         mutex_unlock(&conn->lock);
> +       l2cap_conn_put(conn);
>  }
>
>  struct l2cap_chan *l2cap_chan_create(void)
> --
> 2.54.0.1013.g208068f2d8-goog
>
