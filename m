Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060F1C83F2C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 16:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349578AbjIEQWF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354178AbjIEKGV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 06:06:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 101F51B4
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 03:06:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 32CEDCE10D3
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 614F0C43397
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693908372;
        bh=1TiGkJDXMotFg3DhVzFfC8LAyk2/Rd3RXobMG5Qp2GM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gb/ycb+PTGfiCjXFQdYru68PLPDKEZS6Kd2I6casakBphakCKWW8WI+SxpjWbFe6v
         JfVu/HVslvgv5Z+z1ybibXsHLT3IGcxyvAsXbkYPHtO7Ebk+QUFiKRkoyiBGUOZh9J
         MjUYyi7WGQ8LgYnkRpWB+Ql8Ia7vmBuUXAZgbX7PgnfXJl1SfL8aDH6lg/ATMwKbzK
         AGx1ZzadKeB2whyNMxfIVJmQLdQBTV24OoVsf1qqGUgUlaBShJYlb2DdGdbO6JEG0b
         qjaBMBsnAkwiIvb8wGnmGvspLcFwC4HVctvq+5amW8EFAGXyKrXawtBOxkbxJXC3nu
         npsWQV1j37oww==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4F9E4C53BD4; Tue,  5 Sep 2023 10:06:12 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] Lot of "hci0 sco packet for unknown connection handle"
Date:   Tue, 05 Sep 2023 10:06:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-80791-62941-DHpm0IRP5r@https.bugzilla.kernel.org/>
In-Reply-To: <bug-80791-62941@https.bugzilla.kernel.org/>
References: <bug-80791-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D80791

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |caravena@gmail.com

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
*** Bug 85161 has been marked as a duplicate of this bug. ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
