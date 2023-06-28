Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA696EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 12:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjF1MJM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 08:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjF1MJK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 08:09:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31845198A
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 05:09:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA6726126D
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 12:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24D9AC433C0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 12:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687954147;
        bh=aSPeVm5Km0ukI0oS4VVfZRrjEuZpsU+BYek5CsYEkQY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=l6rkP14UTotVQ1ICziKsrM2ckq+67CSnWaxN4ScTOEsCbIWpCe+/0eBPjIlBOnyP/
         do9mY0nCzotT+HaI+XQ3HfURUGvyKu5yv2vunYZq0YniNlypD9+Z+OYjoZJ2/ZPnTJ
         Oq38yFoWsIRr+e4Wt8nfS16Int9rtcGJy2S9zfn6+AeZPUPYYznCvKiaAB+kMFFkj2
         BoVyoDmaA6TsvsE91paV+xgKCuNQB6z5Jv2CVnp1CpkblswwA3UuXWhT86+8b4WjeQ
         naQN8Jhk2lVnICJSiUzwqGm/j34FHKEq192K0KdN8nDf/SBNXjCOlIVALqQ1X9dOE3
         w2xmOiSudpGkQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 07480C4332E; Wed, 28 Jun 2023 12:09:07 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217581] Bluetooth L2CAP use-after-free
Date:   Wed, 28 Jun 2023 12:09:06 +0000
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
Message-ID: <bug-217581-62941-EPzf3P5CO5@https.bugzilla.kernel.org/>
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

--- Comment #7 from Mohamed Yassine JEBABLI (mohamed-yassine.jebabli@witbe.=
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

Yes with v5.15 I have this crash :
[ 1773.685161] ------------[ cut here ]------------
[ 1773.688454] WARNING: CPU: 1 PID: 728 at lib/refcount.c:25
l2cap_sock_teardown_cb+0x13c/0x23c
[ 1773.696823] refcount_t: addition on 0; use-after-free.
[ 1773.696833] Modules linked in: algif_hash algif_skcipher af_alg stm32_adc
stm32_timer_trigger stm32_lptimer_trigger galcore(O) stm32_crc32 stm32_cryp
stm32_hash libdes crypto_engine stm32_adc_core stm32_cec
[ 1773.696957] CPU: 1 PID: 728 Comm: HCIManager Tainted: G           O=20=
=20=20=20=20
5.15.67 #2
[ 1773.696978] Hardware name: STM32 (Device Tree Support)
[ 1773.697000] [<c0110c54>] (unwind_backtrace) from [<c010c61c>]
(show_stack+0x10/0x14)
[ 1773.697039] [<c010c61c>] (show_stack) from [<c0ca2f50>]
(dump_stack_lvl+0x40/0x4c)
[ 1773.697076] [<c0ca2f50>] (dump_stack_lvl) from [<c0120fc0>]
(__warn+0xec/0x104)
[ 1773.697111] [<c0120fc0>] (__warn) from [<c0c9e214>]
(warn_slowpath_fmt+0x98/0xc4)
[ 1773.697144] [<c0c9e214>] (warn_slowpath_fmt) from [<c0b67748>]
(l2cap_sock_teardown_cb+0x13c/0x23c)
[ 1773.697180] [<c0b67748>] (l2cap_sock_teardown_cb) from [<c0b5f584>]
(l2cap_chan_close+0x138/0x2f4)
[ 1773.697214] [<c0b5f584>] (l2cap_chan_close) from [<c0b67a60>]
(l2cap_sock_shutdown+0x218/0x5ac)
[ 1773.697246] [<c0b67a60>] (l2cap_sock_shutdown) from [<c0b67e44>]
(l2cap_sock_release+0x50/0xe8)
[ 1773.697279] [<c0b67e44>] (l2cap_sock_release) from [<c09b7f10>]
(__sock_release+0x40/0xb8)
[ 1773.697315] [<c09b7f10>] (__sock_release) from [<c09b7f98>]
(sock_close+0x10/0x18)
[ 1773.697345] [<c09b7f98>] (sock_close) from [<c02a6e84>] (__fput+0x74/0x2=
40)
[ 1773.697376] [<c02a6e84>] (__fput) from [<c0141ac0>]
(task_work_run+0x90/0xbc)
[ 1773.697405] [<c0141ac0>] (task_work_run) from [<c010c048>]
(do_work_pending+0x498/0x594)
[ 1773.697432] [<c010c048>] (do_work_pending) from [<c01000c0>]
(slow_work_pending+0xc/0x20)
[ 1773.697459] Exception stack(0xc2d0ffb0 to 0xc2d0fff8)
[ 1773.697478] ffa0:                                     00000000 00000002
00000000 00000000
[ 1773.697498] ffc0: 00000006 b4dfd8c0 00000005 00000006 b4dfd400 b4dfd470
00000000 b4dfcb7c
[ 1773.697515] ffe0: 00000006 b4dfcb58 b6b9fbf9 b6ba1b26 80030030 00000006
[ 1773.697529] ---[ end trace 414d690f067a95d5 ]---
[ 1773.701561] ------------[ cut here ]------------
[ 1773.706049] WARNING: CPU: 1 PID: 728 at lib/refcount.c:28
l2cap_sock_kill.part.0+0x28/0xc0
[ 1773.714484] refcount_t: underflow; use-after-free.
[ 1773.714500] Modules linked in: algif_hash algif_skcipher af_alg stm32_adc
stm32_timer_trigger stm32_lptimer_trigger galcore(O) stm32_crc32 stm32_cryp
stm32_hash libdes crypto_engine stm32_adc_core stm32_cec
[ 1773.714624] CPU: 1 PID: 728 Comm: HCIManager Tainted: G        W  O=20=
=20=20=20=20
5.15.67 #2
[ 1773.714648] Hardware name: STM32 (Device Tree Support)
[ 1773.714668] [<c0110c54>] (unwind_backtrace) from [<c010c61c>]
(show_stack+0x10/0x14)
[ 1773.714711] [<c010c61c>] (show_stack) from [<c0ca2f50>]
(dump_stack_lvl+0x40/0x4c)
[ 1773.714748] [<c0ca2f50>] (dump_stack_lvl) from [<c0120fc0>]
(__warn+0xec/0x104)
[ 1773.714782] [<c0120fc0>] (__warn) from [<c0c9e214>]
(warn_slowpath_fmt+0x98/0xc4)
[ 1773.714815] [<c0c9e214>] (warn_slowpath_fmt) from [<c0b6754c>]
(l2cap_sock_kill.part.0+0x28/0xc0)
[ 1773.714850] [<c0b6754c>] (l2cap_sock_kill.part.0) from [<c0b67708>]
(l2cap_sock_teardown_cb+0xfc/0x23c)
[ 1773.714885] [<c0b67708>] (l2cap_sock_teardown_cb) from [<c0b5f584>]
(l2cap_chan_close+0x138/0x2f4)
[ 1773.714917] [<c0b5f584>] (l2cap_chan_close) from [<c0b67a60>]
(l2cap_sock_shutdown+0x218/0x5ac)
[ 1773.714949] [<c0b67a60>] (l2cap_sock_shutdown) from [<c0b67e44>]
(l2cap_sock_release+0x50/0xe8)
[ 1773.714983] [<c0b67e44>] (l2cap_sock_release) from [<c09b7f10>]
(__sock_release+0x40/0xb8)
[ 1773.715017] [<c09b7f10>] (__sock_release) from [<c09b7f98>]
(sock_close+0x10/0x18)
[ 1773.715046] [<c09b7f98>] (sock_close) from [<c02a6e84>] (__fput+0x74/0x2=
40)
[ 1773.715075] [<c02a6e84>] (__fput) from [<c0141ac0>]
(task_work_run+0x90/0xbc)
[ 1773.715104] [<c0141ac0>] (task_work_run) from [<c010c048>]
(do_work_pending+0x498/0x594)
[ 1773.715131] [<c010c048>] (do_work_pending) from [<c01000c0>]
(slow_work_pending+0xc/0x20)
[ 1773.715157] Exception stack(0xc2d0ffb0 to 0xc2d0fff8)
[ 1773.715177] ffa0:                                     00000000 00000002
00000000 00000000
[ 1773.715197] ffc0: 00000006 b4dfd8c0 00000005 00000006 b4dfd400 b4dfd470
00000000 b4dfcb7c
[ 1773.715214] ffe0: 00000006 b4dfcb58 b6b9fbf9 b6ba1b26 80030030 00000006
[ 1773.715227] ---[ end trace 414d690f067a95d6 ]---

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
