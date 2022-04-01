Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAF7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 10:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343655AbiDAKaB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 06:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343535AbiDAK34 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 06:29:56 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BE126E57D
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 03:28:05 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 66F6420CAB75
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Subject: [PATCH BlueZ 2/7] tools: Fix buffer overflow in hciattach_tialt.c
Date:   Fri, 1 Apr 2022 13:27:52 +0300
Message-ID: <20220401102757.3960551-3-i.kamaletdinov@omp.ru>
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

Array 'c_brf_chip' of size 8 could be accessed by index > 7. We should
limit array access like in previous check at line 221.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.
---
 tools/hciattach_tialt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/hciattach_tialt.c b/tools/hciattach_tialt.c
index 520b383a1..4f7fd42a3 100644
--- a/tools/hciattach_tialt.c
+++ b/tools/hciattach_tialt.c
@@ -221,7 +221,8 @@ int texasalt_init(int fd, int speed, struct termios *ti)
 				((brf_chip > 7) ? "unknown" : c_brf_chip[brf_chip]),
 				brf_chip);
 
-		sprintf(fw, "/etc/firmware/%s.bin", c_brf_chip[brf_chip]);
+		sprintf(fw, "/etc/firmware/%s.bin",
+			(brf_chip > 7) ? "unknown" : c_brf_chip[brf_chip]);
 		texas_load_firmware(fd, fw);
 
 		texas_change_speed(fd, speed);
-- 
2.35.1

