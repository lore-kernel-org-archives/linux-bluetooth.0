Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11E616416
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 02:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706669983; cv=none; b=AWBv91ZuqZ/oXaeftK/FvITratZVPwNquFcSMe2EmARku+//BSUlQIAKrSsghwAUwA23np9ZzYgDpHD9TrKzgjgeh9L+WIW2bzNwqw+ySzqFm1Pi7CjcoERO+nEeddahB8RSxaKFePxA5NGYZf7FI80+XUb7gCdmcKV0rioPbns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706669983; c=relaxed/simple;
	bh=PzZfpxMezNl0kJKJA2vr2vVN509YGuHSNRok/dk1ZoE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Y3Jt2e/S/3lXyKUUzdfzEha06iXRxTLAQ/xnkQ4kWDFC0RvqS40RZmCNEXtPkOgfCdUrK30YmTtE0FFOiYmJKolDAFdNjlbOOoqZ/v8P/tsr2MgM0p1Wjyxu5/m7ibV9hf2BlQxjdAojSoTqsQzhFaQL/+wnKzPYQ/hCBXY6w3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NXyn6unZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NXyn6unZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44C18C433C7
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 02:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706669983;
	bh=PzZfpxMezNl0kJKJA2vr2vVN509YGuHSNRok/dk1ZoE=;
	h=From:To:Subject:Date:From;
	b=NXyn6unZewFqEtipsKbl3JXkJkcttRs3uvGC3k9D2mKNuqECBRmkFNKhwOfhlrmta
	 TjD6l3nlZ2ypAapto7GdlfdXEp0/yywOjnevYtKx2PtnVC1/8yivlW8xQVCQ3/6YHO
	 Fa/e4pDkQ6nCC/pQ+6IuEaveY2aWZ4HsuXSqDUs0U+0r3wi706DG95/ZMwoJ2CQWS8
	 XoTM0CDaHs+aDbu4iXfwx5sjnGY8OMAash4ohZNhM97iEkxEifdOZtROV4lwAWrENd
	 K/xZeEZS1aZ8StOIs78dnmUaAV/4slEhBqKmTkFSgl7P7aobgVrNANJLRACH0XNTb4
	 c7dhGlFQxQAWA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 2AB1EC4332E; Wed, 31 Jan 2024 02:59:43 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218440] New: KASAN: slab-use-after-free in hci_send_acl in
 Kernel 6.7-rc2
Date: Wed, 31 Jan 2024 02:59:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: zhenghaoran@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218440-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218440

            Bug ID: 218440
           Summary: KASAN: slab-use-after-free in hci_send_acl in Kernel
                    6.7-rc2
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: zhenghaoran@buaa.edu.cn
        Regression: No

Hello,

I am writing to report a potential use-after-free that our fuzzing tool fou=
nd
in the 'hci_send_acl' function. The bug was encountered while testing kernel
6.7-rc2 during a Bluetooth pairing procedure. Due to the non-determinism of
concurrent execution, this bug cannot be stably reproduced in my testing.

Through disassembly, we have pinpointed the code at 'hci_send_acl+0x54', wh=
ich
corresponds to the function 'hci_send_acl', specifically at the line:

File: net/bluetooth/hci_core.c
Line: 3234
struct hci_dev *hdev =3D chan->conn->hdev;

Based on the allocate and free tasks reported by KASAN, we suspect that the
use-after-free issue originates from the 'chan' variable in the parameter
passed into the 'hci_send_acl' function.

Although the 'l2cap_conn conn' variable and 'l2cap_chan conn->chan' variable
are locked in the 'l2cap_conn_start' function, 'hci_chan conn->hchan' may s=
till
be released by other threads, causing a use-after-free vulnerability. This
appears to be a very subtle timing issue, which may explain the difficulty =
we
have had in reproducing the bug.

KASAN report=EF=BC=9A
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
BUG: KASAN: slab-use-after-free in hci_send_acl+0x54/0x770 [bluetooth]
Read of size 8 at addr ffff888007212618 by task kworker/0:0/688

CPU: 0 PID: 688 Comm: kworker/0:0 Tainted: G           O       6.7.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1=
.1
04/01/2014
Workqueue: events l2cap_info_timeout [bluetooth]
Call Trace:
 <TASK>
 dump_stack_lvl+0xbf/0xf0
 print_address_description+0x7f/0x3d0
 print_report+0x11d/0x250
 ? __virt_addr_valid+0xc5/0xf0
 ? hci_send_acl+0x54/0x770 [bluetooth]
 kasan_report+0x137/0x170
 ? hci_send_acl+0x54/0x770 [bluetooth]
 hci_send_acl+0x54/0x770 [bluetooth]
 ? get_thread_local+0x9d/0x140 [mfuzz_monitor]
 l2cap_send_cmd+0x633/0xa40 [bluetooth]
 l2cap_send_conn_req+0x1ad/0x360 [bluetooth]
 l2cap_start_connection+0x178/0x420 [bluetooth]
 l2cap_conn_start+0x94e/0xdc0 [bluetooth]
 ? get_thread_local+0x9d/0x140 [mfuzz_monitor]
 ? __mfuzz_coverage__+0x16/0x140 [mfuzz_monitor]
 process_one_work+0x4f0/0xab0
 worker_thread+0x8af/0xee0
 ? _raw_spin_lock_irqsave+0x8d/0x130
 ? process_one_work+0xab0/0xab0
 kthread+0x275/0x300
 ? process_one_work+0xab0/0xab0
 ? kthread_blkcg+0xa0/0xa0
 ret_from_fork+0x30/0x60
 ? kthread_blkcg+0xa0/0xa0
 ret_from_fork_asm+0x11/0x20
 </TASK>

Allocated by task 1167:
 kasan_set_track+0x4c/0x70
 __kasan_kmalloc+0x82/0x90
 __kmalloc+0xac/0x1d0
 hci_chan_create+0x92/0x1c0 [bluetooth]
 l2cap_conn_add+0x8f/0xe30 [bluetooth]
 l2cap_chan_connect+0x5b4/0xff0 [bluetooth]
 l2cap_sock_connect+0x420/0x890 [bluetooth]
 kernel_connect+0xb3/0xe0
 rfcomm_dlc_open+0x605/0x1190 [rfcomm]
 rfcomm_sock_connect+0x3c4/0x7f0 [rfcomm]
 __sys_connect+0x20f/0x270
 __x64_sys_connect+0x71/0x80
 do_syscall_64+0x32/0xa0
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Freed by task 1155:
 kasan_set_track+0x4c/0x70
 kasan_save_free_info+0x24/0x40
 ____kasan_slab_free+0x118/0x190
 slab_free_freelist_hook+0xd1/0x160
 __kmem_cache_free+0xa3/0x170
 hci_chan_list_flush+0x85/0xc0 [bluetooth]
 hci_conn_del+0x568/0x1010 [bluetooth]
 hci_abort_conn_sync+0x7d9/0xaf0 [bluetooth]
 abort_conn_sync+0x78/0xd0 [bluetooth]
 hci_cmd_sync_work+0x1f7/0x2b0 [bluetooth]
 process_one_work+0x4f0/0xab0
 worker_thread+0x8af/0xee0
 kthread+0x275/0x300
 ret_from_fork+0x30/0x60
 ret_from_fork_asm+0x11/0x20

The buggy address belongs to the object at ffff888007212600
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 24 bytes inside of
 freed 64-byte region [ffff888007212600, ffff888007212640)

The buggy address belongs to the physical page:
page:00000000baf0b98e refcount:1 mapcount:0 mapping:0000000000000000 index:=
0x0
pfn:0x7212
anon flags: 0x100000000000800(slab|node=3D0|zone=3D1)
page_type: 0xffffffff()
raw: 0100000000000800 ffff888001041640 ffffea0000079d40 dead000000000003
raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888007212500: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff888007212580: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
>ffff888007212600: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                            ^
 ffff888007212680: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff888007212700: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
