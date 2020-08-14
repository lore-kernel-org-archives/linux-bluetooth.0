Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B15BC433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 09:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5C39204EA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 09:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgHNJyi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 05:54:38 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:36114 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgHNJyi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 05:54:38 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id A2048B0AAE
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2020 17:54:34 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [113.57.152.160])
        by smtp.263.net (postfix) whith ESMTP id P26754T139821989230336S1597398873569370_;
        Fri, 14 Aug 2020 17:54:34 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a450811399363fd9bfc0679124b830ca>
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
Subject: [PATCH BlueZ] adapt:Set property mode failed,memory leak This patch will fix a memory leak,when set property mode,it will send a msg, but if failed,the data'memory do not free
Date:   Fri, 14 Aug 2020 17:54:33 +0800
Message-Id: <20200814095433.10654-1-515672508@qq.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 src/adapter.c | 1 +
 1 file changed, 1 insertion(+)

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



