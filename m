Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED46C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 02:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F8060F4B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Oct 2021 02:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbhJ2CFU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Oct 2021 22:05:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhJ2CFT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Oct 2021 22:05:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1AA4661107
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Oct 2021 02:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635472972;
        bh=4gvIwBufdvvnxSr00XI/k5Ylmv+9i+VqrXsKt8ISObE=;
        h=From:To:Subject:Date:From;
        b=p1Xy5f+O9f4vFEI5bzv881Dr2tHOn/ORAowbMRwOhzdmRxnIZx800seFIhbKHVwxT
         mzgAA9oJCg1GVQJE4VdMiqA80P1zSRGNlhI+kS3zxlHcQ9mJbKEkFoBUy/69UuWzwq
         NkvsjHZso1XkKZaBbVq9kl+BpMtm7b25xqaubA2UpAKNsjbLOXHBBYK2X766EnGU/3
         taEpR2bL7UCXie48gG2/L5YHyGV83x+T0FmX3LbrUWo+vrn4pCqvc1qZMft59dUm0W
         8SsMnpToYstl+Jhfd1ASjgt/5YwpD7qsY3+gw+r75+PDhNTEdJr0Aou31AM4KX7g+t
         yS83DmlR1Koiw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214863] New: Intel AX200 "Bluetooth: hci0: failed to restart LE
 scan: status 31"
Date:   Fri, 29 Oct 2021 02:02:51 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kai.heng.feng@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-214863-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214863

            Bug ID: 214863
           Summary: Intel AX200 "Bluetooth: hci0: failed to restart LE
                    scan: status 31"
           Product: Drivers
           Version: 2.5
    Kernel Version: mainline, bluetooh-next
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: kai.heng.feng@canonical.com
        Regression: No

Device: AX200
Bus 001 Device 002: ID 8087:0029 Intel Corp.=20

Kernel: bluetooth-next
HEAD 2128939fe2e771645dd88e1938c27fdf96bd1cd0 ("Bluetooth: Fix removing adv
when processing cmd complete")

Reproduce step:
1) Open GNOME Settings' Bluetooh panel and let it continuously scan
2) Keep `rkfill block` and `rfkill unblock` loop.

Result:
Bluetooth stops working:
[   29.706981] Bluetooth: hci0: failed to restart LE scan: status 31

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
