Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA461C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 10:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356564AbiAYKhi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 05:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343576AbiAYKfL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 05:35:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60684C061774
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 02:35:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F21576166A
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 10:35:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61F23C340E8
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 10:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643106910;
        bh=XjT7Rua3TQcvhfLZPl/gXxgP2vEH+6Myzg0jeiv4cDM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=fDYoDJTYnvEcKVoD64qmxBpH75/WHk6E0UY1b5AiYw7NIwU+XdaLViUgwz60q1kJ0
         QqHAsN2L4ehXAm9tWY9Msr0JNDINrQLQb1+ki+bsilv9MAdXQCMDW4TDVGEC/sXoJJ
         DZSu0zLipiwhEUiXhCCUBLF/YDo5Fh/ta8+heSNBjtDEzMSUU1W3+Qdx9z28dNFt3A
         NZuxPi5tdplQMfc95oU9SPRx1uAkM+hVAhCqQgxkfksMrhJVYEvKqP5rOQlY4QXvIF
         y+diMpAyCg7Rd/1bOkRDO+E4YDqtjD772RwDu/i/CRlx0xm8LNHpMF+s2cV3fs8KCd
         JLavWEVQVSivQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4CBC4CC13B0; Tue, 25 Jan 2022 10:35:10 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215528] Excessive logging from Intel Bluetooth "Bluetooth:
 hci0: sending frame failed" "hci0: urb 00000000xxxxxxxx submission failed
 (90)"
Date:   Tue, 25 Jan 2022 10:35:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215528-62941-HlpYTF0JDJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215528-62941@https.bugzilla.kernel.org/>
References: <bug-215528-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215528

--- Comment #6 from Artem S. Tashkinov (aros@gmx.com) ---
Looks like I have to reboot, now I get hundreds of messages like this:

Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 48
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 48
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 48
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 0
Bluetooth: hci0: SCO packet for unknown connection handle 257
Bluetooth: hci0: SCO packet for unknown connection handle 257
Bluetooth: hci0: SCO packet for unknown connection handle 257

I'm kinda appalled by how logging in the BT module is handled. Has it ever
occurred to anyone that there's no need to dump hundreds of nearly exactly =
the
same messages?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
