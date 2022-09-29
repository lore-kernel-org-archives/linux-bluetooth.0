Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B3EC32771
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Sep 2022 00:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233645AbiI2Atn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Sep 2022 20:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiI2Atl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Sep 2022 20:49:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055F638A8
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Sep 2022 17:49:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2213B8229C
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 00:49:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6611DC4314D
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Sep 2022 00:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664412576;
        bh=lHNldNW4hDkT8SDU/wTdHe4YyUxY977NIH+5ePwDDzk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gJfSq4BtHahvKEj84bUDdS9G9cXAu24JQ6I+jYBAlS5OTDmiJSbr4uwD1Er9gH4Ov
         0jhtXnhiIok2wX0uzviOd6LUeTTXYkGRNk/OJsbcwZsTnR7+MQzJ3hp7crcwYXOQa6
         O+Lho8WvM9x3pmXyTwWVnizNyE+64hnDfmcnFWg0OwUOMUQFY262/kH0ZFsVvlO2QS
         9GcYCh/4ZdfzVuaxpN8jeZcKJojvO7qwns2ue/FWqvvdcyzHlFEU+eKVV7BI6Hb65P
         BLlDpWHQAbHDlMXOh12MxO+wXBkr7vohHH2EIbOO14MWZ1phzaeSClaNQcJV+sPpMR
         kaZfH4q43we0g==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 59127C433E4; Thu, 29 Sep 2022 00:49:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Thu, 29 Sep 2022 00:49:35 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: patrick.blesi@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-WCuaHSs7Vl@https.bugzilla.kernel.org/>
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

--- Comment #42 from Patrick Blesi (patrick.blesi@gmail.com) ---
(In reply to Patrick Blesi from comment #41)
> I am experiencing the same problem with 5.15.67 for USB Device
> USB_DEVICE(0x8087, 0x0aaa).
>=20
> ~ $ uname -a
> Linux a0d7b954-ssh 5.15.67 #1 SMP Tue Sep 13 13:54:38 UTC 2022 x86_64 Lin=
ux
>=20
> ~ $ lsusb
> Bus 001 Device 001: ID 1d6b:0002
> Bus 001 Device 003: ID 1043:8012
> Bus 002 Device 001: ID 1d6b:0003
> Bus 001 Device 002: ID 8087:0aaa
>=20
> ~ $ dmesg | grep -i bluetooth
> [    0.454719] Bluetooth: Core ver 2.22
> [    0.454904] NET: Registered PF_BLUETOOTH protocol family
> [    0.455504] Bluetooth: HCI device and connection manager initialized
> [    0.455896] Bluetooth: HCI socket layer initialized
> [    0.456392] Bluetooth: L2CAP socket layer initialized
> [    0.456894] Bluetooth: SCO socket layer initialized
> [    4.452912] Bluetooth: hci0: Reading Intel version command failed (-11=
0)
> [    4.452955] Bluetooth: hci0: command 0xfc05 tx timeout
> [    4.498402] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [    4.498405] Bluetooth: BNEP filters: protocol multicast
> [    4.498409] Bluetooth: BNEP socket layer initialized

This was actually a red herring. The issue was manifested by not connecting=
 my
Bluetooth PCI devices as a passthrough to my lxd virtual machine. To resolv=
e I
removed the Bluetooth USB device (0x8087, 0x0aaa) and added the PCI control=
ler
and shared RAM PCI controller in the same iommu group.

00:14.0 USB controller: Intel Corporation Cannon Point-LP USB 3.1 xHCI
Controller (rev 30)=20
00:14.2 RAM memory: Intel Corporation Cannon Point-LP Shared SRAM (rev 30)

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
