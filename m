Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56ADC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Dec 2022 19:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234588AbiLBTbW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Dec 2022 14:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiLBTbV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Dec 2022 14:31:21 -0500
Received: from smtp.github.com (out-17.smtp.github.com [192.30.252.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23DBEF37CD
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 11:31:20 -0800 (PST)
Received: from github.com (hubbernetes-node-7b54fb0.va3-iad.github.net [10.48.200.72])
        by smtp.github.com (Postfix) with ESMTPA id 7D0C35C0497
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Dec 2022 11:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1670009479;
        bh=RL/kYUipAIU2in73Wb5TeaBzUG4f8a2xZ8S3TZJFb78=;
        h=Date:From:To:Subject:From;
        b=mDI/DU94PMwGX/2zgwhH+yQCMpm4UNmcVa430ZMNSsLTwGnaemOIa18PVNIJAsrqf
         5Gzd0DJFihZCtWtlzIiehXdB1UVnS586thF9aFNzolTz1Is99DI0Oe9tUx16FOrIKJ
         7tFhXuhVaJnOWEEU4vmph/iZQ52RcvbozwZvoywI=
Date:   Fri, 02 Dec 2022 11:31:19 -0800
From:   Allen-Webb <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9f5036-d84ce7@github.com>
Subject: [bluez/bluez] 25d6c9: monitor: Decode vendor codecs of
 BT_HCI_CMD_READ_L...
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
  Commit: 25d6c9a0468f4e733fd314ec97d8eafc102ae22e
      https://github.com/bluez/bluez/commit/25d6c9a0468f4e733fd314ec97d8eafc102ae22e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-02 (Fri, 02 Dec 2022)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Decode vendor codecs of BT_HCI_CMD_READ_LOCAL_CODECS_V2

This attempts to decode the vendor codecs includec in the response of
BT_HCI_CMD_READ_LOCAL_CODECS_V2.


  Commit: 43d71b8410ff8cf1abcb4ec5353041268f49b037
      https://github.com/bluez/bluez/commit/43d71b8410ff8cf1abcb4ec5353041268f49b037
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-02 (Fri, 02 Dec 2022)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: Fix not checking valid ranges

When attempting to update discovery ranges the code shall verify if the
range is still valid (handles != 0x0000 and start < end).


  Commit: b6a6f6a8a8592d21d558ffab715c4551c29a36f1
      https://github.com/bluez/bluez/commit/b6a6f6a8a8592d21d558ffab715c4551c29a36f1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-02 (Fri, 02 Dec 2022)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not reading all instances of PAC Sinks/Sources

Both PAC Sink and Source are allowed to have multiple instances:

 - The server wanted to support a smaller maximum transmission unit
 (ATT_MTU, as defined in Volume 3, Part F, Section 3.2.8 in [2]) size.
 Exposing all supported PAC records in a single Sink PAC characteristic
 would require the server to increase its supported Maximum
 Transmission Unit (MTU) size to a value the server considered
 excessive.
 - The server wanted to expose support for proprietary audio
 capabilities (such as vendor-specific audio codecs, as denoted by the
 Codec_ID parameter value) separately from support for
 non-vendor-specific audio capabilities and used separate Sink PAC
 characteristics to expose such support.
 - The server wanted to minimize the amount of data to be transferred,
 when sending notifications to a client that the Sink PAC
 characteristic value changed, by exposing the audio capabilities
 likely to change quicker than others in separate Sink PAC
 characteristics.


  Commit: 636c78666031c12bf73a02bfeb531c3a633608ee
      https://github.com/bluez/bluez/commit/636c78666031c12bf73a02bfeb531c3a633608ee
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-02 (Fri, 02 Dec 2022)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix initiating QoS and Enable procedures as server

According to Table 3.2: ASE state machine transition these procedures
can only be initated by clients.


  Commit: 7642669e4496563ff7c945583c5736364b8a6c37
      https://github.com/bluez/bluez/commit/7642669e4496563ff7c945583c5736364b8a6c37
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-02 (Fri, 02 Dec 2022)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support for custom preset

This adds support for a custom preset which asks the user to enter its
configuration:

[bluetooth]# endpoint.presets 00002bc9-0000-1000-8000-00805f9b34fb custom
[Codec] Enter frequency (Khz): 48
[Codec] Enter frame duration (ms): 10
[Codec] Enter channel allocation: 0x000000003
[Codec] Enter frame length: 100
[QoS] Enter Target Latency (Low, Balance, High): Low
[QoS] Enter SDU Interval (us): 10000
[QoS] Enter Framing (Unframed, Framed): Unframed
[QoS] Enter PHY (1M, 2M): 2M
[QoS] Enter Max SDU: 200
[QoS] Enter RTN: 3
[QoS] Enter Max Transport Latency (ms): 20
[QoS] Enter Presentation Delay (us): 10000


  Commit: 707a547e4d68fd4e848d349142746587de972039
      https://github.com/bluez/bluez/commit/707a547e4d68fd4e848d349142746587de972039
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-02 (Fri, 02 Dec 2022)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix not able to reconfigure

While attempting to configure QoS setting the request id is not reset
to 0 when a response is received which prevents any the QoS to be
reconfigured.


  Commit: 7280f4357cf6c72bf51ebe52739143e0b9203de2
      https://github.com/bluez/bluez/commit/7280f4357cf6c72bf51ebe52739143e0b9203de2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-02 (Fri, 02 Dec 2022)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: Fix crash when transport configuration changes

In case of BAP the same transport may be reconfigured multiple times
which means it would appears multiple times on endpoint->transports
leading to a crash when disconnecting as the code would attempt to
destroy the same object multiple times.


  Commit: b907befc2d801f1a7607cd651369a67cceef8d33
      https://github.com/bluez/bluez/commit/b907befc2d801f1a7607cd651369a67cceef8d33
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-02 (Fri, 02 Dec 2022)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Merge PAC records of the same type/codec

This attempts to merge PAC records which contain the same type and
codec to simplify the matching with client endpoints so all
capabilities and metadata are match at once instead of for each PAC
record.


  Commit: f28433d448fa9ae33305d87f112a1b8abb7c6b17
      https://github.com/bluez/bluez/commit/f28433d448fa9ae33305d87f112a1b8abb7c6b17
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-02 (Fri, 02 Dec 2022)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/media.c

  Log Message:
  -----------
  bap: Fix not waiting Endpoint.SelectProperties

If there are multiple Endpoint.SelectProperties wait them to complete
before attempting to proceed to configure a stream otherwise streams
may not be linked properly and may end up creating multiple CIS
instead.


  Commit: a4bde19d3bd809337eacead3f2c5922a873cee9d
      https://github.com/bluez/bluez/commit/a4bde19d3bd809337eacead3f2c5922a873cee9d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-02 (Fri, 02 Dec 2022)

  Changed paths:
    M Makefile.tools
    M client/main.c
    M client/player.c
    A client/print.c
    A client/print.h

  Log Message:
  -----------
  client: Move common print_* functions to its own file

This move common print_* functions to its own file so they can be
properly reused instead of duplicating the code.


  Commit: d84ce72a543e090665a33ecac64b604805d2ec4c
      https://github.com/bluez/bluez/commit/d84ce72a543e090665a33ecac64b604805d2ec4c
  Author: Allen Webb <allenwebb@google.com>
  Date:   2022-12-02 (Fri, 02 Dec 2022)

  Changed paths:
    M src/bluetooth.ver

  Log Message:
  -----------
  bluetooth.ver: Export sanitizer symbols

Fix llvm sanitizer support by not hiding sanitizer related symbols.


Compare: https://github.com/bluez/bluez/compare/9f5036834ba2...d84ce72a543e
