Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FB7C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Oct 2022 13:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiJUN6T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Oct 2022 09:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiJUN6Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Oct 2022 09:58:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBD62793EB
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 06:58:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4C8661EAD
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 13:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AACFC433B5
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Oct 2022 13:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666360692;
        bh=XH61df99vtxOnntH60dhvp3nZ+V+GXIY7yooTJeagwc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JhEPpU3cREkJsr545A1om+g+Sa3Qyy2Kh72sHrFeGSU4ro/tuFMR/n/Uvp4a5/Q3c
         GMk6Xlq27rFCKrSUyNJKEPY/4zSySM5cw22tly/yyqkLzxdbJrgbxX1eXHx+1HWHb7
         SKqLI0D9dCpdiPSpIea2DYFmzFhuIejW+Adputj/bYYDs7O9xnmVIQUrZ9NDQ9BZye
         BRPaVmxRDdYipJzMW13DZVDSBviDw1ag+Mlj7AEo6R7ixcaVB2JRR2HzXlQY6yquBK
         r+730uXoix9vmZnl5OW5PxVVxXFsF0Mci5vS4vzPYZwPJhsd33TT5L7vVw6ectYxde
         vteD2gbuT8zvA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 4126DC433E4; Fri, 21 Oct 2022 13:58:12 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216580] Jabra Elite 75t (ear buds):Unable to connect and use
 (`hci0: Opcode 0x 401 failed: -16`)
Date:   Fri, 21 Oct 2022 13:58:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-216580-62941-dOwptnnyop@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216580-62941@https.bugzilla.kernel.org/>
References: <bug-216580-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216580

Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |pmenzel+bugzilla.kernel.org
                   |                            |@molgen.mpg.de

--- Comment #5 from Paul Menzel (pmenzel+bugzilla.kernel.org@molgen.mpg.de)=
 ---
Created attachment 303066
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D303066&action=3Dedit
`sudo btmon -w /dev/shm/20221021-linux-6.1-rc1+-ge35184f32151-with-patch.lo=
g`

I tested this on a different system, Dell XPS 13 9360, with the Qualcomm
Atheros Communications QCA1x4 Bluetooth 4.0 (0cf3:e300), and Debian
sid/unstable with KDE Plasma 5.25/5.26 and *bluez* 5.65-1+b1. Please find t=
he
`btmon` output attached.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
