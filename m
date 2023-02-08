Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213C4C636CC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Feb 2023 15:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjBHPbE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Feb 2023 10:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjBHPbC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Feb 2023 10:31:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334972B288
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Feb 2023 07:31:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4D3EB81E65
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Feb 2023 15:31:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7ED47C4339C
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Feb 2023 15:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675870259;
        bh=8l5o0Yk8If96eHpGrdZ8rC8RoydzvmwhhXlNMPazZv4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=d/TJ9e4ACLXSddF3UgUa3X9NEbuGR4behuJ7UyWVJm0KEHnVSQYq7c2anetYMO9Zl
         E7hviOTPQb6kVtBTojBhM2JasifHo4b10L64FqSPEllnLyrviCSQEzMx0f9R98CdHp
         HQKZXRybyK6TWonqObsL9wBXx4JKzqEw+VDR9WjoVn+G20qb+DsA/NGJY94ZFPtDWu
         Ke9U+Gdl7IQ8k2/RIWxGp8tIKcCL+RkrQofKWsYI8wgTTKajp7tS2REaYlXQz9Osjk
         BS/ryOkjSxZASAHVWP/I9HaQFeSrrBJoYKSAw3r/7dKr/U3IaEPgGkbNzS9fQC75Ao
         xHsOjd5oZs19w==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 715D2C43142; Wed,  8 Feb 2023 15:30:59 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Wed, 08 Feb 2023 15:30:55 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jhonatan@justin.com.br
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-FJj0Om4jKT@https.bugzilla.kernel.org/>
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

jhonatan@justin.com.br changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jhonatan@justin.com.br

--- Comment #266 from jhonatan@justin.com.br ---
Having precisely the same issue as mentioned in previous commment by
guimarcalsilva@gmail.com

logs:

> Feb 08 12:25:27 jho kernel: Bluetooth: hci0: CSR: Couldn't suspend the de=
vice
> for our Barrot 8041a02 receive-issue workaround
> Feb 08 12:25:27 jho kernel: Bluetooth: hci0: HCI Delete Stored Link Key
> command is advertised, but not supported.
> Feb 08 12:25:27 jho kernel: Bluetooth: hci0: HCI Read Default Erroneous D=
ata
> Reporting command is advertised, but not supported.
> Feb 08 12:25:27 jho kernel: Bluetooth: hci0: HCI Set Event Filter command=
 not
> supported.
> Feb 08 12:25:29 jho kernel: Bluetooth: hci0: Opcode 0x c03 failed: -110

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
