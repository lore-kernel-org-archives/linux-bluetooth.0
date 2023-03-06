Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CF1C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Mar 2023 19:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjCFTj6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Mar 2023 14:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjCFTj5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Mar 2023 14:39:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4FC37B50
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 11:39:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62AAC61122
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 19:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBE09C433D2
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Mar 2023 19:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678131593;
        bh=m+rAHGPaCEIjg0+88JNTWdzVJonbSgP8trzaVOjud8w=;
        h=From:To:Subject:Date:From;
        b=DMttKcLiDZ/RWaJRMf9llgBG6rTxDqzCGKRVP34C2q3QQftmkffOkd6l5O5Wiv+CJ
         9GYBPG24y2dU5n0WbsmeUomiHSfGm8btlMtZy18nFQASgzTVaBc0lhK46cjlqpqqtv
         4GJjDz81sDAJ6fUQ2ZvZ36A+vWOqvI57eT19tK1cHVowJ1w3RpzIDj3tkN32O/Ji4l
         nsJA16tmPkKDiQpHxK03waa3VF9nSR0A8HOixbCF7z9itzY6jLkvlYFuUzlqVIjT9Y
         P00NXBAJNhdbHd3nCFPCf03USOFiFAgFkwjEihpE4HeKpXXXoyqrG8qWrM1XnzqkNN
         6iR+kbDPUP82A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9EF5BC43142; Mon,  6 Mar 2023 19:39:53 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217150] New: Bluetooth USB Adapter that comes with Xbox One
 Wireless Controller stopped working on 6.3 rc1
Date:   Mon, 06 Mar 2023 19:39:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: cmarobnjak@cock.email
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression attachments.created
Message-ID: <bug-217150-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217150

            Bug ID: 217150
           Summary: Bluetooth USB Adapter that comes with Xbox One
                    Wireless Controller stopped working on 6.3 rc1
           Product: Drivers
           Version: 2.5
    Kernel Version: 6.3 rc1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: cmarobnjak@cock.email
        Regression: No

Created attachment 303885
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303885&action=3Dedit
6.3 rc1 output of sudo journalctl -p err -b 0

Bluetooth USB Adapter that comes with Xbox One Wireless Controller stopped
working on 6.3 rc1.

It has worked and still works on 6.2.2 stable.

I have tested it multiple times, and every time the outcome was the same:

6.3 rc1 --> USB adapter doesn't work (it doesn't flash -> pairing with the
controller not possible).

6.2.2 --> USB adapter works (it flashes -> pairing with the controller poss=
ible
and successful).

I've attached the output of "sudo journalctl -p err -b 0" command in the
report.
The log is exactly the same on 6.2.2 and 6.3 rc1.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
