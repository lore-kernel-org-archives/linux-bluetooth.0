Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0673C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 22:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345292AbiCWWlp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345299AbiCWWll (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 18:41:41 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C8A3819E
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mm17-20020a17090b359100b001c6da62a559so7761716pjb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GFc9sXDCUSGMKzcmjKZL85zsIJOnPsCDkSf/Z7ucJ1E=;
        b=EWanTqBbrzfO5rczKfYNwHtoyH6e8nPeQ6FG9r2qUb7I9rwdTCXbw3/U08CTdPJfPY
         7dcQ1Mpn+/RR7NZ38ECHZRJ/6rhJls5zMaAHguhQhozZX6SqnHEUD/AyoJpAaxXU//OV
         UfZBr08d93OaZ12LhoaXDzPT1VErZkTzEIDLvClwo4lsOKX/YhbBfyvrnEg4uXUM9mUc
         XIbw8U4iVDQOZ5kTv8Www3vKyLBj9ZMAhCXCent833wNX747UZW5dCGY8ED9CISxP0MG
         XMv0dMlDgxF6jRz8nelsw/W67HhHx+fzByN7xPkqjETFl+7DqAjUMUWfIkVlSavyeWHu
         sLjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFc9sXDCUSGMKzcmjKZL85zsIJOnPsCDkSf/Z7ucJ1E=;
        b=Bs9QCDkNaRc0dhIMF8YMSDcSz1lug492aS0mwjcs9ctVfQzgGt6u0hu4GLzCsWrafV
         GPm5VN4SIr91CHSyUzgRDmp6HDIOG+r5uL+HXbOgJuws1cxjGunfHRBPj4DZIWFHuKWQ
         bvs37rM18JWD3ndAza34S3+N5IG+/teeMD1l6ijeju3iy9RQ4WhCNcK5IKh7wLDlQyh5
         Jim8rWiQaA4iEv7eqchboE7B30FtWoIVneWzLPdxCXGumuBpWZ2/RbzaZ4ruoyJOqC/y
         qjl8vTDqX4cFHB06lIrc+i2VBYD0YPRU6DHOtPYiD2R9gtIbYclj4gWelvr+SsT/v9wW
         JKMQ==
X-Gm-Message-State: AOAM530nFBMMAqE6p5eydsHB8FpNCEmQv0W4BJcZzB/+hCGw8QK/AKFW
        JNoXC4N5qk0qb8awzNS7HaSbXmBWFFc=
X-Google-Smtp-Source: ABdhPJytbiTSm1JFh+pUbJ1EVvW6dIq1Uukikv8U2nk6ZW3ePGgSGsuCy5zSA06Y7hOP3Maz1i+TKA==
X-Received: by 2002:a17:902:a415:b0:153:a1b6:729f with SMTP id p21-20020a170902a41500b00153a1b6729fmr2395508plq.52.1648075210136;
        Wed, 23 Mar 2022 15:40:10 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7888e000000b004f79f59827asm825109pfe.139.2022.03.23.15.40.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:40:09 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 7/9] gatt-server: Add DBG macro
Date:   Wed, 23 Mar 2022 15:40:01 -0700
Message-Id: <20220323224003.3736525-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323224003.3736525-1-luiz.dentz@gmail.com>
References: <20220323224003.3736525-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds gatt_log wrapper for util_debug and DBG so file and function
names are printed with the logs.
---
 src/shared/gatt-server.c | 64 ++++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 776e5ce2b..2adb4afbf 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -41,6 +41,9 @@
 
 #define NFY_MULT_TIMEOUT 10
 
+#define DBG(_server, _format, arg...) \
+	gatt_log(_server, "%s:%s() " _format, __FILE__, __func__, ## arg)
+
 struct async_read_op {
 	struct bt_att_chan *chan;
 	struct bt_gatt_server *server;
@@ -233,6 +236,18 @@ static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
 	return true;
 }
 
+static void gatt_log(struct bt_gatt_server *server, const char *format, ...)
+{
+	va_list ap;
+
+	if (!server || !format || !server->debug_callback)
+		return;
+
+	va_start(ap, format);
+	util_debug_va(server->debug_callback, server->debug_data, format, ap);
+	va_end(ap);
+}
+
 static void read_by_grp_type_cb(struct bt_att_chan *chan, uint8_t opcode,
 					const void *pdu, uint16_t length,
 					void *user_data)
@@ -259,9 +274,7 @@ static void read_by_grp_type_cb(struct bt_att_chan *chan, uint8_t opcode,
 	end = get_le16(pdu + 2);
 	get_uuid_le(pdu + 4, length - 4, &type);
 
-	util_debug(server->debug_callback, server->debug_data,
-				"Read By Grp Type - start: 0x%04x end: 0x%04x",
-				start, end);
+	DBG(server, "Read By Grp Type - start: 0x%04x end: 0x%04x", start, end);
 
 	if (!start || !end) {
 		ecode = BT_ATT_ERROR_INVALID_HANDLE;
@@ -483,9 +496,7 @@ static void read_by_type_cb(struct bt_att_chan *chan, uint8_t opcode,
 	end = get_le16(pdu + 2);
 	get_uuid_le(pdu + 4, length - 4, &type);
 
-	util_debug(server->debug_callback, server->debug_data,
-				"Read By Type - start: 0x%04x end: 0x%04x",
-				start, end);
+	DBG(server, "Read By Type - start: 0x%04x end: 0x%04x", start, end);
 
 	if (!start || !end) {
 		ecode = BT_ATT_ERROR_INVALID_HANDLE;
@@ -605,9 +616,7 @@ static void find_info_cb(struct bt_att_chan *chan, uint8_t opcode,
 	start = get_le16(pdu);
 	end = get_le16(pdu + 2);
 
-	util_debug(server->debug_callback, server->debug_data,
-					"Find Info - start: 0x%04x end: 0x%04x",
-					start, end);
+	DBG(server, "Find Info - start: 0x%04x end: 0x%04x", start, end);
 
 	if (!start || !end) {
 		ecode = BT_ATT_ERROR_INVALID_HANDLE;
@@ -708,9 +717,10 @@ static void find_by_type_val_cb(struct bt_att_chan *chan, uint8_t opcode,
 	end = get_le16(pdu + 2);
 	uuid16 = get_le16(pdu + 4);
 
-	util_debug(server->debug_callback, server->debug_data,
-			"Find By Type Value - start: 0x%04x end: 0x%04x uuid: 0x%04x",
-			start, end, uuid16);
+	DBG(server,
+	    "Find By Type Value - start: 0x%04x end: 0x%04x uuid: 0x%04x",
+	    start, end, uuid16);
+
 	ehandle = start;
 	if (start > end) {
 		data.ecode = BT_ATT_ERROR_INVALID_HANDLE;
@@ -756,8 +766,7 @@ static void write_complete_cb(struct gatt_db_attribute *attr, int err,
 		return;
 	}
 
-	util_debug(server->debug_callback, server->debug_data,
-						"Write Complete: err %d", err);
+	DBG(server, "Write Complete: err %d", err);
 
 	handle = gatt_db_attribute_get_handle(attr);
 
@@ -818,10 +827,8 @@ static void write_cb(struct bt_att_chan *chan, uint8_t opcode, const void *pdu,
 		goto error;
 	}
 
-	util_debug(server->debug_callback, server->debug_data,
-				"Write %s - handle: 0x%04x",
-				(opcode == BT_ATT_OP_WRITE_REQ) ? "Req" : "Cmd",
-				handle);
+	DBG(server, "Write %s - handle: 0x%04x",
+		(opcode == BT_ATT_OP_WRITE_REQ) ? "Req" : "Cmd", handle);
 
 	ecode = check_length(length, 0);
 	if (ecode)
@@ -885,8 +892,7 @@ static void read_complete_cb(struct gatt_db_attribute *attr, int err,
 	uint16_t mtu;
 	uint16_t handle;
 
-	util_debug(server->debug_callback, server->debug_data,
-				"Read Complete: err %d", err);
+	DBG(server, "Read Complete: err %d", err);
 
 	mtu = bt_att_get_mtu(server->att);
 	handle = gatt_db_attribute_get_handle(attr);
@@ -922,10 +928,8 @@ static void handle_read_req(struct bt_att_chan *chan,
 		goto error;
 	}
 
-	util_debug(server->debug_callback, server->debug_data,
-			"Read %sReq - handle: 0x%04x",
-			opcode == BT_ATT_OP_READ_BLOB_REQ ? "Blob " : "",
-			handle);
+	DBG(server, "Read %sReq - handle: 0x%04x",
+		opcode == BT_ATT_OP_READ_BLOB_REQ ? "Blob " : "", handle);
 
 	ecode = check_permissions(server, attr, BT_ATT_PERM_READ_MASK);
 	if (ecode)
@@ -1125,8 +1129,7 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
 
 	handle = data->handles[0];
 
-	util_debug(server->debug_callback, server->debug_data,
-			"%s Req - %zu handles, 1st: 0x%04x",
+	DBG(server, "%s Req - %zu handles, 1st: 0x%04x",
 			data->opcode == BT_ATT_OP_READ_MULT_REQ ?
 			"Read Multiple" : "Read Multiple Variable Length",
 			data->num_handles, handle);
@@ -1312,8 +1315,7 @@ static void prep_write_cb(struct bt_att_chan *chan, uint8_t opcode,
 		goto error;
 	}
 
-	util_debug(server->debug_callback, server->debug_data,
-				"Prep Write Req - handle: 0x%04x", handle);
+	DBG(server, "Prep Write Req - handle: 0x%04x", handle);
 
 	ecode = check_length(length, offset);
 	if (ecode)
@@ -1433,8 +1435,7 @@ static void exec_write_cb(struct bt_att_chan *chan, uint8_t opcode,
 
 	flags = ((uint8_t *) pdu)[0];
 
-	util_debug(server->debug_callback, server->debug_data,
-				"Exec Write Req - flags: 0x%02x", flags);
+	DBG(server, "Exec Write Req - flags: 0x%02x", flags);
 
 	if (flags == 0x00)
 		write = false;
@@ -1505,8 +1506,7 @@ static void exchange_mtu_cb(struct bt_att_chan *chan, uint8_t opcode,
 	server->mtu = final_mtu;
 	bt_att_set_mtu(server->att, final_mtu);
 
-	util_debug(server->debug_callback, server->debug_data,
-			"MTU exchange complete, with MTU: %u", final_mtu);
+	DBG(server, "MTU exchange complete, with MTU: %u", final_mtu);
 }
 
 static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
-- 
2.35.1

