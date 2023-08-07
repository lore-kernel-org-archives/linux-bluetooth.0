Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA17BC001DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 23:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjHGXei (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 19:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHGXeh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 19:34:37 -0400
Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B791721
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 16:34:36 -0700 (PDT)
Received: from github.com (hubbernetes-node-a0c4ff4.va3-iad.github.net [10.48.220.68])
        by smtp.github.com (Postfix) with ESMTPA id AD7D19404E0
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 16:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1691451275;
        bh=TGBO0YPmjVXbSVHGqauw624DRRKu9pLgLTdrO6ke8yI=;
        h=Date:From:To:Subject:From;
        b=M9DfeI2pS9fp79MD2ygwfk7Bi8lhsdW3FO7uWx4OUy9aH/4yLEXpNfbBkESVgo/wr
         WzvDbdX/5duoAiSlxAV7aadfNWCZnabRwdMMN+Vo9IqTXYXpg26xtL0xg1Enh0tmRZ
         ltX2Wy1lLOtHgnQZm3EVdrMaMIZkjtG0dJS5Lr5k=
Date:   Mon, 07 Aug 2023 16:34:35 -0700
From:   =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/966502-59569c@github.com>
Subject: [bluez/bluez] d987ff: monitor: Plot RX information with -a/--analyze
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
  Commit: d987ff347b83e4a49d1b646ccf182a19f118d96a
      https://github.com/bluez/bluez/commit/d987ff347b83e4a49d1b646ccf182a19f118d96a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-08-07 (Mon, 07 Aug 2023)

  Changed paths:
    M monitor/analyze.c

  Log Message:
  -----------
  monitor: Plot RX information with -a/--analyze

This attempts to plot the RX information just as TX:

  Found BR-ACL connection with handle 256
        Address: XX:XX:XX:XX:XX:XX
        RX packets: 60/60
        RX Latency: 0-39040 msec (~20294 msec)
        RX size: 6-344 octets (~34 octets)
        RX speed: ~0 Kb/s

  100 +-+------------------------------------------------------------------+
       +|                                                                  |
       +|                                                       RX +-----+ |
       +|                                                                  |
       +|                                                                  |
       +|                                                                  |
        |                                                                  |
        |                                                                  |
   10 +-|                                                                  |
       +|                                                                  |
       +|                                                                  |
       +|                                                                  |
       +|                                                                  |
       +|                                                                  |
        |                                                                  |
        |                                                                  |
    1 +-|  + +                                                           + |
       +|  | |                                                           | |
       ++------------------------------------------------------------------+
        +       +        +       +        +       +       +        +       +
        0      5000    10000   15000    20000   25000   30000    35000   40000
                                   Latency (ms)

        TX packets: 22548/22547
        TX Latency: 3-73 msec (~11 msec)
        TX size: 6-850 octets (~847 octets)
        TX speed: ~568 Kb/s


  Commit: b9c57e815e6e63965c6b0fa5907f7a761d169091
      https://github.com/bluez/bluez/commit/b9c57e815e6e63965c6b0fa5907f7a761d169091
  Author: Karl Bieber <karl.bieber@proton.me>
  Date:   2023-08-07 (Mon, 07 Aug 2023)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main: Fix missing comma


  Commit: 0ee60b31a8432b0737df2bfdbf630c24ca7ef4d3
      https://github.com/bluez/bluez/commit/0ee60b31a8432b0737df2bfdbf630c24ca7ef4d3
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2023-08-07 (Mon, 07 Aug 2023)

  Changed paths:
    M src/error.c
    M src/error.h

  Log Message:
  -----------
  error: Add "Invalid exchange" mapping

This error is returned on this event:
> HCI Event: Auth Complete (0x06) plen 3
        Status: PIN or Key Missing (0x06)
        Handle: 11 Address: 00:00:00:00:00:00 (OUI 00-00-00)


  Commit: 59569c1f947d648f1e0b9234dad3707f6c34739b
      https://github.com/bluez/bluez/commit/59569c1f947d648f1e0b9234dad3707f6c34739b
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2023-08-07 (Mon, 07 Aug 2023)

  Changed paths:
    M profiles/audio/a2dp.c

  Log Message:
  -----------
  a2dp: Expose "Key missing" error

This error is not expected and retries will likely end up with same error.


Compare: https://github.com/bluez/bluez/compare/9665025cc042...59569c1f947d
