Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094D4C4338F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 23:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AB860ED5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 23:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhHNXa5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Aug 2021 19:30:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233223AbhHNXa5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Aug 2021 19:30:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 3157060F51
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Aug 2021 23:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628983828;
        bh=7LbjdLrCuian9TexdcelAwaaL3LtYb1bAyJ3IsxQfhA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aLM4O/6DinmeRWyBV6WkKWIofukAsNfn70GRt9xNyER0l3oqgA8fosA5reNg+9fGn
         /CTzRvkdoNHHdc52kKDBOOLhERWyRek3mCsEbPEOeQ6X7DLRW9ulolKLLRt9byCheP
         gjnZB2RRrVIdbLi5i8/DAzuFUm6+zEnGXd1ggMUB9DDvAnVFDcQNzHI8zeIMzXnpNQ
         Mtg5rF7u8z2TSuTioFB3cHWZmd6IPETGg5jADG3pIxlgodlioSNOktFYryh/bugrse
         dUpLhlF6DZcme0YX+g2t375ebx4avN7Av83zPfrpJt0VDipIbvIKyaG/3jn8TfZLul
         lYzUx+4F2ewgg==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Sat, 14 Aug 2021 23:30:24 +0000
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
Message-ID: <bug-60824-62941-O42CwVomDC@https.bugzilla.kernel.org/>
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

--- Comment #195 from Jack (ostroffjh@users.sourceforge.net) ---
Yahoo.  Upgraded to kernel 5.13.10.  dmesg is similar to earlier kernel
(Comment 192) but the device is now recognized, and I can pair it with my S=
ony
BT headphones.  Not really sure what changed that made the difference.

[  105.530371] usb 1-1: new full-speed USB device number 6 using xhci_hcd
[  105.850394] usb 1-1: New USB device found, idVendor=3D0a12, idProduct=3D=
0001,
bcdDevice=3D88.91
[  105.850403] usb 1-1: New USB device strings: Mfr=3D0, Product=3D2,
SerialNumber=3D0
[  105.850406] usb 1-1: Product: BT DONGLE10
[  105.908027] btusb: unknown parameter 'fixups' ignored
[  105.908193] usbcore: registered new interface driver btusb
[  105.911173] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...
[  105.911178] Bluetooth: hci0: CSR: Failed to suspend the device for our
Barrot 8041a02 receive-issue workaround
[  184.834006] Bluetooth: RFCOMM TTY layer initialized
[  184.834012] Bluetooth: RFCOMM socket layer initialized
[  184.834017] Bluetooth: RFCOMM ver 1.11
[ 2108.854428] input: WH-CH700N (AVRCP) as /devices/virtual/input/input23

btmon info same as in Comment 192.

I do find it interesting that it says V5.0 on the device, but btmon shows
Bluetooth 4.0, although for a cheap dongle from eBay, I'm not surprised.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
