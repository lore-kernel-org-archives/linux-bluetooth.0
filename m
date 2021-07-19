Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D74C636C9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jul 2021 06:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A16861182
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jul 2021 06:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbhGSHBd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jul 2021 03:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233689AbhGSHBc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jul 2021 03:01:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 4EAFE611AB
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jul 2021 06:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626677913;
        bh=nFLchTQj0+GsVDAplbMwwVaPbu1Kro9Nv7ZTWqQG8WE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=eb+Tr20Gh84mp+Jwmwqu5wcxgwu9Nc49rz1rqAcydY4MWjgzJBAXPJARkeH7DrG6/
         tIw7IT+KJ/EyInpxKSWmldLbSZmUvI4lakxkCHtV1yzegebvBaBvufZbC4S3ZT0jM1
         uXV+enlrjD3RntjoBpK9Aw9FXWtwcHDqIt8M3KlZ/Q0RLuCWViIkXvFpzmIUu6yUeu
         8kaMeCo4JrEQxUiN221smrDIRybJ+npz8/EG3ri2o5ZJNCVa1YyeCv4k0crlnKoz9u
         Ym2dd10MG2HdutjSksSd9lne/JV19/ROElwmbxw/c9hxULVASPFtwXL/JWJnon9xZJ
         fzO+Hbd984obA==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 86931] hid-generic 0005:099A:0500.0001: unknown main item tag
 0x0
Date:   Mon, 19 Jul 2021 06:58:32 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: hurikhan77+bko@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-86931-62941-vSRpnrQCgI@https.bugzilla.kernel.org/>
In-Reply-To: <bug-86931-62941@https.bugzilla.kernel.org/>
References: <bug-86931-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D86931

Kai Krakow (hurikhan77+bko@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hurikhan77+bko@gmail.com

--- Comment #10 from Kai Krakow (hurikhan77+bko@gmail.com) ---
"unknown main tag item 0x0" comes from the HID layer, it has nothing to do =
with
Bluetooth or connection stability. It's usually a stray NUL character at the
end of the HID descriptor which the kernel safely ignores but still logs. I=
n my
own driver development (xpadneo), I just shorten the HID descriptor by one =
byte
if it ends with NUL because the devices I work with are known to NUL-termin=
ate
their HID descriptors.

Maybe the kernel should do the same: If the last HID descriptor byte is a
NUL-byte, it should simply shorten the HID descriptor by one byte, essentia=
lly
cutting the offending byte off, and the message would be gone. Other than a=
 log
message, it has no consequences in the kernel, it comes from a completely
different layer that's not related to Bluetooth at all.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
