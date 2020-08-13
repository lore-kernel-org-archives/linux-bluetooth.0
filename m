Return-Path: <SRS0=cSIk=BX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45645C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Aug 2020 19:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C42220791
	for <linux-bluetooth@archiver.kernel.org>; Thu, 13 Aug 2020 19:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHMTcV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgHMTcV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 13 Aug 2020 15:32:21 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 13 Aug 2020 19:32:18 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: gnulux@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-KE6B11wnfG@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=60824

--- Comment #132 from Olivier JUDITH (gnulux@gmail.com) ---
Hi, 

Encoutering issue with a new bluetooth dongle (hci1) acquired from Gearbest
site.

hciconfig hci0 up 
Can't init device hci0: Invalid request code (56)

I tried on 5.4 kernel and  moved to 5.8.1-050801-generic the same behaviour. 

hci1:   Type: Primary  Bus: USB
        BD Address: 00:1A:7D:DA:71:10  ACL MTU: 640:4  SCO MTU: 64:8
        DOWN 
        RX bytes:501 acl:0 sco:0 events:22 errors:0
        TX bytes:329 acl:0 sco:0 commands:22 errors:0
        Features: 0xff 0xff 0x8f 0xfa 0x9b 0xff 0x59 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 

hci0:   Type: Primary  Bus: USB
        BD Address: 4C:1D:96:6D:CB:48  ACL MTU: 1021:4  SCO MTU: 96:6
        UP RUNNING 
        RX bytes:19359 acl:0 sco:0 events:3062 errors:0
        TX bytes:748521 acl:0 sco:0 commands:3061 errors:0
        Features: 0xbf 0xfe 0x0f 0xfe 0xdb 0xff 0x7b 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH SNIFF 
        Link mode: SLAVE ACCEPT 
        Name: 'VivoBook'
        Class: 0x1c010c
        Service Classes: Rendering, Capturing, Object Transfer
        Device Class: Computer, Laptop
        HCI Version: 5.1 (0xa)  Revision: 0x100
        LMP Version: 5.1 (0xa)  Subversion: 0x100
        Manufacturer: Intel Corp. (2)

Any help wil be appreciated. 

Regards

-- 
You are receiving this mail because:
You are the assignee for the bug.
