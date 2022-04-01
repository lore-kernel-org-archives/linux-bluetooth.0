Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E84C43217
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Apr 2022 11:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345380AbiDALQO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Apr 2022 07:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345374AbiDALQL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Apr 2022 07:16:11 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B704812E16C
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Apr 2022 04:14:16 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 2237A20CBB89
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Subject: [PATCH BlueZ 4/7] tools: Prevent infinity loops in bluemoon.c
Date:   Fri, 1 Apr 2022 14:14:05 +0300
Message-ID: <20220401111408.3961844-5-i.kamaletdinov@omp.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220401111408.3961844-1-i.kamaletdinov@omp.ru>
References: <20220401111408.3961844-1-i.kamaletdinov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1910.lancloud.ru (fd00:f066::80)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In case FW size is too big we can face with infinity while() loops.
According to C99 standard SIZE_MAX could be as small as 65535.

So to prevent overflow of 'firmware_offset' we must limit maximum FW
size that could be processed by bluemoon.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.
---
 tools/bluemoon.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/bluemoon.c b/tools/bluemoon.c
index f50107a2a..729da36f6 100644
--- a/tools/bluemoon.c
+++ b/tools/bluemoon.c
@@ -492,6 +492,13 @@ static void request_firmware(const char *path)
 		return;
 	}
 
+	if (st.st_size > (SIZE_MAX - 4)) {
+		fprintf(stderr, "Firmware size is too big\n");
+		close(fd);
+		shutdown_device();
+		return;
+	}
+
 	firmware_data = malloc(st.st_size);
 	if (!firmware_data) {
 		fprintf(stderr, "Failed to allocate firmware buffer\n");
@@ -874,6 +881,12 @@ static void analyze_firmware(const char *path)
 		return;
 	}
 
+	if (st.st_size > (SIZE_MAX - 3)) {
+		fprintf(stderr, "Firmware size is too big\n");
+		close(fd);
+		return;
+	}
+
 	firmware_data = malloc(st.st_size);
 	if (!firmware_data) {
 		fprintf(stderr, "Failed to allocate firmware buffer\n");
-- 
2.35.1

