Return-Path: <SRS0=ag/l=4U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8CEC3F2D8
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Mar 2020 00:56:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0425E24681
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Mar 2020 00:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/VlgiIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgCCA43 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Mar 2020 19:56:29 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:34982 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgCCA43 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Mar 2020 19:56:29 -0500
Received: by mail-pj1-f66.google.com with SMTP id s8so556377pjq.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Mar 2020 16:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qAxMeOymKacb337KY0XVJYFuhLcPjBk7JSRxQLPswi8=;
        b=T/VlgiIjcHT8ATPvg//bDtI+jYGeGPOnFeRztLhQd3uljP5ycKav+TER8quiVOzL4P
         6wfubTqrn80aeZygJOD2RbgjqjAezau+G66bWnqC8nwPnb4O9QfzAmtJB9i/2fUXGY4S
         x3UmFvkj4vaQQF+nKCnsIl/qhh/CF6slWseamG9tKjVbX8eD+KQ+8S9KGZ4RJm1Q6WtU
         4FPrH7U/NxzLdVfxzikfIo+8KiRuzUxbegTQVIIxkWYpMLxnU0fTlh7dQW1/eQJnixJs
         zYfkemkPK1JB1BNTi6tr9K8iU2UPuRMBxcppF7H+0U/eXC6I07O6YlZVM9aC9Q+8rvZj
         C/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qAxMeOymKacb337KY0XVJYFuhLcPjBk7JSRxQLPswi8=;
        b=c9CnmxSRsC7n0DVqil5ocSL1mPoESeKSbpOIsxKeRSl0vOW77T6JF2hUSxWcL7vq+g
         uyP3lg3OmvTArcBQVt35r0J72Vdu6IjBl3VaW6cq6SqkoQQR+dbP0pjKB7YQYBNfwJDg
         vQZqEIPLLa+c5WDEwSTtpoqamVdsMp52LIeDQZT7ph/C39WFSdX4O1rx+4jY1Dwr207d
         RpaJvC0/WxQGAnPW1+y3zwSa5jgvtwgFApDPM1E2HwLDZZJliEQEcTlCV5eaao+3AtUZ
         5p205/IFjM7A4wneqJaGbavgfWTk74bh18v3/gqnFtHC3Co2Lw6d88wi+wWLx8ERBTrf
         uT4w==
X-Gm-Message-State: ANhLgQ2icm6KADhoJJBXjVN1qZ8+S05iuWHoVeci1ak+zyaOOYOhKQmb
        /IJsEXXrjfwR8bfYPeDT/LSdZk1TYmk=
X-Google-Smtp-Source: ADFU+vt19v2+SqtCoINoQLo1wHnNl1dJ0z6iKVblRa7OqlTI8Zd6na7mVLyEox57v3cTaUc6QUgnxw==
X-Received: by 2002:a17:90a:cb83:: with SMTP id a3mr1307215pju.80.1583196986133;
        Mon, 02 Mar 2020 16:56:26 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b21sm23218500pfp.0.2020.03.02.16.56.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 16:56:25 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/5] Bluetooth: L2CAP: Add module option to enable ECRED mode
Date:   Mon,  2 Mar 2020 16:56:21 -0800
Message-Id: <20200303005623.18917-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200303005623.18917-1-luiz.dentz@gmail.com>
References: <20200303005623.18917-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This should make it safe to have the code upstream without affecting
stable systems since there are a few details not sort out with ECRED
mode e.g: how to initiate multiple connections at once.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 15 +++++++++++++++
 net/bluetooth/l2cap_sock.c    |  5 +++++
 3 files changed, 21 insertions(+)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index dbe68b06d4bb..1644c9651a35 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -958,6 +958,7 @@ static inline long l2cap_chan_no_get_sndtimeo(struct l2cap_chan *chan)
 }
 
 extern bool disable_ertm;
+extern bool enable_ecred;
 
 int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 5c03baffc82c..badfbbcc0de4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -45,6 +45,7 @@
 #define LE_FLOWCTL_MAX_CREDITS 65535
 
 bool disable_ertm;
+bool enable_ecred;
 
 static u32 l2cap_feat_mask = L2CAP_FEAT_FIXED_CHAN | L2CAP_FEAT_UCD;
 
@@ -5849,6 +5850,9 @@ static inline int l2cap_ecred_conn_req(struct l2cap_conn *conn,
 	int i, num_scid;
 	bool defer = false;
 
+	if (!enable_ecred)
+		return -EINVAL;
+
 	if (cmd_len < sizeof(*req) || cmd_len - sizeof(*req) % sizeof(u16)) {
 		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto response;
@@ -6092,6 +6096,9 @@ static inline int l2cap_ecred_reconf_req(struct l2cap_conn *conn,
 	struct l2cap_chan *chan;
 	int i, num_scid;
 
+	if (!enable_ecred)
+		return -EINVAL;
+
 	if (cmd_len < sizeof(*req) || cmd_len - sizeof(*req) % sizeof(u16)) {
 		result = L2CAP_CR_LE_INVALID_PARAMS;
 		goto respond;
@@ -7726,7 +7733,12 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	case L2CAP_MODE_BASIC:
 		break;
 	case L2CAP_MODE_LE_FLOWCTL:
+		break;
 	case L2CAP_MODE_EXT_FLOWCTL:
+		if (!enable_ecred) {
+			err = -EOPNOTSUPP;
+			goto done;
+		}
 		break;
 	case L2CAP_MODE_ERTM:
 	case L2CAP_MODE_STREAMING:
@@ -8304,3 +8316,6 @@ void l2cap_exit(void)
 
 module_param(disable_ertm, bool, 0644);
 MODULE_PARM_DESC(disable_ertm, "Disable enhanced retransmission mode");
+
+module_param(enable_ecred, bool, 0644);
+MODULE_PARM_DESC(enable_ecred, "Enable enhanced credit flow control mode");
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 44114db219e1..0c636be3469e 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -273,7 +273,12 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 	switch (chan->mode) {
 	case L2CAP_MODE_BASIC:
 	case L2CAP_MODE_LE_FLOWCTL:
+		break;
 	case L2CAP_MODE_EXT_FLOWCTL:
+		if (!enable_ecred) {
+			err = -EOPNOTSUPP;
+			goto done;
+		}
 		break;
 	case L2CAP_MODE_ERTM:
 	case L2CAP_MODE_STREAMING:
-- 
2.21.1

