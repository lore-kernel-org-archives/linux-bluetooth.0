Return-Path: <SRS0=QcUl=BD=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E3FC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jul 2020 12:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C4920737
	for <linux-bluetooth@archiver.kernel.org>; Fri, 24 Jul 2020 12:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgGXMZO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:25:14 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:39376 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGXMZN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 24 Jul 2020 08:25:13 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 7A3FDB01C6
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2020 20:25:11 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [113.57.152.160])
        by smtp.263.net (postfix) whith ESMTP id P30362T140065527297792S1595593511218582_;
        Fri, 24 Jul 2020 20:25:11 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <9caa455dffd2153fa76e1e41fd427b7c>
X-RL-SENDER: luokai@uniontech.com
X-SENDER: luokai@uniontech.com
X-LOGIN-NAME: luokai@uniontech.com
X-FST-TO: linux-bluetooth@vger.kernel.org
X-SENDER-IP: 113.57.152.160
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   luokai <454728735@qq.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luokai <luokai@uniontech.com>
Subject: [PATCH BlueZ 1/1] src/agent.c : parse_io_capability Function optimization
Date:   Fri, 24 Jul 2020 20:25:07 +0800
Message-Id: <20200724122507.27671-1-454728735@qq.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: luokai <luokai@uniontech.com>

---
 src/agent.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index e0ffcd22f..82baf608f 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -957,20 +957,24 @@ static void agent_destroy(gpointer data)
 	agent_unref(agent);
 }
 
+static struct capability g_cap[]  = {
+	{"", IO_CAPABILITY_KEYBOARDDISPLAY},
+	{"DisplayOnly", IO_CAPABILITY_DISPLAYONLY},
+	{"DisplayYesNo", IO_CAPABILITY_DISPLAYYESNO},
+	{"KeyboardOnly", IO_CAPABILITY_KEYBOARDONLY},
+	{"NoInputNoOutput", IO_CAPABILITY_NOINPUTNOOUTPUT},
+	{"KeyboardDisplay", IO_CAPABILITY_KEYBOARDDISPLAY}
+};
+
 static uint8_t parse_io_capability(const char *capability)
 {
-	if (g_str_equal(capability, ""))
-		return IO_CAPABILITY_KEYBOARDDISPLAY;
-	if (g_str_equal(capability, "DisplayOnly"))
-		return IO_CAPABILITY_DISPLAYONLY;
-	if (g_str_equal(capability, "DisplayYesNo"))
-		return IO_CAPABILITY_DISPLAYYESNO;
-	if (g_str_equal(capability, "KeyboardOnly"))
-		return IO_CAPABILITY_KEYBOARDONLY;
-	if (g_str_equal(capability, "NoInputNoOutput"))
-		return IO_CAPABILITY_NOINPUTNOOUTPUT;
-	if (g_str_equal(capability, "KeyboardDisplay"))
-		return IO_CAPABILITY_KEYBOARDDISPLAY;
+	size_t count = sizeof(g_cap) / sizeof(g_cap[0]); 
+	for (size_t i = 0; i < count; i++)
+	{
+		if(g_str_equal(capability, g_cap[i].cap)) {
+			return g_cap[i].parse_capability;
+		}
+	}
 	return IO_CAPABILITY_INVALID;
 }
 
-- 
2.20.1



