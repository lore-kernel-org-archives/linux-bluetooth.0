Return-Path: <SRS0=sr2f=PQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 066ADC43387
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 18:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A462070B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jan 2019 18:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbfAHSmh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:42:37 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:52870 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727484AbfAHSmg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jan 2019 13:42:36 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id D224828DA2
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jan 2019 18:42:35 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id C649F28DD5; Tue,  8 Jan 2019 18:42:35 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 199035] BCM2046B1 and hid2hci generates highcpu usage due to
 udev since 4.14 kernel
Date:   Tue, 08 Jan 2019 18:42:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: jgwphd@yahoo.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-199035-62941-xKgTsiTXNT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-199035-62941@https.bugzilla.kernel.org/>
References: <bug-199035-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=199035

John (jgwphd@yahoo.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jgwphd@yahoo.com

--- Comment #11 from John (jgwphd@yahoo.com) ---
When I boot up every day without exception, my machine starts up with one of
the CPU cores running at 100%. I see lots of posts on other forums (Unbuntu 
etc) going back over a year or more blaming touchpads or nvidia or WiFi. Some
even say they can't use their thumb drive if it isn't plugged in when they
boot. The problem also mimics a defective thumb drive where you plug it in and
Ubuntu doesn't see it (because systemd-udevd doesn't have the cycles to process
the newly plugged in USB device). Losing one core makes my machine slower but
not too noticeably so. I do see much longer boot times and sometime it will
hang entirely during boot. I assume a single core or dual core machine will be
drastically slowed down or even unusable. When I search I find other non-ubuntu
os's complaining about similar problems.

I have 18.10 running on my Dell studio XPS with an AMD® Phenom(tm) ii x4 945
processor × 4 and AMD® Juniper graphics. It's a quad-core 64 bit machine. I
have wireless mouse and keyboard for Logitech. I have a pretty vanilla set-up.
I DO NOT have a touchpad or nvidia or WiFi!

I can verify that the problem can be managed by stopping and starting
systemd-udevd. I used the following commands, suggested in this bug report, in
sequence in the terminal which corrects the problem until I boot again. 

sudo systemctl stop systemd-udevd systemd-udevd-kernel.socket
systemd-udevd-control.socket

sudo systemctl start systemd-udevd systemd-udevd-kernel.socket
systemd-udevd-control.socket

Also the problem will "sometimes" re-appear by plugging in a thumb drive! 

This is a serious kernel problem and can manifest its presence in a number of
ways depending on your hardware configuration. 

This is a very very very annoying problem will someone PLEASE fix it soon!
...did I mention that this is a serious problem impacting many people!

-- 
You are receiving this mail because:
You are the assignee for the bug.
