Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0EDCC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jan 2022 09:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiABJdy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Jan 2022 04:33:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiABJdx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Jan 2022 04:33:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B0AC061574
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jan 2022 01:33:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9550A60E65
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jan 2022 09:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01D54C36AEF
        for <linux-bluetooth@vger.kernel.org>; Sun,  2 Jan 2022 09:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641116032;
        bh=Tbxa+igREHxI02XVvzoOdcLVvjtC+U6Q5vnI12QmJwo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tCwS2qjc6UyyRc4nJ1OynUWLm0OvrE6XLjX80nQRI56e+iSmU3l3vBhQ1WxrECWTL
         7SXyyZjfzzOoPRb8x5P1A6sjDbYWF8M19e6GK8DroAKyxcwCsakKpPF0udpRnePqKW
         s7LTQE1/NnLe7sdriMml8J3KIDuiBgAJNdrS8TgmeKeUP72tUTcg+hpB+p2BAaHPsE
         3vQ3vrjfe3tr6XYrlUrwatcFpTACcfeNs2NCQlAIbTHS60eW6ec34r6bc/JRsCHk5+
         vykOLsqfrE9exoyXL1Pjo6lVZMKRTpjvILDHl0Z7aZIS6iTW0adQ50oVIu0W7et/BL
         x4JbihWyLstsQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E6240C05FCF; Sun,  2 Jan 2022 09:33:51 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sun, 02 Jan 2022 09:33:48 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pverda@ziggo.nl
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-NLZEr0CwP0@https.bugzilla.kernel.org/>
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

--- Comment #216 from pverda@ziggo.nl ---
Hans de Goede: I have done some testing. If I use the current module the we=
ll
known errors are produced in both ways. That is with and without the module
options. If I use the modified btusb module with all the quirks except the
Barrot quirk the dongle functions without any error if the module options a=
re
there. If I use it without the module options I can't connect to the dongle=
. I
also have lots of command timeout errors in my log file.=20
Swyter: I do not have the full kernel source tree on my system. I only have=
 the
kernel-devel package and this is limited in its capabilities. About the don=
gle:
The dongle is a rectangular one with the print "CSR 4.0" on it. I bought it=
 a
couple of years ago on aliexpress. It has the peculiarity that is support a=
ptx.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
