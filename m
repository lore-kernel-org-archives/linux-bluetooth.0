Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04DEEB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Jul 2023 11:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjGMLyN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Jul 2023 07:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjGMLyM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Jul 2023 07:54:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F63B4
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 04:54:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC7C861016
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 11:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CD68C433C8
        for <linux-bluetooth@vger.kernel.org>; Thu, 13 Jul 2023 11:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689249250;
        bh=Ehqd4R/nYK7SRjmOajbH77k0kLB37tkfCSw6REBsDmc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tA7+UICKMmV+102AIpG+JavRdFjbR1rvvBrMP+I/bvc3cW72wFh+VpIqKS/LxBp30
         xzfiEX/ifcLj1jmwnjzMjvlD8mQX2OO/ZlAMaSCn/DH0wEkQMYp4GaZu3x/aY2eFEk
         nMndytL0g0GItOErfW62DS3krIp3vV/ZUb79th/tsGzlGeCYCi8dQKadCF4/Hzy27U
         x7SnmcVYBiKBx5cWggRRWwFHCFNqzLdUko+5QECoCyrjlX44DdXllYahpFU257VlQr
         MCyW7BH9nTRAn0RUmJM0jr8Afj6lt15+ZlWOzBk3WJZk6hSct6NZPbFSUBbazuZYpW
         vHG7l/HFUNpuQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 37357C53BC6; Thu, 13 Jul 2023 11:54:10 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Thu, 13 Jul 2023 11:54:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: johnbholland@icloud.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-217651-62941-kV6141GIe9@https.bugzilla.kernel.org/>
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

--- Comment #21 from johnbholland@icloud.com ---
Hi,
the following code is working on my 2014 Intel Macbook Pro -

Thanks for the good work!

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5ec4ad0a5c86..596dc69ce510 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4103,9 +4103,11 @@ static int btusb_probe(struct usb_interface *intf,

        BT_DBG("intf %p id %p", intf, id);

-       if ((id->driver_info & BTUSB_IFNUM_2) &&
-           (intf->cur_altsetting->desc.bInterfaceNumber !=3D 2))
-               return -ENODEV;
+
+               if ((id->driver_info & BTUSB_IFNUM_2) &&
+           (intf->cur_altsetting->desc.bInterfaceNumber !=3D 0) &&
+           (intf->cur_altsetting->desc.bInterfaceNumber !=3D 2))
+               return -ENODEV;

        ifnum_base =3D intf->cur_altsetting->desc.bInterfaceNumber;

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
