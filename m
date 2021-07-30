Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24917C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jul 2021 05:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE48160F9B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jul 2021 05:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236235AbhG3Fhz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jul 2021 01:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:34948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233861AbhG3Fhy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jul 2021 01:37:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A9E3A60F48
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jul 2021 05:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627623470;
        bh=rtYERMhRerrMRPSPbjVrf380v/O7/3evdWqzcoagcZQ=;
        h=From:To:Subject:Date:From;
        b=RQJovCd4pNqdNBz7VBNJ0oOL199Lh6Rur+DKfuSB61HGK117/rAUyKyteDddE0zMy
         3UeouNYR8EYbfPOrcZP3vZ859D6aeiEbbSZkPNETK0H9jKedTc7ASJRwRuG7HssoWL
         DikuSiXmKR60ulwg7NEVUWf2RyIKAB2il1ImWBR84zVbwqpXFLydsNua6qS78pPHLk
         GMHQq8NGno6C7uY/NTXkXg0Sa2WpYut7Q8osSX73jSvXMSUbfMnEI9Rd13glKy51xz
         im1zn6thXH8tqu1+1au38I6n4tKqA4Qgvpujo8gH/E+hXApkFn8iDvcnVmbfSLONc2
         wheQBnPfHyGyA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213923] New: Bluetooth: AC9560 doesn't respond any more after
 suspend multiple times
Date:   Fri, 30 Jul 2021 05:37:50 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: koba.ko@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-213923-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213923

            Bug ID: 213923
           Summary: Bluetooth: AC9560 doesn't respond any more after
                    suspend multiple times
           Product: Drivers
           Version: 2.5
    Kernel Version: v5.14-rc3
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: koba.ko@canonical.com
        Regression: No

Created attachment 298119
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D298119&action=3Dedit
lsusb

1. Turn BT off.
2. suspend(deep) and resume 10times.
3. can't open BT again
#[failed]rfkill unblock bluetooth
#[failed]sudo hciconfig hci0 up.
4. status of hci is always down.
#sudo hciconfig -a

Once issue appeare, get these errors
[ 877.194032] Bluetooth: hci0: urb 0000000061b9a002 failed to resubmit (113)
[ 886.941327] Bluetooth: hci0: Failed to read MSFT supported features (-110)

it's related to mstf feature.
1. Remove MSTF from configuration, issue wouldn't be triggered.
2. revert this patch, issue wouldn't be observed.
4a37682c6b59c8888acf93117362d761c5923a69 Bluetooth: advmon offload MSFT han=
dle

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
