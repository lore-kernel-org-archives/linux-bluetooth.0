Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3DFC433ED
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Apr 2021 14:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A867F61208
	for <linux-bluetooth@archiver.kernel.org>; Sat, 24 Apr 2021 14:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhDXOAn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 24 Apr 2021 10:00:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:51056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232250AbhDXOAl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 24 Apr 2021 10:00:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id AFF9A61494
        for <linux-bluetooth@vger.kernel.org>; Sat, 24 Apr 2021 14:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619272803;
        bh=UkcA0ENMFmXFC+7acL0HX00fenpGSdqtYHVlWBUFk0Q=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XsUSC67i/+llTa+2MP3+eHX6J/H7E1SK1rIzi+QT9hkoBJulgZRG5x1lqIkDvxbJW
         WnCD71VKDQvEK71bJRId2IE7OV7EZdITCp3q4Ha68aTfaQD1mn6b5BXfmyk7tc0ZmP
         1oCBPGSXYSCm0g1FpO9mvijrs6Yamc3c0+5jdJEqL+fC6B3zLs5SCMVOW+ws1Iz9X9
         toY41e2LGYJGU5oKDFzSXgyR3ExuX68qYa+l2wxsFyMDDHLBNuIPS9KG2DfT+KhGQm
         OGF1G9oRFyYkSJLU/48/kWahA75/Xdr5n6FgvklLzNtuwNedPgIuby7ieHT7M07kCO
         QmX7PH8rXdjCg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 211983] BUG: Unable to toggle bluetooth ON once switched off
 using rfkill
Date:   Sat, 24 Apr 2021 14:00:03 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: juliusvonkohout@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211983-62941-vZfkV8UVfW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211983-62941@https.bugzilla.kernel.org/>
References: <bug-211983-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211983

--- Comment #2 from juliusvonkohout@gmail.com ---
Same problem on fedora 34 and ubuntu 21.04 with kernel 5.11.
I am using an intel ax201 card.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
