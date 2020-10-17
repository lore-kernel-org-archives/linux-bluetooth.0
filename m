Return-Path: <SRS0=DAWq=DY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74FFBC43457
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Oct 2020 18:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ABA82074A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 17 Oct 2020 18:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438802AbgJQSUz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 17 Oct 2020 14:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:50630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438798AbgJQSUz (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 17 Oct 2020 14:20:55 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 209403] c123 Realtek Bluetooth Radio not detected with Kernel
 5.9
Date:   Sat, 17 Oct 2020 18:20:54 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: dominik.gierlach@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-209403-62941-OnBOienpMf@https.bugzilla.kernel.org/>
In-Reply-To: <bug-209403-62941@https.bugzilla.kernel.org/>
References: <bug-209403-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=209403

Dominikus Gierlach (dominik.gierlach@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |dominik.gierlach@gmail.com

--- Comment #3 from Dominikus Gierlach (dominik.gierlach@gmail.com) ---
The issue is still present with 5.9.1.

Additional information: dmesg output from module loading to `hciconfig hci0
up':

[  741.324397] usbcore: registered new interface driver btusb
[  741.326030] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000c
lmp_ver=0a lmp_subver=8822
[  741.327752] Bluetooth: hci0: RTL: rom_version status=0 version=3
[  741.327757] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_fw.bin
[  741.327889] Bluetooth: hci0: RTL: loading rtl_bt/rtl8822cu_config.bin
[  741.327940] Bluetooth: hci0: RTL: cfg_sz 6, total sz 31422
[  741.605079] Bluetooth: hci0: RTL: fw version 0x09993aa1
[  772.977433] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=0999
lmp_ver=0a lmp_subver=3aa1
[  772.977446] Bluetooth: hci0: RTL: unknown IC info, lmp subver 3aa1, hci rev
0999, hci ver 000a
[  772.977447] Bluetooth: hci0: RTL: assuming no firmware upload needed
[  772.994449] debugfs: File 'dut_mode' in directory 'hci0' already present!



hciconfig hci0 up prints:

envy# hciconfig hci0 up
Can't init device hci0: Protocol not supported (93)

-- 
You are receiving this mail because:
You are the assignee for the bug.
