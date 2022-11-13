Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BFAC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Nov 2022 13:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiKMNib (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Nov 2022 08:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbiKMNi3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Nov 2022 08:38:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CD0643B
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 05:38:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79BAE60301
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 13:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF35CC433D6
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668346706;
        bh=iJKETCsUFs2PQlhRuKCwSnGMp/xZvYMdmhrigzF8TUM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=M+6YFSKhnHAumXW/VqbOgtCWdaPWswvgV0wEy8P2ZWcb/4Q9RCQFRG93jtmKBgL1q
         I9gmc0j723IqPZio+d9J0MMDr+z+u35l+a3v//pJx4ffcra/RygSe8GQQIRA0XFkUx
         5LEDC/ZSaF+MWnuRfblPR2BYC7gCdFJ00QCKTQEeatWE3lyrBn0nTfyJb+yaxwbLZJ
         PmN8vLYJvhbm6pkVkFX/HnkpaYDLdcH5+3r/9X1yGEPW+qYv7HA0Gp4UC0XrX/3yPt
         2BpE/mUEL0LjsOolOhUq+LxLfz71WOGC5s8zPMwN20qO15vZfaPVZTWAgoy/ICuu2M
         DP858aqqtyKyg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BEEEFC433E7; Sun, 13 Nov 2022 13:38:26 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216686] BUG: kernel NULL pointer dereference, address:
 0000000000000680
Date:   Sun, 13 Nov 2022 13:38:26 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: frc.gabriel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216686-62941-geSCR3r7WS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216686-62941@https.bugzilla.kernel.org/>
References: <bug-216686-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216686

--- Comment #7 from frc.gabriel@gmail.com ---
(In reply to Paul Menzel from comment #5)
> In * linux-headers-6.0.0-2-amd64: bluetooth crashes after returning from
> suspend* [1] you write:
>=20
> > I installed 6.0.5-1 and during the past few days seems to be working ok=
ay.
>=20
> Just to avoid misunderstandings, is that outdated information?


Hi, thanks for the quick response,

I think so, I used 6.0.5 only for a couple of days, then installed 6.1-rc3 =
as
soon it landed in experimental.

When writing this bug report (against 6.1-rc3) I noticed 6.0.8 was already =
in
unstable and tried it as well. (full dmesg for 6.0.8 at
https://bugzilla.kernel.org/attachment.cgi?id=3D303163&action=3Dedit)

Both links were added just for context (because they have similar call trac=
e)


>=20
> The trace from attachment 6 [details].1-rc3 oops is:
>=20
> ```
> [  459.240547] usb 5-4: USB disconnect, device number 3
> [  459.241253] BUG: kernel NULL pointer dereference, address:
> 0000000000000680
> [  459.241265] #PF: supervisor read access in kernel mode
> [  459.241270] #PF: error_code(0x0000) - not-present page
> [  459.241275] PGD 0 P4D 0=20
> [  459.241282] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  459.241288] CPU: 12 PID: 973 Comm: bluetoothd Not tainted 6.1.0-0-amd64
> #1  Debian 6.1~rc3-1~exp1
> [  459.241296] Hardware name: LENOVO 21A00004GE/21A00004GE, BIOS R1MET51W
> (1.21 ) 09/15/2022
> [  459.241300] RIP: 0010:hci_send_acl+0x21/0x2f0 [bluetooth]
> [  459.241515] Code: cc cc 0f 1f 80 00 00 00 00 0f 1f 44 00 00 41 57 49 89
> ff 41 56 41 55 41 54 55 48 89 f5 53 48 83 ec 28 4c 8b 67 18 89 54 24 0c <=
4d>
> 8b 8c 24 80 06 00 00 4c 89 4c 24 18 66 90 0f b7 da 8b 4d 70 2b
> [  459.241521] RSP: 0018:ffffa29981eafc00 EFLAGS: 00010286
> [  459.241526] RAX: ffff9119fabab400 RBX: 0000000000000004 RCX:
> 0000000000000000
> [  459.241530] RDX: 0000000000000000 RSI: ffff9119cb626f00 RDI:
> ffff9119c68cfc00
> [  459.241533] RBP: ffff9119cb626f00 R08: ffff911ac574fec0 R09:
> 000000000000000c
> [  459.241535] R10: 0000000000000028 R11: 0000000000000000 R12:
> 0000000000000000
> [  459.241538] R13: ffffa29981eafd40 R14: ffff9119cb626f00 R15:
> ffff9119c68cfc00
> [  459.241542] FS:  00007feffba587c0(0000) GS:ffff911fd2100000(0000)
> knlGS:0000000000000000
> [  459.241546] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  459.241549] CR2: 0000000000000680 CR3: 000000012219c000 CR4:
> 0000000000750ee0
> [  459.241554] PKRU: 55555554
> [  459.241557] Call Trace:
> [  459.241568]  <TASK>
> [  459.241573]  ? mutex_lock+0xe/0x30
> [  459.241605]  l2cap_chan_send+0x12f/0xc60 [bluetooth]
> [  459.241670]  ? remove_wait_queue+0x20/0x60
> [  459.241677]  ? _raw_spin_unlock_irqrestore+0x23/0x40
> [  459.241682]  ? bt_sock_wait_ready+0x128/0x1a0 [bluetooth]
> [  459.241731]  l2cap_sock_sendmsg+0x9a/0x100 [bluetooth]
> [  459.241786]  sock_sendmsg+0x5f/0x70
> [  459.241796]  rfcomm_send_frame+0x62/0xa0 [rfcomm]
> [  459.241814]  rfcomm_send_disc.isra.0+0x80/0xd0 [rfcomm]
> [  459.241828]  __rfcomm_dlc_disconn+0x10a/0x120 [rfcomm]
> [  459.241843]  __rfcomm_dlc_close+0x60/0x200 [rfcomm]
> [  459.241857]  rfcomm_dlc_close+0x6a/0xb0 [rfcomm]
> [  459.241871]  __rfcomm_sock_close+0x2e/0xd0 [rfcomm]
> [  459.241886]  rfcomm_sock_shutdown+0x54/0xb0 [rfcomm]
> [  459.241899]  rfcomm_sock_release+0x2e/0x90 [rfcomm]
> [  459.241914]  __sock_release+0x3d/0xb0
> [  459.241920]  sock_close+0x11/0x20
> [  459.241925]  __fput+0x91/0x250
> [  459.241933]  task_work_run+0x59/0x90
> [  459.241942]  exit_to_user_mode_prepare+0x1cd/0x1e0
> [  459.241948]  syscall_exit_to_user_mode+0x17/0x40
> [  459.241960]  do_syscall_64+0x46/0xc0
> [  459.241974]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> [  459.241981] RIP: 0033:0x7feffc07a770
> [  459.241986] Code: 0d 00 00 00 eb b2 e8 4f f7 01 00 66 2e 0f 1f 84 00 00
> 00 00 00 0f 1f 44 00 00 80 3d 71 1e 0e 00 00 74 17 b8 03 00 00 00 0f 05 <=
48>
> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
> [  459.241990] RSP: 002b:00007ffceb4d6ba8 EFLAGS: 00000202 ORIG_RAX:
> 0000000000000003
> [  459.241995] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 00007feffc07a770
> [  459.241998] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> 0000000000000028
> [  459.242000] RBP: 0000000000000000 R08: 0000000000000000 R09:
> 0000000000000010
> [  459.242003] R10: 0000000000000000 R11: 0000000000000202 R12:
> 0000000000000001
> [  459.242005] R13: 0000555efbd88f30 R14: 00007feffc3691b0 R15:
> 0000555efbd7e350
> [  459.242011]  </TASK>
> ```
>=20
> Could you please attach all Linux messages, that means, the full output of
> `dmesg`, and also have `sudo btmon -w /dev/shm/trace.log` running in
> parallel.

I triggered the bug while running btmon, but the computer become unresponsi=
ve
and freezes completely and I'm not even sure if it get into syslog. I will =
try
later to have btmon writing somewhere else so I don't lose the file.

Meanwhile, I attached all kernel messages I could get from `grep kernel
/var/log/syslog` in a xz file attached at
https://bugzilla.kernel.org/attachment.cgi?id=3D303168


>=20
> As you know it=E2=80=99s a regression, and you can reproduce it, it might=
 be fastest
> to do the following:
>=20
> 1.  Build bluetooth-next [2]. (Clone the source tree, copy the Debian
> configuration from `/boot` to `.config`, run `make olddefconfig` and `make
> localmodconfig`, disable debug info in `make menuconfig`, and then `make
> bindeb-pkg` and install the generated `linux-image=E2=80=A6.deb` with `dp=
kg -i`.
> 2.  If it=E2=80=99s still happening, and you want faster test cycles, try=
 to
> reproduce it in QEMU by passing the USB device through.
> 3.  Bisect the issue with `git bisect`.
>=20
> [1]: https://bugs.debian.org/1023076
> [2]:
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git

Sure, I will try that too later today.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
