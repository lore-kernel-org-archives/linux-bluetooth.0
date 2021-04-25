Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485F5C433B4
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Apr 2021 07:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8E06144A
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Apr 2021 07:44:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhDYHpJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Apr 2021 03:45:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhDYHpI (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Apr 2021 03:45:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4134461480
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Apr 2021 07:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619336669;
        bh=IChURzcTulKuRU/UHaJnyiiO3kWzsNBMb28RAsJMx7k=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HxqAIF20jH4KLLl+m6bFOKyPyZJtLFlu00f8SW7DYf+qIqQ+wuPhpY4GOUFKachA9
         7fi5A5RgG0QrnOlTOm4uWNmOn9tkci+fi18Q7XhoFXchAa1g0CEm51nO2+20vkeD0A
         qr5ZXXXfCTy8Jqj+hEpYMW2W9eSow/dHpP2i8BsSV7nZihmhhOTmLN+CLMqkAhT+85
         Mz3PQnsgJH39wv9plbRJ5MLhTmojZMT3CalJ1azH0OIBX4aWO0bdTPdzUNH0ue+ug4
         /1MTpZlaDd94R4DymJ8AUfka9+kaP2nrEYQGrk9IeNzYJNnwlSdaWGXm4X7xPmU5SL
         SfQ/a+6zY3adA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 211983] BUG: Unable to toggle bluetooth ON once switched off
 using rfkill
Date:   Sun, 25 Apr 2021 07:44:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: juliusvonkohout@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-211983-62941-qysbQky6I5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-211983-62941@https.bugzilla.kernel.org/>
References: <bug-211983-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D211983

--- Comment #3 from juliusvonkohout@gmail.com ---
There seem to be Fedora downstream bugs
https://bugzilla.redhat.com/show_bug.cgi?id=3D1944482

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
