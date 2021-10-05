Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3145C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 09:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A3C6154B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Oct 2021 09:26:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhJEJ2C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Oct 2021 05:28:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232658AbhJEJ2B (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Oct 2021 05:28:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 974406154B
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Oct 2021 09:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633425971;
        bh=aMsoJ0evHhv5g7JksyHmLLRdPwJSQL70mYF3jC1w8Uk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VGsc3oVaEIX/DaADMBjdx2qg5RP0N5UOxraH2DCXZIwZvy6qpdqZBULglRTWv+wh7
         SOUPR2hmZ1Z4QanXDFagVp/j1z0ap5XXOMqfTDuwZEhkhHR/2QtcMGrUXdjsDlcut+
         1jcsJtPTzo+ID6ejg7T4YvV42SBfov2VyznsuZ1cZ6m7E8GvKUTpa/Rka53WnC1i5X
         vOlBz24mYVvXtT/iPjSI56rIKdPIFx2OtTqfRe4ubMqPmScWOlYO21+rm1iSlD6p06
         ufOuzVYXgk+6x/Vx7IWnj4OhjXPOwDWKmEsSm2n4PWqDrgFwNbarQ2Nub5FeDfSQkK
         kzSWGVDKAGuWg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 198451] Error message: Bluetooth: hci0 killing stalled
 connection
Date:   Tue, 05 Oct 2021 09:26:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: f.de.kruijf@beelaertsict.nl
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-198451-62941-4cSe6DBPw6@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198451-62941@https.bugzilla.kernel.org/>
References: <bug-198451-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D198451

Freek de Kruijf (f.de.kruijf@beelaertsict.nl) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--- Comment #1 from Freek de Kruijf (f.de.kruijf@beelaertsict.nl) ---
Apparently this bug does not appear anymore.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
