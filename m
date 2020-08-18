Return-Path: <SRS0=EW2K=B4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF054C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 01:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2BF8207BB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Aug 2020 01:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgHRBYb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Aug 2020 21:24:31 -0400
Received: from lucky1.263xmail.com ([211.157.147.132]:51744 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgHRBYb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Aug 2020 21:24:31 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 08AA3ECE2D;
        Tue, 18 Aug 2020 09:24:25 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [113.57.152.160])
        by smtp.263.net (postfix) whith ESMTP id P18320T139785528137472S1597713864401396_;
        Tue, 18 Aug 2020 09:24:25 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <4c6b7526f22a2d9df226d40b6c81469e>
X-RL-SENDER: chengbo@uniontech.com
X-SENDER: chengbo@uniontech.com
X-LOGIN-NAME: chengbo@uniontech.com
X-FST-TO: luiz.dentz@gmail.com
X-SENDER-IP: 113.57.152.160
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   chengbo <515672508@qq.com>
To:     luiz.dentz@gmail.com
Cc:     515672508@qq.com, linux-bluetooth@vger.kernel.org
Subject: [PATCH] scr:Set property mode failed,memory leak
Date:   Tue, 18 Aug 2020 09:24:24 +0800
Message-Id: <20200818012424.8174-1-515672508@qq.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CABBYNZ+-zF9qLrYdBSWjdWd3qfOJOk-VzNVfTG5eSLYPZ76ahw@mail.gmail.com>
References: <CABBYNZ+-zF9qLrYdBSWjdWd3qfOJOk-VzNVfTG5eSLYPZ76ahw@mail.gmail.com>
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

In the original code,if mgmt_send fails then 0 is returned,then this function return directly,do not free data.
Therefore, you need to free data before executing return.

 	g_free(data);
 
 failed:
-- 
2.20.1



