Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB516C04FF3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 May 2021 19:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9763D6109F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 May 2021 19:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhEXTo4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 May 2021 15:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232790AbhEXTo4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 May 2021 15:44:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9B6726140A
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 May 2021 19:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621885407;
        bh=Dng+8UXETWOpHXJllYB+T09ZTkdD7dg+f4r8aVBtais=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HjLVKHtRX8xC4M1UDsbMEsJJGGsPIfIKJPniYCUYetoUo5IvlNZQpmGpyWOZXldCT
         xIVuvPNpdPaKMX7ZrNkc5rXF6Uui5Vf7IFZNJEmIRbzNrpcIhOp3We1F5hEumcm8UQ
         WKLrkOhGGGXlTv+4fSwgwHkgnYMH2k4238sQ55jwlA0CdRZcw/lP6fly9eBomcTNlA
         bbJHezCAXNZ8kVrBjEXY76P0QA6gpzOy4XoVY53rRGT0b1UP7qzKUn2fKsYsTcEpgx
         AR3y+bebSxH7gaP+62acqdkMswuNulXAIek1uS01WPz+3wfSqgpgnh3SADRYaj9lYf
         TPDaPPw7TmydA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213203] KASAN: null-ptr-deref in range
 [0x0000000000000000-0x0000000000000007] when ASUS USB-BT500 bluetooth dongle
 is connected
Date:   Mon, 24 May 2021 19:43:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erhard_f@mailbox.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-213203-62941-2HMi9bCJHF@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213203-62941@https.bugzilla.kernel.org/>
References: <bug-213203-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213203

--- Comment #1 from Erhard F. (erhard_f@mailbox.org) ---
Created attachment 296973
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D296973&action=3Dedit
kernel .config (5.13-rc3, AMD A10 PRO-7800B)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
