Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F02C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 14:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbiBROQQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 09:16:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbiBROQQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 09:16:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6074229C119
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 06:15:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07FA7B8265C
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 14:15:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7BECC340F1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 14:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645193756;
        bh=VmNg4OHfpfngl/R3+DYCrZU2oO5sgu3L2nbd8dfiPEM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=KsAkqhdFV8ujCTaBL1XkvsMHbEo/lLmK4aySBIivCMoaZt8sqbso1YBqYNReNN3iX
         XjaSzxwjli0QeTkj2Rfqf4IDVvNCpVsJFgZ1LKTNb/e/8a9VHN0d9FZ3trr0sOec2g
         7fCQRaiGNt6JHyjlY/3CSRACQmiiaakjFTCD8pgnrGAgBvUZLo5Cy1+10A+w5CafNQ
         ieOhvN4aMtna5cMkpoJspMKFNbAOY4A+d7yDm7Knt+JeGVRZDjrDbvH3SnA1QIeEK8
         SnpHTeWAQYxM9B+O0zs9LuxBmYFwgaHjwr6vGSUvcHsDukfINwCoPZtl10JeFdf9Lu
         1lgItjfnEFGqw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8F6C1CC13AF; Fri, 18 Feb 2022 14:15:56 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215576] HSP/HFP mSBC profile broken with QCA6174
Date:   Fri, 18 Feb 2022 14:15:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: regressions@leemhuis.info
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215576-62941-mgAUSJWfs5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215576-62941@https.bugzilla.kernel.org/>
References: <bug-215576-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215576

The Linux kernel's regression tracker (Thorsten Leemhuis) (regressions@leem=
huis.info) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |marcel@holtmann.org,
                   |                            |regressions@leemhuis.info

--- Comment #3 from The Linux kernel's regression tracker (Thorsten Leemhui=
s) (regressions@leemhuis.info) ---
hey bluetooth maintainers, what the status here? This regression was report=
ed
more than ten days ago, it was bisected, and a second person roughly confir=
ms
it, nevertheless there wasn't a single reply yet. Is somebody looking into
this?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
