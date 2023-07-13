Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EECEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 05:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjGMF6W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 01:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjGMF6V (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 01:58:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C8E1FDE
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 22:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5401761A22
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 05:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9B95C433CA
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 05:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689227899;
        bh=jDc2UqbQdPMBkaSGMw8akWUthCACWhxmYRux6vnsNtM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hSXo8j6gSqQeU8X/ouczqOt1vl4Rq+Gu9dD9qN0Und4xZ6VtNrqdoneOMbsr7haXh
         R/4ZeJD2KeOJPUgd1ZW0hMygXrK8vcOIaui1OBYbowL0N6vEQdokpYfXIc1YwZ6+41
         FYtRaR3/salqfY21+uSPC/jI/5PAmccGXHC+drLGKOKfdOeyWVtszJw5/COHvfqdOu
         xPrIGAEjHTVF4N7/z8msvTHlqRdbJOo6Kv1B9gpAzPottIHeqbudmojZn7MfPT9Ct7
         4FYLU5GiyptNGjCn8MIJ/iSccD99KdFaacsBPKIpjZ3tj6HCN+izYm9iPsJ/fa9Wng
         9JSpjPz0MwIzw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id A637DC53BD0; Thu, 13 Jul 2023 05:58:19 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Thu, 13 Jul 2023 05:58:19 +0000
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
Message-ID: <bug-217651-62941-MQgb6EFOlf@https.bugzilla.kernel.org/>
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

--- Comment #18 from Tomasz Mo=C5=84 (desowin@gmail.com) ---
The previous proposal is bogus as I messed up the conditions again. It would
reject anything with BTUSB_IFNUM_2 when the interface is either 0 or 2. Wha=
t we
want is to allow either 0 or 2 when BTUSB_IFNUM_2 is set.

The correct patch to try would be:

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5ec4ad0a5c86..764d176e9735 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4104,6 +4104,7 @@ static int btusb_probe(struct usb_interface *intf,
        BT_DBG("intf %p id %p", intf, id);

        if ((id->driver_info & BTUSB_IFNUM_2) &&
+           (intf->cur_altsetting->desc.bInterfaceNumber !=3D 0) &&
            (intf->cur_altsetting->desc.bInterfaceNumber !=3D 2))
                return -ENODEV;

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
