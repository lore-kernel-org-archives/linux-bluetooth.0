Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7345EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 22:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjGLW7z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 18:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjGLW7y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 18:59:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B74C12E
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 15:59:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A439961986
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 22:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 09050C433C9
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 22:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689202792;
        bh=tqR/KSxFdT2UcBL3D8J//fwX5186RBp/hDV2XE/59e8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Q4yTir+wZxa0Lh8ZbQU1pG57zfba6qi/RGA/SVKDczNo94/eFmdPF01oRAbX10hev
         M+ewdspun+m9Car18khsropd2cEa92q47xxATWWZEHnNYQstgyj+xUC0kazzEH3k3C
         c4cmZR2XLjzlntVjwUnM2AZPUa/7HJW34GxKZ/XGHdtbqjcAthMnSdP/OQfDgxs083
         Rq8gL+4L0SBpe9GBNHdZS+pd9CMrmt0urYQRuacjgHkwW9czvy0/Va+eni7LUGpYgc
         cvgARDwi/MVvaS7WiKjRGQpjIJTgvS7kUApkT/WpAgkSMe1Mw3RtGJFZzJtojJ3WI7
         AmFFpuMGuqbog==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id E6605C53BCD; Wed, 12 Jul 2023 22:59:51 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 217651] BCM20702B0  Bluetooth device in MacBook no longer
 working
Date:   Wed, 12 Jul 2023 22:59:51 +0000
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
Message-ID: <bug-217651-62941-Hk3dwMQ6SC@https.bugzilla.kernel.org/>
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

--- Comment #14 from johnbholland@icloud.com ---
I believe I have identified the problem and a fix. Commit
c13380a55522bf14e54779a142487c224509db95 is the cause, found by bisecting a=
nd
testing. Without it (built from immediately prior commit) the problem goes
away. Also, in the current code, this change is there and the latest version
6.5.0-rc1 has the issue, and it can be fixed by reverting this change. The
change in question is:

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5c536151ef83..4ca91c033d2f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3831,13 +3831,9 @@ static int btusb_probe(struct usb_interface *intf,

        BT_DBG("intf %p id %p", intf, id);

-       /* interface numbers are hardcoded in the spec */
-       if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 0) {
-               if (!(id->driver_info & BTUSB_IFNUM_2))
-                       return -ENODEV;
-               if (intf->cur_altsetting->desc.bInterfaceNumber !=3D 2)
-                       return -ENODEV;
-       }
+       if ((id->driver_info & BTUSB_IFNUM_2) &&
+           (intf->cur_altsetting->desc.bInterfaceNumber !=3D 2))
+               return -ENODEV;

        ifnum_base =3D intf->cur_altsetting->desc.bInterfaceNumber;

( - is the code that works, + is the code that doesn't).=20
Looking at the code, it looks like it was meant to remove the outer if
statement and turn the inner part into something simpler. I think it is mis=
sing
an ! and uses && instead of || if that is what it intends.=20

When I changed it to that though, the problem still existed. So what worked=
 for
me was to revert this block of code to the previous version, in both 6.3 and
6.5.  In 6.5 this file has changed a lot, but this block is the same as the
commit made it.=20

My 2014 Macbook Pro is perhaps an obscure bit of hardware and I don't know
whether this change was fixing something on other hardware. On my Macbook,
though, it causes the internal Bluetooth controller to not be seen.=20
I will also send an email to the people in the commit,
 Signed-off-by: Tomasz Mo=C5=84 <tomasz.mon@nordicsemi.no>
    Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
