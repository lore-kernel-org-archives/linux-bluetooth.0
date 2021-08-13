Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560BBC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 11:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3771A60F11
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 11:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240251AbhHMLJl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 07:09:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:34986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229597AbhHMLJl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 07:09:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id CE3D360EE5
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 11:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628852954;
        bh=l9U0pHmdGWXMUFOB9pXIDpyNcWcSHkS9LKJt5vGl4sk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=k8m3NWSM3J1jE42z2srvJYCYa3YH4V5NadFcKk6eIUBrWBmyG7XXEO0QuTT+m4RaG
         yXLSvfbbT7u6wpHL8witrtsTatD5oXQODcmHkA7Pk/R+V+nxMos5fRpEVwn8pQ4a7U
         9uSN6FbTf5c08VYNaCPBSKZoV4XHMf5AfQtfwngSufxIkBhlEpan4TQ/UZUYjdIl89
         wHjhSELxll0OAoDmh+5ve4ug4wq8a/Ms8t82qSGZM8+Cg9A8VfqPHuuUZ38rTILwsG
         RzWcMwC200IRrfgnQO5rBLgipbPyGmq2XOSZbgpQcOegH+UFzory0xAQhHdNMRMZZa
         oCXLDRB0Fjugw==
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Fri, 13 Aug 2021 11:09:11 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jayfu@web.de
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-n8H4E1WC5x@https.bugzilla.kernel.org/>
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

--- Comment #194 from Jay (jayfu@web.de) ---
(In reply to Swyter from comment #191)

> @Jay, does it work fine with just the first patch? That's important.

With just the first patch it does not work:
[  107.129483] usb 1-1: new full-speed USB device number 6 using xhci_hcd
[  107.516042] usb 1-1: New USB device found, idVendor=3D0a12, idProduct=3D=
0001,
bcdDevice=3D88.91
[  107.516050] usb 1-1: New USB device strings: Mfr=3D0, Product=3D2,
SerialNumber=3D0
[  107.516052] usb 1-1: Product: BT DONGLE10
[  107.538827] Bluetooth: hci0: CSR: Unbranded CSR clone detected; adding
workarounds and force-suspending once...
[  107.538835] Bluetooth: hci0: CSR: Failed to suspend the device for our
Barrot 8041a02 receive-issue workaround

It works only with both patches.

> Also please post your `hciconfig -a` *or* 'Read Local Version Information'
> packet from your `btmon -w my.log` as shown here:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D60824#c119
>=20
> We're interested in the HCI Version / Revision and LMP Version / Subversi=
on
> fields, which don't appear in your lsusb dumps, and show what really makes
> your dongle unique.

The new bluez package does not contain hciconfig any more. btmon does not t=
race
any 'Read Local Version Information' packet. Is there another easy way to g=
et
that information?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
