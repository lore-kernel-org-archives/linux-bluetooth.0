Return-Path: <SRS0=zBEa=4N=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9966AC35DF8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 07:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAB021556
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Feb 2020 07:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8ZfymO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgBYHen (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:34:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37200 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbgBYHen (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Feb 2020 02:34:43 -0500
Received: by mail-pl1-f195.google.com with SMTP id q4so1005711pls.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2020 23:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q7FMO0tY3GrpptxYGOy6p6clh2jcMvOY7s3FjDQCpa4=;
        b=k8ZfymO472Adz8rbDKLPFke5BpXY3cYLxEsop+55oGxXqx7dkL+3Ebo2VkEabXJQG/
         GeBKdfFenv9uz6JU8aQNX+uaXrbxJt95CnQJFiK9G1mKhe2uz2pzgJoBKSGp197Zrjsg
         1ljdEF8RvsPo03/b7e+thpalmvsReTicCrlctqFgXcnY5zLA7XQTzpfBfGn/YEFIY6Lk
         ixBOStV3oxyHOXumr+mp1/jTkn/941ZlPthW5VbBqC+2oIIRWg4G9T/YTapT10PgM7uH
         v5RG+8uHrafJMRFejGQSagRBrTAk1Fk7W++9ngJNW5QqhkFmXbP6K6SCunsMnPJCyqp6
         ArWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q7FMO0tY3GrpptxYGOy6p6clh2jcMvOY7s3FjDQCpa4=;
        b=csDx8uCukVz+xPfJg4yrEalmbkDqFIHPlkBKzfk+xEfE1vyPgqNCZPgnDBPM1ZuA3p
         28R214t5sEDAKa8I6XQEyrborcMTm+sxruGucsTLixS44DufZl8E+UCG63LSWRzhJyEM
         AUcxD/2NDrO5uvCrNUrfl7LveMqhNaKna/0CNciSJ1DCypHxwMJDHiaFovY8CpUZw/xo
         JIlJnnpEDQflMeEHnZc1s1uHVp6/DFbMBzI7NxrTEgvx1nS/gWVCZ8xYsWiBP26Kx+/U
         EeeLhN/8PoiizLt423zlKvpnLSrkxyNGSSzmDaUxj3Y7D7EYgtrTcVAspmrLA7UQ9wyM
         OZzw==
X-Gm-Message-State: APjAAAVv29CL8kBrI355KqQLpj//ipv5LbDAfKMt798Gvju9zW5V93Wt
        z9bgBsL6G+RqYpSU+4PukTF4abrl0hI=
X-Google-Smtp-Source: APXvYqxVzkLJs27q94GYxwrMJrbaI6P6OuTrz+FRejnuEEy5tRoTDMEPjkaGOgiEpCZKq4YuKTgppQ==
X-Received: by 2002:a17:902:9889:: with SMTP id s9mr49514231plp.252.1582616082385;
        Mon, 24 Feb 2020 23:34:42 -0800 (PST)
Received: from vudentzs-t460s.amr.corp.intel.com ([2601:1c0:6800:1640::3287])
        by smtp.gmail.com with ESMTPSA id j125sm15642787pfg.160.2020.02.24.23.34.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:34:41 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 4/5] Bluetooth: L2CAP: Add module option to enable ECRED mode
Date:   Mon, 24 Feb 2020 23:34:36 -0800
Message-Id: <20200225073437.11212-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200225073437.11212-1-luiz.dentz@gmail.com>
References: <20200225073437.11212-1-luiz.dentz@gmail.com>
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
 net/bluetooth/l2cap_sock.c    |  8 ++++++++
 3 files changed, 24 insertions(+)

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
index 19123c268ce3..7ed0b79dd832 100644
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
@@ -658,7 +663,10 @@ static int l2cap_set_mode(struct l2cap_chan *chan, u8 mode)
 {
 	switch (chan->mode) {
 	case L2CAP_MODE_LE_FLOWCTL:
+		break;
 	case L2CAP_MODE_EXT_FLOWCTL:
+		if (!enable_ecred)
+			return -EINVAL;
 		break;
 	case L2CAP_MODE_BASIC:
 		clear_bit(CONF_STATE2_DEVICE, &chan->conf_state);
-- 
2.21.1

