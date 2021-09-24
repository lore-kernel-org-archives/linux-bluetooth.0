Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9386FC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 03:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72EC560EB4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Sep 2021 03:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243971AbhIXDMo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Sep 2021 23:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243954AbhIXDMn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Sep 2021 23:12:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 828886124B
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Sep 2021 03:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632453071;
        bh=uWnM/Eaoy+xnud08OOnOvl5GMRM8HWbDwC8VLVlw5PE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=inUBW0fKGsxUnfyMTZeguYZ9++uyDewgfeSwKFaqL55k1CiQkPvJK9v3VIUwLrD6q
         SMMgfNNEFqSdqfGfQOlVEJzsch/wbr+NvjbJqm+OA8WF/2qCzS3GmQtQlzgXlSuqLa
         UrBHDX76uC7AH6I5jKBVdkTvd6XATi+2GFnLgAwJA2KQbIpPgWVaemJ7C6zROFvmaL
         nUpfw/sYRp4eW/yfrAVyATdosDZgg3fKrFbJHw6KnOBw5QbZfUUa7CCQ1Hq6VAmv7W
         IJ4IcLtHWmgvRTyKzevz4fV5YlHwAok1sNgRp2CQKfdKOkYkMka13jtSnd6480ATn5
         6JskKOd2+a+sw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 24 Sep 2021 03:11:07 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sakuramail@tutanota.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-7oZdiEbMoL@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

sakuramail@tutanota.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sakuramail@tutanota.com

--- Comment #202 from sakuramail@tutanota.com ---
Last tested on 5.10/5.11/5.12, the controller was detected and I was able to
power it on with bluetoothctl, but was never able to pair with anything due=
 to
a protocol error on dmesg. Testing now on:

$ uname -r
5.14.6-artix1-1

$ lsusb
Bus 001 Device 004: ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Don=
gle
(HCI mode)

# dmesg
[16890.185351] usb 1-2: new full-speed USB device number 4 using xhci_hcd
[16890.502677] usb 1-2: New USB device found, idVendor=3D0a12, idProduct=3D=
0001,
bcdDevice=3D25.20
[16890.502684] usb 1-2: New USB device strings: Mfr=3D0, Product=3D2,
SerialNumber=3D0
[16890.502686] usb 1-2: Product: CSR8510 A10
[16890.518436] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...
[16895.708850] Bluetooth: hci0: CSR: Failed to suspend the device for our
Barrot 8041a02 receive-issue workaround
[16900.829464] Bluetooth: hci0: setting interface failed (110)

[mgmt]# info
Index list with 0 items

The controller does not appear anymore, tried multiple usb ports.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
