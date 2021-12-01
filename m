Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44041C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 11:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348855AbhLALKC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 06:10:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55050 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhLALKC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 06:10:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D563DB81E06
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 11:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7AB4EC53FCE
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 11:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638356799;
        bh=MlqPTFNXFqWAX+a958JbMIYAE64eUZnc9Z0RneHCe38=;
        h=From:To:Subject:Date:From;
        b=kCJvAI5ZQvLUgQio1q1LS3mOEPTuSXfSdtDT7BqTQXTNvrZMn62OoFPkl4zlMsUWD
         N1FcsyOsoNRioSfF/9oKrmRvxen7/OEOk5HlQC88ZnX3NB3JzTkaDXuzu7AUZ9sDfP
         gMwNDwji0K4e4P/C328LKjcEXGMtmAUkVrLwv5w6ch1ltQJztX39z9DoNPnj/KQwMA
         uhJllxojJOllzvsCZ0jXPGoiX79+79yM9HBTwNBHaWAbjzAfQGlf1Xbj3GMf8JJ8TP
         1AbNd38i2MIZcyZpVBP+V3IgWzJBbDz9k7Bh5tt3U3i3o+LdU6skwjqZ4r+NiYUmmc
         JCO0oU3nVJpKw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 58EC760F00; Wed,  1 Dec 2021 11:06:39 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215187] New: btintel: AX201: missing firmware ibt-19-16-0.sfi
Date:   Wed, 01 Dec 2021 11:06:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: nozzy123nozzy@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215187-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215187

            Bug ID: 215187
           Summary: btintel: AX201: missing firmware ibt-19-16-0.sfi
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.16-rc3
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: nozzy123nozzy@gmail.com
        Regression: No

I was testing Linux-5.16-rc3 on my laptop with "Intel Corp AX201 Bluetooth".
After boot, I found the strange error message shown below.
---------------here----------
kernel: Bluetooth hci0: firmware: failed to load intel/ibt-19-16-0.sfi (-2)
---------------here----------
 After I checked
git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git, I found
the "ibt-19-16-0.sfi" was missing. Strangely the Bluetooth service of this
kernel appeared to work fine, at least against my bt headphone, without this
firmware.

 When I booted Linux-5.15.5 on the same laptop, I found the "ibt-19-0-4.sfi"
was loaded.=20

 This strange message is similar to the report
https://lore.kernel.org/linux-bluetooth/81eddb07-f346-c12a-345b-d929fd2edb1=
0@googlemail.com/
but the linux/drivers/Bluetooth/btintel.c of 5.16-rc3 has already implement=
ed
the checker by "btintel_test_flag(hdev, INTEL_BOOTLOADER)".=20

Does it show some bug? I would be grateful if someone could answer.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
