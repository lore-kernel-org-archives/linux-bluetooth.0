Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AA4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Dec 2021 23:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353882AbhLAXvX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Dec 2021 18:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353868AbhLAXuz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Dec 2021 18:50:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB22C06174A
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 15:47:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38161B8210E
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 23:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB029C53FAD
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Dec 2021 23:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638402451;
        bh=lDXHd5M3xoS9yyH8/VKQwjjZ+jswE2ClnoOydfRKgTs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aIOfwNmejG42jRf4s0xDm8fGd1TPMzdu43u9ub6i0g1poHnEmiLmg8MDbQ7w4OHTY
         UUfpaduP6enz5nlvO9ycZ4fIeo7pfwOMJ+QBw/DYEfsmhGf/hgGmQieT+lC5krS5qv
         S5T5nHEIumUJJg6sDnlZteH5AOprqWeh/y/qIAcGuF+ZR7KeuBGgYGIcRhwXWeVy5u
         5wWSpnk85bAtClCr8sE7k/jOJfHLfJa+08SWcVNa3Tl0sS/OiwwugtDFO7s7fvxkMz
         3RFu0z2FicPvMNbeosnaVQgEz5KkwealJxUAPlHzCwF845X0Hj7vcMZiM0i8frUNo2
         2E/eh+m9MRiRQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id C17F260F00; Wed,  1 Dec 2021 23:47:30 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 212965] WARNING: possible circular locking dependency detected,
 bluetoothd/547 is trying to acquire lock: ffff9f6854610078
 (&hdev->lock){+.+.}-{3:3}, at: hci_conn_get_phy+0x18/0x150 [bluetooth]
Date:   Wed, 01 Dec 2021 23:47:30 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-212965-62941-IQdyKrujeb@https.bugzilla.kernel.org/>
In-Reply-To: <bug-212965-62941@https.bugzilla.kernel.org/>
References: <bug-212965-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D212965

Erhard F. (erhard_f@mailbox.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--- Comment #2 from Erhard F. (erhard_f@mailbox.org) ---
Have not seen this since quite some time. Kernel 5.15.5 and 5.16-rc3 are ok
too.

Closing as obsolete.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
