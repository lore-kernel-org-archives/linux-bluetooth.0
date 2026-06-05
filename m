Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B3131F9A6
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667618; cv=pass; b=lZUBLQm2zvbEiw/jUr2iLf1jI8NbZTbdlk8AWYTjJGzPBp/48epshayQEQfLmg/KaKeTshUSHTsHyy9Y4OQqvyw9AFa4glrpPJtQ1BYLx4Frn6DOQFGp4VB1mWjAkDGJicOj8ZFcKCT/LZ6U1iIQAgLdDEuqtw9Au0QA7p+HVH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667618; c=relaxed/simple;
	bh=lnrX/alTF6KRYOVLeNGt5aSvUEO9ekSTzYT/x3q7MxM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdypXL1sT1LD22RvEHcUVetsxZdPtJpJiICqQs4AHJCQUNFUVAqqTQxa3fZu76owlV4Zn4AOOmw/bwe0l1MRu0uf3bGkcvFbQFvaMELb136ACZbAqGLAPNsNUgFfhUdY8qylZF7A0LRlK1DOyBsorJTP2wicRugdHBxKgIO+bZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GraBHCzG; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GraBHCzG"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66056b248abso1899974d50.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Jun 2026 06:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780667615; cv=none;
        d=google.com; s=arc-20240605;
        b=P1MIUZT7eCnqVPAiaSOe4nmNl4zIhwM0Y/HGQJg9G/q3NBBy24/5byUsCP1pcIKvgP
         5eYk3wwEimDHWznU/rb4DEpbAnGa0H+jm/uqohltczn3nQNKdinCejRoi+xn33ypnwVg
         3Z+wvJCVZJJg2HJyvLjCuD24yC+44xelN2+mn3SKIwbyJtjsPhG+Lqd0CqMm7FITnSOi
         4/4zJBJTJpbX36qZ0qsq8o91aCI+NQlsfsfTnf8qpPu8hcIOe2EESIzjOeXvlVzyls3m
         zPU0doybt5ZdkYY4qvszBTeAa8olnRbRiUffsppZsGWiGAscIr1WBB3qlLiH306F5pJ/
         b/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xfAfd92LPN6FTzlStdmduyo1i07dNUdV4TQ4blRoPHA=;
        fh=M/jjsz1fmS0Ryk20WIYQo7kIXqJoJkqFwrZYQxGP3EE=;
        b=Oosy7qBirE5uUUfoY5K47IPkGf0UDqNa+RFSSM508Jp5Y5vGMiX2aZ4b8L0UBtLE8/
         BCaS5bF8Gjrq18rBGGLaxB958vEv44pysimoMsEp9T/OhsGY+S0GrF3PpK+tY9pXH9Sq
         jfqpRd7/JjKji+3TX1D8JKjy0jIrZ108UM/BPZ2gxKC9CeJ1j8dD4d4gmjzIOiSWTyIZ
         55iiXAtclDDH3MVgrubgPcBK25WBUAj5JLgv3D69LCFn8tU08nGicRHR/CrWKa67aS05
         YrBE0v6Lxh2973GHcWm9daR5B9p351nVt1NGHVlYxsCbB2ovECt6poVwP26AP7nSDNGh
         cOrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780667615; x=1781272415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xfAfd92LPN6FTzlStdmduyo1i07dNUdV4TQ4blRoPHA=;
        b=GraBHCzGV0DMkuSc0lKxcUoCqFBFKOnk6Au8gulcR66xIyxpdxDNFATR0g1t00+C1K
         efBisxcuPqtMCvbveMKmyoG1FA2AHbx4uKrgGDyv/080fne37WUOnWwJElTQ86qOmAnz
         HoOYNumZ8lRF+SFcmEAp8EEwhrd/EV4DziF7GNTTRdjaE4zwxmR7cMQe65SrOO7Yt1Ky
         SEKLiuKAuLjZM7IaKYPuvgxpyh6TwjJ8uBMYFuG55JPuGgT653nEFDD1v/VVMhCBzVOm
         Dq4P5WMfBt9VauMY/ljQxhBxfhkyhGFy5qx+u+hi0NNxy4ByTnJQLh2apZKvwS7GbeeO
         RTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780667615; x=1781272415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xfAfd92LPN6FTzlStdmduyo1i07dNUdV4TQ4blRoPHA=;
        b=Xv+1O8fQ6RIx5mdc1Pt4N6gzLaQwkvIvY1IoaxCF8g2cWdepfPmejlrPvuBmygxYEl
         kGZs3VVX55SWi9dSpbz/vfxLl/Z6rBAMeK0B8WEEMcfaDyTeRX1DF/6DYaBNby0yjr57
         T9PDPjM2uYddfPhk4wgLOgGRFCTOfm8eCGDIUQwSxoYOn/rLdRfZeW4yOxhPblbMlLhd
         GGpdyhYSirnU+sLZCdAMQbKYpczIWpI+mDF1CYyzr9KUK5njTbH2lmGeXD01dUYztQFK
         qOlHv3raz/1nF5xcAPYIQLlOMuEL/f+ZxVRwKA22CDlJcuP11wzI3lpxa3N1a5HFM+3Z
         U18w==
X-Forwarded-Encrypted: i=1; AFNElJ+x3OPc/k2ATvM1hfLJGjA4oLBglzzGiHu69rNG6ITcQYZadMkhp4cgX16oMbLZY+Xv2NuU7B01PgwgBwuAbfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRxm6KzS53piCFTrhMZKUF7bNvPdzmZW+mbaT5Cc1Ry9DGvTcs
	QNumjrv1pkaJ7HXUQIQTwptIy8YhUuoeJPgtwnFkq5PZYG/utfe70V848RuuRrF+xWmr45ZG2DS
	IxJrN93efk8iTNakc1FPy7YAfpDFtmsA=
X-Gm-Gg: Acq92OFy9nxNw+mk0MOAVd+/2a5mypRLlNrMGvEnnaqR5tetMx5y3K2+hNvx7iQPmdh
	HmPRz2KgpwvGFlom140hBfPjNENUnqJBwfbdHtZB35UnOBQ0Z2NlPW4SdRbs3HN+77xEepaboNm
	BiFSEppy1XfBEOptiV1ODdq/4suzltRF1fXw5qVAvrmi/WYLfZ6CenquhqgSMWJAzLV8BKBqP5q
	bLIaCq7R+SxWFqNIj77GTj4/+IAAJkECObbxAnpnKf7UFsy4ywEGx1x0KTNrI0upFsDvbIEPGX4
	lPUDV3Rl5Y0kNTx8EbwuLoE4hDMtjiRNeB5OGENOWREeXLW7gYOmDtP4nKGxRhTYU0TE3Z833Pz
	eBnos
X-Received: by 2002:a05:690e:4144:b0:660:62e5:9303 with SMTP id
 956f58d0204a3-661070cbcd8mr3224018d50.63.1780667614476; Fri, 05 Jun 2026
 06:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603123111.2334409-1-elver@google.com> <CANpmjNPQCx8rynFhOUfqgagP-KBh0pJsXz6PQt6G3LomdzVJYw@mail.gmail.com>
 <CABBYNZL9tH1Tc+jbc6fJ-Y1EtX+_QUk_P3ghDmdOaXY0gdqtnQ@mail.gmail.com>
 <aiFzWTYs1ppHhnNS@elver.google.com> <CABBYNZLvDNPM9YXa+Whbx=+4Cgy-rp+pVVv0J0M52DsUMcQ8NQ@mail.gmail.com>
 <aiKigutVmlbOuXGy@elver.google.com>
In-Reply-To: <aiKigutVmlbOuXGy@elver.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 5 Jun 2026 09:53:23 -0400
X-Gm-Features: AVHnY4I67wzXiPEGDaQQ8w8J3ZWrmgFUJgPoEgqcC9JJwGfqxBc7NjE3AxuuBX8
Message-ID: <CABBYNZLXGuOy9PdKY27nnJVK7=EG=52d_hfDtZcspAEOfp_WHQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix UAF in l2cap_chan_timeout
To: Marco Elver <elver@google.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	stable@vger.kernel.org, Siwei Zhang <oss@fourdim.xyz>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On Fri, Jun 5, 2026 at 6:18=E2=80=AFAM Marco Elver <elver@google.com> wrote=
:
>
> On Thu, Jun 04, 2026 at 10:10AM -0400, Luiz Augusto von Dentz wrote:
> > Hi Marco,
> >
> > On Thu, Jun 4, 2026 at 8:45=E2=80=AFAM Marco Elver <elver@google.com> w=
rote:
> > >
> > > On Wed, Jun 03, 2026 at 01:31PM -0400, Luiz Augusto von Dentz wrote:
> > > > Hi Marco,
> > > >
> > > > On Wed, Jun 3, 2026 at 9:16=E2=80=AFAM Marco Elver <elver@google.co=
m> wrote:
> > > > >
> > > > > On Wed, 3 Jun 2026 at 14:31, Marco Elver <elver@google.com> wrote=
:
> > > > > >
> > > > > > l2cap_chan_timeout() accesses chan->conn without holding a refe=
rence to
> > > > > > the connection object. If l2cap_conn_del() races and tears down=
 the
> > > > > > connection while the timer is waiting for locks, it can result =
in a
> > > > > > use-after-free when the timer wakes up and attempts to acquire
> > > > > > conn->lock:
> > > > > >
> > > > > > | BUG: KASAN: slab-use-after-free in instrument_atomic_read_wri=
te include/linux/instrumented.h:112 [inline]
> > > > > > | BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_ac=
quire include/linux/atomic/atomic-instrumented.h:4456 [inline]
> > > > > > | BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kerne=
l/locking/mutex.c:161 [inline]
> > > > > > | BUG: KASAN: slab-use-after-free in mutex_lock+0x4f/0xa0 kerne=
l/locking/mutex.c:318
> > > > > > | Write of size 8 at addr ffff8881298d9550 by task kworker/2:1/=
83
> > > > > > |
> > > > > > | CPU: 2 UID: 0 PID: 83 Comm: kworker/2:1 Not tainted 7.1.0-rc6=
-next-20260601-dirty #6 PREEMPT(full)
> > > > > > | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1=
.17.0-debian-1.17.0-1 04/01/2014
> > > > > > | Workqueue: events l2cap_chan_timeout
> > > > > > | Call Trace:
> > > > > > |  <TASK>
> > > > > > |  instrument_atomic_read_write include/linux/instrumented.h:11=
2 [inline]
> > > > > > |  atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-=
instrumented.h:4456 [inline]
> > > > > > |  __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
> > > > > > |  mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
> > > > > > |  l2cap_chan_timeout+0x5d/0x1b0 net/bluetooth/l2cap_core.c:422
> > > > > > |  process_one_work kernel/workqueue.c:3326 [inline]
> > > > > > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > > > > > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > > > > > |  kthread+0x346/0x430 kernel/kthread.c:436
> > > > > > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > > > > > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > > > > |  </TASK>
> > > > > > |
> > > > > > | Allocated by task 320:
> > > > > > |  l2cap_conn_add+0xa7/0x820 net/bluetooth/l2cap_core.c:7075
> > > > > > |  l2cap_connect_cfm+0xdb/0xd70 net/bluetooth/l2cap_core.c:7452
> > > > > > |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inlin=
e]
> > > > > > |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.=
c:3760
> > > > > > |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> > > > > > |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> > > > > > |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> > > > > > |  process_one_work kernel/workqueue.c:3326 [inline]
> > > > > > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > > > > > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > > > > > |  kthread+0x346/0x430 kernel/kthread.c:436
> > > > > > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > > > > > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > > > > |
> > > > > > | Freed by task 322:
> > > > > > |  hci_disconn_cfm include/net/bluetooth/hci_core.h:2154 [inlin=
e]
> > > > > > |  hci_conn_hash_flush+0x101/0x1f0 net/bluetooth/hci_conn.c:273=
6
> > > > > > |  hci_dev_close_sync+0x889/0xde0 net/bluetooth/hci_sync.c:5405
> > > > > > |  hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
> > > > > > |  hci_unregister_dev+0x1f7/0x370 net/bluetooth/hci_core.c:2679
> > > > > > |  vhci_release+0x12a/0x180 drivers/bluetooth/hci_vhci.c:690
> > > > > > |  __fput+0x369/0x890 fs/file_table.c:510
> > > > > > |  task_work_run+0x160/0x1d0 kernel/task_work.c:233
> > > > > > |  get_signal+0xf5b/0x1120 kernel/signal.c:2810
> > > > > > |  arch_do_signal_or_restart+0x4d/0x600 arch/x86/kernel/signal.=
c:337
> > > > > > |  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
> > > > > > |  exit_to_user_mode_loop+0x85/0x510 kernel/entry/common.c:98
> > > > > > |  __exit_to_user_mode_prepare include/linux/irq-entry-common.h=
:207 [inline]
> > > > > > |  syscall_exit_to_user_mode_prepare include/linux/irq-entry-co=
mmon.h:230 [inline]
> > > > > > |  syscall_exit_to_user_mode include/linux/entry-common.h:318 [=
inline]
> > > > > > |  do_syscall_64+0x263/0x3d0 arch/x86/entry/syscall_64.c:100
> > > > > > |  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > > |
> > > > > > | Last potentially related work creation:
> > > > > > |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inlin=
e]
> > > > > > |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.=
c:3760
> > > > > > |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> > > > > > |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> > > > > > |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> > > > > > |  process_one_work kernel/workqueue.c:3326 [inline]
> > > > > > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > > > > > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > > > > > |  kthread+0x346/0x430 kernel/kthread.c:436
> > > > > > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > > > > > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > > > > |
> > > > > > | The buggy address belongs to the object at ffff8881298d9400
> > > > > > |  which belongs to the cache kmalloc-512 of size 512
> > > > > > | The buggy address is located 336 bytes inside of
> > > > > > |  freed 512-byte region [ffff8881298d9400, ffff8881298d9600)
> > > > > >
> > > > > > Fix it by holding a reference to the connection when the channe=
l timer
> > > > > > is scheduled, and releasing it when the timer is either cancele=
d or
> > > > > > executes to completion.
> > > > > >
> > > > > > Since l2cap_chan_del() nullifies chan->conn to disassociate the=
 channel
> > > > > > during teardown, the timer handler might read NULL from chan->c=
onn even
> > > > > > if it held a reference. To address this, introduce a `timer_con=
n` field
> > > > > > to `struct l2cap_chan` to store the connection pointer associat=
ed with
> > > > > > the active timer. The timer handler uses this field to acquire =
locks and
> > > > > > release the connection reference, and skips channel closing ope=
rations
> > > > > > if chan->conn has already been nullified by teardown.
> > > > > >
> > > > > > Fixes: 75780ca4c6a8 ("Bluetooth: L2CAP: use chan timer to close=
 channels in cleanup_listen()")
> > > > > > Cc: <stable@vger.kernel.org>
> > > > > > Cc: Siwei Zhang <oss@fourdim.xyz>
> > > > > > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > > Assisted-by: Gemini:gemini-3.1-pro-preview
> > > > > > Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258=
069-1-oss%40fourdim.xyz
> > > > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > >
> > > > > Sigh, Sashiko points out more problems here:
> > > > > https://sashiko.dev/#/patchset/20260603123111.2334409-1-elver%40g=
oogle.com
> > > > >
> > > > > > Can this lockless read of chan->timer_conn cause a use-after-fr=
ee or double
> > > > > > free if another thread re-arms the timer concurrently?
> > > > >
> > > > > I haven't analyzed this further yet, so consider this patch a
> > > > > bug-report-only. If anyone finds a better fix sooner, please go a=
head.
> > > >
> > > > I was thinking or something like the following:
> > >
> > > I tested that and my repro didn't trigger the UAF here, but I still
> > > think it has the same fundamental issue:
> > >
> > > If the timer worker is preempted immediately after reading chan->conn
> > > but before entering l2cap_conn_hold_unless_zero(), l2cap_conn_del() c=
an
> > > complete concurrently.
> > >
> > > When the timer worker resumes, l2cap_conn_hold_unless_zero(conn) will
> > > attempt to read conn->ref that has already been freed, resulting in
> > > another UAF.
> >
> > I see. The window is very narrow but it is perhaps still triggerable
> > somehow. The only thing that comes to mind is that we would need to
> > take a reference of l2cap_conn with the likes of l2cap_set_timer then,
> > which means l2cap_chan_timeout needs to drop not only l2cap_chan but
> > also l2cap_conn when done, otherwise there will always be the risk of
> > l2cap_conn_del running while l2cap_chan_timeout is pending.
>
> What if we tie conn's lifetime to chan? I see that 'conn' being
> NULL/non-NULL is also used as a presence/not-present marker, but we
> could add an explicit conn_ref?
>
> ------ >8 ------
>
> From: Marco Elver <elver@google.com>
> Date: Wed, 3 Jun 2026 18:24:56 +0200
> Subject: [PATCH] Bluetooth: L2CAP: Fix UAF in channel timeout by holding =
conn
>  ref
>
> l2cap_chan_timeout() runs asynchronously and accesses chan->conn. If
> the connection is torn down while the timer is running or pending,
> chan->conn can be freed, leading to a use-after-free when the timer
> worker attempts to lock conn->lock:
>
> | BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include=
/linux/instrumented.h:112 [inline]
> | BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_acquire incl=
ude/linux/atomic/atomic-instrumented.h:4456 [inline]
> | BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kernel/locking/=
mutex.c:161 [inline]
> | BUG: KASAN: slab-use-after-free in mutex_lock+0x4f/0xa0 kernel/locking/=
mutex.c:318
> | Write of size 8 at addr ffff8881298d9550 by task kworker/2:1/83
> |
> | CPU: 2 UID: 0 PID: 83 Comm: kworker/2:1 Not tainted 7.1.0-rc6-next-2026=
0601-dirty #6 PREEMPT(full)
> | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debi=
an-1.17.0-1 04/01/2014
> | Workqueue: events l2cap_chan_timeout
> | Call Trace:
> |  <TASK>
> |  instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
> |  atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrument=
ed.h:4456 [inline]
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
> |  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [i
> e]
> |  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:
> [inline]
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
> |  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [i
> e]
> |  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:
> [inline]
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
> Fix it by having struct l2cap_chan hold a reference to l2cap_conn
> (conn_ref) when the channel is added to the connection, and releasing it
> in the channel destructor. This ensures the connection remains alive as
> long as the channel exists. While conn and conn_ref point to the same
> object, conn being NULL indicates it being torn down, while conn_ref's
> only purpose is to associate its lifetime with the parent channel.
>
> Fixes: 75780ca4c6a8 ("Bluetooth: L2CAP: use chan timer to close channe
> ls in cleanup_listen()")
> Cc: <stable@vger.kernel.org>
> Cc: Siwei Zhang <oss@fourdim.xyz>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-o
> ss%40fourdim.xyz
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 15 +++++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index e0a1f2293679..de3673149deb 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -514,6 +514,7 @@ struct l2cap_seq_list {
>
>  struct l2cap_chan {
>         struct l2cap_conn       *conn;
> +       struct l2cap_conn       *conn_ref;
>         struct kref     kref;
>         atomic_t        nesting;
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index c4ccfbda9d78..7f331a31b723 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -422,6 +422,9 @@ static void l2cap_chan_timeout(struct work_struct *wo=
rk)
>          */
>         l2cap_chan_lock(chan);
>
> +       if (!chan->conn)
> +               goto unlock;
> +
>         if (chan->state =3D=3D BT_CONNECTED || chan->state =3D=3D BT_CONF=
IG)
>                 reason =3D ECONNREFUSED;
>         else if (chan->state =3D=3D BT_CONNECT &&
> @@ -434,10 +437,10 @@ static void l2cap_chan_timeout(struct work_struct *=
work)
>
>         chan->ops->close(chan);
>
> +unlock:
>         l2cap_chan_unlock(chan);
> -       l2cap_chan_put(chan);
> -
>         mutex_unlock(&conn->lock);
> +       l2cap_chan_put(chan);
>  }
>
>  struct l2cap_chan *l2cap_chan_create(void)
> @@ -490,6 +493,9 @@ static void l2cap_chan_destroy(struct kref *kref)
>         list_del(&chan->global_l);
>         write_unlock(&chan_list_lock);
>
> +       if (chan->conn_ref)
> +               l2cap_conn_put(chan->conn_ref);
> +
>         kfree(chan);
>  }
>
> @@ -594,6 +600,7 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct=
 l2cap_chan *chan)
>         conn->disc_reason =3D HCI_ERROR_REMOTE_USER_TERM;
>
>         chan->conn =3D conn;
> +       chan->conn_ref =3D l2cap_conn_get(conn);
>
>         switch (chan->chan_type) {
>         case L2CAP_CHAN_CONN_ORIENTED:
> @@ -3160,12 +3167,16 @@ static void l2cap_ack_timeout(struct work_struct =
*work)
>
>         l2cap_chan_lock(chan);
>
> +       if (!chan->conn)
> +               goto unlock;
> +
>         frames_to_ack =3D __seq_offset(chan, chan->buffer_seq,
>                                      chan->last_acked_seq);
>
>         if (frames_to_ack)
>                 l2cap_send_rr_or_rnr(chan, 0);
>
> +unlock:
>         l2cap_chan_unlock(chan);
>         l2cap_chan_put(chan);
>  }
> --
> 2.54.0.1032.g2f8565e1d1-goog

Looks good, please a spim a patch since just pasting like the above
doesn't seem to trigger PW and CI/CD run.

--=20
Luiz Augusto von Dentz
