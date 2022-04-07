Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002F2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Apr 2022 04:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240722AbiDGEoK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Apr 2022 00:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbiDGEoI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Apr 2022 00:44:08 -0400
X-Greylist: delayed 908 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 21:42:09 PDT
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 101AE65E0;
        Wed,  6 Apr 2022 21:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=M+DOsIMoR6Lx2TPgr7
        0J/v+vaBEJ+wDqvgo9cHgmApQ=; b=PVw5TznebNmyM0YY97rMsBrkSdWGiw3nRL
        r2IIynXIhE2Cb5Y5RH1cHkDdTzBjLcB2vv1vV1DLKDBWcLm1vq7txcaFwQM6+MqS
        sUbwmLF+VoeyTTze1RHfF3nfvLHbfU2k4LRJLsItwoSxC+2mbUa4V3sryottKVIq
        GX94/WzXs=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp5 (Coremail) with SMTP id HdxpCgCXGrH7Z05i+MtdAA--.7405S4;
        Thu, 07 Apr 2022 12:26:52 +0800 (CST)
From:   Yuanjun Gong <ruc_gongyuanjun@163.com>
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Bluetooth: hci_uart: check for missing tty operations
Date:   Thu,  7 Apr 2022 12:26:23 +0800
Message-Id: <20220407042623.28438-1-ruc_gongyuanjun@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: HdxpCgCXGrH7Z05i+MtdAA--.7405S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4fAr17KrWrXFy8JFW8WFg_yoW8WFW7pF
        WfGF15CF1UJr47Wr17Aay5WFyrJ3Z3WrWIk39Fvas8urW5trW8Zw1ay345t39rZrW5Jr4I
        v3WDta47GF1UJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRnvtAUUUUU=
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: 5uxfsw5rqj53pdqm30i6rwjhhfrp/1tbiJw3b5V5vBN3fPgABsc
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Gong Yuanjun <ruc_gongyuanjun@163.com>

Add a check to the missing tty operations in hci_ag6xx,
hci_h4, hci_ll following the implementations in hci_ath.

Signed-off-by: Gong Yuanjun <ruc_gongyuanjun@163.com>
---
 drivers/bluetooth/hci_ag6xx.c | 3 +++
 drivers/bluetooth/hci_h4.c    | 3 +++
 drivers/bluetooth/hci_ll.c    | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/drivers/bluetooth/hci_ag6xx.c b/drivers/bluetooth/hci_ag6xx.c
index 2d40302409ff..a5f141d43066 100644
--- a/drivers/bluetooth/hci_ag6xx.c
+++ b/drivers/bluetooth/hci_ag6xx.c
@@ -36,6 +36,9 @@ static int ag6xx_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
+        if (!hci_uart_has_flow_control(hu))
+            return -EOPNOTSUPP;
+
 	ag6xx = kzalloc(sizeof(*ag6xx), GFP_KERNEL);
 	if (!ag6xx)
 		return -ENOMEM;
diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 1d0cdf023243..0ceabe340351 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -44,6 +44,9 @@ static int h4_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
+        if (!hci_uart_has_flow_control(hu))
+            return -EOPNOTSUPP;
+
 	h4 = kzalloc(sizeof(*h4), GFP_KERNEL);
 	if (!h4)
 		return -ENOMEM;
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 4eb420a9ed04..22166df1467f 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -114,6 +114,9 @@ static int ll_open(struct hci_uart *hu)
 
 	BT_DBG("hu %p", hu);
 
+        if (!hci_uart_has_flow_control(hu))
+            return -EOPNOTSUPP;
+
 	ll = kzalloc(sizeof(*ll), GFP_KERNEL);
 	if (!ll)
 		return -ENOMEM;
-- 
2.17.1

