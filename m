Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DE8C25B47
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Oct 2023 08:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjJ0Igr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Oct 2023 04:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0Igq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Oct 2023 04:36:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C50106
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Oct 2023 01:36:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0002DC433CD
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Oct 2023 08:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698395804;
        bh=ier+lkzvzGzuM4YmuF1q9sSqw2qvLEIm01oinq8HGDc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Y9LIe7gCihGZnd149gF39rJP69ELTOAqVvT2itExfltuVQF+WExBxvg79PEYXJNV3
         Vx0tEeCeDeMsZvpcUx7E0gHzUoo1eQkSUrv+qvShE55OdUEsXEU4ONlmqHDZKXtQGg
         AUrif2x2Vw4d7HBBPsCzcxp2iB2Y2GaHH6votuCcHchQL3BCdkgl6yQArlhA8EKV4o
         mhptaPkNWwbgoIGrRnXMk+QEJzesWmzOwO48m/I0kOwCNOln7cUEKK2GEEddVJXdO1
         /TDleMEIQkA5ha/z/QsP5mG7nqcmuOjRV5UUyi5B0EYTnvXYIA9bqQ04fidJpplcBH
         2HO+qwW0qi46Q==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id DB538C53BC6; Fri, 27 Oct 2023 08:36:43 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 80791] "Bluetooth: hci0: ACL packet for unknown connection
 handle" must be hidden behind "debug"
Date:   Fri, 27 Oct 2023 08:36:43 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: aros@gmx.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-80791-62941-ni3JlQSGwr@https.bugzilla.kernel.org/>
In-Reply-To: <bug-80791-62941@https.bugzilla.kernel.org/>
References: <bug-80791-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D80791

Artem S. Tashkinov (aros@gmx.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |aros@gmx.com

--- Comment #7 from Artem S. Tashkinov (aros@gmx.com) ---
When connecting my laptop to my smartphone I get this message almost every 2
seconds.

I don't think the user can even do anything about it, could you please show=
 it
_just once_?

[278536.979041] input: Smartphone X (AVRCP) as /devices/virtual/input/input=
20
[278557.775313] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278573.330987] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278574.837013] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278577.025169] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278579.533122] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278587.617396] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278601.656461] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278603.847227] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278605.494469] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278607.640811] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278609.998596] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278611.898942] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278626.172392] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278627.966819] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278630.108002] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278634.449240] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278637.205311] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278639.417526] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278650.205987] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278651.664703] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278659.509455] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278661.063814] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278663.972533] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278666.922671] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278669.291930] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278673.299147] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278675.681829] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278693.982873] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278695.476906] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837
[278703.181558] Bluetooth: hci0: ACL packet for unknown connection handle 3=
837

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
