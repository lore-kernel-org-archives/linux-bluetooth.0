Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0FAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Dec 2021 12:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhLKMjS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Dec 2021 07:39:18 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57116 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhLKMjS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Dec 2021 07:39:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56C23B80108
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Dec 2021 12:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11764C341CC
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Dec 2021 12:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639226356;
        bh=gB1RTof0RmpyxOK2cfNUdcPbqe4/Ya0DGT4kjBtxZDs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=S4yLPfPf4uncRisLxtdzxAH+nDMY5Y+oQIM01tpHcRyX55xtth8OvAnUoQ8oeqgHe
         O7+6tpG+HHjI1B6rsnIGKJODp3o2nSBuj58OLNZFCN/biwKWKzkGSjavyG9oWI6tVM
         VZuo1YtHw7HqffeiWrMU8MJtvDC12THhLuqHSgZeahM+got5YkTKFraOCPTJ0gezv8
         yAG8+jb8zUeAcHV7NNlpSCXlluW++lvTkO8MB56j14dYF8lkiwdMr0NejcYJTcaY4q
         lQubdDn3hbHaEpfMM2XVgS7jT9O2IMODIPmd4hquRoBXwTBOWEnyTqGCQTLvkjgDeJ
         TN31rpcPG+g8w==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id EE10861101; Sat, 11 Dec 2021 12:39:15 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Sat, 11 Dec 2021 12:39:15 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: erik@rigtorp.se
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-RE2gKJRQQl@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215167-62941@https.bugzilla.kernel.org/>
References: <bug-215167-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215167

--- Comment #17 from Erik Rigtorp (erik@rigtorp.se) ---
(In reply to Takashi Iwai from comment #16)
> When you add the BTUSB_INTEL_BROKEN_INITIAL_NCMD flag for your device
> (8087:0aa7) in the blacklist_table[] in btusb.c as in comment 13, does it
> fix the problem?

Yes, running 5.15.16 tag from linux stable repo with this patch on top fixes
the issue:
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 79d0db542da3..0ed04061823b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -368,7 +368,8 @@ static const struct usb_device_id blacklist_table[] =3D=
 {
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
BTUSB_INTEL_BROKEN_INITIAL_NCMD },
        { USB_DEVICE(0x8087, 0x0a2a), .driver_info =3D BTUSB_INTEL_COMBINED=
 },
        { USB_DEVICE(0x8087, 0x0a2b), .driver_info =3D BTUSB_INTEL_COMBINED=
 },
-       { USB_DEVICE(0x8087, 0x0aa7), .driver_info =3D BTUSB_INTEL_COMBINED=
 },
+       { USB_DEVICE(0x8087, 0x0aa7), .driver_info =3D BTUSB_INTEL_COMBINED=
 |
+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
BTUSB_INTEL_BROKEN_INITIAL_NCMD},
        { USB_DEVICE(0x8087, 0x0aaa), .driver_info =3D BTUSB_INTEL_COMBINED=
 },

        /* Other Intel Bluetooth devices */

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
