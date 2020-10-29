Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01266C56201
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 00:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD187207DE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 00:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgJ2A0t convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 20:26:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbgJ2A0h (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 20:26:37 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 29 Oct 2020 00:26:34 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: jpsilva@uefs.br
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-a8k7X4NhUO@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

Joao Vieira (jpsilva@uefs.br) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jpsilva@uefs.br

--- Comment #157 from Joao Vieira (jpsilva@uefs.br) ---
I'm using v5.9.0 and my device is no more no being detectable. It was when
using v5.4.0 and I was able to use it with my readmi airdots but not with my
dualshock 4

btmon -w my.log
Bluetooth monitor ver 5.54
= Note: Linux version 5.9.0 (armv7l)                                        
0.389794
= Note: Bluetooth subsystem version 2.22                                    
0.389809
@ MGMT Open: bluetoothd (privileged) version 1.18                   {0x0001}
0.389816
@ MGMT Open: btmon (privileged) version 1.18                        {0x0002}
0.389977
@ RAW Open: hcitool (privileged) version 2.22                      {0x0003}
29.538239
@ RAW Close: hcitool                                               {0x0003}
29.538398
@ RAW Open: hcitool (privileged) version 2.22                      {0x0003}
29.538529
@ RAW Close: hcitool                                               {0x0003}
29.538556

lsusb -vvd 0a12:0001...| grep bcdDevice
  bcdDevice           25.20

dmesg |grep 'CSR clone detected'
<nothing>

hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 5.54
Can't attach to device hci0. No such device(19)

-- 
You are receiving this mail because:
You are the assignee for the bug.
