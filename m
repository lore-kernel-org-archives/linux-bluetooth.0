Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7EBC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 29 Oct 2022 20:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiJ2UkF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 29 Oct 2022 16:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJ2UkC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 29 Oct 2022 16:40:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCA813D09
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 13:39:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7195C60CEF
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 20:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4667C43144
        for <linux-bluetooth@vger.kernel.org>; Sat, 29 Oct 2022 20:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667075998;
        bh=0CwTsrUjHapBnaF5K+4YXwxU+tVxirEHgNnXcST80kc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=UwH2Gi0fCNt/gTFpVI5uPcOCiIy/2Hz6F8MzdPSAGRg99GfDt5eJjsx3Z3qk7r4K7
         RXvPLXYMywuMndtRBBCisfYufz4GIX+ScpEJ/JvtLwDuGOmseTbrAGz0jxe/tsq/Oc
         VAihIKavz9ZJh+J0BbL1UFJubU/alJ38aGAL+SPjfcVtKbBelZvrQdc896P0JXarBL
         ntcXUNQxzb0cF85Su22drptuUkyZ4fXQctXPSu3k2GBjr8Ce7csp/FAMIwLpXgwttc
         tK1ZuSyZGLylDLvdp770liVjgRc3BwEPWo/WF6u8KMPNJoM8Wx4ZaG3IpSN+xTB69W
         +aOKnd3J2OwtQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C6A77C433E9; Sat, 29 Oct 2022 20:39:58 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 29 Oct 2022 20:39:56 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: swyterzone@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-Scpfio3AuR@https.bugzilla.kernel.org/>
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

--- Comment #243 from Swyter (swyterzone@gmail.com) ---
Submitted a patch series trying to re-fix this re-mess. We'll see:
https://patchwork.kernel.org/project/bluetooth/list/?series=3D690177

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
