Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23ADCDB46E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Oct 2023 02:24:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234048AbjJLCYk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 22:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbjJLCYk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 22:24:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CF2A9
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 19:24:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94E68C433C8
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Oct 2023 02:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697077478;
        bh=Cnm9o6P5z68FsM4Xwte9QVOvsH1s+4AtqYlX2BewgnA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=WNZ0n8drpmHkjWh7Zm671OUoWy2CHvhpdPu53QpYYcQ+roAUVaCp0bM1rc6CuGIZf
         FAmz2u9w0P1FY97CxxabVdcV1oCZvfbPsG/x7dVTuAWXbLPBi6umYCxxCUPXNwiWRj
         adCUuS3PKnydHW/IDFbcHruudM5pJjsUdzaBROk6aUB+LpTfWSvgojMvPbFcZFTV/K
         Fd1rw77PyivkAhrsSL4Fi89nu+4pArW1sCARXr7DyQC8zxtF6qGwpZc2Q5P5sDB1Kp
         +TALcEH6nbE6n/P2GdAffctfj9KspNDqE9ajIVZa/+U2Uu18MrHzxNeznbebq1vF/m
         m4kZp90NVT9BQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 82729C53BC6; Thu, 12 Oct 2023 02:24:38 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 218001] bt shotdown
Date:   Thu, 12 Oct 2023 02:24:38 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-218001-62941-w9mvc0VnyE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218001-62941@https.bugzilla.kernel.org/>
References: <bug-218001-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D218001

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Please stop spamming kernel bugzilla.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
