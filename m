Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3491EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Dec 2021 04:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbhLME0b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 12 Dec 2021 23:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbhLME0b (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 12 Dec 2021 23:26:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E987CC061748
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Dec 2021 20:26:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 720FAB80B71
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 04:26:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40B38C341CD
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Dec 2021 04:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639369588;
        bh=TZgBmAjIAaRpM6K1RHrV2b1YKPcorj9gd8WWOOxCUJs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YGo1rCvEQUPI48uuf/NMKCIPIsLlhnRoMQyDj6KrS++XpqbkF6vv9/bobtwR62+Zn
         cuIr8YOR5sXSFs+CWTDoWMYOCkBfeu3ilB8pddUOcXOvPj2+6W122eG6YbD3RWSQ+3
         fjcpgG1SneVeDfgS+QsWfoUSGy1fM7bl940qcDfSa/xnDm/SgtzVHpZbI0VX8xAO8y
         pItxVX2CKwwnJQSAVNLhza71V/NF98glc9Z6I7A9g8Nm3/jSn89+t3H8zswQ9uLlK2
         Idpnt4MziOiOaJlANuahDh/mx1LhREcFCezm+M3BbKcGKydtNvv1BmWgh7icCnviCx
         /k+omSn5dWCCQ==
Received: by pdx-korg-bugzilla-2.web.codeaurora.org (Postfix, from userid 48)
        id 292B260F4F; Mon, 13 Dec 2021 04:26:28 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 215167] Bluetooth: hci0: command 0xfc05 tx timeout
Date:   Mon, 13 Dec 2021 04:26:27 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: tedd.an@intel.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-215167-62941-JpOSrPHafK@https.bugzilla.kernel.org/>
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

Tedd An (tedd.an@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |tedd.an@intel.com

--- Comment #18 from Tedd An (tedd.an@intel.com) ---
(In reply to George Olson from comment #8)
> when I boot with 5.15.3 kernel, btusb is not loaded onto the kernel.
>=20
> Results after modprobe btusb:
> > lsmod | grep bt
> btusb                  65536  0
> btrtl                  28672  1 btusb
> btbcm                  20480  1 btusb
> btintel                45056  1 btusb
> bluetooth             729088  4 btrtl,btintel,btbcm,btusb
> usbcore               372736  6 xhci_hcd,usbhid,typec,uvcvideo,btusb,xhci=
_pci
>=20
> > journalctl -b | egrep -i hci
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: xHCI Host
> Controller
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: new USB bus
> registered, assigned bus number 1
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: hcc params
> 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
> Nov 29 15:37:25 asustribetrek kernel: usb usb1: Product: xHCI Host Contro=
ller
> Nov 29 15:37:25 asustribetrek kernel: usb usb1: Manufacturer: Linux
> 5.15.3-1-default xhci-hcd
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: xHCI Host
> Controller
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: new USB bus
> registered, assigned bus number 2
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: Host supports
> USB 3.1 Enhanced SuperSpeed
> Nov 29 15:37:25 asustribetrek kernel: usb usb2: Product: xHCI Host Contro=
ller
> Nov 29 15:37:25 asustribetrek kernel: usb usb2: Manufacturer: Linux
> 5.15.3-1-default xhci-hcd
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: xHCI Host
> Controller
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: new USB bus
> registered, assigned bus number 3
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: hcc params
> 0x20007fc1 hci version 0x120 quirks 0x0000000000009810
> Nov 29 15:37:25 asustribetrek kernel: usb usb3: Product: xHCI Host Contro=
ller
> Nov 29 15:37:25 asustribetrek kernel: usb usb3: Manufacturer: Linux
> 5.15.3-1-default xhci-hcd
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: xHCI Host
> Controller
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: new USB bus
> registered, assigned bus number 4
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: Host supports
> USB 3.1 Enhanced SuperSpeed
> Nov 29 15:37:25 asustribetrek kernel: usb usb4: Product: xHCI Host Contro=
ller
> Nov 29 15:37:25 asustribetrek kernel: usb usb4: Manufacturer: Linux
> 5.15.3-1-default xhci-hcd
> Nov 29 15:37:26 asustribetrek kernel: usb 3-1: new full-speed USB device
> number 2 using xhci_hcd
> Nov 29 15:37:26 asustribetrek kernel: usb 3-5: new high-speed USB device
> number 3 using xhci_hcd
> Nov 29 15:37:34 asustribetrek sddm-helper[1600]: Adding cookie to
> "/run/user/1000/xauth_HCineT"
> Nov 29 15:56:37 asustribetrek kernel: Bluetooth: HCI device and connection
> manager initialized
> Nov 29 15:56:37 asustribetrek kernel: Bluetooth: HCI socket layer initial=
ized

Hi, George,=20
When you have a chance, could you try with 5.16-rc1 kernel? Yours seems
different from the above issue (like 8087: 0a2a). Just in case make sure to
cold boot after upgrading the kernel.

--- Comment #19 from Tedd An (tedd.an@intel.com) ---
(In reply to George Olson from comment #8)
> when I boot with 5.15.3 kernel, btusb is not loaded onto the kernel.
>=20
> Results after modprobe btusb:
> > lsmod | grep bt
> btusb                  65536  0
> btrtl                  28672  1 btusb
> btbcm                  20480  1 btusb
> btintel                45056  1 btusb
> bluetooth             729088  4 btrtl,btintel,btbcm,btusb
> usbcore               372736  6 xhci_hcd,usbhid,typec,uvcvideo,btusb,xhci=
_pci
>=20
> > journalctl -b | egrep -i hci
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: xHCI Host
> Controller
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: new USB bus
> registered, assigned bus number 1
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: hcc params
> 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
> Nov 29 15:37:25 asustribetrek kernel: usb usb1: Product: xHCI Host Contro=
ller
> Nov 29 15:37:25 asustribetrek kernel: usb usb1: Manufacturer: Linux
> 5.15.3-1-default xhci-hcd
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: xHCI Host
> Controller
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: new USB bus
> registered, assigned bus number 2
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:0d.0: Host supports
> USB 3.1 Enhanced SuperSpeed
> Nov 29 15:37:25 asustribetrek kernel: usb usb2: Product: xHCI Host Contro=
ller
> Nov 29 15:37:25 asustribetrek kernel: usb usb2: Manufacturer: Linux
> 5.15.3-1-default xhci-hcd
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: xHCI Host
> Controller
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: new USB bus
> registered, assigned bus number 3
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: hcc params
> 0x20007fc1 hci version 0x120 quirks 0x0000000000009810
> Nov 29 15:37:25 asustribetrek kernel: usb usb3: Product: xHCI Host Contro=
ller
> Nov 29 15:37:25 asustribetrek kernel: usb usb3: Manufacturer: Linux
> 5.15.3-1-default xhci-hcd
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: xHCI Host
> Controller
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: new USB bus
> registered, assigned bus number 4
> Nov 29 15:37:25 asustribetrek kernel: xhci_hcd 0000:00:14.0: Host supports
> USB 3.1 Enhanced SuperSpeed
> Nov 29 15:37:25 asustribetrek kernel: usb usb4: Product: xHCI Host Contro=
ller
> Nov 29 15:37:25 asustribetrek kernel: usb usb4: Manufacturer: Linux
> 5.15.3-1-default xhci-hcd
> Nov 29 15:37:26 asustribetrek kernel: usb 3-1: new full-speed USB device
> number 2 using xhci_hcd
> Nov 29 15:37:26 asustribetrek kernel: usb 3-5: new high-speed USB device
> number 3 using xhci_hcd
> Nov 29 15:37:34 asustribetrek sddm-helper[1600]: Adding cookie to
> "/run/user/1000/xauth_HCineT"
> Nov 29 15:56:37 asustribetrek kernel: Bluetooth: HCI device and connection
> manager initialized
> Nov 29 15:56:37 asustribetrek kernel: Bluetooth: HCI socket layer initial=
ized

Hi, George,=20
When you have a chance, could you try with 5.16-rc1 kernel? Yours seems
different from the above issue (like 8087: 0a2a). Just in case make sure to
cold boot after upgrading the kernel.

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
