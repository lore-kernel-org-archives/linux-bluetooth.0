Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6498C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 23:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242162AbhLVXpq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 18:45:46 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49208 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241033AbhLVXpq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 18:45:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C198B81EDB
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 23:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA736C36AE5
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 23:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640216743;
        bh=RFaa60HT4OZhHDIPd3sf8PDRUdCGdzCrRUUCQbXwlg8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tkVNgGfTzeaQLJ4TUwNyKtV17lhDuG98Q6HtgqiRjFUoxt/MFmsyntYWCFekAlUU/
         9NugCGhe2lFy9TDGC6al3ejHllfECGyHwBHCF1wUy73iF6vqBGSvmYffn5DfyDCOjk
         NVbj4Mw2W3i36yNLz4/ZaFtH8YJ6xb048iHtAloR2zRZ9eg4l6OqvJZoylXSNNqz4Z
         1jztChE4/8t1S7IWfmzN2l1IwiAY8GV3f6HaNl9ZO22QpRYJgxrfMFBKORfwSc49n0
         9pTv6+Q0St6aa1MR152Dz5qsU1RGSljxOuBYPG02A1bDJM1y9kGjfbKpC+agRHq7zb
         zhtf5WhXZMbUg==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 79D3D61177; Wed, 22 Dec 2021 23:45:43 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215347] btintel: AX200 (8087:0029): hci crashes and can't
 recover after repeated rfkill on/off
Date:   Wed, 22 Dec 2021 23:45:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215347-62941-SUtSTi9WOh@https.bugzilla.kernel.org/>
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

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #9 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
This is like fixed by:

https://lore.kernel.org/linux-bluetooth/20211213212650.2067066-1-luiz.dentz=
@gmail.com/T/#t

It was fixup on the original patch and force pushed to bluetooth-next
yesterday.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
