Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762A247B431
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582263; cv=pass; b=f0HIPfuglt8nYVYb4CIE4C2JIMXC+rKULsl//nD/ActFOqgwZN5UBob94sbXXLgFbxC9ziwWiaP55sDWhpE50TXOsLfr8OP2qurpX+nb5D7x9mgu5GrToHMSkCQre+WdB6L/B1d8JpQuDcqf89NGAVlHyQAitFoKLbIEEK6DMF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582263; c=relaxed/simple;
	bh=wypWffxnDNTSiB8taBVqAMgSLfKvk6rwhKySNic+1ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RMScAcoxMSFwhtJZSukD0yf5ct8qQSu/vPpHzr8uRWfLGLK2G5AWZIoUR/lCiZ1UUt+uPDmj+pJ/5eFh0iV7DRm/SPX+Y9ZdPeIjoaSixzAWxgGpt+21IamR1lY5fQQRLM8oq59XXbkqJdy11orzfYI89W77O4C4J1DGluzwYYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn3D08zq; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn3D08zq"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-66043ecf6b3so889114d50.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Jun 2026 07:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780582260; cv=none;
        d=google.com; s=arc-20240605;
        b=bYJ1mO0WJFRndVN9FVbmieUaVv8VcKHfrIGoLy0K2q4Efdztl6jS3NghpAlsNJxfq2
         8/36fSMz38MxKsuE3C3TvM5yN2dkcbzf/snElikl5P/WdbfZ3i900vRkDQt6JY9Eio+q
         q+uBO+SR/r9i+DR7fxKnOavS7OiL7nZ8ewJUnhjg4EvHlLLWTzcYaJF+FXCitKpg5zyM
         PKNxpfBV5WKS3bOQ15vIcm7YgITyYvhDH7i4YkzFw3b2e1nnghYt0rR8DMbKxhg1vd2A
         ctXMgrQGtB9O3fsboWvZUGeRuPcnuonjz6J5t/UJ8QXiByYj4PJNwDkHAID/4D5bJeXS
         p7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7yHa51Mj+ewc0UTc1c2Cz+lJ0RiTZkofDwbf0p3+F6g=;
        fh=e6nq21wIKMhlXtPxutql2OqON+P+R9XMErTGaKRLlNo=;
        b=H6+KP5L0XwaxOLHXpOBAgxhZMisqmvNuivWBuF+4cDpl2+qfTAYKpaoQW6aoP/pEqU
         qx8s5gfnVV4Emh1LzR5olb6ls/arOgKM7o12Wnk6jqKTk2Y2rJQWE8kqmF7eyplKTyi5
         yckamkQpfGWVaJKpvlz88Tqq02cMK2Fb/Z9WaGFFUi+hLtf73+0wSQLbqve/3ntq3cu3
         benRDvgtYqk6tKmcSHqgNxlKMPQIkDswXmgj20GUvW6/8D/jHkyUfcofub2kaqb24sZq
         8SmN2Z2EsWYmk4wRG2OEingf4m8Cef18Z4yeqCdRBLZIfkCI6w644uVjE/c7VEdAt8G9
         fetA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780582260; x=1781187060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yHa51Mj+ewc0UTc1c2Cz+lJ0RiTZkofDwbf0p3+F6g=;
        b=Yn3D08zqMLqoHDAYGPLWfzim/Ls/nIopiTW8BQ1m7Y9E0KfS9Ebu1cmu3LhV0LA2rm
         1BpMR+7rtKxn9x3yPxNUJp5tf0TuPynmsO86ZMTVVhEa7XF6Ty0Xj1Al7Ai24rdL73yf
         4eJvsIqD0BWA3v5Uavbl7QRM6sQCXejvqlV2wKDkbwzzDYwsg/ydRFT6nNJfWXH+z5/F
         c7CDlj5iMhdKyl3ZswcuF7Va1JB9eOrUmExN3bHb+198tnJ5hyrDfXE1gEE5V9evxoRm
         rvtMPja+PQ2FZn07+Sz6TXmnjf6VowyoROwHVCScHZBwk3Etn8+eIbl15x1jp5JvAfbh
         tN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582260; x=1781187060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7yHa51Mj+ewc0UTc1c2Cz+lJ0RiTZkofDwbf0p3+F6g=;
        b=YHjwhT2fpXraeA3MzeVJ8XtgyBjYpwZBpVUnvJ6nSScWKDn4Hh2eDzG/XOFbp8KLVg
         HF91tJQk1p7u8wfoS5jxQiJOqr42V3wl6K2iFe+OmyAc6D4JdsgByEuacXOCM6CK7wPQ
         lz0LfXyNZQYJqo7SGKJiY8Hz1f3ohPvMHelnXqjF+PF0HgOKOezDYgWSyFE/Lj0pPMqA
         ewc3ltM2h2UVxS1ZlZS7CmCDhH4K+Ed2/SsBUktVATIqyEiSKGyxk4ATOhTfGr1kL0pU
         fId7oLxUEfMEHyA3waVpkGZhiLU/LFV5mjeic34GKlNkpdJn9hpYlDSqGOlqxTT+K/wn
         KbWw==
X-Forwarded-Encrypted: i=1; AFNElJ+XpMxfhf7qM04uRCQczuM1MnT7BsHnf1c+K9lo/qXao6NE1RHD0C5k+0CDjTVH2l8oO5RldOCdxxMzkDoZgCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMAJeZFTF+xo3aGsfTtP64aaDpdcGaPhyzrBJ0AZZgoTYKi86n
	OIAMr2MNClIu8iqIP4K4LITes6MD8YfARYfmAvcEbybQdGVKzWaULfLDyT7BuhkPQYpdqEp+T5l
	0mER+mxF2uku6OOtv1Zq9qWagBVdGdyc=
X-Gm-Gg: Acq92OFmk//aTrD75J7FuY2ew/1Q6+Dn5IftVLXZfTq8UsvojZltp9xaC1IKqQd4gAc
	7nnCW+9FDdhu8B6bSspLd7aI6K56yDjUeCTvynTRlkLSVs26u9VEhVa8DCYQs9Xo7Rc1yzgcloc
	Fj9Md1Y3aJI90OLPf67HR3mJ/9Q9ipcWSfjDJuZIG1hwy7r8afmXuUq0crymOjNrfkkntVAo1jX
	PQw1gPljdDYlmrRmXZhx4V8Ntxp4Z50dtRee/OFWfZobR2c+DktlU33aqbwDZ1A6F3ZAohBQO82
	Tnr+zfjF9pEDS3r9oQ+K4q9NuHA//EkLZ2HhacRHlQHYhzninY5NM7u/RUTeueip5KV43xvyzY7
	dWA==
X-Received: by 2002:a53:ef83:0:b0:65e:4272:2eb8 with SMTP id
 956f58d0204a3-660dc62f0a8mr5746510d50.65.1780582260125; Thu, 04 Jun 2026
 07:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603123111.2334409-1-elver@google.com> <CANpmjNPQCx8rynFhOUfqgagP-KBh0pJsXz6PQt6G3LomdzVJYw@mail.gmail.com>
 <CABBYNZL9tH1Tc+jbc6fJ-Y1EtX+_QUk_P3ghDmdOaXY0gdqtnQ@mail.gmail.com> <aiFzWTYs1ppHhnNS@elver.google.com>
In-Reply-To: <aiFzWTYs1ppHhnNS@elver.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 4 Jun 2026 10:10:47 -0400
X-Gm-Features: AVHnY4Ij8uki-OEkVLkPvr2tG07yagjQEUhyfT8i2DAZ0c58nSOGhYZNdMOegQM
Message-ID: <CABBYNZLvDNPM9YXa+Whbx=+4Cgy-rp+pVVv0J0M52DsUMcQ8NQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix UAF in l2cap_chan_timeout
To: Marco Elver <elver@google.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	stable@vger.kernel.org, Siwei Zhang <oss@fourdim.xyz>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On Thu, Jun 4, 2026 at 8:45=E2=80=AFAM Marco Elver <elver@google.com> wrote=
:
>
> On Wed, Jun 03, 2026 at 01:31PM -0400, Luiz Augusto von Dentz wrote:
> > Hi Marco,
> >
> > On Wed, Jun 3, 2026 at 9:16=E2=80=AFAM Marco Elver <elver@google.com> w=
rote:
> > >
> > > On Wed, 3 Jun 2026 at 14:31, Marco Elver <elver@google.com> wrote:
> > > >
> > > > l2cap_chan_timeout() accesses chan->conn without holding a referenc=
e to
> > > > the connection object. If l2cap_conn_del() races and tears down the
> > > > connection while the timer is waiting for locks, it can result in a
> > > > use-after-free when the timer wakes up and attempts to acquire
> > > > conn->lock:
> > > >
> > > > | BUG: KASAN: slab-use-after-free in instrument_atomic_read_write i=
nclude/linux/instrumented.h:112 [inline]
> > > > | BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_acquir=
e include/linux/atomic/atomic-instrumented.h:4456 [inline]
> > > > | BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kernel/lo=
cking/mutex.c:161 [inline]
> > > > | BUG: KASAN: slab-use-after-free in mutex_lock+0x4f/0xa0 kernel/lo=
cking/mutex.c:318
> > > > | Write of size 8 at addr ffff8881298d9550 by task kworker/2:1/83
> > > > |
> > > > | CPU: 2 UID: 0 PID: 83 Comm: kworker/2:1 Not tainted 7.1.0-rc6-nex=
t-20260601-dirty #6 PREEMPT(full)
> > > > | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.=
0-debian-1.17.0-1 04/01/2014
> > > > | Workqueue: events l2cap_chan_timeout
> > > > | Call Trace:
> > > > |  <TASK>
> > > > |  instrument_atomic_read_write include/linux/instrumented.h:112 [i=
nline]
> > > > |  atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-inst=
rumented.h:4456 [inline]
> > > > |  __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
> > > > |  mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
> > > > |  l2cap_chan_timeout+0x5d/0x1b0 net/bluetooth/l2cap_core.c:422
> > > > |  process_one_work kernel/workqueue.c:3326 [inline]
> > > > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > > > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > > > |  kthread+0x346/0x430 kernel/kthread.c:436
> > > > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > > > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > > |  </TASK>
> > > > |
> > > > | Allocated by task 320:
> > > > |  l2cap_conn_add+0xa7/0x820 net/bluetooth/l2cap_core.c:7075
> > > > |  l2cap_connect_cfm+0xdb/0xd70 net/bluetooth/l2cap_core.c:7452
> > > > |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
> > > > |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:37=
60
> > > > |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> > > > |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> > > > |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> > > > |  process_one_work kernel/workqueue.c:3326 [inline]
> > > > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > > > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > > > |  kthread+0x346/0x430 kernel/kthread.c:436
> > > > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > > > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > > |
> > > > | Freed by task 322:
> > > > |  hci_disconn_cfm include/net/bluetooth/hci_core.h:2154 [inline]
> > > > |  hci_conn_hash_flush+0x101/0x1f0 net/bluetooth/hci_conn.c:2736
> > > > |  hci_dev_close_sync+0x889/0xde0 net/bluetooth/hci_sync.c:5405
> > > > |  hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
> > > > |  hci_unregister_dev+0x1f7/0x370 net/bluetooth/hci_core.c:2679
> > > > |  vhci_release+0x12a/0x180 drivers/bluetooth/hci_vhci.c:690
> > > > |  __fput+0x369/0x890 fs/file_table.c:510
> > > > |  task_work_run+0x160/0x1d0 kernel/task_work.c:233
> > > > |  get_signal+0xf5b/0x1120 kernel/signal.c:2810
> > > > |  arch_do_signal_or_restart+0x4d/0x600 arch/x86/kernel/signal.c:33=
7
> > > > |  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
> > > > |  exit_to_user_mode_loop+0x85/0x510 kernel/entry/common.c:98
> > > > |  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207=
 [inline]
> > > > |  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common=
.h:230 [inline]
> > > > |  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inli=
ne]
> > > > |  do_syscall_64+0x263/0x3d0 arch/x86/entry/syscall_64.c:100
> > > > |  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > |
> > > > | Last potentially related work creation:
> > > > |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
> > > > |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:37=
60
> > > > |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> > > > |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> > > > |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> > > > |  process_one_work kernel/workqueue.c:3326 [inline]
> > > > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > > > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > > > |  kthread+0x346/0x430 kernel/kthread.c:436
> > > > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > > > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > > |
> > > > | The buggy address belongs to the object at ffff8881298d9400
> > > > |  which belongs to the cache kmalloc-512 of size 512
> > > > | The buggy address is located 336 bytes inside of
> > > > |  freed 512-byte region [ffff8881298d9400, ffff8881298d9600)
> > > >
> > > > Fix it by holding a reference to the connection when the channel ti=
mer
> > > > is scheduled, and releasing it when the timer is either canceled or
> > > > executes to completion.
> > > >
> > > > Since l2cap_chan_del() nullifies chan->conn to disassociate the cha=
nnel
> > > > during teardown, the timer handler might read NULL from chan->conn =
even
> > > > if it held a reference. To address this, introduce a `timer_conn` f=
ield
> > > > to `struct l2cap_chan` to store the connection pointer associated w=
ith
> > > > the active timer. The timer handler uses this field to acquire lock=
s and
> > > > release the connection reference, and skips channel closing operati=
ons
> > > > if chan->conn has already been nullified by teardown.
> > > >
> > > > Fixes: 75780ca4c6a8 ("Bluetooth: L2CAP: use chan timer to close cha=
nnels in cleanup_listen()")
> > > > Cc: <stable@vger.kernel.org>
> > > > Cc: Siwei Zhang <oss@fourdim.xyz>
> > > > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > Assisted-by: Gemini:gemini-3.1-pro-preview
> > > > Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-=
1-oss%40fourdim.xyz
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > >
> > > Sigh, Sashiko points out more problems here:
> > > https://sashiko.dev/#/patchset/20260603123111.2334409-1-elver%40googl=
e.com
> > >
> > > > Can this lockless read of chan->timer_conn cause a use-after-free o=
r double
> > > > free if another thread re-arms the timer concurrently?
> > >
> > > I haven't analyzed this further yet, so consider this patch a
> > > bug-report-only. If anyone finds a better fix sooner, please go ahead=
.
> >
> > I was thinking or something like the following:
>
> I tested that and my repro didn't trigger the UAF here, but I still
> think it has the same fundamental issue:
>
> If the timer worker is preempted immediately after reading chan->conn
> but before entering l2cap_conn_hold_unless_zero(), l2cap_conn_del() can
> complete concurrently.
>
> When the timer worker resumes, l2cap_conn_hold_unless_zero(conn) will
> attempt to read conn->ref that has already been freed, resulting in
> another UAF.

I see. The window is very narrow but it is perhaps still triggerable
somehow. The only thing that comes to mind is that we would need to
take a reference of l2cap_conn with the likes of l2cap_set_timer then,
which means l2cap_chan_timeout needs to drop not only l2cap_chan but
also l2cap_conn when done, otherwise there will always be the risk of
l2cap_conn_del running while l2cap_chan_timeout is pending.

--=20
Luiz Augusto von Dentz
