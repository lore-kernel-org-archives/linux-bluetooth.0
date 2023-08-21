Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FAAEE49A0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 19:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjHUTZV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 15:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjHUTZT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 15:25:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A9ADB
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 12:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8788B63F3D
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 19:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9ED1C433C8
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 19:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692645916;
        bh=ymnemX/kgSAxRoJUezKr/qoGzPMo4ceKioC2l4JROMA=;
        h=From:To:Subject:Date:From;
        b=EFaJ7KKtxR/4j1IGsB6zNQunLtN0Md7DAelLm3oIlE6DpYOxlU/8q0fNxgf8Sczji
         CXHLDXpjqSnr1I7XziUgY31UPWyC35z+AsQaDpJJR2fxNtsd6puKo1uL1BFs4hz8G2
         pnXuVXH7nbvV2LuhJCgqGVbNn/dEJ3Vcv+XHnU1qutHycWwT/OXJS57515fWULOCB9
         OoSPcsPMYubIcSKHEhxRsfIe3bOQfL73O2KZoFpL/N8qTMpUPW+GlMo9NDaAxxY75T
         7Krm5ZF/VTST17OdHnAczoQQaInIUzFXJU05Fo0sEl5+SeYJPSPJM4xB8xEs1rBnbR
         hZ7nHaTYrhs/A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D79E4C4332E; Mon, 21 Aug 2023 19:25:16 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217812] New: Bluetooth: hci0: unexpected cc 0x041a length: 7 >
 1 on bluetooth scan (CSR chip)
Date:   Mon, 21 Aug 2023 19:25:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: georg.schwarz@freenet.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-217812-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217812

            Bug ID: 217812
           Summary: Bluetooth: hci0: unexpected cc 0x041a length: 7 > 1 on
                    bluetooth scan (CSR chip)
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: georg.schwarz@freenet.de
        Regression: No

The bug occurs with the following USB bluetooth dongle:

https://fccid.io/SHP-BED009/Label/Label-Location-and-Sample-572556

USB ID 0x0a12 0x0001

identified by the kernel as

Bluetooth: hci0: CSR: Setting up dongle with HCI ver=3D3 rev=3D07a6; LMP ve=
r=3D3
subver=3D 07a6; manufacturer=3D10

I opened up the dongle, and the chip has a CSR logo and the following
inscription printed on it: 41B14 3A05U 549AE

I know that 0x0a12 0x0001 are often fake Chinese chips, but this one to the
best of my knowledge is an original one (BT 2.0).
(and the kernel correctly does not identify it as a fake, so that's not the
issue here).


Description of the bug:
When scanning for bluetooth devices (using Blueman's Search) any bluetooth
device (e.g. phone, speaker, etc.) found is listed with its MAC only, not i=
ts
name, unless that device has previously been paired with (and its data is
cached in /var/lib/bluetooth/(adapter's MAC)/cache/, in which case the name=
 is
probably not queried).
In the system log the following entry is added on every search which yields=
 at
least one such "MAC-only" device:

Bluetooth: hci0: unexpected cc 0x041a length: 7 > 1

Needless to say the devices' names do resolve when scanned from other
computers/phones (including from another Linux system running the same fresh
Manjaro installation but featuring different BT hardware).

I have tested it on two different machines (with the above BT dongle) with
numerous Linux distributions and kernels and bluez releases. I can reproduc=
e it
directly with a Manjaro or Xubuntu live/install image.
The above kernel message occurs with kernels 6.1.44, 6.4.9 and 6.5.0rc5.

None of the test machines are dual-boot, they are Linux-only.

With some much older installations (Xubuntu 16 or 18 for example), the BT n=
ames
do not get resolved either (same behavior), but the syslog message is a
different one:

Bluetooth: hci0: last event is not cmd complete (0x0f)

I suspect that it is still the same bug though, just a different message in
older kernels.

In addition, I noticed the following which may or may not be related:
When booting up without the BT dongle attached and then plugging it in, the
following message is written to syslog (before the kernel messages about the
new BT device):

Bluetooth: hci0: unexpected event for opcode 0x0000

This is true for all the kernels I tried (at least the 6.X ones).

I initially opened an issue with Blueman
(https://github.com/blueman-project/blueman/issues/2116), but I am convinced
now that it is actually a driver (kernel) issue.

If I can provide further information or tests, please kindly let me know.
Thanks.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
