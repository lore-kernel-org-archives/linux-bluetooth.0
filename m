Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F1CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Dec 2021 18:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbhLGSZ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 13:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240453AbhLGSZV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 13:25:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8DAC061756
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 10:21:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FB29B81DD0
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 18:21:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D66B3C341CA
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 18:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638901305;
        bh=iCyJXtMn+2ZqZJXG+l/wQH1bV8iKDPCovVVJlYJ8EIY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CSwzGReR2434TS5/3gimPGhBu89lTuE08ICbTANw3MFrrWMCcU5GBt91/BFORNmOi
         3kpZwxf70JHCipOcdd6teQ3v7EYv5Z6USV3f6kP/c+XDl4q56q3sIcQb+roxCZLIqd
         /K0ZmvbTCtJCGzaRPBMiNTVlIiGy99MZcFgDIiZUCNriKcdSqbOblivQjfO73Ow+xA
         BJetqfujCQh57V5ogm+MI5z21Mqo+1fYP+gnOwFvBuquePg1YMdB4c/aWc4GppwTQz
         o2Vh/ESSav+EOB5cEKvay+ifC4i36s8hUTLap+U1Kr9hG7H4/SR2Cq0Cn/+1wiXYKh
         I44B3IG9qwPmQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id B7C8F60F8F; Tue,  7 Dec 2021 18:21:45 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210141] Bluetooth device driven by rtw_8822ce is lost after
 suspend to RAM
Date:   Tue, 07 Dec 2021 18:21:45 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: stiltskin@ymail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-210141-62941-PsyOVhR7Cw@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210141-62941@https.bugzilla.kernel.org/>
References: <bug-210141-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D210141

stimucou12 (stiltskin@ymail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |stiltskin@ymail.com

--- Comment #4 from stimucou12 (stiltskin@ymail.com) ---
The problem vanished away for me on HP Laptop 17-by0xxx running ubuntu 20.04
with kernel 5.4.0-91-generic and RTL8821CE using rtl8821ce-dkms
5.5.2.1-0ubuntu4~20.04.4

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
