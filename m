Return-Path: <SRS0=otBP=MV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2B4C64EB8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Oct 2018 12:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA07214C5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Oct 2018 12:35:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA07214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbeJITv6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 9 Oct 2018 15:51:58 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:35868 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726393AbeJITv6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 9 Oct 2018 15:51:58 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 718D628BB4
        for <linux-bluetooth@vger.kernel.org>; Tue,  9 Oct 2018 12:35:13 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 6464528BD7; Tue,  9 Oct 2018 12:35:13 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 201361] New: BT mouse getting reset during operation
Date:   Tue, 09 Oct 2018 12:35:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: caravena@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-201361-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=201361

            Bug ID: 201361
           Summary: BT mouse getting reset during operation
           Product: Drivers
           Version: 2.5
    Kernel Version: Ubuntu 4.18.0-7.8-generic 4.18.5
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: caravena@gmail.com
        Regression: No

Hello,

Open bug in launchpad.net
https://bugs.launchpad.net/bugs/1796553

"(note: It's unclear to me if that's a kernel regression or an issue with
bluez)

I've been using this particular combination of Bluetooth mouse ("TECKNET
BM306") & laptop ("Dell Latitude E7240") for over a year now.

It used to work with 18.04 and 17.10, but with 18.10 I'm encountering a strange
disconnect behaviour:

1) Mouse is working ok
2) Mouse suddenly stops
3) Disabling and enabling bluetooth on the laptop makes the mouse work again."

Best regards,
--
Cristian Aravena Romero (caravena)

-- 
You are receiving this mail because:
You are the assignee for the bug.
