Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A86DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 12:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241419AbiCNMWj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243931AbiCNMVY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Mar 2022 08:21:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A758813CF4
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 05:18:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5D131B80DF9
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 12:18:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 150BDC34100
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Mar 2022 12:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647260319;
        bh=X7qdRJBZSRbPWQPw8uJO/fo75Jt+qGjYrOgsuhJ3MoQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gmP45vOIWm/2oiL3W8LyN1TxDm7xEbvAfx8yr9XiHBkKRftt/w2sMnVlzgruneOuw
         sS3lGRxh6r4/ZHlrqOSj2ruIXxfmSmUl7xh2JCgcW+NQAyBHrJNcTmvn1NHSA+IUBl
         7PARFsYJ7Mqkwtkk86QGNGIBE6Fr4MpaOxuiURQLzpOZP2GH0mlLSXFPFo68whJK7z
         k3woRR9eegbvr7vMpLjIdPXHAg+YrW2YkZVHmAxy9B6oZC7+OyFZEuDNEORE1h6Q2b
         W0HCsqvX/P0g340otowehYA/MRAh4/Mf8xRYf4/iUmx9COCeWL+MhmLSldFofMWr36
         MvNNAJTIUdGCA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id EFE7FC05F98; Mon, 14 Mar 2022 12:18:38 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Mon, 14 Mar 2022 12:18:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
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
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215167-62941-O6im1WDAH0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #29 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de=
) ---
@Ievgen, thank you for the report. Is the non-working Bluetooth a regression
too or just the messages? There were some Bluetooth regressions in Linux 5.=
16
cycle, some them only fixed in Linux 5.17-rc7. Could you please test with t=
hat
first?

If not, please create a new issue, and reference it here. For the new issue,
please do `sudo modprobe -r btusb` and `sudo btmon -w /dev/shm/trace.log` a=
nd
attach the logs.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
