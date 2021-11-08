Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325AEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Nov 2021 16:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D80C61406
	for <linux-bluetooth@archiver.kernel.org>; Mon,  8 Nov 2021 16:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbhKHQir (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Nov 2021 11:38:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240086AbhKHQir (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Nov 2021 11:38:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id D05FD61458
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 Nov 2021 16:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636389362;
        bh=ZUdR0ro24Gh8YMlUa4/ZuuH/G1acGCKgOvkswyXF1MI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SbLpJRemMjJ1F3obWMIMRY+ZjhgT2aRrB0/uUpsDKJXdPsouGCmx6c3hG+0NunjD/
         HH1uLZY5EFBF8FX7rQKsV7nCv6H5lHAGpO3EB9VSY/4wkug+N1Kn//ABysTvXxl5sZ
         s+a6pAM7xSoUFSPjz1BDGmWZY3BLWtDgaBQDMgMYKPu4Nw6GbpoPJ1A4VXsUmr0In0
         KTedwffVbTWW1ut8qqK1RG8OcySr5ABdhbwMOu6MgkrW/33SvT8nGn4Wc53x1lfBdx
         DgdEUtfmYTf4QnAQ3K7dZVV6JTNxRkht0Vxe1diaOZCe9i9hsujf4murNXogvYQqzH
         UbO/SyhOF9QtQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 214823] RTL8821CE Bluetooth adapter randomly stopped working,
 only suspend then resume can reset it
Date:   Mon, 08 Nov 2021 16:36:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: thanhdatwarriorok@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-214823-62941-xoxoaJjXiS@https.bugzilla.kernel.org/>
In-Reply-To: <bug-214823-62941@https.bugzilla.kernel.org/>
References: <bug-214823-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D214823

--- Comment #3 from thanhdatwarriorok@gmail.com ---
That workaround only works for 5.10 kernel

For a better workaround see https://github.com/lwfinger/rtw88/issues/72

In case the link die for whatever reason, quote:

Add usbcore.autosuspend=3D0 to kernel parameter or blacklist only bluetooth
adapter using https://wiki.archlinux.org/title/Power_management#USB_autosus=
pend

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
