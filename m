Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450ACC432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 00:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A2060FBF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 00:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbhHMA6I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Aug 2021 20:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbhHMA6I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Aug 2021 20:58:08 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CDFC061756
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Aug 2021 17:57:42 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id t7-20020a17090a5d87b029017807007f23so18148428pji.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Aug 2021 17:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vD+ncmb1Z/CYbhY1wcej3AJhKiVnGoKEbvUCRmVhwow=;
        b=ifl3ZPUlthWATN4UfOQw8CaMEwClywcB+/0t2P6oHcRni/Du959Sm1Hxnr02Cn8gE2
         129g+hB3Eunfy9ofu9o78KBdGuXSRcMpGCxwvEZuyPuDy2P6GQZJR1dZiUtuDcBBEl5U
         DY4LnKdljbfGKgXiE551q3dDujPYqgk0Hb173C6WpEM3N5DSkynorSWtTJuOavJBLTse
         tdczG+92WFP9a3QIaTUHHUj7T+VXu3W4YL8yyWcIj0VpHyLmA0NohUvWNY9SXj3SiOHr
         BZdToU9xmxwqDUo8KEDXEv1JIXwylb7FauteFIqAOcyjL+3ILJ5TCV/kbahFxu5neMV/
         L/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vD+ncmb1Z/CYbhY1wcej3AJhKiVnGoKEbvUCRmVhwow=;
        b=Gnd7vUWHifqmZ1c6vP2Cu4ODqi4Uj33ML2h3WaE9Kj6bVMJAWGSAgfDctzUrZZv0aB
         MIXxSYgTSotwDeAkbQ8Fc4kF2uQWxRtTVT+AdLJO76v7B6rGCr0rKBhaxMS/fLM77R/9
         t5wChkcRsTKvXEH7vFQlPWKxY2UotoAYYuATNAWjmiqvfil14L6pMre+LMj6x5dqW22X
         Pel6cHp7wONlglCx+bD892bJzBF/ix9xAq2J7sXlDU3XPluIDsz1RgzPkvHgr41htBFV
         zGXLuCjmwn5nZzNHeXLXrWSksoHhcgqhGV343XeV0gxMQNM0WWWua6dpfqS7vvUgaLA9
         Vifw==
X-Gm-Message-State: AOAM530dyaEsfJGCfoq9mZAkn1xI+BRBLWA6tYLwgY++/XcozsDeVFXI
        DgKORkvYfVenB2YUVaOQcISfcVqg+XU=
X-Google-Smtp-Source: ABdhPJx9E2/E4mYRy4gwFTafMSkn8xJ7uggsBKrUMWcsSPrynCe30+uggwavv35536y55wGILROKpw==
X-Received: by 2002:a17:902:7584:b0:12d:8cb5:c7b8 with SMTP id j4-20020a170902758400b0012d8cb5c7b8mr1704427pll.84.1628816261512;
        Thu, 12 Aug 2021 17:57:41 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b15sm43980pgj.60.2021.08.12.17.57.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 17:57:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] bthost: Add bthost_debug and use it on smp.c
Date:   Thu, 12 Aug 2021 17:57:39 -0700
Message-Id: <20210813005739.1043743-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bthost_debug which wraps util_debug and make use of it in
smp.c.
---
 emulator/bthost.c | 50 +++++++++++++++++++++++++----------------------
 emulator/bthost.h |  2 ++
 emulator/hciemu.c |  4 ++--
 emulator/smp.c    | 20 ++++++++++++++-----
 4 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 62f5a1bae..547685208 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -691,8 +691,7 @@ static void send_command(struct bthost *bthost, uint16_t opcode,
 	uint8_t pkt = BT_H4_CMD_PKT;
 	struct iovec iov[3];
 
-	util_debug(bthost->debug_callback, bthost->debug_data,
-				"command 0x%02x", opcode);
+	bthost_debug(bthost, "command 0x%02x", opcode);
 
 	iov[0].iov_base = &pkt;
 	iov[0].iov_len = sizeof(pkt);
@@ -794,6 +793,18 @@ bool bthost_set_debug(struct bthost *bthost, bthost_debug_func_t callback,
 	return true;
 }
 
+void bthost_debug(struct bthost *host, const char *format, ...)
+{
+	va_list ap;
+
+	if (!host || !format || !host->debug_callback)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(host->debug_callback, host->debug_data, format, ap);
+	va_end(ap);
+}
+
 static void read_local_features_complete(struct bthost *bthost,
 						const void *data, uint8_t len)
 {
@@ -870,8 +881,8 @@ static void evt_cmd_complete(struct bthost *bthost, const void *data,
 	case BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE:
 		break;
 	default:
-		util_debug(bthost->debug_callback, bthost->debug_data,
-				"Unhandled cmd_complete opcode 0x%04x", opcode);
+		bthost_debug(bthost, "Unhandled cmd_complete opcode 0x%04x",
+								opcode);
 		break;
 	}
 
@@ -1298,8 +1309,7 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 	if (len < 1)
 		return;
 
-	util_debug(bthost->debug_callback, bthost->debug_data,
-				"event 0x%02x", *event);
+	bthost_debug(bthost, "event 0x%02x", *event);
 
 	switch (*event) {
 	case BT_HCI_EVT_LE_CONN_COMPLETE:
@@ -1321,8 +1331,8 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 		evt_le_cis_req(bthost, evt_data, len - 1);
 		break;
 	default:
-		util_debug(bthost->debug_callback, bthost->debug_data,
-				"Unsupported LE Meta event 0x%2.2x", *event);
+		bthost_debug(bthost, "Unsupported LE Meta event 0x%2.2x",
+								*event);
 		break;
 	}
 }
@@ -1340,8 +1350,7 @@ static void process_evt(struct bthost *bthost, const void *data, uint16_t len)
 
 	param = data + sizeof(*hdr);
 
-	util_debug(bthost->debug_callback, bthost->debug_data,
-				"event 0x%02x", hdr->evt);
+	bthost_debug(bthost, "event 0x%02x", hdr->evt);
 
 	switch (hdr->evt) {
 	case BT_HCI_EVT_CMD_COMPLETE:
@@ -1409,8 +1418,7 @@ static void process_evt(struct bthost *bthost, const void *data, uint16_t len)
 		break;
 
 	default:
-		util_debug(bthost->debug_callback, bthost->debug_data,
-				"Unsupported event 0x%2.2x", hdr->evt);
+		bthost_debug(bthost, "Unsupported event 0x%2.2x", hdr->evt);
 		break;
 	}
 }
@@ -1754,8 +1762,7 @@ static void l2cap_sig(struct bthost *bthost, struct btconn *conn,
 		break;
 
 	default:
-		util_debug(bthost->debug_callback, bthost->debug_data,
-				"Unknown L2CAP code 0x%02x", hdr->code);
+		bthost_debug(bthost, "Unknown L2CAP code 0x%02x", hdr->code);
 		ret = false;
 	}
 
@@ -1987,8 +1994,7 @@ static void l2cap_le_sig(struct bthost *bthost, struct btconn *conn,
 		break;
 
 	default:
-		util_debug(bthost->debug_callback, bthost->debug_data,
-				"Unknown L2CAP code 0x%02x", hdr->code);
+		bthost_debug(bthost, "Unknown L2CAP code 0x%02x", hdr->code);
 		ret = false;
 	}
 
@@ -2329,8 +2335,7 @@ static void process_rfcomm(struct bthost *bthost, struct btconn *conn,
 		rfcomm_uih_recv(bthost, conn, l2conn, data, len);
 		break;
 	default:
-		util_debug(bthost->debug_callback, bthost->debug_data,
-					"Unknown frame type");
+		bthost_debug(bthost, "Unknown frame type");
 		break;
 	}
 }
@@ -2355,8 +2360,8 @@ static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
 	handle = acl_handle(acl_hdr->handle);
 	conn = bthost_find_conn(bthost, handle);
 	if (!conn) {
-		util_debug(bthost->debug_callback, bthost->debug_data,
-				"ACL data for unknown handle 0x%04x", handle);
+		bthost_debug(bthost, "ACL data for unknown handle 0x%04x",
+								handle);
 		return;
 	}
 
@@ -2392,7 +2397,7 @@ static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
 		if (l2conn && l2conn->psm == 0x0003)
 			process_rfcomm(bthost, conn, l2conn, l2_data, l2_len);
 		else
-			util_debug(bthost->debug_callback, bthost->debug_data,
+			bthost_debug(bthost,
 					"Packet for unknown CID 0x%04x (%u)",
 					cid, cid);
 		break;
@@ -2422,8 +2427,7 @@ void bthost_receive_h4(struct bthost *bthost, const void *data, uint16_t len)
 		process_acl(bthost, data + 1, len - 1);
 		break;
 	default:
-		util_debug(bthost->debug_callback, bthost->debug_data,
-				"Unsupported packet 0x%2.2x", pkt_type);
+		bthost_debug(bthost, "Unsupported packet 0x%2.2x", pkt_type);
 		break;
 	}
 }
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 5a85b7232..3dec44514 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -27,6 +27,8 @@ typedef void (*bthost_debug_func_t)(const char *str, void *user_data);
 typedef void (*bthost_destroy_func_t)(void *user_data);
 bool bthost_set_debug(struct bthost *bthost, bthost_debug_func_t callback,
 			void *user_data, bthost_destroy_func_t destroy);
+void bthost_debug(struct bthost *bthost, const char *format, ...)
+					__attribute__((format(printf, 2, 3)));
 
 void bthost_set_send_handler(struct bthost *bthost, bthost_send_func handler,
 							void *user_data);
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index a3ec44243..fe5ef747a 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -454,7 +454,7 @@ void hciemu_unref(struct hciemu *hciemu)
 	free(hciemu);
 }
 
-static void bthost_debug(const char *str, void *user_data)
+static void bthost_print(const char *str, void *user_data)
 {
 	struct hciemu *hciemu = user_data;
 
@@ -484,7 +484,7 @@ static void hciemu_client_set_debug(void *data, void *user_data)
 	struct hciemu *hciemu = user_data;
 
 	btdev_set_debug(client->dev, btdev_client_debug, hciemu, NULL);
-	bthost_set_debug(client->host, bthost_debug, hciemu, NULL);
+	bthost_set_debug(client->host, bthost_print, hciemu, NULL);
 }
 
 bool hciemu_set_debug(struct hciemu *hciemu, hciemu_debug_func_t callback,
diff --git a/emulator/smp.c b/emulator/smp.c
index ec1baea04..21a34dde6 100644
--- a/emulator/smp.c
+++ b/emulator/smp.c
@@ -358,7 +358,8 @@ static bool verify_random(struct smp_conn *conn, const uint8_t rnd[16])
 		return false;
 
 	if (memcmp(conn->pcnf, confirm, sizeof(conn->pcnf)) != 0) {
-		printf("Confirmation values don't match\n");
+		bthost_debug(conn->smp->bthost,
+					"Confirmation values don't match");
 		return false;
 	}
 
@@ -698,12 +699,13 @@ void smp_data(void *conn_data, const void *data, uint16_t len)
 	uint8_t opcode;
 
 	if (len < 1) {
-		printf("Received too small SMP PDU\n");
+		bthost_debug(conn->smp->bthost, "Received too small SMP PDU");
 		return;
 	}
 
 	if (conn->addr_type == BDADDR_BREDR) {
-		printf("Received BR/EDR SMP data on LE link\n");
+		bthost_debug(conn->smp->bthost,
+					"Received BR/EDR SMP data on LE link");
 		return;
 	}
 
@@ -754,12 +756,13 @@ void smp_bredr_data(void *conn_data, const void *data, uint16_t len)
 	uint8_t opcode;
 
 	if (len < 1) {
-		printf("Received too small SMP PDU\n");
+		bthost_debug(conn->smp->bthost, "Received too small SMP PDU");
 		return;
 	}
 
 	if (conn->addr_type != BDADDR_BREDR) {
-		printf("Received LE SMP data on BR/EDR link\n");
+		bthost_debug(conn->smp->bthost,
+					"Received LE SMP data on BR/EDR link");
 		return;
 	}
 
@@ -853,6 +856,7 @@ void *smp_conn_add(void *smp_data, uint16_t handle,
 {
 	struct smp *smp = smp_data;
 	struct smp_conn *conn;
+	char ia_str[18], ra_str[18];
 
 	conn = malloc(sizeof(struct smp_conn));
 	if (!conn)
@@ -870,6 +874,12 @@ void *smp_conn_add(void *smp_data, uint16_t handle,
 	memcpy(conn->ia, ia, 6);
 	memcpy(conn->ra, ra, 6);
 
+	ba2str((bdaddr_t *) ia, ia_str);
+	ba2str((bdaddr_t *) ra, ra_str);
+
+	bthost_debug(smp->bthost, "ia %s type 0x%02x ra %s type 0x%02x",
+					ia_str, ia_type, ra_str, ra_type);
+
 	bt_crypto_random_bytes(smp->crypto, conn->prnd, sizeof(conn->prnd));
 
 	return conn;
-- 
2.31.1

