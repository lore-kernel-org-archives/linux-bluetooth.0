Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D55C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 May 2022 17:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378055AbiEGRjJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 May 2022 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352051AbiEGRjE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 May 2022 13:39:04 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA24A22509
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 May 2022 10:35:16 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 56D0F20A451A
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Subject: [PATCH BlueZ 0/4] [v3] Fix few more bugs found by SVACE
Date:   Sat, 7 May 2022 20:35:01 +0300
Message-ID: <20220507173505.31249-1-i.kamaletdinov@omp.ru>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1910.lancloud.ru (fd00:f066::80)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch set includes few fixes for bugs that was found by
Linux Verification Center (linuxtesting.org) with the SVACE static
analysis tool.

Changelog:
[v3] Removed trailing whitespace (style issue).
[v2] Some minor style changes after CI check.
[v1] Initial version.

Ildar Kamaletdinov (4):
  tools: Fix memory leak in hciconfig
  tools: Fix memory leaks in btgatt-server/client
  tools: Fix handle leak in rfcomm
  device: Fix uninitialized value usage

 src/device.c          | 3 ++-
 tools/btgatt-client.c | 6 +++++-
 tools/btgatt-server.c | 5 ++++-
 tools/hciconfig.c     | 6 +++++-
 tools/rfcomm.c        | 4 ++++
 5 files changed, 20 insertions(+), 4 deletions(-)

-- 
2.35.3

