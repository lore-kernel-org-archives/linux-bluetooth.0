Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18711C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 15:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbiDMPRL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiDMPRK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 11:17:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F0614084
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 08:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C32F9B82520
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 15:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 769E3C385AB
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 15:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649862886;
        bh=beirXauafyrnWtYjPk0GXgSk7sAAcw6kPiozckXaefI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VZIOF977YEDGdNqvQP9PKiFOPStZhBD4CjJq1BPGWNhvF1C85sojx0ixaqS7YPPZq
         C6ecOi3T7hnoAcUxLhedzbij8zdIYM/dbRDVUPHSMcoC83DL8aiXLF+M43WdPd0Hyo
         dU9aA0tyQL6xq9WT+qyO9exoXmyg9bC367HeRRhQ16RbYFyaPpGwrXccNlV1GIxi4+
         P/t8i79bF0GC79NrNEz8T5neSfUb4xAhJQBVKAb/tyTnBNLkgmWu29wtQh8kfwo4Ps
         tq3G139ahCDpiDyA2ad5kLnWfD2Ook37uxUVhx1Ud47K7mwZAdcVjYeeqtwg2pURjq
         FEIAve0eNDv8A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 56D88CAC6E2; Wed, 13 Apr 2022 15:14:45 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 199035] BCM2046B1 and hid2hci generates highcpu usage due to
 udev since 4.14 kernel
Date:   Wed, 13 Apr 2022 15:14:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mathieutournier@gmail.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: OBSOLETE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-199035-62941-uDnUU6XDNn@https.bugzilla.kernel.org/>
In-Reply-To: <bug-199035-62941@https.bugzilla.kernel.org/>
References: <bug-199035-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D199035

Tournier Mathieu (mathieutournier@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |OBSOLETE

--- Comment #19 from Tournier Mathieu (mathieutournier@gmail.com) ---
Finnally solved !
5.15 kernel and ubuntu 22.04 upgrade solved totally the issue for me.
I can enable my integrated Dell BT card again :)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
