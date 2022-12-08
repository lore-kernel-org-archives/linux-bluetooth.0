Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB86C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Dec 2022 22:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiLHWfY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Dec 2022 17:35:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiLHWfW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Dec 2022 17:35:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CD415FFC
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 14:35:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2399B8264D
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 22:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CBE1C433D2
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Dec 2022 22:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670538919;
        bh=DYdCIv7gIDd7vGLDzyYdyHy/dwkJV6pWcmLprqP6Ah4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=M54L3aNyyTs1kWnetZvfUFberaBdgB7tSpLthZCNBOGSTeqycSLHU2rPNxHnjt4/b
         +6R+aa0FfXzppnpsLbScrixJQxoKwHnZ0hHwjObiiOMKvj133WhBAif/xH/cdpd++O
         CO7hvkwf+o4fyN1tq/j8gFabsu9KhK3Cf+kkAsoAC9nBtV8viTeP0ZMH44BzgYpRZe
         Pb9puTbgW3nmaPgW/nZY1OFbd0kreMMZFud3CwJ86GwFrsrMy/yjh2NKXJIsP6te8x
         JTWCiUM9aKgsLt6iHI+l/WVV4ri2MBq/qPLUDajehCyqiJZF1iKix5eccwWLM/BPhP
         0RYvz3CpuPjIA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 31DB9C43144; Thu,  8 Dec 2022 22:35:19 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216792] bluetoothd: src/adapter.c:set_device_privacy_complete()
 Set device flags return status: Invalid Parameters
Date:   Thu, 08 Dec 2022 22:35:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla.kernel.org@e3q.eu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216792-62941-E5TDbybfRm@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216792-62941@https.bugzilla.kernel.org/>
References: <bug-216792-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216792

--- Comment #2 from Erik Quaeghebeur (bugzilla.kernel.org@e3q.eu) ---
(In reply to Luiz Von Dentz from comment #1)
> What bluetoothd version is that? [=E2=80=A6]

bluez-5.65

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
