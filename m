Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0082CE79C2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Sep 2023 10:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbjITKxl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Sep 2023 06:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbjITKxj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Sep 2023 06:53:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A7FD3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 03:53:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15E5EC433BC
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Sep 2023 10:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695207213;
        bh=G+ojRwyDsenGbt25zoCp3kDjq+sJkYdTQ6AWLMu874M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qK1NyF2QhTq38LV/lSFdke32bxCat/oxK+TgC3xj9ZQbZcOyuM9NWgpxjo4t62I4q
         1/iH2rHgrrEMW26eFVhpj8NUNF7mo5qQ6sHDvMpIa/w3VAjGTryTjJddp4idqxWz49
         noTYlRxDcjbQLUyZyfla1cfAC0QTGld5/+VMvAacFzNaxCLtpy9vutT3q4ThJa0IRO
         S0Bw4ASltJB4l3+WZOJmz/TuJmAu8/1RGLJ4awqyZlSs0abWSg5ppXl4LjC0+BV7v9
         188y7b45cMuaqZSUHMsuYFjCvx5m+2QiQo9HuE9+BbZXNjXSpUo1BEKfYX3aZQ35+T
         tLQUxqgRWCgHw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id F3091C53BD4; Wed, 20 Sep 2023 10:53:32 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Wed, 20 Sep 2023 10:53:32 +0000
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
X-Bugzilla-Resolution: CODE_FIX
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216936-62941-IpfjiYRQvd@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |CODE_FIX

--- Comment #18 from Artem S. Tashkinov (aros@gmx.com) ---
This looks to be fixed in 6.5.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
