Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E0E3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Mar 2022 00:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234339AbiCVAhT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Mar 2022 20:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbiCVAhS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Mar 2022 20:37:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCAE3FBCF
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 17:35:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53B50B81AE0
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 00:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EDEF6C340EE
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Mar 2022 00:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647909350;
        bh=Qf12Up51zajCWox88gIU4+FUf26CNMkCJ4Q+sOdhM/U=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LQQ+QjMfOSF2IcceSb/GrFkf9cq/eBjpUOggtuUdyl/IfU4JJvSwYP6l3B2Aku8VO
         ZBHEbl0pgm/WjZtW3YaP0w7vmnLep29C0KB7wc31ByaEh1l5lRPcDehICjirAA0/d0
         78OM9P9peWO7eVIM+ae/W+CoIjJKRS/ZLRertGEJT48/aR0/snCnDZn/vKZ4q7JUmh
         kuFc+myyUJ/5Dhv7pYIwsJKjt6N9b2pDTpuCyaGUqGsXEo/cVZZF7HykxEeqH3B5bb
         rCtxqf8l7gRYguqv2PYDxlK+OWe72JG+JuwaoPPF3a9RNQI453CHM4JNe9+h6ZkPpO
         0dXcohHn7iJ6Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id D2CF8C05F98; Tue, 22 Mar 2022 00:35:49 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215713] New (useless?) warning messages from BlueTooth in
 kernel 5.17
Date:   Tue, 22 Mar 2022 00:35:49 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: low
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215713-62941-Ekzb3eCFQ2@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215713-62941@https.bugzilla.kernel.org/>
References: <bug-215713-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215713

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #1 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/net/bluetooth/hci_event.c?id=3D314d8cd2787418c5ac6b02035c344644f47=
b292b

It haven't made to 5.17 though but it is already fixed in bluetooth-next.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
