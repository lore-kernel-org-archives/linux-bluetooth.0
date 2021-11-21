Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418E2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 21 Nov 2021 21:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbhKUVZN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Nov 2021 16:25:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230418AbhKUVZK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Nov 2021 16:25:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id AE00E60F4F
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Nov 2021 21:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637529718;
        bh=ekCJjQhX5cFC/JZPk/2RZ4HTqdhbZOo6V4TW08CYR5Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rEx6FnGrCdRzmtHIbf9RspsFinmTcW8uu97mH270zCAPVA3KPQS/oOLSiSyp75Jz+
         9CUBYa1D/MEUip1eEgHhfjVcpctTdbetCPMez1m10WtHB6fUZDjto1MCEnBXQL+XUH
         muI5vPFmhQUgo/ltjLgHSU1LDbVt7ykKaRTqL1EW8MwItSjktXxZFC8O9iT7qHBfhO
         djOYyMzqxT0VcsEtv+/JZ9q5hXUD+svGleZRm8vGLQ7VIhSGUOkpCc5n5LjN4D9mbi
         19NQe+BsdfRDhbFogaJK5f3QkUSYw9aJp0SPhRqaNhCRtAT4YpzVXQEx9b9vNfHI8w
         CZYe+fZ6ARj4g==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 9A1F860EBD; Sun, 21 Nov 2021 21:21:58 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215015] rtl8723bs restarting loop
Date:   Sun, 21 Nov 2021 21:21:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: serg@podtynnyi.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215015-62941-Eyh8LtVrKR@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215015-62941@https.bugzilla.kernel.org/>
References: <bug-215015-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215015

Serg Podtynnyi (serg@podtynnyi.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
