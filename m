Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3752C43219
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 02:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353357AbiAYCdx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jan 2022 21:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3413952AbiAYAl3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jan 2022 19:41:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF09EC05430B
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 14:27:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D1FF612FC
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 22:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8123C340E8
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 22:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643063254;
        bh=D9Hi7pFGEU+S5UtQvb7JhQlfj4sDJXppUcEVrZIqwP0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DDAfm8uAU527yR5QdmDDammI6hoekJPQdP0G/vr1uBj7IGJ16l1NTx2nbjXHma/XS
         MdFSG8PnWV5tQEP3BCgdjNUZBL0gDfsxRIehqkFD5maV7zqQb5PGQprOYetWMhENqf
         6RF/roAHZle9fExrTiz3EAWOpB3uln0n3pdoG31oFOzlr2d9fcxQSA1ADhkyu5LzmB
         NinuKiNbqSfsUdq3GEo21083Aw1sJLcldEv6tlbFE0Rt3lWzpDws4JVn5fMf7P6QwH
         Jl5mOQka5EbSdDibnCVun3mSf6UX2dyo7BqYcP4WxTXgY+57p7mDuaO4OrAL7UAHMu
         sJFSRqlDCgXFw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 9EE30CC13AF; Mon, 24 Jan 2022 22:27:34 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215528] Excessive logging from Intel Bluetooth "Bluetooth:
 hci0: sending frame failed" "hci0: urb 00000000xxxxxxxx submission failed
 (90)"
Date:   Mon, 24 Jan 2022 22:27:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215528-62941-SINxl3bOX0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215528-62941@https.bugzilla.kernel.org/>
References: <bug-215528-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215528

--- Comment #2 from Artem S. Tashkinov (aros@gmx.com) ---
This happens when I try to connect my BT headphones and then something goes
awry. Maybe 1 out of 50 attempts fail this way.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
