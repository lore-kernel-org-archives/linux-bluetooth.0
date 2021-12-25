Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5405C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 25 Dec 2021 01:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhLYBch (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Dec 2021 20:32:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhLYBch (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Dec 2021 20:32:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4768C061401
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Dec 2021 17:32:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BB7F8B82358
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Dec 2021 01:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57D92C36AE5
        for <linux-bluetooth@vger.kernel.org>; Sat, 25 Dec 2021 01:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640395953;
        bh=KItOJfqObku/v500KKe6c2IFYxL4omjDZNcBYhYhWPI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VHPZKjFxIhrB3rQO4eviCXmgXZWkzBEDaO2ohR9MS++QelfQg2utohs33eu+9LRPy
         nZEo4wYxnCTpOEPps2j5eyFIJ/J1Fmco0MO/y7uZVYwUL0HitMAdvg5wSw3PGFLwT6
         8DL3Yd7vKCvWQc493FjiDfovkXZ2ra2pIOxngZ48yRR4rkBJupQzDB0iHTwqmLkXjV
         ynNrXUDI3uy7q2KfdRlsntQ+CYRdWKwQZJZKtsSFBl/BIOpwasiISX4O9w0w+HtTpr
         vuI9W+YC4l9ftxk1Czwt+wh4eTkOxSSkv4pXhoOhhORmRx2QIqckVXTMjBmNwvoJR0
         q5guFYLmOGGeQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 2D0F960F9E; Sat, 25 Dec 2021 01:32:33 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215347] btintel: AX200 (8087:0029): hci crashes and can't
 recover after repeated rfkill on/off
Date:   Sat, 25 Dec 2021 01:32:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: hui.wang@canonical.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215347-62941-hKho8SmeMe@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215347-62941@https.bugzilla.kernel.org/>
References: <bug-215347-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215347

--- Comment #12 from Hui Wang (hui.wang@canonical.com) ---
Through bisecting, I found the commit cf75ad8b41d2 ("Bluetooth: hci_sync:
Convert MGMT_SET_POWERED" fixed the bug I reported.

The problem is the commit has 10+ depending commits, it is not easy to bakc=
port
the fix to 5.14 and 5.15 kernels.

@Tedd and Luiz,

Do you have plan to backport the fix to stable 5.15 kernel at least?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
