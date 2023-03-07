Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5DCC678DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 17:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbjCGRhr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 12:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjCGRhT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 12:37:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D645653D
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 09:33:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 389D161514
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 17:33:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A111CC4339E
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 17:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678210396;
        bh=jFubTMiH61Q3a0Fai5/1ShaRIBuZtSe3GxGja4GCAKw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JKonQab0PUXkiPBKNxi2YVkCOxzai2jJ8AaCAjHAO7hn97VRcFUzH994p1Ugosdih
         rMOMKxWN2eMMofowKjwbx/ibAVwU+5vFUtxnN1WytpESQzckI8iRdyXOPQxnno9ott
         EmvqeeKuyxN6vANy3nx/e3ZGr11FaLKTA35CjP5mC/yBWG4AoOHKE+alNXGikckQD/
         Unsdx5l1k0lSdcsYpIrZAw0u1m/d4bPHDg/VPZRL3JEpGEG7xK/NyC8CPcr6fPjj+J
         CA9HP/VnuZTlHcvGt+rakpi7sONbYmuzgiJv+QhfJhG5yeNXc5VvbuuQV1URTrS61K
         UmEstGA/jhnDg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 846BBC43141; Tue,  7 Mar 2023 17:33:16 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217150] Bluetooth USB Adapter that comes with Xbox One Wireless
 Controller stopped working on 6.3 rc1
Date:   Tue, 07 Mar 2023 17:33:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217150-62941-spfz8t1kdy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217150-62941@https.bugzilla.kernel.org/>
References: <bug-217150-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217150

--- Comment #6 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
Is that adapter maybe only supported through a out of tree driver.

I noticed this in the 6.2 dmesg:

usbcore: registered new interface driver xone-dongle
[=E2=80=A6]
xone-dongle 2-5:1.0: xone_mt76_evaluate_channels: channel=3D11, power=3D33
xone-dongle 2-5:1.0: xone_mt76_evaluate_channels: channel=3D149, power=3D40
xone-dongle 2-5:1.0: xone_mt76_evaluate_channels: channel=3D153, power=3D40
xone-dongle 2-5:1.0: xone_mt76_evaluate_channels: channel=3D157, power=3D40
xone-dongle 2-5:1.0: xone_mt76_evaluate_channels: channel=3D161, power=3D40
xone-dongle 2-5:1.0: xone_mt76_evaluate_channels: channel=3D165, power=3D40
xone-dongle 2-5:1.0: xone_mt76_evaluate_channels: channel=3D1, power=3D30
xone-dongle 2-5:1.0: xone_mt76_evaluate_channels: channel=3D36, power=3D43
xone-dongle 2-5:1.0: xone_mt76_evaluate_channels: channel=3D40, power=3D43
xone-dongle 2-5:1.0: xone_mt76_evaluate_channels: channel=3D44, power=3D43
xone-dongle 2-5:1.0: xone_mt76_evaluate_channels: channel=3D48, power=3D43
xone-dongle 2-5:1.0: xone_mt76_evaluate_channels: channel=3D6, power=3D32
xone-dongle 2-5:1.0: xone_mt76_init_address: address=3D6c:5d:3a:00:e5:76
xone-dongle 2-5:1.0: xone_mt76_init_channels: channel=3D165
xone-dongle 2-5:1.0: xone_mt76_init_radio: id=3D0x7613
xone-dongle 2-5:1.0: xone_mt76_send_firmware: build=3D201703281033____
xone_gip: loading out-of-tree module taints kernel.
xone_gip: module verification failed: signature and/or required key missing=
 -
tainting kernel

Then it's no wonder that it doesn't work in 6.3

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
