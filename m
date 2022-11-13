Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513ABC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Nov 2022 14:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbiKMOP3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Nov 2022 09:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235201AbiKMOP1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Nov 2022 09:15:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E56CCF
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 06:15:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94D09B80945
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 14:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4420AC433D6
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 14:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668348922;
        bh=tHTYzKRHY5hl8ASUDhSwoBEIkGT8IhXWy9KOHYiYYjw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SyfnceWEzqzStFAAdkioEu7kfw6uPCB45V9tLzPNw3Ix7twevpz/jcd0PRW1/o9Oi
         FUJYWEWA+pWJsE72KRzaZ3odpwIHdxntIb+Axs/EvQEY+nHopSzeJRq+qFRSWwiGiw
         qnA9ini7XqsInGkn2YR6fgPU4/JBEwFuLHyYjsrUNqbtneO+I6LgqY1w322Rr0lXt2
         95tmPfIocl2mwQ36DjoTwoAnTkOsMlF0buWsvbtCIUtK8Kp5ga+Gy1jkp+WLic2/J+
         ibGRUh28+0Do1zY87qxUkHQxyFwxSyCaBUl5YSu09UTaWS6+pJHav25qHEOEjZAXzB
         rT8+LQydKrpGg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3035FC433E7; Sun, 13 Nov 2022 14:15:22 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216686] BUG: kernel NULL pointer dereference, address:
 0000000000000680
Date:   Sun, 13 Nov 2022 14:15:21 +0000
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
Message-ID: <bug-216686-62941-xDGfaKH1XG@https.bugzilla.kernel.org/>
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

--- Comment #8 from frc.gabriel@gmail.com ---
(In reply to frc.gabriel from comment #7)
> (In reply to Paul Menzel from comment #5)
> > In * linux-headers-6.0.0-2-amd64: bluetooth crashes after returning from
> > suspend* [1] you write:
> >=20
> > > I installed 6.0.5-1 and during the past few days seems to be working
> okay.
> >=20
> > Just to avoid misunderstandings, is that outdated information?
>=20
>=20
> Hi, thanks for the quick response,
>=20
> I think so, I used 6.0.5 only for a couple of days, then installed 6.1-rc3
> as soon it landed in experimental.
>=20
> When writing this bug report (against 6.1-rc3) I noticed 6.0.8 was already
> in unstable and tried it as well. (full dmesg for 6.0.8 at
> https://bugzilla.kernel.org/attachment.cgi?id=3D303163&action=3Dedit)
>=20
> Both links were added just for context (because they have similar call tr=
ace)
>=20
>=20
> >=20
> > The trace from attachment 6 [details].1-rc3 oops is:
> >=20
> > ```
> > [  459.240547] usb 5-4: USB disconnect, device number 3
> > [  459.241253] BUG: kernel NULL pointer dereference, address:
> > 0000000000000680
> > [  459.241265] #PF: supervisor read access in kernel mode
> > [  459.241270] #PF: error_code(0x0000) - not-present page
> > [  459.241275] PGD 0 P4D 0=20
> > [  459.241282] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [  459.241288] CPU: 12 PID: 973 Comm: bluetoothd Not tainted 6.1.0-0-am=
d64
> > #1  Debian 6.1~rc3-1~exp1
> > [  459.241296] Hardware name: LENOVO 21A00004GE/21A00004GE, BIOS R1MET5=
1W
> > (1.21 ) 09/15/2022
> > [  459.241300] RIP: 0010:hci_send_acl+0x21/0x2f0 [bluetooth]
> > [  459.241515] Code: cc cc 0f 1f 80 00 00 00 00 0f 1f 44 00 00 41 57 49=
 89
> > ff 41 56 41 55 41 54 55 48 89 f5 53 48 83 ec 28 4c 8b 67 18 89 54 24 0c
> <4d>
> > 8b 8c 24 80 06 00 00 4c 89 4c 24 18 66 90 0f b7 da 8b 4d 70 2b
> > [  459.241521] RSP: 0018:ffffa29981eafc00 EFLAGS: 00010286
> > [  459.241526] RAX: ffff9119fabab400 RBX: 0000000000000004 RCX:
> > 0000000000000000
> > [  459.241530] RDX: 0000000000000000 RSI: ffff9119cb626f00 RDI:
> > ffff9119c68cfc00
> > [  459.241533] RBP: ffff9119cb626f00 R08: ffff911ac574fec0 R09:
> > 000000000000000c
> > [  459.241535] R10: 0000000000000028 R11: 0000000000000000 R12:
> > 0000000000000000
> > [  459.241538] R13: ffffa29981eafd40 R14: ffff9119cb626f00 R15:
> > ffff9119c68cfc00
> > [  459.241542] FS:  00007feffba587c0(0000) GS:ffff911fd2100000(0000)
> > knlGS:0000000000000000
> > [  459.241546] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  459.241549] CR2: 0000000000000680 CR3: 000000012219c000 CR4:
> > 0000000000750ee0
> > [  459.241554] PKRU: 55555554
> > [  459.241557] Call Trace:
> > [  459.241568]  <TASK>
> > [  459.241573]  ? mutex_lock+0xe/0x30
> > [  459.241605]  l2cap_chan_send+0x12f/0xc60 [bluetooth]
> > [  459.241670]  ? remove_wait_queue+0x20/0x60
> > [  459.241677]  ? _raw_spin_unlock_irqrestore+0x23/0x40
> > [  459.241682]  ? bt_sock_wait_ready+0x128/0x1a0 [bluetooth]
> > [  459.241731]  l2cap_sock_sendmsg+0x9a/0x100 [bluetooth]
> > [  459.241786]  sock_sendmsg+0x5f/0x70
> > [  459.241796]  rfcomm_send_frame+0x62/0xa0 [rfcomm]
> > [  459.241814]  rfcomm_send_disc.isra.0+0x80/0xd0 [rfcomm]
> > [  459.241828]  __rfcomm_dlc_disconn+0x10a/0x120 [rfcomm]
> > [  459.241843]  __rfcomm_dlc_close+0x60/0x200 [rfcomm]
> > [  459.241857]  rfcomm_dlc_close+0x6a/0xb0 [rfcomm]
> > [  459.241871]  __rfcomm_sock_close+0x2e/0xd0 [rfcomm]
> > [  459.241886]  rfcomm_sock_shutdown+0x54/0xb0 [rfcomm]
> > [  459.241899]  rfcomm_sock_release+0x2e/0x90 [rfcomm]
> > [  459.241914]  __sock_release+0x3d/0xb0
> > [  459.241920]  sock_close+0x11/0x20
> > [  459.241925]  __fput+0x91/0x250
> > [  459.241933]  task_work_run+0x59/0x90
> > [  459.241942]  exit_to_user_mode_prepare+0x1cd/0x1e0
> > [  459.241948]  syscall_exit_to_user_mode+0x17/0x40
> > [  459.241960]  do_syscall_64+0x46/0xc0
> > [  459.241974]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> > [  459.241981] RIP: 0033:0x7feffc07a770
> > [  459.241986] Code: 0d 00 00 00 eb b2 e8 4f f7 01 00 66 2e 0f 1f 84 00=
 00
> > 00 00 00 0f 1f 44 00 00 80 3d 71 1e 0e 00 00 74 17 b8 03 00 00 00 0f 05
> <48>
> > 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
> > [  459.241990] RSP: 002b:00007ffceb4d6ba8 EFLAGS: 00000202 ORIG_RAX:
> > 0000000000000003
> > [  459.241995] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> > 00007feffc07a770
> > [  459.241998] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> > 0000000000000028
> > [  459.242000] RBP: 0000000000000000 R08: 0000000000000000 R09:
> > 0000000000000010
> > [  459.242003] R10: 0000000000000000 R11: 0000000000000202 R12:
> > 0000000000000001
> > [  459.242005] R13: 0000555efbd88f30 R14: 00007feffc3691b0 R15:
> > 0000555efbd7e350
> > [  459.242011]  </TASK>
> > ```
> >=20
> > Could you please attach all Linux messages, that means, the full output=
 of
> > `dmesg`, and also have `sudo btmon -w /dev/shm/trace.log` running in
> > parallel.
>=20
> I triggered the bug while running btmon, but the computer become
> unresponsive and freezes completely and I'm not even sure if it get into
> syslog. I will try later to have btmon writing somewhere else so I don't
> lose the file.
>=20
> Meanwhile, I attached all kernel messages I could get from `grep kernel
> /var/log/syslog` in a xz file attached at
> https://bugzilla.kernel.org/attachment.cgi?id=3D303168
>=20
>=20
> >=20
> > As you know it=E2=80=99s a regression, and you can reproduce it, it mig=
ht be
> fastest
> > to do the following:
> >=20
> > 1.  Build bluetooth-next [2]. (Clone the source tree, copy the Debian
> > configuration from `/boot` to `.config`, run `make olddefconfig` and `m=
ake
> > localmodconfig`, disable debug info in `make menuconfig`, and then `make
> > bindeb-pkg` and install the generated `linux-image=E2=80=A6.deb` with `=
dpkg -i`.
> > 2.  If it=E2=80=99s still happening, and you want faster test cycles, t=
ry to
> > reproduce it in QEMU by passing the USB device through.
> > 3.  Bisect the issue with `git bisect`.
> >=20
> > [1]: https://bugs.debian.org/1023076
> > [2]:
> >
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git
>=20
> Sure, I will try that too later today.

Ah, I forgot to share how I reproduce this bug:


While a video is playing in firefox:
  Once a while I disconnect and connect the earphone headset via
gnome-control-center.
  I connect my android cellphone to the earphone headset while it is still
connected to computer, "forcing" a disconnection.
All that while still keeping gnome-control-center bluetooth page open/scann=
ing.

After a few cycles, of connect+disconnect the earphone headset shows as
"connected" in gnome-control-center, but no audio sink is available.

At this point, closing the lid or switching bluetooth off (via
gnome-control-center toggle) I get this message in dmesg:

```
2022-11-13T08:04:07.733635+01:00 computer kernel: [  553.697726] general
protection fault, probably for non-canonical address 0xa0ffff9bb2249beb: 00=
00
[#1] PREEMPT SMP NOPTI
2022-11-13T08:04:07.733710+01:00 computer kernel: [  553.697742] CPU: 7 PID:
933 Comm: bluetoothd Not tainted 6.0.0-4-amd64 #1  Debian 6.0.8-1
2022-11-13T08:04:07.733716+01:00 computer kernel: [  553.697752] Hardware n=
ame:
LENOVO 21A00004GE/21A00004GE, BIOS R1MET51W (1.21 ) 09/15/2022
2022-11-13T08:04:07.733720+01:00 computer kernel: [  553.697756] RIP:
0010:hci_send_acl+0x4a/0x2f0 [bluetooth]
2022-11-13T08:04:07.733724+01:00 computer kernel: [  553.697825] Code: 0c 4=
d 8b
8c 24 80 06 00 00 4c 89 4c 24 18 66 90 0f b7 da 8b 4d 70 2b 4d 74 c6 45 28 =
02
89 4d 70 41 89 cd c7 45 74 00 00 00 00 <41> 0f b6 51 43 84 d2 0f 84 0e 02 0=
0 00
80 fa 01 0f 84 81 00 00 00
2022-11-13T08:04:07.733728+01:00 computer kernel: [  553.697831] RSP:
0018:ffffbd1fc1bc7c00 EFLAGS: 00010202
2022-11-13T08:04:07.733729+01:00 computer kernel: [  553.697839] RAX:
ffff9bb240599600 RBX: 0000000000000002 RCX: 0000000000000008
2022-11-13T08:04:07.733733+01:00 computer kernel: [  553.697844] RDX:
0000000000000002 RSI: ffff9bb1c30ea600 RDI: ffff9bb1c805fcc0
2022-11-13T08:04:07.733736+01:00 computer kernel: [  553.697847] RBP:
ffff9bb1c30ea600 R08: ffff9bb2378ba2c0 R09: a0ffff9bb2249ba8
2022-11-13T08:04:07.733740+01:00 computer kernel: [  553.697851] R10:
0000000000000029 R11: 0000000000000000 R12: ffff9bb2249ba1c1
2022-11-13T08:04:07.733743+01:00 computer kernel: [  553.697854] R13:
0000000000000008 R14: ffff9bb1c30ea600 R15: ffff9bb1c805fcc0
2022-11-13T08:04:07.733746+01:00 computer kernel: [  553.697858] FS:=20
00007f6c939e47c0(0000) GS:ffff9bb7edfc0000(0000) knlGS:0000000000000000
2022-11-13T08:04:07.733748+01:00 computer kernel: [  553.697863] CS:  0010 =
DS:
0000 ES: 0000 CR0: 0000000080050033
2022-11-13T08:04:07.733824+01:00 computer kernel: [  553.697868] CR2:
00007fac2212d000 CR3: 0000000168dc2000 CR4: 0000000000750ee0
2022-11-13T08:04:07.733830+01:00 computer kernel: [  553.697872] PKRU: 5555=
5554
2022-11-13T08:04:07.733833+01:00 computer kernel: [  553.697875] Call Trace:
2022-11-13T08:04:07.733836+01:00 computer kernel: [  553.697881]  <TASK>
2022-11-13T08:04:07.733839+01:00 computer kernel: [  553.697885]  ?
mutex_lock+0xe/0x30
2022-11-13T08:04:07.733843+01:00 computer kernel: [  553.697901]=20
l2cap_chan_send+0x12f/0xc60 [bluetooth]
2022-11-13T08:04:07.733846+01:00 computer kernel: [  553.697977]  ?
remove_wait_queue+0x20/0x60
2022-11-13T08:04:07.733849+01:00 computer kernel: [  553.697987]  ?
_raw_spin_unlock_irqrestore+0x23/0x40
2022-11-13T08:04:07.733852+01:00 computer kernel: [  553.697995]  ?
bt_sock_wait_ready+0x128/0x1a0 [bluetooth]
2022-11-13T08:04:07.733855+01:00 computer kernel: [  553.698050]=20
l2cap_sock_sendmsg+0x9a/0x100 [bluetooth]
2022-11-13T08:04:07.733858+01:00 computer kernel: [  553.698114]=20
sock_sendmsg+0x5f/0x70
2022-11-13T08:04:07.733861+01:00 computer kernel: [  553.698125]=20
rfcomm_send_frame+0x62/0xa0 [rfcomm]
2022-11-13T08:04:07.733864+01:00 computer kernel: [  553.698141]=20
rfcomm_send_disc.isra.0+0x80/0xd0 [rfcomm]
2022-11-13T08:04:07.733867+01:00 computer kernel: [  553.698154]=20
__rfcomm_dlc_disconn+0x10a/0x120 [rfcomm]
2022-11-13T08:04:07.733870+01:00 computer kernel: [  553.698166]=20
__rfcomm_dlc_close+0x60/0x200 [rfcomm]
2022-11-13T08:04:07.733872+01:00 computer kernel: [  553.698179]=20
rfcomm_dlc_close+0x6a/0xb0 [rfcomm]
2022-11-13T08:04:07.733875+01:00 computer kernel: [  553.698190]=20
__rfcomm_sock_close+0x2e/0xd0 [rfcomm]
2022-11-13T08:04:07.733878+01:00 computer kernel: [  553.698203]=20
rfcomm_sock_shutdown+0x54/0xb0 [rfcomm]
2022-11-13T08:04:07.733882+01:00 computer kernel: [  553.698215]=20
rfcomm_sock_release+0x2e/0x90 [rfcomm]
2022-11-13T08:04:07.733885+01:00 computer kernel: [  553.698227]=20
__sock_release+0x3d/0xb0
2022-11-13T08:04:07.733888+01:00 computer kernel: [  553.698234]=20
sock_close+0x11/0x20
2022-11-13T08:04:07.733890+01:00 computer kernel: [  553.698239]=20
__fput+0x91/0x250
2022-11-13T08:04:07.733892+01:00 computer kernel: [  553.698248]=20
task_work_run+0x5c/0x90
2022-11-13T08:04:07.733895+01:00 computer kernel: [  553.698257]=20
exit_to_user_mode_prepare+0x1cd/0x1e0
2022-11-13T08:04:07.733898+01:00 computer kernel: [  553.698264]=20
syscall_exit_to_user_mode+0x17/0x40
2022-11-13T08:04:07.733901+01:00 computer kernel: [  553.698271]=20
do_syscall_64+0x46/0xc0
2022-11-13T08:04:07.733904+01:00 computer kernel: [  553.698280]=20
entry_SYSCALL_64_after_hwframe+0x63/0xcd
2022-11-13T08:04:07.733907+01:00 computer kernel: [  553.698289] RIP:
0033:0x7f6c94006770
2022-11-13T08:04:07.733910+01:00 computer kernel: [  553.698295] Code: 0d 0=
0 00
00 eb b2 e8 4f f7 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d =
71
1e 0e 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 8=
0 00
00 00 00 48 83 ec 18 89 7c
2022-11-13T08:04:07.733914+01:00 computer kernel: [  553.698300] RSP:
002b:00007ffc65ad5da8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
2022-11-13T08:04:07.733917+01:00 computer kernel: [  553.698306] RAX:
0000000000000000 RBX: 0000000000000000 RCX: 00007f6c94006770
2022-11-13T08:04:07.733920+01:00 computer kernel: [  553.698310] RDX:
0000000000000000 RSI: 0000000000000000 RDI: 0000000000000029
2022-11-13T08:04:07.733923+01:00 computer kernel: [  553.698313] RBP:
0000000000000000 R08: 0000000000000000 R09: 0000000000000010
2022-11-13T08:04:07.733925+01:00 computer kernel: [  553.698316] R10:
0000000000000000 R11: 0000000000000202 R12: 0000000000000001
2022-11-13T08:04:07.733929+01:00 computer kernel: [  553.698319] R13:
00005564dd86f1f0 R14: 00005564dd86d940 R15: 00005564dd876610
2022-11-13T08:04:07.733932+01:00 computer kernel: [  553.698326]  </TASK>
2022-11-13T08:04:07.733934+01:00 computer kernel: [  553.698328] Modules li=
nked
in: xt_conntrack nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype
nft_compat nf_tables libcrc32c nfnetlink br_netfilter bridge stp llc
nvme_fabrics uinput ctr ccm rfcomm snd_seq_dummy snd_hrtimer snd_seq
snd_seq_device cmac algif_hash algif_skcipher af_alg cpufreq_ondemand
cpufreq_powersave cpufreq_conservative zstd cpufreq_userspace zstd_compress
overlay zram qrtr bnep zsmalloc binfmt_misc nls_ascii nls_cp437 vfat
intel_rapl_msr fat intel_rapl_common rtw89_8852ae rtw89_8852a btusb btrtl b=
tbcm
rtw89_pci btintel rtw89_core btmtk snd_acp3x_pdm_dma snd_acp3x_rn snd_soc_d=
mic
bluetooth snd_soc_core snd_ctl_led snd_compress snd_hda_codec_realtek mac80=
211
edac_mce_amd snd_hda_codec_generic snd_hda_codec_hdmi jitterentropy_rng
uvcvideo snd_hda_intel snd_intel_dspcfg videobuf2_vmalloc videobuf2_memops
snd_intel_sdw_acpi kvm_amd videobuf2_v4l2 drbg libarc4 videobuf2_common
ansi_cprng
2022-11-13T08:04:07.733938+01:00 computer kernel: [  553.698439]  snd_hda_c=
odec
kvm snd_hda_core videodev snd_hwdep snd_pci_acp6x ecdh_generic thinkpad_acpi
irqbypass snd_pci_acp5x cfg80211 rapl mc ecc wmi_bmof pcspkr snd_rn_pci_acp=
3x
snd_pcm snd_acp_config nvram ccp k10temp platform_profile ucsi_acpi
snd_soc_acpi typec_ucsi snd_timer sp5100_tco ledtrig_audio snd_pci_acp3x
rng_core watchdog snd roles soundcore typec rfkill ac joydev evdev serio_raw
amd_pstate msr parport_pc ppdev lp parport fuse efi_pstore configfs efivarfs
ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 crc32c_generic dm_crypt
dm_mod amdgpu gpu_sched drm_buddy i2c_algo_bit drm_display_helper crc32_pcl=
mul
crc32c_intel cec rc_core drm_ttm_helper ttm ghash_clmulni_intel rtsx_pci_sd=
mmc
xhci_pci drm_kms_helper nvme mmc_core xhci_hcd r8169 nvme_core aesni_intel =
drm
realtek t10_pi mdio_devres usbcore crypto_simd psmouse libphy
crc64_rocksoft_generic cryptd crc64_rocksoft crc_t10dif rtsx_pci i2c_piix4
crct10dif_generic crct10dif_pclmul usb_common crc64 crct10dif_common wmi
2022-11-13T08:04:07.733946+01:00 computer kernel: [  553.698572]  battery v=
ideo
i2c_scmi button sha512_ssse3 sha512_generic
2022-11-13T08:04:07.733949+01:00 computer kernel: [  553.698586] ---[ end t=
race
0000000000000000 ]---

```

After this message is printed, closing the lid and opening it again I get t=
hese
(suspend (s2idle) and (deep)):

```
2022-11-13T08:55:19.687599+01:00 computer kernel: [ 3625.820979] PM: suspend
exit
2022-11-13T08:55:19.687610+01:00 computer kernel: [ 3625.821050] PM: suspend
entry (s2idle)
2022-11-13T08:55:39.731257+01:00 computer kernel: [ 3625.857013] Filesystems
sync: 0.035 seconds
2022-11-13T08:55:39.731469+01:00 computer kernel: [ 3625.857914] Freezing u=
ser
space processes ...=20
2022-11-13T08:55:39.731480+01:00 computer kernel: [ 3625.924634] r8169
0000:05:00.0 enp5s0: Link is Down
2022-11-13T08:55:39.731488+01:00 computer kernel: [ 3645.867121]=20
2022-11-13T08:55:39.731492+01:00 computer kernel: [ 3645.867138] Freezing of
tasks failed after 20.009 seconds (1 tasks refusing to freeze, wq_busy=3D0):
2022-11-13T08:55:39.731499+01:00 computer kernel: [ 3645.867211]
task:bluetoothd      state:D stack:    0 pid: 6502 ppid:     1 flags:0x0000=
0006
2022-11-13T08:55:39.731505+01:00 computer kernel: [ 3645.867230] Call Trace:
2022-11-13T08:55:39.731511+01:00 computer kernel: [ 3645.867237]  <TASK>
2022-11-13T08:55:39.731516+01:00 computer kernel: [ 3645.867249]=20
__schedule+0x33e/0xa10
2022-11-13T08:55:39.731521+01:00 computer kernel: [ 3645.867281]=20
schedule+0x5d/0xe0
2022-11-13T08:55:39.731569+01:00 computer kernel: [ 3645.867291]=20
schedule_preempt_disabled+0x14/0x30
2022-11-13T08:55:39.731577+01:00 computer kernel: [ 3645.867299]=20
__mutex_lock.constprop.0+0x3b4/0x700
2022-11-13T08:55:39.731582+01:00 computer kernel: [ 3645.867312]=20
rfcomm_dlc_open+0x3e/0x360 [rfcomm]
2022-11-13T08:55:39.731588+01:00 computer kernel: [ 3645.867339]=20
rfcomm_sock_connect+0xd8/0x130 [rfcomm]
2022-11-13T08:55:39.731593+01:00 computer kernel: [ 3645.867358]=20
__sys_connect+0xa4/0xd0
2022-11-13T08:55:39.731683+01:00 computer kernel: [ 3645.867376]=20
__x64_sys_connect+0x14/0x20
2022-11-13T08:55:39.731693+01:00 computer kernel: [ 3645.867385]=20
do_syscall_64+0x3a/0xc0
2022-11-13T08:55:39.731700+01:00 computer kernel: [ 3645.867399]=20
entry_SYSCALL_64_after_hwframe+0x63/0xcd
2022-11-13T08:55:39.731705+01:00 computer kernel: [ 3645.867413] RIP:
0033:0x7f8d074bf470
2022-11-13T08:55:39.731711+01:00 computer kernel: [ 3645.867423] RSP:
002b:00007ffe397682c8 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
2022-11-13T08:55:39.731717+01:00 computer kernel: [ 3645.867434] RAX:
ffffffffffffffda RBX: 00007ffe397684c0 RCX: 00007f8d074bf470
2022-11-13T08:55:39.731723+01:00 computer kernel: [ 3645.867440] RDX:
000000000000000a RSI: 00007ffe397682e0 RDI: 0000000000000029
2022-11-13T08:55:39.731727+01:00 computer kernel: [ 3645.867446] RBP:
000055ec2510b410 R08: 000000000000001f R09: 000055ec250d01d0
2022-11-13T08:55:39.731732+01:00 computer kernel: [ 3645.867451] R10:
0000000000001000 R11: 0000000000000202 R12: 0000000000000000
2022-11-13T08:55:39.731737+01:00 computer kernel: [ 3645.867457] R13:
000055ec250d07f0 R14: 000055ec233329f0 R15: 00007ffe397682e0
2022-11-13T08:55:39.731741+01:00 computer kernel: [ 3645.867466]  </TASK>
2022-11-13T08:55:39.731745+01:00 computer kernel: [ 3645.867475]=20
2022-11-13T08:55:39.731751+01:00 computer kernel: [ 3645.867479] OOM killer
enabled.
2022-11-13T08:55:39.738773+01:00 computer kernel: [ 3645.867483] Restarting
tasks ... done.
2022-11-13T08:55:39.738807+01:00 computer kernel: [ 3645.873016] random: cr=
ng
reseeded on system resumption
2022-11-13T08:55:39.863568+01:00 computer kernel: [ 3645.996885] PM: suspend
exit
2022-11-13T08:55:39.939555+01:00 computer kernel: [ 3646.075416] PM: suspend
entry (deep)
2022-11-13T08:55:39.976001+01:00 computer kernel: [ 3646.112036] Filesystems
sync: 0.036 seconds
2022-11-13T08:55:59.985387+01:00 computer kernel: [ 3646.113861] Freezing u=
ser
space processes ...=20
2022-11-13T08:55:59.985459+01:00 computer kernel: [ 3666.121238] Freezing of
tasks failed after 20.007 seconds (1 tasks refusing to freeze, wq_busy=3D0):
2022-11-13T08:55:59.985470+01:00 computer kernel: [ 3666.121308]
task:bluetoothd      state:D stack:    0 pid: 6502 ppid:     1 flags:0x0000=
0006
2022-11-13T08:55:59.985476+01:00 computer kernel: [ 3666.121325] Call Trace:
2022-11-13T08:55:59.985481+01:00 computer kernel: [ 3666.121331]  <TASK>
2022-11-13T08:55:59.985486+01:00 computer kernel: [ 3666.121343]=20
__schedule+0x33e/0xa10
2022-11-13T08:55:59.985494+01:00 computer kernel: [ 3666.121374]=20
schedule+0x5d/0xe0
2022-11-13T08:55:59.985499+01:00 computer kernel: [ 3666.121383]=20
schedule_preempt_disabled+0x14/0x30
2022-11-13T08:55:59.985544+01:00 computer kernel: [ 3666.121392]=20
__mutex_lock.constprop.0+0x3b4/0x700
2022-11-13T08:55:59.985550+01:00 computer kernel: [ 3666.121404]=20
rfcomm_dlc_open+0x3e/0x360 [rfcomm]
2022-11-13T08:55:59.985556+01:00 computer kernel: [ 3666.121431]=20
rfcomm_sock_connect+0xd8/0x130 [rfcomm]
2022-11-13T08:55:59.985561+01:00 computer kernel: [ 3666.121449]=20
__sys_connect+0xa4/0xd0
2022-11-13T08:55:59.985568+01:00 computer kernel: [ 3666.121467]=20
__x64_sys_connect+0x14/0x20
2022-11-13T08:55:59.985574+01:00 computer kernel: [ 3666.121475]=20
do_syscall_64+0x3a/0xc0
2022-11-13T08:55:59.985579+01:00 computer kernel: [ 3666.121489]=20
entry_SYSCALL_64_after_hwframe+0x63/0xcd
2022-11-13T08:55:59.985584+01:00 computer kernel: [ 3666.121502] RIP:
0033:0x7f8d074bf470
2022-11-13T08:55:59.985588+01:00 computer kernel: [ 3666.121512] RSP:
002b:00007ffe397682c8 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
2022-11-13T08:55:59.985593+01:00 computer kernel: [ 3666.121522] RAX:
ffffffffffffffda RBX: 00007ffe397684c0 RCX: 00007f8d074bf470
2022-11-13T08:55:59.985599+01:00 computer kernel: [ 3666.121528] RDX:
000000000000000a RSI: 00007ffe397682e0 RDI: 0000000000000029
2022-11-13T08:55:59.985604+01:00 computer kernel: [ 3666.121534] RBP:
000055ec2510b410 R08: 000000000000001f R09: 000055ec250d01d0
2022-11-13T08:55:59.985610+01:00 computer kernel: [ 3666.121539] R10:
0000000000001000 R11: 0000000000000202 R12: 0000000000000000
2022-11-13T08:55:59.985615+01:00 computer kernel: [ 3666.121544] R13:
000055ec250d07f0 R14: 000055ec233329f0 R15: 00007ffe397682e0
2022-11-13T08:55:59.985619+01:00 computer kernel: [ 3666.121553]  </TASK>
2022-11-13T08:55:59.985624+01:00 computer kernel: [ 3666.121562]=20
2022-11-13T08:55:59.985628+01:00 computer kernel: [ 3666.121565] OOM killer
enabled.
2022-11-13T08:55:59.991624+01:00 computer kernel: [ 3666.121569] Restarting
tasks ... done.
2022-11-13T08:55:59.991654+01:00 computer kernel: [ 3666.125306] random: cr=
ng
reseeded on system resumption
2022-11-13T08:56:00.023913+01:00 computer kernel: [ 3666.156324] Generic FE=
-GE
Realtek PHY r8169-0-200:00: attached PHY driver
(mii_bus:phy_addr=3Dr8169-0-200:00, irq=3DMAC)
2022-11-13T08:56:00.115588+01:00 computer kernel: [ 3666.248877] PM: suspend
exit
2022-11-13T08:56:00.115604+01:00 computer kernel: [ 3666.248972] PM: suspend
entry (s2idle)
```

Best,
Gabriel Francisco

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
