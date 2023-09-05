Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF624C83F2C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 16:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbjIEQWu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354179AbjIEKGb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Sep 2023 06:06:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016FB90
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 03:06:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5A150CE10C5
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:06:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DA45C433C8
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 10:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693908384;
        bh=ZVqX3V5yPUXoMIiLoRiLFts2S/qvmUbQpDBv8jCbh7Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aEXhAYhVLBKHoQZ53Nh6sIW4rb0zSzGcK1Ompchj8vyiUShmN9h/dr39581wtuiRG
         lF+Dw5Su4R1XOGLMpx9s1ANk4hcCgQ1b2Ewe+SDVRWnjXI0A8ouYyB5a4+MMi+iOD0
         7kPb+LLpmeatgZaRJoI9xhtm8zRZLEDtEIgqAYePYPIH5RMyjMP8MMZskGB2x9Q3q+
         dQ7fs3b07c0Zoz1Y4Bw+IyOcWuNHVX5BmQY/dBZjnM/tuht/KN00j/K3ZVqUd3vTqK
         pV1oQh0iGR99aIvV8+6kNQFxGd5Y5SeclVTpy0XDnJ7J3O5bIIsirw9dH1BFTkb3zE
         jj06rk8QHX4BQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 8ECB7C53BCD; Tue,  5 Sep 2023 10:06:24 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 90151] Bluetooth: hci0 SCO packet for unknown connection handle
 38
Date:   Tue, 05 Sep 2023 10:06:24 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: DUPLICATE
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status resolution
Message-ID: <bug-90151-62941-tJsf9ncn2e@https.bugzilla.kernel.org/>
In-Reply-To: <bug-90151-62941@https.bugzilla.kernel.org/>
References: <bug-90151-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D90151

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
         Resolution|---                         |DUPLICATE

--- Comment #4 from Artem S. Tashkinov (aros@gmx.com) ---


*** This bug has been marked as a duplicate of bug 80791 ***

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
