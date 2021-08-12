Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980F5C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 18:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7709A6103E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Aug 2021 18:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhHLSQv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Aug 2021 14:16:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237554AbhHLSQs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Aug 2021 14:16:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id E21796108C
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Aug 2021 18:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628792182;
        bh=KsvMvSjBhtJ+MrniGSpCkYEPiN/l3thrqJL1LK9E3w0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=adIjj9KQ2PbyqUHUbiXIPKyU0Ab+yrpDsLktS1g7nYwDNXhKZGHH8WWBi+hkC3s11
         tVJum0iBoqk4LHiodPYv/rUSVxwPcgIkTRPyaAo0Ij6gNzMWnKB7yDYs/VTwTSrp6t
         BvK9FdIk5crY8vzKWOgRhFTO/sZ+fqDmFf6gVnVPGrne0aaTZHIZ3ZpLj/8XnQD/sB
         xJdNGQo4MxxL8F0Q5e6s+cBFsf9lbCMjgAXyALC7LJZprLtcUwdjUr4pEWu5C1yrxd
         ZT5Q7lHujcXHOhxcW2EH96hSvsS+d9jVAaZvEzr5csKvNGUvBIvCYxyv0YtqHJGuVo
         IU8xKdN0qXlCQ==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 12 Aug 2021 18:16:19 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: ostroffjh@users.sourceforge.net
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-OXQZWPaDP3@https.bugzilla.kernel.org/>
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

--- Comment #192 from Jack (ostroffjh@users.sourceforge.net) ---
The dongle itself says V5.0, does show up in lsusb, but is not seen by
bluetootctl.

dmesg:
[88730.215224] usb 1-2: new full-speed USB device number 15 using xhci_hcd
[88730.533384] usb 1-2: New USB device found, idVendor=3D0a12, idProduct=3D=
0001,
bcdDevice=3D88.91
[88730.533390] usb 1-2: New USB device strings: Mfr=3D0, Product=3D2,
SerialNumber=3D0
[88730.533392] usb 1-2: Product: BT DONGLE10
[88730.546179] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...
[88730.546186] Bluetooth: hci0: CSR: Failed to suspend the device for our
Barrot 8041a02 receive-issue workaround

< HCI Command: Read Local Version In.. (0x04|0x0001) plen 0  #1 [hci0] 6.83=
4674
> HCI Event: Command Complete (0x0e) plen 12                 #2 [hci0] 6.83=
8502
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.0 (0x06) - Revision 12576 (0x3120)
        LMP version: Bluetooth 4.0 (0x06) - Subversion 8891 (0x22bb)
        Manufacturer: Cambridge Silicon Radio (10)

I still can't figure out how to get the quirks to work, as dmesg still shows
[   20.500180] btusb: unknown parameter 'fixups' ignored

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
