Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE55C6FA99
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Mar 2023 07:27:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCJH15 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 02:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjCJH1x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 02:27:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444E9107D66
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 23:27:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB87660DC4
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 07:27:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 419F5C4339C
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 07:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678433263;
        bh=HZRVMP83yS/DwAnI7aYEaFbU7xTA7RURySN2bUiWl2U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UI1oT/Rpsb7glRVTzJx2J2giTlrIDtJv3AjNEN3UUBUYe4lrZnPKtunSspfLVthkl
         7zyuv4NweucPpqa+hRxxNxrntHXxrL3H3NXX6tV5Qx5tp6m4Doh8eVOIJJSjDkJ0HP
         aQOkyImErtSRZZgg7rWXAE3bdojGtXqJJ4vkJwbc5qhszrUohTUcllRtvaEZHTtFdP
         MYUYsagABr5k6tW/ZGhJ/yVs10o+wbQxsrmbus7CWyX+ynbGA2gzWqvZawKZ6llLA1
         RhQ8FFlwONCiqDVtvlr9PGCvg+vtDCxrxSFpb0pMrBKKh+RgsV3RYZsZpcWuOaw3X8
         EKDq5KCiV+29w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 1EBC6C43144; Fri, 10 Mar 2023 07:27:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217023] [Intel AX200] hci0: Malformed MSFT vendor event: 0x02
Date:   Fri, 10 Mar 2023 07:27:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bavay@slf.ch
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-217023-62941-j2S6p6Tj97@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217023-62941@https.bugzilla.kernel.org/>
References: <bug-217023-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217023

Mathias Bavay (bavay@slf.ch) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bavay@slf.ch

--- Comment #2 from Mathias Bavay (bavay@slf.ch) ---
Same error on newer Intel hardware (AX210), since I've started using kernel
5.19.x (compiled by Ubuntu). My bluetooth keyboard and mouse also now need =
~1
second when the desktop is loaded before being usable. With my previous ker=
nel
(5.15.x), this error message did not appear and I could use the keyboard ri=
ght
away, without the small lag that I now experience.

$ lsusb | grep Bluetooth
Bus 001 Device 002: ID 8087:0032 Intel Corp. AX210 Bluetooth

$ dmesg | grep hci0
[   18.025550] Bluetooth: hci0: Device revision is 0
[   18.025553] Bluetooth: hci0: Secure boot is enabled
[   18.025554] Bluetooth: hci0: OTP lock is enabled
[   18.025555] Bluetooth: hci0: API lock is enabled
[   18.025556] Bluetooth: hci0: Debug lock is disabled
[   18.025557] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[   18.025558] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 bu=
ild
38
[   18.026909] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.=
sfi
[   18.026936] Bluetooth: hci0: Boot Address: 0x100800
[   18.026938] Bluetooth: hci0: Firmware Version: 132-5.22
[   19.585644] Bluetooth: hci0: Waiting for firmware download to complete
[   19.585655] Bluetooth: hci0: Firmware loaded in 1522209 usecs
[   19.585821] Bluetooth: hci0: Waiting for device to boot
[   19.612549] Bluetooth: hci0: Device booted in 26194 usecs
[   19.612617] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[   19.613943] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-0041-0041.ddc
[   19.615693] Bluetooth: hci0: Applying Intel DDC parameters completed
[   19.618707] Bluetooth: hci0: Firmware timestamp 2022.5 buildtype 1 build
38020
[   19.865890] Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)
[   19.866093] Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)

$ uname -a
Linux 5.19.0-35-generic #36~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Fri Feb 17
15:17:25 UTC 2 x86_64 x86_64 x86_64 GNU/Linux

$ lscpu
Intel(R) Core(TM) i7-9750H CPU @ 2.60GHz

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
