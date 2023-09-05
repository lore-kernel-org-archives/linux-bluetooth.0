Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1183DCA0FFE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Sep 2023 16:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbjIEQWq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Sep 2023 12:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343981AbjIEDJ3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Sep 2023 23:09:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 583B6CC6
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Sep 2023 20:09:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AC8A8B80DB0
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 03:09:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5ADB7C433C7
        for <linux-bluetooth@vger.kernel.org>; Tue,  5 Sep 2023 03:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693883363;
        bh=f/BhjgDPZdA7li+4CRomGleUFCGMgrhtLqQzbJw0ChQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cgOFXORF/KeUZHqb/8wMUT2H0uJEoXYHeLv+0G6zocbqchlrGlhYrBmwHHk69SkYH
         u1mH8ioaEnvbuxqcK7wkBv0Xig7MUn229n4Nm07R2MDEY+TsaImQqY0/kn7e8nAPfV
         2Dy5j8Q3xPyidnAVEQ5HF3/rnFILnUarU3QtcOIjcBorYUlVNOlJVRDtlUT70eWECb
         CasVAwKsZvN4u+2Vr/KE+Mfd5OwzbO9d/5LDH0euGt1NAO+OB1rnNyYKa3WNJhseFu
         RNbRjVgH9SXpd9F0LfU7y4MBimqOCobZzBYdeAdWFd9M6ZVKeDPjPUu4T868qwt+hA
         Enak8l6Safi3g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4B879C4332E; Tue,  5 Sep 2023 03:09:23 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217870] ATS2851 chipset for Baseus BA07 Bluetooth does not
 connect, no bluetooth device connects, adapter does not turn on
Date:   Tue, 05 Sep 2023 03:09:23 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: mg-tatangelo@hotmail.com.br
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cf_kernel_version
Message-ID: <bug-217870-62941-pilEKhCfx7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217870-62941@https.bugzilla.kernel.org/>
References: <bug-217870-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217870

mg-tatangelo@hotmail.com.br (mg-tatangelo@hotmail.com.br) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
     Kernel Version|                            |5.16

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
