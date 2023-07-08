Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F55EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Jul 2023 09:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjGHJx6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 8 Jul 2023 05:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjGHJx5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 8 Jul 2023 05:53:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888F61BC3
        for <linux-bluetooth@vger.kernel.org>; Sat,  8 Jul 2023 02:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E01960B40
        for <linux-bluetooth@vger.kernel.org>; Sat,  8 Jul 2023 09:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C2F3C433CB
        for <linux-bluetooth@vger.kernel.org>; Sat,  8 Jul 2023 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688810035;
        bh=YLo4ec54k8UrKtuMjBsZe4aWoWa1Y1H3erqDx6ppLVw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OJh+hb8IRUrVEmQxuwMzM/T0cFStPmKKqoPwnY1TE7QShHjNb4kg05lbaPK7BXjvj
         DBeHmYV1Jxvx+Gq8sYSwzWP6vNMh/I+m5EIA3g3nDhyBRXWhVs6XLcw7D9HdujCumA
         j1lYlx0/e6OVU4KkBY7jHD16u7zteOHomJ4PfHmEFVl/LLQIR/4vRdgFA0MmAMHjgU
         8aOrzH8X6NSpLbdRQRGE28F3DNegBG1JMSE60Vr/MIqjJk2Sr99Ob6ZYRIv5wAC7sk
         v9LOrV5PJUuclRkDIY9fv9Ag5EXTyJ4OB8c7e+r2MmF1DasW2ZA9D6UZpjweQVOmcu
         y7QwBUmCP03aw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 53C5DC53BD0; Sat,  8 Jul 2023 09:53:55 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 200007] HP Elite Presenter Mouse support
Date:   Sat, 08 Jul 2023 09:53:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: marco.morandini@polimi.it
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-200007-62941-IYXvOUklRe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-200007-62941@https.bugzilla.kernel.org/>
References: <bug-200007-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D200007

--- Comment #5 from marco.morandini@polimi.it ---
Should be fixed by
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/hid/hid-quirks.c?id=3D0db117359e47750d8bd310d19f13e1c4ef7fc26a

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
