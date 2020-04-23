Return-Path: <SRS0=6Duj=6H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6F9C54FD0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 17:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39C320857
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Apr 2020 17:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729889AbgDWRR4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:17:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:53236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729887AbgDWRR4 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Apr 2020 13:17:56 -0400
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 23 Apr 2020 17:17:53 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: thefugazi@gmail.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-60824-62941-yY4LaMaMJD@https.bugzilla.kernel.org/>
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

thefugazi@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |thefugazi@gmail.com

--- Comment #61 from thefugazi@gmail.com ---
(In reply to Michael Akushsky from comment #58)
> Adopted patch to kernel version 5.5, confirmed that my device started working
> 
> ID 0a12:0001 Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)
> 
> That's my adoption:
> https://github.com/akushsky/kernel_patches/blob/master/UbiquitousEvil/
> bluetooth.patch

Same device ID here and while this patch gets the dongle functioning, I am
unable to establish a successful connection with any device.

< HCI Command: Create Connection (0x01|0x0005) plen 13   #299 [hci0] 192.046072
        Address: 5C:EB:68:74:50:AD (Cheerstar Technology Co., Ltd)
        Packet type: 0xcc18
          DM1 may be used
          DH1 may be used
          DM3 may be used
          DH3 may be used
          DM5 may be used
          DH5 may be used
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
        Role switch: Allow slave (0x01)
> HCI Event: Command Status (0x0f) plen 4                #300 [hci0] 192.048152
      Create Connection (0x01|0x0005) ncmd 1
        Status: Success (0x00)
> HCI Event: Connect Complete (0x03) plen 11             #301 [hci0] 192.508147
        Status: Success (0x00)
        Handle: 128
        Address: 5C:EB:68:74:50:AD (Cheerstar Technology Co., Ltd)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Suppo.. (0x01|0x001b) plen 2  #302 [hci0] 192.508223
        Handle: 128
> HCI Event: Command Status (0x0f) plen 4                #303 [hci0] 192.510138
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Supported Fea.. (0x0b) plen 11  #304 [hci0] 192.511139
        Status: Success (0x00)
        Handle: 128
        Features: 0xff 0xfe 0x8f 0xfe 0xdb 0xff 0x5b 0x87
          3 slot packets
          5 slot packets
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Hold mode
          Sniff mode
          Power control requests
          Channel quality driven data rate (CQDDR)
          SCO link
          HV2 packets
          HV3 packets
          u-law log synchronous data
          A-law log synchronous data
          CVSD synchronous data
          Paging parameter negotiation
          Power control
          Transparent synchronous data
          Broadcast Encryption
          Enhanced Data Rate ACL 2 Mbps mode
          Enhanced Data Rate ACL 3 Mbps mode
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          Extended SCO link (EV3 packets)
          EV4 packets
          EV5 packets
          AFH capable slave
          AFH classification slave
          LE Supported (Controller)
          3-slot Enhanced Data Rate ACL packets
          5-slot Enhanced Data Rate ACL packets
          Sniff subrating
          Pause encryption
          AFH capable master
          AFH classification master
          Enhanced Data Rate eSCO 2 Mbps mode
          Enhanced Data Rate eSCO 3 Mbps mode
          3-slot Enhanced Data Rate eSCO packets
          Extended Inquiry Response
          Simultaneous LE and BR/EDR (Controller)
          Secure Simple Pairing
          Encapsulated PDU
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
< HCI Command: Read Remote Exten.. (0x01|0x001c) plen 3  #305 [hci0] 192.511150
        Handle: 128
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                #306 [hci0] 192.513135
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Extended Feat.. (0x23) plen 13  #307 [hci0] 192.514139
        Status: Success (0x00)
        Handle: 128
        Page: 1/1
        Features: 0x03 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
          LE Supported (Host)
< HCI Command: Remote Name Requ.. (0x01|0x0019) plen 10  #308 [hci0] 192.514157
        Address: 5C:EB:68:74:50:AD (Cheerstar Technology Co., Ltd)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
< ACL Data TX: Handle 128 flags 0x00 dlen 10             #309 [hci0] 192.514167
      L2CAP: Information Request (0x0a) ident 1 len 2
        Type: Extended features supported (0x0002)
> HCI Event: Command Status (0x0f) plen 4                #310 [hci0] 192.516133
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Max Slots Change (0x1b) plen 3              #311 [hci0] 192.517132
        Handle: 128
        Max slots: 5
> HCI Event: Number of Completed Packets (0x13) plen 5   #312 [hci0] 192.554140
        Num handles: 1
        Handle: 128
        Count: 1
> HCI Event: Remote Name Req Complete (0x07) plen 255    #313 [hci0] 192.578126
        Status: Success (0x00)
        Address: 5C:EB:68:74:50:AD (Cheerstar Technology Co., Ltd)
        Name: Tronsmart Spunky Beat
@ MGMT Event: Device Connected (0x000b) plen 36      {0x0001} [hci0] 192.578141
        BR/EDR Address: 5C:EB:68:74:50:AD (Cheerstar Technology Co., Ltd)
        Flags: 0x00000000
        Data length: 23
        Name (complete): Tronsmart Spunky Beat
@ MGMT Event: Device Connected (0x000b) plen 36      {0x0002} [hci0] 192.578141
        BR/EDR Address: 5C:EB:68:74:50:AD (Cheerstar Technology Co., Ltd)
        Flags: 0x00000000
        Data length: 23
        Name (complete): Tronsmart Spunky Beat
< ACL Data TX: Handle 128 flags 0x00 dlen 12             #314 [hci0] 196.529160
      L2CAP: Connection Request (0x02) ident 2 len 4
        PSM: 1 (0x0001)
        Source CID: 64
> HCI Event: Number of Completed Packets (0x13) plen 5   #315 [hci0] 196.554157
        Num handles: 1
        Handle: 128
        Count: 1
> HCI Event: Disconnect Complete (0x05) plen 4           #316 [hci0] 226.973306
        Status: Success (0x00)
        Handle: 128
        Reason: Remote User Terminated Connection (0x13)
@ MGMT Event: Device Disconnected (0x000c) plen 8    {0x0001} [hci0] 226.973325
        BR/EDR Address: 5C:EB:68:74:50:AD (Cheerstar Technology Co., Ltd)
        Reason: Connection terminated by remote host (0x03)
@ MGMT Event: Device Disconnected (0x000c) plen 8    {0x0002} [hci0] 226.973325
        BR/EDR Address: 5C:EB:68:74:50:AD (Cheerstar Technology Co., Ltd)
        Reason: Connection terminated by remote host (0x03)

-- 
You are receiving this mail because:
You are the assignee for the bug.
