Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA84C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 06:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FC6610CB
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Apr 2021 06:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbhDAGxw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Apr 2021 02:53:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15425 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhDAGx0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Apr 2021 02:53:26 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F9v3s44KnzjXhh;
        Thu,  1 Apr 2021 14:51:37 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 14:53:13 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <yumeng18@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] Bluetooth: Remove 'return' in void function
Date:   Thu, 1 Apr 2021 14:50:38 +0800
Message-ID: <1617259839-31383-2-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1617259839-31383-1-git-send-email-yumeng18@huawei.com>
References: <1617259839-31383-1-git-send-email-yumeng18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

void function return statements are not generally useful.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
---
 net/bluetooth/6lowpan.c    | 2 --
 net/bluetooth/l2cap_core.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index cff4944..19f7e42 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -841,8 +841,6 @@ static void chan_close_cb(struct l2cap_chan *chan)
 	} else {
 		spin_unlock(&devices_lock);
 	}
-
-	return;
 }
 
 static void chan_state_change_cb(struct l2cap_chan *chan, int state, int err)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 56e1975..ccfe8ad 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -676,8 +676,6 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		skb_queue_purge(&chan->tx_q);
 		break;
 	}
-
-	return;
 }
 EXPORT_SYMBOL_GPL(l2cap_chan_del);
 
-- 
2.8.1

