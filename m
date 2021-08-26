Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1C7C432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 12:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD2561073
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Aug 2021 12:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241415AbhHZM0t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Aug 2021 08:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234453AbhHZM0k (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Aug 2021 08:26:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A7D5961052
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Aug 2021 12:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629980753;
        bh=pvH+p0g8A9ZmmGTUW6lBxmzSSqFgefJJs1ki1uU7FWQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Pm7geIgc4wsBV7Ac48kvAYM+YFnZypitI5SlFRndheWPF7W/RS0cjK1lP6/yVvWUE
         Rrx8EAI/UTGQ7z5gB6W62NkLJvVB7TfCAMm5n9Ka4JfJUKKW3pG7vPD0wGxZ3rK8DB
         4uofpGNfp4sq4NpbdLgCE9WCnIjANJaQhrOTb4JJ+V3Z2ukiusC8U64N3bTCM+keUI
         dxuFqhi9Jw0pN7j1D1rBsLNTpxHclbxeBOZVYmljZBnFuyWnK1AL2hPh/1YWFpXLxS
         gdPpClMOkDtRqGvmRhEYH47gWayI3XMckSwyucwDAKYa5RGKzSzO6S+14ItF9bqUpd
         lJ+geuMfLeI5Q==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214111] rtl8761b usb bluetooth doesn't work following reboot
 until unplug/replug
Date:   Thu, 26 Aug 2021 12:25:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: rodomar705@protonmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214111-62941-UDdeBQG0fJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214111-62941@https.bugzilla.kernel.org/>
References: <bug-214111-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214111

--- Comment #2 from Marco (rodomar705@protonmail.com) ---
Forgot to upload logs, sorry. This are my previous logs, that are full of
random tx trasmission issues, like:

aug 25 09:54:51 Desktop kernel: Bluetooth: hci0: command 0x0c24 tx timeout
aug 25 09:54:54 Desktop kernel: Bluetooth: hci0: command 0x0c52 tx timeout
aug 25 19:45:17 Desktop kernel: Bluetooth: hci0: command 0x0c24 tx timeout
aug 25 20:10:59 Desktop kernel: Bluetooth: hci0: command 0x0c03 tx timeout

aug 24 21:26:58 Desktop kernel: Bluetooth: hci0: command 0x0405 tx timeout
aug 24 21:27:00 Desktop kernel: Bluetooth: hci0: command 0x0c03 tx timeout
aug 24 21:27:08 Desktop kernel: Bluetooth: hci0: HCI reset during shutdown
failed
aug 24 21:27:26 Desktop kernel: Bluetooth: hci0: command 0x0405 tx timeout
aug 24 22:18:46 Desktop kernel: Bluetooth: hci0: command 0x0c1a tx timeout

aug 24 14:08:01 Desktop kernel: Bluetooth: hci0: command 0x0c24 tx timeout
aug 24 14:08:03 Desktop kernel: Bluetooth: hci0: command 0x0c52 tx timeout

The HCI reset failed are triggered when I would try to disable and reenable=
 the
adapter from KDE desktop, but to no avail before. Now it works perfectly fi=
ne
and I've no errors anywhere in the dmesg log, I'll also post it.

All the kernel logs are filtered with grep Bluetooth.

Hope to see this issue fixed soon,

Marco.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
