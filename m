Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82395C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Dec 2021 07:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238438AbhLFHXa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Dec 2021 02:23:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47962 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238367AbhLFHX3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Dec 2021 02:23:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B9FB61174
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Dec 2021 07:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D81EC341C1
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Dec 2021 07:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638775200;
        bh=myvxbjdrQ5XC6gIlAW09lyDy+Kekom/CgPKZFD55xjM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sf8/M5Xj24Qq0sDQOI0CP3VGCYEiXA73pP7zqRhsIGrFk/mKllaImv/GnLqfXa2tw
         2+tFy+KFq6QLbj4mwfJys018mrBYUiwuThj37Abc+IGh5tEA6FScjHRFPA3Gql7ezn
         FwIsQCrJEBKPA+GAUDEHw79n6NnWhV8qPwbvR5b/A1/jzDQ3ZVeiZ8RtWcLuz05Uz5
         gV3dhV0cLIjNLFPBM/azMbHD0T2OYpz6xKXdjjHN+LRJ1bz7iLED59QdGFwYkoGGPY
         tC3dYS9tVW75ATdaVm9P3XirA3Z6LxjlRsjNd+VRaISKq+LVSWUTEVRg9/sSQwHbDy
         7BZxMCaPoBJLw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 31A4661158; Mon,  6 Dec 2021 07:20:00 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215187] btintel: AX201: missing firmware ibt-19-16-0.sfi
Date:   Mon, 06 Dec 2021 07:19:59 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kiran.k@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215187-62941-GYKYU5bhBa@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215187-62941@https.bugzilla.kernel.org/>
References: <bug-215187-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215187

Kiran (kiran.k@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |kiran.k@intel.com

--- Comment #2 from Kiran (kiran.k@intel.com) ---
Hi Takahide Nojima,

Could you please check with 22.80 version of firmware for AX201 ? One issue
related to firmware version got fixed in below release

https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git=
/commit/?id=3D142174abc58e4529d5c4ec410a955bf0885dbe6f

Thanks,
Kiran

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
