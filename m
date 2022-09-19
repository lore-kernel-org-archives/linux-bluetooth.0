Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2353C6FA82
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Sep 2022 21:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiISVn7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 17:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiISVnr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 17:43:47 -0400
Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CEA3FA2A
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 14:43:47 -0700 (PDT)
Received: from github.com (hubbernetes-node-1217b6e.va3-iad.github.net [10.48.13.18])
        by smtp.github.com (Postfix) with ESMTPA id 7C3FFE05CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 14:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1663623826;
        bh=kISCQlh9CKVmefRsv4IpshA2D02EbiSLZqE5aNbalJk=;
        h=Date:From:To:Subject:From;
        b=fdVAsT7jZh4UPfZPsnoV3LQZjkKqWgW1Gf7egIvNQKArdqdCCleEZ75jgt27TsNP7
         P904hSphtR2O4XI5wqwlJqi9Q9W+xS8DPiMmKJOuGHIhwSZr74PhXv765yDhlAAseC
         zvtv1+KX1yH+0hEWzehdLmwrsWhLRspq9FAKfzs0=
Date:   Mon, 19 Sep 2022 14:43:46 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/af1bfb-f6ac08@github.com>
Subject: [bluez/bluez] de0a36: shared/bap: Remove include to io.h
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
  Commit: de0a366833cd056aa29a5f089000deff867f690c
      https://github.com/bluez/bluez/commit/de0a366833cd056aa29a5f089000deff867f690c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-09-15 (Thu, 15 Sep 2022)

  Changed paths:
    M profiles/audio/transport.c
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Remove include to io.h

Users of bap.h shall also include io.h, including io.h by default may
cause errors if has been previously included.


  Commit: 68adb4d1b7f24cb4ee3a68c896efe55530da7932
      https://github.com/bluez/bluez/commit/68adb4d1b7f24cb4ee3a68c896efe55530da7932
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-09-15 (Thu, 15 Sep 2022)

  Changed paths:
    M src/shared/tester.c
    M src/shared/tester.h
    M unit/test-tester.c

  Log Message:
  -----------
  shared/tester: Remove include to io.h

Users of tester.h shall also include io.h, including io.h by default may
cause errors if has been previously included.


  Commit: b7023510c929eeca6f03da5194fd625fdc371f7a
      https://github.com/bluez/bluez/commit/b7023510c929eeca6f03da5194fd625fdc371f7a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-09-16 (Fri, 16 Sep 2022)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: Fix not detecting transport connection collision

Some headsets appears to attempt to connect back after receiving
AVDTP_Open which would cause unexpected transitions since setup->io
and stream->io would not be in sync:

> ACL Data RX: Handle 70 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 2 nosp 0
< ACL Data TX: Handle 70 flags 0x00 dlen 12
      L2CAP: Connection Request (0x02) ident 6 len 4
        PSM: 25 (0x0019)
        Source CID: 67
> ACL Data RX: Handle 70 flags 0x02 dlen 12
      L2CAP: Connection Request (0x02) ident 10 len 4
        PSM: 25 (0x0019)
        Source CID: 68
< ACL Data TX: Handle 70 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 10 len 8
        Destination CID: 68
        Source CID: 68
        Result: Connection pending (0x0001)
        Status: Authorization pending (0x0002)
< ACL Data TX: Handle 70 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 10 len 8
        Destination CID: 68
        Source CID: 68
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
> ACL Data RX: Handle 70 flags 0x02 dlen 16
      L2CAP: Connection Response (0x03) ident 6 len 8
        Destination CID: 69
        Source CID: 67
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)

Fixes: https://github.com/bluez/bluez/issues/327


  Commit: f6ac0886f08e6b8e030816acf2029ca1ef41c7ac
      https://github.com/bluez/bluez/commit/f6ac0886f08e6b8e030816acf2029ca1ef41c7ac
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-09-16 (Fri, 16 Sep 2022)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: Make use of gatt_db_attribute_get_ccc

This makes use of gatt_db_attribute_get_ccc to locate a CCC of a given
attribute.


Compare: https://github.com/bluez/bluez/compare/af1bfbb470c0...f6ac0886f08e
