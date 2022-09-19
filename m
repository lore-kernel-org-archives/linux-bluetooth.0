Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EB0ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Sep 2022 22:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiISWoR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 18:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiISWoR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 18:44:17 -0400
Received: from smtp.github.com (out-25.smtp.github.com [192.30.252.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846374F691
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 15:44:16 -0700 (PDT)
Received: from github.com (hubbernetes-node-0c60bd8.ash1-iad.github.net [10.56.15.45])
        by smtp.github.com (Postfix) with ESMTPA id C899E840474
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 15:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1663627455;
        bh=lk5hTgvDsYkI45TCEhIn9mnNHa7dKc043WuUUMpNomU=;
        h=Date:From:To:Subject:From;
        b=Cvwcn7RaCQfkQzanUasMD2JDAB6mvtZmVvux+Ee7sFSyZd42SHlJaBuNiEuH9nhB6
         BeKROh8wgJ7vJvmnzV7ASy4Qk+QhwkOPwmqe2mr2mOctet0vnUA2MAA7LRGkWnLS5D
         nmTtCKafi0t+iS/ou/ryjuI2/527iC9OoQcm1i64=
Date:   Mon, 19 Sep 2022 15:44:15 -0700
From:   Sathish Narasimman <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f6ac08-115514@github.com>
Subject: [bluez/bluez] b8a113: shared/vcp: Add initial code for handling VCP
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
  Commit: b8a113ecbabcae1c6192bdb9b9ab6f352056c5bf
      https://github.com/bluez/bluez/commit/b8a113ecbabcae1c6192bdb9b9ab6f352056c5bf
  Author: Sathish Narasimman <sathish.narasimman@intel.com>
  Date:   2022-09-19 (Mon, 19 Sep 2022)

  Changed paths:
    M Makefile.am
    A src/shared/vcp.c
    A src/shared/vcp.h

  Log Message:
  -----------
  shared/vcp: Add initial code for handling VCP

This adds initial code for Volume Control Profile.


  Commit: a96ede87c63f1c4a397240841e1f460fbbc288b3
      https://github.com/bluez/bluez/commit/a96ede87c63f1c4a397240841e1f460fbbc288b3
  Author: Sathish Narasimman <sathish.narasimman@intel.com>
  Date:   2022-09-19 (Mon, 19 Sep 2022)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/vcp.c

  Log Message:
  -----------
  profiles: Add initial code for vcp plugin

This adds initial code for vcp plugin which handles Volume Control
Profile and Volume Control Service.


  Commit: 115514d85a17dcc03da4f784c9d65c1e98491296
      https://github.com/bluez/bluez/commit/115514d85a17dcc03da4f784c9d65c1e98491296
  Author: Sathish Narasimman <sathish.narasimman@intel.com>
  Date:   2022-09-19 (Mon, 19 Sep 2022)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Add decoding support for Volume Control Serice

This adds decoding support for VCS attributes

> ACL Data RX: Handle 3585 flags 0x02 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x0017 Type: Volume State (0x2b7d)
< ACL Data TX: Handle 3585 flags 0x00 dlen 8
      ATT: Read Response (0x0b) len 3
        Value: 000000
        Handle: 0x0017 Type: Volume State (0x2b7d)
            Volume Setting: 0
            Not Muted: 0
            Change Counter: 0
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 3585 Address: 49:71:FC:C0:66:C6 (Resolvable)
        Count: 1
> ACL Data RX: Handle 3585 flags 0x02 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x001c Type: Volume Flags (0x2b7f)
< ACL Data TX: Handle 3585 flags 0x00 dlen 6
      ATT: Read Response (0x0b) len 1
        Value: 01
        Handle: 0x001c Type: Volume Flags (0x2b7f)
            Volume Falg: 1


Compare: https://github.com/bluez/bluez/compare/f6ac0886f08e...115514d85a17
