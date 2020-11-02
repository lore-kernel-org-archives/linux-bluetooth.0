Return-Path: <SRS0=F55x=EI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC5AC00A89
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A75152225E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Nov 2020 19:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds50etqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgKBTMh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgKBTMg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Nov 2020 14:12:36 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55F2C0617A6
        for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2020 11:12:36 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id w11so7301351pll.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2020 11:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=AJ40uhAUVOG4HQ6xubmwRqCHUzL28Zk1s0d9ENX1l90=;
        b=Ds50etqNZ3UPYsIZgm+8agmXVwCuGlFK5GoUWXdyJ4kIJdXfEIK4AHwADtYAd3GW9I
         jjqplUxZEynDFyaEh7HulhMHqzYY9s7gyGszRy/lvpgsQpmB7uRbGlAfUySziiRknn/Y
         WdxuaLbLBGnFnbdjLztp2dLEGC/doR/ozdlyopCi1i8dbt0+YpybyhFnxGSkECm0vXuh
         38HIb6HIv1oXauPvD6sc/djwdpQjpoOEn7MFFDDgq41cRihGHmPPqiE2y+yyBfJYX+sy
         Xz+/JI8wGnazGtppZJESdPWBLwuWdrnKBK5tHVMdLhDrEXISZkquh1XMqlH1yUXy7VyC
         meIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJ40uhAUVOG4HQ6xubmwRqCHUzL28Zk1s0d9ENX1l90=;
        b=jZdV87GgXNEwg5En8cCjbnW/LGZa4pM8ZmUn3rR6SSgBQLWayC0iCzuOLlMh8NTgK9
         BYONJxUOx+LX5/RE/PNhRv6ylgSvn0/+QT+jqqPwWP0AcI/zU9G99DjOQt3hknOtrOyZ
         aFKE9VU4Aa8hmH9KVCc4R97zF7jcAIKi7VrbXBeD8N3rpu+GIE5N2nQm8ay2+T5gyZsn
         xo4O5qc5qLNc31qDkLPespmzdYtABotawRE0RWKlNvD1vLa0tlQbIIb/8zrnFnPUS/Pe
         OOZV2QZq2bmZTdc/k/uwsNqMwpDTic+fvxKATOSYIF/3eMJt4Xq5iVSy0O82/Y18l3m8
         t3BA==
X-Gm-Message-State: AOAM5333eVmvh1abP/YAU8kCx6ci3ryDW6IMucQpmsSSeZ0J+YfeWCr1
        6jpJHjrN5vmE4WnrMgsDFMgq2e06L1HWnQ==
X-Google-Smtp-Source: ABdhPJxL5bj4v6pqD0CglvjBmgiMPG2+wfnufMvsxMaSQEaAzBum8+qIKGNKg6gQqcj+dvkEycUeeg==
X-Received: by 2002:a17:902:8608:b029:d4:c459:f1e8 with SMTP id f8-20020a1709028608b02900d4c459f1e8mr21804171plo.36.1604344356078;
        Mon, 02 Nov 2020 11:12:36 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z10sm14589716pff.218.2020.11.02.11.12.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 11:12:35 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 02/11] emulator/bthost: Add debug support
Date:   Mon,  2 Nov 2020 11:12:23 -0800
Message-Id: <20201102191232.1848737-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201102191232.1848737-1-luiz.dentz@gmail.com>
References: <20201102191232.1848737-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bthost_set_debug which can be used to debug internals of
bthost.
---
 emulator/bthost.c | 73 ++++++++++++++++++++++++++++++++++++++++-------
 emulator/bthost.h |  5 ++++
 2 files changed, 68 insertions(+), 10 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 1c05c7496..f5b09bc4f 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -24,6 +24,7 @@
 #include "lib/bluetooth.h"
 
 #include "src/shared/util.h"
+#include "src/shared/tester.h"
 #include "monitor/bt.h"
 #include "monitor/rfcomm.h"
 #include "bthost.h"
@@ -213,6 +214,10 @@ struct bthost {
 	bool conn_init;
 	bool le;
 	bool sc;
+
+	bthost_debug_func_t debug_callback;
+	bthost_destroy_func_t debug_destroy;
+	void *debug_data;
 };
 
 struct bthost *bthost_create(void)
@@ -487,9 +492,20 @@ static void queue_command(struct bthost *bthost, const struct iovec *iov,
 static void send_packet(struct bthost *bthost, const struct iovec *iov,
 								int iovlen)
 {
+	int i;
+
 	if (!bthost->send_handler)
 		return;
 
+	for (i = 0; i < iovlen; i++) {
+		if (!i)
+			util_hexdump('<', iov[i].iov_base, iov[i].iov_len,
+				bthost->debug_callback, bthost->debug_data);
+		else
+			util_hexdump(' ', iov[i].iov_base, iov[i].iov_len,
+				bthost->debug_callback, bthost->debug_data);
+	}
+
 	bthost->send_handler(iov, iovlen, bthost->send_data);
 }
 
@@ -675,6 +691,9 @@ static void send_command(struct bthost *bthost, uint16_t opcode,
 	uint8_t pkt = BT_H4_CMD_PKT;
 	struct iovec iov[3];
 
+	util_debug(bthost->debug_callback, bthost->debug_data,
+				"command 0x%02x", opcode);
+
 	iov[0].iov_base = &pkt;
 	iov[0].iov_len = sizeof(pkt);
 
@@ -759,6 +778,22 @@ void bthost_notify_ready(struct bthost *bthost, bthost_ready_cb cb)
 	bthost->ready_cb = cb;
 }
 
+bool bthost_set_debug(struct bthost *bthost, bthost_debug_func_t callback,
+			void *user_data, bthost_destroy_func_t destroy)
+{
+	if (!bthost)
+		return false;
+
+	if (bthost->debug_destroy)
+		bthost->debug_destroy(bthost->debug_data);
+
+	bthost->debug_callback = callback;
+	bthost->debug_destroy = destroy;
+	bthost->debug_data = user_data;
+
+	return true;
+}
+
 static void read_local_features_complete(struct bthost *bthost,
 						const void *data, uint8_t len)
 {
@@ -835,7 +870,8 @@ static void evt_cmd_complete(struct bthost *bthost, const void *data,
 	case BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE:
 		break;
 	default:
-		printf("Unhandled cmd_complete opcode 0x%04x\n", opcode);
+		util_debug(bthost->debug_callback, bthost->debug_data,
+				"Unhandled cmd_complete opcode 0x%04x", opcode);
 		break;
 	}
 
@@ -1242,6 +1278,9 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 	if (len < 1)
 		return;
 
+	util_debug(bthost->debug_callback, bthost->debug_data,
+				"event 0x%02x", *event);
+
 	switch (*event) {
 	case BT_HCI_EVT_LE_CONN_COMPLETE:
 		evt_le_conn_complete(bthost, evt_data, len - 1);
@@ -1259,7 +1298,8 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 		evt_le_ext_conn_complete(bthost, evt_data, len - 1);
 		break;
 	default:
-		printf("Unsupported LE Meta event 0x%2.2x\n", *event);
+		util_debug(bthost->debug_callback, bthost->debug_data,
+				"Unsupported LE Meta event 0x%2.2x", *event);
 		break;
 	}
 }
@@ -1277,6 +1317,9 @@ static void process_evt(struct bthost *bthost, const void *data, uint16_t len)
 
 	param = data + sizeof(*hdr);
 
+	util_debug(bthost->debug_callback, bthost->debug_data,
+				"event 0x%02x", hdr->evt);
+
 	switch (hdr->evt) {
 	case BT_HCI_EVT_CMD_COMPLETE:
 		evt_cmd_complete(bthost, param, hdr->plen);
@@ -1343,7 +1386,8 @@ static void process_evt(struct bthost *bthost, const void *data, uint16_t len)
 		break;
 
 	default:
-		printf("Unsupported event 0x%2.2x\n", hdr->evt);
+		util_debug(bthost->debug_callback, bthost->debug_data,
+				"Unsupported event 0x%2.2x", hdr->evt);
 		break;
 	}
 }
@@ -1674,7 +1718,8 @@ static void l2cap_sig(struct bthost *bthost, struct btconn *conn,
 		break;
 
 	default:
-		printf("Unknown L2CAP code 0x%02x\n", hdr->code);
+		util_debug(bthost->debug_callback, bthost->debug_data,
+				"Unknown L2CAP code 0x%02x", hdr->code);
 		ret = false;
 	}
 
@@ -1892,7 +1937,8 @@ static void l2cap_le_sig(struct bthost *bthost, struct btconn *conn,
 		break;
 
 	default:
-		printf("Unknown L2CAP code 0x%02x\n", hdr->code);
+		util_debug(bthost->debug_callback, bthost->debug_data,
+				"Unknown L2CAP code 0x%02x", hdr->code);
 		ret = false;
 	}
 
@@ -2232,7 +2278,8 @@ static void process_rfcomm(struct bthost *bthost, struct btconn *conn,
 		rfcomm_uih_recv(bthost, conn, l2conn, data, len);
 		break;
 	default:
-		printf("Unknown frame type\n");
+		util_debug(bthost->debug_callback, bthost->debug_data,
+					"Unknown frame type");
 		break;
 	}
 }
@@ -2257,7 +2304,8 @@ static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
 	handle = acl_handle(acl_hdr->handle);
 	conn = bthost_find_conn(bthost, handle);
 	if (!conn) {
-		printf("ACL data for unknown handle 0x%04x\n", handle);
+		util_debug(bthost->debug_callback, bthost->debug_data,
+				"ACL data for unknown handle 0x%04x", handle);
 		return;
 	}
 
@@ -2293,8 +2341,9 @@ static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
 		if (l2conn && l2conn->psm == 0x0003)
 			process_rfcomm(bthost, conn, l2conn, l2_data, l2_len);
 		else
-			printf("Packet for unknown CID 0x%04x (%u)\n", cid,
-									cid);
+			util_debug(bthost->debug_callback, bthost->debug_data,
+					"Packet for unknown CID 0x%04x (%u)",
+					cid, cid);
 		break;
 	}
 }
@@ -2309,6 +2358,9 @@ void bthost_receive_h4(struct bthost *bthost, const void *data, uint16_t len)
 	if (len < 1)
 		return;
 
+	util_hexdump('>', data, len, bthost->debug_callback,
+					bthost->debug_data);
+
 	pkt_type = ((const uint8_t *) data)[0];
 
 	switch (pkt_type) {
@@ -2319,7 +2371,8 @@ void bthost_receive_h4(struct bthost *bthost, const void *data, uint16_t len)
 		process_acl(bthost, data + 1, len - 1);
 		break;
 	default:
-		printf("Unsupported packet 0x%2.2x\n", pkt_type);
+		util_debug(bthost->debug_callback, bthost->debug_data,
+				"Unsupported packet 0x%2.2x", pkt_type);
 		break;
 	}
 }
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 3841f98a1..77f17fd69 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -23,6 +23,11 @@ void bthost_destroy(struct bthost *bthost);
 typedef void (*bthost_ready_cb) (void);
 void bthost_notify_ready(struct bthost *bthost, bthost_ready_cb cb);
 
+typedef void (*bthost_debug_func_t)(const char *str, void *user_data);
+typedef void (*bthost_destroy_func_t)(void *user_data);
+bool bthost_set_debug(struct bthost *bthost, bthost_debug_func_t callback,
+			void *user_data, bthost_destroy_func_t destroy);
+
 void bthost_set_send_handler(struct bthost *bthost, bthost_send_func handler,
 							void *user_data);
 
-- 
2.26.2

