Return-Path: <SRS0=NHH5=EE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1390C4741F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C59020838
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Oct 2020 21:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB+DiPmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725747AbgJ2Vwq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Oct 2020 17:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgJ2Vwq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Oct 2020 17:52:46 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7B1C0613D2
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:52:46 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o9so1938757plx.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2020 14:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=U9/bfdZMvZJG5rdKJZ8CX0AZcrB7aqh2pZH6mdppYtk=;
        b=kB+DiPmFvmqZ29MpBQLL4JXWL/3I+93z5Y/4HdvNlhgGLnjBzpW+jjunlpDHDi8wbd
         W+XEUr/ZJq1gbYQ9/otpEhbY/l29OpP8+vVewTRseEmY9fL59hMX9qbNAoI61C1CUTft
         0W69zY7VsvtLSn2qTTB9r/bsaA4kAWHy3VsBhpQ0WvOpBD5E287KQojOM4sdhOMS6GH8
         42/N5B3F2Cw36Zf7H7QTutjQQCPUthccT3NlSt6muzAiWmd7DDA6WOQFt/qcbb6HQA2P
         37R63+abb8ZdUp0L/OPmgUmIVkVYpszOQ/8/jh/kQ1rpxN0DOoOnQhjX9573oQftXAfg
         uobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U9/bfdZMvZJG5rdKJZ8CX0AZcrB7aqh2pZH6mdppYtk=;
        b=BcV8umWTi67CYp9KA4fJDO+znpIt90SCFq+GBLgvW1GwybkN+BokoSr9oUCptv/7wj
         /xAAzkDZLNTZvu3CYfy9DT4Ede4W+bUyRHRh6RaDWWzxUp+pYToPI2rrMifxwQ4Xe7jL
         JgePzm/SSnAs6BrkaR2MqwspcOMSpxE0fZBpXgTJosdOPhJIEHWizNvWX8hsgljh1f7q
         yBuxwF11b0bC6Yb6jykRsUJTNRKI+ZVNu3y+PS8isbYlnh+Sv8w/Q8oayWy2M6ATLF7d
         nR+PvJycHoz5Nz7sQ/pPXe00EVo5yPaJe8lrAbzJeTwN4iI5aO4ckduPLm3N14h5UWtb
         dhJg==
X-Gm-Message-State: AOAM532bE2kX4iAOjM7uKFw9PncwQD9MMHp/ZnYYn1dQgClPKdgYpUKI
        8Y/ifiW9wZAxG17C9EULpVY85HBehQTPKg==
X-Google-Smtp-Source: ABdhPJwEJOsvM5Pz38E97VUBCjJF8+qU+NkmanexXEYzccUrw6Uq8ffEVo5kuQA0wHPvnYgSf0K2NQ==
X-Received: by 2002:a17:902:10a:b029:d2:6379:ab8a with SMTP id 10-20020a170902010ab02900d26379ab8amr5984330plb.66.1604008365686;
        Thu, 29 Oct 2020 14:52:45 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id lw12sm780572pjb.5.2020.10.29.14.52.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 14:52:45 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] emulator/bthost: Add debug support
Date:   Thu, 29 Oct 2020 14:52:42 -0700
Message-Id: <20201029215243.888555-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201029215243.888555-1-luiz.dentz@gmail.com>
References: <20201029215243.888555-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bthost_set_debug which can be used to debug internals of
bthost.
---
 emulator/bthost.c | 70 ++++++++++++++++++++++++++++++++++++++++-------
 emulator/bthost.h |  5 ++++
 2 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 1c05c7496..c1054b970 100644
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
 
@@ -1259,7 +1295,8 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 		evt_le_ext_conn_complete(bthost, evt_data, len - 1);
 		break;
 	default:
-		printf("Unsupported LE Meta event 0x%2.2x\n", *event);
+		util_debug(bthost->debug_callback, bthost->debug_data,
+				"Unsupported LE Meta event 0x%2.2x", *event);
 		break;
 	}
 }
@@ -1277,6 +1314,9 @@ static void process_evt(struct bthost *bthost, const void *data, uint16_t len)
 
 	param = data + sizeof(*hdr);
 
+	util_debug(bthost->debug_callback, bthost->debug_data,
+				"event 0x%04x", hdr->evt);
+
 	switch (hdr->evt) {
 	case BT_HCI_EVT_CMD_COMPLETE:
 		evt_cmd_complete(bthost, param, hdr->plen);
@@ -1343,7 +1383,8 @@ static void process_evt(struct bthost *bthost, const void *data, uint16_t len)
 		break;
 
 	default:
-		printf("Unsupported event 0x%2.2x\n", hdr->evt);
+		util_debug(bthost->debug_callback, bthost->debug_data,
+				"Unsupported event 0x%2.2x", hdr->evt);
 		break;
 	}
 }
@@ -1674,7 +1715,8 @@ static void l2cap_sig(struct bthost *bthost, struct btconn *conn,
 		break;
 
 	default:
-		printf("Unknown L2CAP code 0x%02x\n", hdr->code);
+		util_debug(bthost->debug_callback, bthost->debug_data,
+				"Unknown L2CAP code 0x%02x", hdr->code);
 		ret = false;
 	}
 
@@ -1892,7 +1934,8 @@ static void l2cap_le_sig(struct bthost *bthost, struct btconn *conn,
 		break;
 
 	default:
-		printf("Unknown L2CAP code 0x%02x\n", hdr->code);
+		util_debug(bthost->debug_callback, bthost->debug_data,
+				"Unknown L2CAP code 0x%02x", hdr->code);
 		ret = false;
 	}
 
@@ -2232,7 +2275,8 @@ static void process_rfcomm(struct bthost *bthost, struct btconn *conn,
 		rfcomm_uih_recv(bthost, conn, l2conn, data, len);
 		break;
 	default:
-		printf("Unknown frame type\n");
+		util_debug(bthost->debug_callback, bthost->debug_data,
+					"Unknown frame type");
 		break;
 	}
 }
@@ -2257,7 +2301,8 @@ static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
 	handle = acl_handle(acl_hdr->handle);
 	conn = bthost_find_conn(bthost, handle);
 	if (!conn) {
-		printf("ACL data for unknown handle 0x%04x\n", handle);
+		util_debug(bthost->debug_callback, bthost->debug_data,
+				"ACL data for unknown handle 0x%04x", handle);
 		return;
 	}
 
@@ -2293,8 +2338,9 @@ static void process_acl(struct bthost *bthost, const void *data, uint16_t len)
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
@@ -2309,6 +2355,9 @@ void bthost_receive_h4(struct bthost *bthost, const void *data, uint16_t len)
 	if (len < 1)
 		return;
 
+	util_hexdump('>', data, len, bthost->debug_callback,
+					bthost->debug_data);
+
 	pkt_type = ((const uint8_t *) data)[0];
 
 	switch (pkt_type) {
@@ -2319,7 +2368,8 @@ void bthost_receive_h4(struct bthost *bthost, const void *data, uint16_t len)
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

