Return-Path: <SRS0=s7/i=P2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6D1C43387
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 06:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E6020855
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Jan 2019 06:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfARGbQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Jan 2019 01:31:16 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:44420 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726962AbfARGbQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Jan 2019 01:31:16 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 9B6C52EB7F
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Jan 2019 06:31:15 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 8FF882EB80; Fri, 18 Jan 2019 06:31:15 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 198699] Kernel regularly logs: Bluetooth: hci0: last event is
 not cmd complete (0x0f)
Date:   Fri, 18 Jan 2019 06:31:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ishank005@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-198699-62941-tDspEFoB5x@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198699-62941@https.bugzilla.kernel.org/>
References: <bug-198699-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=198699

Ishan Kulkarni (ishank005@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ishank005@gmail.com

--- Comment #23 from Ishan Kulkarni (ishank005@gmail.com) ---
Observing the issue on Fedora 29 Cinnamon. I have Lenovo T440P laptop on which
I am trying to connect my Bluetooth headsets (Sony MDR-XB650BT).

The Bluetooth is failing to even detect the headsets. At the same time, it can
detect my smart bands, mobile phones, other laptops etc. The same headphones
connect correctly on my Windows laptop.

In dmesg, I can see the messages as :

[717817.195781] Bluetooth: hci0: read Intel version: 3707100180012d0d00
[717817.198527] Bluetooth: hci0: Intel Bluetooth firmware file:
intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
[717817.394926] Bluetooth: hci0: Intel firmware patch completed and activated
[717818.100820] Bluetooth: hci0: last event is not cmd complete (0x0f)
[717849.196840] Bluetooth: hci0: last event is not cmd complete (0x0f)
[717906.393910] Bluetooth: hci0: last event is not cmd complete (0x0f)
[717922.201017] Bluetooth: hci0: last event is not cmd complete (0x0f)

-- 
You are receiving this mail because:
You are the assignee for the bug.
