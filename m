Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DAFC636D3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 03:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjAaDBL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 22:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjAaDBI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 22:01:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E7230E93
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 19:01:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A169D61231
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 03:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03BB2C4339B
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 03:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675134061;
        bh=ny8mZX1Y+pKD1XkQj9BnD1b7kccInMmgLJ9+o7nOC9k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qwiyHcZElONBdVUYrhQ9pHmMws19D9LdNYmevD0xaQ30W2JCKnV7uUOFRwtuH9zwT
         QBkjMpTWupHLBkNCmS0hWD/vMQrvAPKQ6VW4+WsoI93gD3NwlcLdepIFS/FEN0Lt2L
         GSy7J7PrKw9heu7WI71SCZ8KdwjwZIezyH7RH/uMm89ciP0yN9HUXwDPqem2nw9R1l
         KEwU+FLliTDxoQfn6/aEmXph2a/3mw/+AjZxwUY3yKoHZOChPNFKMwAjY0zTlsrGmH
         azQs3+TF9PURIaGvpbTT/4Jtc8gSLpICwOek6CUyPwD5wfPbYiV15eTuXtBuZDXBe6
         p7QwL5mHoB3vQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E077DC43143; Tue, 31 Jan 2023 03:01:00 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216936] First attempt to upload firmware for Intel Bluetooth
 fails (a timing issue?)
Date:   Tue, 31 Jan 2023 03:01:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216936-62941-dpDO2zW8B4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216936-62941@https.bugzilla.kernel.org/>
References: <bug-216936-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216936

--- Comment #5 from Artem S. Tashkinov (aros@gmx.com) ---
This seemingly happens only after rebooting from Windows 10. It does not ha=
ppen
when cold booting.

I guess if the firmware is already uploaded, then there's an error.

Maybe it happened before, I just didn't reboot after Windows so often.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
