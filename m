Return-Path: <SRS0=vV7E=WL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA40EC31E40
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Aug 2019 05:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7810206C2
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Aug 2019 05:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729988AbfHOFyN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Aug 2019 01:54:13 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:56752 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729759AbfHOFyN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Aug 2019 01:54:13 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id D31C1288C6
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Aug 2019 05:54:11 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id C261A288BC; Thu, 15 Aug 2019 05:54:11 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 15 Aug 2019 05:54:09 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: arthur@life.net.br
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-lDQalQ9yv8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
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

https://bugzilla.kernel.org/show_bug.cgi?id=60824

Arthur Fragoso (arthur@life.net.br) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |arthur@life.net.br

--- Comment #33 from Arthur Fragoso (arthur@life.net.br) ---
Same here:

0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode).

But the product name is: JL AC69 A10

I tested in Linux 5.2.8-1-MANJARO, and the 4.19.57-1-MANJARO.

The problems are:

- After booting up the OS with the BT Dongle in, if I try to 'sudo bluetoothctl
power on', it fails and 'btmon' returns this:


@ MGMT Command: Set Powered (0x0005) plen 1                                    
         {0x0001} [hci0] 34.681295
        Powered: Enabled (0x01)
= Open Index: 00:1A:7D:DA:71:10                                                
                  [hci0] 34.743182
< HCI Command: Reset (0x03|0x0003) plen 0                                      
               #2 [hci0] 34.743412
= Close Index: 00:1A:7D:DA:71:10                                               
                  [hci0] 44.768939
@ MGMT Event: Command Status (0x0002) plen 3                                   
         {0x0001} [hci0] 44.772086
      Set Powered (0x0005)
        Status: Failed (0x03)
= bluetoothd: Failed to set mode: Failed (0x03)                                
                  [hci0] 44.790305


If I unplug and plug it back, the power on command will work fine. If it is set
to AutoEnable on /etc/bluetooth/main.conf, it will also be powered up after
plugin it back.
If I power off, it will only work again if I unplug and plug it back. So it's
not a big problem.


The big deal is that I can't make it to scan:

$ sudo bluetoothctl scan on

bluetoothd[2358]: src/adapter.c:start_discovery() sender :1.268
bluetoothd[2358]: src/adapter.c:update_discovery_filter() 
bluetoothd[2358]: src/adapter.c:discovery_filter_to_mgmt_cp() 
bluetoothd[2358]: src/adapter.c:trigger_start_discovery() 
bluetoothd[2358]: src/adapter.c:cancel_passive_scanning() 
bluetoothd[2358]: src/adapter.c:start_discovery_timeout() 
bluetoothd[2358]: src/adapter.c:start_discovery_timeout()
adapter->current_discovery_filter == 0
bluetoothd[2358]: src/adapter.c:start_discovery_complete() status 0x03


@ MGMT Command: Start Discovery (0x0023) plen 1           {0x0001} [hci0]
37.252439
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6      #81 [hci0]
37.252583
        Address: 06:4D:6A:64:58:36 (Non-Resolvable)
< HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7     #82 [hci0]
39.423752
        Type: Active (0x01)
        Interval: 22.500 msec (0x0024)
        Window: 11.250 msec (0x0012)
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4            {0x0001} [hci0]
39.423747
      Start Discovery (0x0023) plen 1
        Status: Failed (0x03)
        Address type: 0x07
          BR/EDR
          LE Public
          LE Random
< HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2         #83 [hci0]
41.557120
        Scanning: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
< HCI Command: Inquiry (0x01|0x0001) plen 5                    #84 [hci0]
43.690407
        Access code: 0x9e8b33 (General Inquiry)
        Length: 10.24s (0x08)
        Num responses: 0


I will try to apply the patch and compile the kernel to see if I can get it to
work. It's crazy to think this thread started in November 2013, and currently
there are many of those CSR dongles being sold.

-- 
You are receiving this mail because:
You are the assignee for the bug.
