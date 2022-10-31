Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948D5C38A02
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 11:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiJaLJq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 07:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiJaLJp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 07:09:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56A8E021
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 04:09:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35431B815BB
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 11:09:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1C72C43470
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 11:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667214580;
        bh=oaOxARE5K59owZHn89aUbpMA2pYpaxGoqbqiY6w5MbA=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=mm99lGMg0GWfj53kq0PWr9L7A3zUTdQ67fGwuFz79pAsNLaVvtk/Gr6NXFd5EO5rU
         u8cdKvJWMJ9fXf2lX8NeAiSgFdc7hQ+bzksBcRcrIAbblJMSH9C/cvgZDCpV+FC2BP
         mxGmI0TD7KZ2WPFPrQfKAXnLRZbtrEDij0AlxzR/AHRpIWdAj+BrcaIIDtyPCILnBd
         V8cPrMP2ULCCGRivOaB52+vyLDEeWF8WWNsW46ht2lGpDDw79b2086+zfdVHjHk5zQ
         yTtdMqOJ6qI8H6UIyBI1EzQNSK7WMOsYNTiS5NJRyIVg32kBLsraeIwVNzk8K7GOAY
         mu8Cr2M0NfKMQ==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
        id C42ACC433E7; Mon, 31 Oct 2022 11:09:40 +0000 (UTC)
From:   bugzilla-daemon@kernel.org
To:     linux-bluetooth@vger.kernel.org
Subject: [Bug 60824] [PATCH][regression] Cambridge Silicon Radio, Ltd
 Bluetooth Dongle unusable
Date:   Mon, 31 Oct 2022 11:09:37 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: justanormaltinkerermihir@duck.com
X-Bugzilla-Status: REOPENED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-60824-62941-Ex6FZZIsCZ@https.bugzilla.kernel.org/>
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

--- Comment #250 from justanormaltinkerermihir@duck.com ---
It seems that my terminal failed to copy the last line of the commands
correctly so here it fixed:

< HCI Command: Read Local Version In.. (0x04|0x0001) plen 0  #1 [hci0] 9.44=
8239
> HCI Event: Command Complete (0x0e) plen 12                 #2 [hci0] 9.45=
0137
      Read Local Version Information (0x04|0x0001) ncmd 1
        Status: Success (0x00)
        HCI version: Bluetooth 5.0 (0x09) - Revision 2064 (0x0810)
        LMP version: Bluetooth 5.0 (0x09) - Subversion 8978 (0x2312)
        Manufacturer: Cambridge Silicon Radio (10)


< HCI Command: Read Local Support.. (0x04|0x0002) plen 0  #127 [hci0] 10.18=
8575
> HCI Event: Command Complete (0x0e) plen 68              #128 [hci0] 10.19=
4513
      Read Local Supported Commands (0x04|0x0002) ncmd 1
        Status: Success (0x00)
        Commands: 163 entries
          Inquiry (Octet 0 - Bit 0)
          Inquiry Cancel (Octet 0 - Bit 1)
          Periodic Inquiry Mode (Octet 0 - Bit 2)
          Exit Periodic Inquiry Mode (Octet 0 - Bit 3)
          Create Connection (Octet 0 - Bit 4)
          Disconnect (Octet 0 - Bit 5)
          Create Connection Cancel (Octet 0 - Bit 7)
          Accept Connection Request (Octet 1 - Bit 0)
          Reject Connection Request (Octet 1 - Bit 1)
          Link Key Request Reply (Octet 1 - Bit 2)
          Link Key Request Negative Reply (Octet 1 - Bit 3)
          PIN Code Request Reply (Octet 1 - Bit 4)
          PIN Code Request Negative Reply (Octet 1 - Bit 5)
          Change Connection Packet Type (Octet 1 - Bit 6)
          Authentication Requested (Octet 1 - Bit 7)
          Set Connection Encryption (Octet 2 - Bit 0)
          Change Connection Link Key (Octet 2 - Bit 1)
          Temporary Link Key (Octet 2 - Bit 2)
          Remote Name Request (Octet 2 - Bit 3)
          Remote Name Request Cancel (Octet 2 - Bit 4)
          Read Remote Supported Features (Octet 2 - Bit 5)
          Read Remote Extended Features (Octet 2 - Bit 6)
          Read Remote Version Information (Octet 2 - Bit 7)
          Read Clock Offset (Octet 3 - Bit 0)
          Read LMP Handle (Octet 3 - Bit 1)
          Hold Mode (Octet 4 - Bit 1)
          Sniff Mode (Octet 4 - Bit 2)
          Exit Sniff Mode (Octet 4 - Bit 3)
          Park State (Octet 4 - Bit 4)
          Exit Park State (Octet 4 - Bit 5)
          QoS Setup (Octet 4 - Bit 6)
          Role Discovery (Octet 4 - Bit 7)
          Switch Role (Octet 5 - Bit 0)
          Read Link Policy Settings (Octet 5 - Bit 1)
          Write Link Policy Settings (Octet 5 - Bit 2)
          Read Default Link Policy Settings (Octet 5 - Bit 3)
          Write Default Link Policy Settings (Octet 5 - Bit 4)
          Flow Specification (Octet 5 - Bit 5)
          Set Event Mask (Octet 5 - Bit 6)
          Reset (Octet 5 - Bit 7)
          Set Event Filter (Octet 6 - Bit 0)
          Flush (Octet 6 - Bit 1)
          Read PIN Type (Octet 6 - Bit 2)
          Write PIN Type (Octet 6 - Bit 3)
          Create New Unit Key (Octet 6 - Bit 4)
          Read Stored Link Key (Octet 6 - Bit 5)
          Write Stored Link Key (Octet 6 - Bit 6)
          Delete Stored Link Key (Octet 6 - Bit 7)
          Write Local Name (Octet 7 - Bit 0)
          Read Local Name (Octet 7 - Bit 1)
          Read Connection Accept Timeout (Octet 7 - Bit 2)
          Write Connection Accept Timeout (Octet 7 - Bit 3)
          Read Page Timeout (Octet 7 - Bit 4)
          Write Page Timeout (Octet 7 - Bit 5)
          Read Scan Enable (Octet 7 - Bit 6)
          Write Scan Enable (Octet 7 - Bit 7)
          Read Page Scan Activity (Octet 8 - Bit 0)
          Write Page Scan Activity (Octet 8 - Bit 1)
          Read Inquiry Scan Activity (Octet 8 - Bit 2)
          Write Inquiry Scan Activity (Octet 8 - Bit 3)
          Read Class of Device (Octet 9 - Bit 0)
          Write Class of Device (Octet 9 - Bit 1)
          Read Voice Setting (Octet 9 - Bit 2)
          Write Voice Setting (Octet 9 - Bit 3)
          Read Automatic Flush Timeout (Octet 9 - Bit 4)
          Write Automatic Flush Timeout (Octet 9 - Bit 5)
          Read Num Broadcast Retransmissions (Octet 9 - Bit 6)
          Write Num Broadcast Retransmissions (Octet 9 - Bit 7)
          Read Hold Mode Activity (Octet 10 - Bit 0)
          Write Hold Mode Activity (Octet 10 - Bit 1)
          Read Transmit Power Level (Octet 10 - Bit 2)
          Read Sync Flow Control Enable (Octet 10 - Bit 3)
          Write Sync Flow Control Enable (Octet 10 - Bit 4)
          Set Controller To Host Flow Control (Octet 10 - Bit 5)
          Host Buffer Size (Octet 10 - Bit 6)
          Host Number of Completed Packets (Octet 10 - Bit 7)
          Read Link Supervision Timeout (Octet 11 - Bit 0)
          Write Link Supervision Timeout (Octet 11 - Bit 1)
          Read Number of Supported IAC (Octet 11 - Bit 2)
          Read Current IAC LAP (Octet 11 - Bit 3)
          Write Current IAC LAP (Octet 11 - Bit 4)
          Set AFH Host Channel Classification (Octet 12 - Bit 1)
          Read Inquiry Scan Type (Octet 12 - Bit 4)
          Write Inquiry Scan Type (Octet 12 - Bit 5)
          Read Inquiry Mode (Octet 12 - Bit 6)
          Write Inquiry Mode (Octet 12 - Bit 7)
          Read Page Scan Type (Octet 13 - Bit 0)
          Write Page Scan Type (Octet 13 - Bit 1)
          Read AFH Channel Assessment Mode (Octet 13 - Bit 2)
          Write AFH Channel Assessment Mode (Octet 13 - Bit 3)
          Read Local Version Information (Octet 14 - Bit 3)
          Read Local Supported Features (Octet 14 - Bit 5)
          Read Local Extended Features (Octet 14 - Bit 6)
          Read Buffer Size (Octet 14 - Bit 7)
          Read BD ADDR (Octet 15 - Bit 1)
          Read Failed Contact Counter (Octet 15 - Bit 2)
          Reset Failed Contact Counter (Octet 15 - Bit 3)
          Read Link Quality (Octet 15 - Bit 4)
          Read RSSI (Octet 15 - Bit 5)
          Read AFH Channel Map (Octet 15 - Bit 6)
          Read Clock (Octet 15 - Bit 7)
          Read Loopback Mode (Octet 16 - Bit 0)
          Write Loopback Mode (Octet 16 - Bit 1)
          Enable Device Under Test Mode (Octet 16 - Bit 2)
          Setup Synchronous Connection (Octet 16 - Bit 3)
          Accept Synchronous Connection Request (Octet 16 - Bit 4)
          Reject Synchronous Connection Request (Octet 16 - Bit 5)
          Read Extended Inquiry Response (Octet 17 - Bit 0)
          Write Extended Inquiry Response (Octet 17 - Bit 1)
          Refresh Encryption Key (Octet 17 - Bit 2)
          Sniff Subrating (Octet 17 - Bit 4)
          Read Simple Pairing Mode (Octet 17 - Bit 5)
          Write Simple Pairing Mode (Octet 17 - Bit 6)
          Read Local OOB Data (Octet 17 - Bit 7)
          Read Inquiry Response TX Power Level (Octet 18 - Bit 0)
          Write Inquiry Transmit Power Level (Octet 18 - Bit 1)
          Read Default Erroneous Data Reporting (Octet 18 - Bit 2)
          Write Default Erroneous Data Reporting (Octet 18 - Bit 3)
          IO Capability Request Reply (Octet 18 - Bit 7)
          User Confirmation Request Reply (Octet 19 - Bit 0)
          User Confirmation Request Neg Reply (Octet 19 - Bit 1)
          User Passkey Request Reply (Octet 19 - Bit 2)
          User Passkey Request Negative Reply (Octet 19 - Bit 3)
          Remote OOB Data Request Reply (Octet 19 - Bit 4)
          Write Simple Pairing Debug Mode (Octet 19 - Bit 5)
          Enhanced Flush (Octet 19 - Bit 6)
          Remote OOB Data Request Neg Reply (Octet 19 - Bit 7)
          Send Keypress Notification (Octet 20 - Bit 2)
          IO Capability Request Negative Reply (Octet 20 - Bit 3)
          Read Encryption Key Size (Octet 20 - Bit 4)
          Read Enhanced Transmit Power Level (Octet 24 - Bit 0)
          Read LE Host Supported (Octet 24 - Bit 5)
          Write LE Host Supported (Octet 24 - Bit 6)
          LE Set Event Mask (Octet 25 - Bit 0)
          LE Read Buffer Size (Octet 25 - Bit 1)
          LE Read Local Supported Features (Octet 25 - Bit 2)
          LE Set Random Address (Octet 25 - Bit 4)
          LE Set Advertising Parameters (Octet 25 - Bit 5)
          LE Read Advertising Channel TX Power (Octet 25 - Bit 6)
          LE Set Advertising Data (Octet 25 - Bit 7)
          LE Set Scan Response Data (Octet 26 - Bit 0)
          LE Set Advertise Enable (Octet 26 - Bit 1)
          LE Set Scan Parameters (Octet 26 - Bit 2)
          LE Set Scan Enable (Octet 26 - Bit 3)
          LE Create Connection (Octet 26 - Bit 4)
          LE Create Connection Cancel (Octet 26 - Bit 5)
          LE Read Accept List Size (Octet 26 - Bit 6)
          LE Clear Accept List (Octet 26 - Bit 7)
          LE Add Device To Accept List (Octet 27 - Bit 0)
          LE Remove Device From Accept List (Octet 27 - Bit 1)
          LE Connection Update (Octet 27 - Bit 2)
          LE Set Host Channel Classification (Octet 27 - Bit 3)
          LE Read Channel Map (Octet 27 - Bit 4)
          LE Read Remote Used Features (Octet 27 - Bit 5)
          LE Encrypt (Octet 27 - Bit 6)
          LE Rand (Octet 27 - Bit 7)
          LE Start Encryption (Octet 28 - Bit 0)
          LE Long Term Key Request Reply (Octet 28 - Bit 1)
          LE Long Term Key Request Neg Reply (Octet 28 - Bit 2)
          LE Read Supported States (Octet 28 - Bit 3)
          LE Receiver Test (Octet 28 - Bit 4)
          LE Transmitter Test (Octet 28 - Bit 5)
          LE Test End (Octet 28 - Bit 6)


< HCI Command: Read Local Support.. (0x04|0x0003) plen 0  #121 [hci0] 10.18=
2585
> HCI Event: Command Complete (0x0e) plen 12              #122 [hci0] 10.18=
4514
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
          AFH capable peripheral
          AFH classification peripheral
          LE Supported (Controller)
          3-slot Enhanced Data Rate ACL packets
          5-slot Enhanced Data Rate ACL packets
          Pause encryption
          AFH capable central
          AFH classification central
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

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
