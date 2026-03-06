Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79DC145355
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 18:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822987; cv=pass; b=oVK7vPQ3MNoyA3dJsb2vrunxomxqILtTFFR1Ehww/aamIftPYG5+ZFPDiTB7IdBrB5HaLwhOnpec0u2/RIzfI0kaZlzynkPvDaElMNaKf3W+XtlOlS0cJAtNK6+8gqFQr/xL5XgG94MSdjJr/ZSdufgFPbL5wXVy0qGQp0gEkkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822987; c=relaxed/simple;
	bh=x5LO9TnVJnv/KbIA8A28jd2gtc9Z2axLoYs6stvvc0s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aOBvPlHXV+EAxAhTMGLr2lyJq6P6x3XWSLuUMg9Nx+JpHicjcysbBRz1h4p5iemkFCHVC7zyTJnyR9Vb4CG6Ji6+izJxCD8N55bVoQlPPqUiWMmCWJ/ZODqbUNJTM9Mtsyn7BSqTuJFXVoxzBSUmZ1yZMbilsTxAzPUUxprAR8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=TVfrLjp8; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="TVfrLjp8"
Received: from [192.168.1.195] (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fSFnR4bxrz49Q6d;
	Fri, 06 Mar 2026 20:49:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1772822972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qBaAraKN+ROi+B6xIEfwQbl7C+z1DsDIWumip+yUJRE=;
	b=TVfrLjp84EIcnD7wP+EO5++UbRXd+GkFMW/MiYSe9+799Lboxnt0wGn8UQa5ruRoimgypu
	RDysiiDuymgzJYv3S1fMI0Zjn4YmRFcnpHbG9OwPQ6pEW3MYflV7WuZ4G4WhTWsaOf5eYT
	byQho3a+iwMBVrmSP9TyfhTfuh3xgsHzfgrQYV72pqdi+ikxV017LKD9N5hlb6l7UQynOE
	pXXba9aVNSMndwwMOuTU+j72WJO7FrFcVW+luDND9+/E7cahd2S/Ej4r7y5S0hh62uBZyj
	f+LS8pcZ8J1p2GK1tAyHSyVgV3NNycWLDfttbJxRku3Jc3AFnZEGFFjLS7Hx7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1772822972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qBaAraKN+ROi+B6xIEfwQbl7C+z1DsDIWumip+yUJRE=;
	b=rH2JkSB0vj3ArK+TOStuEXwF6mWsOXNpEq19WXcpvnM6N/IRCjRZZtdo/ezSoSVJlylgyB
	TdQ223jPsvgpe34/CBiRM6+X6MS1TRCjPcST3OGp74sqaQB0HX/YdqYXNJHpIETbcETMjh
	SXOT8kGQmUnMnUz2rkYu+fYQQJIbKUHGHrmro8sX8kH/q/oUBP/CH3y7IU7wru5NI7bmak
	OP35Xyp+ne0Rth5EI6IXLOY4nrGO+m3zDOqJlzq5MXQaUSVMZSh2oWHOnF0fUue28gqrUA
	FcOvOKpkEGz84Zid0NgYhT1W5QZi0Jiml7zzXZ+8GUYFetJEWI9h5KGfeAa2/A==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1772822972;
	b=ck2w/wm+5ZLa/6H7w0KR5A0sEjxF9Yy3xM3iQVOGaXHDOArJOvWDFW9sK4m5sje3QedtMk
	+sG9mzPZp94lcmu0qsd5uBDf5ymvh+WnH8FXf15hQm0Ci32mNi9L1OApMQGAfx0XwlHl2F
	5He+E5S6KY5itEFWRsW496laPpcLp3OdNFE9NbqxIrZh2Wd6KXeyQcKz7PzEX1Hjg3bVeo
	iM7bnSt5dnxHwwqRPA1Ll58DCl0uK7ExCYkSSIQgdSBjP4CAKwbUtgnv7bOznBNO2FPhJ6
	asaGxUq0FeZgxIicAkLmXrGfE8VDP17dw9E292+tcch/plODxYqZgnm0ho2CZw==
Message-ID: <6424bfa07b5844d1149367413ce7c353f0cdad02.camel@iki.fi>
Subject: Re: [PATCH v1] Bluetooth: HIDP: Fix possible UAF
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Date: Fri, 06 Mar 2026 20:49:30 +0200
In-Reply-To: <20260306023155.554597-1-luiz.dentz@gmail.com>
References: <20260306023155.554597-1-luiz.dentz@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

to, 2026-03-05 kello 21:31 -0500, Luiz Augusto von Dentz kirjoitti:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>=20
> This fixes the following trace caused by not dropping l2cap_conn
> reference when user->remove callback is called:
>=20
> [   97.809249] l2cap_conn_free: freeing conn ffff88810a171c00
> [   97.809907] CPU: 1 UID: 0 PID: 1419 Comm: repro_standalon Not tainted =
7.0.0-rc1-dirty #14 PREEMPT(lazy)
> [   97.809935] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.17.0-debian-1.17.0-1 04/01/2014
> [   97.809947] Call Trace:
> [   97.809954]  <TASK>
> [   97.809961]  dump_stack_lvl (lib/dump_stack.c:122)
> [   97.809990]  l2cap_conn_free (net/bluetooth/l2cap_core.c:1808)
> [   97.810017]  l2cap_conn_del (./include/linux/kref.h:66 net/bluetooth/l=
2cap_core.c:1821 net/bluetooth/l2cap_core.c:1798)
> [   97.810055]  l2cap_disconn_cfm (net/bluetooth/l2cap_core.c:7347 (discr=
iminator 1) net/bluetooth/l2cap_core.c:7340 (discriminator 1))
> [   97.810086]  ? __pfx_l2cap_disconn_cfm (net/bluetooth/l2cap_core.c:734=
1)
> [   97.810117]  hci_conn_hash_flush (./include/net/bluetooth/hci_core.h:2=
152 (discriminator 2) net/bluetooth/hci_conn.c:2644 (discriminator 2))
> [   97.810148]  hci_dev_close_sync (net/bluetooth/hci_sync.c:5360)
> [   97.810180]  ? __pfx_hci_dev_close_sync (net/bluetooth/hci_sync.c:5285=
)
> [   97.810212]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810242]  ? up_write (./arch/x86/include/asm/atomic64_64.h:87 (disc=
riminator 5) ./include/linux/atomic/atomic-arch-fallback.h:2852 (discrimina=
tor 5) ./include/linux/atomic/atomic-long.h:268 (discriminator 5) ./include=
/linux/atomic/atomic-instrumented.h:3391 (discriminator 5) kernel/locking/r=
wsem.c:1385 (discriminator 5) kernel/locking/rwsem.c:1643 (discriminator 5)=
)
> [   97.810267]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810290]  ? rcu_is_watching (./arch/x86/include/asm/atomic.h:23 ./i=
nclude/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/context_trac=
king.h:128 kernel/rcu/tree.c:752)
> [   97.810320]  hci_unregister_dev (net/bluetooth/hci_core.c:504 net/blue=
tooth/hci_core.c:2716)
> [   97.810346]  vhci_release (drivers/bluetooth/hci_vhci.c:691)
> [   97.810375]  ? __pfx_vhci_release (drivers/bluetooth/hci_vhci.c:678)
> [   97.810404]  __fput (fs/file_table.c:470)
> [   97.810430]  task_work_run (kernel/task_work.c:235)
> [   97.810451]  ? __pfx_task_work_run (kernel/task_work.c:201)
> [   97.810472]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810495]  ? do_raw_spin_unlock (./include/asm-generic/qspinlock.h:1=
28 (discriminator 5) kernel/locking/spinlock_debug.c:142 (discriminator 5))
> [   97.810527]  do_exit (kernel/exit.c:972)
> [   97.810547]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810574]  ? __pfx_do_exit (kernel/exit.c:897)
> [   97.810594]  ? lock_acquire (kernel/locking/lockdep.c:470 (discriminat=
or 6) kernel/locking/lockdep.c:5870 (discriminator 6) kernel/locking/lockde=
p.c:5825 (discriminator 6))
> [   97.810616]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810639]  ? do_raw_spin_lock (kernel/locking/spinlock_debug.c:95 (d=
iscriminator 4) kernel/locking/spinlock_debug.c:118 (discriminator 4))
> [   97.810664]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810688]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discrimi=
nator 1))
> [   97.810721]  do_group_exit (kernel/exit.c:1093)
> [   97.810745]  get_signal (kernel/signal.c:3007 (discriminator 1))
> [   97.810772]  ? security_file_permission (./arch/x86/include/asm/jump_l=
abel.h:37 security/security.c:2366)
> [   97.810803]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810826]  ? vfs_read (fs/read_write.c:555)
> [   97.810854]  ? __pfx_get_signal (kernel/signal.c:2800)
> [   97.810880]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810905]  ? __pfx_vfs_read (fs/read_write.c:555)
> [   97.810932]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.810960]  arch_do_signal_or_restart (arch/x86/kernel/signal.c:337 (=
discriminator 1))
> [   97.810990]  ? __pfx_arch_do_signal_or_restart (arch/x86/kernel/signal=
.c:334)
> [   97.811021]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.811055]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.811078]  ? ksys_read (fs/read_write.c:707)
> [   97.811106]  ? __pfx_ksys_read (fs/read_write.c:707)
> [   97.811137]  exit_to_user_mode_loop (kernel/entry/common.c:66 kernel/e=
ntry/common.c:98)
> [   97.811169]  ? rcu_is_watching (./arch/x86/include/asm/atomic.h:23 ./i=
nclude/linux/atomic/atomic-arch-fallback.h:457 ./include/linux/context_trac=
king.h:128 kernel/rcu/tree.c:752)
> [   97.811192]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.811215]  ? trace_hardirqs_off (./include/trace/events/preemptirq.h=
:36 (discriminator 33) kernel/trace/trace_preemptirq.c:95 (discriminator 33=
) kernel/trace/trace_preemptirq.c:90 (discriminator 33))
> [   97.811240]  do_syscall_64 (./include/linux/irq-entry-common.h:226 ./i=
nclude/linux/irq-entry-common.h:256 ./include/linux/entry-common.h:325 arch=
/x86/entry/syscall_64.c:100)
> [   97.811268]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   97.811292]  ? exc_page_fault (arch/x86/mm/fault.c:1480 (discriminator=
 3) arch/x86/mm/fault.c:1527 (discriminator 3))
> [   97.811318]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S=
:130)
> [   97.811338] RIP: 0033:0x445cfe
> [   97.811352] Code: Unable to access opcode bytes at 0x445cd4.
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   97.811360] RSP: 002b:00007f65c41c6dc8 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000000
> [   97.811378] RAX: fffffffffffffe00 RBX: 00007f65c41c76c0 RCX: 000000000=
0445cfe
> [   97.811391] RDX: 0000000000000400 RSI: 00007f65c41c6e40 RDI: 000000000=
0000004
> [   97.811403] RBP: 00007f65c41c7250 R08: 0000000000000000 R09: 000000000=
0000000
> [   97.811415] R10: 0000000000000000 R11: 0000000000000246 R12: fffffffff=
fffffe8
> [   97.811428] R13: 0000000000000000 R14: 00007fff780a8c00 R15: 00007f65c=
41c76c0
> [   97.811453]  </TASK>
> [   98.402453] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   98.403560] BUG: KASAN: use-after-free in __mutex_lock (kernel/locking=
/mutex.c:199 kernel/locking/mutex.c:694 kernel/locking/mutex.c:776)
> [   98.404541] Read of size 8 at addr ffff888113ee40a8 by task khidpd_000=
50004/1430
> [   98.405361]
> [   98.405563] CPU: 1 UID: 0 PID: 1430 Comm: khidpd_00050004 Not tainted =
7.0.0-rc1-dirty #14 PREEMPT(lazy)
> [   98.405588] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.17.0-debian-1.17.0-1 04/01/2014
> [   98.405600] Call Trace:
> [   98.405607]  <TASK>
> [   98.405614]  dump_stack_lvl (lib/dump_stack.c:122)
> [   98.405641]  print_report (mm/kasan/report.c:379 mm/kasan/report.c:482=
)
> [   98.405667]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.405691]  ? __virt_addr_valid (arch/x86/mm/physaddr.c:55)
> [   98.405724]  ? __mutex_lock (kernel/locking/mutex.c:199 kernel/locking=
/mutex.c:694 kernel/locking/mutex.c:776)
> [   98.405748]  kasan_report (mm/kasan/report.c:221 mm/kasan/report.c:597=
)
> [   98.405778]  ? __mutex_lock (kernel/locking/mutex.c:199 kernel/locking=
/mutex.c:694 kernel/locking/mutex.c:776)
> [   98.405807]  __mutex_lock (kernel/locking/mutex.c:199 kernel/locking/m=
utex.c:694 kernel/locking/mutex.c:776)
> [   98.405832]  ? do_raw_spin_lock (kernel/locking/spinlock_debug.c:95 (d=
iscriminator 4) kernel/locking/spinlock_debug.c:118 (discriminator 4))
> [   98.405859]  ? l2cap_unregister_user (./include/linux/list.h:381 (disc=
riminator 2) net/bluetooth/l2cap_core.c:1723 (discriminator 2))
> [   98.405888]  ? __pfx_do_raw_spin_lock (kernel/locking/spinlock_debug.c=
:114)
> [   98.405915]  ? __pfx___mutex_lock (kernel/locking/mutex.c:775)
> [   98.405939]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.405963]  ? lock_acquire (kernel/locking/lockdep.c:470 (discriminat=
or 6) kernel/locking/lockdep.c:5870 (discriminator 6) kernel/locking/lockde=
p.c:5825 (discriminator 6))
> [   98.405984]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discrimi=
nator 1))
> [   98.406015]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.406038]  ? lock_release (kernel/locking/lockdep.c:5536 kernel/lock=
ing/lockdep.c:5889 kernel/locking/lockdep.c:5875)
> [   98.406061]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.406085]  ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/irq=
flags.h:42 ./arch/x86/include/asm/irqflags.h:119 ./arch/x86/include/asm/irq=
flags.h:159 ./include/linux/spinlock_api_smp.h:178 kernel/locking/spinlock.=
c:194)
> [   98.406107]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.406130]  ? __timer_delete_sync (kernel/time/timer.c:1592)
> [   98.406158]  ? l2cap_unregister_user (./include/linux/list.h:381 (disc=
riminator 2) net/bluetooth/l2cap_core.c:1723 (discriminator 2))
> [   98.406186]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.406210]  l2cap_unregister_user (./include/linux/list.h:381 (discri=
minator 2) net/bluetooth/l2cap_core.c:1723 (discriminator 2))
> [   98.406263]  hidp_session_thread (./include/linux/instrumented.h:112 .=
/include/linux/atomic/atomic-instrumented.h:400 ./include/linux/refcount.h:=
389 ./include/linux/refcount.h:432 ./include/linux/refcount.h:450 ./include=
/linux/kref.h:64 net/bluetooth/hidp/core.c:996 net/bluetooth/hidp/core.c:13=
05)
> [   98.406293]  ? __pfx_hidp_session_thread (net/bluetooth/hidp/core.c:12=
64)
> [   98.406323]  ? kthread (kernel/kthread.c:433)
> [   98.406340]  ? __pfx_hidp_session_wake_function (net/bluetooth/hidp/co=
re.c:1251)
> [   98.406370]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.406393]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discrimi=
nator 1))
> [   98.406424]  ? __pfx_hidp_session_wake_function (net/bluetooth/hidp/co=
re.c:1251)
> [   98.406453]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.406476]  ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:79 (=
discriminator 1))
> [   98.406499]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.406523]  ? kthread (kernel/kthread.c:433)
> [   98.406539]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.406565]  ? kthread (kernel/kthread.c:433)
> [   98.406581]  ? __pfx_hidp_session_thread (net/bluetooth/hidp/core.c:12=
64)
> [   98.406610]  kthread (kernel/kthread.c:467)
> [   98.406627]  ? __pfx_kthread (kernel/kthread.c:412)
> [   98.406645]  ret_from_fork (arch/x86/kernel/process.c:164)
> [   98.406674]  ? __pfx_ret_from_fork (arch/x86/kernel/process.c:153)
> [   98.406704]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.406728]  ? __pfx_kthread (kernel/kthread.c:412)
> [   98.406747]  ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
> [   98.406774]  </TASK>
> [   98.406780]
> [   98.433693] The buggy address belongs to the physical page:
> [   98.434405] page: refcount:0 mapcount:0 mapping:0000000000000000 index=
:0xffff888113ee7c40 pfn:0x113ee4
> [   98.435557] flags: 0x200000000000000(node=3D0|zone=3D2)
> [   98.436198] raw: 0200000000000000 ffffea0004244308 ffff8881f6f3ebc0 00=
00000000000000
> [   98.437195] raw: ffff888113ee7c40 0000000000000000 00000000ffffffff 00=
00000000000000
> [   98.438115] page dumped because: kasan: bad access detected
> [   98.438951]
> [   98.439211] Memory state around the buggy address:
> [   98.439871]  ffff888113ee3f80: fc fc fc fc fc fc fc fc fc fc fc fc fc =
fc fc fc
> [   98.440714]  ffff888113ee4000: ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff ff ff
> [   98.441580] >ffff888113ee4080: ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff ff ff
> [   98.442458]                                   ^
> [   98.443011]  ffff888113ee4100: ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff ff ff
> [   98.443889]  ffff888113ee4180: ff ff ff ff ff ff ff ff ff ff ff ff ff =
ff ff ff
> [   98.444768] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   98.445719] Disabling lock debugging due to kernel taint
> [   98.448074] l2cap_conn_free: freeing conn ffff88810c22b400
> [   98.450012] CPU: 1 UID: 0 PID: 1430 Comm: khidpd_00050004 Tainted: G  =
  B               7.0.0-rc1-dirty #14 PREEMPT(lazy)
> [   98.450040] Tainted: [B]=3DBAD_PAGE
> [   98.450047] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.17.0-debian-1.17.0-1 04/01/2014
> [   98.450059] Call Trace:
> [   98.450065]  <TASK>
> [   98.450071]  dump_stack_lvl (lib/dump_stack.c:122)
> [   98.450099]  l2cap_conn_free (net/bluetooth/l2cap_core.c:1808)
> [   98.450125]  l2cap_conn_put (net/bluetooth/l2cap_core.c:1822)
> [   98.450154]  session_free (net/bluetooth/hidp/core.c:990)
> [   98.450181]  hidp_session_thread (net/bluetooth/hidp/core.c:1307)
> [   98.450213]  ? __pfx_hidp_session_thread (net/bluetooth/hidp/core.c:12=
64)
> [   98.450271]  ? kthread (kernel/kthread.c:433)
> [   98.450293]  ? __pfx_hidp_session_wake_function (net/bluetooth/hidp/co=
re.c:1251)
> [   98.450339]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.450368]  ? find_held_lock (kernel/locking/lockdep.c:5350 (discrimi=
nator 1))
> [   98.450406]  ? __pfx_hidp_session_wake_function (net/bluetooth/hidp/co=
re.c:1251)
> [   98.450442]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.450471]  ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:79 (=
discriminator 1))
> [   98.450499]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.450528]  ? kthread (kernel/kthread.c:433)
> [   98.450547]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.450578]  ? kthread (kernel/kthread.c:433)
> [   98.450598]  ? __pfx_hidp_session_thread (net/bluetooth/hidp/core.c:12=
64)
> [   98.450637]  kthread (kernel/kthread.c:467)
> [   98.450657]  ? __pfx_kthread (kernel/kthread.c:412)
> [   98.450680]  ret_from_fork (arch/x86/kernel/process.c:164)
> [   98.450715]  ? __pfx_ret_from_fork (arch/x86/kernel/process.c:153)
> [   98.450752]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:221)
> [   98.450782]  ? __pfx_kthread (kernel/kthread.c:412)
> [   98.450804]  ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
> [   98.450836]  </TASK>
>=20
> Fixes: b4f34d8d9d26 ("Bluetooth: hidp: add new session-management helpers=
")
> Reported-by: soufiane el hachmi <kilwa10@gmail.com>
> Tested-by: soufiane el hachmi <kilwa10@gmail.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hidp/core.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
> index 6724adce615b..e0e400381550 100644
> --- a/net/bluetooth/hidp/core.c
> +++ b/net/bluetooth/hidp/core.c
> @@ -986,7 +986,8 @@ static void session_free(struct kref *ref)
>  	skb_queue_purge(&session->intr_transmit);
>  	fput(session->intr_sock->file);
>  	fput(session->ctrl_sock->file);
> -	l2cap_conn_put(session->conn);
> +	if (session->conn)
> +		l2cap_conn_put(session->conn);
>  	kfree(session);
>  }
> =20
> @@ -1164,6 +1165,15 @@ static void hidp_session_remove(struct l2cap_conn =
*conn,
> =20
>  	down_write(&hidp_session_sem);
> =20
> +	/* Drop L2CAP reference immediately to indicate that
> +	 * l2cap_unregister_user() shall not be called as it is already
> +	 * considered removed.
> +	 */
> +	if (session->conn) {
> +		l2cap_conn_put(session->conn);
> +		session->conn =3D NULL;
> +	}
> +
>  	hidp_session_terminate(session);
> =20
>  	cancel_work_sync(&session->dev_init);
> @@ -1301,7 +1311,9 @@ static int hidp_session_thread(void *arg)
>  	 * Instead, this call has the same semantics as if user-space tried to
>  	 * delete the session.
>  	 */
> -	l2cap_unregister_user(session->conn, &session->user);
> +	if (session->conn)
> +		l2cap_unregister_user(session->conn, &session->user);

Does this TOCTOU on session->conn:

[Task 1]                             [Task 2]
hci_dev_lock()
  l2cap_disconn_cfm()
    l2cap_conn_del()
                                     if (session->conn)
      hidp_session_remove()
      l2cap_conn_free()
                                       l2cap_unregister_user()
                                         hdev =3D conn->hcon->hdev <UAF>

I wonder if it is same issue as
https://syzkaller.appspot.com/bug?extid=3D14b6d57fb728e27ce23c

and I remember the earlier patch that tries to address the race via
changing the locking:

https://lore.kernel.org/all/20251106182016.26508-1-ssranevjti@gmail.com/

AFAICS, done that way the call to l2cap_unregister_user() in
hidp_session_thread() should be noop via the !list_empty(&user->list)
branch, as the hidp_session_remove() already ran. session->conn would
remain until it is put when session->ref refcount goes to zero.


> +
>  	hidp_session_put(session);
> =20
>  	module_put_and_kthread_exit(0);

--=20
Pauli Virtanen
