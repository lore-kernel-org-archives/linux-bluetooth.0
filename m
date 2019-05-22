Return-Path: <SRS0=CsNs=TW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE33C282CE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 19:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1E520868
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 May 2019 19:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfEVTLs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 May 2019 15:11:48 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:52278 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729555AbfEVTLs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 May 2019 15:11:48 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 5806F201CB
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2019 19:11:47 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 5652420408; Wed, 22 May 2019 19:11:47 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 203643] [REGRESSION][BISECTED] Sixaxis gamepad no longer
 connects via Bluetooth
Date:   Wed, 22 May 2019 19:11:46 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: irherder@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-203643-62941-1hBEfs3owA@https.bugzilla.kernel.org/>
In-Reply-To: <bug-203643-62941@https.bugzilla.kernel.org/>
References: <bug-203643-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=203643

Andriy Perevortkin (irherder@gmail.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |irherder@gmail.com

--- Comment #10 from Andriy Perevortkin (irherder@gmail.com) ---
Sadly the RFC patch above does not fix it for me, the revert does
The device is edifier w330nb headset.

hcidump fragment of failed connection:

> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 5C:C6:E9:11:B1:20
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 5C:C6:E9:11:B1:20 key 9290EB1424E3A352C43F17C8499A3670
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 5C:C6:E9:11:B1:20
> HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 256 encrypt 0x01
< HCI Command: Read Encryption Key Size (0x05|0x0008) plen 2
> ACL data: handle 256 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0580
< ACL data: handle 256 flags 0x00 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0000 scid 0x0580 result 3 status 0
      Connection refused - security block
> HCI Event: Command Complete (0x0e) plen 7
    Read Encryption Key Size (0x05|0x0008) ncmd 1
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 256 packets 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 256 reason 0x13
    Reason: Remote User Terminated Connection

-- 
You are receiving this mail because:
You are the assignee for the bug.
