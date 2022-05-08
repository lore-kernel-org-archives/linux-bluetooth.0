Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13125C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  8 May 2022 19:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbiEHT0r (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 8 May 2022 15:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiEHT03 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 8 May 2022 15:26:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6729913CD4
        for <linux-bluetooth@vger.kernel.org>; Sun,  8 May 2022 12:15:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19C50B80EA2
        for <linux-bluetooth@vger.kernel.org>; Sun,  8 May 2022 19:15:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B95FDC385A4
        for <linux-bluetooth@vger.kernel.org>; Sun,  8 May 2022 19:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652037302;
        bh=R2ehK08qzj7wb1+KNvz8NGn9TUvCecosWM6lI/mR2RE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Y9nwyj7MzVUfOezUfES+ICrs/ObaJ/XgmhuOTnvfA96ltg0fP1yz0XbHm7sFfx6co
         e6INdiGtlfXS8LxzNu2Hz8jdzlWvusUW/Yj/jR0k1RSgVv0msxOxJOPFXzizakwgu6
         yCUO1EbMnFLn+bwwnc5r9KtLNpFDgNxvnPm9Jk/QYbiP8QQCzqGHBx8Vdx1untmJH/
         kjjkC7TpNj+4UQ9BR8xq2+hiYAOsUB8DgzWG01YKcroI0Dw1y98mS5dxepcgvzvCFe
         MGD8uXaKhe3b8HIVuxabn0T7Tdhp4g4gPLB2gKlLXt7UTs63Gah7as5XOGWXtyhWpt
         aRyZDIflYjLiQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A4353CC13AF; Sun,  8 May 2022 19:15:02 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215189] hci0: unexpected event for opcode 0xfc2f
Date:   Sun, 08 May 2022 19:15:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: shwoseph@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215189-62941-naMJGkqQu1@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215189-62941@https.bugzilla.kernel.org/>
References: <bug-215189-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215189

shwoseph@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |shwoseph@gmail.com

--- Comment #2 from shwoseph@gmail.com ---
I am suffering from this issue as well. It wouldn=E2=80=99t be so bad excep=
t that the
message gets printed out to tty1 and messes up my login console on wake from
sleep.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
