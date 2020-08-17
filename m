Return-Path: <SRS0=KHjC=B3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F05C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 02:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA7E20658
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Aug 2020 02:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgHQCuF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Aug 2020 22:50:05 -0400
Received: from lucky1.263xmail.com ([211.157.147.133]:39990 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgHQCuD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Aug 2020 22:50:03 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Aug 2020 22:50:02 EDT
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id DCD08C5EB9
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2020 10:42:34 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [113.57.152.160])
        by smtp.263.net (postfix) whith ESMTP id P18320T139785900570368S1597632154375135_;
        Mon, 17 Aug 2020 10:42:35 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <607354c5bf9259ae2c0df726aa5bea82>
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
Subject: [PATCH BlueZ 1/1] scr:Set property mode failed,memory leak
Date:   Mon, 17 Aug 2020 10:42:34 +0800
Message-Id: <20200817024234.13758-1-515672508@qq.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch will fix a memory leak,when set property mode,
it will creat a request,if failed,the data's memory do not free
---
 src/adapter.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5e896a9f0..3d07921a7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2917,9 +2917,10 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 	data->id = id;
 
 	if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
-			property_set_mode_complete, data, g_free) > 0)
+			property_set_mode_complete, data, g_free) > 0) {
+		g_free(data);
 		return;
-
+	}
 	g_free(data);
 
 failed:
-- 
2.20.1



