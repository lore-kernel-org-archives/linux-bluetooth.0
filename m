Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115C6EE57F1
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 10:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243062AbjIHKWx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 06:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243025AbjIHKWw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 06:22:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62632212E
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 03:22:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22E77C433C7
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 10:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168462;
        bh=2zbDjCbssDuz2wW9ejXDCIR1IcMcFmUyAaK1m7Cd8ro=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eCCufYlotIaTsCxjUgKq73LQCRswCSX1c1/mLc3OLYw4qsTRyVdS6j1HVyyek6piL
         kA86bm9HxyzK2794gbhPckXFR0jAyUnza+jiCJJ/Ij9fV2vU17rheo3Q/YLD0kN2Tc
         xbApATXcIAxKEibgOXvTm6bMPuthKb/YM2wdKgBjpyRBn4CNCZzQHR/7wqOQrdpsiv
         GYdzyL9xb1eQtS3JQuQcA0MXacatKkOsD2Jkpb2hAIslrKmd5AAscjvBdN7ztC6SwZ
         JfY91Q6NYH/96jpN1dOa5nk9FKxagHzMmoM2g9bMel7110QhsWixQNOX10J5TXg3kn
         7jxgcdMJ2otpw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 096FEC4332E; Fri,  8 Sep 2023 10:21:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217773] Bluetooth LE scan doesn't show device name
Date:   Fri, 08 Sep 2023 10:21:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tatrics@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-217773-62941-lOSyXqXRlJ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217773-62941@https.bugzilla.kernel.org/>
References: <bug-217773-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217773

TatriX (tatrics@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--- Comment #2 from TatriX (tatrics@gmail.com) ---
It looks like this change:
https://github.com/bluez/bluetooth-next/commit/52bf4fd43f759ac4698f041fff2c=
b27691698265
has fixed it.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
