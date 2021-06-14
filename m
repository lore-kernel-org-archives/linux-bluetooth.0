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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0963EC48BE8
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 17:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8DC761352
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jun 2021 17:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhFNRG7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:06:59 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:45775 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235429AbhFNRG7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jun 2021 13:06:59 -0400
Received: by mail-pg1-f173.google.com with SMTP id q15so9130418pgg.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jun 2021 10:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zLooGsgG1er0NKeoKJOwp2oC3UJdX+oI+pS9jjr3XuU=;
        b=UQS2+fP7lFGS/AL0fydmNzzDtk20YfNDN2ghp6pWgzJihLHi19Q8hpb3nZ/GFOsC7k
         7t6921tbFYfrLvxW+KgfIwHI5CdFaZMt1JxBQxj6gLLzfRgoYWKx8WSYBb9OQLP3XmAW
         GTHm42dLyxYSz4qyqYicraQA2smazTvkRHIDAea/P9lcO04WK9WU+VNRhKRH6F9Wy8M/
         mBufuuELdgc7CJMDYmYfBodNE2Bn9sp1fPfSweS691svRmAyiXhKJFo1bZIhr/hVfeWb
         yb1kBqqcUwCq7eX8AQmplNlQGUIszl49hWAOfyhUuK1bHt39HzCHfMJSTS0xz7oUGK/h
         M2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zLooGsgG1er0NKeoKJOwp2oC3UJdX+oI+pS9jjr3XuU=;
        b=k5AeJDz0YXVDV370ldF2a2yl8smMdwGP74IDUYdVWel71ubL7RH2YdXDBlls8jFhyy
         q0VXVyAaElrfmjNbtB/AosT2G9gARh5y0BepJQWBt5pKn2gIkqKszHzF8p29u/4FrP2o
         teMU5LxfDvo2v2I32E7WQM2Se3j4TfPM7RKpRpG7bqZ07LYZKzdUZJnJmgtQQRsJLH1C
         XrKEhShWyR3WASigRPLx4Pe8/y6nTBHvw/M4N8PsB9V0TvH6IeGJvPp3PVtNyEiNo7Sg
         ays6Ckm3vqP+lOC6IKE9ay74lSzSVdpF72N6i1iUmG8YFIOtFAkfYS2gekGkbEyQPaL8
         mSgg==
X-Gm-Message-State: AOAM5337buaq40aNlJV3CJ5YXNIFEkgAi5UW58vXS/N6bwJIG2oInYcM
        /IRi9xppFdPZo3EOh1QxQMorhM7wYtld5A==
X-Google-Smtp-Source: ABdhPJxEyTar3HRJaqPQoIsUBkiaarKUFQyLpZKm60qIfZq2sS/r/93cDxgquL004BR88mKDVNQ+rQ==
X-Received: by 2002:a65:644c:: with SMTP id s12mr10696056pgv.318.1623690235364;
        Mon, 14 Jun 2021 10:03:55 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s22sm12756329pfg.197.2021.06.14.10.03.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:03:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: SMP: Fix crash when receiving new connection when debug is enabled
Date:   Mon, 14 Jun 2021 10:03:54 -0700
Message-Id: <20210614170354.1197989-1-luiz.dentz@gmail.com>
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
 net/bluetooth/smp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 53f984d11bc1..8fb8ccd63ca9 100644
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
-- 
2.31.1

