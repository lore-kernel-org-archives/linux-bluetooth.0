Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB731C001DF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 22 Oct 2023 10:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjJVKJi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 22 Oct 2023 06:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJVKJh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 22 Oct 2023 06:09:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B408AEE
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Oct 2023 03:09:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FAD8C433C7
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Oct 2023 10:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697969375;
        bh=QCMX7kL3w0TdJyl8nlGjH0SJrNoo6zUdCFGsWBnStM8=;
        h=From:To:Subject:Date:From;
        b=XaMBtFZ5y9wNToqZ71//tgI1HDr2vEdkPvnDmaXEE5xD0xQmtRp7ZL+dUEM0oeJtA
         5i4AqukiPK9VrLmI+6WzOPWiykLpeEgf048DasQO0lf+dll0RzdzFQgorXQVPX7X9S
         o2nYYwWTDe9QsqdD83LHKwLf71YqJwmlcsyyaJ06exfDR/8kqjsPiDSWZmy4FxDrHf
         zeY0Xg7JuGS2IxIy5X6aZEZBIeuNZggyXnIrYcxw7mY9HQbPiwhfrfyqjPIJzmkvql
         SD9MNo6pzHbiOxk9yBN0TmYQoaC1TinSptu4qbMNdCOjbWY+hdYKTKi1cI9HTZXQrb
         FizNjLyGVsPFg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 24C79C4332E; Sun, 22 Oct 2023 10:09:35 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 218034] New: PC connection to smartphone, "telephone"
 connection failure
Date:   Sun, 22 Oct 2023 10:09:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: epistemepromeneur@free.fr
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218034-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218034

            Bug ID: 218034
           Summary: PC connection to smartphone, "telephone" connection
                    failure
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: epistemepromeneur@free.fr
        Regression: No

Operating System: openSUSE Tumbleweed 20231020
KDE Plasma Version: 5.27.8
KDE Frameworks Version: 5.111.0
Qt Version: 5.15.11
Kernel Version: 6.5.6-1-default (64-bit)

first step

I try to connect the PC to the Bluetooth network of the phone (PAN) via
networkmanager plasmoid.
Result : failure because the Pan is not enabled at the phone

second step

I try to connect to the Bluetooth "telephone" and "audio" protocol via
bluedevil plasmoid
result : success !

If we don't do the first step, the second step fails.

Is there something missing in the Bluetooth dialog for connecting to the
"telephone" and "audio" protocol ?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
