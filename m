Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CD3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Nov 2023 08:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbjKBIRk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Nov 2023 04:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjKBIRj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Nov 2023 04:17:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D08130
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Nov 2023 01:17:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84996C433C8
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Nov 2023 08:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698913056;
        bh=vON+nt1CcautyKRMR6bGu8h4MwNC2LEzIOnxcx7zR/o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=muyR/ryMyASd9HuXQ9/thX6tgl3hIJ6ICJYYb43VWbYndoV2o0y2FkfdqmsuJdJ0V
         cR3c4AFnKVDrCXm9V/kZRmvu4NpsDk1glouVlQw8gEc9wBei2jqKE0mQ7Y++6S8scy
         8mo6SPQyLSx4I/whfgR9EjPorVatoUY/r2DjUWJ6Zt+iHfYrtU8MryicGTwfPuHw9t
         7uq7kcQfNAQ//qHivWb0DEiSmrAJXcawCDCap1UanI1Eya0YDjnglbP+UxMR1YkSE6
         D4CXFe0JBrJWXAa9JDu1ncp9wyPXHZ+SLiU7GvwO75Ho7KAXto193Jx0D6jYJSEtMn
         wYwPw7Bdobfuw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 6AC52C53BD3; Thu,  2 Nov 2023 08:17:36 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 204589] Bluetooth touchpad (Apple Magic Trackpad) disconnects
 every few minutes
Date:   Thu, 02 Nov 2023 08:17:36 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: attila@lendvai.name
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-204589-62941-XY6aWKzB4a@https.bugzilla.kernel.org/>
In-Reply-To: <bug-204589-62941@https.bugzilla.kernel.org/>
References: <bug-204589-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D204589

attila lendvai (attila@lendvai.name) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |attila@lendvai.name

--- Comment #16 from attila lendvai (attila@lendvai.name) ---
i'm also affected by this for years, and it makes the touchpad rather annoy=
ing
to use.

it's been happening on different laptops, but my current setup is:

Thinkpad Carbon X1 gen6
Linux 6.4.16
x86_64
running Guix

$ lspci -nnk | grep 0280 -A3
02:00.0 Network controller [0280]: Intel Corporation Wireless 8265 / 8275
[8086:24fd] (rev 78)
        Subsystem: Intel Corporation Dual Band Wireless-AC 8265 [8086:0010]
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi

$ lsusb -d 8087:
Bus 001 Device 015: ID 8087:0a2b Intel Corp. Bluetooth wireless interface

$ bluetoothctl info
Device 28:37:37:2D:43:AD (public)
        Alias: 28-37-37-2D-43-AD
        Class: 0x00002594
        Icon: input-tablet
        Paired: yes
        Bonded: yes
        Trusted: yes
        Blocked: no
        Connected: yes
        WakeAllowed: yes
        LegacyPairing: no
        UUID: Human Interface Device... (00001124-0000-1000-8000-00805f9b34=
fb)
        UUID: PnP Information           (00001200-0000-1000-8000-00805f9b34=
fb)
        Modalias: usb:v05ACp030Ed0160

dmesg at every dis-/reconnect:

[364555.042486] input: Apple Wireless Trackpad as
/devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:512/0=
005:05AC:030E.009C/input/input166
[364555.042732] magicmouse 0005:05AC:030E.009C: input,hidraw5: BLUETOOTH HID
v1.60 Mouse [Apple Wireless Trackpad] on 84:fd:d1:8d:7a:e7
[366309.985739] magicmouse 0005:05AC:030E.009D: unknown main item tag 0x0
[366309.985887] input: Apple Wireless Trackpad as
/devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:256/0=
005:05AC:030E.009D/input/input167
[366309.986256] magicmouse 0005:05AC:030E.009D: input,hidraw5: BLUETOOTH HID
v1.60 Mouse [Apple Wireless Trackpad] on 84:fd:d1:8d:7a:e7
[366513.879351] magicmouse 0005:05AC:030E.009E: unknown main item tag 0x0
[366513.879540] input: Apple Wireless Trackpad as
/devices/pci0000:00/0000:00:14.0/usb1/1-7/1-7:1.0/bluetooth/hci0/hci0:256/0=
005:05AC:030E.009E/input/input168

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
