Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C27C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Dec 2021 10:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhL0KXB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Dec 2021 05:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbhL0KXB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Dec 2021 05:23:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AC0C06173E
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Dec 2021 02:23:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F20F0B80E52
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Dec 2021 10:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA451C36AE7
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Dec 2021 10:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640600578;
        bh=nycqIDejaYwnaHU/Xmqqai+kDGYvns+GJe6hFEsU/wU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cOdBSLQ7Fh+iOVdSadM8D31kBJCG+3ULJSRBlf7Y/LvQTcMuwsoo3UZVh0Vb4xIu1
         X+JQ2nUp4dNbmzDXB4CjkqG3rGhbhbZA2u1es4cQ8laGXFIVpoAu3XPIj7tDGi+gvT
         xKEkdWSYqI5BRZ8hE3D4OuZ3roeO7ioNuAg+GMgNW8rDm9RySIuYHOnPI8I+i0TCXE
         1f1/xiQpbIpIa/X8cqvfmkRLm3Y0e+36CDBTnMDXUdKQtClJD374LL3Vn7NouEgp0h
         jFrZt6plVOKPeUy25Rq8FcPuS4xZGh37otlb52kHJuDclcdzutFaxxN7FNeCrbfe6l
         57ARdv9vvuj1Q==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id B88EF60F9E; Mon, 27 Dec 2021 10:22:58 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215425] Intel Bluetooth: hci0: Timed out waiting for suspend
 events
Date:   Mon, 27 Dec 2021 10:22:58 +0000
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
X-Bugzilla-Changed-Fields: short_desc
Message-ID: <bug-215425-62941-rzUTH31JS0@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215425-62941@https.bugzilla.kernel.org/>
References: <bug-215425-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215425

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Summary|Bluetooth: hci0: Timed out  |Intel Bluetooth: hci0:
                   |waiting for suspend events  |Timed out waiting for
                   |                            |suspend events

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
