Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D38C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 10:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344622AbiAYKpE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 05:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352945AbiAYKmo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 05:42:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E933EC061749
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 02:42:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85E426167A
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 10:42:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4D78C340E9
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 10:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643107362;
        bh=XLhZ38PxhCcek73EhxdzMcKzBkoM7CpYdhmj+ifwh30=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nlTssB511VDvvuw+3tPZXLa/qSUIaZTTZvwaVeC3Somz3pbpd+z7tXQn10eEOHIaK
         5mMSeepTuTxaK+otVA03HUT1/C3DWYzWBsaaKHs1/7IKsjLWu1TDbNhSyIizzcb0m8
         7JW8zGigPYiiEaqOfQQL4WR0AJbabzueci85/YFCJO8j/I9bVZTmLrs+ZXZsI1v+Uj
         SeRCTUTgjd+dimJAhhHLNTtHweAJlcej7m1qwPSQEIJIGY030qMMAIKyfNETM6TVwn
         n4r4at4ODAWo4eXeiv856PQKg3ybXTOfPo+VgcpTVYYVrOB7sC/FVHZSJ5YEKO3SFC
         jlpC0h04sTbjQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C90F6CC13B1; Tue, 25 Jan 2022 10:42:42 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215528] Excessive logging from Intel Bluetooth "Bluetooth:
 hci0: sending frame failed" "hci0: urb 00000000xxxxxxxx submission failed
 (90)"
Date:   Tue, 25 Jan 2022 10:42:42 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-215528-62941-78FbSpcuil@https.bugzilla.kernel.org/>
In-Reply-To: <bug-215528-62941@https.bugzilla.kernel.org/>
References: <bug-215528-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D215528

--- Comment #7 from Artem S. Tashkinov (aros@gmx.com) ---
Created attachment 300317
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300317&action=3Dedit
dmesg

Had to reboot to revive the BT stack otherwise despite it working I continu=
ed
to receive hundreds of messages per second.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
