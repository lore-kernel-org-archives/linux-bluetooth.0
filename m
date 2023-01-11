Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A6BC54EBC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Jan 2023 01:23:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbjAKBXA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Jan 2023 20:23:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjAKBW6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Jan 2023 20:22:58 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F242C19
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 17:22:57 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so15460012pjj.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 17:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=1hZyYu1D4iIf/DIUik1bt7umt7x6WYLcjANjQoC4Ukw=;
        b=WHNT5xsLl203jJWfE7lkeXoDcs5HAE/soYai0gVdXHyOQygzHxIp0233WAsnEBxT/B
         qVNmec6TYrK6LFM/xFnK3N8UuDD7mHHGeL9IlIKrtHV9sHXaliW1kcMnWV0Eirs3+F6d
         ZIqL6SoGhtixBERqDBTIYJ4LkSB6WPMrqzbvcPie94pH25Mgqh3K7EYvapTp4ckV/7tj
         UiK7AMYUW+rlur/RP9Fy/boIQaMz3jCOJnCrSx4C6l4Q/fJEuz7PbBUMdQ0kk7UCXGLG
         lGiNvcWnzfgwUNxLLYD5zQbNghe27luIxtpUBa9WNg8WKHToJA5Sp4d/QPxwqT0Yqrv3
         QQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hZyYu1D4iIf/DIUik1bt7umt7x6WYLcjANjQoC4Ukw=;
        b=mQPVD/RUDttRRSv4pdcz6LuH48MGaSqd+FjvKsdFSKN27Ks9GgMCPeU7nuhQFaa01+
         b6gqCuZgBYD6pHfkJ8FaU5dEZN8SZ5rrr1cLbTn2ygBQTvRFZGY7ZevgB4Z3qjrcWIXY
         3FKWUS3yfaFktAE68jWdmdXqyQE1W/s8cNVGerNkGtB/4UViotHpxBwDKLDHAAZ2PTux
         wf7pUvfrAJnNmVg3ANPla28BQxUkMItST4bAcQ2TNaKlIqGwRajfzn7PLnE5e/4rv+kB
         Icta7VuoR3J+IB6PH3SKnQGnwc/y/g38DPjKi2AHJz2kOJQJIt1ykSjBUVQTBKiExwMH
         IDPg==
X-Gm-Message-State: AFqh2krrR3QTxJBbxmYNNpusUOaQnTOeyCTEsgtFjFJzLMPmO9JUOtFM
        PCivV2JALJVKUxyw5+f882iNXOl795o=
X-Google-Smtp-Source: AMrXdXvi7HbpJJmFCzNY6QSYWN5ULwKtK5hjxy1VrY39Txkp2UoK4W+rRziaBok7kCcu+Wq+AUhZsQ==
X-Received: by 2002:a17:902:e84e:b0:189:aedf:677d with SMTP id t14-20020a170902e84e00b00189aedf677dmr1022845plg.69.1673400176377;
        Tue, 10 Jan 2023 17:22:56 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b00192b0a07891sm8784670plx.101.2023.01.10.17.22.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 17:22:55 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_event: Fix Invalid wait context
Date:   Tue, 10 Jan 2023 17:22:53 -0800
Message-Id: <20230111012254.3724082-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following trace caused by attempting to lock
cmd_sync_work_lock while holding the rcu_read_lock:

kworker/u3:2/212 is trying to lock:
ffff888002600910 (&hdev->cmd_sync_work_lock){+.+.}-{3:3}, at:
hci_cmd_sync_queue+0xad/0x140
other info that might help us debug this:
context-{4:4}
4 locks held by kworker/u3:2/212:
 #0: ffff8880028c6530 ((wq_completion)hci0#2){+.+.}-{0:0}, at:
 process_one_work+0x4dc/0x9a0
 #1: ffff888001aafde0 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0},
 at: process_one_work+0x4dc/0x9a0
 #2: ffff888002600070 (&hdev->lock){+.+.}-{3:3}, at:
 hci_cc_le_set_cig_params+0x64/0x4f0
 #3: ffffffffa5994b00 (rcu_read_lock){....}-{1:2}, at:
 hci_cc_le_set_cig_params+0x2f9/0x4f0

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_event.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0594af4e37ca..ad92a4be5851 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3848,8 +3848,11 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 			   conn->handle, conn->link);
 
 		/* Create CIS if LE is already connected */
-		if (conn->link && conn->link->state == BT_CONNECTED)
+		if (conn->link && conn->link->state == BT_CONNECTED) {
+			rcu_read_unlock();
 			hci_le_create_cis(conn->link);
+			rcu_read_lock();
+		}
 
 		if (i == rp->num_handles)
 			break;
-- 
2.37.3

