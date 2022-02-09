Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBECC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 01:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiBJBc2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Feb 2022 20:32:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbiBJBc1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Feb 2022 20:32:27 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6190C205E8
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 17:32:25 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id i62so5569485ioa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 17:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=etxAVAB3cOkKl6MfaDuYIWwyszQbn7AfSsAsSXTiogk=;
        b=Wz0PgVwRdXbk1AqlmPPIhWiUT4xber1Y0ZUcafQ0fZTBGdif3HY/7bsqKdJGwdhFop
         QoKY2tinGYofQdP5wtQkrdmlAU6S9a0T5o5eGs1JDqE0oJdUuqKhmSUipTIh4tRV6Ok6
         bk08Ep6SIJ5wmXZQoSr7yGBkY+8T5EQthhULPdiu0yoV6K98++oTmj+N0WoKyRxDe7Di
         m/XY2Z+OF5wsjOHeKZtVshiAP+p1ad8t9oUd1mWx5MUdM/LgRLqVT4v6tNbnSfko3vfS
         s9u59EfsWFiKxB50CLcTp+VTFQgDnIDqg6zLqH7dZsv2z2Zys+N1k5DSfwxFek0N37Qe
         MH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=etxAVAB3cOkKl6MfaDuYIWwyszQbn7AfSsAsSXTiogk=;
        b=ufBrJ7CLi80odD6TdFLR83wQf2ljQnFJEI+KkcxVjpwHu1kh6ZuRQ4rLduz3efC3ND
         yn6pPVVRAn21fwPmqsYLnAIj9lzp6+0wbdmuUHR03NN9zN/ywu2wV1z9WOUO48zBOOlW
         FQv+dvGFjlpW8hGvCle2F4j19xlCwR570DaoIRM6TDumrg+T/Euh3QaBGeLzNm7Qj7qy
         4rQoS0yFIFG7XNiGuorkymo7x87nGXS0qq7F3xbuRG4NikaDHFJk+5QdI6eEdFcR11kO
         2qYaEWJ8oZknJd3Z3CSN13v+RcdXreybRys24fKhlrq+DUljWOTOZdx8e/gWLKiFbmd+
         xIMw==
X-Gm-Message-State: AOAM532CMZWkoW620BCVdX9cF5RR1TRK05jPmm1gWLKRCGchYptUServ
        q1TIfYke0jQIxE2SqYPzgt5dZJy3ENmjoA==
X-Google-Smtp-Source: ABdhPJzdjAiNO7HzOf3WWPBNcfJCceTaijfFJsWmL0R7AHuYUmKkSG+P5OTRGNPjIkpiB4rrYuu+Xw==
X-Received: by 2002:a63:6a06:: with SMTP id f6mr3886696pgc.576.1644450954702;
        Wed, 09 Feb 2022 15:55:54 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g7sm3240799pfi.7.2022.02.09.15.55.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 15:55:54 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] bthost: Fix not handling ACL fragmentation
Date:   Wed,  9 Feb 2022 15:55:50 -0800
Message-Id: <20220209235553.150294-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Large packets requires the support of ACL fragmentation in order to be
properly processed.
---
 emulator/bthost.c | 121 ++++++++++++++++++++++++++++++++++++++--------
 monitor/bt.h      |   2 +
 2 files changed, 102 insertions(+), 21 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 66e337f34..ec7a7eb0d 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -203,6 +203,9 @@ struct bthost {
 	uint8_t bdaddr[6];
 	uint8_t features[8];
 	bthost_send_func send_handler;
+	uint16_t acl_len;
+	uint16_t l2_len;
+	void *acl_data;
 	void *send_data;
 	struct cmd_queue cmd_q;
 	uint8_t ncmd;
@@ -491,6 +494,7 @@ void bthost_destroy(struct bthost *bthost)
 
 	queue_destroy(bthost->le_ext_adv, le_ext_adv_free);
 
+	free(bthost->acl_data);
 	free(bthost);
 }
 
@@ -2426,24 +2430,15 @@ static void process_rfcomm(struct bthost *bthost, struct btconn *conn,
 	}
 }
 
-static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
+static void process_l2cap(struct bthost *bthost, uint16_t handle,
+					const void *data, uint16_t len)
 {
-	const struct bt_hci_acl_hdr *acl_hdr = data;
-	const struct bt_l2cap_hdr *l2_hdr = data + sizeof(*acl_hdr);
-	uint16_t handle, cid, acl_len, l2_len;
+	const struct bt_l2cap_hdr *l2_hdr = data;
 	struct cid_hook *hook;
 	struct btconn *conn;
 	struct l2conn *l2conn;
-	const void *l2_data;
-
-	if (len < sizeof(*acl_hdr) + sizeof(*l2_hdr))
-		return;
-
-	acl_len = le16_to_cpu(acl_hdr->dlen);
-	if (len != sizeof(*acl_hdr) + acl_len)
-		return;
+	uint16_t cid, l2_len;
 
-	handle = acl_handle(acl_hdr->handle);
 	conn = bthost_find_conn(bthost, handle);
 	if (!conn) {
 		bthost_debug(bthost, "ACL data for unknown handle 0x%04x",
@@ -2452,36 +2447,40 @@ static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
 	}
 
 	l2_len = le16_to_cpu(l2_hdr->len);
-	if (len - sizeof(*acl_hdr) != sizeof(*l2_hdr) + l2_len)
+	if (len != sizeof(*l2_hdr) + l2_len) {
+		bthost_debug(bthost, "L2CAP invalid length: %u != %zu",
+					len, sizeof(*l2_hdr) + l2_len);
 		return;
+	}
 
-	l2_data = data + sizeof(*acl_hdr) + sizeof(*l2_hdr);
+	bthost_debug(bthost, "L2CAP data: %u bytes", l2_len);
 
 	cid = le16_to_cpu(l2_hdr->cid);
 
 	hook = find_cid_hook(conn, cid);
 	if (hook) {
-		hook->func(l2_data, l2_len, hook->user_data);
+		hook->func(l2_hdr->data, l2_len, hook->user_data);
 		return;
 	}
 
 	switch (cid) {
 	case 0x0001:
-		l2cap_sig(bthost, conn, l2_data, l2_len);
+		l2cap_sig(bthost, conn, l2_hdr->data, l2_len);
 		break;
 	case 0x0005:
-		l2cap_le_sig(bthost, conn, l2_data, l2_len);
+		l2cap_le_sig(bthost, conn, l2_hdr->data, l2_len);
 		break;
 	case 0x0006:
-		smp_data(conn->smp_data, l2_data, l2_len);
+		smp_data(conn->smp_data, l2_hdr->data, l2_len);
 		break;
 	case 0x0007:
-		smp_bredr_data(conn->smp_data, l2_data, l2_len);
+		smp_bredr_data(conn->smp_data, l2_hdr->data, l2_len);
 		break;
 	default:
 		l2conn = btconn_find_l2cap_conn_by_scid(conn, cid);
 		if (l2conn && l2conn->psm == 0x0003)
-			process_rfcomm(bthost, conn, l2conn, l2_data, l2_len);
+			process_rfcomm(bthost, conn, l2conn, l2_hdr->data,
+								l2_len);
 		else
 			bthost_debug(bthost,
 					"Packet for unknown CID 0x%04x (%u)",
@@ -2490,6 +2489,86 @@ static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
 	}
 }
 
+static void append_acl_data(struct bthost *bthost, uint16_t handle,
+				uint8_t flags, const void *data, uint16_t len)
+{
+	if (!bthost->acl_data) {
+		bthost_debug(bthost, "Unexpected ACL frame: handle 0x%4.4x "
+				"flags 0x%2.2x", handle, flags);
+		return;
+	}
+
+	if (bthost->acl_len + len > bthost->l2_len) {
+		bthost_debug(bthost, "Unexpected ACL frame: handle 0x%4.4x "
+				"flags 0x%2.2x", handle, flags);
+		return;
+	}
+
+	memcpy(bthost->acl_data + bthost->acl_len, data, len);
+	bthost->acl_len += len;
+
+	bthost_debug(bthost, "ACL data: %u/%u bytes", bthost->acl_len,
+							bthost->l2_len);
+
+	if (bthost->acl_len < bthost->l2_len)
+		return;
+
+	process_l2cap(bthost, handle, bthost->acl_data, bthost->acl_len);
+
+	free(bthost->acl_data);
+	bthost->acl_data = NULL;
+	bthost->acl_len = 0;
+	bthost->l2_len = 0;
+}
+
+static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
+{
+	const struct bt_hci_acl_hdr *acl_hdr = data;
+	const struct bt_l2cap_hdr *l2_hdr = (void *) acl_hdr->data;
+	uint16_t handle, acl_len, l2_len;
+	uint8_t flags;
+
+	acl_len = le16_to_cpu(acl_hdr->dlen);
+	if (len != sizeof(*acl_hdr) + acl_len)
+		return;
+
+	handle = acl_handle(acl_hdr->handle);
+	flags = acl_flags(acl_hdr->handle);
+
+	switch (flags) {
+	case 0x00:	/* start of a non-automatically-flushable PDU */
+	case 0x02:	/* start of an automatically-flushable PDU */
+		if (bthost->acl_data) {
+			bthost_debug(bthost, "Unexpected ACL start frame");
+			free(bthost->acl_data);
+			bthost->acl_data = NULL;
+			bthost->acl_len = 0;
+		}
+
+		l2_len = le16_to_cpu(l2_hdr->len) + sizeof(*l2_hdr);
+
+		bthost_debug(bthost, "acl_len %u l2_len %u", acl_len, l2_len);
+
+		if (acl_len == l2_len) {
+			process_l2cap(bthost, handle, acl_hdr->data, acl_len);
+			break;
+		}
+
+		bthost->acl_data = malloc(l2_len);
+		bthost->acl_len = 0;
+		bthost->l2_len = l2_len;
+		/* fall through */
+	case 0x01:	/* continuing fragment */
+		append_acl_data(bthost, handle, flags, acl_hdr->data, acl_len);
+		break;
+	case 0x03:	/* complete automatically-flushable PDU */
+		process_l2cap(bthost, handle, acl_hdr->data, acl_len);
+		break;
+	default:
+		bthost_debug(bthost, "Invalid ACL frame flags 0x%2.2x", flags);
+	}
+}
+
 void bthost_receive_h4(struct bthost *bthost, const void *data, uint16_t len)
 {
 	uint8_t pkt_type;
diff --git a/monitor/bt.h b/monitor/bt.h
index dc4e11c3c..66ed3ef5a 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -488,6 +488,7 @@ struct bt_hci_cmd_hdr {
 struct bt_hci_acl_hdr {
 	uint16_t handle;
 	uint16_t dlen;
+	uint8_t  data[];
 } __attribute__ ((packed));
 
 struct bt_hci_sco_hdr {
@@ -3663,6 +3664,7 @@ struct bt_hci_evt_le_req_peer_sca_complete {
 struct bt_l2cap_hdr {
 	uint16_t len;
 	uint16_t cid;
+	uint8_t  data[];
 } __attribute__ ((packed));
 
 struct bt_l2cap_hdr_sig {
-- 
2.34.1

