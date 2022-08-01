Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B11C00144
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 23:10:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiHAXKl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 19:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiHAXKi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 19:10:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5806F27B29
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 16:10:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CBD35B81624
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 23:10:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8400BC433D7
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659395434;
        bh=LZJ+akY2PmmVPw8bt9tBVxSd8M01WNAL8MhdSjF1l4s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hZW696X9dNYbv5tReF8hUa4173IXn5DASYje+6JY2GqoIkn4lS3CodTEONW2aekaS
         5ukKE+Z8Dm6jfO8ES8JvwHszmKx+T8PvdqSFuk87M2O3rTpHlRGwuV5+F4JJDC23IX
         8kJMKEvkQ99TkIKOTsYGKm5mQfCoxkUsDgysvPXDQ7fM67AiTk7eMya9/mbuph1Cpr
         FVzpkBTJ5OsqmgPDPsBkTUbljGsuVpvb5ryreWsGwYgqFy+KSzHWHKkEa21ySBIoJK
         rKsXhopv0ItRTUmznDvsOMK9I15nQ31XqEEPid4+MM7bCRiHWfTWexM0e2xVZMxGhr
         Bn57XpZF+e+Kw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6D79EC433E7; Mon,  1 Aug 2022 23:10:34 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216314] After resume the host stops listening to incoming
 Bluetooth pairing requests
Date:   Mon, 01 Aug 2022 23:10:34 +0000
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
X-Bugzilla-Resolution: PATCH_ALREADY_AVAILABLE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216314-62941-Ns7qbS2ss3@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216314-62941@https.bugzilla.kernel.org/>
References: <bug-216314-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216314

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---
Must have been fixed by:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D68253f3cd715e819bc4bff2b0e6b21234e259d56

Sadly, no one has pushed this very important fix to stable.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
