Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF75C127B78
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Feb 2024 20:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707338982; cv=none; b=czgLi7wpjFHeoKjgdvBP4efMnPVqlG4Xx/UXGzvlAmWZ97HUwSG9IVYincUSKVFn+50B4EVa/pTdfRMZgxmCKBOszswd6nMBOajS1EVKAJXII0c0wedWoA6REENywSga6b80Qrib0TSWtps1XiV9Vt9WTPcS9wiPgcRVjr1K6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707338982; c=relaxed/simple;
	bh=2KTcwsZ6cR9yE20Fvdgv7CcFQzvF0ql2zz3o6YQt9Xc=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=O/KowqLLdA9YO/z+9PUz6MGZYg+98tGOxEr0CmQUWmsQTHekBl/2/itL4vyHmUr/WSM4SkPTH7ZTBcz5tagDNF66GlJbt7He7SBEiM/9aMVMhSFlsX+RsUSSdTzi9xXmexTJQvYtPh+n5Yu6Xf7WsQFletGk3CeHblxSgBvuWbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrveD5Xj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrveD5Xj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73747C43141
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Feb 2024 20:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707338981;
	bh=2KTcwsZ6cR9yE20Fvdgv7CcFQzvF0ql2zz3o6YQt9Xc=;
	h=From:To:Subject:Date:From;
	b=VrveD5XjnrIFSLTLXuXB062d0e32r64z+rHHpORbwr82plXVpJu83M150yPgha2nE
	 BjtlBn4S0JPLua3BowCymjlbMyZvDODC+h+ox0jM+dl0J0wx2C1A8bPRbucy5JhaWO
	 EY62ZwAHz0K+8zZLPeVpmMgHO8u4W+rITwZk5EtWWFe2+LK+fxs6XixN4k2cAK+Kcv
	 hGzyWLq2QkDz2WhEuQukCgdaZm94EBCfG4+GPqkXxg7YaC35TREgVA7Cy/95sZktTy
	 bNJC3DTNnPcUAhZOMkQxiVDeWOE3EUwUUS0rgINGkmwevJOyLX9jJxBZSvCsSb4YNi
	 shN4EavqDnaZw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id 5B2D0C53BCD; Wed,  7 Feb 2024 20:49:41 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218468] New: Unable to transfer file via Bluetooth from Nokia
 N9
Date: Wed, 07 Feb 2024 20:49:41 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: pmenzel+bugzilla.kernel.org@molgen.mpg.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 cf_regression
Message-ID: <bug-218468-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218468

            Bug ID: 218468
           Summary: Unable to transfer file via Bluetooth from Nokia N9
           Product: Drivers
           Version: 2.5
          Hardware: All
                OS: Linux
            Status: NEW
          Severity: normal
          Priority: P3
         Component: Bluetooth
          Assignee: linux-bluetooth@vger.kernel.org
          Reporter: pmenzel+bugzilla.kernel.org@molgen.mpg.de
        Regression: No

[I believe this is a regression.]

Choosing a file on the Nokia N9 and sending it to a Dell XPS 13 9360 with
Debian sid/unstable, GNOME does not show any dialog to accept. Only for some
seconds the Bluetooth symbol appears in the top bar next to the Wifi symbol.
(Transferring a file from the laptop to the Nokia N9 works.)

This also does not work with Linux 6.7 and 6.8-rc2.

```
Bluetooth monitor ver 5.71
btmon[5009]: =3D Note: Linux version 6.6.13-amd64 (x86_64)               0.=
347686
btmon[5009]: =3D Note: Bluetooth subsystem version 2.22                  0.=
347689
=3D New Index: 9C:B6:D0:D1:XX:XX (Primary,USB,hci0)               [hci0] 0.=
347690
=3D Open Index: 9C:B6:D0:D1:XX:XX                                 [hci0] 0.=
347690
=3D Index Info: 9C:B6:D0:D1:XX:XX (Qualcomm)                      [hci0] 0.=
347691
bluetoothd[4955]: @ MGMT Open: b.. (privileged) version 1.22  {0x0001} 0.34=
7692
> HCI Event: Connect Request (0x04) plen 10                  #1 [hci0] 9.48=
8340
        Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Class: 0x5a020c
          Major class: Phone (cellular, cordless, payphone, modem)
          Minor class: Smart phone
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Telephony (Cordless telephony, Modem, Headset)
        Link type: ACL (0x01)
< HCI Command: Accept Connection Req.. (0x01|0x0009) plen 7  #2 [hci0] 9.48=
8429
        Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Role: Central (0x00)
> HCI Event: Command Status (0x0f) plen 4                    #3 [hci0] 9.48=
9257
      Accept Connection Request (0x01|0x0009) ncmd 1
        Status: Success (0x00)
> HCI Event: Role Change (0x12) plen 8                       #4 [hci0] 9.74=
4476
        Status: Success (0x00)
        Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Role: Central (0x00)
> HCI Event: Connect Complete (0x03) plen 11                 #5 [hci0] 9.75=
1445
        Status: Success (0x00)
        Handle: 2
        Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Link type: ACL (0x01)
        Encryption: Disabled (0x00)
< HCI Command: Read Remote Supported.. (0x01|0x001b) plen 2  #6 [hci0] 9.75=
1700
        Handle: 2 Address: 40:98:4E:5B:XX:XX (Texas Instruments)
btmon[5009]: @ RAW Open: btmon (privileged) version 2.22      {0x0002} 9.75=
2457
btmon[5009]: @ RAW Close: btmon                               {0x0002} 9.75=
2483
> HCI Event: Command Status (0x0f) plen 4                    #7 [hci0] 9.76=
2334
      Read Remote Supported Features (0x01|0x001b) ncmd 1
        Status: Success (0x00)
> HCI Event: Read Remote Supported Features (0x0b) plen 11   #8 [hci0] 9.76=
3447
        Status: Success (0x00)
        Handle: 2 Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Features: 0xff 0xfe 0x2d 0xfe 0xdb 0xff 0x7b 0x87
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
          Power control
          Transparent synchronous data
          Flow control lag (middle bit)
          Enhanced Data Rate ACL 2 Mbps mode
          Enhanced Data Rate ACL 3 Mbps mode
          Enhanced inquiry scan
          Interlaced inquiry scan
          Interlaced page scan
          RSSI with inquiry results
          Extended SCO link (EV3 packets)
          EV4 packets
          EV5 packets
          AFH capable peripheral
          AFH classification peripheral
          LE Supported (Controller)
          3-slot Enhanced Data Rate ACL packets
          5-slot Enhanced Data Rate ACL packets
          Sniff subrating
          Pause encryption
          AFH capable central
          AFH classification central
          Enhanced Data Rate eSCO 2 Mbps mode
          Enhanced Data Rate eSCO 3 Mbps mode
          3-slot Enhanced Data Rate eSCO packets
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
< HCI Command: Read Remote Extended... (0x01|0x001c) plen 3  #9 [hci0] 9.76=
3529
        Handle: 2 Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Page: 1
> HCI Event: Command Status (0x0f) plen 4                   #10 [hci0] 9.76=
4317
      Read Remote Extended Features (0x01|0x001c) ncmd 1
        Status: Success (0x00)
> HCI Event: Max Slots Change (0x1b) plen 3                 #11 [hci0] 9.76=
6316
        Handle: 2 Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Max slots: 5
> HCI Event: Read Remote Extended Features (0x23) plen 13   #12 [hci0] 9.76=
7332
        Status: Success (0x00)
        Handle: 2 Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Page: 1/1
        Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
          Secure Simple Pairing (Host Support)
< HCI Command: Remote Name Request (0x01|0x0019) plen 10    #13 [hci0] 9.76=
7816
        Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Page scan repetition mode: R2 (0x02)
        Page scan mode: Mandatory (0x00)
        Clock offset: 0x0000
< ACL Data TX: Handle 2 flags 0x00 dlen 10                  #14 [hci0] 9.76=
7848
      L2CAP: Information Request (0x0a) ident 1 len 2
        Type: Extended features supported (0x0002)
> HCI Event: Command Status (0x0f) plen 4                   #15 [hci0] 9.76=
9323
      Remote Name Request (0x01|0x0019) ncmd 1
        Status: Success (0x00)
> HCI Event: Number of Completed Packets (0x13) plen 5      #16 [hci0] 9.77=
0377
        Num handles: 1
        Handle: 2 Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Count: 1
        #14: len 10 (40 Kb/s)
        Latency: 2 msec (2-2 msec ~2 msec)
> ACL Data RX: Handle 2 flags 0x02 dlen 10                  #17 [hci0] 9.77=
5053
      L2CAP: Information Request (0x0a) ident 1 len 2
        Type: Extended features supported (0x0002)
> ACL Data RX: Handle 2 flags 0x02 dlen 16                  #18 [hci0] 9.77=
5063
      L2CAP: Information Response (0x0b) ident 1 len 8
        Type: Extended features supported (0x0002)
        Result: Success (0x0000)
        Features: 0x00000080
          Fixed Channels
< ACL Data TX: Handle 2 flags 0x00 dlen 16                  #19 [hci0] 9.77=
5116
      L2CAP: Information Response (0x0b) ident 1 len 8
        Type: Extended features supported (0x0002)
        Result: Success (0x0000)
        Features: 0x000002b8
          Enhanced Retransmission Mode
          Streaming Mode
          FCS Option
          Fixed Channels
          Unicast Connectionless Data Reception
< ACL Data TX: Handle 2 flags 0x00 dlen 10                  #20 [hci0] 9.77=
5143
      L2CAP: Information Request (0x0a) ident 2 len 2
        Type: Fixed channels supported (0x0003)
> HCI Event: Remote Name Req Complete (0x07) plen 255       #21 [hci0] 9.78=
8378
        Status: Success (0x00)
        Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Name: Nokia N9
@ MGMT Event: Device Connected (0x000b) plen 28        {0x0001} [hci0] 9.78=
8417
        BR/EDR Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Flags: 0x00000000
        Data length: 15
        Name (complete): Nokia N9
        Class: 0x5a020c
          Major class: Phone (cellular, cordless, payphone, modem)
          Minor class: Smart phone
          Networking (LAN, Ad hoc)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Telephony (Cordless telephony, Modem, Headset)
> HCI Event: Number of Completed Packets (0x13) plen 5      #22 [hci0] 9.78=
9334
        Num handles: 1
        Handle: 2 Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Count: 1
        #19: len 16 (9 Kb/s)
        Latency: 14 msec (2-14 msec ~8 msec)
> HCI Event: Number of Completed Packets (0x13) plen 5      #23 [hci0] 9.79=
0331
        Num handles: 1
        Handle: 2 Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Count: 1
        #20: len 10 (5 Kb/s)
        Latency: 15 msec (2-15 msec ~11 msec)
> ACL Data RX: Handle 2 flags 0x02 dlen 10                  #24 [hci0] 9.81=
9039
      L2CAP: Information Request (0x0a) ident 2 len 2
        Type: Fixed channels supported (0x0003)
> ACL Data RX: Handle 2 flags 0x02 dlen 20                  #25 [hci0] 9.81=
9044
      L2CAP: Information Response (0x0b) ident 2 len 12
        Type: Fixed channels supported (0x0003)
        Result: Success (0x0000)
        Channels: 0x0000000000000002
          L2CAP Signaling (BR/EDR)
< ACL Data TX: Handle 2 flags 0x00 dlen 20                  #26 [hci0] 9.81=
9216
      L2CAP: Information Response (0x0b) ident 2 len 12
        Type: Fixed channels supported (0x0003)
        Result: Success (0x0000)
        Channels: 0x0000000000000086
          L2CAP Signaling (BR/EDR)
          Connectionless reception
          Security Manager (BR/EDR)
> HCI Event: Number of Completed Packets (0x13) plen 5      #27 [hci0] 9.82=
2375
        Num handles: 1
        Handle: 2 Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Count: 1
        #26: len 20 (53 Kb/s)
        Latency: 3 msec (2-15 msec ~7 msec)
> ACL Data RX: Handle 2 flags 0x02 dlen 12                  #28 [hci0] 9.85=
5118
      L2CAP: Connection Request (0x02) ident 3 len 4
        PSM: 1 (0x0001)
        Source CID: 64
< ACL Data TX: Handle 2 flags 0x00 dlen 16                  #29 [hci0] 9.85=
5186
      L2CAP: Connection Response (0x03) ident 3 len 8
        Destination CID: 64
        Source CID: 64
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
< ACL Data TX: Handle 2 flags 0x00 dlen 12                  #30 [hci0] 9.85=
5217
      L2CAP: Configure Request (0x04) ident 3 len 4
        Destination CID: 64
        Flags: 0x0000
> HCI Event: Number of Completed Packets (0x13) plen 5      #31 [hci0] 9.85=
9423
        Num handles: 1
        Handle: 2 Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Count: 1
        #29: len 16 (32 Kb/s)
        Latency: 4 msec (2-15 msec ~5 msec)
> HCI Event: Number of Completed Packets (0x13) plen 5      #32 [hci0] 9.86=
1369
        Num handles: 1
        Handle: 2 Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Count: 1
        #30: len 12 (16 Kb/s)
        Latency: 6 msec (2-15 msec ~6 msec)
> ACL Data RX: Handle 2 flags 0x02 dlen 12                  #33 [hci0] 9.87=
9041
      L2CAP: Configure Request (0x04) ident 4 len 4
        Destination CID: 64
        Flags: 0x0000
> ACL Data RX: Handle 2 flags 0x02 dlen 18                  #34 [hci0] 9.87=
9049
      L2CAP: Configure Response (0x05) ident 3 len 10
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 672
< ACL Data TX: Handle 2 flags 0x00 dlen 18                  #35 [hci0] 9.87=
9101
      L2CAP: Configure Response (0x05) ident 4 len 10
        Source CID: 64
        Flags: 0x0000
        Result: Success (0x0000)
        Option: Maximum Transmission Unit (0x01) [mandatory]
          MTU: 672
> HCI Event: Number of Completed Packets (0x13) plen 5      #36 [hci0] 9.88=
2375
        Num handles: 1
        Handle: 2 Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Count: 1
        #35: len 18 (48 Kb/s)
        Latency: 3 msec (2-15 msec ~4 msec)
> ACL Data RX: Handle 2 flags 0x02 dlen 38                  #37 [hci0] 9.90=
7023
      Channel: 64 len 34 [PSM 1 mode Basic (0x00)] {chan 0}
      SDP: Service Search Attribute Request (0x06) tid 0 len 29
        Search pattern: [len 19]
          Sequence (6) with 17 bytes [8 extra bits] len 19
            UUID (3) with 16 bytes [0 extra bits] len 17
              00001105-0000-1000-8000-00805f9b34fb
              OBEX Object Push
        Max record count: 65535
        Attribute list: [len 7]
          Sequence (6) with 5 bytes [8 extra bits] len 7
            Unsigned Integer (1) with 4 bytes [0 extra bits] len 5
              0x0000ffff
        Continuation state: 0
bluetoothd[4955]: < ACL Data TX: Hand.. flags 0x00 dlen 14  #38 [hci0] 9.90=
7438
      Channel: 64 len 10 [PSM 1 mode Basic (0x00)] {chan 0}
      SDP: Service Search Attribute Response (0x07) tid 0 len 5
        Attribute bytes: 2
        Continuation state: 0
> HCI Event: Number of Completed Packets (0x13) plen 5      #39 [hci0] 9.91=
2402
        Num handles: 1
        Handle: 2 Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Count: 1
        #38: len 14 (28 Kb/s)
        Latency: 4 msec (2-15 msec ~4 msec)
        Channel: 64 [PSM 1 mode Basic (0x00)] {chan 0}
        Channel Latency: 4 msec (4-4 msec ~4 msec)
> ACL Data RX: Handle 2 flags 0x02 dlen 12                  #40 [hci0] 9.93=
1035
      L2CAP: Disconnection Request (0x06) ident 5 len 4
        Destination CID: 64
        Source CID: 64
< ACL Data TX: Handle 2 flags 0x00 dlen 12                  #41 [hci0] 9.93=
1127
      L2CAP: Disconnection Response (0x07) ident 5 len 4
        Destination CID: 64
        Source CID: 64
> HCI Event: Number of Completed Packets (0x13) plen 5      #42 [hci0] 9.93=
4404
        Num handles: 1
        Handle: 2 Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Count: 1
        #41: len 12 (32 Kb/s)
        Latency: 3 msec (2-15 msec ~4 msec)
> HCI Event: Disconnect Complete (0x05) plen 4             #43 [hci0] 12.10=
5651
        Status: Success (0x00)
        Handle: 2 Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Reason: Remote User Terminated Connection (0x13)
@ MGMT Event: Device Disconnected (0x000c) plen 8     {0x0001} [hci0] 12.10=
5751
        BR/EDR Address: 40:98:4E:5B:XX:XX (Texas Instruments)
        Reason: Connection terminated by remote host (0x03)
```

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
