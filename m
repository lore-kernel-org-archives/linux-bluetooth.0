Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731D2C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jan 2022 20:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239970AbiA0UQI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jan 2022 15:16:08 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:37294 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240004AbiA0UQH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jan 2022 15:16:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 14562CE237C
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 20:16:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 342CDC340F0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 20:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643314564;
        bh=ca9CNcUApqo0eFUD5ACocc93+m5QJb6VER2u/7khXRY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Nj4wI8te7qilm/WhtV5ejadd3Y1T7KL0PEhZ4CFMzx0rhaSJStVDNXxs+HSJGcWZr
         D2qxG4rdlFkJLs8Z/FNZTGDMWJstDyWKAPW9wyFQuvhSrist3M+CUnv8NSE4i8P481
         7M3QGgR/eISjrLzGlcY2wnI8gpv+IKDmMpHbEkmaJ0CwVjkjwNpEEmoO8mOCf5QbZN
         RbVxCHmNMcwimy84H22fLnpyc/7Y7GiOyPSzmv1uO6cE0hZUI5pypCHTj+/J3rHYL9
         RDTRqmMzRcstvqnz0KeMAy1dq5WXOOyCUzjS9GCoxLsyqeRr4RGhqvlQGYl2eGl1fA
         OTWFlQT5bd0Dw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id 24C5BCC13AA; Thu, 27 Jan 2022 20:16:04 +0000 (UTC)
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Thu, 27 Jan 2022 20:16:00 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: artium@nihamkin.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc attachments.created
Message-ID: <bug-60824-62941-l2XLemfjoE@https.bugzilla.kernel.org/>
In-Reply-To: <bug-60824-62941@https.bugzilla.kernel.org/>
References: <bug-60824-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=3D60824

Artium (artium@nihamkin.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |artium@nihamkin.com

--- Comment #223 from Artium (artium@nihamkin.com) ---
Created attachment 300341
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D300341&action=3Dedit
btmon -w my.log for bcdDevice 88.91

Hope this helps.

Bluetooth monitor ver 5.53
=3D Note: Linux version 5.13.0-27-generic (x86_64)=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                                0.014382
=3D Note: Bluetooth subsystem version 2.22=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20
                                                0.014388
=3D New Index: 00:1A:7D:DA:71:13 (Primary,USB,hci0)=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                         [hci0] 0.014390
@ MGMT Open: bluetoothd (privileged) version 1.20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                       {0x0001} 0.014392
@ MGMT Open: btmon (privileged) version 1.20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                       {0x0002} 0.014479
@ RAW Open: hciconfig version 2.22=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
                                      {0x0003} 60.544023
@ RAW Close: hciconfig=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                      {0x0003} 60.544469
@ RAW Open: hciconfig version 2.22=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20
                                      {0x0003} 69.380485
@ RAW Close: hciconfig=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                      {0x0003} 69.380893
@ RAW Open: hciconfig (privileged) version 2.22=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                      {0x0003} 79.123846
=3D Open Index: 00:1A:7D:DA:71:13=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
                                        [hci0] 79.268817
=3D Index Info: 00:1A:7D:DA:71:13 (Cambridge Silicon Radio)=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                        [hci0] 79.268854
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0=20=20=20=
=20=20=20=20=20=20=20=20=20=20
                                     #1 [hci0] 79.268932
> HCI Event: Command Complete (0x0e) plen 12=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>                                      #2 [hci0] 79.272734
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 5.0 (0x09) - Revision 2064 (0x0810)
        LMP version: Bluetooth 5.0 (0x09) - Subversion 8978 (0x2312)
        Manufacturer: Cambridge Silicon Radio (10)
< HCI Command: Reset (0x03|0x0003) plen 0=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20
                                     #3 [hci0] 79.272969
> HCI Event: Command Complete (0x0e) plen 4=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>                                      #4 [hci0] 79.284725
      Reset (0x03|0x0003) ncmd 1
        Status: Success (0x00)
< HCI Command: Read Local Supported Features (0x04|0x0003) plen 0=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
                                     #5 [hci0] 79.284870
> HCI Event: Command Complete (0x0e) plen 12=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>                                      #6 [hci0] 79.287702
      Read Local Supported Features (0x04|0x0003) ncmd 1
        Status: Success (0x00)
        Features: 0xbf 0x3e 0x4d 0xfa 0xdb 0x3d 0x7b 0xc7
          3 slot packets
          5 slot packets
          Encryption
          Slot offset
          Timing accuracy
          Role switch
          Sniff mode
          Power control requests
          Channel quality driven data rate (CQDDR)
          SCO link
          HV2 packets
          HV3 packets
          CVSD synchronous data
          Power control
          Transparent synchronous data
          Flow control lag (most significant bit)
          Enhanced Data Rate ACL 2 Mbps mode
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
          Pause encryption
          AFH capable master
          AFH classification master
          Enhanced Data Rate eSCO 2 Mbps mode
          Extended Inquiry Response
          Simultaneous LE and BR/EDR (Controller)
          Secure Simple Pairing
          Encapsulated PDU
          Erroneous Data Reporting
          Non-flushable Packet Boundary Flag
          Link Supervision Timeout Changed Event
          Inquiry TX Power Level
          Enhanced Power Control
          Extended features
          Unknown features (0x4000000000000000)
< HCI Command: Read Local Version Information (0x04|0x0001) plen 0=20=20=20=
=20=20=20=20=20=20=20=20=20=20
                                     #7 [hci0] 79.287785
> HCI Event: Command Complete (0x0e) plen 12=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>                                      #8 [hci0] 79.290703
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 5.0 (0x09) - Revision 2064 (0x0810)
        LMP version: Bluetooth 5.0 (0x09) - Subversion 8978 (0x2312)
        Manufacturer: Cambridge Silicon Radio (10)
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                     #9 [hci0] 79.290779
> HCI Event: Command Complete (0x0e) plen 10=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>                                     #10 [hci0] 79.293696
      Read BD ADDR (0x04|0x0009) ncmd 1
        Status: Success (0x00)
        Address: 00:1A:7D:DA:71:13 (cyber-blue(HK)Ltd)
< HCI Command: Read Buffer Size (0x04|0x0005) plen 0=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                    #11 [hci0] 79.293917
> HCI Event: Command Complete (0x0e) plen 11=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>                                     #12 [hci0] 79.296698
      Read Buffer Size (0x04|0x0005) ncmd 1
        Status: Success (0x00)
        ACL MTU: 679  ACL max packet: 8
        SCO MTU: 48   SCO max packet: 16
< HCI Command: Read Class of Device (0x03|0x0023) plen 0=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                    #13 [hci0] 79.296749
> HCI Event: Command Complete (0x0e) plen 7=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>                                     #14 [hci0] 79.299704
      Read Class of Device (0x03|0x0023) ncmd 1
        Status: Success (0x00)
        Class: 0x000000
          Major class: Miscellaneous
          Minor class: 0x00
< HCI Command: Read Local Name (0x03|0x0014) plen 0=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                    #15 [hci0] 79.299817
> HCI Event: Command Complete (0x0e) plen 252=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
>                                     #16 [hci0] 79.317704
      Read Local Name (0x03|0x0014) ncmd 1
        Status: Success (0x00)
        Name: CSR8510 A10

< HCI Command: Read Voice Setting (0x03|0x0025) plen 0=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                    #17 [hci0] 79.317863
> HCI Event: Command Complete (0x0e) plen 6=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>                                     #18 [hci0] 79.320707
      Read Voice Setting (0x03|0x0025) ncmd 1
        Status: Success (0x00)
        Setting: 0x0000
          Input Coding: Linear
          Input Data Format: 1's complement
          Input Sample Size: 8-bit
          # of bits padding at MSB: 0
          Air Coding Format: CVSD
< HCI Command: Read Number of Supported IAC (0x03|0x0038) plen 0=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
                                    #19 [hci0] 79.320795
> HCI Event: Command Complete (0x0e) plen 5=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>                                     #20 [hci0] 79.323704
      Read Number of Supported IAC (0x03|0x0038) ncmd 1
        Status: Success (0x00)
        Number of IAC: 2
< HCI Command: Read Current IAC LAP (0x03|0x0039) plen 0=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                    #21 [hci0] 79.323801
> HCI Event: Command Complete (0x0e) plen 8=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>                                     #22 [hci0] 79.326704
      Read Current IAC LAP (0x03|0x0039) ncmd 1
        Status: Success (0x00)
        Number of IAC: 1
        Access code: 0x9e8b33 (General Inquiry)
< HCI Command: Set Event Filter (0x03|0x0005) plen 1=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
                                    #23 [hci0] 79.326769
        Type: Clear All Filters (0x00)
> HCI Event: Command Complete (0x0e) plen 4=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20
>                                     #24 [hci0] 79.329709
      Set Event Filter (0x03|0x0005) ncmd 1
        Status: Invalid HCI Command Parameters (0x12)
=3D Close Index: 00:1A:7D:DA:71:13=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20
                                        [hci0] 79.329830
@ RAW Close: hciconfig

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
