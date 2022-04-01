Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94FEDC433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 11:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345363AbiDALQG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 07:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237488AbiDALQF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 07:16:05 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B66120DBC
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 04:14:15 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 0A86820C601C
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Subject: [PATCH BlueZ 0/7] [v3] Fix bugs found by SVACE static analisys tool
Date:   Fri, 1 Apr 2022 14:14:01 +0300
Message-ID: <20220401111408.3961844-1-i.kamaletdinov@omp.ru>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1910.lancloud.ru (fd00:f066::80)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set includes few fixes that was found by Linux Verification Center
(linuxtesting.org) with the SVACE static analysis tool.

I have manually filtered out non-relevant and false positive problems and only
procedeed with bugs that currently lead to some errors/vulnerabilities or may
lead to them in some specific conditions.

Changelog:
v3 one fix wasn't staged, sorry, one more fix after CI checks
v2 some minor style fixes after CI check.
v1 initial version.

Ildar Kamaletdinov (7):
  monitor: Fix out-of-bound read in print_le_states
  tools: Fix buffer overflow in hciattach_tialt.c
  tools: Fix signed integer overflow in btsnoop.c
  tools: Prevent infinity loops in bluemoon.c
  tools: Limit width of fields in sscanf
  device: Limit width of fields in sscanf
  gatt: Fix double free and freed memory dereference

 monitor/packet.c        |  7 ++++---
 src/device.c            | 14 +++++++-------
 src/gatt-database.c     |  4 ++++
 tools/bluemoon.c        | 13 +++++++++++++
 tools/btmgmt.c          |  2 +-
 tools/btsnoop.c         |  2 +-
 tools/hciattach_tialt.c |  3 ++-
 tools/hex2hcd.c         |  2 +-
 8 files changed, 33 insertions(+), 14 deletions(-)

-- 
2.35.1

