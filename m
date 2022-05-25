Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE254C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 May 2022 08:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbiEYIQh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 May 2022 04:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240601AbiEYIQO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 May 2022 04:16:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437B98D6AA
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 01:15:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 891F8B81CEF
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 08:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C8DCC34116
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 May 2022 08:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653466544;
        bh=5Bxb9Y5raTZY/PZHJSesbwXMRczA0OeCHz5xiIqVrEA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=G3IyuTIL7PJDwu3uq/meu8YrK9ezgpOciXavqzPfTEnpZufmvDBZRR6zaDdgzZFD5
         vbNIqCXJ7sxtOzSZLUbrXZnCfoKa9jT+aMpuSGqNuaLQuA9LwK6SJp10hYwxTWCJwp
         xDf3ASfK9s2fwMchdOwRYujEWURkS3htN0rA2e9XLS+lNP5KnlsRv6TTOT26tAxUnH
         u881T0JdATycf9p+f8EgN3ftH++3Mi7jGh39fHCygM1L2EJxcXwmeNhO6rMSOtwAsZ
         5mDyM2e+Z9abY3YrxqbM+QV7FqiiunPGYcjCeRO0wxOs54oC2t4T/KK7/fs+0RCrb+
         Tk/3nq8dDNjdA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E5452C05FD5; Wed, 25 May 2022 08:15:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216022] JBL Live 660NC
Date:   Wed, 25 May 2022 08:15:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: INVALID
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-216022-62941-dEIP6LxEI0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216022-62941@https.bugzilla.kernel.org/>
References: <bug-216022-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216022

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |INVALID

--- Comment #1 from Artem S. Tashkinov (aros@gmx.com) ---
Bluetooth has two major audio profiles:

* High Fidelity Playback (only for playing audio, mic is not available)
* Headset Head Unit (horrible audio quality, only suitable for making calls,
mic is available)

Looks like you're using the first and naturally there will be no microphone
available.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
