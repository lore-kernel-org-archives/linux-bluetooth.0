Return-Path: <SRS0=Lkqy=OU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7715C6783B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Dec 2018 23:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30732086D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Dec 2018 23:24:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30732086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeLKXYd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:24:33 -0500
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:37270 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726243AbeLKXYc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Dec 2018 18:24:32 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 36D732B62B
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Dec 2018 23:24:31 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 29CDB2B62D; Tue, 11 Dec 2018 23:24:31 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 199873] Bluetooth 3.0 mouses are automatically disconnected
 after connected
Date:   Tue, 11 Dec 2018 23:24:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jswxxuyuan@163.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-199873-62941-PAQPX2U9AJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-199873-62941@https.bugzilla.kernel.org/>
References: <bug-199873-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=199873

jswxxuyuan@163.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jswxxuyuan@163.com

--- Comment #3 from jswxxuyuan@163.com ---
I can also reproduce this bug.

Notebook: Dell XPS 13 (9370)
Wi-Fi/BT module: not sure...
bluez: 5.50
BT mouse: logitech M336 (M337)

Log:
[bluetooth]# paired-devices 
Device 34:88:5D:92:FC:0C Bluetooth Mouse M336/M337/M535
// try to connect the mouse
[bluetooth]# connect 34:88:5D:92:FC:0C
Attempting to connect to 34:88:5D:92:FC:0C
Failed to connect: org.bluez.Error.Failed
// try to connect in discovery mode
[bluetooth]# connect 34:88:5D:92:FC:0C
Attempting to connect to 34:88:5D:92:FC:0C
[CHG] Device 34:88:5D:92:FC:0C Connected: yes
[CHG] Device 34:88:5D:92:FC:0C ServicesResolved: yes
Failed to connect: org.bluez.Error.NotAvailable
[CHG] Device 34:88:5D:92:FC:0C ServicesResolved: no
[CHG] Device 34:88:5D:92:FC:0C Connected: no
// moving around the mouse
[CHG] Device 34:88:5D:92:FC:0C Connected: yes
[CHG] Device 34:88:5D:92:FC:0C Connected: no
[CHG] Device 34:88:5D:92:FC:0C Connected: yes
[CHG] Device 34:88:5D:92:FC:0C Connected: no
[CHG] Device 34:88:5D:92:FC:0C Connected: yes
[CHG] Device 34:88:5D:92:FC:0C Connected: no

-- 
You are receiving this mail because:
You are the assignee for the bug.
