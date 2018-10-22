Return-Path: <SRS0=GZqV=NC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE88C004D3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Oct 2018 12:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6847A20652
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Oct 2018 12:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6847A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeJVVCJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:02:09 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:34892 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727590AbeJVVCI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Oct 2018 17:02:08 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 044E328488
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Oct 2018 12:43:42 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 02A0B28A75; Mon, 22 Oct 2018 12:43:42 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 198699] Kernel regularly logs: Bluetooth: hci0: last event is
 not cmd complete (0x0f)
Date:   Mon, 22 Oct 2018 12:43:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla.kernel.org@pritschet.eu
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-198699-62941-NacUFtsZlQ@https.bugzilla.kernel.org/>
In-Reply-To: <bug-198699-62941@https.bugzilla.kernel.org/>
References: <bug-198699-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=198699

Matthias Pritschet (bugzilla.kernel.org@pritschet.eu) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |bugzilla.kernel.org@pritsch
                   |                            |et.eu

--- Comment #15 from Matthias Pritschet (bugzilla.kernel.org@pritschet.eu) ---
This Bug seems to affect even basic HCI functionality:
"hcitool inq" is never returning in my case. dmesg gives me said error message.
I have tried two different USB-Bluetooth Dongles:

[ ] usb 2-2: New USB device found, idVendor=04b4, idProduct=f901, bcdDevice=
1.12
[ ] usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ ] usb 2-2: Product: CYW20704A2
[ ] usb 2-2: Manufacturer: Cypress Semi
[ ] Bluetooth: hci0: last event is not cmd complete (0x0f)

[ ] usb 2-2: New USB device found, idVendor=0a12, idProduct=0001,
bcdDevice=88.91
[ ] usb 2-2: New USB device strings: Mfr=0, Product=2, SerialNumber=0
[ ] usb 2-2: Product: CSR8510 A10
[ ] Bluetooth: hci0: last event is not cmd complete (0x0f)

Also btmon/hcidump just seem to freeze:

< HCI Command: Inquiry (0x01|0x0001) plen 5     #1 [hci0] 10.211282             
        Access code: 0x9e8b33 (General Inquiry)
        Length: 10.24s (0x08)
        Num responses: 0
> HCI Event: Command Status (0x0f) plen 4       #2 [hci0] 10.314299             
      Inquiry (0x01|0x0001) ncmd 1
        Status: Success (0x00)


The only way to recover from this state is to issue a "hciconfig hci0 reset".

-- 
You are receiving this mail because:
You are the assignee for the bug.
