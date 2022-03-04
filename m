Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2CD9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Mar 2022 09:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiCDJyA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Mar 2022 04:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbiCDJx6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Mar 2022 04:53:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FB642A0A
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 01:53:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FFD8B8272C
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 09:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2133C340E9
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Mar 2022 09:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646387587;
        bh=/VhmxPr1XG7TmDgLh1c+YWZrH2rjA2gxPOpxGkvPk14=;
        h=From:To:Subject:Date:From;
        b=vQC3UfP2gVfPF5ei77yRAxt+NPp2D5RelLkpGZa9qEZ+Vah7YxLBEwTFlBwbH3/kT
         FKcdPCYkfVPoLoU7SuiV1g+b4Eg8XPDLQpDOkftp9nyLna2lUV0Mu5JIilzPjH1xMW
         yecEfGnd2WF7Ti6kDdBcyUqa2AJNoa4JhBRW5TCib3nOyeS1AbcFG7/va9Qj6diWGt
         utRcnttC8YJc/0s2dhszSOlwA3+cCG98Oztb3xLV7iKYvl7LQJZtPzuQONarrYkTul
         rvm48L6DvAd7YJbjlpBcFM/58QAEahVCNItoDWJxjAYoZYp3JLbn1OpUgpUI6XZIjw
         KRReiwFn68eJQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9616FC05F98; Fri,  4 Mar 2022 09:53:07 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215659] New: "Unexpected continuation frame" spam in kernel log
Date:   Fri, 04 Mar 2022 09:53:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: smurf@smurf.noris.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-215659-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215659

            Bug ID: 215659
           Summary: "Unexpected continuation frame" spam in kernel log
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.17
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: smurf@smurf.noris.de
        Regression: No

My kernel log gets spammed by these messages:

M=C3=A4r 04 10:46:18 s-asi kernel: Bluetooth: Unexpected continuation frame=
 (len 0)
M=C3=A4r 04 10:46:18 s-asi kernel: Bluetooth: Unexpected continuation frame=
 (len 0)
M=C3=A4r 04 10:46:18 s-asi kernel: Bluetooth: Unexpected continuation frame=
 (len 0)
M=C3=A4r 04 10:46:19 s-asi kernel: Bluetooth: Unexpected continuation frame=
 (len 0)
M=C3=A4r 04 10:46:19 s-asi kernel: Bluetooth: Unexpected continuation frame=
 (len 0)
M=C3=A4r 04 10:46:19 s-asi kernel: Bluetooth: Unexpected continuation frame=
 (len 0)
M=C3=A4r 04 10:46:19 s-asi kernel: Bluetooth: Unexpected continuation frame=
 (len 0)
M=C3=A4r 04 10:46:19 s-asi kernel: Bluetooth: Unexpected continuation frame=
 (len 0)

Please skip when len=3D=3D0 and/or rate limit

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
