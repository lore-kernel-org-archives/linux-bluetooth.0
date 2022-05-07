Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B3CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 May 2022 15:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446581AbiEGPQs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 May 2022 11:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238956AbiEGPQo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 May 2022 11:16:44 -0400
X-Greylist: delayed 351 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 07 May 2022 08:12:56 PDT
Received: from mxout02.lancloud.ru (mxout02.lancloud.ru [45.84.86.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3B32D1F0
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 May 2022 08:12:55 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout02.lancloud.ru 1AB132323A66
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Subject: [PATCH BlueZ 3/4] tools: Fix handle leak in rfcomm
Date:   Sat, 7 May 2022 18:06:56 +0300
Message-ID: <20220507150657.28240-4-i.kamaletdinov@omp.ru>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220507150657.28240-1-i.kamaletdinov@omp.ru>
References: <20220507150657.28240-1-i.kamaletdinov@omp.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1910.lancloud.ru (fd00:f066::80)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Some branches of execution can make handle (socket) leakage.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.
---
 tools/rfcomm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/rfcomm.c b/tools/rfcomm.c
index cd520aa44..e013ff588 100644
--- a/tools/rfcomm.c
+++ b/tools/rfcomm.c
@@ -298,6 +298,7 @@ static void cmd_connect(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **arg
 
 		if (setsockopt(sk, SOL_SOCKET, SO_LINGER, &l, sizeof(l)) < 0) {
 			perror("Can't set linger option");
+			close(sk);
 			return;
 		}
 	}
@@ -466,6 +467,7 @@ static void cmd_listen(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv
 	if (getsockname(nsk, (struct sockaddr *)&laddr, &alen) < 0) {
 		perror("Can't get RFCOMM socket name");
 		close(nsk);
+		close(sk);
 		return;
 	}
 
@@ -475,6 +477,7 @@ static void cmd_listen(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv
 		if (setsockopt(nsk, SOL_SOCKET, SO_LINGER, &l, sizeof(l)) < 0) {
 			perror("Can't set linger option");
 			close(nsk);
+			close(sk);
 			return;
 		}
 	}
@@ -490,6 +493,7 @@ static void cmd_listen(int ctl, int dev, bdaddr_t *bdaddr, int argc, char **argv
 	dev = ioctl(nsk, RFCOMMCREATEDEV, &req);
 	if (dev < 0) {
 		perror("Can't create RFCOMM TTY");
+		close(nsk);
 		close(sk);
 		return;
 	}
-- 
2.35.3

