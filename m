Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F05C7619A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 20:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjDEUT2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 16:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjDEUT1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 16:19:27 -0400
Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99C43A9C
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 13:19:25 -0700 (PDT)
Received: from github.com (hubbernetes-node-c7b2993.va3-iad.github.net [10.48.146.34])
        by smtp.github.com (Postfix) with ESMTPA id 07F6D5C03F6
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 13:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1680725965;
        bh=iaYrnk4bPkl44tbM+8yFZrlEHQ/785aAVmVmjp0QJac=;
        h=Date:From:To:Subject:From;
        b=lbyHnj8AHyavVMlpYfYJrOthLCznCRnCOZU4cpEmfyocbN7odklhSVi62TMyNVJiq
         SgEI2303yX9pkCLiirMBzlZw9bSN++x8wsGQcQPGh3dpJt8grE4bw/EcAOv0xWyZZ1
         9A2CtRrjtJKnDxz2JXCjIPPZekm5l70BC3OdWRPU=
Date:   Wed, 05 Apr 2023 13:19:25 -0700
From:   iulia-tanasescu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/cffd58-61971f@github.com>
Subject: [bluez/bluez] 7aee0b: set: Fix not attempt to connect devices with
 RSI
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
  Commit: 7aee0b67ba9fadb0713a14a3f4121cdeffa75f6c
      https://github.com/bluez/bluez/commit/7aee0b67ba9fadb0713a14a3f4121cdeffa75f6c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-04-03 (Mon, 03 Apr 2023)

  Changed paths:
    M src/set.c

  Log Message:
  -----------
  set: Fix not attempt to connect devices with RSI

If a device advertising with RSI is only found later after the set was
already create we shall still attempt to connect to it.


  Commit: 61971f026466391ca8fa563559e2fe6bd5129581
      https://github.com/bluez/bluez/commit/61971f026466391ca8fa563559e2fe6bd5129581
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-04-05 (Wed, 05 Apr 2023)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Add decoding support for BASS

This adds decoding support for BASS attributes:

> ACL Data RX: Handle 0 flags 0x02 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)

< ACL Data TX: Handle 0 flags 0x00 dlen 45
      ATT: Read Response (0x0b) len 40
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
        Value: 0100f2698be807c0013a6501020101000000000403020400
          Source_ID: 1
          Source_Address_Type: 0
          Source_Address: C0:07:E8:8B:69:F2
          Source_Adv_SID: 1
          Broadcast_ID: 0x01653a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Broadcast_Code required
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
            Metadata #0: len 0x03 type 0x02
            Metadata: 0400

> ACL Data RX: Handle 0 flags 0x02 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x003d Type: Broadcast Receive State (0x2bc8)

< ACL Data TX: Handle 0 flags 0x00 dlen 5
      ATT: Read Response (0x0b) len 0
        Handle: 0x003d Type: Broadcast Receive State (0x2bc8)
        Value:
          Empty characteristic

> ACL Data RX: Handle 0 flags 0x02 dlen 8
      ATT: Write Request (0x12) len 3
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data: 00
            Opcode: Remote Scan Stopped (0x00)

< ACL Data TX: Handle 0 flags 0x00 dlen 9
      ATT: Error Response (0x01) len 4
        Write Request (0x12)
        Handle: 0x0040
        Error: Reserved (0x80)

> ACL Data RX: Handle 0 flags 0x02 dlen 8
      ATT: Write Request (0x12) len 3
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data: 01
            Opcode: Remote Scan Started (0x01)

< ACL Data TX: Handle 0 flags 0x00 dlen 9
      ATT: Error Response (0x01) len 4
        Write Request (0x12)
        Handle: 0x0040
        Error: Reserved (0x80)

> ACL Data RX: Handle 0 flags 0x01 dlen 5
      ATT: Write Request (0x12) len 27
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data: 0200f2698be807c0013a650100ffff01000000000403020400
            Opcode: Add Source (0x02)
            Source_Address_Type: 0
            Source_Address: C0:07:E8:8B:69:F2
            Source_Adv_SID: 1
            Broadcast_ID: 0x01653a
            PA_Sync_State: Do not synchronize to PA
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000000
              Metadata #0: len 0x03 type 0x02
              Metadata: 0400

< ACL Data TX: Handle 0 flags 0x00 dlen 9
      ATT: Error Response (0x01) len 4
        Write Request (0x12)
        Handle: 0x0040
        Error: Reserved (0x80)

> ACL Data RX: Handle 0 flags 0x02 dlen 22
      ATT: Write Request (0x12) len 17
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data: 030102780001000000000403040400
            Opcode: Modify Source (0x03)
            Source_ID: 1
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0x0078
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000000
              Metadata #0: len 0x03 type 0x04
              Metadata: 0400

< ACL Data TX: Handle 0 flags 0x00 dlen 9
      ATT: Error Response (0x01) len 4
        Write Request (0x12)
        Handle: 0x0040
        Error: Reserved (0x80)

> ACL Data RX: Handle 0 flags 0x02 dlen 25
      ATT: Write Request (0x12) len 20
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data: 0401b803eac6afbb65a25a41f15305680201
            Opcode: Set Broadcast_Code (0x04)
            Source_ID: 1
            Broadcast_Code: b803eac6afbb65a25a41f15305680201

< ACL Data TX: Handle 0 flags 0x00 dlen 5
      ATT: Write Response (0x13) len 0

< ACL Data TX: Handle 0 flags 0x00 dlen 33
      ATT: Handle Multiple Value Notification (0x23) len 28
        Length: 0x0018
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data: 0100f2698be807c0013a6501020201000000000403020400
          Source_ID: 1
          Source_Address_Type: 0
          Source_Address: C0:07:E8:8B:69:F2
          Source_Adv_SID: 1
          Broadcast_ID: 0x01653a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Decrypting
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
            Metadata #0: len 0x03 type 0x02
            Metadata: 0400

> ACL Data RX: Handle 0 flags 0x02 dlen 9
      ATT: Write Request (0x12) len 4
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data: 0501
            Opcode: Remove Source (0x05)
            Source_ID: 1

< ACL Data TX: Handle 0 flags 0x00 dlen 9
      ATT: Error Response (0x01) len 4
        Write Request (0x12)
        Handle: 0x0040
        Error: Reserved (0x80)


Compare: https://github.com/bluez/bluez/compare/cffd5832a52c...61971f026466
