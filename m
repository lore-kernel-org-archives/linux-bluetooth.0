Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF63C2C86E
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 03:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPZ9FBKu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CF1AC433C7
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Dec 2023 03:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703561598;
	bh=Ht46TEEoIEOuuz6wCeRE0bQh/sdDpzSIF2MJZLo9pF0=;
	h=From:To:Subject:Date:From;
	b=WPZ9FBKuuFTRMbkBc9uh6MbQuWiHSmypwJkAavoJ8/EE+tzr2fRmZYAffS89TDhx7
	 qAZr2Aosjixok/kvVTbAm+Ciq3IgiZgU9rOLtDtYpHXvXKoNBSjG1HoldiuI4UU4le
	 nd1F7tJM/KW2cKNrX4ChsZXbhSQZacgVrOjgwR7npgH33kF994QIMKG0dn+WaLI0qC
	 85e05nPMcGji6fVNLFxCzjV/enNzWPVflPXEHj80AH5wDRtEF5fNuye8maDSa59RxR
	 Ceg6rxA2HN7Wg4V+O0uuXI81Q6l1prC3HdzjG1ieLR9GpDG8bQh48n6BFaAvOVrt5m
	 7YtlFAn9EeSFg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5DCFDC4332E; Tue, 26 Dec 2023 03:33:18 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218323] New: KASAN: null-ptr-deref in rfcomm_check_security in
 Kernel 6.7-rc2
Date: Tue, 26 Dec 2023 03:33:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: 20373622@buaa.edu.cn
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression attachments.created
Message-ID: <bug-218323-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=3D218323

            Bug ID: 218323
           Summary: KASAN: null-ptr-deref in rfcomm_check_security in
                    Kernel 6.7-rc2
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: 20373622@buaa.edu.cn
        Regression: No

Created attachment 305656
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D305656&action=3Dedit
terminal log

Hello All,

Our fuzzing tool find a null-ptr-deref in rfcomm_check_security in Linux
6.7-rc2.

During our fuzz testing of the connection and disconnection process at the
RFCOMM layer, we discovered this bug. By comparing the packets from a normal
connection and disconnection process with the testcase that triggered a KAS=
AN
report, we analyzed the cause of this bug as follows:

1. In the packets captured during a normal connection, the host sends a `Re=
ad
Encryption Key Size` type of `HCI_CMD` packet (Command Opcode: 0x1408) to t=
he
controller to inquire the length of encryption key. After receiving this
packet, the controller immediately replies with a Command Complete packet
(Event Code: 0x0e) to return the Encryption Key Size. (See Attachment 2)

2. In our fuzz test case, the timing of the controller's response to this
packet was delayed to an unexpected point: after the RFCOMM and L2CAP layers
had disconnected but before the HCI layer had disconnected. (See Attachment=
 3)

3. After receiving the Encryption Key Size Response at the time described in
point 2, the host still called the rfcomm_check_security function. However,=
 by
this time `struct l2cap_conn *conn =3D l2cap_pi(sk)->chan->conn;` had alrea=
dy
been released, and when the function executed `return
hci_conn_security(conn->hcon, d->sec_level, auth_type, d->out);`, specifica=
lly
when accessing `conn->hcon`, a null-ptr-deref error occurred.

Attachment 1(vm.log) is the complete terminal log when this bug was trigger=
ed,
including the KASAN report and the HCI layer packets. The HCI packets excha=
nged
between host and controller were printed by the HCI driver. For example:
[H->D:CMD] indicates an HCI_CMD packet sent from the host to the controller.

This bug can be reproduced with a relatively high level of consistency. We
conducted 10 tests using the same sequence of packets, and out of those, the
bug triggered the KASAN report 7 times.

Here is the KASAN report:

general protection fault, probably for non-canonical address
0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 539 Comm: krfcommd Tainted: G           O       6.7.0-rc2 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1=
.1
04/01/2014
RIP: 0010:rfcomm_check_security+0x142/0x230 [rfcomm]
Code: 00 00 48 89 e8 48 c1 e8 03 42 8a 1c 20 84 db 0f 85 9a 00 00 00 bf ea =
04
20 50 e8 c9 3c d9 ff 44 8a 6d 00 4c 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 1=
2 bf
1b 2f 83 28 e8 ad 3c d9 ff 4c 89 ff e8 f5
RSP: 0018:ffff88800b797c20 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88800559f000 RCX: 00000000c0249000
RDX: dffffc0000000000 RSI: 0000000000000246 RDI: ffffffffc0249000
RBP: ffff8880072f9893 R08: ffff88800b797b73 R09: 1ffff110016f2f6e
R10: dffffc0000000000 R11: ffffed10016f2f6f R12: dffffc0000000000
R13: ffff8880072f9801 R14: ffff8880072f9800 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd235665000 CR3: 0000000004784000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __die_body+0x62/0xb0=20
 ? die_addr+0xbe/0xf0=20
 ? exc_general_protection+0x2a7/0x3c0
 ? asm_exc_general_protection+0x22/0x30
 ? rfcomm_check_security+0x142/0x230 [rfcomm]
 rfcomm_process_connect+0x1ad/0x280 [rfcomm]
 rfcomm_process_rx+0x1064/0x1b80 [rfcomm]
 ? __mfuzz_coverage__+0x16/0x140 [mfuzz_monitor]
 rfcomm_process_sessions+0x758/0x1d20 [rfcomm]
 ? _raw_spin_lock_irqsave+0x8d/0x130
 ? __mfuzz_coverage__+0x16/0x140 [mfuzz_monitor]
 rfcomm_run+0x49f/0x6d0 [rfcomm]
 ? wait_woken+0xf0/0xf0
 ? skb_tail_pointer+0xc0/0xc0 [rfcomm]
 kthread+0x275/0x300
 ? skb_tail_pointer+0xc0/0xc0 [rfcomm]
 ? kthread_blkcg+0xa0/0xa0
 ret_from_fork+0x30/0x60
 ? kthread_blkcg+0xa0/0xa0
 ret_from_fork_asm+0x11/0x20
 </TASK>
Modules linked in: btvirt(O) rfcomm(O) bnep(O) btintel bluetooth(O)
mfuzz_monitor(O) ecdh_generic ecc [last unloaded: btvirt(O)]
---[ end trace 0000000000000000 ]---
RIP: 0010:rfcomm_check_security+0x142/0x230 [rfcomm]
Code: 00 00 48 89 e8 48 c1 e8 03 42 8a 1c 20 84 db 0f 85 9a 00 00 00 bf ea =
04
20 50 e8 c9 3c d9 ff 44 8a 6d 00 4c 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 1=
2 bf
1b 2f 83 28 e8 ad 3c d9 ff 4c 89 ff e8 f5
RSP: 0018:ffff88800b797c20 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88800559f000 RCX: 00000000c0249000
RDX: dffffc0000000000 RSI: 0000000000000246 RDI: ffffffffc0249000
RBP: ffff8880072f9893 R08: ffff88800b797b73 R09: 1ffff110016f2f6e
R10: dffffc0000000000 R11: ffffed10016f2f6f R12: dffffc0000000000
R13: ffff8880072f9801 R14: ffff8880072f9800 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88806d200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd235665000 CR3: 0000000004784000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


Any feedback would be appreciated, thanks!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
