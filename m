Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB9AC43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 21:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiFQVRQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 17:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiFQVRP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 17:17:15 -0400
Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0178820BDB
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 14:17:13 -0700 (PDT)
Received: from github.com (hubbernetes-node-0fa589c.ash1-iad.github.net [10.56.200.62])
        by smtp.github.com (Postfix) with ESMTPA id 39B53900836
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1655500633;
        bh=d11ims8TdRwe8sEQmQBWl0HuDUIwTkzBp2ai45syN8Y=;
        h=Date:From:To:Subject:From;
        b=g9qDHsL/DkZFzXgn3CrSX0iyjxfx5K/OOGdJMUMU0dmWiRThZ77J8X4CHRA1mBpvD
         UnBMjGx6NUdcSTq5Z2gnfEIxUhO7KHrOVwu5nGvDRR9v+fdpnpS0h4WjEv0u7y/Mql
         DvO+X2C//1gIMKL4iOMwS4kBt1OL7u9UnIwF2omQ=
Date:   Fri, 17 Jun 2022 14:17:13 -0700
From:   Tedd Ho-Jeong An <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/afc8c8-3075ff@github.com>
Subject: [bluez/bluez] c53cb7: monitor/att: Print attribute information on
 ATT_RE...
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
  Commit: c53cb7be2d61e7bdf26c20f61f94d572068d5c6b
      https://github.com/bluez/bluez/commit/c53cb7be2d61e7bdf26c20f61f94d572068d5c6b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-06-16 (Thu, 16 Jun 2022)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Print attribute information on ATT_REQ_RSP

This prints the attribute information on ATT_REQ_RSP to make it easier
to identify to which handle the response is for:

> ACL Data RX: Handle 42 flags 0x02 dlen 9
      Channel: 65 len 5 sdu 3 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
      ATT: Read Response (0x0b) len 2
        Value: 0300
        Handle: 0x0030 Type: Source ASE (0x2bc5)
            ASE ID: 3
            State: Idle (0x00)


  Commit: 5da3c0387baf4a6bc984263350ea53fa511f87c7
      https://github.com/bluez/bluez/commit/5da3c0387baf4a6bc984263350ea53fa511f87c7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-06-16 (Thu, 16 Jun 2022)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Add decoding support for PAC Sink/Source Location

This adds decoding support for PAC Sink/Source Location attributes:

> ACL Data RX: Handle 42 flags 0x02 dlen 9
      Channel: 65 len 5 sdu 3 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
      ATT: Read Request (0x0a) len 2
        Handle: 0x001a Type: Sink Audio Locations (0x2bca)
< ACL Data TX: Handle 42 flags 0x00 dlen 11
      Channel: 64 len 7 sdu 5 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
      ATT: Read Response (0x0b) len 4
        Value: 03000000
        Handle: 0x001a Type: Sink Audio Locations (0x2bca)
           Location: 0x00000003
              Front Left (0x00000001)
              Front Right (0x00000002)


  Commit: 2bdb79cf8173daa0c44d692fcbd7d7408b4fd994
      https://github.com/bluez/bluez/commit/2bdb79cf8173daa0c44d692fcbd7d7408b4fd994
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-06-16 (Thu, 16 Jun 2022)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Add decoding support for PAC Audio Context

This adds decoding support for PAC Audio Context attributes:

> ACL Data RX: Handle 42 flags 0x02 dlen 9
      Channel: 65 len 5 sdu 3 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
      ATT: Read Request (0x0a) len 2
        Handle: 0x0026 Type: Supported Audio Contexts (0x2bce)
< ACL Data TX: Handle 42 flags 0x00 dlen 11
      Channel: 64 len 7 sdu 5 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
      ATT: Read Response (0x0b) len 4
        Value: ff0f0e00
        Handle: 0x0026 Type: Supported Audio Contexts (0x2bce)
            Sink Context: 0x0fff
              Unspecified (0x0001)
              Conversational (0x0002)
              Media (0x0004)
              Game (0x0008)
              Instructional (0x0010)
              Voice Assistants (0x0020)
              Live (0x0040)
              Sound Effects (0x0080)
              Notifications (0x0100)
              Ringtone (0x0200)
              Alerts (0x0400)
              Emergency alarm (0x0800)
            Source Context: 0x000e
              Conversational (0x0002)
              Media (0x0004)
              Game (0x0008)


  Commit: bf5a7c604ff7aa312c8f98c19c0cb2b00d95e482
      https://github.com/bluez/bluez/commit/bf5a7c604ff7aa312c8f98c19c0cb2b00d95e482
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-06-16 (Thu, 16 Jun 2022)

  Changed paths:
    M monitor/att.c
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor/att: Add LTV deconding support for PAC/ASE

This adds decoding support for PAC/ASE attributes:

> ACL Data RX: Handle 42 flags 0x02 dlen 31
      Channel: 65 len 27 sdu 25 [PSM 39 mode Enhanced Credit (0x81)] {chan 1}
      ATT: Read Response (0x0b) len 24
        Value: 010600000000100301ff0002020302030305041e00f00000
          Number of PAC(s): 1
          PAC #0:
            Codec: LC3 (0x06)
            Codec Specific Capabilities #0: len 0x03 type 0x01
              Sampling Frequencies: 0x00ff
                8 Khz (0x0001)
                11.25 Khz (0x0002)
                16 Khz (0x0004)
                22.05 Khz (0x0008)
                24 Khz (0x0010)
                32 Khz (0x0020)
                44.1 Khz (0x0040)
                48 Khz (0x0080)
            Codec Specific Capabilities #1: len 0x02 type 0x02
              Frame Duration: 0x0003
                7.5 ms (0x01)
                10 ms (0x02)
            Codec Specific Capabilities #2: len 0x02 type 0x03
              Audio Channel Count: 0x03
                1 channel (0x01)
                2 channels (0x02)
            Codec Specific Capabilities #3: len 0x05 type 0x04
              Frame Length: 30 (0x001e) - 240 (0x00f0)
> ACL Data RX: Handle 42 flags 0x02 dlen 30
      Channel: 64 len 26 sdu 24 [PSM 39 mode Enhanced Credit (0x81)] {chan 0}
      ATT: Write Command (0x52) len 23
        Handle: 0x0036 Type: ASE Control Point (0x2bc6)
          Data: 010101020206000000000a02010302020103042800
            Opcode: Codec Configuration (0x01)
            Number of ASE(s): 1
            ASE: #0
            ASE ID: 0x01
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: LC3 (0x06)
            Codec Specific Configuration #0: len 0x02 type 0x01
            Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration #1: len 0x02 type 0x02
            Frame Duration: 10 ms (0x01)
            Codec Specific Configuration #2: len 0x03 type 0x04
            Frame Length: 40 (0x0028)


  Commit: 7378408ed4da2267ea7f5fbaff38de57ea75c950
      https://github.com/bluez/bluez/commit/7378408ed4da2267ea7f5fbaff38de57ea75c950
  Author: Tedd Ho-Jeong An <tedd.an@intel.com>
  Date:   2022-06-17 (Fri, 17 Jun 2022)

  Changed paths:
    M doc/mgmt-api.txt

  Log Message:
  -----------
  doc/mgmt-api: Update for Add Extended Advertisement Command

This patch aligns the input parameter for Add Extended Advertisement
command with actual data struct and add missing flag descriptions.


  Commit: 2479a013a2028d419c713b9e41ee55e2851533f4
      https://github.com/bluez/bluez/commit/2479a013a2028d419c713b9e41ee55e2851533f4
  Author: Tedd Ho-Jeong An <tedd.an@intel.com>
  Date:   2022-06-17 (Fri, 17 Jun 2022)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Update flag information for Extended Advertismement

This patch updates the missing flag details for Advertisement flags

@ MGMT Event: Command Complete (0x0001) plen 11
      Read Advertising Features (0x003d) plen 8
        Status: Success (0x00)
        Flags: 0x0001ffff
	...
          Unknown advertising flag (0x00010c00)
	...


  Commit: 3075ff8fffec894d0518540c9435e870f98750b7
      https://github.com/bluez/bluez/commit/3075ff8fffec894d0518540c9435e870f98750b7
  Author: Tedd Ho-Jeong An <tedd.an@intel.com>
  Date:   2022-06-17 (Fri, 17 Jun 2022)

  Changed paths:
    M tools/btmgmt.c

  Log Message:
  -----------
  tools/btmgmt: Add support Add Ext Adv command

This patch adds new command to support the following MGMT API:
 Add Extended Advertising Parameters Command
 Add Extended Advertising Data Command


Compare: https://github.com/bluez/bluez/compare/afc8c8f56fa2...3075ff8fffec
