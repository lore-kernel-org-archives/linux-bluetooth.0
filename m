Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0D0C4167B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Dec 2022 22:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiLXWCG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Dec 2022 17:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiLXWCD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Dec 2022 17:02:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BC26576
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Dec 2022 14:02:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45CCDB802C0
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Dec 2022 22:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D04F2C433F1
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Dec 2022 22:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671919319;
        bh=mSeLNPRYVpoIMw22kwIbTJGJDX9oNn4qCA+ALffZjcA=;
        h=From:To:Subject:Date:From;
        b=qBj6LObXFeHA5buZBeaYmHlsCjF2DcPSVKnkCVs2/cEjBFaGNYctlvJXH1PcWi9U9
         bAsbUoJdEFF3tjI3TnpOVOy9YyiZ/fBbw3Zw40yZ1/6Qseke3lI9bWEyGVlPAtBDyA
         cKQjpSW1+k3XVrU9SXOnfZj/HUWlRi5kkt+bEiIiqDIkQnYOqINXA7TRY/+PEcZv1q
         olqqO9CGhDhn7qfWfSlkWjPMq3fs+FkG0qX/40wwLyu2WsL2BWbPdC8amZ3xvigHDl
         WBwlgvCFsTnLlV5VE+d4Mb9a3KElBsS6HgIH0ogmV1Lv3IQooGYs5Q2VkwpQEUVCml
         et3Rd/KrYHICg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B83C6C43143; Sat, 24 Dec 2022 22:01:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216845] New: JBL GO 2 only recognized after restarting
 `bluetoothd`
Date:   Sat, 24 Dec 2022 22:01:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-216845-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216845

            Bug ID: 216845
           Summary: JBL GO 2 only recognized after restarting `bluetoothd`
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.1-rc8
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: pmenzel+bugzilla.kernel.org@molgen.mpg.de
        Regression: No

Created attachment 303469
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303469&action=3Dedit
`sudo btmon -w /dev/shm/linux-6.1-rc8-btmon.txt`

Using Debian sid/unstable with Linux 6.1-rc8, *bluez* 5.66-1 and
gnome-control-center *1:43.1-2*, going into the Bluetooth section of
*gnome-control-center* and starting bluetoothd with `sudo systemctl start
bluetooth.service` the *JBL GO 2* is not shown (pairing mode is activated).
Only stopping bluetooth and starting it again, it=E2=80=99s showing up. Ple=
ase find the
btmon trace attached.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
