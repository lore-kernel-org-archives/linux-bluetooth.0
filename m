Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE37C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 May 2022 17:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352057AbiEGRLL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 May 2022 13:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446666AbiEGRLC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 May 2022 13:11:02 -0400
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694A03B555
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 May 2022 10:07:12 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 331BB2225710
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Subject: [PATCH BlueZ 2/4] tools: Fix memory leaks in btgatt-server/client
Date:   Sat, 7 May 2022 20:07:01 +0300
Message-ID: <20220507170703.29902-3-i.kamaletdinov@omp.ru>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220507170703.29902-1-i.kamaletdinov@omp.ru>
References: <20220507170703.29902-1-i.kamaletdinov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1910.lancloud.ru (fd00:f066::80)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

According to man buffer allocated by getline() should be freed by
the user program even if getline() failed.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.
---
 tools/btgatt-client.c | 6 +++++-
 tools/btgatt-server.c | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index 8c9365aa2..58a03bd48 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -1355,12 +1355,16 @@ static void prompt_read_cb(int fd, uint32_t events, void *user_data)
 		return;
 	}
 
-	if ((read = getline(&line, &len, stdin)) == -1)
+	read = getline(&line, &len, stdin);
+	if (read < 0) {
+		free(line);
 		return;
+	}
 
 	if (read <= 1) {
 		cmd_help(cli, NULL);
 		print_prompt();
+		free(line);
 		return;
 	}
 
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index 4a5d2b720..90a6c9b0a 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -1080,12 +1080,15 @@ static void prompt_read_cb(int fd, uint32_t events, void *user_data)
 	}
 
 	read = getline(&line, &len, stdin);
-	if (read < 0)
+	if (read < 0) {
+		free(line);
 		return;
+	}
 
 	if (read <= 1) {
 		cmd_help(server, NULL);
 		print_prompt();
+		free(line);
 		return;
 	}
 
-- 
2.35.3

