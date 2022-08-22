Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1C3C00140
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 02:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiHVCBj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 21 Aug 2022 22:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbiHVCBh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 21 Aug 2022 22:01:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084E1220EA
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 19:01:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2F3EB80E72
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 02:01:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6787EC433D7
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 02:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661133694;
        bh=yp5zKOYfXhz6hSkIxc6aCHiCk0c/O+wfAyFSzN5epm8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=PxXaG4JG1MK6/WAtqFJSbcKDcDyiNSynREW6UjHloHT/T/JeHGeymXA2K+wgqgtYE
         N9zQB4OHACnGTwErUj4lZjH7BT9caOSRQ1YRy5LzHRJWgMvdDEibdVglNeCipTSRMM
         d7H7tE7Vy9f655GMmLSG3z/41PJ1syoZam7u/JipiYelPfmH37DHNfoJMUiWHiZCAl
         7/aef/vkEej+laPsjJtIlbilAft3dXaAhxf2wm50PcYGlsVQVNBUfyseG4Z1RXKmUl
         v3JP9qgfFDqa2MG76Ghx/kxnu8n+Lt1nPc77bDxraKkOAkQPWdZaimXVZULduVfs7Q
         /ZzyQgjXk074A==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 594BBC433E9; Mon, 22 Aug 2022 02:01:34 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216389] net/bluetooth/l2cap_core.c fails bounds check with GCC
 12.2
Date:   Mon, 22 Aug 2022 02:01:34 +0000
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
X-Bugzilla-Resolution: ANSWERED
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216389-62941-r05py1LfUk@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216389-62941@https.bugzilla.kernel.org/>
References: <bug-216389-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216389

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |ANSWERED

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
This will be fixed eventually, might have already been fixed in 6.0-rc2.

Removing -Werror will fix it as well.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
