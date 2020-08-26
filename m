Return-Path: <SRS0=or7B=CE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23937C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 17:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC81720737
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Aug 2020 17:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHZRIH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:08:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:36738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbgHZRIF (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Aug 2020 13:08:05 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Wed, 26 Aug 2020 17:08:02 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: b.razmjoo@protonmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-n5QjlI6S9N@https.bugzilla.kernel.org/>
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

Babak (b.razmjoo@protonmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |b.razmjoo@protonmail.com

--- Comment #146 from Babak (b.razmjoo@protonmail.com) ---
Hi everyone, I have bought a dongle just like Andres's in
https://bugzilla.kernel.org/show_bug.cgi?id=60824#c81 and my system has
problems activating it. This is my system:

Linux localhost.localdomain 5.7.9-200.fc32.x86_64 #1 SMP Fri Jul 17 16:23:37
UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

These are result of running commands recommended here:

$ hciconfig -a
hci0:   Type: Primary  Bus: USB
        BD Address: 00:1A:7D:DA:71:10  ACL MTU: 640:2  SCO MTU: 64:8
        DOWN 
        RX bytes:538 acl:0 sco:0 events:25 errors:0
        TX bytes:338 acl:0 sco:0 commands:25 errors:0
        Features: 0xff 0xff 0x8f 0xfa 0xdb 0xff 0x5b 0x87
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 

Local Version Information from btmon output:
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0             
                 #5 [hci0] 3.570144
> HCI Event: Command Complete (0x0e) plen 12                                   
>                  #6 [hci0] 3.572090
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 4.0 (0x06) - Revision 12576 (0x3120)
        LMP version: Bluetooth 4.0 (0x06) - Subversion 8891 (0x22bb)
        Manufacturer: Cambridge Silicon Radio (10)

hcidump -X resulted in this :
https://bugzilla.kernel.org/attachment.cgi?id=292177

btmon -w : https://bugzilla.kernel.org/attachment.cgi?id=292179

lsusb : https://bugzilla.kernel.org/attachment.cgi?id=292181

thanks for the great work

-- 
You are receiving this mail because:
You are the assignee for the bug.
