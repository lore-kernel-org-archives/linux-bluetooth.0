Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A84C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 20:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbiCUU5B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiCUU5A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Mar 2022 16:57:00 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A190196D72
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 13:55:34 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e22so18136651ioe.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Mar 2022 13:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GFc9sXDCUSGMKzcmjKZL85zsIJOnPsCDkSf/Z7ucJ1E=;
        b=gTRRSStniyQcgVXwW2SrDKgzIFlo1sWPm0onKHVqobgC5rzMpoO81t7K/pmrzoUJSW
         W4jh1fZysxFN6PZO94k5RVKHIsR/T9MId+JomHjA/Ot/17G9hFDbtF4kKIHXtGITO8YP
         s5MsFMdlPiZRg4oP+JmKnH/9uCPD2b30/YGBeBqS3qNIyfnpJbcggyOk5Hjlbkf51SS4
         p85RHTINQ/0fxctsniNXnRmI044KdV0xpx4MoGnqGDsbRRtHFe057IBCkavfsT0XHF8E
         MGgINcnlTOCEhKIEoVGfxQFqM37/5FOEBJ+XKuj6hs4yxnLBzOZkSyugAEm/qgA18rXY
         7cYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFc9sXDCUSGMKzcmjKZL85zsIJOnPsCDkSf/Z7ucJ1E=;
        b=DoSaYt0lSmsEX8UWE8aaW6E4yb9CGV+mmzzmtyaeGYD+HPKrYGGH04q6/aDCbiq7JR
         FwlefP6tqjE2e8CZaarT8fIvytetekGNgTiXVzIC9yQYS3iCCyUW0kvpGjB2MfhdqMgk
         siOtRHWQMLIcXJAdPynYPMtZtePYUOozqYOvgRm/UUQteAo5cKoJFSuHLnvCLgEsunkO
         htIu+Redsz82xQjV2QbRQIIyR2W7EOlt7DvM+nSdJMSDSLrSV3b2z/WIErYz+S0gkJyA
         zM0PyCTiodxLQ88ERTdu2TQRQQiSeasLx+HIrOaIGeBUlMqeEzohWiTwOoUuDB5U896K
         zFMw==
X-Gm-Message-State: AOAM530p27iYLDQqJbFZ2VYhHGG3tQgklu+PMPSCFTvAGfWOgESj01qU
        tQg0j3tEmFPfOYsHc9JqSaGN+3DcMvw=
X-Google-Smtp-Source: ABdhPJx59G0c0L0X33kLrT6KmAoQSHog1rdX6BfoVIls2o8REEnTNmUfHhH1iVNOkoqLGDTYJ+pKDg==
X-Received: by 2002:a05:6602:14cb:b0:646:4868:5fd with SMTP id b11-20020a05660214cb00b00646486805fdmr10665834iow.31.1647896133517;
        Mon, 21 Mar 2022 13:55:33 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q4-20020a056e0215c400b002c5fdff3087sm10962223ilu.29.2022.03.21.13.55.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:55:33 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] gatt-server: Add DBG macro
Date:   Mon, 21 Mar 2022 13:55:28 -0700
Message-Id: <20220321205529.2469387-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220321205529.2469387-1-luiz.dentz@gmail.com>
References: <20220321205529.2469387-1-luiz.dentz@gmail.com>
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

