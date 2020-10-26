Return-Path: <SRS0=rjyd=EB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBE6C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 08:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5505F20829
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Oct 2020 08:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770309AbgJZIhc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Oct 2020 04:37:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1770139AbgJZIhc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Oct 2020 04:37:32 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 208965] not working bluetooth mouse low energy rtl8822ce
Date:   Mon, 26 Oct 2020 08:37:31 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: high
X-Bugzilla-Who: niklas97.nf@googlemail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-208965-62941-kohn0aEqr5@https.bugzilla.kernel.org/>
In-Reply-To: <bug-208965-62941@https.bugzilla.kernel.org/>
References: <bug-208965-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=208965

--- Comment #19 from Niklas Frank (niklas97.nf@googlemail.com) ---
(In reply to david.zakarias from comment #13)
> I tried what Julian did, but things do not work. 
> 
> hciconfig hci0 shows:
> 
> hci0: Type: Primary  Bus: USB
>       BD Address: 80:30:49:1B:82:2C  ACL MTU: 1021:6  SCO MTU: 255:12
>       DOWN 
>       RX bytes:2068 acl:0 sco:0 events:189 errors:0
>       TX bytes:32660 acl:0 sco:0 commands:189 errors:0
> 
> If I start btmon, and do sudo hciconfig hci0 up, there's a huge amount of
> output, and an error at the end:
> 
> < HCI Command: LE Clear White List (0x08|0x0010) plen 0    #59 [hci0]
> 38.597768
> > HCI Event: Command Complete (0x0e) plen 4                #60 [hci0]
> 38.599898
>       LE Clear White List (0x08|0x0010) ncmd 2
>         Status: Success (0x00)
> < HCI Command: LE Set Resolvable P.. (0x08|0x002e) plen 2  #61 [hci0]
> 38.600001
>         Timeout: 900 seconds
> > HCI Event: Command Complete (0x0e) plen 4                #62 [hci0]
> 38.601954
>       LE Set Resolvable Private Address Timeout (0x08|0x002e) ncmd 2
>         Status: Unsupported Remote Feature / Unsupported LMP Feature (0x1a)
> 
> 
> I'm stuck, any ideas?

Hi,

I got a similar error. 
I have a Huawei Matebook 14 2020 with Ryzen 4600H and the same RTL8822CE. 
lsusb shows the following: 
Bus 003 Device 002: ID 1358:c123 Realtek Bluetooth Radio

I applied Julians Kernel patch and can see that the firmware is loaded during
boot, but bluez does not detect the controller. 
dmesg | grep -i bluetooth:
[    1.720939] usb 3-3: Product: Bluetooth Radio
[    3.962354] Bluetooth: Core ver 2.22
[    3.962376] Bluetooth: HCI device and connection manager initialized
[    3.962380] Bluetooth: HCI socket layer initialized
[    3.962382] Bluetooth: L2CAP socket layer initialized
[    3.962385] Bluetooth: SCO socket layer initialized
[    4.091974] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000c
lmp_ver=0a lmp_subver=8822
[    4.093982] Bluetooth: hci0: RTL: rom_version status=0 version=3
[    4.093985] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_fw.bin
[    4.094858] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_config.bin
[    4.094926] Bluetooth: hci0: RTL: cfg_sz 6, total sz 31422
[    4.196048] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    4.196051] Bluetooth: BNEP filters: protocol multicast
[    4.196057] Bluetooth: BNEP socket layer initialized
[    4.371968] Bluetooth: hci0: RTL: fw version 0x09993aa1

Trying to bring the device up via 'hciconfig hci0 up' gives me the following
error message: 
Can't init device hci0: Protocol not supported (93)`

Does anyone have any Ideas what I can do to get this working?

-- 
You are receiving this mail because:
You are the assignee for the bug.
