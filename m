Return-Path: <SRS0=9PGa=ZY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB50C432C3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 12:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D651920833
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Dec 2019 12:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfLBMmW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Dec 2019 07:42:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:34720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbfLBMmW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Dec 2019 07:42:22 -0500
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 205735] New: Kernel 4.19.42 and newer have broke my Bluetooth
 keyboard/mouse support
Date:   Mon, 02 Dec 2019 12:42:20 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: cijoml@volny.cz
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-205735-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=205735

            Bug ID: 205735
           Summary: Kernel 4.19.42 and newer have broke my Bluetooth
                    keyboard/mouse support
           Product: Drivers
           Version: 2.5
    Kernel Version: 4.19.42 and all newer also 5.4
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: blocking
          Priority: P1
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: cijoml@volny.cz
        Regression: No

Hello guys,

I own a very old Logitech diNovo media set with Keyboard, Mouse MX1000
for Bluetooth and Mediapad.
Since 4.19.41 I was able to use it without problem, but kernel 4.19.42
introduced two patches which one of them problably broke my Bluetooth
setup support.
According to the changelog those might be:

commit 38f092c41cebaff589e88cc22686b289a6840559
Author: Marcel Holtmann <marcel@xxxxxxxxxxxx>
Date: Wed Apr 24 22:19:17 2019 +0200

Bluetooth: Align minimum encryption key size for LE and BR/EDR connections

commit d5bb334a8e171b262e48f378bd2096c0ea458265 upstream.

The minimum encryption key size for LE connections is 56 bits and to
align LE with BR/EDR, enforce 56 bits of minimum encryption key size for
BR/EDR connections as well.

Signed-off-by: Marcel Holtmann <marcel@xxxxxxxxxxxx>
Signed-off-by: Johan Hedberg <johan.hedberg@xxxxxxxxx>
Cc: stable@xxxxxxxxxxxxxxx
Signed-off-by: Greg Kroah-Hartman <gregkh@xxxxxxxxxxxxxxxxxxx>

commit c6d1f9b4b2cb768e29f5d44af143f25ad89062b1
Author: Young Xiao <YangX92@xxxxxxxxxxx>
Date: Fri Apr 12 15:24:30 2019 +0800

Bluetooth: hidp: fix buffer overflow

commit a1616a5ac99ede5d605047a9012481ce7ff18b16 upstream.

Struct ca is copied from userspace. It is not checked whether the "name"
field is NULL terminated, which allows local users to obtain potentially
sensitive information from kernel stack memory, via a HIDPCONNADD command.

This vulnerability is similar to CVE-2011-1079.

Signed-off-by: Young Xiao <YangX92@xxxxxxxxxxx>
Signed-off-by: Marcel Holtmann <marcel@xxxxxxxxxxxx>
Cc: stable@xxxxxxxxxxxxxxx
Signed-off-by: Greg Kroah-Hartman <gregkh@xxxxxxxxxxxxxxxxxxx>

My current working setup with 4.19.41 is as follows:

root@thinkpad:/home/cijoml# hcitool con
Connections:
> ACL 00:07:61:49:2A:6A handle 69 state 1 lm MASTER AUTH ENCRYPT
> ACL 00:07:61:3E:1C:71 handle 71 state 1 lm MASTER AUTH ENCRYPT
> ACL 00:07:61:49:E0:3D handle 68 state 1 lm MASTER

root@thinkpad:/home/cijoml# hcitool info 00:07:61:3E:1C:71
Requesting information ...
BD Address: 00:07:61:3E:1C:71
OUI Company: Logitech Europe SA (00-07-61)
Device Name: Logitech diNovo Keyboard
LMP Version: 1.2 (0x2) LMP Subversion: 0x545
Manufacturer: Cambridge Silicon Radio (10)
Features: 0xfc 0xff 0x0f 0x00 0x08 0x08 0x00 0x00
<encryption> <slot offset> <timing accuracy> <role switch>
<hold mode> <sniff mode> <park state> <RSSI> <channel quality>
<SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log>
<CVSD> <paging scheme> <power control> <transparent SCO>
<AFH cap. slave> <AFH cap. master>
root@thinkpad:/home/cijoml# hcitool info 00:07:61:49:E0:3D
Requesting information ...
BD Address: 00:07:61:49:E0:3D
OUI Company: Logitech Europe SA (00-07-61)
Device Name: Logitech MX1000 mouse
LMP Version: 1.2 (0x2) LMP Subversion: 0x545
Manufacturer: Cambridge Silicon Radio (10)
Features: 0xfc 0xff 0x0f 0x00 0x08 0x08 0x00 0x00
<encryption> <slot offset> <timing accuracy> <role switch>
<hold mode> <sniff mode> <park state> <RSSI> <channel quality>
<SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log>
<CVSD> <paging scheme> <power control> <transparent SCO>
<AFH cap. slave> <AFH cap. master>
root@thinkpad:/home/cijoml# hcitool info 00:07:61:49:2A:6A
Requesting information ...
BD Address: 00:07:61:49:2A:6A
OUI Company: Logitech Europe SA (00-07-61)
Device Name: Logitech Mediapad
LMP Version: 1.2 (0x2) LMP Subversion: 0x545
Manufacturer: Cambridge Silicon Radio (10)
Features: 0xfc 0xff 0x0f 0x00 0x08 0x08 0x00 0x00
<encryption> <slot offset> <timing accuracy> <role switch>
<hold mode> <sniff mode> <park state> <RSSI> <channel quality>
<SCO link> <HV2 packets> <HV3 packets> <u-law log> <A-law log>
<CVSD> <paging scheme> <power control> <transparent SCO>
<AFH cap. slave> <AFH cap. master>


Can anybody please look at this and fix the support for my Bluetooth
set so I do not need to throw it into dustbin?

Thank you in advance

Michal

-- 
You are receiving this mail because:
You are the assignee for the bug.
