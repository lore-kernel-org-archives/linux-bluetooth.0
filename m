Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43458C4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 18:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2441D610FD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 18:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhHBS5z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 14:57:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229899AbhHBS5y (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 14:57:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 37A806100A
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Aug 2021 18:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627930665;
        bh=vQTR6R2ua1D2QiUAtKOvbTureHcgILoTzRBmxQpML1I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jtR7v4BEoo8Mo9J+igFnbUCzgdGjzEeKl+xB9amf/1BvixDT5GZcqnrzfY2gxPHYa
         qPyCNAyGWtdTmpsLfS/zaDVjt1G2tYlao244hznbMwmo1WW62kcPEDjk/evhfKvtU6
         xKv8j29z/i4P4wz1iEhrJqFvV+6RmIf+K8nILRrYx54jP49fAQOKD6UXiv76EpLlp5
         +qaEZhb9W8/f7OdYXBXs59OeRffjodU61rNHl1K8QFPL6OliE9MwQ4JP+bp/m0/Pxs
         YOfLEIu5kEHsitEmx7vbO/Jzae39ZsyB8CtsBOt9QxfbBWUPz7/vriR1ICrCC4A+SS
         OyVJdo/IXlpAw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213369] Bluetooth Will Not Enable Intel AX200
Date:   Mon, 02 Aug 2021 18:57:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: luiz.dentz@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-213369-62941-IN93IAwpAY@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213369-62941@https.bugzilla.kernel.org/>
References: <bug-213369-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213369

Luiz Von Dentz (luiz.dentz@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |luiz.dentz@gmail.com

--- Comment #2 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
Does dmesg show any errors? Looks like the controller could not be configur=
ed
for some reason.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
