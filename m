Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E668EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Sep 2022 09:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiI3Jwo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Sep 2022 05:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiI3Jwn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Sep 2022 05:52:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAAF12888B
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 02:52:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 26CD2CE248F
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 09:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9165FC433D6
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Sep 2022 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664531557;
        bh=CYXbm+DVDwOQIbwUQmHjVRi/ZOtlrKsbJXffKvffAmk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=uadkfhxyKwV5GxGercQLmrj2maJWrDGikPa1y7lUoAkUiocDvtqrDHoCwI8j6ddsE
         HQH5x2CVs5rj3W2b0rSqsjZSlDjFB7R3dRPx1Bg6VxocmyvbROtkR1E62owGIrpeNu
         +PczhXMvbTLNfI6KKhb61WAD54tiD6N+u+3wE/jn/I/Ji5T0H3LqL15xVNozAi3qyD
         rC92S447cSxz1c8Di546jyImV2B165NqqtzElOKI4PfXOYStQGIWSbz6qDizoXgPr+
         qefD0LgtuONLA4e5xKGT1qh2mF80v0/SnVtMFBv+PkCVyZgASK2Bav3aSaCToqKSQ1
         Gen5SB7CLtWzQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 73B98C433E4; Fri, 30 Sep 2022 09:52:37 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216532] openSUSE Tumbleweed, AX210, bluetooth, connection fails
Date:   Fri, 30 Sep 2022 09:52:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: epistemepromeneur@free.fr
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216532-62941-HW1JkTyZA7@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216532-62941@https.bugzilla.kernel.org/>
References: <bug-216532-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216532

--- Comment #3 from epistemepromeneur@free.fr ---
What don't you understand in this following procedure ?

At the PC, after pairing, disconnect the smartphone.
Wait 5 minutes or more
At the PC, connect the smartphone. Connection fails.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
