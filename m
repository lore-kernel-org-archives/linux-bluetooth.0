Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE53FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Apr 2022 20:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390612AbiDUUKI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Apr 2022 16:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiDUUKH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Apr 2022 16:10:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D324C78E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 13:07:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4806CB82911
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 20:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8883C385A1
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Apr 2022 20:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650571633;
        bh=RuUkErZC1dksMjguLynfXovNzesQRa9DH2FFdwsHf1M=;
        h=From:To:Subject:Date:From;
        b=dJ9U19aCO5uPlAAHmQ9eo+UAMob+svNrBPnLZnjOIqrrEhiRsiEBcfW2Mr+tua+55
         8TrVJDyAou/CZQkWZnt/y342l4akCywep3JkXnbM1PPsOe9fB59dhpLx7w6S1KhWqF
         csA2yGRyHb49ofih3tutvOtvyFwy7ojq4L/C4Qi/Gu8eC11NuxMXHHxxp2eH7mg5si
         Z3MUxzIJfbK3cSWW3cwQTK2nVMKudF8YANWDiqJIYtIqvhAGkL95n99AEcvm66EneE
         LuZTMV48kX1qqKKkgr5YP881WSJIVRh/70KNHye2Ya/Z+LywloJ3gcW0P8McV+vbdz
         fs2nNV45z8fSA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CBF5DC05FD0; Thu, 21 Apr 2022 20:07:13 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215872] New: ath11k: QCA6390 firmware crashes after some time
Date:   Thu, 21 Apr 2022 20:07:13 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mail@kai-mast.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-215872-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215872

            Bug ID: 215872
           Summary: ath11k: QCA6390 firmware crashes after some time
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.17.3-arch1-1
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: mail@kai-mast.de
        Regression: No

Created attachment 300786
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300786&action=3Dedit
dmesg | grep Bluetooth

I'm on arch Linux. For a while now (multiple kernel versions since 5.15 at
least) my qca firwmare seems to crash. Weirdly bluetooth stops working and =
WiFi
still works fine.
There is nothing in particular that seems to trigger this. I just have to w=
ait
for a while. Sometimes a few minutes after boot sometimes a few hours.=20

Rebooting without a power connection or booting into Windows usually resolv=
es
this issue.

I'm on a 2020 Dell XPS 9500. Fimrware is up to date at 1.13.

Output of uname -a: Linux kai-xps 5.17.3-arch1-1 #1 SMP PREEMPT Thu, 14 Apr
2022 01:18:36 +0000 x86_64 GNU/Linux

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
