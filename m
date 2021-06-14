Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64122C2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E0161002
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 17:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbhFNRs7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233975AbhFNRs6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jun 2021 13:48:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDECC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 10:46:46 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id u18so6352594plc.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 10:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zfH7NxJswAHgyoEd2HcZ5Wmd5SRFGG1RoPJgAG94BYA=;
        b=N/NyggQs0w7GvjeHS8rJ2VjVE3TxriCWcDUlGL8XldlOvK45e0HqFQs7b7abL5qKWr
         /UeCltty4t+Nknjov1Fjvji7mx+YdrT9Qtp0QllMvy9s9EygsWY9kGE1gXpLgaU8LUu6
         FXtmWi0uu7sIzU3PQPFrYLFLLZSKulVDPlAf3tc6ktMGlbsQmAMY4GgAC8vaBrjNNOFn
         gs3akFkzefFqCeTluhRy6kvBjeRhd521bGKn1YVbPIFepT9UkSj/gyaK83eejUKyUheW
         rvOPB5l3KvNppqyqvAJIsyE9sNWB1OP3TMtVSIedUcS/HWc8cLU/vpxJ72ABLQXrYDmo
         zhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zfH7NxJswAHgyoEd2HcZ5Wmd5SRFGG1RoPJgAG94BYA=;
        b=UXAR3TtfKMjGzOFOavDzJNYpLzlpXKu2uIfxUsQC9MjslRGQPcMpVIRAY+Uz7iNR9d
         RFr/XJDUEz1w2l/lTs0toUCMX8elmMBFTMpIfpx43AoLvVK5c9VHB5DC0ZWnkdwc+xTW
         fi4lHvoJZkhSik3mIUucjJKVM9oEHHiFewXddNV+gVH6Ks6G2gsOrgJkIO6+up0P5zB2
         nHpjTGTxuN3LfBonSjybNoLPBguwotk874qd+X+UCD6IZfbvEolisnX8rsI+mi/o4XsR
         WKPS475O+2oq/NrXaq/J1hfg+VrD5q3bCZk3kp84N/8wiWaPSUctuubOxCotNT8Bh3Ki
         +yfw==
X-Gm-Message-State: AOAM533rkWWUfDG+3d7EflTY7V+QI2xblHURU7Kd6M670hi/n4W3r4dx
        TanmZIHp10PGFPrEZhhc38uffTuQZQ4nrQ==
X-Google-Smtp-Source: ABdhPJwGI8Y71ivnWHdqSUr4Sgx51c9+f7Fl2jTlsClrk4QfMxTs33ahXmcgIDdymxpgecFtmDNpZQ==
X-Received: by 2002:a17:902:c948:b029:114:91be:32f6 with SMTP id i8-20020a170902c948b029011491be32f6mr227425pla.64.1623692806232;
        Mon, 14 Jun 2021 10:46:46 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f18sm93074pjq.48.2021.06.14.10.46.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:46:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: SMP: Fix crash when receiving new connection when debug is enabled
Date:   Mon, 14 Jun 2021 10:46:44 -0700
Message-Id: <20210614174644.1259909-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When receiving a new connection pchan->conn won't be initialized so the
code cannot use bt_dev_dbg as the pointer to hci_dev won't be
accessible.

Fixes: 2e1614f7d61e4 ("Bluetooth: SMP: Convert BT_ERR/BT_DBG to bt_dev_err/bt_dev_dbg")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/smp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 53f984d11bc1..11f853d0500f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3231,7 +3231,7 @@ static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
 {
 	struct l2cap_chan *chan;
 
-	bt_dev_dbg(pchan->conn->hcon->hdev, "pchan %p", pchan);
+	BT_DBG("pchan %p", pchan);
 
 	chan = l2cap_chan_create();
 	if (!chan)
@@ -3252,7 +3252,7 @@ static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
 	 */
 	atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
 
-	bt_dev_dbg(pchan->conn->hcon->hdev, "created chan %p", chan);
+	BT_DBG("created chan %p", chan);
 
 	return chan;
 }
@@ -3356,7 +3356,7 @@ static void smp_del_chan(struct l2cap_chan *chan)
 {
 	struct smp_dev *smp;
 
-	bt_dev_dbg(chan->conn->hcon->hdev, "chan %p", chan);
+	BT_DBG("chan %p", chan);
 
 	smp = chan->data;
 	if (smp) {
-- 
2.31.1

