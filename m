Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF4CC77B7D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 May 2023 20:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbjEJUVf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 May 2023 16:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236125AbjEJUVe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 May 2023 16:21:34 -0400
Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DD13ABA
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 13:21:30 -0700 (PDT)
Received: from github.com (hubbernetes-node-117dc4c.ash1-iad.github.net [10.56.156.43])
        by smtp.github.com (Postfix) with ESMTPA id C06A9900BF7
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 13:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1683750089;
        bh=D/bkZQ1tIvJkCOXie/hmJt40WXsLGcie0nOU/bosPU8=;
        h=Date:From:To:Subject:From;
        b=EsSsQBeLm04O3SuX0m3K4GoAcdMPlM9DtURQ9dr/U3WTosiRfYiUc23Ms4EWSFP2i
         GvswwAA2pLY7I6QKUct0NPFoDdt3Lzwx5W+5tg0FhGKywm1yznRn5XBnY84aioPi/E
         /AG+hj4P1j1tQVVq54rh1dbwi9ymv+zSXUT5CZiA=
Date:   Wed, 10 May 2023 13:21:29 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/acfa41-8c452c@github.com>
Subject: [bluez/bluez] 89f8d6: monitor/intel: Fix not skipping unknown TLV
 types
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
  Commit: 89f8d6bae18f853ae2ab9f6de21b62469f82d84c
      https://github.com/bluez/bluez/commit/89f8d6bae18f853ae2ab9f6de21b62469f82d84c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-09 (Tue, 09 May 2023)

  Changed paths:
    M monitor/intel.c

  Log Message:
  -----------
  monitor/intel: Fix not skipping unknown TLV types

The code was stopping at first time it detected an unknown TLV type when
it could continue:

> HCI Event: Vendor (0xff) plen 82
        Vendor Prefix (0x8780)
      Intel Extended Telemetry (0x03)
        Extended event type (0x01): Audio Link Quality Report Type (0x05)
        Unknown extended subevent 0x81
        01 01 05 81 04 88 13 00 00 82 10 6a e6 6c 00 00  ...........j.l..
        00 00 00 4b 45 53 00 00 00 00 00 83 04 00 00 00  ...KES..........
        00 84 04 01 03 07 19 85 04 3f 08 00 00 86 08 00  .........?......
        00 00 00 00 00 00 00 87 04 00 00 00 00 88 04 00  ................
        00 00 00 89 04 00 00 00 00 8a 04 b9 49 0c 00     ............I..

So this changes it to:

> HCI Event: Vendor (0xff) plen 82
        Vendor Prefix (0x8780)
      Intel Extended Telemetry (0x03)
        Extended event type (0x01): Audio Link Quality Report Type (0x05)
        Unknown extended subevent 0x81
        88 13 00 00                                      ....
        Unknown extended subevent 0x82
        04 97 6c 00 00 00 00 00 68 44 53 00 00 00 00 00  ..l.....hDS.....
        Unknown extended subevent 0x83
        00 00 00 00                                      ....
        Unknown extended subevent 0x84
        01 03 07 19                                      ....
        Unknown extended subevent 0x85
        3a 08 00 00                                      :...
        Unknown extended subevent 0x86
        00 00 00 00 00 00 00 00                          ........
        Unknown extended subevent 0x87
        00 00 00 00                                      ....
        Unknown extended subevent 0x88
        00 00 00 00                                      ....
        Unknown extended subevent 0x89
        00 00 00 00                                      ....
        Unknown extended subevent 0x8a
        9f 1a 2f 00                                      ../.


  Commit: 8c452c2ec1739efe581273bacd738e5294d0ca0f
      https://github.com/bluez/bluez/commit/8c452c2ec1739efe581273bacd738e5294d0ca0f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-09 (Tue, 09 May 2023)

  Changed paths:
    M monitor/intel.c

  Log Message:
  -----------
  monitor/intel: Skip packet/error counters if 0

This skips printing TLVs related to packet/error count if they are 0 and
also update the missing TLVs:

> HCI Event: Vendor (0xff) plen 188
        Vendor Prefix (0x8780)
      Intel Extended Telemetry (0x03)
        Extended event type (0x01): Perform Stats (0x05)
        ACL connection handle (0x4a): 0x0100
        Rx HEC errors (0x4b): 3
        Packets from host (0x4d): 375
        Tx packets (0x4e): 375
        Tx packets 0 retries (0x4f): 354
        Tx packets 1 retries (0x50): 20
        Tx packets 3 retries (0x52): 1
        Tx 3DH5 packets (0x5c): 375
        Rx packets (0x5d): 400
        ACL link throughput (bps) (0x5e): 533419
        ACL max packet latency (us) (0x5f): 36875
        ACL avg packet latency (us) (0x60): 19441
        ACL RX RSSI moving avg (0x61): 65329
        ACL RX SNR Bad Margin Counter (0x62): 1M 59 2M 0 3M 0
        ACL RX RSSI Bad Counter (0x63): 1M 1711 2M 0 3M 0
        ACL TX RSSI Bad Counter (0x64): 1M 1024 2M 0 3M 0


Compare: https://github.com/bluez/bluez/compare/acfa41dedb47...8c452c2ec173
