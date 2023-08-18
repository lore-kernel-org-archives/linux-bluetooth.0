Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004E1C678DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Aug 2023 10:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245736AbjHRKCO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Aug 2023 06:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359657AbjHRKBt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Aug 2023 06:01:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C5F35A4
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 03:01:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A39AA66624
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 10:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3B9FC433BB
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Aug 2023 10:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692352836;
        bh=qTK9QJDt0lCvJaq/+tQvwHeFsJtRKCMwuolPTX3nvQQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LqHd6nexHXTWxusY3N3FYOarbHK8dmnUldgBBS0WEkL5QsunrlDjGciJm7s8FLCfj
         /vQR4r1IiaQDCJ2tWvZUd1Du+ugMw4jTkfxAd21wLbQ6pBhv0dNp8gPUrkNtbQLawp
         UYemtxq/yBgFGqnsR6h/usWLi97PV5kos4G016GkzVC/S70H0A28hTpKHc/+7u+oSt
         /PH1/vgKbLkw6PqJmDreAwqQE+zrLYQDJPrZEd51xkiq77dLmEXbq5aD1AyvzBH7zx
         LxlAZqXELWetrufwwyp45iRiB01yQjWG6/SThLX2HcyyB2wZmzEbUK+EUdALjHzP70
         GiQwys6ACoBIQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4B8C5C53BD3; Fri, 18 Aug 2023 10:00:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217023] [Intel AX200] hci0: Malformed MSFT vendor event: 0x02
Date:   Fri, 18 Aug 2023 10:00:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: andretiagob@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217023-62941-m7O2NhalEm@https.bugzilla.kernel.org/>
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

--- Comment #8 from Andr=C3=A9 Barata (andretiagob@protonmail.com) ---
Same error here, Intel Killer WiFi 6E AX1675

Bus 003 Device 006: ID 8087:0033 Intel Corp.=20

dmesg | grep hci0
[    6.616282] Bluetooth: hci0: Device revision is 0
[    6.616287] Bluetooth: hci0: Secure boot is enabled
[    6.616289] Bluetooth: hci0: OTP lock is enabled
[    6.616290] Bluetooth: hci0: API lock is enabled
[    6.616291] Bluetooth: hci0: Debug lock is disabled
[    6.616292] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
[    6.616294] Bluetooth: hci0: Bootloader timestamp 2019.40 buildtype 1 bu=
ild
38
[    6.677948] Bluetooth: hci0: Found device firmware: intel/ibt-0040-0041.=
sfi
[    6.677973] Bluetooth: hci0: Boot Address: 0x100800
[    6.677975] Bluetooth: hci0: Firmware Version: 98-13.23
[    8.301161] Bluetooth: hci0: Waiting for firmware download to complete
[    8.301242] Bluetooth: hci0: Firmware loaded in 1585261 usecs
[    8.301285] Bluetooth: hci0: Waiting for device to boot
[    8.317241] Bluetooth: hci0: Device booted in 15612 usecs
[    8.317365] Bluetooth: hci0: Malformed MSFT vendor event: 0x02
[    8.317557] Bluetooth: hci0: Found Intel DDC parameters:
intel/ibt-0040-0041.ddc
[    8.320382] Bluetooth: hci0: Applying Intel DDC parameters completed
[    8.323374] Bluetooth: hci0: Firmware timestamp 2023.13 buildtype 1 build
62562
[    8.469680] Bluetooth: hci0: Bad flag given (0x1) vs supported (0x0)

$ uname -a
Linux MSI.Home 6.4.10-200.fc38.x86_64 #1 SMP PREEMPT_DYNAMIC Wed Jul 19
16:32:49 UTC 2023 x86_64 GNU/Linux

$ lscpu
12th Gen Intel(R) Core(TM) i7-1280P

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
