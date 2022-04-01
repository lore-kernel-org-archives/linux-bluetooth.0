Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06B5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 10:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343645AbiDAK35 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 06:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343542AbiDAK34 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 06:29:56 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B9C26E57B
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 03:28:05 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 1779520CAB74
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Subject: [PATCH BlueZ 1/7] monitor: Fix out-of-bound read in print_le_states
Date:   Fri, 1 Apr 2022 13:27:51 +0300
Message-ID: <20220401102757.3960551-2-i.kamaletdinov@omp.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401102757.3960551-1-i.kamaletdinov@omp.ru>
References: <20220401102757.3960551-1-i.kamaletdinov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1910.lancloud.ru (fd00:f066::80)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Accessing le_states_desc_table array with value 15 can cause
out-of-bound read because current size of array is 14.

Currently this cannot lead to any problems becase we do no have such
state in le_states_comb_table but this could be changed in future and
raise described problem.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.
---
 monitor/packet.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index b7431b57d..15d629e2d 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2816,7 +2816,8 @@ static const struct {
 static void print_le_states(const uint8_t *states_array)
 {
 	uint64_t mask, states = 0;
-	int i, n;
+	int i = 0;
+	size_t n = 0;
 
 	for (i = 0; i < 8; i++)
 		states |= ((uint64_t) states_array[i]) << (i * 8);
@@ -2833,7 +2834,7 @@ static void print_le_states(const uint8_t *states_array)
 		if (!(states & val))
 			continue;
 
-		for (n = 0; n < 16; n++) {
+		for (n = 0; n < ARRAY_SIZE(le_states_desc_table); n++) {
 			if (le_states_comb_table[i].states & (1 << n))
 				str[num++] = le_states_desc_table[n].str;
 		}
-- 
2.35.1

