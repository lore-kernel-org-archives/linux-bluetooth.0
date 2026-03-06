Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBA136C9D1
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 19:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772825002; cv=pass; b=I9LFkuKWRss0RlkrUeg5nUf3+jARwHVHO4wPjySuM30wlAVpLCiONkDGaljbqZaLE1IwUcgQbUQMNG6Oi7ooxHoNRpsUgX18xjmj49Mk+nqSv3UDqyzxN9cxYhwTJx6ObpZ7NVEnq4V6jXiae3DcoBEpHDL7W/gh+72zcFcSVrc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772825002; c=relaxed/simple;
	bh=nVkyuQgSh/PCZfLQELLPXO24ezzXYThqBNXscemi3mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQysXpL6XqmqQlvn3xvaeEh9ArajmgEb2MsCCKu/PsrrRwdQV640Y7IsjiPSQ01wZtcF75YsH+/UsGwbSrNkH3sr5fa5hxwjG9PDBx6usqF83v19yhOGA5yUYZ9VqROmjaCrmi69WaISdHZvxZRaSFURj9hcd1ktheZ2w7P/eWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzRk4Bji; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzRk4Bji"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64c9707fc11so7230689d50.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Mar 2026 11:23:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772824999; cv=none;
        d=google.com; s=arc-20240605;
        b=iOr5DTES5IlW02+zMQIi/wc0lVpPLQB1THrsJCwyB1+9BUGNeOlf7BmNPYSjB71d/R
         yZzxwBRkaK+LuItnyH04po8C8Q13kp8H0M1VQJeM7/kT9co00ZbYOfgDe3BmQ2rfNqv0
         I7gk0utQxe0dd9pGNnWfC+vzl/y0/ZRIQaWYjwccm8aLOO6HmbV9JNRgRu8WA2N9WP4R
         ZekISqGZySIEe2kxvKOB0dJxkX2mTPDz2SrP1jn9r8UMzN0kOK0sFzVVzS0vt1KfTn27
         HTeBrk6OsWFCUpKwls7h486ctAF44c6dzYpYG1mfvP1J2+/6md6hEptiiJCcexMeLcHj
         OCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MzhEkHUKtMFIE+Lu3b/lyo+Npxh5y6jriu3QSriEyco=;
        fh=fAVvqa29TMCSLQ1BWo+IkeTh9vOt2h2EvlnFWIq0DOI=;
        b=exbhtu0sws0yxbapI65Ok/qOqhOu+wySqSN6skGMg1tiggCkSWblx/1L/T2IGcg+AF
         nx0fN6DIFWNdUmTSbncTFOIosUo2H2T0doIo9bqYa+lgcMqaKAlf+mtPP8dDYN7/HIVj
         5KGHCUz37MkFYaCyWfIOep+CUBiR6E4CA3KHNOAXRtDGBFbTIu0Tm2S0Vbd5msA8pwqH
         U48FVV5lNmFgpdtQ+S1osm8yjHs23h7iDHjMQ6frUNp3pOznZgh1ruG6zaoydP4cST0Q
         8y8RPuK+qphuzsI3KeLW8DgjtDk+fOPfr+BiXARV7G86XlJYt4cyGEGffiPYMS2+vPil
         0/Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772824999; x=1773429799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzhEkHUKtMFIE+Lu3b/lyo+Npxh5y6jriu3QSriEyco=;
        b=ZzRk4BjiWBEg8WPAph7hkiqasT+byIcbgVKVjniuLq4yEpdEYiI6UljEO/TB3Gmknf
         M3YZIGxsjabqMDwfpIaHfK0tyD6MT3nmoU0Fjfjm8BlOEfDQoM9ujfxD+2QmyyfKxRUX
         6iVz3DG1B0R4SR0yUX/HaF8eHHmAWM7IlgRLUBOkGapA68gYdwKTLH4CtY80Bk6LTr7a
         M9ETtN3UQMrJUVfnnN36fthopG50bkPPPKNrCN9tuCPLIbGE3+UTSeylRQqanx/s89VO
         FT7N2qVQcTptjuxPjg0tJHcQWow1B+3hw2lePRKmOk4oZIscPfJvRhWxLnlpDjD2/2v1
         Dtzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772824999; x=1773429799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MzhEkHUKtMFIE+Lu3b/lyo+Npxh5y6jriu3QSriEyco=;
        b=C9dTpKiUIvOJfobvmGOk/Pb0iiS82CRZSqXWMMm4KetZ0h4qhVfJVeZyz7WLN6+UjQ
         V6jrWxJvZ/4yUrQsW6jbQt7VVIQn6XDgDUrEnvFGQVZK/QdW0FZ0bJYodw3snP5B5bjr
         TTeSRcDD6d6228IlTX9T9apYndbx7CxScuvx30e1Yl5lBxD6DEzDSruLdlvNIucZZNgI
         QfIw/F/lIJ5rkQ56c6HDuMIeOkDF/kQcUbY2D8fNyqyicXTVe/ANI2xIlf+t2Iq9xsjw
         N1hDW9sgrf5Hofx46V0LFgdj2LTO1pxTmG73510qeDh5PkZEVuj2mayAmjmqYxW5x1Dv
         lV6w==
X-Gm-Message-State: AOJu0YwB87aouTz15iG32T/IEc4IZgXZneloq+e8C+lyN8o3DTib2ZDj
	KSNygDKsoUDCYHOPXI25y1yyxF+QGUEh5bCnZr+o7PlzbXyrc+WUojv8631mONBs5HvY8uRzsj5
	BQjE5+k+De9kUMsb1PlHi3JLKvKOwPLxxaQ==
X-Gm-Gg: ATEYQzy8x2a2y+ZYUIQ4DR3NCsmGG8vIelgRQitWvpiCdBGYLNXRqxwjdcChOLr0h8r
	Mr2VVekp8ZvnQQER8DQlMqmF4RD1lLPnX8GQ0Ihxt9SG7GehJcv6skfE63UUJbiDp8FBga//uw/
	cNGdcTc9ekFMAPigRVm9dHjQwPUEjXja939T9+JEMLDYMOLrvSCIYeg44MKxRFRGFBSehdee73K
	sL3OkEWP6yUUUu2W6C4qA5uqYwGLFqJbvRL9+b8OiNz9qCvDYnASLQpaxRxTppFcnhM8EHeAfCk
	2qmAvTNWemUIKxjWfn2zUnkYFVpkbXMi7xT6kD/3o1W4utO9DBwe3LVqSvYg623S/YwJiw==
X-Received: by 2002:a05:690e:1409:b0:649:b6d1:d589 with SMTP id
 956f58d0204a3-64d140f3175mr3207102d50.19.1772824998713; Fri, 06 Mar 2026
 11:23:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306023155.554597-1-luiz.dentz@gmail.com> <6424bfa07b5844d1149367413ce7c353f0cdad02.camel@iki.fi>
In-Reply-To: <6424bfa07b5844d1149367413ce7c353f0cdad02.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 6 Mar 2026 14:23:07 -0500
X-Gm-Features: AaiRm539XZQXo6VheH5FrfelK00v9D7kl9KkDvLnA4RjCpHkGYLG-9bdHweI2j0
Message-ID: <CABBYNZ+BstyONrGGV75jUgfpVbTvgZ0vcPmyEsn0B8rp9Tbu6g@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: HIDP: Fix possible UAF
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Fri, Mar 6, 2026 at 1:49=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> to, 2026-03-05 kello 21:31 -0500, Luiz Augusto von Dentz kirjoitti:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This fixes the following trace caused by not dropping l2cap_conn
> > reference when user->remove callback is called:
> >
> > [   97.809249] l2cap_conn_free: freeing conn ffff88810a171c00
> > [   97.809907] CPU: 1 UID: 0 PID: 1419 Comm: repro_standalon Not tainte=
d 7.0.0-rc1-dirty #14 PREEMPT(lazy)
> > [   97.809935] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.17.0-debian-1.17.0-1 04/01/2014
> > [   97.809947] Call Trace:
> > [   97.809954]  <TASK>
> > [   97.809961]  dump_stack_lvl (lib/dump_stack.c:122)
> > [   97.809990]  l2cap_conn_free (net/bluetooth/l2cap_core.c:1808)
> > [   97.810017]  l2cap_conn_del (./include/linux/kref.h:66 net/bluetooth=
/l2cap_core.c:1821 net/bluetooth/l2cap_core.c:1798)
> > [   97.810055]  l2cap_disconn_cfm (net/bluetooth/l2cap_core.c:7347 (dis=
criminator 1) net/bluetooth/l2cap_core.c:7340 (discriminator 1))
> > [   97.810086]  ? __pfx_l2cap_disconn_cfm (net/bluetooth/l2cap_core.c:7=
341)
> > [   97.810117]  hci_conn_hash_flush (./include/net/bluetooth/hci_core.h=
:2152 (discriminator 2) net/bluetooth/hci_conn.c:2644 (discriminator 2))
> > [   97.810148]  hci_dev_close_sync (net/bluetooth/hci_sync.c:5360)
> > [   97.810180]  ? __pfx_hci_dev_close_sync (net/bluetooth/hci_sync.c:52=
85)
> > [   97.810212]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   97.810242]  ? up_write (./arch/x86/include/asm/atomic64_64.h:87 (di=
scriminator 5) ./include/linux/atomic/atomic-arch-fallback.h:2852 (discrimi=
nator 5) ./include/linux/atomic/atomic-long.h:268 (discriminator 5) ./inclu=
de/linux/atomic/atomic-instrumented.h:3391 (discriminator 5) kernel/locking=
/rwsem.c:1385 (discriminator 5) kernel/locking/rwsem.c:1643 (discriminator =
5))
> > [   97.810267]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   97.810290]  ? rcu_is_watching (./arch/x86/include/asm/atomic.h:23 .=
/include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/context_tr=
acking.h:128 kernel/rcu/tree.c:752)
> > [   97.810320]  hci_unregister_dev (net/bluetooth/hci_core.c:504 net/bl=
uetooth/hci_core.c:2716)
> > [   97.810346]  vhci_release (drivers/bluetooth/hci_vhci.c:691)
> > [   97.810375]  ? __pfx_vhci_release (drivers/bluetooth/hci_vhci.c:678)
> > [   97.810404]  __fput (fs/file_table.c:470)
> > [   97.810430]  task_work_run (kernel/task_work.c:235)
> > [   97.810451]  ? __pfx_task_work_run (kernel/task_work.c:201)
> > [   97.810472]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   97.810495]  ? do_raw_spin_unlock (./include/asm-generic/qspinlock.h=
:128 (discriminator 5) kernel/locking/spinlock_debug.c:142 (discriminator 5=
))
> > [   97.810527]  do_exit (kernel/exit.c:972)
> > [   97.810547]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   97.810574]  ? __pfx_do_exit (kernel/exit.c:897)
> > [   97.810594]  ? lock_acquire (kernel/locking/lockdep.c:470 (discrimin=
ator 6) kernel/locking/lockdep.c:5870 (discriminator 6) kernel/locking/lock=
dep.c:5825 (discriminator 6))
> > [   97.810616]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   97.810639]  ? do_raw_spin_lock (kernel/locking/spinlock_debug.c:95 =
(discriminator 4) kernel/locking/spinlock_debug.c:118 (discriminator 4))
> > [   97.810664]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   97.810688]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discri=
minator 1))
> > [   97.810721]  do_group_exit (kernel/exit.c:1093)
> > [   97.810745]  get_signal (kernel/signal.c:3007 (discriminator 1))
> > [   97.810772]  ? security_file_permission (./arch/x86/include/asm/jump=
_label.h:37 security/security.c:2366)
> > [   97.810803]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   97.810826]  ? vfs_read (fs/read_write.c:555)
> > [   97.810854]  ? __pfx_get_signal (kernel/signal.c:2800)
> > [   97.810880]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   97.810905]  ? __pfx_vfs_read (fs/read_write.c:555)
> > [   97.810932]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   97.810960]  arch_do_signal_or_restart (arch/x86/kernel/signal.c:337=
 (discriminator 1))
> > [   97.810990]  ? __pfx_arch_do_signal_or_restart (arch/x86/kernel/sign=
al.c:334)
> > [   97.811021]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   97.811055]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   97.811078]  ? ksys_read (fs/read_write.c:707)
> > [   97.811106]  ? __pfx_ksys_read (fs/read_write.c:707)
> > [   97.811137]  exit_to_user_mode_loop (kernel/entry/common.c:66 kernel=
/entry/common.c:98)
> > [   97.811169]  ? rcu_is_watching (./arch/x86/include/asm/atomic.h:23 .=
/include/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/context_tr=
acking.h:128 kernel/rcu/tree.c:752)
> > [   97.811192]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   97.811215]  ? trace_hardirqs_off (./include/trace/events/preemptirq=
.h:36 (discriminator 33) kernel/trace/trace_preemptirq.c:95 (discriminator =
33) kernel/trace/trace_preemptirq.c:90 (discriminator 33))
> > [   97.811240]  do_syscall_64 (./include/linux/irq-entry-common.h:226 .=
/include/linux/irq-entry-common.h:256 ./include/linux/entry-common.h:325 ar=
ch/x86/entry/syscall_64.c:100)
> > [   97.811268]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   97.811292]  ? exc_page_fault (arch/x86/mm/fault.c:1480 (discriminat=
or 3) arch/x86/mm/fault.c:1527 (discriminator 3))
> > [   97.811318]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64=
.S:130)
> > [   97.811338] RIP: 0033:0x445cfe
> > [   97.811352] Code: Unable to access opcode bytes at 0x445cd4.
> >
> > Code starting with the faulting instruction
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   97.811360] RSP: 002b:00007f65c41c6dc8 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000000
> > [   97.811378] RAX: fffffffffffffe00 RBX: 00007f65c41c76c0 RCX: 0000000=
000445cfe
> > [   97.811391] RDX: 0000000000000400 RSI: 00007f65c41c6e40 RDI: 0000000=
000000004
> > [   97.811403] RBP: 00007f65c41c7250 R08: 0000000000000000 R09: 0000000=
000000000
> > [   97.811415] R10: 0000000000000000 R11: 0000000000000246 R12: fffffff=
fffffffe8
> > [   97.811428] R13: 0000000000000000 R14: 00007fff780a8c00 R15: 00007f6=
5c41c76c0
> > [   97.811453]  </TASK>
> > [   98.402453] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   98.403560] BUG: KASAN: use-after-free in __mutex_lock (kernel/locki=
ng/mutex.c:199 kernel/locking/mutex.c:694 kernel/locking/mutex.c:776)
> > [   98.404541] Read of size 8 at addr ffff888113ee40a8 by task khidpd_0=
0050004/1430
> > [   98.405361]
> > [   98.405563] CPU: 1 UID: 0 PID: 1430 Comm: khidpd_00050004 Not tainte=
d 7.0.0-rc1-dirty #14 PREEMPT(lazy)
> > [   98.405588] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.17.0-debian-1.17.0-1 04/01/2014
> > [   98.405600] Call Trace:
> > [   98.405607]  <TASK>
> > [   98.405614]  dump_stack_lvl (lib/dump_stack.c:122)
> > [   98.405641]  print_report (mm/kasan/report.c:379 mm/kasan/report.c:4=
82)
> > [   98.405667]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.405691]  ? __virt_addr_valid (arch/x86/mm/physaddr.c:55)
> > [   98.405724]  ? __mutex_lock (kernel/locking/mutex.c:199 kernel/locki=
ng/mutex.c:694 kernel/locking/mutex.c:776)
> > [   98.405748]  kasan_report (mm/kasan/report.c:221 mm/kasan/report.c:5=
97)
> > [   98.405778]  ? __mutex_lock (kernel/locking/mutex.c:199 kernel/locki=
ng/mutex.c:694 kernel/locking/mutex.c:776)
> > [   98.405807]  __mutex_lock (kernel/locking/mutex.c:199 kernel/locking=
/mutex.c:694 kernel/locking/mutex.c:776)
> > [   98.405832]  ? do_raw_spin_lock (kernel/locking/spinlock_debug.c:95 =
(discriminator 4) kernel/locking/spinlock_debug.c:118 (discriminator 4))
> > [   98.405859]  ? l2cap_unregister_user (./include/linux/list.h:381 (di=
scriminator 2) net/bluetooth/l2cap_core.c:1723 (discriminator 2))
> > [   98.405888]  ? __pfx_do_raw_spin_lock (kernel/locking/spinlock_debug=
.c:114)
> > [   98.405915]  ? __pfx___mutex_lock (kernel/locking/mutex.c:775)
> > [   98.405939]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.405963]  ? lock_acquire (kernel/locking/lockdep.c:470 (discrimin=
ator 6) kernel/locking/lockdep.c:5870 (discriminator 6) kernel/locking/lock=
dep.c:5825 (discriminator 6))
> > [   98.405984]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discri=
minator 1))
> > [   98.406015]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.406038]  ? lock_release (kernel/locking/lockdep.c:5536 kernel/lo=
cking/lockdep.c:5889 kernel/locking/lockdep.c:5875)
> > [   98.406061]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.406085]  ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/i=
rqflags.h:42 ./arch/x86/include/asm/irqflags.h:119 ./arch/x86/include/asm/i=
rqflags.h:159 ./include/linux/spinlock_api_smp.h:178 kernel/locking/spinloc=
k.c:194)
> > [   98.406107]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.406130]  ? __timer_delete_sync (kernel/time/timer.c:1592)
> > [   98.406158]  ? l2cap_unregister_user (./include/linux/list.h:381 (di=
scriminator 2) net/bluetooth/l2cap_core.c:1723 (discriminator 2))
> > [   98.406186]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.406210]  l2cap_unregister_user (./include/linux/list.h:381 (disc=
riminator 2) net/bluetooth/l2cap_core.c:1723 (discriminator 2))
> > [   98.406263]  hidp_session_thread (./include/linux/instrumented.h:112=
 ./include/linux/atomic/atomic-instrumented.h:400 ./include/linux/refcount.=
h:389 ./include/linux/refcount.h:432 ./include/linux/refcount.h:450 ./inclu=
de/linux/kref.h:64 net/bluetooth/hidp/core.c:996 net/bluetooth/hidp/core.c:=
1305)
> > [   98.406293]  ? __pfx_hidp_session_thread (net/bluetooth/hidp/core.c:=
1264)
> > [   98.406323]  ? kthread (kernel/kthread.c:433)
> > [   98.406340]  ? __pfx_hidp_session_wake_function (net/bluetooth/hidp/=
core.c:1251)
> > [   98.406370]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.406393]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discri=
minator 1))
> > [   98.406424]  ? __pfx_hidp_session_wake_function (net/bluetooth/hidp/=
core.c:1251)
> > [   98.406453]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.406476]  ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:79=
 (discriminator 1))
> > [   98.406499]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.406523]  ? kthread (kernel/kthread.c:433)
> > [   98.406539]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.406565]  ? kthread (kernel/kthread.c:433)
> > [   98.406581]  ? __pfx_hidp_session_thread (net/bluetooth/hidp/core.c:=
1264)
> > [   98.406610]  kthread (kernel/kthread.c:467)
> > [   98.406627]  ? __pfx_kthread (kernel/kthread.c:412)
> > [   98.406645]  ret_from_fork (arch/x86/kernel/process.c:164)
> > [   98.406674]  ? __pfx_ret_from_fork (arch/x86/kernel/process.c:153)
> > [   98.406704]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.406728]  ? __pfx_kthread (kernel/kthread.c:412)
> > [   98.406747]  ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
> > [   98.406774]  </TASK>
> > [   98.406780]
> > [   98.433693] The buggy address belongs to the physical page:
> > [   98.434405] page: refcount:0 mapcount:0 mapping:0000000000000000 ind=
ex:0xffff888113ee7c40 pfn:0x113ee4
> > [   98.435557] flags: 0x200000000000000(node=3D0|zone=3D2)
> > [   98.436198] raw: 0200000000000000 ffffea0004244308 ffff8881f6f3ebc0 =
0000000000000000
> > [   98.437195] raw: ffff888113ee7c40 0000000000000000 00000000ffffffff =
0000000000000000
> > [   98.438115] page dumped because: kasan: bad access detected
> > [   98.438951]
> > [   98.439211] Memory state around the buggy address:
> > [   98.439871]  ffff888113ee3f80: fc fc fc fc fc fc fc fc fc fc fc fc f=
c fc fc fc
> > [   98.440714]  ffff888113ee4000: ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff ff ff
> > [   98.441580] >ffff888113ee4080: ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff ff ff
> > [   98.442458]                                   ^
> > [   98.443011]  ffff888113ee4100: ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff ff ff
> > [   98.443889]  ffff888113ee4180: ff ff ff ff ff ff ff ff ff ff ff ff f=
f ff ff ff
> > [   98.444768] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [   98.445719] Disabling lock debugging due to kernel taint
> > [   98.448074] l2cap_conn_free: freeing conn ffff88810c22b400
> > [   98.450012] CPU: 1 UID: 0 PID: 1430 Comm: khidpd_00050004 Tainted: G=
    B               7.0.0-rc1-dirty #14 PREEMPT(lazy)
> > [   98.450040] Tainted: [B]=3DBAD_PAGE
> > [   98.450047] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.17.0-debian-1.17.0-1 04/01/2014
> > [   98.450059] Call Trace:
> > [   98.450065]  <TASK>
> > [   98.450071]  dump_stack_lvl (lib/dump_stack.c:122)
> > [   98.450099]  l2cap_conn_free (net/bluetooth/l2cap_core.c:1808)
> > [   98.450125]  l2cap_conn_put (net/bluetooth/l2cap_core.c:1822)
> > [   98.450154]  session_free (net/bluetooth/hidp/core.c:990)
> > [   98.450181]  hidp_session_thread (net/bluetooth/hidp/core.c:1307)
> > [   98.450213]  ? __pfx_hidp_session_thread (net/bluetooth/hidp/core.c:=
1264)
> > [   98.450271]  ? kthread (kernel/kthread.c:433)
> > [   98.450293]  ? __pfx_hidp_session_wake_function (net/bluetooth/hidp/=
core.c:1251)
> > [   98.450339]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.450368]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discri=
minator 1))
> > [   98.450406]  ? __pfx_hidp_session_wake_function (net/bluetooth/hidp/=
core.c:1251)
> > [   98.450442]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.450471]  ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:79=
 (discriminator 1))
> > [   98.450499]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.450528]  ? kthread (kernel/kthread.c:433)
> > [   98.450547]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.450578]  ? kthread (kernel/kthread.c:433)
> > [   98.450598]  ? __pfx_hidp_session_thread (net/bluetooth/hidp/core.c:=
1264)
> > [   98.450637]  kthread (kernel/kthread.c:467)
> > [   98.450657]  ? __pfx_kthread (kernel/kthread.c:412)
> > [   98.450680]  ret_from_fork (arch/x86/kernel/process.c:164)
> > [   98.450715]  ? __pfx_ret_from_fork (arch/x86/kernel/process.c:153)
> > [   98.450752]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221=
)
> > [   98.450782]  ? __pfx_kthread (kernel/kthread.c:412)
> > [   98.450804]  ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
> > [   98.450836]  </TASK>
> >
> > Fixes: b4f34d8d9d26 ("Bluetooth: hidp: add new session-management helpe=
rs")
> > Reported-by: soufiane el hachmi <kilwa10@gmail.com>
> > Tested-by: soufiane el hachmi <kilwa10@gmail.com>
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  net/bluetooth/hidp/core.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> > index 6724adce615b..e0e400381550 100644
> > --- a/net/bluetooth/hidp/core.c
> > +++ b/net/bluetooth/hidp/core.c
> > @@ -986,7 +986,8 @@ static void session_free(struct kref *ref)
> >       skb_queue_purge(&session->intr_transmit);
> >       fput(session->intr_sock->file);
> >       fput(session->ctrl_sock->file);
> > -     l2cap_conn_put(session->conn);
> > +     if (session->conn)
> > +             l2cap_conn_put(session->conn);
> >       kfree(session);
> >  }
> >
> > @@ -1164,6 +1165,15 @@ static void hidp_session_remove(struct l2cap_con=
n *conn,
> >
> >       down_write(&hidp_session_sem);
> >
> > +     /* Drop L2CAP reference immediately to indicate that
> > +      * l2cap_unregister_user() shall not be called as it is already
> > +      * considered removed.
> > +      */
> > +     if (session->conn) {
> > +             l2cap_conn_put(session->conn);
> > +             session->conn =3D NULL;
> > +     }
> > +
> >       hidp_session_terminate(session);
> >
> >       cancel_work_sync(&session->dev_init);
> > @@ -1301,7 +1311,9 @@ static int hidp_session_thread(void *arg)
> >        * Instead, this call has the same semantics as if user-space tri=
ed to
> >        * delete the session.
> >        */
> > -     l2cap_unregister_user(session->conn, &session->user);
> > +     if (session->conn)
> > +             l2cap_unregister_user(session->conn, &session->user);
>
> Does this TOCTOU on session->conn:
>
> [Task 1]                             [Task 2]
> hci_dev_lock()
>   l2cap_disconn_cfm()
>     l2cap_conn_del()
>                                      if (session->conn)
>       hidp_session_remove()
>       l2cap_conn_free()
>                                        l2cap_unregister_user()
>                                          hdev =3D conn->hcon->hdev <UAF>
>
> I wonder if it is same issue as
> https://syzkaller.appspot.com/bug?extid=3D14b6d57fb728e27ce23c
>
> and I remember the earlier patch that tries to address the race via
> changing the locking:
>
> https://lore.kernel.org/all/20251106182016.26508-1-ssranevjti@gmail.com/

Interesting, this one might have slipped through. It seems valid and
looks like it would address the TOCTOU, let me check with the reporter
if the above fix the problem as well then we migh just drop the change
setting the l2cap_conn to NULL.

>
> AFAICS, done that way the call to l2cap_unregister_user() in
> hidp_session_thread() should be noop via the !list_empty(&user->list)
> branch, as the hidp_session_remove() already ran. session->conn would
> remain until it is put when session->ref refcount goes to zero.
>
>
> > +
> >       hidp_session_put(session);
> >
> >       module_put_and_kthread_exit(0);
>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
