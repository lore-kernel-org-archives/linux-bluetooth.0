Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CE5C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 18 Dec 2021 06:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbhLRGMt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 18 Dec 2021 01:12:49 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:35476 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbhLRGMt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 18 Dec 2021 01:12:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8B65CCE0B52
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Dec 2021 06:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87699C36AE0
        for <linux-bluetooth@vger.kernel.org>; Sat, 18 Dec 2021 06:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639807965;
        bh=dOm63E89msFP0It6PLEgfGUviZUzuHR11F3uIBXXXe8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OvpdOhNz7oIPSgx5jC89Deu4kEhpwq5nPbeKe/IPlpp290eB0SH5DHcCGUDLuhI4A
         dSTo0R2jQkwKGRHIsSg4mD1KCFZJDdlxyli209/zEEclqqIBvkQUbwjdvQIvMjZXGV
         qIVB6uqe7HmsPG0Cd9voHrR8b88ELeEmJXzBHDcupzj5tngFQzkZcc3yuB9HhPnyCh
         az3iZV2MNK3iU6IRu71UDBUFbbXHGHVPX2JRMr/vjvkszqaZHyjCNyTlmVKiSlRv+t
         CtkXTBOH+ZvO/BN8spLTFcU99XSPaY/43SJVWdoVNCvyBLRcfUpnjuyintRkPwJzOu
         R8UE/4QknGWTQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 5EA1060F55; Sat, 18 Dec 2021 06:12:45 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215347] btintel: AX200 (8087:0029): hci crashes and can't
 recover after repeated rfkill on/off
Date:   Sat, 18 Dec 2021 06:12:45 +0000
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
Message-ID: <bug-215347-62941-PrkiQKSbrV@https.bugzilla.kernel.org/>
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

--- Comment #2 from Hui Wang (hui.wang@canonical.com) ---
Hi Tedd,

Forgot to mention, before running the bttest.sh, need to open the gnmoe
bluetooth setting, so the testing steps are:
- boot the system
- open a terminal and run 'dmesg -w'
- run gnome-settings->bluetooth (please see the attached picture)
- run bttest.sh

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
