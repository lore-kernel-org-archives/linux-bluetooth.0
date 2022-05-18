Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE39C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 May 2022 22:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiERWRt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 May 2022 18:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiERWRq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 May 2022 18:17:46 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE0C20AE67
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 15:17:44 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id x12so3365109pgj.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 May 2022 15:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ChJFvNq/Wsh2RG3EOPiLBgjC/bQ3ZyP8oD3/t6vqWuA=;
        b=TbY5gZ+i2wnGLRPCcS/SDqzMHT7wh8cEbUMpd+n0ZZInC6ogyHtMzfoWHWBkHIUm58
         Ha1EEvXCWFQNZ+M+Hu7tLjoJEJsjfWsPUDljBWmp9arlxhKVkIZpdNNwZYfC019au8mi
         lKXmaxAxGs5QmRLUW03h3B3I2+rwJCZJ4LuSbpGqjJDxkDdcaxrJifypL1DDJZIIHUk8
         xh6ywzHpYvohWPKAojIAtfKmvjxh2m6HzggCBoEBfrGE6vqXxbHh/CFlph2QhqpmHI0v
         IprwqKnsMMkOT3Y23LqysTEbJ1B/Y41NpyDABVUFTl49Vf27W9zovrsQL1DlDkku9YY6
         HlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ChJFvNq/Wsh2RG3EOPiLBgjC/bQ3ZyP8oD3/t6vqWuA=;
        b=OEM0rGH1VeoykVUDMMPi42FS64HhOSXv9MYtRPiMEdPikxLaTVN76SuQzXxteU0u+d
         AoPlkUfuzmAIniRlhcimZgS1hOqzjsjxhqH/Jd3tHt3/MBq3ntos4OhV9w4YwUjlfW8C
         1h+TcpRmtatZk4r81z07oQ3V6leGdJ6Lw/Xl8QXF15ogLNaoHo2ArL5sUhloR9y2d3V/
         zpxT29sym0zTTCmPOJ5L93hXmf4V7DaH24sEGGtsztpsUlKHiY03Zza0+SNQZ5WkqUqH
         N1QfE1MNGVQ09cLA4qBE2TqU1rZWniQ7SUpkTRcdK9QWX9XtfeCMAVEtQPyx7TH9A0P4
         Sz4w==
X-Gm-Message-State: AOAM532t+6g0HIo4Gs2QCVG75TK5h9ssy1fz6CDGDKspY/dw0ncUmPpP
        KStHM0ghRegKL2kmu8WdDNR0NVW8OOE=
X-Google-Smtp-Source: ABdhPJy2EPPzs/otxbwLjFGnvAnO9nNIiEk1jsK7MIR6QboVEdyN2BrSP0+wi7H4DWYI7TgAWpQ0wQ==
X-Received: by 2002:a62:be14:0:b0:505:a43b:cf6e with SMTP id l20-20020a62be14000000b00505a43bcf6emr1483253pff.33.1652912263296;
        Wed, 18 May 2022 15:17:43 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id iz15-20020a170902ef8f00b001619b38701bsm2201363plb.72.2022.05.18.15.17.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 15:17:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] monitor/att: Decode attribute type
Date:   Wed, 18 May 2022 15:17:01 -0700
Message-Id: <20220518221701.2220062-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518221701.2220062-1-luiz.dentz@gmail.com>
References: <20220518221701.2220062-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This attempt to decode the attribute type if its gatt_db can be loaded:

< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Write Request (0x12) len 4
        Handle: 0x000b Type: Client Characteristic Configuration (0x2902)
          Data: 0200
---
 Makefile.tools   |   5 +-
 monitor/att.c    | 145 +++++++++++++++++++++++++++++++++++++++++++----
 monitor/packet.c |   2 +-
 3 files changed, 138 insertions(+), 14 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index a152dad6f..4b513366f 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -49,7 +49,10 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 				monitor/msft.h monitor/msft.c \
 				monitor/jlink.h monitor/jlink.c \
 				monitor/tty.h monitor/emulator.h \
-				monitor/att.h monitor/att.c
+				monitor/att.h monitor/att.c \
+				src/log.h src/log.c \
+				src/textfile.h src/textfile.c \
+				src/settings.h src/settings.c
 monitor_btmon_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-mainloop.la \
 				$(GLIB_LIBS) $(UDEV_LIBS) -ldl
diff --git a/monitor/att.c b/monitor/att.c
index 5ad8244db..304c37319 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -18,11 +18,21 @@
 #include <stdlib.h>
 #include <string.h>
 #include <inttypes.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <linux/limits.h>
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
+#include "lib/hci.h"
+#include "lib/hci_lib.h"
 
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
+#include "src/textfile.h"
+#include "src/settings.h"
 #include "bt.h"
 #include "packet.h"
 #include "display.h"
@@ -316,11 +326,123 @@ static void att_read_type_rsp(const struct l2cap_frame *frame)
 					frame->data + 1, frame->size - 1);
 }
 
+struct att_conn_data {
+	struct gatt_db *ldb;
+	struct gatt_db *rdb;
+};
+
+static void att_conn_data_free(void *data)
+{
+	struct att_conn_data *att_data = data;
+
+	gatt_db_unref(att_data->rdb);
+	gatt_db_unref(att_data->ldb);
+	free(att_data);
+}
+
+static void load_gatt_db(struct packet_conn_data *conn)
+{
+	struct att_conn_data *data;
+	char filename[PATH_MAX];
+	bdaddr_t src;
+	char local[18];
+	char peer[18];
+
+	if (hci_devba(conn->index, &src) < 0)
+		return;
+
+	data = new0(struct att_conn_data, 1);
+	data->rdb = gatt_db_new();
+	data->ldb = gatt_db_new();
+	conn->data = data;
+	conn->destroy = att_conn_data_free;
+
+	ba2str(&src, local);
+
+	create_filename(filename, PATH_MAX, "/%s/attributes", local);
+
+	btd_settings_gatt_db_load(data->ldb, filename);
+
+	ba2str((bdaddr_t *)conn->dst, peer);
+
+	create_filename(filename, PATH_MAX, "/%s/cache/%s", local, peer);
+
+	btd_settings_gatt_db_load(data->rdb, filename);
+}
+
+static struct gatt_db_attribute *get_attribute(const struct l2cap_frame *frame,
+						uint16_t handle, bool rsp)
+{
+	struct packet_conn_data *conn;
+	struct att_conn_data *data;
+	struct gatt_db *db;
+
+	conn = packet_get_conn_data(frame->handle);
+	if (!conn)
+		return NULL;
+
+	data = conn->data;
+	/* Try loading local and remote gatt_db if not loaded yet */
+	if (!data) {
+		load_gatt_db(conn);
+		data = conn->data;
+		if (!data)
+			return NULL;
+	}
+
+	if (frame->in) {
+		if (rsp)
+			db = data->rdb;
+		else
+			db = data->ldb;
+	} else {
+		if (rsp)
+			db = data->ldb;
+		else
+			db = data->rdb;
+	}
+
+	return gatt_db_get_attribute(db, handle);
+}
+
+static void print_handle(const struct l2cap_frame *frame, uint16_t handle,
+								bool rsp)
+{
+	struct gatt_db_attribute *attr;
+	const bt_uuid_t *uuid;
+	char label[21];
+
+	attr = get_attribute(frame, handle, rsp);
+	if (!attr)
+		goto done;
+
+	uuid = gatt_db_attribute_get_type(attr);
+	if (!uuid)
+		goto done;
+
+	switch (uuid->type) {
+	case BT_UUID16:
+		sprintf(label, "Handle: 0x%4.4x Type", handle);
+		print_uuid(label, &cpu_to_le16(uuid->value.u16), 2);
+		return;
+	case BT_UUID128:
+		sprintf(label, "Handle: 0x%4.4x Type", handle);
+		print_uuid(label, &uuid->value.u128, 16);
+		return;
+	case BT_UUID_UNSPEC:
+	case BT_UUID32:
+		break;
+	}
+
+done:
+	print_field("Handle: 0x%4.4x", handle);
+}
+
 static void att_read_req(const struct l2cap_frame *frame)
 {
 	const struct bt_l2cap_att_read_req *pdu = frame->data;
 
-	print_field("Handle: 0x%4.4x", le16_to_cpu(pdu->handle));
+	print_handle(frame, le16_to_cpu(pdu->handle), false);
 }
 
 static void att_read_rsp(const struct l2cap_frame *frame)
@@ -330,7 +452,7 @@ static void att_read_rsp(const struct l2cap_frame *frame)
 
 static void att_read_blob_req(const struct l2cap_frame *frame)
 {
-	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_handle(frame, get_le16(frame->data), false);
 	print_field("Offset: 0x%4.4x", get_le16(frame->data + 2));
 }
 
@@ -346,8 +468,7 @@ static void att_read_multiple_req(const struct l2cap_frame *frame)
 	count = frame->size / 2;
 
 	for (i = 0; i < count; i++)
-		print_field("Handle: 0x%4.4x",
-					get_le16(frame->data + (i * 2)));
+		print_handle(frame, get_le16(frame->data + (i * 2)), false);
 }
 
 static void att_read_group_type_req(const struct l2cap_frame *frame)
@@ -390,7 +511,7 @@ static void att_read_group_type_rsp(const struct l2cap_frame *frame)
 
 static void att_write_req(const struct l2cap_frame *frame)
 {
-	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_handle(frame, get_le16(frame->data), false);
 	print_hex_field("  Data", frame->data + 2, frame->size - 2);
 }
 
@@ -400,14 +521,14 @@ static void att_write_rsp(const struct l2cap_frame *frame)
 
 static void att_prepare_write_req(const struct l2cap_frame *frame)
 {
-	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_handle(frame, get_le16(frame->data), false);
 	print_field("Offset: 0x%4.4x", get_le16(frame->data + 2));
 	print_hex_field("  Data", frame->data + 4, frame->size - 4);
 }
 
 static void att_prepare_write_rsp(const struct l2cap_frame *frame)
 {
-	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_handle(frame, get_le16(frame->data), true);
 	print_field("Offset: 0x%4.4x", get_le16(frame->data + 2));
 	print_hex_field("  Data", frame->data + 4, frame->size - 4);
 }
@@ -436,7 +557,7 @@ static void att_handle_value_notify(const struct l2cap_frame *frame)
 {
 	const struct bt_l2cap_att_handle_value_notify *pdu = frame->data;
 
-	print_field("Handle: 0x%4.4x", le16_to_cpu(pdu->handle));
+	print_handle(frame, le16_to_cpu(pdu->handle), true);
 	print_hex_field("  Data", frame->data + 2, frame->size - 2);
 }
 
@@ -444,7 +565,7 @@ static void att_handle_value_ind(const struct l2cap_frame *frame)
 {
 	const struct bt_l2cap_att_handle_value_ind *pdu = frame->data;
 
-	print_field("Handle: 0x%4.4x", le16_to_cpu(pdu->handle));
+	print_handle(frame, le16_to_cpu(pdu->handle), true);
 	print_hex_field("  Data", frame->data + 2, frame->size - 2);
 }
 
@@ -463,7 +584,7 @@ static void att_multiple_vl_rsp(const struct l2cap_frame *frame)
 		if (!l2cap_frame_get_le16(f, &handle))
 			return;
 
-		print_field("Handle: 0x%4.4x", handle);
+		print_handle(frame, get_le16(frame->data), true);
 
 		if (!l2cap_frame_get_le16(f, &len))
 			return;
@@ -484,13 +605,13 @@ static void att_multiple_vl_rsp(const struct l2cap_frame *frame)
 
 static void att_write_command(const struct l2cap_frame *frame)
 {
-	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_handle(frame, get_le16(frame->data), false);
 	print_hex_field("  Data", frame->data + 2, frame->size - 2);
 }
 
 static void att_signed_write_command(const struct l2cap_frame *frame)
 {
-	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_handle(frame, get_le16(frame->data), false);
 	print_hex_field("  Data", frame->data + 2, frame->size - 2 - 12);
 	print_hex_field("  Signature", frame->data + frame->size - 12, 12);
 }
diff --git a/monitor/packet.c b/monitor/packet.c
index 8608cf2ef..e854c1a8e 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -765,7 +765,7 @@ static void print_handle_native(uint16_t handle)
 	}
 
 	sprintf(label, "Handle: %d Address", handle);
-	print_addr("  Address", conn->dst, conn->dst_type);
+	print_addr(label, conn->dst, conn->dst_type);
 }
 
 static void print_handle(uint16_t handle)
-- 
2.35.1

