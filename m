Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E1A179A7
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169720; cv=none; b=TdbZFq8xGJWGZAYD+MEZej+/VLjQHORgKIz6BFlSCrVrBGR9uLnQyuGQMraxSk1Rd00E8bBvDvgCQXV1bZXhDn00aldp4hdp73EZn9diEZ8qVOJIytCH3KjuUe2zKsqQVDLAQeE4DgaMxkP0MyewwweIXNOC7gj+76uLazYjjUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169720; c=relaxed/simple;
	bh=ypHrgLCvtO+mMiaegrfU3a/D8k89hCRWvQdi1lygWZc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ixIUzLilFOUv20IX8LnXb3qAI0bPI1yJspxpe71PX3A2HFrWSzpoBppKdtekEOqBKR8Y5iSMxxf/vrtDls+EAgZezfTnv62vDIhPbKgZWagSRChJp9Dp6W1DYedYzgkuO98dbFjUEltnX8Hndqh65QJg+4gZ5i4qSr09iMjKELc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXBcR5DO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXBcR5DO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 823FEC43399
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 08:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706169719;
	bh=ypHrgLCvtO+mMiaegrfU3a/D8k89hCRWvQdi1lygWZc=;
	h=From:To:Subject:Date:From;
	b=WXBcR5DOGTnvOqaXYbuHiRW4djjxwWoi7fY3qu0knhlpJKDNvFqrnIPwjyl9h8VeV
	 OMQIKZ+noKQ8ouSsFEAeM8LSiNtYMJkfnYBJ7gsnL0zyB5CTkt4Vy0zuZi8bgbFJxs
	 Z7RnagtABFC2fthFqvexhP+XBZ6fP4BqhrRVeW8AY6tol7Slm14p9qFVjnFacpwU5C
	 0ON94ER10RQiE3vdJoSn8RdXTiqcJuvgX+enHStKWdHZ6ie1XCHTEYQfJplB8xBhuV
	 aSEmbDiJtozNOUrFaN5m4ShtHErGu2nNYh8MAKJpZR6I3VAeZ3omHxFbW0oBBZsm+g
	 hzcj+5E6z3e9w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 70371C53BD0; Thu, 25 Jan 2024 08:01:59 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218421] New: Possible Use-After-Free in bt_accept_poll
Date: Thu, 25 Jan 2024 08:01:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: 20373622@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter cc
 cf_regression
Message-ID: <bug-218421-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218421

            Bug ID: 218421
           Summary: Possible Use-After-Free in bt_accept_poll
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: 20373622@buaa.edu.cn
                CC: baijiaju1990@gmail.com, johan.hedberg@gmail.com,
                    luiz.dentz@gmail.com, marcel@holtmann.org
        Regression: No

Hello,

I am writing to report a potential use-after-free that our fuzzing tool fou=
nd
in the 'bt_accept_poll' function. The bug was encountered while testing ker=
nel
6.7-rc2 during a Bluetooth pairing procedure. Due to the non-determinism of
concurrent execution, this bug cannot be stably reproduced in my testing.

Through disassembly, we have pinpointed the code at 'bt_sock_poll+0x233', w=
hich
corresponds to the inline function 'bt_accept_poll', specifically at the li=
ne:

File: net/bluetooth/af_bluetooth.c
Line: 492
list_for_each_entry_safe(s, n, &bt_sk(parent)->accept_q, accept_q)

Based on the allocate and free tasks reported by KASAN, we suspect that the
use-after-free issue originates from the 'parent' variable in the
'bt_accept_poll' function, which corresponds to the 'sk' from 'bt_sock_poll'
that is passed into it.

The 'bt_accept_poll' function is called from 'bt_sock_poll' as follows:

File: net/bluetooth/af_bluetooth.c
Line: 506
    struct sock *sk =3D sock->sk;
    __poll_t mask =3D 0;

    poll_wait(file, sk_sleep(sk), wait);

    if (sk->sk_state =3D=3D BT_LISTEN)
        return bt_accept_poll(sk);

This suggests that at the time of evaluating 'if (sk->sk_state =3D=3D BT_LI=
STEN)',
'sk' is likely not NULL, and its 'sk_state' is 'BT_LISTEN'. However, by the
time the execution reaches the section of code in 'bt_accept_poll' mentioned
above, 'sk' seems to have been freed. This appears to be a very subtle timi=
ng
issue, which may explain the difficulty we have had in reproducing the bug.

KASAN report=EF=BC=9A
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in bt_sock_poll+0x233/0x9d0 [bluetooth]
Read of size 8 at addr ffff888005f142f8 by task bluetoothd/521

CPU: 0 PID: 521 Comm: bluetoothd Tainted: G           O 6.7.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1=
.1
04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xbf/0xf0
 print_address_description+0x7f/0x3d0
 print_report+0x11d/0x250
 ? __virt_addr_valid+0xc5/0xf0
 ? bt_sock_poll+0x233/0x9d0 [bluetooth]
 kasan_report+0x137/0x170
 ? bt_sock_poll+0x233/0x9d0 [bluetooth]
 bt_sock_poll+0x233/0x9d0 [bluetooth]
 sock_poll+0x2a0/0x350
 do_sys_poll+0x926/0x11a0
 ? __ia32_compat_sys_ppoll_time64+0x290/0x290
 ? __ia32_compat_sys_ppoll_time64+0x290/0x290
 ? __ia32_compat_sys_ppoll_time64+0x290/0x290
 ? __ia32_compat_sys_ppoll_time64+0x290/0x290
 ? __ia32_compat_sys_ppoll_time64+0x290/0x290
 ? __ia32_compat_sys_ppoll_time64+0x290/0x290
 ? __ia32_compat_sys_ppoll_time64+0x290/0x290
 ? __ia32_compat_sys_ppoll_time64+0x290/0x290
 __se_sys_poll+0x15d/0x340
 ? fpregs_assert_state_consistent+0x24/0xa0
 do_syscall_64+0x32/0xa0
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7f6c44c1f933
Code: 49 8b 45 10 5d 41 5c 41 5d 41 5e c3 66 2e 0f 1f 84 00 00 00 00 00 90 =
64
8b 04 25 18 00 00 00 85 c0 75 14 b8 07 00 00 00 0f 05 <48> 3d 00 f0 ff ff 7=
7 55
c3 0f 1f 40 00 48 83 ec 28 89 54 24 1c 48
RSP: 002b:00007ffe74204ad8 EFLAGS: 00000246 ORIG_RAX: 0000000000000007
RAX: ffffffffffffffda RBX: 00007f6c44ee1410 RCX: 00007f6c44c1f933
RDX: 00000000ffffffff RSI: 000000000000000f RDI: 00005614a8807720
RBP: 00005614a8807720 R08: 0000000000000010 R09: 0000000000000002
R10: 000000000000000f R11: 0000000000000246 R12: 000000000000000f
R13: 00007ffe74204af4 R14: 00000000ffffffff R15: 00005614a87f8bd0
 </TASK>

Allocated by task 671:
 kasan_set_track+0x4c/0x70
 __kasan_kmalloc+0x82/0x90
 __kmalloc+0xac/0x1d0
 sk_prot_alloc+0xdd/0x1a0
 sk_alloc+0x2c/0x4f0
 bt_sock_alloc+0x43/0x440 [bluetooth]
 l2cap_sock_alloc+0x3f/0x160 [bluetooth]
 l2cap_sock_new_connection_cb+0x12f/0x240 [bluetooth]
 l2cap_connect+0x7f1/0x1490 [bluetooth]
 l2cap_bredr_sig_cmd+0x45c/0x71c0 [bluetooth]
 l2cap_recv_frame+0xd46/0x1610 [bluetooth]
 l2cap_recv_acldata+0x2c5/0xd00 [bluetooth]
 hci_rx_work+0x67b/0xd00 [bluetooth]
 process_one_work+0x4f0/0xab0
 worker_thread+0x8af/0xee0
 kthread+0x275/0x300
 ret_from_fork+0x30/0x60
 ret_from_fork_asm+0x11/0x20

Freed by task 670:
 kasan_set_track+0x4c/0x70
 kasan_save_free_info+0x24/0x40
 ____kasan_slab_free+0x118/0x190
 slab_free_freelist_hook+0xd1/0x160
 __kmem_cache_free+0xa3/0x170
 __sk_destruct+0x317/0x400
 sock_put+0x81/0xd0 [bluetooth]
 l2cap_sock_kill+0xf6/0x110 [bluetooth]
 l2cap_sock_close_cb+0x66/0x80 [bluetooth]
 l2cap_conn_del+0x345/0x640 [bluetooth]
 l2cap_connect_cfm+0xdb/0x1060 [bluetooth]
 hci_connect_cfm+0x100/0x1c0 [bluetooth]
 hci_conn_failed+0x1c8/0x280 [bluetooth]
 hci_abort_conn_sync+0x7d9/0xaf0 [bluetooth]
 hci_disconnect_all_sync+0x152/0x1b0 [bluetooth]
 hci_set_powered_sync+0x499/0x6c0 [bluetooth]
 hci_cmd_sync_work+0x1f7/0x2b0 [bluetooth]
 process_one_work+0x4f0/0xab0
 worker_thread+0x8af/0xee0
 kthread+0x275/0x300
 ret_from_fork+0x30/0x60
 ret_from_fork_asm+0x11/0x20

Last potentially related work creation:
 kasan_save_stack+0x3b/0x60
 kasan_record_aux_stack_noalloc+0x96/0xa0
 __call_rcu_common+0x75/0xb40
 addrconf_ifdown+0x147a/0x1680
 addrconf_notify+0x161/0x1900
 notifier_call_chain+0xcd/0x1e0
 unregister_netdevice_many_notify+0xaa1/0x1230
 sit_exit_batch_net+0x53c/0x570
 cleanup_net+0x51f/0x970
 process_one_work+0x4f0/0xab0
 worker_thread+0x8af/0xee0
 kthread+0x275/0x300
 ret_from_fork+0x30/0x60
 ret_from_fork_asm+0x11/0x20

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
