Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A63C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 May 2022 15:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385674AbiEGPQr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 May 2022 11:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241614AbiEGPQq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 May 2022 11:16:46 -0400
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B312D1FE
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 May 2022 08:12:58 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 8685020CFFC6
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
To:     <linux-bluetooth@vger.kernel.org>
CC:     Ildar Kamaletdinov <i.kamaletdinov@omp.ru>
Subject: [PATCH BlueZ 1/4] tools: Fix memory leak in hciconfig
Date:   Sat, 7 May 2022 18:06:54 +0300
Message-ID: <20220507150657.28240-2-i.kamaletdinov@omp.ru>
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

printf() was using function that return dynamic allocated memory as
a parameter.

Found by Linux Verification Center (linuxtesting.org) with the SVACE
static analysis tool.
---
 tools/hciconfig.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index e4d521583..2619285d5 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -80,7 +80,10 @@ static void print_pkt_type(struct hci_dev_info *di)
 
 static void print_link_policy(struct hci_dev_info *di)
 {
-	printf("\tLink policy: %s\n", hci_lptostr(di->link_policy));
+	char *str;
+	str = hci_lptostr(di->link_policy);
+	printf("\tLink policy: %s\n", str);
+	bt_free(str);
 }
 
 static void print_link_mode(struct hci_dev_info *di)
-- 
2.35.3

