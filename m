Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4B3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Dec 2022 21:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiLHVmS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Dec 2022 16:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHVmR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Dec 2022 16:42:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F46AE67
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 13:42:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6053B6208F
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 21:42:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B68B2C433F1
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 21:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670535735;
        bh=CqTtc3go3OpPDXZx14YEw7irH/GAq3J3MplP+5ZQvHI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=rhTIsm6ai/m/VNsfcRzb7P77Sj348SBn+v5r09w8KWgexa4D0LqkeEho1egS/7FJ8
         zzV57SycNVk66d1QXNQRAaFQSJ6qGARDs+2Xbk5qrQuSBwLmU21VaVnBuKB12gTsKo
         Uhj78Hg1cJS4QWVL3zNKgVdutaEph7A2pHemrsTpntOpPXUOYrJrAZSwm9i014hXn8
         iyiIlvHxnaMKpIjYLHsL9XPL/MmAX18SU7kKrfV19p8whH5adnCRV3szyZ4/YgBeIG
         3hWbdHFSlnSQt7ReBOuYzUsjs2MeQnHPRSxaxfW0z5tgoQQoFGuVd7sXT528kAlhSR
         vASSzcp2MYgvg==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A1FA4C43144; Thu,  8 Dec 2022 21:42:15 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 212243] bluetoothd: profiles/input/hog-lib.c:report_value_cb()
 bt_uhid_send: Invalid argument (22)
Date:   Thu, 08 Dec 2022 21:42:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla.kernel.org@e3q.eu
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-212243-62941-Glx8MtaVvp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-212243-62941@https.bugzilla.kernel.org/>
References: <bug-212243-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D212243

Erik Quaeghebeur (bugzilla.kernel.org@e3q.eu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
