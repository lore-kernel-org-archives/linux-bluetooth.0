Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07CAC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 14:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68B5610A7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 14:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238168AbhHLOvg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Aug 2021 10:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:60150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238158AbhHLOvf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Aug 2021 10:51:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DB2C561102
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Aug 2021 14:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628779869;
        bh=W5fAeVv/MHiBZ6LNiX9YJyuaF/LDbNqVDBeguz2+Rg4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kvV6Gq9QmvVPfJYQ+14CXTaJKvjfT/zLxJ00nkjnBtPxBMGbYa3LgMxZ8wlGsCZhy
         Zs3X+1bytMfewxZmCsITup9KMzCpyhrAomxH4xxyleM0WVqVxll8PEQ5lygFZO1Q6J
         PaIG8MTkxXL0db/fAU9M0MQKBZu9ujQi2tmt6kXz6I29jSNvTaxXEXVWMaliBt9JLb
         ULyLFmMm4vFhC4GQO+lIB6AvVj7u9QHhiCWLtJSXFbarhxh6vZRYSYLeGwGWRELbZA
         SaeGLrJUyj+q1aDmYQSgxbeSH/XWVyiYvQC/Y0biWC7gWZn/WFr65IEMBYLGkVBI/d
         52QT5Ai0mvQBA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 12 Aug 2021 14:51:06 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-Zr50MSB6Jw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

--- Comment #191 from Swyter (swyterzone@gmail.com) ---
Good to hear. The force-suspend-for-everyone patch has landed on linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/=
?id=3Df4292e2faf522f899b642d2040a2edbcbd455b9f

So that only leaves the `HCI_FLT_CLEAR_ALL` thing to do, so far. Maybe some=
one
else wants to tackle this one. I don't mind, but sending not-so-thoroughly
tested patches for things I can't verify directly is a bit eh.

@Jay, does it work fine with just the first patch? That's important.

Also please post your `hciconfig -a` *or* 'Read Local Version Information'
packet from your `btmon -w my.log` as shown here:
https://bugzilla.kernel.org/show_bug.cgi?id=3D60824#c119

We're interested in the HCI Version / Revision and LMP Version / Subversion
fields, which don't appear in your lsusb dumps, and show what really makes =
your
dongle unique.

Thanks a lot, guys.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
