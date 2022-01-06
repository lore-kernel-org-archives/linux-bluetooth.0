Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C87C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 12:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiAFM6T (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 07:58:19 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58958 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239070AbiAFM6S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 07:58:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 946E061BCB
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jan 2022 12:58:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08BA4C36B03
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jan 2022 12:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641473898;
        bh=FyCNOXCh9osaHFPmQJW+oYGzFA5o9HbkGXCCjI9ohHo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Vk6YnphWYc0+r1NcHrvgMFPh7d8jwdBiuwc/E+n7aX2nvAzLv5rcQjGbJpm8nt04X
         zE54CUteq8IB/z/SQ61yV0umXGddmWF6t4BvXT8YyJNMm8PLQab8mMlrKF4lpPqg9z
         ObpXt6Bvmwq1lXrkWuMI/ynT7xaR9iHTy0Q4npXYTEhTS8ILX6UkgRQdNGHsFhL/wl
         6D6D5MgYTXGEkJua99PvmDy2hrB67nAoe51UIzXJVnZrBe0LPJOzh5619Lld8eKCeY
         R/FLhLuzrC+raw+BN62p7L3wmHTFKGey6EDtahhktdzrTLyGlYLoDU0C97RX0+vBaE
         c9QhSbTcgpjQQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id EC93FC05FDF; Thu,  6 Jan 2022 12:58:17 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 213829] Intel AX210 Bluetooth controller doesn't start from
 warm boot
Date:   Thu, 06 Jan 2022 12:58:16 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: barz621@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-213829-62941-D4VdCZB5hO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-213829-62941@https.bugzilla.kernel.org/>
References: <bug-213829-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D213829

--- Comment #52 from Apostolos B. (barz621@gmail.com) ---
> What kind of errors?

Some like that:

=CE=99=CE=B1=CE=BD 05 18:20:53 mainland bluetoothd[25908]: Loading LTKs tim=
ed out for hci0
=CE=99=CE=B1=CE=BD 05 18:20:53 mainland kernel: Bluetooth: hci0: command 0x=
0c52 tx timeout
=CE=99=CE=B1=CE=BD 05 18:20:55 mainland kernel: Bluetooth: hci0: command 0x=
0c24 tx timeout
=CE=99=CE=B1=CE=BD 05 18:20:57 mainland kernel: Bluetooth: hci0: command 0x=
0c1a tx timeout
=CE=99=CE=B1=CE=BD 05 18:20:59 mainland kernel: Bluetooth: hci0: command 0x=
0405 tx timeout
=CE=99=CE=B1=CE=BD 05 18:20:59 mainland kernel: Bluetooth: hci0: No way to =
reset. Ignoring and
continuing
=CE=99=CE=B1=CE=BD 05 18:21:36 mainland kernel: Bluetooth: hci0: command 0x=
0408 tx timeout
=CE=99=CE=B1=CE=BD 05 18:21:36 mainland kernel: Bluetooth: hci0: No way to =
reset. Ignoring and
continuing

I think those are the ones that are logged when i cant use the mouse any mo=
re
and need to shutdown completely.

Might be usb related since afai understand the bluetooth adapter is connect=
ed
via USB.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
