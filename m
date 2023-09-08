Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7612DEE57EB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 10:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjIHKcX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 06:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbjIHKcW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 06:32:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836A41FD5
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 03:32:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9E03C433B9
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 10:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694168661;
        bh=JWnWBsdifNRif1vmQqZujH8lYGIQeLDirNv6Of428/k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=bZfGNxGzyHJtk6c9XUFoMRlQLFlhrQZJGSIIF0FT12U/ViXnaUevLrLPbZbwd/dCt
         jVyrz7YlRbs/i6XXTS5RRDXvtEPD01UcmsLRfurXDT2ZjTvt4vg8nfbtj7X0yhLlVv
         JnshUu/364B8J2omvdVLE67OmA/96AQjS6Zb9JnH0ly7GnvuaXJqYeimzMRD7DVz3w
         A7aWbyTu36yuO6cEiF/lOsV9iqBxJusMwppWDDkmg96DUFUafDL5WRaI07fBC/+qas
         CXLNzY7dJ3VGo6qH1F9dsjjjyP4oMeoXYoa8QVVjrSRmkHHkvb0zsTxWa4bSRtmxPK
         w4+zI+C02+exA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id CA0C3C53BD0; Fri,  8 Sep 2023 10:24:20 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] "Bluetooth: hci0: ACL packet for unknown connection
 handle" must be hidden behind "debug"
Date:   Fri, 08 Sep 2023 10:24:20 +0000
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
Message-ID: <bug-80791-62941-jTCn2Nx10b@https.bugzilla.kernel.org/>
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
                 CC|                            |luiz.dentz@gmail.com

--- Comment #6 from Artem S. Tashkinov (aros@gmx.com) ---
Luiz,

Could you look into this please?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
