Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F9FC433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Nov 2021 22:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhK2W5C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbhK2W4d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Nov 2021 17:56:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640D1C061A16
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 13:58:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B014ECE13DF
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 21:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB752C53FD0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Nov 2021 21:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638223124;
        bh=+rK3fWveB9nVpZbuXZ4/Nu0EE9OPbGe1SFH70HVVkJ0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qUpLdxyhEYq9OWf8G21WVgEaq1OqlcpTbHHdam3j1wT4QhL/nxsRQ6QWYKyvI5bMv
         uanxkE8Do0pOFVWK+L72kI9j5ENnfKRaW6nQkvzh9eDuEU2zY6E9kz0+TbPMBdHpZl
         6jCK5CfEyMq0B2pUDuSxAkjWOcua4+s+Ruq7uCRAwh0Kkb8ukAMoxfsQuC9OFUuevP
         azorzEIlQf57vWARpNwcgTriF1d16goBfT+fbUrdlnXO8dX1wuk0Kaqhr5B2u2PjUj
         SyiHK4hfPnHefp4vKkJDIBqZMZzDXINOfvCE440o7B/76+c4xso8BytyLGJ2jxSEkt
         kyJe3D414kXiw==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id C724160F26; Mon, 29 Nov 2021 21:58:44 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Mon, 29 Nov 2021 21:58:44 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tech@reachthetribes.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-215167-62941-uzq2HwvBiQ@https.bugzilla.kernel.org/>
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

--- Comment #8 from George Olson (tech@reachthetribes.org) ---
when I boot with 5.15.3 kernel, btusb is not loaded onto the kernel.

Results after modprobe btusb:
> lsmod | grep bt
btusb                  65536  0
btrtl                  28672  1 btusb
btbcm                  20480  1 btusb
btintel                45056  1 btusb
bluetooth             729088  4 btrtl,btintel,btbcm,btusb
usbcore               372736  6 xhci_hcd,usbhid,typec,uvcvideo,btusb,xhci_p=
ci

> journalctl -b | egrep -i hci
Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: xHCI Host
Controller
Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: new USB bus
registered, assigned bus number 1
Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: hcc params
0x20007fc1 hci version 0x120 quirks 0x0000000200009810
Nov 29 15:37:25 asustribetrek kernel: usb usb1: Product: xHCI Host Controll=
er
Nov 29 15:37:25 asustribetrek kernel: usb usb1: Manufacturer: Linux
5.15.3-1-default xhci-hcd
Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: xHCI Host
Controller
Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: new USB bus
registered, assigned bus number 2
Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: Host supports =
USB
3.1 Enhanced SuperSpeed
Nov 29 15:37:25 asustribetrek kernel: usb usb2: Product: xHCI Host Controll=
er
Nov 29 15:37:25 asustribetrek kernel: usb usb2: Manufacturer: Linux
5.15.3-1-default xhci-hcd
Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: xHCI Host
Controller
Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: new USB bus
registered, assigned bus number 3
Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: hcc params
0x20007fc1 hci version 0x120 quirks 0x0000000000009810
Nov 29 15:37:25 asustribetrek kernel: usb usb3: Product: xHCI Host Controll=
er
Nov 29 15:37:25 asustribetrek kernel: usb usb3: Manufacturer: Linux
5.15.3-1-default xhci-hcd
Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: xHCI Host
Controller
Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: new USB bus
registered, assigned bus number 4
Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: Host supports =
USB
3.1 Enhanced SuperSpeed
Nov 29 15:37:25 asustribetrek kernel: usb usb4: Product: xHCI Host Controll=
er
Nov 29 15:37:25 asustribetrek kernel: usb usb4: Manufacturer: Linux
5.15.3-1-default xhci-hcd
Nov 29 15:37:26 asustribetrek kernel: usb 3-1: new full-speed USB device nu=
mber
2 using xhci_hcd
Nov 29 15:37:26 asustribetrek kernel: usb 3-5: new high-speed USB device nu=
mber
3 using xhci_hcd
Nov 29 15:37:34 asustribetrek sddm-helper[1600]: Adding cookie to
"/run/user/1000/xauth_HCineT"
Nov 29 15:56:37 asustribetrek kernel: Bluetooth: HCI device and connection
manager initialized
Nov 29 15:56:37 asustribetrek kernel: Bluetooth: HCI socket layer initializ=
ed

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
