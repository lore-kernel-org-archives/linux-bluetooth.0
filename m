Return-Path: <SRS0=J5Jk=MY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A21C67877
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Oct 2018 17:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035B92148C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 12 Oct 2018 17:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035B92148C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bugzilla.kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeJMB2u convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:28:50 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:54106 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727123AbeJMB2t (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 12 Oct 2018 21:28:49 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 7F8662B2D3
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Oct 2018 17:55:10 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 7383B2BAD8; Fri, 12 Oct 2018 17:55:10 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 201363] RTL8822BE Bluetooth not detected on Lenovo A485
Date:   Fri, 12 Oct 2018 17:55:10 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: samantham@posteo.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-201363-62941-OZ5YAV79Uf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-201363-62941@https.bugzilla.kernel.org/>
References: <bug-201363-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=201363

--- Comment #1 from Samantha McVey (samantham@posteo.net) ---
Created attachment 279011
  --> https://bugzilla.kernel.org/attachment.cgi?id=279011&action=edit
dmesg with bluetooth

Update: I have extracted Lenovo's RTL8822BE wifi and bluetooth firmware from
their Windows driver packages and gotten the bluetooth partially working. It
works if the system is up to sleep and then woken up again, though it doesn't
work when the system is booted up for the first time.

lsusb info:
Bus 004 Device 008: ID 0bda:b023 Realtek Semiconductor Corp.

I am hosting the firmware here https://github.com/samcv/A485-RTL8822BE-firmware
which has detail about how I extracted the firmware so I will only repost
relevant info here.

So there is still an issue loading firmware at boot, which hopefully  makes
this issue easier to solve.

Here is new dmesg | grep -Ei 'blue|8822|rtlwifi' output (full log is attached)

[    6.101343] usb 4-2.2: Product: Bluetooth Radio 
[   17.740697] r8822be: module is from the staging directory, the quality is
unknown, you have been warned.
[   17.745603] Bluetooth: Core ver 2.22
[   17.745605] Bluetooth: Starting self testing
[   17.745607] Bluetooth: Finished self testing
[   17.746180] Bluetooth: HCI device and connection manager initialized
[   17.746185] Bluetooth: HCI socket layer initialized
[   17.746188] Bluetooth: L2CAP socket layer initialized
[   17.746202] Bluetooth: SCO socket layer initialized
[   17.749597] r8822be 0000:02:00.0: enabling device (0000 -> 0003)
[   17.765897] r8822be: Using firmware rtlwifi/rtl8822befw.bin
[   17.771715] r8822be: rtlwifi: wireless switch is on
[   17.937819] r8822be 0000:02:00.0 wlp2s0: renamed from wlan0
[   18.838828] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   18.838831] Bluetooth: BNEP filters: protocol multicast
[   18.838837] Bluetooth: BNEP socket layer initialized
[   19.761568] Bluetooth: hci0: command 0x1001 tx timeout
[   27.761615] Bluetooth: hci0: RTL: HCI_OP_READ_LOCAL_VERSION failed (-110)
** Laptop goes to sleep here **
[  110.129904] r8822be: rtlwifi: wireless switch is on
[  111.619279] usb 4-2.2: Product: Bluetooth Radio 
[  111.973924] Bluetooth: hci0: RTL: rtl: examining hci_ver=07 hci_rev=000b
lmp_ver=07 lmp_subver=8822
[  111.975921] Bluetooth: hci0: RTL: rom_version status=0 version=2
[  111.975923] Bluetooth: hci0: RTL: rtl: loading rtl_bt/rtl8822b_fw.bin
[  111.977304] Bluetooth: hci0: RTL: rtl: loading rtl_bt/rtl8822b_config.bin
[  111.977829] Bluetooth: hci0: RTL: cfg_sz 14, total sz 24066

-- 
You are receiving this mail because:
You are the assignee for the bug.
