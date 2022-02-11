Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81194C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Feb 2022 16:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349785AbiBKQDq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Feb 2022 11:03:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238240AbiBKQDp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Feb 2022 11:03:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A61421F
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 08:03:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBCFF60B8A
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 16:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A666C340EB
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Feb 2022 16:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644595423;
        bh=aEYFuZ1AtzxrQmOz4lxmc3CZTz5uMwmidTwgW91U3pM=;
        h=From:To:Subject:Date:From;
        b=i0HxK23h7Et3qbxwg6sfP/s57LO+WN4/7rcIeH70rvYQ1ORG65OUReZGL7kVR5S25
         QATXQ/Nb2MXqPpBOdOiCx9O/3BTyk6uLO2LTPgQttBciyM88qomV+HaCIfljmJRM11
         Qsd2SRKfGhg8qivbM1HCAM0S0s4aFs7z6tWjyHofvM6GO5GNFZX3pTyFxIWfRmJUMn
         XjO4ZJiRaU4hCh4RYTg/UguCFDAC+i0wdgL2Pm+6QGEUWVuKdoaJok17VoMZzJmTQK
         S2bP/f5mAz4lpbc9/2E3vGejyC6zqpCie+y4IbGcBjDkhBYyEBk3za+F2rvpPqctGs
         vBvN4l8aUYNiA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0C3C9C05FE2; Fri, 11 Feb 2022 16:03:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215594] New: Unable to transfer big files to Nokia N9 and Jolla
 phone
Date:   Fri, 11 Feb 2022 16:03:42 +0000
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
Message-ID: <bug-215594-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215594

            Bug ID: 215594
           Summary: Unable to transfer big files to Nokia N9 and Jolla
                    phone
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.16-rc1
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

Created attachment 300440
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300440&action=3Dedit
Output of `btmon --write /dev/shm/btmon-trace.log`

Report:
https://lore.kernel.org/linux-bluetooth/def03073-3fab-3b34-6ffc-702bb1b3758=
f@leemhuis.info/T/#m04445e920610d42a9510d0f6d97afa5376e4a3ca

Created Bugzilla issue to upload log files.

Unfortunately, I do not know, how to capture `obexd` logs. `obexd -d` did n=
ot
print any messages to the terminal. `obexctl --monitor` also did not get it
more verbose.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
