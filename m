Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D01EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 05:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjGMFpc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 01:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjGMFpa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 01:45:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A216E65
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 22:45:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD0A3619DD
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 05:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42B60C433C9
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 05:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689227129;
        bh=D2MrYUYzwLlFDLeG8y1gqmiNuYbN7hORq8F+puOFEcg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=J72fdYZqIoYnY8qlp5CRfSkYFxSLARyocNIQclZtbhimUyHhUB/UUOeggmIxFycL3
         aV52TSrpsIuc8FSAhlH6DOOz5O5JfK32RDUxbbhhx5oFoszCo7xBBUWtnaNZVZeGkE
         VCTRyhw4tqNkzUaqGFmOuWsiYxRbp40Em0NNS8lzUqbSBwAPCanSTFTLUjp2gAuTb4
         mZrMOxDqLwqMup/ptnXxhaBLAClFLZY857ettTHLYfaiESVU8f+IYm80BXlAwIm0zF
         fxC3+12DCEcqDn+DuBDC9nsNm5VB4zbrLu7LES9o1ENJVwXEf3ko/zlSEj73GINhoJ
         R6BAqjrdsy6Ew==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 3380DC53BD2; Thu, 13 Jul 2023 05:45:29 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Thu, 13 Jul 2023 05:45:28 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: desowin@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217651-62941-RkBcMY1icy@https.bugzilla.kernel.org/>
In-Reply-To: <bug-217651-62941@https.bugzilla.kernel.org/>
References: <bug-217651-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D217651

--- Comment #17 from Tomasz Mo=C5=84 (desowin@gmail.com) ---
I think I understand the issue now, but the lsusb output would confirm it.
Before my patch, the driver would allow both interface 0 and 2, after it on=
ly
interface 2 is allowed for devices with BTUSB_IFNUM_2 flag set.

I see two potential solutions:
  1. Remove the check completely
  2. Change the if condition to allow both interface 0 and 2.

For the second solution, please try following patch:

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5ec4ad0a5c86..46844194f54e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4104,7 +4104,8 @@ static int btusb_probe(struct usb_interface *intf,
        BT_DBG("intf %p id %p", intf, id);

        if ((id->driver_info & BTUSB_IFNUM_2) &&
-           (intf->cur_altsetting->desc.bInterfaceNumber !=3D 2))
+           ((intf->cur_altsetting->desc.bInterfaceNumber !=3D 0) ||
+            (intf->cur_altsetting->desc.bInterfaceNumber !=3D 2))
                return -ENODEV;

        ifnum_base =3D intf->cur_altsetting->desc.bInterfaceNumber;

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
