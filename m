Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012B9C433ED
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Apr 2021 02:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B892961185
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Apr 2021 02:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhDJCU3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Apr 2021 22:20:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16433 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDJCU2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Apr 2021 22:20:28 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FHJZ00DdgzqT0W;
        Sat, 10 Apr 2021 10:18:00 +0800 (CST)
Received: from DESKTOP-EFRLNPK.china.huawei.com (10.174.176.196) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Sat, 10 Apr 2021 10:20:06 +0800
From:   Qiheng Lin <linqiheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qiheng Lin <linqiheng@huawei.com>
Subject: [PATCH -next] Bluetooth: use flexible-array member instead of zero-length array
Date:   Sat, 10 Apr 2021 10:19:35 +0800
Message-ID: <20210410021935.11100-1-linqiheng@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.174.176.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix the following coccicheck warning:

net/bluetooth/msft.c:37:6-13: WARNING use flexible-array member instead
net/bluetooth/msft.c:42:6-10: WARNING use flexible-array member instead
net/bluetooth/msft.c:52:6-10: WARNING use flexible-array member instead

Signed-off-by: Qiheng Lin <linqiheng@huawei.com>
---
 net/bluetooth/msft.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/msft.c b/net/bluetooth/msft.c
index e28f15439ce4..37a394786a94 100644
--- a/net/bluetooth/msft.c
+++ b/net/bluetooth/msft.c
@@ -34,12 +34,12 @@ struct msft_le_monitor_advertisement_pattern {
 	__u8 length;
 	__u8 data_type;
 	__u8 start_byte;
-	__u8 pattern[0];
+	__u8 pattern[];
 };
 
 struct msft_le_monitor_advertisement_pattern_data {
 	__u8 count;
-	__u8 data[0];
+	__u8 data[];
 };
 
 struct msft_cp_le_monitor_advertisement {
@@ -49,7 +49,7 @@ struct msft_cp_le_monitor_advertisement {
 	__u8 rssi_low_interval;
 	__u8 rssi_sampling_period;
 	__u8 cond_type;
-	__u8 data[0];
+	__u8 data[];
 } __packed;
 
 struct msft_rp_le_monitor_advertisement {
-- 
2.31.1

