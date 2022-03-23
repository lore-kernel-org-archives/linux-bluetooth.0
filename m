Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF40C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 20:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344565AbiCWUPY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344553AbiCWUPU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 16:15:20 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EDC7655
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:49 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u17so2289153pfk.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GFc9sXDCUSGMKzcmjKZL85zsIJOnPsCDkSf/Z7ucJ1E=;
        b=eYRmh8bMpjq60OForJLANcqAfIcK3DUJFYq/yZ67qH1owJfgZHMw24XUZCtKhduorC
         99RW0owf2KwWSfao3fp6F9+Gp0nySaRuktipHOW6y7x+54WGD4ivP2dOPcoZz7EeYSZe
         f9KKheWHpW/ZVQglx2IIsUDbwTfZEfv04mx3n4rHEGTBOvtHQV+32b9baWJQgnoyuN8A
         CCurs4O5SIp2WOwRxok9pF8mFaobM9/2ixR+l15sDjDfDcVpadAy7hzpKAK5EmaPaK+d
         WLAAalhrhaLsme6Gdc5b/yCO/A/PxlFPk+Snz62wo1UXwS6XnfWxI6sd3CPTsf+ursqV
         J/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFc9sXDCUSGMKzcmjKZL85zsIJOnPsCDkSf/Z7ucJ1E=;
        b=KTkF87xfjed7BEC2k4MZAzwFGZ35oMxuZTml7RkPFsY0ZURMaBpXJfT7Iv4Oxrbtp6
         I8uU1ZaYrzP7W3a5M48RfilbcmdzmY1Eya2fpuVCqiLdMxaYbLHAcD5j9up/uFqxiXsG
         qAeNAxM6lxuste7La278mM3o40EtzY44JX+C8SmbaLmcgzvlDL1XSJd6Mq7yuyuYpXwO
         0Xwvu6Q36ygR2jnf9nNZVXm1baQHkMhNy/eV3OxtBzjBCZOvesV6rzVN5k669A5ayu4l
         cyeGyONeqyAYiIeNuLgjapvKQAgcUFLBd3qZZn/6Qe+sx4AHkzsh36WUqIVwJH7Pn/3B
         p9aw==
X-Gm-Message-State: AOAM533nYWz5VEe0J+0opOJaAApF9YNIhecXLXCk1MuMcQ8s9qdIqdTs
        IIHjddklGuZcyQSi+WYc7SNmU7yXGaA=
X-Google-Smtp-Source: ABdhPJxGZKh496622iTltAIEXhGzOoxI+mDsDGr+eqVooYkUVe09sSeL4MgsP6LWw1MBc0+mIyVhFQ==
X-Received: by 2002:a63:4b1e:0:b0:365:8bc:6665 with SMTP id y30-20020a634b1e000000b0036508bc6665mr1208809pga.445.1648066428928;
        Wed, 23 Mar 2022 13:13:48 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m4-20020a17090a7f8400b001bef3fc3938sm478361pjl.49.2022.03.23.13.13.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:13:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 7/9] gatt-server: Add DBG macro
Date:   Wed, 23 Mar 2022 13:13:39 -0700
Message-Id: <20220323201341.3596128-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220323201341.3596128-1-luiz.dentz@gmail.com>
References: <20220323201341.3596128-1-luiz.dentz@gmail.com>
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

