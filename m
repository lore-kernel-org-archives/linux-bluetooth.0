Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2910AC4321E
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Nov 2022 19:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiK0TyQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 27 Nov 2022 14:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiK0TyP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 27 Nov 2022 14:54:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7339ADF47
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Nov 2022 11:54:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D907760DF7
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Nov 2022 19:54:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F7C7C433C1
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Nov 2022 19:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669578853;
        bh=Z1wwTCmvkUeQaxzNwKGqJCTnCPSwa0iPyACcO8lJHfU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=X1pMeU2KEEdmwe0dTb5EPqdrp6ug9KzVCtoyecWeNq+Kf/gRKq8ednZe4SI3nOus6
         n8AqWaJw0MdSVuPMPJ5Nz8qAXd6vyl2/TFJDIzx5Guc+RiLVkiycP4eK8ko5EqJ+Yx
         tMha3DdTUfRaQ4hPKyQK7onbE7BjJhek0i7AWzo426EPwmldLDVuK9zXFkJ9AK4QSc
         jCeTtu3HDXiLr3NO4Z+q1Av4VRRRsYGc9Hu7ldYDAnTeC3IppKdMLzQ/0swkcgBd0h
         G+d2shFIw2dUTSPptuGR/aOXl9N3V6FtDXwYz4FNrWJHWhY16v6ZhIoqiR1cT4Cmmw
         1K7bp7JVVRFzw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 26CF5C433E7; Sun, 27 Nov 2022 19:54:13 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216683] [REGRESSION] HCI_QUIRK_NO_SUSPEND_NOTIFIER causes
 kernel panic on fake CSR 5.0 clones
Date:   Sun, 27 Nov 2022 19:54:12 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: ostroffjh@users.sourceforge.net
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216683-62941-ZQSMPCdjk5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216683-62941@https.bugzilla.kernel.org/>
References: <bug-216683-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216683

--- Comment #8 from Jack (ostroffjh@users.sourceforge.net) ---
I have reconfirmed with a vanilla 6.0.9 kernel.  I got the crash in less th=
an
an hour, without even unplug/replug.  Comment out that one line in btusb.c =
and
no crash with multiple unplug/replug of the dongle.  When I get more time, =
I'll
try applying the patch in Comment #0 to confirm it allows the dongle to wor=
k.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
