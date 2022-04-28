Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB89C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Apr 2022 22:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352917AbiD1Wku (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Apr 2022 18:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351604AbiD1Wkt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Apr 2022 18:40:49 -0400
Received: from smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90EE583A9
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Apr 2022 15:37:32 -0700 (PDT)
Received: from github.com (hubbernetes-node-26efbe9.ac4-iad.github.net [10.52.202.82])
        by smtp.github.com (Postfix) with ESMTPA id D9187520BE9
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Apr 2022 15:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1651185451;
        bh=dqqoPLGwtPEpx9i2LlPtmqiB38MUtrDmd+k2cB/mecU=;
        h=Date:From:To:Subject:From;
        b=uQWm8ZbEykoMFXMOVevmrMxygjOuxXjFUTrDBUR8308gHgZt6ku7wnj8FaNq5U/3a
         EFfkz6UmI0/10LFAwIlx13v5cSqLgdAvs5CdqmM/qaeSqI2dfSnCI+0PSbWneZ9S08
         nZV9pV+EU606ykqHYRPxkvhaJ2rLrwFUPLg1j17k=
Date:   Thu, 28 Apr 2022 15:37:31 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/dd5b66-fa7828@github.com>
Subject: [bluez/bluez] 7a8749: client/player: Add transport.receive command
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
  Commit: 7a87497da4ab0e1d1358713a023403ec781644e6
      https://github.com/bluez/bluez/commit/7a87497da4ab0e1d1358713a023403ec781644e6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-26 (Tue, 26 Apr 2022)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add transport.receive command

This adds transport.receive command:

Get/Set file to receive
Usage:
	 receive [filename]


  Commit: 640d6b5c662d0f1c30f87bdb2be805fb40367c96
      https://github.com/bluez/bluez/commit/640d6b5c662d0f1c30f87bdb2be805fb40367c96
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-26 (Tue, 26 Apr 2022)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  btmon: Add proper decoding to Service Data UUID

This adds proper decoding for Service Data UUID:

        Service Data: Apple, Inc. (0xfd6f)
          Data: e6b07e19815e902100b8b2f4a55255fd18f0c6be


  Commit: 6da642225f5a4648efe538ee8723b1dd663cee3b
      https://github.com/bluez/bluez/commit/6da642225f5a4648efe538ee8723b1dd663cee3b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-26 (Tue, 26 Apr 2022)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  btmon: Add support for decoding Broadcast Audio Annoucements

This adds support for decoding Broadcast Audio Announcements as shown
on:

Basic Audio Profile / Profile Specification
Page 34 of 146

Table 3.14: Broadcast Source AD format when transmitting Broadcast
Audio Announcements

< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 36
        Handle: 0x00
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x20
        Service Data: Broadcast Audio Announcement (0x1852)
        Broadcast ID: 904177 (0x0dcbf1)
        Name (complete): Broadcast Audio Source


  Commit: 80cd36cd2a0c6eb7cc3134a00817439898e4bb7c
      https://github.com/bluez/bluez/commit/80cd36cd2a0c6eb7cc3134a00817439898e4bb7c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-26 (Tue, 26 Apr 2022)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  btmon: Add support for decoding Basic Audio Annoucements

This adds support for decoding Basic Audio Announcements as shown
on:

Basic Audio Profile / Profile Specification
Page 36 of 146

Table 3.15: Format of BASE used in Basic Audio Announcements

< HCI Command: LE Set Periodic Advertising Data (0x08|0x003f) plen 36
        Handle: 0
        Operation: Complete ext advertising data (0x03)
        Data length: 0x21
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 40000
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 1
            Codec: Reserved (0x06)
            Codec Specific Configuration: 010101020403010000020428
            Metadata: 020202
              BIS #0:
              Index: 1
              Codec Specific Configuration:


  Commit: f65a9c9d21f69942024ea5b9f581533d2788eb2e
      https://github.com/bluez/bluez/commit/f65a9c9d21f69942024ea5b9f581533d2788eb2e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-26 (Tue, 26 Apr 2022)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  btmon: Fix not decoding LC3 id

This enablind decoding LC3 codec id (0x06).


  Commit: fa7828bddd2164408535a9ac45095564e9ebbeea
      https://github.com/bluez/bluez/commit/fa7828bddd2164408535a9ac45095564e9ebbeea
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-04-28 (Thu, 28 Apr 2022)

  Changed paths:
    M profiles/audio/media.c
    M profiles/audio/transport.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  transport: Fix not being able to initialize volume properly

In case AVRCP is connected first and
media_transport_update_device_volume is called without any media_player
being available the volume setting would be lost and Transport.Volume
won't be available, so this introduces btd_device_{set,get}_volume
helpers which is used to store the volume temporarely so
media_player_get_device_volume is able to restore it when the transport
is created.

Fixes: https://github.com/bluez/bluez/issues/335


Compare: https://github.com/bluez/bluez/compare/dd5b66695c2b...fa7828bddd21
