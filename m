Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E173AEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 08:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjF2Imj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 04:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjF2IlV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 04:41:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419512972
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 01:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9CF9614ED
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 08:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B46FC433C0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jun 2023 08:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688028001;
        bh=J9lI1TVsk4dRc0TxdV2yOZcNOYeP0kVnO+gs5T9jNM4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LlA7Pt2Q1MyX8/+MOtqvP+MVmS1hmpgpnyO75MDWlmThG+ao8KZj4HTmHeX+Ws/tY
         6d4JxObijiyx98osZyzaPzr3pinu9Znc+vkXNT3z+xtF4HJmg3Qjv8s0mUn/x66TtI
         phiTcNosLyxvBaZ3iP3t8mwFugdsr90Syq7I2SVNZEn72eWtZ+whY+Gr7vBMd1uaof
         OjaWLjCv/9Lew83Iw+1xyRcrPTpGYu66rWviwFhdMjxpGJl4s9VDlr+TVQ8M44Gg4G
         AtoNcUWEC0NiVUf82l7P+QuDgqNxImOOHwHHZwxqINqp5YfNf2Q99le3nTx+O+6caA
         xgxJ2vfea0/gA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id EDFB3C4332E; Thu, 29 Jun 2023 08:40:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217581] Bluetooth L2CAP use-after-free
Date:   Thu, 29 Jun 2023 08:40:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mohamed-yassine.jebabli@witbe.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217581-62941-jpvEHC45Bf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217581-62941@https.bugzilla.kernel.org/>
References: <bug-217581-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217581

--- Comment #8 from Mohamed Yassine JEBABLI (mohamed-yassine.jebabli@witbe.=
net) ---
(In reply to Bagas Sanjaya from comment #6)
> On 6/27/23 20:23, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D217581
> >=20
> > --- Comment #5 from Mohamed Yassine JEBABLI
> > (mohamed-yassine.jebabli@witbe.net) ---
> > (In reply to Bagas Sanjaya from comment #4)
> >> (In reply to Mohamed Yassine JEBABLI from comment #0)
> >>> In reconnect slave mode, I start direct advertising. After establishi=
ng
> the
> >>> connection with the central device, we begin ATT exchanges over the L=
2CAP
> >>> socket, and then I receive a disconnect with L2CAP traces. This issue=
 is
> >>> observed across different kernel versions such as 5.17, 6.2, 6.3, 6.3=
.7,
> >> etc.
> >>>
> >>
> >> Do you have this issue on v5.15?
> >=20
> > Not tested on v5.15. I started with 5.17 version.
> >=20
>=20
> Again: Do you have this issue on v5.15?

Tested on kernel v5.15 with l2cap_core traces enabled.=20
=3D=3D> The same scenario from reconnecr to disconnect and I think the same=
 bug
related to rfcount which goes to NULL in the other versions > v5.15.=20

Jun 28 14:41:36 buildroot kernel: chan 7942e3b3 orig refcnt 1
Jun 28 14:41:36 buildroot kernel: hcon 5a56584a bdaddr 48:b0:2d:02:81:0a st=
atus
0
Jun 28 14:41:36 buildroot kernel: hcon 5a56584a conn d7202d29 hchan 981967be
Jun 28 14:41:36 buildroot kernel: chan 7942e3b3 orig refcnt 2
Jun 28 14:41:36 buildroot kernel: chan e8221202
Jun 28 14:41:36 buildroot kernel: chan e8221202 orig refcnt 1
Jun 28 14:41:36 buildroot kernel: conn d7202d29, psm 0x00, dcid 0x0004
Jun 28 14:41:36 buildroot kernel: chan e8221202 orig refcnt 2
Jun 28 14:41:36 buildroot kernel: chan e5e549e1 orig refcnt 1
Jun 28 14:41:36 buildroot kernel: chan 7942e3b3 orig refcnt 3
Jun 28 14:41:36 buildroot kernel: chan 05ee00c1
Jun 28 14:41:36 buildroot kernel: conn d7202d29, psm 0x00, dcid 0x0006
Jun 28 14:41:36 buildroot kernel: chan 05ee00c1 orig refcnt 1
Jun 28 14:41:36 buildroot kernel: chan e5e549e1 orig refcnt 2
Jun 28 14:41:36 buildroot kernel: conn d7202d29
Jun 28 14:41:36 buildroot kernel: chan 05ee00c1 len 2
Jun 28 14:41:36 buildroot kernel: chan 05ee00c1, skb 62f90460 len 6 priorit=
y 7
Jun 28 14:41:36 buildroot kernel: hci1 conn d7202d29
Jun 28 14:41:36 buildroot kernel:=20
Jun 28 14:41:37 buildroot kernel: hcon 5a56584a reason 19
Jun 28 14:41:37 buildroot kernel: hcon 5a56584a conn d7202d29, err 104
Jun 28 14:41:37 buildroot kernel: chan 05ee00c1 orig refcnt 2
Jun 28 14:41:37 buildroot kernel: chan 05ee00c1, conn d7202d29, err 104, st=
ate
BT_CONNECTED
Jun 28 14:41:37 buildroot kernel: chan 05ee00c1 orig refcnt 3
Jun 28 14:41:37 buildroot kernel: chan 05ee00c1 orig refcnt 2
Jun 28 14:41:37 buildroot kernel: chan 05ee00c1 orig refcnt 1
Jun 28 14:41:37 buildroot kernel: chan 05ee00c1
Jun 28 14:41:37 buildroot kernel: chan e8221202 orig refcnt 3
Jun 28 14:41:37 buildroot kernel: chan e8221202, conn d7202d29, err 104, st=
ate
BT_OPEN
Jun 28 14:41:37 buildroot kernel: chan e8221202 orig refcnt 4
Jun 28 14:41:37 buildroot kernel: chan e8221202 orig refcnt 3
Jun 28 14:41:37 buildroot kernel: chan e8221202 orig refcnt 2
Jun 28 14:41:37 buildroot kernel: chan 7942e3b3 orig refcnt 2
Jun 28 14:41:37 buildroot kernel: chan 7942e3b3 state BT_LISTEN
Jun 28 14:41:37 buildroot kernel: chan e8221202 orig refcnt 1
Jun 28 14:41:37 buildroot kernel: chan e8221202
Jun 28 14:41:37 buildroot kernel: chan e8221202 orig refcnt 0
Jun 28 14:41:37 buildroot kernel: ------------[ cut here ]------------
Jun 28 14:41:37 buildroot kernel: WARNING: CPU: 1 PID: 476 at lib/refcount.=
c:25
l2cap_sock_teardown_cb+0x13c/0x23c
Jun 28 14:41:37 buildroot kernel: refcount_t: addition on 0; use-after-free.
Jun 28 14:41:37 buildroot kernel: Modules linked in: algif_hash algif_skcip=
her
af_alg stm32_adc stm32_timer_trigger stm32_lptimer_trigger galcore(O)
stm32_crc32 stm32_cryp stm32_hash libdes crypto_engine stm32_adc_core stm32=
_cec
Jun 28 14:41:37 buildroot kernel: CPU: 1 PID: 476 Comm: HCIManager Tainted:=
 G=20=20
        O      5.15.67 #2
Jun 28 14:41:37 buildroot kernel: Hardware name: STM32 (Device Tree Support)
Jun 28 14:41:37 buildroot kernel: [<c0110c54>] (unwind_backtrace) from
[<c010c61c>] (show_stack+0x10/0x14)
Jun 28 14:41:37 buildroot kernel: [<c010c61c>] (show_stack) from [<c0ca2f50=
>]
(dump_stack_lvl+0x40/0x4c)
Jun 28 14:41:37 buildroot kernel: [<c0ca2f50>] (dump_stack_lvl) from
[<c0120fc0>] (__warn+0xec/0x104)
Jun 28 14:41:37 buildroot kernel: [<c0120fc0>] (__warn) from [<c0c9e214>]
(warn_slowpath_fmt+0x98/0xc4)
Jun 28 14:41:37 buildroot kernel: [<c0c9e214>] (warn_slowpath_fmt) from
[<c0b67748>] (l2cap_sock_teardown_cb+0x13c/0x23c)
Jun 28 14:41:37 buildroot kernel: [<c0b67748>] (l2cap_sock_teardown_cb) from
[<c0b5f584>] (l2cap_chan_close+0x138/0x2f4)
Jun 28 14:41:37 buildroot kernel: [<c0b5f584>] (l2cap_chan_close) from
[<c0b67a60>] (l2cap_sock_shutdown+0x218/0x5ac)
Jun 28 14:41:37 buildroot kernel: [<c0b67a60>] (l2cap_sock_shutdown) from
[<c0b67e44>] (l2cap_sock_release+0x50/0xe8)
Jun 28 14:41:37 buildroot kernel: [<c0b67e44>] (l2cap_sock_release) from
[<c09b7f10>] (__sock_release+0x40/0xb8)
Jun 28 14:41:37 buildroot kernel: [<c09b7f10>] (__sock_release) from
[<c09b7f98>] (sock_close+0x10/0x18)
Jun 28 14:41:37 buildroot kernel: [<c09b7f98>] (sock_close) from [<c02a6e84=
>]
(__fput+0x74/0x240)
Jun 28 14:41:37 buildroot kernel: [<c02a6e84>] (__fput) from [<c0141ac0>]
(task_work_run+0x90/0xbc)
Jun 28 14:41:37 buildroot kernel: [<c0141ac0>] (task_work_run) from
[<c010c048>] (do_work_pending+0x498/0x594)
Jun 28 14:41:37 buildroot kernel: [<c010c048>] (do_work_pending) from
[<c01000c0>] (slow_work_pending+0xc/0x20)
Jun 28 14:41:37 buildroot kernel: Exception stack(0xc3fe1fb0 to 0xc3fe1ff8)
Jun 28 14:41:37 buildroot kernel: 1fa0:=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
00000000 00000002 00000000 00000000
Jun 28 14:41:37 buildroot kernel: 1fc0: 00000006 b4dfd8c0 00000005 00000006
b4dfd400 b4dfd470 00000000 b4dfcb7c
Jun 28 14:41:37 buildroot kernel: 1fe0: 00000006 b4dfcb58 b6b96bf9 b6b98b26
80030030 00000006
Jun 28 14:41:37 buildroot kernel: ---[ end trace b1ffe2b440acbd97 ]---
Jun 28 14:41:37 buildroot kernel: chan e8221202 state BT_OPEN
Jun 28 14:41:37 buildroot kernel: chan e8221202 orig refcnt 3221225472
Jun 28 14:41:37 buildroot kernel: ------------[ cut here ]------------
Jun 28 14:41:37 buildroot kernel: WARNING: CPU: 1 PID: 476 at lib/refcount.=
c:28
l2cap_sock_kill.part.0+0x28/0xc0
Jun 28 14:41:37 buildroot kernel: refcount_t: underflow; use-after-free.
Jun 28 14:41:37 buildroot kernel: Modules linked in: algif_hash algif_skcip=
her
af_alg stm32_adc stm32_timer_trigger stm32_lptimer_trigger galcore(O)
stm32_crc32 stm32_cryp stm32_hash libdes crypto_engine stm32_adc_core stm32=
_cec
Jun 28 14:41:37 buildroot kernel: CPU: 1 PID: 476 Comm: HCIManager Tainted:=
 G=20=20
     W  O      5.15.67 #2
Jun 28 14:41:37 buildroot kernel: Hardware name: STM32 (Device Tree Support)
Jun 28 14:41:37 buildroot kernel: [<c0110c54>] (unwind_backtrace) from
[<c010c61c>] (show_stack+0x10/0x14)
Jun 28 14:41:37 buildroot kernel: [<c010c61c>] (show_stack) from [<c0ca2f50=
>]
(dump_stack_lvl+0x40/0x4c)
Jun 28 14:41:37 buildroot kernel: [<c0ca2f50>] (dump_stack_lvl) from
[<c0120fc0>] (__warn+0xec/0x104)
Jun 28 14:41:37 buildroot kernel: [<c0120fc0>] (__warn) from [<c0c9e214>]
(warn_slowpath_fmt+0x98/0xc4)
Jun 28 14:41:37 buildroot kernel: [<c0c9e214>] (warn_slowpath_fmt) from
[<c0b6754c>] (l2cap_sock_kill.part.0+0x28/0xc0)
Jun 28 14:41:37 buildroot kernel: [<c0b6754c>] (l2cap_sock_kill.part.0) from
[<c0b67708>] (l2cap_sock_teardown_cb+0xfc/0x23c)
Jun 28 14:41:37 buildroot kernel: [<c0b67708>] (l2cap_sock_teardown_cb) from
[<c0b5f584>] (l2cap_chan_close+0x138/0x2f4)
Jun 28 14:41:37 buildroot kernel: [<c0b5f584>] (l2cap_chan_close) from
[<c0b67a60>] (l2cap_sock_shutdown+0x218/0x5ac)
Jun 28 14:41:37 buildroot kernel: [<c0b67a60>] (l2cap_sock_shutdown) from
[<c0b67e44>] (l2cap_sock_release+0x50/0xe8)
Jun 28 14:41:37 buildroot kernel: [<c0b67e44>] (l2cap_sock_release) from
[<c09b7f10>] (__sock_release+0x40/0xb8)
Jun 28 14:41:37 buildroot kernel: [<c09b7f10>] (__sock_release) from
[<c09b7f98>] (sock_close+0x10/0x18)
Jun 28 14:41:37 buildroot kernel: [<c09b7f98>] (sock_close) from [<c02a6e84=
>]
(__fput+0x74/0x240)
Jun 28 14:41:37 buildroot kernel: [<c02a6e84>] (__fput) from [<c0141ac0>]
(task_work_run+0x90/0xbc)
Jun 28 14:41:37 buildroot kernel: [<c0141ac0>] (task_work_run) from
[<c010c048>] (do_work_pending+0x498/0x594)
Jun 28 14:41:37 buildroot kernel: [<c010c048>] (do_work_pending) from
[<c01000c0>] (slow_work_pending+0xc/0x20)
Jun 28 14:41:37 buildroot kernel: Exception stack(0xc3fe1fb0 to 0xc3fe1ff8)
Jun 28 14:41:37 buildroot kernel: 1fa0:=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
00000000 00000002 00000000 00000000
Jun 28 14:41:37 buildroot kernel: 1fc0: 00000006 b4dfd8c0 00000005 00000006
b4dfd400 b4dfd470 00000000 b4dfcb7c
Jun 28 14:41:37 buildroot kernel: 1fe0: 00000006 b4dfcb58 b6b96bf9 b6b98b26
80030030 00000006
Jun 28 14:41:37 buildroot kernel: ---[ end trace b1ffe2b440acbd98 ]---
Jun 28 14:41:37 buildroot kernel: chan e8221202 orig refcnt 3221225472
Jun 28 14:41:37 buildroot kernel: chan 7942e3b3 orig refcnt 3
Jun 28 14:41:37 buildroot kernel: chan 7942e3b3 orig refcnt 2
Jun 28 14:41:37 buildroot kernel: chan 7942e3b3 orig refcnt 3
Jun 28 14:41:37 buildroot kernel: chan 7942e3b3 orig refcnt 2
Jun 28 14:41:37 buildroot kernel: chan 7942e3b3 orig refcnt 1
Jun 28 14:41:37 buildroot kernel: chan 7942e3b3

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
