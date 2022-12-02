Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7703C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 06:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiLBGQJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Dec 2022 01:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiLBGQH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Dec 2022 01:16:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CB4A8969
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 22:16:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54336B8208C
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 06:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E91F3C433C1
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 06:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669961759;
        bh=wv72c+Eb66jxuQ/ZFgzKLCmT3Ly3x6c0+WtNv53Q5vA=;
        h=From:To:Subject:Date:From;
        b=dkPNDqiXT9l6BjL4FruQnZJXrOdUDhDr09xR/hFWgNLTxzjSeuD1DWW2MQzkwidAE
         iPikM66/uI9SKC30PmqoavNk7sZCRdMxJFvQ7uBLTh57mqeiBULsf1IVKbXka6Ydxu
         X/ELgpTAuMsoHo//ycKB+RS2deHdix+mMgoGuaDVTazlfYvS3JbLBT09MI9pT9V2nR
         4tFhzRlWtuigox40WtI6JDgxNCMaWBunRwUZnCDUdRlwytSHTTYOlmJGnOurBxOOy2
         V4w1tjxxDGmhEeqJL7E3xi/OQjtFAeDyZ7Lvnf0sP3P7Awr4z6fB8EXlLA5FxQJ0sq
         dcGR7tyi8XfIg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id BD48BC433E6; Fri,  2 Dec 2022 06:15:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216764] New: WCN6855 bluetooth USB completely unable to detect
 on some devices
Date:   Fri, 02 Dec 2022 06:15:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: wiagn233@outlook.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216764-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216764

            Bug ID: 216764
           Summary: WCN6855 bluetooth USB completely unable to detect on
                    some devices
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.10.115;6.0.1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: wiagn233@outlook.com
        Regression: No

I'm using a QCNFA765(WCN6855) wlan+bt combo card on my arm SBCs. However so=
me
devices completely unable to detect its Bluetooth USB device. I've tested i=
t on
radxa's Rock 3A and Rock 5B and beaglebone ai-64. USB only detected on Rock=
 3a
at any kernel version(both downstream and upstream kernel detects). Other t=
wo
devices cannot detect it at all. lsusb doesn't report anything about this c=
ard,
dmesg reports no warning/error about usb.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
