Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0BEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 01:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6623861452
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 01:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232088AbhKKBN4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Nov 2021 20:13:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231312AbhKKBN4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Nov 2021 20:13:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 10928619A6
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 01:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636593068;
        bh=WU/h3SntHP4ti6yxIQVvs0LCWn3i7/EO2JTuGy/wRho=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tzyNTDZ8+lDvAcpvc6kx19poeeRDWsneuhtCV0VcSqeoTNsoJeOx0e8300CVXv0Uj
         jZVY9JG4kdhD8Ck5fsgqjdlC4GY+rxLv8M5cNuAglKFmEfKzjgQWiOLc515flSxzQ4
         FLT+nc7sS74/cn1oQXKQzoq/hB9TDvY5ls3HC4RnEE2gxeKn+Zy7IcFUWGHPe8PRs4
         V5r/dqpw09r8birLhSC5nLYYD0Rt4FFu6Oy5s6iD96yKpGR7YWoLcDpgqKEmSetnVA
         FOv+r/D6I87WjEoyPuW+BCusomouOgwGVwhoNXPZjNzHJ9pnYJTtUsFLXhw1e6hqko
         yAMxm07IJe6/Q==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Thu, 11 Nov 2021 01:11:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tedd.an@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-213829-62941-fh7xPahdLj@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213829-62941@https.bugzilla.kernel.org/>
References: <bug-213829-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213829

Tedd An (tedd.an@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tedd.an@intel.com

--- Comment #19 from Tedd An (tedd.an@intel.com) ---
This should be fixed with
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/bluetooth/btintel.c?id=3D35191a0fe986bacf69bd842de81119dca7970f11

I tried it with 5.15 and didn't see the problem.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
