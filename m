Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0309C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 12:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344506AbiDAMSn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 08:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiDAMSm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 08:18:42 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACC027796C
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 05:16:52 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 51EE420D30A9
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Subject: [PATCH BlueZ 3/6] tools: Fix signed integer overflow in btsnoop.c
Date:   Fri, 1 Apr 2022 15:16:44 +0300
Message-ID: <20220401121647.3985682-4-i.kamaletdinov@omp.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401121647.3985682-1-i.kamaletdinov@omp.ru>
References: <20220401121647.3985682-1-i.kamaletdinov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1910.lancloud.ru (fd00:f066::80)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If malformed packet is proceed with zero 'size' field we will face with
wrong behaviour of write() call. Value 'toread - 1' gives wrong sign
for value 'written' (-1) in write() call. To prevent this we should
check that 'toread' is not equal to zero.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.
---
 tools/btsnoop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btsnoop.c b/tools/btsnoop.c
index 738027dfc..a0d6cf356 100644
--- a/tools/btsnoop.c
+++ b/tools/btsnoop.c
@@ -193,7 +193,7 @@ next_packet:
 	flags = be32toh(input_pkt[select_input].flags);
 
 	len = read(input_fd[select_input], buf, toread);
-	if (len < 0 || len != (ssize_t) toread) {
+	if (toread == 0 || len < 0 || len != (ssize_t) toread) {
 		close(input_fd[select_input]);
 		input_fd[select_input] = -1;
 		goto next_packet;
-- 
2.35.1

