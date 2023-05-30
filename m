Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72B4C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 23:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbjE3XbT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 19:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjE3XbS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 19:31:18 -0400
Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033C7F7
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 16:31:11 -0700 (PDT)
Received: from github.com (hubbernetes-node-be35c4e.ash1-iad.github.net [10.56.201.97])
        by smtp.github.com (Postfix) with ESMTPA id 380409001E7
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 16:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1685489471;
        bh=f7yGwqpk/+98NIolPW8cSBTKcbor+bGqDMdp/2VGSyY=;
        h=Date:From:To:Subject:From;
        b=Pdm3QD700M1G5woxkoxFOkuzwuyC1QC6N08qU6DJcR78uplviIY2ZFtta/nTWxYiP
         fkBN9KUv/TiI3gshMooVkL/mWW/3Ma1LG9JTqp5VQhzIVJYA+ALUy0RqScZij0m0Fo
         FfyOXc9m82S9nV2fYZk7A/j+4K8QncC22vKHvNcc=
Date:   Tue, 30 May 2023 16:31:11 -0700
From:   iulia-tanasescu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/15eb57-1248bd@github.com>
Subject: [bluez/bluez] 8ff103: isotest: Add support for creating/synchronizing
 to...
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 8ff103f9939798521f06d36dd7bf4e0f7fc2dd08
      https://github.com/bluez/bluez/commit/8ff103f9939798521f06d36dd7bf4e0f7fc2dd08
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-05-30 (Tue, 30 May 2023)

  Changed paths:
    M tools/isotest.c
    M tools/isotest.rst

  Log Message:
  -----------
  isotest: Add support for creating/synchronizing to multiple BISes

This adds an additional command line option for the Broadcast exercise,
so that the user can indicate the number of BISes to create as part of a
BIG (Broadcast Source), or the number of BISes to synchronize
to (Broadcast Sink).

For the Broadcast Source exercise, issue the following command,
in order to create a BIG with handle 0x01, associated with the
advertising handle 0x01, with 2 BISes:

    tools/isotest -i hci0 -s 00:00:00:00:00:00 -N 2 -G 1 -T 1

The isotest and btmon logs will look something like this:

isotest[7178]: mgmt socket: fd 3
isotest[7178]: mgmt_set_le: err 0
isotest[7178]: mgmt_set_experimental: err 0
isotest[7179]: Exit
isotest[7178]: Connecting 00:00:00:00:00:00 ...
isotest[7178]: Connected [00:00:00:00:00:00]
isotest[7178]: QoS [BIG 0x01 BIS 0x01 Packing 0x00 Framing 0x00 Encryption 0x00]
isotest[7178]: Input QoS [Interval 10000 us Latency 10 ms SDU 0 PHY 0x00 RTN 2]
isotest[7178]: Output QoS [Interval 10000 us Latency 10 ms SDU 40 PHY 0x02 RTN 2]
isotest[7178]: Connecting 00:00:00:00:00:00 ...
isotest[7178]: Connected [00:00:00:00:00:00]
isotest[7178]: QoS [BIG 0x01 BIS 0x01 Packing 0x00 Framing 0x00 Encryption 0x00]
isotest[7178]: Input QoS [Interval 10000 us Latency 10 ms SDU 0 PHY 0x00 RTN 2]
isotest[7178]: Output QoS [Interval 10000 us Latency 10 ms SDU 40 PHY 0x02 RTN 2]
isotest[7183]: Sending ...
isotest[7183]: Number of packets: 1
isotest[7183]: Socket jitter buffer: 80 buffer
isotest[7183]: [seq 0] 40 bytes buffered 92 (3712 bytes)
isotest[7184]: Sending ...
isotest[7184]: Number of packets: 1
isotest[7184]: Socket jitter buffer: 80 buffer
isotest[7184]: [seq 0] 40 bytes buffered 92 (3712 bytes)
isotest[7178]: Exit

< HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068) plen 31
        Handle: 0x01
        Advertising Handle: 0x01
        Number of BIS: 2
        SDU Interval: 10000 us (0x002710)
        Maximum SDU size: 40
        Maximum Latency: 10 ms (0x000a)
        RTN: 0x02
        PHY: LE 2M (0x02)
        Packing: Sequential (0x00)
        Framing: Unframed (0x00)
        Encryption: 0x00
        Broadcast Code: 00000000000000000000000000000000

> HCI Event: Command Status (0x0f) plen 4
      LE Create Broadcast Isochronous Group (0x08|0x0068) ncmd 1
        Status: Success (0x00)

> HCI Event: LE Meta Event (0x3e) plen 23
      LE Broadcast Isochronous Group Complete (0x1b)
        Status: Success (0x00)
        Handle: 0x01
        BIG Synchronization Delay: 1974 us (0x0007b6)
        Transport Latency: 1974 us (0x0007b6)
        PHY: LE 2M (0x02)
        NSE: 3
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 10
        Connection Handle #1: 11

< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 10
        Data Path Direction: Input (Host to Controller) (0x00)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration:

> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 10

< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 11
        Data Path Direction: Input (Host to Controller) (0x00)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration:

> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 11

< ISO Data TX: Handle 10 flags 0x02 dlen 44

< ISO Data TX: Handle 11 flags 0x02 dlen 44

> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 10
        Count: 1

> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 11
        Count: 1

For the Broadcast Sink exercise, issue the following command,
in order to synchronize to the BISes created by the source:

    tools/isotest -i hci1 -r 36:13:00:E1:1B:F0 -V le_random -N 2 -G 1

The flow is shown by the isotest log and the filtered btmon snippet below:

isotest[4033]: mgmt socket: fd 3
isotest[4034]: Exit
isotest[4033]: mgmt_set_le: err 0
isotest[4033]: mgmt_set_experimental: err 0
isotest[4033]: Waiting for connection 36:13:00:E1:1B:F0...
isotest[4036]: Connected [36:13:00:E1:1B:F0]
isotest[4036]: QoS [BIG 0x01 BIS 0x00 Packing 0x00 Framing 0x00 Encryption 0x00]
isotest[4036]: Input QoS [Interval 1974 us Latency 10 ms SDU 40 PHY 0x00 RTN 0]
isotest[4036]: Output QoS [Interval 0 us Latency 0 ms SDU 0 PHY 0x00 RTN 0]
isotest[4036]: Receiving ...
isotest[4037]: Connected [36:13:00:E1:1B:F0]
isotest[4037]: QoS [BIG 0x01 BIS 0x00 Packing 0x00 Framing 0x00 Encryption 0x00]
isotest[4037]: Input QoS [Interval 1974 us Latency 10 ms SDU 40 PHY 0x00 RTN 0]
isotest[4037]: Output QoS [Interval 0 us Latency 0 ms SDU 0 PHY 0x00 RTN 0]
isotest[4037]: Receiving ...
isotest[4037]: [seq 0] 280 bytes in 6.48 sec speed 0.34 kb/s
isotest[4036]: [seq 0] 280 bytes in 6.54 sec speed 0.33 kb/s
isotest[4037]: [seq 1] 280 bytes in 7.01 sec speed 0.31 kb/s
isotest[4036]: [seq 1] 280 bytes in 7.02 sec speed 0.31 kb/s
isotest[4037]: [seq 2] 280 bytes in 7.06 sec speed 0.31 kb/s
isotest[4036]: [seq 2] 280 bytes in 7.04 sec speed 0.31 kb/s

< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044) plen 14
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x00
        Adv address type: Random (0x01)
        Adv address: 36:13:00:E1:1B:F0 (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 163840 msec (0x4000)
        Sync CTE type: 0x0000

> HCI Event: Command Status (0x0f) plen 4
      LE Periodic Advertising Create Sync (0x08|0x0044) ncmd 1
        Status: Success (0x00)

< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13
        Own address type: Public (0x00)
        Filter policy: Ignore not in accept list (0x01)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Passive (0x00)
          Interval: 60.000 msec (0x0060)
          Window: 30.000 msec (0x0030)
        Entry 1: LE Coded
          Type: Passive (0x00)
          Interval: 60.000 msec (0x0060)
          Window: 30.000 msec (0x0030)

> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 1
        Status: Success (0x00)

< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)

> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 1
        Status: Success (0x00)

> HCI Event: LE Meta Event (0x3e) plen 16
      LE Periodic Advertising Sync Established (0x0e)
        Status: Success (0x00)
        Sync handle: 0
        Advertising SID: 0x00
        Advertiser address type: Random (0x01)
        Advertiser address: 36:13:00:E1:1B:F0 (Non-Resolvable)
        Advertiser PHY: LE 2M (0x02)
        Periodic advertising interval: 10.00 msec (0x0008)
        Advertiser clock accuracy: 0x00

> HCI Event: LE Meta Event (0x3e) plen 8
      LE Periodic Advertising Report (0x0f)
        Sync handle: 0
        TX power: 127 dbm (0x7f)
        RSSI: -47 dBm (0xd1)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x00

> HCI Event: LE Meta Event (0x3e) plen 20
      LE Broadcast Isochronous Group Info Advertising Report (0x22)
        Sync Handle: 0x0000
        Number BIS: 2
        NSE: 3
        ISO Interval: 10.00 msec (0x0008)
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        SDU Interval: 10000 us (0x002710)
        Maximum SDU: 40
        PHY: LE 2M (0x02)
        Framing: Unframed (0x00)
        Encryption: 0x00

< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b) plen 26
        BIG Handle: 0x01
        BIG Sync Handle: 0x0000
        Encryption: Unencrypted (0x00)
        Broadcast Code: 00000000000000000000000000000000
        Maximum Number Subevents: 0x00
        Timeout: 163840 ms (0x4000)
        Number of BIS: 2
        BIS ID: 0x01
        BIS ID: 0x02

> HCI Event: LE Meta Event (0x3e) plen 19
      LE Broadcast Isochronous Group Sync Estabilished (0x1d)
        Status: Success (0x00)
        BIG Handle: 0x01
        Transport Latency: 1974 us (0x0007b6)
        NSE: 3
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 10
        Connection Handle #1: 11

< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 10
        Data Path Direction: Output (Controller to Host) (0x01)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration:

> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 10

< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 11
        Data Path Direction: Output (Controller to Host) (0x01)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration:

> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 11

> ISO Data RX: Handle 10 flags 0x06 dlen 48

> ISO Data RX: Handle 11 flags 0x06 dlen 48


  Commit: 97edc78bd81f7fe9ddac17feac69569ea64a215b
      https://github.com/bluez/bluez/commit/97edc78bd81f7fe9ddac17feac69569ea64a215b
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-05-30 (Tue, 30 May 2023)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Support multiple BIS

This adds support for creating a BIG with multiple BISes.


  Commit: 35d8c3b572dc20047edb6064edf9e0bd998896ad
      https://github.com/bluez/bluez/commit/35d8c3b572dc20047edb6064edf9e0bd998896ad
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-05-30 (Tue, 30 May 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add BAP Broadcast AC tests

This adds the following tests based on BAP Broadcast Audio Configurations:

ISO Broadcaster AC 12 - Success
ISO Broadcaster AC 13 - Success
ISO Broadcaster AC 14 - Success


  Commit: c39317ed42cbcdcf9330e3051743c87fc366125a
      https://github.com/bluez/bluez/commit/c39317ed42cbcdcf9330e3051743c87fc366125a
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-05-30 (Tue, 30 May 2023)

  Changed paths:
    M src/shared/bass.c

  Log Message:
  -----------
  shared/bass: Add Write Without Response property to the CP characteristic

This adds the Write Without Response property to the Broadcast Audio
Scan Control Point characteristic, which is mandatory according to
specification.


  Commit: 1248bdd432915e3cdac1561127aa723e2cf153be
      https://github.com/bluez/bluez/commit/1248bdd432915e3cdac1561127aa723e2cf153be
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-05-30 (Tue, 30 May 2023)

  Changed paths:
    M Makefile.am
    A unit/test-bass.c

  Log Message:
  -----------
  unit: Introduce test-bass

This adds 3 unit tests for BASS server, to simulate the
Generic GATT Integrated Test suite for BASS.

Test Summary
------------
BASS/SR/SGGIT/SER/BV-01-C                            Passed
BASS/SR/SGGIT/CHA/BV-01-C                            Passed
BASS/SR/SGGIT/CHA/BV-02-C                            Passed
Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0


Compare: https://github.com/bluez/bluez/compare/15eb57049b19...1248bdd43291
