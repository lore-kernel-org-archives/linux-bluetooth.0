Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBBAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 09:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1456475AbiAYJL3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 04:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454039AbiAYI5Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 03:57:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4255C061401
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 00:08:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95B15B815F3
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 08:08:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DC77C340E0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 08:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643098116;
        bh=Gn9HwLUA1q+4WtDz8c+ybrmXoZKDMebGFefWOMWHqm4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=TuxW7TpHu8BwxwnhFWUys17osnXfrK1kCsq3dw5L+BGk1jadiGBlIKCu2xmMTbtEA
         sIt+Jsaj4lYm60Mtv3tPnj1XhwA0tX2XuLDQubwlOOetjBcbvE9iL23EQk/kRjEzXX
         Fb/zNkTThrZq0caZBDdgjTJknhnpvPDTsjuLDmqYdlAXiw+rmhzOvbBz/x+nCvnlnw
         rt7hjc1xs94hFOx3n0MbqrI29MSUNJJK2z8o9+rHitB+W9iSIy2wYAuKya/2hazcPb
         IpDP1z6D9RUNUOiH1hBAwbvEyjBGY33f11cuMQFyFtPMsfpkInkMtxuYRBqAPXHnkH
         iIqSAMj9dKcVw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 2FBCDCC13A6; Tue, 25 Jan 2022 08:08:36 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215497] NULL pointer deref in klist_next triggered by Bluetooth
 HCI_Disconnection_Complete event
Date:   Tue, 25 Jan 2022 08:08:36 +0000
X-Bugzilla-Reason: CC
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Networking
X-Bugzilla-Component: Other
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: soenke.huster@eknoes.de
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: stephen@networkplumber.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-215497-62941-7tmm5ZuIZT@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215497-62941@https.bugzilla.kernel.org/>
References: <bug-215497-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215497

S=C3=B6nke Huster (soenke.huster@eknoes.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #5 from S=C3=B6nke Huster (soenke.huster@eknoes.de) ---
Fixed in d5ebaa7c5f6f688959e8d40840b2249ede63b8ed @ bluetooth-next
(https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.g=
it/commit/?id=3Dd5ebaa7c5f6f688959e8d40840b2249ede63b8ed)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are on the CC list for the bug.=
