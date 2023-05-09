Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBE4C77B7F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 May 2023 01:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjEIBUc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 May 2023 21:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjEIBUZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 May 2023 21:20:25 -0400
Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558209006
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 May 2023 18:20:23 -0700 (PDT)
Received: from github.com (hubbernetes-node-8104217.ac4-iad.github.net [10.52.138.23])
        by smtp.github.com (Postfix) with ESMTPA id 5FF5D60007D
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 May 2023 18:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1683595222;
        bh=8ksHmlikmB6nOGCpfpg3lD3C5jdbBMvMEAzoSEIJ6Qk=;
        h=Date:From:To:Subject:From;
        b=IwGHrz13XZpFLxWqkVGfvq2DgboC0GrUEEjChnqXH0UKcyGruLQCWGbfsnFbtjeoG
         PEM5VV0rXUZEmQAVHYFRYfD00efnEDZis23hl0ikncQPqwCw89mUnzf3JciXOUdLUN
         St+7mz6y1dGGp0LhUs3RPsTMvc1XNchdbwFiUnEI=
Date:   Mon, 08 May 2023 18:20:22 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6bafe1-acfa41@github.com>
Subject: [bluez/bluez] 6c81ba: monitor/att: Attempt to insert discovered
 attributes
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
  Commit: 6c81bae99bc593af75913951ed553842862e95a8
      https://github.com/bluez/bluez/commit/6c81bae99bc593af75913951ed553842862e95a8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-05 (Fri, 05 May 2023)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Attempt to insert discovered attributes

This attempts to insert discovered attributes into monitor gatt_db
instance if their respective discover procedures are used which enables
decoding traces injected by user via unit testing:

> sudo unit/test-bap -m -s "34

= test-bap: BAP/UCL/SCC/BV-034-C [UCL SNK Config Codec, VS] - run
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x0003 Type: Sink PAC (0x2bc9)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 8
        Handle: 0x0003 Type: Sink PAC (0x2bc9)
        Value: 01ff010001000000
          Number of PAC(s): 1
          PAC #0:
            Codec: Vendor specific (0xff)
            Codec Company ID: Nokia Mobile Phones (0x0001)
            Codec Vendor ID: 0x0001
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x0006 Type: Sink Audio Locations (0x2bca)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 4
        Handle: 0x0006 Type: Sink Audio Locations (0x2bca)
        Value: 03000000
           Location: 0x00000003
              Front Left (0x00000001)
              Front Right (0x00000002)
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x0009 Type: Source PAC (0x2bcb)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 8
        Handle: 0x0009 Type: Source PAC (0x2bcb)
        Value: 01ff010001000000
          Number of PAC(s): 1
          PAC #0:
            Codec: Vendor specific (0xff)
            Codec Company ID: Nokia Mobile Phones (0x0001)
            Codec Vendor ID: 0x0001
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x000c Type: Source Audio Locations (0x2bcc)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 4
        Handle: 0x000c Type: Source Audio Locations (0x2bcc)
        Value: 03000000
           Location: 0x00000003
              Front Left (0x00000001)
              Front Right (0x00000002)
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x000f Type: Available Audio Contexts (0x2bcd)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 4
        Handle: 0x000f Type: Available Audio Contexts (0x2bcd)
        Value: ff0f0e00
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
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x0012 Type: Supported Audio Contexts (0x2bce)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 4
        Handle: 0x0012 Type: Supported Audio Contexts (0x2bce)
        Value: ff0f0e00
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
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x0016 Type: Sink ASE (0x2bc4)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 2
        Handle: 0x0016 Type: Sink ASE (0x2bc4)
        Value: 0100
            ASE ID: 1
            State: Idle (0x00)
> test-bap: User Data RX
      ATT: Write Request (0x12) len 4
        Handle: 0x0017
          Data: 0100
< test-bap: User Data TX
      ATT: Write Response (0x13) len 0
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x0019 Type: Sink ASE (0x2bc4)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 2
        Handle: 0x0019 Type: Sink ASE (0x2bc4)
        Value: 0200
            ASE ID: 2
            State: Idle (0x00)
> test-bap: User Data RX
      ATT: Write Request (0x12) len 4
        Handle: 0x001a
          Data: 0100
< test-bap: User Data TX
      ATT: Write Response (0x13) len 0
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x001c Type: Source ASE (0x2bc5)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 2
        Handle: 0x001c Type: Source ASE (0x2bc5)
        Value: 0300
            ASE ID: 3
            State: Idle (0x00)
> test-bap: User Data RX
      ATT: Write Request (0x12) len 4
        Handle: 0x001d
          Data: 0100
< test-bap: User Data TX
      ATT: Write Response (0x13) len 0
> test-bap: User Data RX
      ATT: Read Request (0x0a) len 2
        Handle: 0x001f Type: Source ASE (0x2bc5)
< test-bap: User Data TX
      ATT: Read Response (0x0b) len 2
        Handle: 0x001f Type: Source ASE (0x2bc5)
        Value: 0400
            ASE ID: 4
            State: Idle (0x00)
> test-bap: User Data RX
      ATT: Write Request (0x12) len 4
        Handle: 0x0020
          Data: 0100
< test-bap: User Data TX
      ATT: Write Response (0x13) len 0
> test-bap: User Data RX
      ATT: Write Request (0x12) len 4
        Handle: 0x0023
          Data: 0100
< test-bap: User Data TX
      ATT: Write Response (0x13) len 0
> test-bap: User Data RX
      ATT: Write Command (0x52) len 13
        Handle: 0x0022 Type: ASE Control Point (0x2bc6)
          Data: 0101030202ff0100010000
            Opcode: Codec Configuration (0x01)
            Number of ASE(s): 1
            ASE: #0
            ASE ID: 0x03
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: Vendor specific (0xff)
            Codec Company ID: Nokia Mobile Phones (0x0001)
            Codec Vendor ID: 0x0001
< test-bap: User Data TX
      ATT: Handle Value Notification (0x1b) len 7
        Handle: 0x0022 Type: ASE Control Point (0x2bc6)
          Data: 0101030000
            Opcode: Codec Configuration (0x01)
            Number of ASE(s): 1
            ASE: #0
            ASE ID: 0x03
            ASE Response Code: Success (0x00)
            ASE Response Reason: None (0x00)
< test-bap: User Data TX
      ATT: Handle Value Notification (0x1b) len 27
        Handle: 0x001c Type: Source ASE (0x2bc5)
          Data: 03010102010a00204e00409c00204e00409c00ff0100010000
            ASE ID: 3
            State: Codec Configured (0x01)
            Framing: Unframed PDUs not supported (0x01)
            PHY: 0x02
            LE 2M PHY preffered (0x02)
            RTN: 1
            Max Transport Latency: 10
            Presentation Delay Min: 20000 us
            Presentation Delay Max: 40000 us
            Preferred Presentation Delay Min: 20000 us
            Preferred Presentation Delay Max: 40000 us
            Codec: Vendor specific (0xff)
            Codec Company ID: Nokia Mobile Phones (0x0001)
            Codec Vendor ID: 0x0001


  Commit: acfa41dedb47f1bff9399e2273e4623aac4decc5
      https://github.com/bluez/bluez/commit/acfa41dedb47f1bff9399e2273e4623aac4decc5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-05 (Fri, 05 May 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix misaligment errors

This fixes the following errors:

monitor/packet.c:11968:27: runtime error: member access within
misaligned address 0x565448026d55 for type
'const struct monitor_l2cap_hdr', which requires 2 byte alignment
monitor/packet.c:11968:4: runtime error: member access within
misaligned address 0x565448026d55 for type
'const struct monitor_l2cap_hdr', which requires 2 byte alignment


Compare: https://github.com/bluez/bluez/compare/6bafe1c66515...acfa41dedb47
