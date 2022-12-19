Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDB8C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Dec 2022 21:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiLSVKV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Dec 2022 16:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiLSVKU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Dec 2022 16:10:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2647811C0F
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 13:10:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D09D0B80E42
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 21:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 56793C433F1
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Dec 2022 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671484216;
        bh=/e3uForzy3m6O0WwSjw6HNAz9AUw5ZCQdFlH8guC/y8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Gh4mevzOMhyj5ge2kIsP4TnLSxmmHkeFZT3QTF3EGTAwrOdepNCioMreHBRVql/SV
         cld2hkhAbZKi2itWvSMjJU4hPVAydD3zsoYNeRgy488BGspLqnwXYhCLNdYgusdBrS
         8UhLVzh930JCEi4nUm+tD6HgMffp1BmVd5gOl66oiuK847VVBBZ56kV9NyrfpzipZJ
         XBfpTpeUkOnS4luF/KL0RGj+wmYCdf0VfWClhEe2mar6r1O26ujdd9m1wI9/EVwINB
         H14wE1u0L0IbgTqJWQzWXh1zRhmHru91ipCtOuRdMCrZaCksL/ENLL+Ru1rPN59kEM
         jIz8uVLHmYPtw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3A806C43143; Mon, 19 Dec 2022 21:10:16 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 216817] btusb device with ID 0489:e0d0 no longer working after
 v6.0
Date:   Mon, 19 Dec 2022 21:10:16 +0000
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
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-216817-62941-DWPzypSwyv@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216817-62941@https.bugzilla.kernel.org/>
References: <bug-216817-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D216817

--- Comment #5 from Luiz Von Dentz (luiz.dentz@gmail.com) ---
(In reply to Andrew M from comment #3)
> Unfortunately it sill fails with 6.1 from Arch testing and a latest git p=
ull
> (6.1.r13139.gf9ff5644bcc0) which both include that change.

Can you try with the following patch:

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5220bfd75b00..b3676b899647 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3572,7 +3572,7 @@ static const struct hci_init_stage hci_init2[] =3D {
 static int hci_le_read_buffer_size_sync(struct hci_dev *hdev)
 {
        /* Use Read LE Buffer Size V2 if supported */
-       if (hdev->commands[41] & 0x20)
+       if (iso_capable(hdev) && hdev->commands[41] & 0x20)
                return __hci_cmd_sync_status(hdev,
                                             HCI_OP_LE_READ_BUFFER_SIZE_V2,
                                             0, NULL, HCI_CMD_TIMEOUT);

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
