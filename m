Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1556C19F2B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Aug 2022 08:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbiHDIQS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Aug 2022 04:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiHDIQQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Aug 2022 04:16:16 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF6617061;
        Thu,  4 Aug 2022 01:16:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VLLurmP_1659600958;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VLLurmP_1659600958)
          by smtp.aliyun-inc.com;
          Thu, 04 Aug 2022 16:16:10 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, luiz.dentz@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] Bluetooth: Clean up some inconsistent indenting
Date:   Thu,  4 Aug 2022 16:15:56 +0800
Message-Id: <20220804081556.94743-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

No functional modification involved.

net/bluetooth/hci_debugfs.c:192 uuids_show() warn: inconsistent
indenting.

Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=1821
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 net/bluetooth/hci_debugfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 902b40a90b91..1d4bee86fbbd 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -187,9 +187,9 @@ static int uuids_show(struct seq_file *f, void *p)
 
 		seq_printf(f, "%pUb\n", val);
 	}
-	hci_dev_unlock(hdev);
 
-       return 0;
+	hci_dev_unlock(hdev);
+	return 0;
 }
 
 DEFINE_SHOW_ATTRIBUTE(uuids);
-- 
2.20.1.7.g153144c

