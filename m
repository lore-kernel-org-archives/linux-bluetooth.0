Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42CEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Dec 2021 00:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhLRACg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Dec 2021 19:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhLRACf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Dec 2021 19:02:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F57C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Dec 2021 16:02:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 520B960C7F
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Dec 2021 00:02:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC411C36AE8
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Dec 2021 00:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639785754;
        bh=lhIbubYtKEEEbg1xofU3dW2EiAj7TLuy9j9EGRsQvkc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aIbOE7gN++Crt1lGlIVWUCTZOCTbEFjKpTyX1541dDfsClrPsHIVQr//9ttB3IL9u
         qCPdvgAcVGaF1A35nFy0IAtFT77p+K0mgsYg84TLbPnfVfs+kS+OkvVLpRdjIqHSVn
         gZkEba96LBb4qtQUPJx29U6HiKSEdRw8w2Nq2eiPmjpgHIqO2zcpSeAJ1XXcvBF8CJ
         Sl3k+XoJo6C7wH5gRn+krt37wJk8IlkpTew/TFfXr+8LCjzLvyV8snI958mvzMji9c
         TKTaZByqpIvCpNME8DtiSR5CyzhB1+7WJgfCntFMhZr6L6jWU1C1kLnIA/npuXkOno
         vzSxcL0tFvEfw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 7D69660F54; Sat, 18 Dec 2021 00:02:34 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215347] btintel: AX200 (8087:0029): hci crashes and can't
 recover after repeated rfkill on/off
Date:   Sat, 18 Dec 2021 00:02:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: tedd.an@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215347-62941-OYFTieeAOE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215347-62941@https.bugzilla.kernel.org/>
References: <bug-215347-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215347

--- Comment #1 from Tedd An (tedd.an@intel.com) ---
Hi Hui Wang,

What's the kernel version?
I tried with the tip of the
bluetooth-next(https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bl=
uetooth-next.git/)
and didn't see the issue.

Could you capture the btmon log and dmesg log?

Regards,

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
