Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE08C32773
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Aug 2022 16:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354281AbiHSQ4x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354487AbiHSQzY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Aug 2022 12:55:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803794E62D
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 09:16:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED3B361639
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 16:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D66EC433C1
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 16:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660925730;
        bh=a+tjk8kcncF95d33LlVXribjD8hNgmGAgkg9Q9emIps=;
        h=From:To:Subject:Date:From;
        b=EnXrEIHWrTaw2PcWC93P/5/fFCROlRXKCCrJs5zrzaqL/RRmmMEpY9n249vvRfQGl
         YDCINbXLa3rKq0Y3E/abaV4BMG8Qt8aB38MgypubDO2e8/UCjtp4FXm8ww3lKCKKN1
         yMNF+z5DufbS3IJEllyfqEhrvZsTkiylobKJytKqFda8sm2UhmsnhLHBTM6DbWAVmC
         A0JOkYrH/lAXn8gNbCrinPpgBLAl5ECMvM+8RNp/ZGZ/fTFtggGOrnC0DiPdpi8W97
         9c/prgaoqADMggq74H5QVa4Z5yA6Gex+lrUM/PlkzPwKGqVPX9rNfa4DsZmkk58NqC
         Vb1EZqbRmhC+w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 417EFC433E6; Fri, 19 Aug 2022 16:15:30 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216382] New: [bisected][regression] mediatek bluetooth
 13d3:3563 (mt7921e) doesn't work with audio devices.
Date:   Fri, 19 Aug 2022 16:15:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arek.rusi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216382-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216382

            Bug ID: 216382
           Summary: [bisected][regression] mediatek bluetooth 13d3:3563
                    (mt7921e) doesn't work with audio devices.
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.0-rc1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: arek.rusi@gmail.com
        Regression: No

After update to new 6.0rc1 I can't use any bt-earphones.=20=20
I've checked in bluetoothctl: devices are still connected but none of
endpoint/transport entries are creates.

XB1S gamepad works without any issues.

bisecting result:
---
26afbd826ee326e63a334c37fd45e82e50a615ec is the first bad commit
commit 26afbd826ee326e63a334c37fd45e82e50a615ec
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Mon Jul 29 18:15:43 2019 +0300

    Bluetooth: Add initial implementation of CIS connections

    This adds the initial implementation of CIS connections and introduces
    the ISO packets/links.
---

can't revert this commit.=20

*Aditionally, I've tried this kernel on second machine with AX210 wifi/bt c=
ombo
and issue doesn't appear. So I assume problem is limited to mediatek module.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
