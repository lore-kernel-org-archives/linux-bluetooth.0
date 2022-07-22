Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13633C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 20:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiGVUn0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 16:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGVUnZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 16:43:25 -0400
Received: from smtp.github.com (out-26.smtp.github.com [192.30.252.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548C1AF704
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 13:43:24 -0700 (PDT)
Received: from github.com (hubbernetes-node-9ce04c5.ash1-iad.github.net [10.56.14.83])
        by smtp.github.com (Postfix) with ESMTPA id B1C065E02A4
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 13:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1658522603;
        bh=Oi89NZ6CVEl1gWi1GzaAOkp/yZPcByl7MJ2CpXsd5+I=;
        h=Date:From:To:Subject:From;
        b=QFVtOwgB709yaXbrTgUHa6QdZUGuytUj4EeN4VhdK88CuxJ+NCANGgGdNG+5T58z8
         0vDP6DleD3kGVN9fWr5RNw9b8f52dtILhbv/A9HKL//FgA/7K4Z8N9uTpVHEW1TB2W
         tI3wnPeMdgsR4gHrfiNK25df7brBpurmNgguOAJg=
Date:   Fri, 22 Jul 2022 13:43:23 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/af998f-4314f7@github.com>
Subject: [bluez/bluez] b031e4: lib: Add definitions for ISO socket
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
  Commit: b031e4dc8c4ef9cdce40b34a8699c6174c850202
      https://github.com/bluez/bluez/commit/b031e4dc8c4ef9cdce40b34a8699c6174c850202
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-07-22 (Fri, 22 Jul 2022)

  Changed paths:
    M Makefile.am
    M lib/bluetooth.h
    A lib/iso.h

  Log Message:
  -----------
  lib: Add definitions for ISO socket


  Commit: cc482ad3780b788e0e03ec34c04697d90a65f3af
      https://github.com/bluez/bluez/commit/cc482ad3780b788e0e03ec34c04697d90a65f3af
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-07-22 (Fri, 22 Jul 2022)

  Changed paths:
    M src/shared/util.c

  Log Message:
  -----------
  shared/util: Decode BlueZ Experimental ISO Socket UUID

This adds BlueZ experimental ISO Socket UUID to uuid128_table so it is
decoded by the likes of btmon.


  Commit: 9c65bad7a8784b492ca417e82944eb192a7e1bfc
      https://github.com/bluez/bluez/commit/9c65bad7a8784b492ca417e82944eb192a7e1bfc
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-07-22 (Fri, 22 Jul 2022)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Fix Read Exp Feature tests

This adds ISO Socket UUID as response to Read Exp Feature.


  Commit: 8dc5b5e1ba6b500ee2126bde11601d152cc5d973
      https://github.com/bluez/bluez/commit/8dc5b5e1ba6b500ee2126bde11601d152cc5d973
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-07-22 (Fri, 22 Jul 2022)

  Changed paths:
    M src/adapter.c
    M src/adapter.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  adapter: Add support for setting ISO Socket experimental feature

This adds support for setting ISO Socket experimental UUID which
enables the use of BTPROTO_ISO on the system.


  Commit: b1b575cf1720521bfe7ae58f6d2276d07add326b
      https://github.com/bluez/bluez/commit/b1b575cf1720521bfe7ae58f6d2276d07add326b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-07-22 (Fri, 22 Jul 2022)

  Changed paths:
    M btio/btio.c
    M btio/btio.h
    M tools/btiotest.c

  Log Message:
  -----------
  btio: Add support for ISO sockets

This adds support to create objects that map to ISO sockets.


  Commit: 26ee34d7be40ec189811908d7351ec24d11b5db0
      https://github.com/bluez/bluez/commit/26ee34d7be40ec189811908d7351ec24d11b5db0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-07-22 (Fri, 22 Jul 2022)

  Changed paths:
    M Makefile.tools
    A tools/iso-tester.c
    M tools/test-runner.c

  Log Message:
  -----------
  tools: Add iso-tester

This adds iso-tester which tests BTPROTO_ISO socket:

Basic Framework - Success
Basic ISO Socket - Success
Basic ISO Get Socket Option - Success
Basic ISO Set Socket Option - Success
ISO QoS 8_1_1 - Success
ISO QoS 8_2_1 - Success
ISO QoS 16_1_1 - Success
ISO QoS 16_2_1 - Success
ISO QoS 16_2_1 CIG 0x01 - Success
ISO QoS 16_2_1 CIG 0x01 CIS 0x01 - Success
ISO QoS 24_1_1 - Success
ISO QoS 24_2_1 - Success
ISO QoS 32_1_1 - Success
ISO QoS 32_2_1 - Success
ISO QoS 44_1_1 - Success
ISO QoS 44_2_1 - Success
ISO QoS 48_1_1 - Success
ISO QoS 48_2_1 - Success
ISO QoS 48_3_1 - Success
ISO QoS 48_4_1 - Success
ISO QoS 48_5_1 - Success
ISO QoS 48_6_1 - Success
ISO QoS 8_1_2 - Success
ISO QoS 8_2_2 - Success
ISO QoS 16_1_2 - Success
ISO QoS 16_2_2 - Success
ISO QoS 24_1_2 - Success
ISO QoS 24_2_2 - Success
ISO QoS 32_1_2 - Success
ISO QoS 32_2_2 - Success
ISO QoS 44_1_2 - Success
ISO QoS 44_2_2 - Success
ISO QoS 48_1_2 - Success
ISO QoS 48_2_2 - Success
ISO QoS 48_3_2 - Success
ISO QoS 48_4_2 - Success
ISO QoS 48_5_2 - Success
ISO QoS 48_6_2 - Success
ISO QoS - Invalid
ISO Connect2 CIG 0x01 - Success
ISO Send - Success
ISO Receive - Success
ISO Defer - Success
ISO Defer Send - Success
ISO Defer Receive - Success
ISO Defer Reject - Success
ISO Send and Receive - Success
ISO Broadcaster - Success
ISO Broadcaster BIG 0x01 - Success
ISO Broadcaster BIG 0x01 BIS 0x01 - Success
ISO Broadcaster Receiver - Success


  Commit: 037ed8c5b12a1c80791af5df50fa93428dbc9f17
      https://github.com/bluez/bluez/commit/037ed8c5b12a1c80791af5df50fa93428dbc9f17
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-07-22 (Fri, 22 Jul 2022)

  Changed paths:
    M Makefile.tools
    A tools/isotest.c

  Log Message:
  -----------
  tools: Add isotest tool

This adds isotest tool which can be used to test ISO sockets.


  Commit: 4314f70667217549054f61def6575085a7a18d78
      https://github.com/bluez/bluez/commit/4314f70667217549054f61def6575085a7a18d78
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-07-22 (Fri, 22 Jul 2022)

  Changed paths:
    M Makefile.tools
    A tools/isotest.rst

  Log Message:
  -----------
  isotest: Add documentation

This adds isotest.rst which documents the modes and options of
isotest(1) and is then converted isotest.1 manpage.


Compare: https://github.com/bluez/bluez/compare/af998fd32c34...4314f7066721
