Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A368EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Feb 2022 18:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233245AbiBGSHt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Feb 2022 13:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbiBGSAl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Feb 2022 13:00:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BA6C0401DA
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Feb 2022 10:00:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2A05612BB
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Feb 2022 18:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55B55C004E1
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Feb 2022 18:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644256840;
        bh=0Ss1BNfauPr366zXyrGRZhJTMvSOkeRQ00I26dQsLZ8=;
        h=From:To:Subject:Date:From;
        b=qbRhg8ur2XgoP1d0byZQqNwhN9h9i0MzOIXXOfYwjaPr/9BpUp+dGHeIg+89Z49AX
         nyHgAvSD0h+HLWMpwKe9QFxG3x1JajRv1SQpY5P1nFHyRB/J/YcsBzd089l5sD1QCj
         23N7scA9LfzROB8TFmUEHQkw4oGc2P6LRa3ySt1FOV/jAU43fNLHUDrXcmsV9BkL2w
         iRNkRKO98C5ko8f4OWn1tyXLlsU4QS2Nz93T4UQZUeixkk0ZehJeEqCMBXyAlVdyuU
         WWxTva7r+O3vQkr7VK8qZu8uoGF98lcYK1R22SNVf8BjMdDUkvAOmHueKjR18/OJRS
         D8eu9SYJrXETQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3A9F2C05FD2; Mon,  7 Feb 2022 18:00:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] New: HSP/HFP mSBC profile broken with QCA6174
Date:   Mon, 07 Feb 2022 18:00:39 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: mike@mjones.io
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

            Bug ID: 215576
           Summary: HSP/HFP mSBC profile broken with QCA6174
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.16.7
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: mike@mjones.io
        Regression: No

Created attachment 300405
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300405&action=3Dedit
dmesg with 5.16.7

Between v5.15 and v5.16, mSBC via pipewire stopped working with the QCA6174
adapter.

Switching to the HSP/HFP profile with mSBC codec in pipewire produces a loud
buzzing sound, and the microphone does not function. When using PulseAudio
instead of pipewire, the buzzing is absent but audio input/output also don't
work.

Other users are reporting the same issue at [1].

I ran a git bisect between these two versions and the issue seems to have b=
een
caused by this commit:

[b2af264ad3af437238c9500aa830ebcafb180e05] Bluetooth: Add support for
HCI_Enhanced_Setup_Synchronous_Connection command

[1] https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/2019

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
