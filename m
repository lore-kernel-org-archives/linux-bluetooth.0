Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 617B5C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sun, 13 Nov 2022 07:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiKMHaA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Nov 2022 02:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMH37 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Nov 2022 02:29:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942EA10551
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Nov 2022 23:29:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5086CB80B24
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 07:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2D2CC433C1
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Nov 2022 07:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668324595;
        bh=A9goO0IKOsQrB5bRM9fHJoOXgR/Ydh5yDRhJERK1hK8=;
        h=From:To:Subject:Date:From;
        b=NuQDZDSOSMai2zZAM8c3heOozoY564mhwB0XVKm3dsjd4CYqjsu7L79qQrfQZrmpx
         eTNVpn8WCIQcDsEWHpKZwp+jQgVzjOrbZNUrvi6re0FtsYVDOxrDNJR+oraDaF/TCC
         rCBz5r1wkZlPn/L7Xrv5JZ+JlZN1CWxUt9ObKfE2ggkKNf8VMRyd5qXPWg+Cgt3cPP
         ADhUdpXvOZuw2wNyAfeqt02EINJiHmYedcS5EJ8p63lIkpDg8aluIBDqs2vzXMvriL
         Y+rT7VZCwLT2IT3WFR4J1EFxQf9QxgWvsnZ4jDbJxyQ8Ijmo9xd8g2IOidVVvv+crm
         ZALGqiTipkK3A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id B68C9C433E4; Sun, 13 Nov 2022 07:29:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216686] New: BUG: kernel NULL pointer dereference, address:
 0000000000000680
Date:   Sun, 13 Nov 2022 07:29:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: frc.gabriel@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-216686-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216686

            Bug ID: 216686
           Summary: BUG: kernel NULL pointer dereference, address:
                    0000000000000680
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.0.0, 6.0.3, 6.0.8, 6.1-rc3
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: frc.gabriel@gmail.com
        Regression: Yes

Hi, good morning,

I noticed few bluetooth crashes starting with kernel 6.0.0 release.

With 5.19.x I didn't see this oops and bluetooth works ok.

Kernel oops comes pretty randomly and/or takes some time to occur.

I noticed it happens more frequently when returning from suspend or when tr=
ying
to reconnect an already paired earphone headset.

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1021905 (kernel=3D6.0.0,
firmware-linux=3D20210818, bios=3D1.19)
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1023076 (kernel=3D6.0.3,
firmware-linux=3D20221012, bios=3D1.19)

This kernel oops is also appearing with 6.0.8 and 6.1-rc3 from debian
experimental + firmware-linux=3D20221012 and lenovo bios=3D1.21.

Have a nice day,
Gabriel Francisco

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
