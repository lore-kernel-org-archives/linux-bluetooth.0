Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40DDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Apr 2022 02:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239600AbiDNCOw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 22:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiDNCOu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 22:14:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C54515B5
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 19:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D84DB827DB
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Apr 2022 02:12:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A887C385A6
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Apr 2022 02:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649902345;
        bh=jo7dvZQJAclIU9n2dMBaMHWPleErI+m+wNbYXI29lCw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gpBUFIllMJnkM+vVJ43tGcDLZ1Yk8Ki6aYCDP8w6kGZIrCCYCHRali5p9jf1XJ4+M
         g7mdaFICkns1lL3jsz0U/3Fb3DpVE3NRtr/W3NfCgTqS5CgLobe3jAXLHyXvl+BCJg
         XD1KquDalnIk4UUz0R4P2t5OFsn3pF6Bi4mqJ6/kYwwXAtGCvWcCWUlGV/CP8KdIe0
         eEUrnBDn2yFV8CRSBnk1QeuWjIPsiC01GuQZwTBt0EEgkmrZSKg1hQizH1LdvuDOx+
         x44ZIP3BLuyjlTYgpL4srHtitsYXL/KXUr0oHxBom/Wbhv5WLA2B1iiCeQRfgpAqxw
         yMXn/EohQOxPA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DB9A1C05FCE; Thu, 14 Apr 2022 02:12:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214863] Intel AX200 "Bluetooth: hci0: failed to restart LE
 scan: status 31"
Date:   Thu, 14 Apr 2022 02:12:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: kai.heng.feng@canonical.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: WILL_NOT_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-214863-62941-rJ9m2SjJDW@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214863-62941@https.bugzilla.kernel.org/>
References: <bug-214863-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214863

Kai-Heng Feng (kai.heng.feng@canonical.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |WILL_NOT_FIX

--- Comment #3 from Kai-Heng Feng (kai.heng.feng@canonical.com) ---
With latest kernel/firmware, the error still shows but Bluetooth seems to
continue to work.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
