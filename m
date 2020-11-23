Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0774BC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 20:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0A0920715
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Nov 2020 20:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbgKWUMY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Nov 2020 15:12:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731855AbgKWUMX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Nov 2020 15:12:23 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 210275] Bluetooth stopped working on kernel 5.9
Date:   Mon, 23 Nov 2020 20:12:22 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: francesco.kirico@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-210275-62941-2EA1ggAxFp@https.bugzilla.kernel.org/>
In-Reply-To: <bug-210275-62941@https.bugzilla.kernel.org/>
References: <bug-210275-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=210275

Francesco Chirico (francesco.kirico@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |francesco.kirico@gmail.com

--- Comment #2 from Francesco Chirico (francesco.kirico@gmail.com) ---
Same problem here after recent updates.
My configuration:

uname -a
Linux Giove 5.9.9-200.fc33.x86_64 #1 SMP Thu Nov 19 21:25:45 UTC 2020 x86_64
x86_64 x86_64 GNU/Linux

lsmod | grep bluetooth
bluetooth             684032  12 btrtl,btintel,btbcm,bnep,btusb
ecdh_generic           16384  1 bluetooth
rfkill                 28672  7 bluetooth,cfg80211

bluetoothctl --version
bluetoothctl: 5.55

sudo hciconfig hci0 up
Can't init device hci0: Connection timed out (110)

sudo hciconfig hci0 up
Can't init device hci0: Protocol not supported (93)

dmesg | grep Bluetooth
[    2.477351] usb 1-1.4: Product: Bluetooth Radio
[    4.851973] Bluetooth: Core ver 2.22
[    4.851993] Bluetooth: HCI device and connection manager initialized
[    4.851995] Bluetooth: HCI socket layer initialized
[    4.851997] Bluetooth: L2CAP socket layer initialized
[    4.852004] Bluetooth: SCO socket layer initialized
[    4.903968] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b
lmp_ver=0a lmp_subver=8761
[    4.904962] Bluetooth: hci0: RTL: rom_version status=0 version=1
[    4.904964] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761b_fw.bin
[    4.906676] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761b_config.bin
[    4.907054] Bluetooth: hci0: RTL: cfg_sz 6, total sz 20522
[    5.033234] Bluetooth: hci0: RTL: fw version 0x0999646b
[   13.214469] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[   13.214471] Bluetooth: BNEP filters: protocol multicast
[   13.214474] Bluetooth: BNEP socket layer initialized
[ 2558.708298] Bluetooth: hci0: command 0x1001 tx timeout
[ 2566.964134] Bluetooth: hci0: RTL: HCI_OP_READ_LOCAL_VERSION failed (-110)
[ 2581.056198] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=0999
lmp_ver=0a lmp_subver=646b
[ 2581.056202] Bluetooth: hci0: RTL: unknown IC info, lmp subver 646b, hci rev
0999, hci ver 000a
[ 2581.056203] Bluetooth: hci0: RTL: assuming no firmware upload needed

-- 
You are receiving this mail because:
You are the assignee for the bug.
