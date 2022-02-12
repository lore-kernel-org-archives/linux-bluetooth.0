Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D9FBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Feb 2022 18:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbiBLSjX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Feb 2022 13:39:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiBLSjX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Feb 2022 13:39:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9195F6007A
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 10:39:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E340B807EC
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 18:39:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05E79C36AE2
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644691153;
        bh=Q1XyjER1NFMeks6C/bpzVoM3TnkMjzeh7uapt4komV0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kMS7kzIXr+sV3Gp/O0Tm2WBL7VhnKueTLPBWFE16CHCghjvzcTPSNFY3gQHxzXd+j
         3EknPpJqabd2mNEhzofugQLBj7xkowgZgv8aIWiypvqfeVzZgG1MrzqmDGAziETISL
         HlPRK+KkhwlAhLeIJB6AJABjUe76vqo8zV8ywUebSDvGi4h/nJVQcIe12ZfK49xbjH
         TR7JHfHCjy3YOTZgmCJhMoP93QGDG0cQSQU8qULQEaFXhja08DkmHI8Y2EEaNymsvK
         erfT2DT36EQ7tVLQaCnzXub9wfKGxOR2EmVF1+EFbFtfM+UtR1oE6ZgcRKEtGdbZvY
         2WpPHD/skD+fg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E23E0C05FF5; Sat, 12 Feb 2022 18:39:12 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215594] Unable to transfer big files to Nokia N9 and Jolla
 phone
Date:   Sat, 12 Feb 2022 18:39:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tedd.an@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215594-62941-7QaMmcypRG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215594-62941@https.bugzilla.kernel.org/>
References: <bug-215594-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215594

Tedd An (tedd.an@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tedd.an@intel.com

--- Comment #5 from Tedd An (tedd.an@intel.com) ---
I tested with latest BlueZ(HEAD:
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3D002c0c9eda0=
052a834ddd4b63026f534b7d52f14)
without reverting the commits in
#3(https://bugzilla.kernel.org/show_bug.cgi?id=3D215594#c3) and RFCOMM work=
ed
fine.
I tested both Windows 10 and MAC OS and was able to send and receive the fi=
les.

Please try it with the latest BlueZ and see if it makes any difference.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
