Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685DCC83F2C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 16:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237981AbjIEQWM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354177AbjIEKGU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 06:06:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE6590
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 03:06:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59503B81104
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CB81C433CD
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693908372;
        bh=p4jx4BkUQoa8hrskH7mJUWfnxoGS/G4J2CXfM217NXE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=M3Fsx1dtTHu+MWIJlvL+8sPvbsdTeOj5HOpk/3/UQdNKkKrHhHCsWeyJ6q4LfAeDj
         +rogbZ2iWAxPhor2dy+x7SGjusE7txxRQjCRii5pPtMHpkUI/mFGSec8+rmF+zJnEp
         S/4Rkydzpu8QRkL3W4WHk7sdUzc/VHnNHbfbocCh7u/FjZV5joYJPSyfz9PnkYqHwf
         ndIFQtcsPVIsumflCn0ixAlBE/5VD+zciFb9HHW+2WZpGE+NAkIaLapvReFsw5d+BH
         ul8U3DGniTlhStwSUt6RNKTN8TbL1gavh5b/gmcY3CwXbIIz5f0vgAgEO7GUNKMVmH
         ZxhxNaLYAXsKA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 0682FC53BD0; Tue,  5 Sep 2023 10:06:12 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 85161] Bluetooth: hci0 SCO packet for unknown connection handle
 41
Date:   Tue, 05 Sep 2023 10:06:11 +0000
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
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-85161-62941-F7oSY8ApSj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-85161-62941@https.bugzilla.kernel.org/>
References: <bug-85161-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D85161

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #6 from Artem S. Tashkinov (aros@gmx.com) ---


*** This bug has been marked as a duplicate of bug 80791 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
