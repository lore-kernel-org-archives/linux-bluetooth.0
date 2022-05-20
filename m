Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC0AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 May 2022 04:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbiETERa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 00:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiETERU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 00:17:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68FD703E8
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 21:17:17 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id pq9-20020a17090b3d8900b001df622bf81dso6897262pjb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 21:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=+tTlP/tjwm51gk5ioQz3E377YsDesZVEuKkVCbz2gtI=;
        b=l47vgddIRIC7RQsj4tUNZG6rrHZYgH3QKV6wil3v7flTW2pP45qIoFaJnDfS3dbdQc
         GhZzZ65HX/kXQ6QgAGGPl7MIUkG1NGrjn77GclK2obrTasu9Mmhg5ZMTyBbnefjz4N6n
         c+86z9mKJoq3+SQOg+B9N2NNF+j4G5Xr3wwOXFhTgVfVgsqqCmdi3ZqRTdZRBzVEhUlC
         GYL7Md+erI2SckcXsBMRUDZWF8H1rqDi0j/2vkwGW+hDsfmQ8kZPK8PSZoFPlmSbJXSm
         YiQtfQZ5EZnm/lBV1WZmmh4Y/855c3qsLWGuX0+PlbOBCdTlVdO1NPhX6KeKf/eXgODa
         TDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+tTlP/tjwm51gk5ioQz3E377YsDesZVEuKkVCbz2gtI=;
        b=EcGmKCZ6Zie3CNrb4/vrVmSn81nUuQrFVyfGjOL4TfWC5QV+nrlULEnnckbP3LvQB6
         shwT0+Q/DyWiGbbzcS+3F5eETTkFhQ6QnIFyTBe5C6X1GI1UGqTdI3Ub2aSdew9Og+wU
         zNTuzy2ATloSTvp60crf8nv/JabYTCgKod/VBqbMNiLkRGjaLVk8RzDIdlaykmjr5m0r
         Z1MTR9ycPzc5+gNIVJtWPwtB6xI7NjhZ5/n/TP84kJXBj1EJqvCqnL2OmlwMpMVigr7m
         v421DK+pGKtC14CbzGy45bHlXnMB0lioIxdlPJxPNrYlGm7jWA8bErnh7L7d9GRS4dVe
         u/lA==
X-Gm-Message-State: AOAM5338GHIUf5YnBdMvkJFBHiScBrbkM6mRLquCXeWDwwaEerKDAW7j
        yuRohxZIgtUn02/JaCYaFDKtezSnp5s=
X-Google-Smtp-Source: ABdhPJxOl+N9xayJ9kmurLmA90K81nc70g+9Db1e4jj4Z1HKK2LkupG1AgNcRIwVNnViH8dr5c3h0Q==
X-Received: by 2002:a17:902:e0d3:b0:161:f0c7:b810 with SMTP id e19-20020a170902e0d300b00161f0c7b810mr1946561pla.138.1653020225524;
        Thu, 19 May 2022 21:17:05 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a450d00b001df955c28f6sm381405pjg.37.2022.05.19.21.17.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 21:17:04 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/7] monitor: Move ATT decoding function into its own file
Date:   Thu, 19 May 2022 21:16:58 -0700
Message-Id: <20220520041701.2572197-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520041701.2572197-1-luiz.dentz@gmail.com>
References: <20220520041701.2572197-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves ATT decoding function from l2cap.c to att.c.
---
 Makefile.tools  |   6 +-
 monitor/att.c   | 642 ++++++++++++++++++++++++++++++++++++++++++++++++
 monitor/att.h   |  16 ++
 monitor/l2cap.c | 616 +---------------------------------------------
 monitor/l2cap.h |   5 +
 5 files changed, 669 insertions(+), 616 deletions(-)
 create mode 100644 monitor/att.c
 create mode 100644 monitor/att.h

diff --git a/Makefile.tools b/Makefile.tools
index b7d893248..a152dad6f 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -48,9 +48,11 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 				monitor/broadcom.h monitor/broadcom.c \
 				monitor/msft.h monitor/msft.c \
 				monitor/jlink.h monitor/jlink.c \
-				monitor/tty.h monitor/emulator.h
+				monitor/tty.h monitor/emulator.h \
+				monitor/att.h monitor/att.c
 monitor_btmon_LDADD = lib/libbluetooth-internal.la \
-				src/libshared-mainloop.la $(UDEV_LIBS) -ldl
+				src/libshared-mainloop.la \
+				$(GLIB_LIBS) $(UDEV_LIBS) -ldl
 
 if MANPAGES
 man_MANS += monitor/btmon.1
diff --git a/monitor/att.c b/monitor/att.c
new file mode 100644
index 000000000..5ad8244db
--- /dev/null
+++ b/monitor/att.c
@@ -0,0 +1,642 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2014  Intel Corporation
+ *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <inttypes.h>
+
+#include "lib/bluetooth.h"
+#include "lib/uuid.h"
+
+#include "src/shared/util.h"
+#include "bt.h"
+#include "packet.h"
+#include "display.h"
+#include "l2cap.h"
+#include "att.h"
+
+static void print_uuid(const char *label, const void *data, uint16_t size)
+{
+	const char *str;
+	char uuidstr[MAX_LEN_UUID_STR];
+
+	switch (size) {
+	case 2:
+		str = bt_uuid16_to_str(get_le16(data));
+		print_field("%s: %s (0x%4.4x)", label, str, get_le16(data));
+		break;
+	case 4:
+		str = bt_uuid32_to_str(get_le32(data));
+		print_field("%s: %s (0x%8.8x)", label, str, get_le32(data));
+		break;
+	case 16:
+		sprintf(uuidstr, "%8.8x-%4.4x-%4.4x-%4.4x-%8.8x%4.4x",
+				get_le32(data + 12), get_le16(data + 10),
+				get_le16(data + 8), get_le16(data + 6),
+				get_le32(data + 2), get_le16(data + 0));
+		str = bt_uuidstr_to_str(uuidstr);
+		print_field("%s: %s (%s)", label, str, uuidstr);
+		break;
+	default:
+		packet_hexdump(data, size);
+		break;
+	}
+}
+
+static void print_handle_range(const char *label, const void *data)
+{
+	print_field("%s: 0x%4.4x-0x%4.4x", label,
+				get_le16(data), get_le16(data + 2));
+}
+
+static void print_data_list(const char *label, uint8_t length,
+					const void *data, uint16_t size)
+{
+	uint8_t count;
+
+	if (length == 0)
+		return;
+
+	count = size / length;
+
+	print_field("%s: %u entr%s", label, count, count == 1 ? "y" : "ies");
+
+	while (size >= length) {
+		print_field("Handle: 0x%4.4x", get_le16(data));
+		print_hex_field("Value", data + 2, length - 2);
+
+		data += length;
+		size -= length;
+	}
+
+	packet_hexdump(data, size);
+}
+
+static void print_attribute_info(uint16_t type, const void *data, uint16_t len)
+{
+	const char *str = bt_uuid16_to_str(type);
+
+	print_field("%s: %s (0x%4.4x)", "Attribute type", str, type);
+
+	switch (type) {
+	case 0x2800:	/* Primary Service */
+	case 0x2801:	/* Secondary Service */
+		print_uuid("  UUID", data, len);
+		break;
+	case 0x2802:	/* Include */
+		if (len < 4) {
+			print_hex_field("  Value", data, len);
+			break;
+		}
+		print_handle_range("  Handle range", data);
+		print_uuid("  UUID", data + 4, len - 4);
+		break;
+	case 0x2803:	/* Characteristic */
+		if (len < 3) {
+			print_hex_field("  Value", data, len);
+			break;
+		}
+		print_field("  Properties: 0x%2.2x", *((uint8_t *) data));
+		print_field("  Handle: 0x%2.2x", get_le16(data + 1));
+		print_uuid("  UUID", data + 3, len - 3);
+		break;
+	default:
+		print_hex_field("Value", data, len);
+		break;
+	}
+}
+
+static const char *att_opcode_to_str(uint8_t opcode);
+
+static void att_error_response(const struct l2cap_frame *frame)
+{
+	const struct bt_l2cap_att_error_response *pdu = frame->data;
+	const char *str;
+
+	switch (pdu->error) {
+	case 0x01:
+		str = "Invalid Handle";
+		break;
+	case 0x02:
+		str = "Read Not Permitted";
+		break;
+	case 0x03:
+		str = "Write Not Permitted";
+		break;
+	case 0x04:
+		str = "Invalid PDU";
+		break;
+	case 0x05:
+		str = "Insufficient Authentication";
+		break;
+	case 0x06:
+		str = "Request Not Supported";
+		break;
+	case 0x07:
+		str = "Invalid Offset";
+		break;
+	case 0x08:
+		str = "Insufficient Authorization";
+		break;
+	case 0x09:
+		str = "Prepare Queue Full";
+		break;
+	case 0x0a:
+		str = "Attribute Not Found";
+		break;
+	case 0x0b:
+		str = "Attribute Not Long";
+		break;
+	case 0x0c:
+		str = "Insufficient Encryption Key Size";
+		break;
+	case 0x0d:
+		str = "Invalid Attribute Value Length";
+		break;
+	case 0x0e:
+		str = "Unlikely Error";
+		break;
+	case 0x0f:
+		str = "Insufficient Encryption";
+		break;
+	case 0x10:
+		str = "Unsupported Group Type";
+		break;
+	case 0x11:
+		str = "Insufficient Resources";
+		break;
+	case 0x12:
+		str = "Database Out of Sync";
+		break;
+	case 0x13:
+		str = "Value Not Allowed";
+		break;
+	case 0xfd:
+		str = "CCC Improperly Configured";
+		break;
+	case 0xfe:
+		str = "Procedure Already in Progress";
+		break;
+	case 0xff:
+		str = "Out of Range";
+		break;
+	default:
+		str = "Reserved";
+		break;
+	}
+
+	print_field("%s (0x%2.2x)", att_opcode_to_str(pdu->request),
+							pdu->request);
+	print_field("Handle: 0x%4.4x", le16_to_cpu(pdu->handle));
+	print_field("Error: %s (0x%2.2x)", str, pdu->error);
+}
+
+static void att_exchange_mtu_req(const struct l2cap_frame *frame)
+{
+	const struct bt_l2cap_att_exchange_mtu_req *pdu = frame->data;
+
+	print_field("Client RX MTU: %d", le16_to_cpu(pdu->mtu));
+}
+
+static void att_exchange_mtu_rsp(const struct l2cap_frame *frame)
+{
+	const struct bt_l2cap_att_exchange_mtu_rsp *pdu = frame->data;
+
+	print_field("Server RX MTU: %d", le16_to_cpu(pdu->mtu));
+}
+
+static void att_find_info_req(const struct l2cap_frame *frame)
+{
+	print_handle_range("Handle range", frame->data);
+}
+
+static const char *att_format_str(uint8_t format)
+{
+	switch (format) {
+	case 0x01:
+		return "UUID-16";
+	case 0x02:
+		return "UUID-128";
+	default:
+		return "unknown";
+	}
+}
+
+static uint16_t print_info_data_16(const void *data, uint16_t len)
+{
+	while (len >= 4) {
+		print_field("Handle: 0x%4.4x", get_le16(data));
+		print_uuid("UUID", data + 2, 2);
+		data += 4;
+		len -= 4;
+	}
+
+	return len;
+}
+
+static uint16_t print_info_data_128(const void *data, uint16_t len)
+{
+	while (len >= 18) {
+		print_field("Handle: 0x%4.4x", get_le16(data));
+		print_uuid("UUID", data + 2, 16);
+		data += 18;
+		len -= 18;
+	}
+
+	return len;
+}
+
+static void att_find_info_rsp(const struct l2cap_frame *frame)
+{
+	const uint8_t *format = frame->data;
+	uint16_t len;
+
+	print_field("Format: %s (0x%2.2x)", att_format_str(*format), *format);
+
+	if (*format == 0x01)
+		len = print_info_data_16(frame->data + 1, frame->size - 1);
+	else if (*format == 0x02)
+		len = print_info_data_128(frame->data + 1, frame->size - 1);
+	else
+		len = frame->size - 1;
+
+	packet_hexdump(frame->data + (frame->size - len), len);
+}
+
+static void att_find_by_type_val_req(const struct l2cap_frame *frame)
+{
+	uint16_t type;
+
+	print_handle_range("Handle range", frame->data);
+
+	type = get_le16(frame->data + 4);
+	print_attribute_info(type, frame->data + 6, frame->size - 6);
+}
+
+static void att_find_by_type_val_rsp(const struct l2cap_frame *frame)
+{
+	const uint8_t *ptr = frame->data;
+	uint16_t len = frame->size;
+
+	while (len >= 4) {
+		print_handle_range("Handle range", ptr);
+		ptr += 4;
+		len -= 4;
+	}
+
+	packet_hexdump(ptr, len);
+}
+
+static void att_read_type_req(const struct l2cap_frame *frame)
+{
+	print_handle_range("Handle range", frame->data);
+	print_uuid("Attribute type", frame->data + 4, frame->size - 4);
+}
+
+static void att_read_type_rsp(const struct l2cap_frame *frame)
+{
+	const struct bt_l2cap_att_read_group_type_rsp *pdu = frame->data;
+
+	print_field("Attribute data length: %d", pdu->length);
+	print_data_list("Attribute data list", pdu->length,
+					frame->data + 1, frame->size - 1);
+}
+
+static void att_read_req(const struct l2cap_frame *frame)
+{
+	const struct bt_l2cap_att_read_req *pdu = frame->data;
+
+	print_field("Handle: 0x%4.4x", le16_to_cpu(pdu->handle));
+}
+
+static void att_read_rsp(const struct l2cap_frame *frame)
+{
+	print_hex_field("Value", frame->data, frame->size);
+}
+
+static void att_read_blob_req(const struct l2cap_frame *frame)
+{
+	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_field("Offset: 0x%4.4x", get_le16(frame->data + 2));
+}
+
+static void att_read_blob_rsp(const struct l2cap_frame *frame)
+{
+	packet_hexdump(frame->data, frame->size);
+}
+
+static void att_read_multiple_req(const struct l2cap_frame *frame)
+{
+	int i, count;
+
+	count = frame->size / 2;
+
+	for (i = 0; i < count; i++)
+		print_field("Handle: 0x%4.4x",
+					get_le16(frame->data + (i * 2)));
+}
+
+static void att_read_group_type_req(const struct l2cap_frame *frame)
+{
+	print_handle_range("Handle range", frame->data);
+	print_uuid("Attribute group type", frame->data + 4, frame->size - 4);
+}
+
+static void print_group_list(const char *label, uint8_t length,
+					const void *data, uint16_t size)
+{
+	uint8_t count;
+
+	if (length == 0)
+		return;
+
+	count = size / length;
+
+	print_field("%s: %u entr%s", label, count, count == 1 ? "y" : "ies");
+
+	while (size >= length) {
+		print_handle_range("Handle range", data);
+		print_uuid("UUID", data + 4, length - 4);
+
+		data += length;
+		size -= length;
+	}
+
+	packet_hexdump(data, size);
+}
+
+static void att_read_group_type_rsp(const struct l2cap_frame *frame)
+{
+	const struct bt_l2cap_att_read_group_type_rsp *pdu = frame->data;
+
+	print_field("Attribute data length: %d", pdu->length);
+	print_group_list("Attribute group list", pdu->length,
+					frame->data + 1, frame->size - 1);
+}
+
+static void att_write_req(const struct l2cap_frame *frame)
+{
+	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_hex_field("  Data", frame->data + 2, frame->size - 2);
+}
+
+static void att_write_rsp(const struct l2cap_frame *frame)
+{
+}
+
+static void att_prepare_write_req(const struct l2cap_frame *frame)
+{
+	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_field("Offset: 0x%4.4x", get_le16(frame->data + 2));
+	print_hex_field("  Data", frame->data + 4, frame->size - 4);
+}
+
+static void att_prepare_write_rsp(const struct l2cap_frame *frame)
+{
+	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_field("Offset: 0x%4.4x", get_le16(frame->data + 2));
+	print_hex_field("  Data", frame->data + 4, frame->size - 4);
+}
+
+static void att_execute_write_req(const struct l2cap_frame *frame)
+{
+	uint8_t flags = *(uint8_t *) frame->data;
+	const char *flags_str;
+
+	switch (flags) {
+	case 0x00:
+		flags_str = "Cancel all prepared writes";
+		break;
+	case 0x01:
+		flags_str = "Immediately write all pending values";
+		break;
+	default:
+		flags_str = "Unknown";
+		break;
+	}
+
+	print_field("Flags: %s (0x%02x)", flags_str, flags);
+}
+
+static void att_handle_value_notify(const struct l2cap_frame *frame)
+{
+	const struct bt_l2cap_att_handle_value_notify *pdu = frame->data;
+
+	print_field("Handle: 0x%4.4x", le16_to_cpu(pdu->handle));
+	print_hex_field("  Data", frame->data + 2, frame->size - 2);
+}
+
+static void att_handle_value_ind(const struct l2cap_frame *frame)
+{
+	const struct bt_l2cap_att_handle_value_ind *pdu = frame->data;
+
+	print_field("Handle: 0x%4.4x", le16_to_cpu(pdu->handle));
+	print_hex_field("  Data", frame->data + 2, frame->size - 2);
+}
+
+static void att_handle_value_conf(const struct l2cap_frame *frame)
+{
+}
+
+static void att_multiple_vl_rsp(const struct l2cap_frame *frame)
+{
+	struct l2cap_frame *f = (void *) frame;
+
+	while (frame->size) {
+		uint16_t handle;
+		uint16_t len;
+
+		if (!l2cap_frame_get_le16(f, &handle))
+			return;
+
+		print_field("Handle: 0x%4.4x", handle);
+
+		if (!l2cap_frame_get_le16(f, &len))
+			return;
+
+		print_field("Length: 0x%4.4x", len);
+
+		print_hex_field("  Data", f->data,
+				len < f->size ? len : f->size);
+
+		if (len > f->size) {
+			print_text(COLOR_ERROR, "invalid size");
+			return;
+		}
+
+		l2cap_frame_pull(f, f, len);
+	}
+}
+
+static void att_write_command(const struct l2cap_frame *frame)
+{
+	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_hex_field("  Data", frame->data + 2, frame->size - 2);
+}
+
+static void att_signed_write_command(const struct l2cap_frame *frame)
+{
+	print_field("Handle: 0x%4.4x", get_le16(frame->data));
+	print_hex_field("  Data", frame->data + 2, frame->size - 2 - 12);
+	print_hex_field("  Signature", frame->data + frame->size - 12, 12);
+}
+
+struct att_opcode_data {
+	uint8_t opcode;
+	const char *str;
+	void (*func) (const struct l2cap_frame *frame);
+	uint8_t size;
+	bool fixed;
+};
+
+static const struct att_opcode_data att_opcode_table[] = {
+	{ 0x01, "Error Response",
+			att_error_response, 4, true },
+	{ 0x02, "Exchange MTU Request",
+			att_exchange_mtu_req, 2, true },
+	{ 0x03, "Exchange MTU Response",
+			att_exchange_mtu_rsp, 2, true },
+	{ 0x04, "Find Information Request",
+			att_find_info_req, 4, true },
+	{ 0x05, "Find Information Response",
+			att_find_info_rsp, 5, false },
+	{ 0x06, "Find By Type Value Request",
+			att_find_by_type_val_req, 6, false },
+	{ 0x07, "Find By Type Value Response",
+			att_find_by_type_val_rsp, 4, false },
+	{ 0x08, "Read By Type Request",
+			att_read_type_req, 6, false },
+	{ 0x09, "Read By Type Response",
+			att_read_type_rsp, 3, false },
+	{ 0x0a, "Read Request",
+			att_read_req, 2, true },
+	{ 0x0b, "Read Response",
+			att_read_rsp, 0, false },
+	{ 0x0c, "Read Blob Request",
+			att_read_blob_req, 4, true },
+	{ 0x0d, "Read Blob Response",
+			att_read_blob_rsp, 0, false },
+	{ 0x0e, "Read Multiple Request",
+			att_read_multiple_req, 4, false },
+	{ 0x0f, "Read Multiple Response"	},
+	{ 0x10, "Read By Group Type Request",
+			att_read_group_type_req, 6, false },
+	{ 0x11, "Read By Group Type Response",
+			att_read_group_type_rsp, 4, false },
+	{ 0x12, "Write Request"	,
+			att_write_req, 2, false	},
+	{ 0x13, "Write Response",
+			att_write_rsp, 0, true	},
+	{ 0x16, "Prepare Write Request",
+			att_prepare_write_req, 4, false },
+	{ 0x17, "Prepare Write Response",
+			att_prepare_write_rsp, 4, false },
+	{ 0x18, "Execute Write Request",
+			att_execute_write_req, 1, true },
+	{ 0x19, "Execute Write Response"	},
+	{ 0x1b, "Handle Value Notification",
+			att_handle_value_notify, 2, false },
+	{ 0x1d, "Handle Value Indication",
+			att_handle_value_ind, 2, false },
+	{ 0x1e, "Handle Value Confirmation",
+			att_handle_value_conf, 0, true },
+	{ 0x20, "Read Multiple Request Variable Length",
+			att_read_multiple_req, 4, false },
+	{ 0x21, "Read Multiple Response Variable Length",
+			att_multiple_vl_rsp, 4, false },
+	{ 0x23, "Handle Multiple Value Notification",
+			att_multiple_vl_rsp, 4, false },
+	{ 0x52, "Write Command",
+			att_write_command, 2, false },
+	{ 0xd2, "Signed Write Command", att_signed_write_command, 14, false },
+	{ }
+};
+
+static const char *att_opcode_to_str(uint8_t opcode)
+{
+	int i;
+
+	for (i = 0; att_opcode_table[i].str; i++) {
+		if (att_opcode_table[i].opcode == opcode)
+			return att_opcode_table[i].str;
+	}
+
+	return "Unknown";
+}
+
+void att_packet(uint16_t index, bool in, uint16_t handle, uint16_t cid,
+					const void *data, uint16_t size)
+{
+	struct l2cap_frame frame;
+	uint8_t opcode = *((const uint8_t *) data);
+	const struct att_opcode_data *opcode_data = NULL;
+	const char *opcode_color, *opcode_str;
+	int i;
+
+	if (size < 1) {
+		print_text(COLOR_ERROR, "malformed attribute packet");
+		packet_hexdump(data, size);
+		return;
+	}
+
+	for (i = 0; att_opcode_table[i].str; i++) {
+		if (att_opcode_table[i].opcode == opcode) {
+			opcode_data = &att_opcode_table[i];
+			break;
+		}
+	}
+
+	if (opcode_data) {
+		if (opcode_data->func) {
+			if (in)
+				opcode_color = COLOR_MAGENTA;
+			else
+				opcode_color = COLOR_BLUE;
+		} else
+			opcode_color = COLOR_WHITE_BG;
+		opcode_str = opcode_data->str;
+	} else {
+		opcode_color = COLOR_WHITE_BG;
+		opcode_str = "Unknown";
+	}
+
+	print_indent(6, opcode_color, "ATT: ", opcode_str, COLOR_OFF,
+				" (0x%2.2x) len %d", opcode, size - 1);
+
+	if (!opcode_data || !opcode_data->func) {
+		packet_hexdump(data + 1, size - 1);
+		return;
+	}
+
+	if (opcode_data->fixed) {
+		if (size - 1 != opcode_data->size) {
+			print_text(COLOR_ERROR, "invalid size");
+			packet_hexdump(data + 1, size - 1);
+			return;
+		}
+	} else {
+		if (size - 1 < opcode_data->size) {
+			print_text(COLOR_ERROR, "too short packet");
+			packet_hexdump(data + 1, size - 1);
+			return;
+		}
+	}
+
+	l2cap_frame_init(&frame, index, in, handle, 0, cid, 0,
+						data + 1, size - 1);
+	opcode_data->func(&frame);
+}
diff --git a/monitor/att.h b/monitor/att.h
new file mode 100644
index 000000000..07951b200
--- /dev/null
+++ b/monitor/att.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011-2014  Intel Corporation
+ *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ */
+
+#include <stdint.h>
+#include <stdbool.h>
+
+void att_packet(uint16_t index, bool in, uint16_t handle, uint16_t cid,
+					const void *data, uint16_t size);
diff --git a/monitor/l2cap.c b/monitor/l2cap.c
index 192b6c920..3f5554e5e 100644
--- a/monitor/l2cap.c
+++ b/monitor/l2cap.c
@@ -33,7 +33,7 @@
 #include "avdtp.h"
 #include "rfcomm.h"
 #include "bnep.h"
-
+#include "att.h"
 
 #define L2CAP_MODE_BASIC		0x00
 #define L2CAP_MODE_RETRANS		0x01
@@ -1538,7 +1538,7 @@ static const struct sig_opcode_data le_sig_opcode_table[] = {
 	{ },
 };
 
-static void l2cap_frame_init(struct l2cap_frame *frame, uint16_t index, bool in,
+void l2cap_frame_init(struct l2cap_frame *frame, uint16_t index, bool in,
 				uint16_t handle, uint8_t ident,
 				uint16_t cid, uint16_t psm,
 				const void *data, uint16_t size)
@@ -2123,618 +2123,6 @@ static void amp_packet(uint16_t index, bool in, uint16_t handle,
 	opcode_data->func(&frame);
 }
 
-static void print_uuid(const char *label, const void *data, uint16_t size)
-{
-	const char *str;
-	char uuidstr[MAX_LEN_UUID_STR];
-
-	switch (size) {
-	case 2:
-		str = bt_uuid16_to_str(get_le16(data));
-		print_field("%s: %s (0x%4.4x)", label, str, get_le16(data));
-		break;
-	case 4:
-		str = bt_uuid32_to_str(get_le32(data));
-		print_field("%s: %s (0x%8.8x)", label, str, get_le32(data));
-		break;
-	case 16:
-		sprintf(uuidstr, "%8.8x-%4.4x-%4.4x-%4.4x-%8.8x%4.4x",
-				get_le32(data + 12), get_le16(data + 10),
-				get_le16(data + 8), get_le16(data + 6),
-				get_le32(data + 2), get_le16(data + 0));
-		str = bt_uuidstr_to_str(uuidstr);
-		print_field("%s: %s (%s)", label, str, uuidstr);
-		break;
-	default:
-		packet_hexdump(data, size);
-		break;
-	}
-}
-
-static void print_handle_range(const char *label, const void *data)
-{
-	print_field("%s: 0x%4.4x-0x%4.4x", label,
-				get_le16(data), get_le16(data + 2));
-}
-
-static void print_data_list(const char *label, uint8_t length,
-					const void *data, uint16_t size)
-{
-	uint8_t count;
-
-	if (length == 0)
-		return;
-
-	count = size / length;
-
-	print_field("%s: %u entr%s", label, count, count == 1 ? "y" : "ies");
-
-	while (size >= length) {
-		print_field("Handle: 0x%4.4x", get_le16(data));
-		print_hex_field("Value", data + 2, length - 2);
-
-		data += length;
-		size -= length;
-	}
-
-	packet_hexdump(data, size);
-}
-
-static void print_attribute_info(uint16_t type, const void *data, uint16_t len)
-{
-	const char *str = bt_uuid16_to_str(type);
-
-	print_field("%s: %s (0x%4.4x)", "Attribute type", str, type);
-
-	switch (type) {
-	case 0x2800:	/* Primary Service */
-	case 0x2801:	/* Secondary Service */
-		print_uuid("  UUID", data, len);
-		break;
-	case 0x2802:	/* Include */
-		if (len < 4) {
-			print_hex_field("  Value", data, len);
-			break;
-		}
-		print_handle_range("  Handle range", data);
-		print_uuid("  UUID", data + 4, len - 4);
-		break;
-	case 0x2803:	/* Characteristic */
-		if (len < 3) {
-			print_hex_field("  Value", data, len);
-			break;
-		}
-		print_field("  Properties: 0x%2.2x", *((uint8_t *) data));
-		print_field("  Handle: 0x%2.2x", get_le16(data + 1));
-		print_uuid("  UUID", data + 3, len - 3);
-		break;
-	default:
-		print_hex_field("Value", data, len);
-		break;
-	}
-}
-
-static const char *att_opcode_to_str(uint8_t opcode);
-
-static void att_error_response(const struct l2cap_frame *frame)
-{
-	const struct bt_l2cap_att_error_response *pdu = frame->data;
-	const char *str;
-
-	switch (pdu->error) {
-	case 0x01:
-		str = "Invalid Handle";
-		break;
-	case 0x02:
-		str = "Read Not Permitted";
-		break;
-	case 0x03:
-		str = "Write Not Permitted";
-		break;
-	case 0x04:
-		str = "Invalid PDU";
-		break;
-	case 0x05:
-		str = "Insufficient Authentication";
-		break;
-	case 0x06:
-		str = "Request Not Supported";
-		break;
-	case 0x07:
-		str = "Invalid Offset";
-		break;
-	case 0x08:
-		str = "Insufficient Authorization";
-		break;
-	case 0x09:
-		str = "Prepare Queue Full";
-		break;
-	case 0x0a:
-		str = "Attribute Not Found";
-		break;
-	case 0x0b:
-		str = "Attribute Not Long";
-		break;
-	case 0x0c:
-		str = "Insufficient Encryption Key Size";
-		break;
-	case 0x0d:
-		str = "Invalid Attribute Value Length";
-		break;
-	case 0x0e:
-		str = "Unlikely Error";
-		break;
-	case 0x0f:
-		str = "Insufficient Encryption";
-		break;
-	case 0x10:
-		str = "Unsupported Group Type";
-		break;
-	case 0x11:
-		str = "Insufficient Resources";
-		break;
-	case 0x12:
-		str = "Database Out of Sync";
-		break;
-	case 0x13:
-		str = "Value Not Allowed";
-		break;
-	case 0xfd:
-		str = "CCC Improperly Configured";
-		break;
-	case 0xfe:
-		str = "Procedure Already in Progress";
-		break;
-	case 0xff:
-		str = "Out of Range";
-		break;
-	default:
-		str = "Reserved";
-		break;
-	}
-
-	print_field("%s (0x%2.2x)", att_opcode_to_str(pdu->request),
-							pdu->request);
-	print_field("Handle: 0x%4.4x", le16_to_cpu(pdu->handle));
-	print_field("Error: %s (0x%2.2x)", str, pdu->error);
-}
-
-static void att_exchange_mtu_req(const struct l2cap_frame *frame)
-{
-	const struct bt_l2cap_att_exchange_mtu_req *pdu = frame->data;
-
-	print_field("Client RX MTU: %d", le16_to_cpu(pdu->mtu));
-}
-
-static void att_exchange_mtu_rsp(const struct l2cap_frame *frame)
-{
-	const struct bt_l2cap_att_exchange_mtu_rsp *pdu = frame->data;
-
-	print_field("Server RX MTU: %d", le16_to_cpu(pdu->mtu));
-}
-
-static void att_find_info_req(const struct l2cap_frame *frame)
-{
-	print_handle_range("Handle range", frame->data);
-}
-
-static const char *att_format_str(uint8_t format)
-{
-	switch (format) {
-	case 0x01:
-		return "UUID-16";
-	case 0x02:
-		return "UUID-128";
-	default:
-		return "unknown";
-	}
-}
-
-static uint16_t print_info_data_16(const void *data, uint16_t len)
-{
-	while (len >= 4) {
-		print_field("Handle: 0x%4.4x", get_le16(data));
-		print_uuid("UUID", data + 2, 2);
-		data += 4;
-		len -= 4;
-	}
-
-	return len;
-}
-
-static uint16_t print_info_data_128(const void *data, uint16_t len)
-{
-	while (len >= 18) {
-		print_field("Handle: 0x%4.4x", get_le16(data));
-		print_uuid("UUID", data + 2, 16);
-		data += 18;
-		len -= 18;
-	}
-
-	return len;
-}
-
-static void att_find_info_rsp(const struct l2cap_frame *frame)
-{
-	const uint8_t *format = frame->data;
-	uint16_t len;
-
-	print_field("Format: %s (0x%2.2x)", att_format_str(*format), *format);
-
-	if (*format == 0x01)
-		len = print_info_data_16(frame->data + 1, frame->size - 1);
-	else if (*format == 0x02)
-		len = print_info_data_128(frame->data + 1, frame->size - 1);
-	else
-		len = frame->size - 1;
-
-	packet_hexdump(frame->data + (frame->size - len), len);
-}
-
-static void att_find_by_type_val_req(const struct l2cap_frame *frame)
-{
-	uint16_t type;
-
-	print_handle_range("Handle range", frame->data);
-
-	type = get_le16(frame->data + 4);
-	print_attribute_info(type, frame->data + 6, frame->size - 6);
-}
-
-static void att_find_by_type_val_rsp(const struct l2cap_frame *frame)
-{
-	const uint8_t *ptr = frame->data;
-	uint16_t len = frame->size;
-
-	while (len >= 4) {
-		print_handle_range("Handle range", ptr);
-		ptr += 4;
-		len -= 4;
-	}
-
-	packet_hexdump(ptr, len);
-}
-
-static void att_read_type_req(const struct l2cap_frame *frame)
-{
-	print_handle_range("Handle range", frame->data);
-	print_uuid("Attribute type", frame->data + 4, frame->size - 4);
-}
-
-static void att_read_type_rsp(const struct l2cap_frame *frame)
-{
-	const struct bt_l2cap_att_read_group_type_rsp *pdu = frame->data;
-
-	print_field("Attribute data length: %d", pdu->length);
-	print_data_list("Attribute data list", pdu->length,
-					frame->data + 1, frame->size - 1);
-}
-
-static void att_read_req(const struct l2cap_frame *frame)
-{
-	const struct bt_l2cap_att_read_req *pdu = frame->data;
-
-	print_field("Handle: 0x%4.4x", le16_to_cpu(pdu->handle));
-}
-
-static void att_read_rsp(const struct l2cap_frame *frame)
-{
-	print_hex_field("Value", frame->data, frame->size);
-}
-
-static void att_read_blob_req(const struct l2cap_frame *frame)
-{
-	print_field("Handle: 0x%4.4x", get_le16(frame->data));
-	print_field("Offset: 0x%4.4x", get_le16(frame->data + 2));
-}
-
-static void att_read_blob_rsp(const struct l2cap_frame *frame)
-{
-	packet_hexdump(frame->data, frame->size);
-}
-
-static void att_read_multiple_req(const struct l2cap_frame *frame)
-{
-	int i, count;
-
-	count = frame->size / 2;
-
-	for (i = 0; i < count; i++)
-		print_field("Handle: 0x%4.4x",
-					get_le16(frame->data + (i * 2)));
-}
-
-static void att_read_group_type_req(const struct l2cap_frame *frame)
-{
-	print_handle_range("Handle range", frame->data);
-	print_uuid("Attribute group type", frame->data + 4, frame->size - 4);
-}
-
-static void print_group_list(const char *label, uint8_t length,
-					const void *data, uint16_t size)
-{
-	uint8_t count;
-
-	if (length == 0)
-		return;
-
-	count = size / length;
-
-	print_field("%s: %u entr%s", label, count, count == 1 ? "y" : "ies");
-
-	while (size >= length) {
-		print_handle_range("Handle range", data);
-		print_uuid("UUID", data + 4, length - 4);
-
-		data += length;
-		size -= length;
-	}
-
-	packet_hexdump(data, size);
-}
-
-static void att_read_group_type_rsp(const struct l2cap_frame *frame)
-{
-	const struct bt_l2cap_att_read_group_type_rsp *pdu = frame->data;
-
-	print_field("Attribute data length: %d", pdu->length);
-	print_group_list("Attribute group list", pdu->length,
-					frame->data + 1, frame->size - 1);
-}
-
-static void att_write_req(const struct l2cap_frame *frame)
-{
-	print_field("Handle: 0x%4.4x", get_le16(frame->data));
-	print_hex_field("  Data", frame->data + 2, frame->size - 2);
-}
-
-static void att_write_rsp(const struct l2cap_frame *frame)
-{
-}
-
-static void att_prepare_write_req(const struct l2cap_frame *frame)
-{
-	print_field("Handle: 0x%4.4x", get_le16(frame->data));
-	print_field("Offset: 0x%4.4x", get_le16(frame->data + 2));
-	print_hex_field("  Data", frame->data + 4, frame->size - 4);
-}
-
-static void att_prepare_write_rsp(const struct l2cap_frame *frame)
-{
-	print_field("Handle: 0x%4.4x", get_le16(frame->data));
-	print_field("Offset: 0x%4.4x", get_le16(frame->data + 2));
-	print_hex_field("  Data", frame->data + 4, frame->size - 4);
-}
-
-static void att_execute_write_req(const struct l2cap_frame *frame)
-{
-	uint8_t flags = *(uint8_t *) frame->data;
-	const char *flags_str;
-
-	switch (flags) {
-	case 0x00:
-		flags_str = "Cancel all prepared writes";
-		break;
-	case 0x01:
-		flags_str = "Immediately write all pending values";
-		break;
-	default:
-		flags_str = "Unknown";
-		break;
-	}
-
-	print_field("Flags: %s (0x%02x)", flags_str, flags);
-}
-
-static void att_handle_value_notify(const struct l2cap_frame *frame)
-{
-	const struct bt_l2cap_att_handle_value_notify *pdu = frame->data;
-
-	print_field("Handle: 0x%4.4x", le16_to_cpu(pdu->handle));
-	print_hex_field("  Data", frame->data + 2, frame->size - 2);
-}
-
-static void att_handle_value_ind(const struct l2cap_frame *frame)
-{
-	const struct bt_l2cap_att_handle_value_ind *pdu = frame->data;
-
-	print_field("Handle: 0x%4.4x", le16_to_cpu(pdu->handle));
-	print_hex_field("  Data", frame->data + 2, frame->size - 2);
-}
-
-static void att_handle_value_conf(const struct l2cap_frame *frame)
-{
-}
-
-static void att_multiple_vl_rsp(const struct l2cap_frame *frame)
-{
-	struct l2cap_frame *f = (void *) frame;
-
-	while (frame->size) {
-		uint16_t handle;
-		uint16_t len;
-
-		if (!l2cap_frame_get_le16(f, &handle))
-			return;
-
-		print_field("Handle: 0x%4.4x", handle);
-
-		if (!l2cap_frame_get_le16(f, &len))
-			return;
-
-		print_field("Length: 0x%4.4x", len);
-
-		print_hex_field("  Data", f->data,
-				len < f->size ? len : f->size);
-
-		if (len > f->size) {
-			print_text(COLOR_ERROR, "invalid size");
-			return;
-		}
-
-		l2cap_frame_pull(f, f, len);
-	}
-}
-
-static void att_write_command(const struct l2cap_frame *frame)
-{
-	print_field("Handle: 0x%4.4x", get_le16(frame->data));
-	print_hex_field("  Data", frame->data + 2, frame->size - 2);
-}
-
-static void att_signed_write_command(const struct l2cap_frame *frame)
-{
-	print_field("Handle: 0x%4.4x", get_le16(frame->data));
-	print_hex_field("  Data", frame->data + 2, frame->size - 2 - 12);
-	print_hex_field("  Signature", frame->data + frame->size - 12, 12);
-}
-
-struct att_opcode_data {
-	uint8_t opcode;
-	const char *str;
-	void (*func) (const struct l2cap_frame *frame);
-	uint8_t size;
-	bool fixed;
-};
-
-static const struct att_opcode_data att_opcode_table[] = {
-	{ 0x01, "Error Response",
-			att_error_response, 4, true },
-	{ 0x02, "Exchange MTU Request",
-			att_exchange_mtu_req, 2, true },
-	{ 0x03, "Exchange MTU Response",
-			att_exchange_mtu_rsp, 2, true },
-	{ 0x04, "Find Information Request",
-			att_find_info_req, 4, true },
-	{ 0x05, "Find Information Response",
-			att_find_info_rsp, 5, false },
-	{ 0x06, "Find By Type Value Request",
-			att_find_by_type_val_req, 6, false },
-	{ 0x07, "Find By Type Value Response",
-			att_find_by_type_val_rsp, 4, false },
-	{ 0x08, "Read By Type Request",
-			att_read_type_req, 6, false },
-	{ 0x09, "Read By Type Response",
-			att_read_type_rsp, 3, false },
-	{ 0x0a, "Read Request",
-			att_read_req, 2, true },
-	{ 0x0b, "Read Response",
-			att_read_rsp, 0, false },
-	{ 0x0c, "Read Blob Request",
-			att_read_blob_req, 4, true },
-	{ 0x0d, "Read Blob Response",
-			att_read_blob_rsp, 0, false },
-	{ 0x0e, "Read Multiple Request",
-			att_read_multiple_req, 4, false },
-	{ 0x0f, "Read Multiple Response"	},
-	{ 0x10, "Read By Group Type Request",
-			att_read_group_type_req, 6, false },
-	{ 0x11, "Read By Group Type Response",
-			att_read_group_type_rsp, 4, false },
-	{ 0x12, "Write Request"	,
-			att_write_req, 2, false	},
-	{ 0x13, "Write Response",
-			att_write_rsp, 0, true	},
-	{ 0x16, "Prepare Write Request",
-			att_prepare_write_req, 4, false },
-	{ 0x17, "Prepare Write Response",
-			att_prepare_write_rsp, 4, false },
-	{ 0x18, "Execute Write Request",
-			att_execute_write_req, 1, true },
-	{ 0x19, "Execute Write Response"	},
-	{ 0x1b, "Handle Value Notification",
-			att_handle_value_notify, 2, false },
-	{ 0x1d, "Handle Value Indication",
-			att_handle_value_ind, 2, false },
-	{ 0x1e, "Handle Value Confirmation",
-			att_handle_value_conf, 0, true },
-	{ 0x20, "Read Multiple Request Variable Length",
-			att_read_multiple_req, 4, false },
-	{ 0x21, "Read Multiple Response Variable Length",
-			att_multiple_vl_rsp, 4, false },
-	{ 0x23, "Handle Multiple Value Notification",
-			att_multiple_vl_rsp, 4, false },
-	{ 0x52, "Write Command",
-			att_write_command, 2, false },
-	{ 0xd2, "Signed Write Command", att_signed_write_command, 14, false },
-	{ }
-};
-
-static const char *att_opcode_to_str(uint8_t opcode)
-{
-	int i;
-
-	for (i = 0; att_opcode_table[i].str; i++) {
-		if (att_opcode_table[i].opcode == opcode)
-			return att_opcode_table[i].str;
-	}
-
-	return "Unknown";
-}
-
-static void att_packet(uint16_t index, bool in, uint16_t handle,
-			uint16_t cid, const void *data, uint16_t size)
-{
-	struct l2cap_frame frame;
-	uint8_t opcode = *((const uint8_t *) data);
-	const struct att_opcode_data *opcode_data = NULL;
-	const char *opcode_color, *opcode_str;
-	int i;
-
-	if (size < 1) {
-		print_text(COLOR_ERROR, "malformed attribute packet");
-		packet_hexdump(data, size);
-		return;
-	}
-
-	for (i = 0; att_opcode_table[i].str; i++) {
-		if (att_opcode_table[i].opcode == opcode) {
-			opcode_data = &att_opcode_table[i];
-			break;
-		}
-	}
-
-	if (opcode_data) {
-		if (opcode_data->func) {
-			if (in)
-				opcode_color = COLOR_MAGENTA;
-			else
-				opcode_color = COLOR_BLUE;
-		} else
-			opcode_color = COLOR_WHITE_BG;
-		opcode_str = opcode_data->str;
-	} else {
-		opcode_color = COLOR_WHITE_BG;
-		opcode_str = "Unknown";
-	}
-
-	print_indent(6, opcode_color, "ATT: ", opcode_str, COLOR_OFF,
-				" (0x%2.2x) len %d", opcode, size - 1);
-
-	if (!opcode_data || !opcode_data->func) {
-		packet_hexdump(data + 1, size - 1);
-		return;
-	}
-
-	if (opcode_data->fixed) {
-		if (size - 1 != opcode_data->size) {
-			print_text(COLOR_ERROR, "invalid size");
-			packet_hexdump(data + 1, size - 1);
-			return;
-		}
-	} else {
-		if (size - 1 < opcode_data->size) {
-			print_text(COLOR_ERROR, "too short packet");
-			packet_hexdump(data + 1, size - 1);
-			return;
-		}
-	}
-
-	l2cap_frame_init(&frame, index, in, handle, 0, cid, 0,
-						data + 1, size - 1);
-	opcode_data->func(&frame);
-}
-
 static void print_smp_io_capa(uint8_t io_capa)
 {
 	const char *str;
diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index e46042db4..951b411e0 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -26,6 +26,11 @@ struct l2cap_frame {
 	uint16_t size;
 };
 
+void l2cap_frame_init(struct l2cap_frame *frame, uint16_t index, bool in,
+				uint16_t handle, uint8_t ident,
+				uint16_t cid, uint16_t psm,
+				const void *data, uint16_t size);
+
 static inline void l2cap_frame_pull(struct l2cap_frame *frame,
 				const struct l2cap_frame *source, uint16_t len)
 {
-- 
2.35.1

