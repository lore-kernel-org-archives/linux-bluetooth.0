Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9028C48BE8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 07:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9582161352
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 07:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhFNHx4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jun 2021 03:53:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232603AbhFNHxz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jun 2021 03:53:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 787B361352
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 07:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623657113;
        bh=Q1D6ATzJb/vtR9ZrZ8S3MaHIPz4ERNmM9GNU3w/MJrA=;
        h=From:To:Subject:Date:From;
        b=u2cf7xpkZNwEvxvMjvY6fAviLBjuZGZM2zdJAhRoO4o5j8p3xKrrBsz/CoC++aNPb
         PdmypXYui/tPr8aPL7CfiPj0WiHI5/zXeqWubOmhkjPRlRgP+tzgxiLgoJJkvs2nSs
         ZmqCAWF/dZKvD5vAx114JbjMBKEJ6UUsYHOQaaf9HdUcSXM6h7T4z9/Fq7UcFoNbUY
         424bWPEc1+qBnYf1UeamsTolRIzyXsNHJ8QdZ4xS57e+72mugoGQNQcywkLa7LjgAw
         XoIOw9+Gpoxyu3/x9HOBaFSUolCAyWu9kDrzbs8no82Qu9KQO7Uq4WPKfoW42FDM6L
         fpS8PWgYw5R0A==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213431] New: Xbox Series X/S Controller enters
 connect/disconnect loop when in pairing mode, doesn't connect at all after
 paired
Date:   Mon, 14 Jun 2021 07:51:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: saldorin@web.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-213431-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213431

            Bug ID: 213431
           Summary: Xbox Series X/S Controller enters connect/disconnect
                    loop when in pairing mode, doesn't connect at all
                    after paired
           Product: Drivers
           Version: 2.5
    Kernel Version: 5.13
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: saldorin@web.de
        Regression: No

i hope this is the right place for this bug report, the bluez website isn't=
 too
clear about that.

The new Microsoft Xbox-Controllers don't work properly, but enter a
connect/disconnect loop when in pairing mode after being paired. Regular
connect (outside pairing mode) doesn't work at all.

According to the dev of xpadneo this seems to be an issue with bluez.
See also: https://github.com/atar-axis/xpadneo/issues/295

There are several logs attached to that github issue, but let me know if i =
can
provide any other useful info!

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
