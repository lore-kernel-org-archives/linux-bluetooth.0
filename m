Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BDAC433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 10:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2039520716
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 10:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgHNKAu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:00:50 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:56922 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgHNKAu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 06:00:50 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 599CAA1A0C
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 18:00:47 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [113.57.152.160])
        by smtp.263.net (postfix) whith ESMTP id P18320T139785796572928S1597399247734917_;
        Fri, 14 Aug 2020 18:00:48 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <78f4aea74d0e4521b5d1f26efcf9465d>
X-RL-SENDER: chengbo@uniontech.com
X-SENDER: chengbo@uniontech.com
X-LOGIN-NAME: chengbo@uniontech.com
X-FST-TO: linux-bluetooth@vger.kernel.org
X-SENDER-IP: 113.57.152.160
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   chengbo <515672508@qq.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] adapt:Set property mode failed,memory leak
Date:   Fri, 14 Aug 2020 18:00:47 +0800
Message-Id: <20200814100047.11008-1-515672508@qq.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch will fix a memory leak,when set property mode,it will send a msg,
but if failed,the data'memory do not free
---
 ...Set-property-mode-failed-memory-leak.patch | 26 +++++++++++++++++++
 src/adapter.c                                 |  1 +
 2 files changed, 27 insertions(+)
 create mode 100644 0001-adapt-Set-property-mode-failed-memory-leak.patch

diff --git a/0001-adapt-Set-property-mode-failed-memory-leak.patch b/0001-adapt-Set-property-mode-failed-memory-leak.patch
new file mode 100644
index 000000000..4994e03a6
--- /dev/null
+++ b/0001-adapt-Set-property-mode-failed-memory-leak.patch
@@ -0,0 +1,26 @@
+From 62d56bedbd32662b3f33af99dd464d67958e76d6 Mon Sep 17 00:00:00 2001
+From: chengbo <515672508@qq.com>
+Date: Fri, 14 Aug 2020 17:09:51 +0800
+Subject: [PATCH BlueZ] adapt:Set property mode failed,memory leak This patch
+ will fix a memory leak,when set property mode,it will send a msg, but if
+ failed,the data'memory do not free
+
+---
+ src/adapter.c | 1 +
+ 1 file changed, 1 insertion(+)
+
+diff --git a/src/adapter.c b/src/adapter.c
+index 5e896a9f0..cb4cd8b75 100644
+--- a/src/adapter.c
++++ b/src/adapter.c
+@@ -2918,6 +2918,7 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
+ 
+ 	if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
+ 			property_set_mode_complete, data, g_free) > 0)
++		g_free(data);
+ 		return;
+ 
+ 	g_free(data);
+-- 
+2.20.1
+
diff --git a/src/adapter.c b/src/adapter.c
index 5e896a9f0..cb4cd8b75 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2918,6 +2918,7 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 
 	if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
 			property_set_mode_complete, data, g_free) > 0)
+		g_free(data);
 		return;
 
 	g_free(data);
-- 
2.20.1



