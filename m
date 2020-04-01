Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773C4C43331
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 22:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE3720678
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 22:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bEe8xVXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733133AbgDAWOr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:14:47 -0400
Received: from mail-pf1-f169.google.com ([209.85.210.169]:33584 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733095AbgDAWOr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 18:14:47 -0400
Received: by mail-pf1-f169.google.com with SMTP id c138so738676pfc.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2020 15:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1vu4h8YZdqPoNxMR4Bg7PsRKoy+xKrL2ziEBT8GCNdo=;
        b=bEe8xVXwT0cFZijWgR2OK2XEB2fHWqF/gCDJFe3BPcCU/HRZP2VVeDBazTHTAcgZu8
         XUA1++4hYITA/m2f6aOgugK5qB7qkcscdGTqFFcqBtTkB/Ab5F2e9pht4/nvi0KGeY19
         dwkZOXsQ3vwS6tqmIkFFviKHdQcl61J4aIw0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1vu4h8YZdqPoNxMR4Bg7PsRKoy+xKrL2ziEBT8GCNdo=;
        b=FnvFNghdEzT7HuzYVGMZAwKVVR8bcR4jVwcNuNuwU0WU14/Zdwf+9BMs1awX5pnbWe
         1vx/emlp0fmXThlHqpE35WH6fr4hNp4ShNdIaHIbEORVvCTyiRd8I9Qzko6VeWeJwloo
         oaHs/qx2oO0O5Qan20bqGzJtHQlW8Gm1blQlZsC5j6sKVEzjfs+IGm413upqU1VzHWMb
         jeluHcOgJ0IRju31dGLfzbuwDEFQaVUbeoBfUY5xDTNrRTarrC4g3HQC7XoW/KcSqtPX
         D5t6fLSfDIVyeXOPb3jAaHQ4plZiWGjcDlxlATF3DPWfyKSeIq5Sm9nHSb0WhNPE3XdF
         wCaw==
X-Gm-Message-State: ANhLgQ1dzVI3+kufEK55AryBzpN1hIoTqTCFESJrNJvjrzmFII/PGupc
        /j/oIJMzpAtSghLCmONaadS+VfQHDdY=
X-Google-Smtp-Source: ADFU+vt3PuGZW+giDM6J0zSGWtAcLpwD6JaoCnLR557wETConD7OJL/MWK+VscHmvBcKAHqYzeSBzA==
X-Received: by 2002:a62:3487:: with SMTP id b129mr25456150pfa.150.1585779285306;
        Wed, 01 Apr 2020 15:14:45 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:b7e2:9910:bd78:608d])
        by smtp.gmail.com with ESMTPSA id z6sm2394666pjt.42.2020.04.01.15.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 15:14:44 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Miao Chou <mcchou@chromium.org>
Subject: [PATCH 3/5] Implement CreateServiceRecord method
Date:   Wed,  1 Apr 2020 15:14:32 -0700
Message-Id: <20200401221434.12185-3-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200401221434.12185-1-sonnysasaka@chromium.org>
References: <20200401221434.12185-1-sonnysasaka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Miao Chou <mcchou@chromium.org>

This implements the CreateServiceRecord method of org.bluez.Adapter1 interface.
---
 src/adapter.c | 414 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 414 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 972d88772..c02aaf32b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -48,6 +48,7 @@
 #include "bluetooth/sdp_lib.h"
 #include "lib/uuid.h"
 #include "lib/mgmt.h"
+#include "lib/sdp.h"
 
 #include "gdbus/gdbus.h"
 
@@ -3424,6 +3425,415 @@ static DBusMessage *connect_device(DBusConnection *conn,
 	return NULL;
 }
 
+static int parse_int_uint_variant(DBusMessageIter *iter, bool unsign,
+					uint32_t size, void **val, uint8_t *dtd)
+{
+	int dbus_type = DBUS_TYPE_INVALID;
+	char arg[4];
+
+	switch(size) {
+	case 1:
+		if (unsign) {
+			*val = malloc(sizeof(uint8_t));
+			*dtd = SDP_UINT8;
+		} else {
+			*val = malloc(sizeof(int8_t));
+			*dtd = SDP_INT8;
+		}
+		dbus_type = DBUS_TYPE_BYTE;
+		break;
+	case 2:
+		if (unsign) {
+			*val = malloc(sizeof(uint16_t));
+			*dtd = SDP_UINT16;
+			dbus_type = DBUS_TYPE_UINT16;
+		} else {
+			*val = malloc(sizeof(int16_t));
+			*dtd = SDP_INT16;
+			dbus_type = DBUS_TYPE_INT16;
+		}
+		break;
+	case 4:
+		if (unsign) {
+			*val = malloc(sizeof(uint32_t));
+			*dtd = SDP_UINT32;
+			dbus_type = DBUS_TYPE_UINT32;
+		} else {
+			*val = malloc(sizeof(int32_t));
+			*dtd = SDP_INT32;
+			dbus_type = DBUS_TYPE_INT32;
+		}
+		break;
+	case 8:
+		if (unsign) {
+			*val = malloc(sizeof(uint64_t));
+			*dtd = SDP_UINT64;
+			dbus_type = DBUS_TYPE_UINT64;
+		} else {
+			*val = malloc(sizeof(int64_t));
+			*dtd = SDP_INT64;
+			dbus_type = DBUS_TYPE_INT64;
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!*val)
+		return -1;
+
+	if (dbus_message_iter_get_arg_type(iter) != dbus_type) {
+		free(*val);
+		return -EINVAL;
+	}
+	dbus_message_iter_get_basic(iter, arg);
+
+	memcpy(*val, arg, size);
+
+	return 0;
+}
+
+static int parse_str_variant(DBusMessageIter *iter, void **val, int *str_len)
+{
+	const char *str;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return -EINVAL;
+	dbus_message_iter_get_basic(iter, &str);
+
+	if (!str)
+		return -1;
+
+	*str_len = strlen(str) + 1;
+
+	*val = calloc(*str_len, sizeof(char));
+	if (!val)
+		return -1;
+
+	strncpy(*val, str, *str_len - 1);
+
+	return 0;
+}
+
+static int parse_attr_value(DBusMessageIter *val_struct,
+					sdp_data_t **attr, sdp_record_t* rec)
+{
+	DBusMessageIter iter, val_variant;
+	uint8_t val_type = SDP_VAL_TYPE_NIL;
+	uint32_t val_size = 0;
+
+	uint8_t dtd;
+	void *val = NULL;
+	int str_len = 0;
+	int ret = 0;
+
+	*attr = NULL;
+
+	if (dbus_message_iter_get_arg_type(val_struct) != DBUS_TYPE_STRUCT)
+		return -EINVAL;
+	dbus_message_iter_recurse(val_struct, &iter);
+
+	// Extract attribute value type.
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_BYTE)
+		return -EINVAL;
+	dbus_message_iter_get_basic(&iter, &val_type);
+	if (!dbus_message_iter_next(&iter))
+		return -ENODATA;
+
+	// Extract attribute value size.
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_UINT32)
+		return -EINVAL;
+	dbus_message_iter_get_basic(&iter, &val_size);
+	if (!dbus_message_iter_next(&iter))
+		return -ENODATA;
+
+	// Extract attribute value based on its type.
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return -EINVAL;
+	dbus_message_iter_recurse(&iter, &val_variant);
+
+	switch(val_type) {
+	case SDP_VAL_TYPE_NIL:
+		dtd = SDP_DATA_NIL;
+		break;
+	case SDP_VAL_TYPE_UINT: {
+		ret = parse_int_uint_variant(&val_variant, true, val_size, &val,
+						&dtd);
+		if (ret < 0)
+			return ret;
+		break;
+	}
+	case SDP_VAL_TYPE_INT: {
+		ret = parse_int_uint_variant(&val_variant, false, val_size, &val,
+						&dtd);
+		if (ret < 0)
+			return ret;
+		break;
+	}
+	case SDP_VAL_TYPE_UUID: {
+		// The UUID string is in "%08x-%04x-%04x-%04x-%08x%04x" format.
+		// Take Bluetooth base UUID for instance, the base UUID string
+		// is "00000000-0000-1000-8000-00805F9B34FB". Extra action may
+		// be needed to change the UUID type of a newly-created |uuid|
+		// based on the |val_size| field.
+		uuid_t *uuid = NULL;
+		const char *uuid_str;
+		void *arg = NULL;
+
+		if (dbus_message_iter_get_arg_type(&val_variant) !=
+				DBUS_TYPE_STRING)
+			return -EINVAL;
+		dbus_message_iter_get_basic(&val_variant, &uuid_str);
+
+		if (!uuid_str)
+			return -1;
+
+		uuid = (uuid_t *)malloc(sizeof(uuid_t));
+		if (!uuid)
+			return -1;
+
+		if (bt_string2uuid(uuid, uuid_str) < 0) {
+			free(uuid);
+			return -1;
+		}
+
+		switch(val_size) {
+		case 2:
+			dtd = SDP_UUID16;
+			if (!sdp_uuid128_to_uuid(uuid)) {
+				free(uuid);
+				return -1;
+			}
+			arg = &uuid->value.uuid16;
+			break;
+		case 4:
+			dtd = SDP_UUID32;
+			if (!sdp_uuid128_to_uuid(uuid)) {
+				free(uuid);
+				return -1;
+			}
+			arg = &uuid->value.uuid32;
+			break;
+		case 16:
+			dtd = SDP_UUID128;
+			arg = &uuid->value.uuid128;
+			break;
+		default:
+			free(uuid);
+			return -EINVAL;
+		}
+
+		val = malloc(val_size);
+		memcpy(val, arg, val_size);
+
+		// Insert the UUID into |rec|'s search pattern. The ownership
+		// of |uuid| will NOT be transferred, so |uuid| should be freed
+		// after use.
+		sdp_pattern_add_uuid(rec, uuid);
+
+		free(uuid);
+		break;
+	}
+	case SDP_VAL_TYPE_STRING: {
+		dtd = SDP_TEXT_STR8;
+		ret = parse_str_variant(&val_variant, &val, &str_len);
+		if (ret < 0)
+			return ret;
+		break;
+	}
+	case SDP_VAL_TYPE_BOOL: {
+		dbus_bool_t *arg = NULL;
+
+		dtd = SDP_BOOL;
+
+		if (dbus_message_iter_get_arg_type(&val_variant) !=
+				DBUS_TYPE_BOOLEAN)
+			return -EINVAL;
+		dbus_message_iter_get_basic(&val_variant, arg);
+
+		if (!arg)
+			return -1;
+
+		val = malloc(sizeof(bool));
+		if (!val)
+			return -1;
+
+		memcpy(val, arg, sizeof(bool));
+		break;
+	}
+	case SDP_VAL_TYPE_URL: {
+		dtd = SDP_URL_STR8;
+		ret = parse_str_variant(&val_variant, &val, &str_len);
+		if (ret < 0)
+			return ret;
+		break;
+	}
+	case SDP_VAL_TYPE_SEQUENCE: {
+		sdp_data_t *seq = NULL;
+		DBusMessageIter seq_iter;
+
+		dtd = SDP_SEQ32;
+
+		if (dbus_message_iter_get_arg_type(&val_variant) !=
+				DBUS_TYPE_ARRAY)
+			return -EINVAL;
+
+		dbus_message_iter_recurse(&val_variant, &seq_iter);
+
+		// Recursively extract the value from each element of the
+		// sequence.
+		while (dbus_message_iter_get_arg_type(&seq_iter) ==
+				DBUS_TYPE_STRUCT) {
+			sdp_data_t *data;
+
+			ret = parse_attr_value(&seq_iter, &data, rec);
+			if (!data || ret < 0) {
+				if (data)
+					sdp_data_free(data);
+				if (seq)
+					sdp_data_free(seq);
+
+				return ret;
+			}
+			seq = sdp_seq_append(seq, data);
+
+			dbus_message_iter_next(&seq_iter);
+		}
+
+		val = seq;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	*attr = sdp_data_alloc_with_length(dtd, val, str_len);
+	if (!*attr) {
+		ret = -1;
+		goto error_alloc_attr;
+	}
+
+	return 0;
+
+error_alloc_attr:
+	if (!val)
+		return ret;
+
+	if (val_type == SDP_VAL_TYPE_SEQUENCE)
+		sdp_data_free((sdp_data_t *)val);
+	else
+		free(val);
+
+	return ret;
+}
+
+static int parse_record(DBusMessageIter *rec_array,
+				sdp_record_t *rec)
+{
+	DBusMessageIter attr_dict;
+	sdp_data_t *attr = NULL;
+	int ret = 0;
+
+	if (dbus_message_iter_get_arg_type(rec_array) != DBUS_TYPE_ARRAY)
+		return -EINVAL;
+
+	dbus_message_iter_recurse(rec_array, &attr_dict);
+
+	while(dbus_message_iter_get_arg_type(&attr_dict) ==
+							DBUS_TYPE_DICT_ENTRY) {
+		DBusMessageIter entry;
+		uint16_t attr_id;
+
+		dbus_message_iter_recurse(&attr_dict, &entry);
+
+		// Extract attribute ID.
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_UINT16)
+			return -EINVAL;
+		dbus_message_iter_get_basic(&entry, &attr_id);
+		if (!dbus_message_iter_next(&entry))
+			return -ENODATA;
+
+		// Extract attribute value structure.
+		ret = parse_attr_value(&entry, &attr, rec);
+		if (ret < 0)
+			goto error_parse_attr;
+
+		// Add the new attribute to the record.
+		if (sdp_attr_add(rec, attr_id, attr) < 0) {
+			ret = -1;
+			goto error_parse_attr;
+		}
+
+		dbus_message_iter_next(&attr_dict);
+	}
+
+	return 0;
+
+error_parse_attr:
+	if (attr)
+		sdp_data_free(attr);
+
+	// Release the UUID pattern list.
+	sdp_list_free(rec->pattern, free);
+
+	return ret;
+}
+
+static DBusMessage *create_service_record(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	DBusMessage *reply;
+	sdp_record_t *rec;
+	DBusMessageIter rec_array, iter;
+	int ret = 0;
+
+	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+		return btd_error_not_ready(msg);
+
+	if(!dbus_message_iter_init(msg, &rec_array))
+		return btd_error_failed(msg, "Failed to read record argument");
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return btd_error_failed(msg, "Failed to create method reply");
+
+	rec = sdp_record_alloc();
+	if (!rec)
+		goto failed_to_alloc;
+
+	ret = parse_record(&rec_array, rec);
+	if (ret < 0) {
+		sdp_record_free(rec);
+		if (ret == -EINVAL || ret == -ENODATA)
+			return btd_error_invalid_args(msg);
+		else
+			return btd_error_failed(msg,
+					"Failed to parse record argument");
+	}
+
+	ret = adapter_service_add(adapter, rec);
+	if (ret < 0) {
+		sdp_record_free(rec);
+		if (ret == -EEXIST)
+			return btd_error_already_exists(msg);
+		else
+			return btd_error_failed(msg, "Failed to add record");
+	}
+
+	dbus_message_iter_init_append(reply, &iter);
+	if (!dbus_message_iter_append_basic(
+				&iter, DBUS_TYPE_UINT32, &rec->handle)) {
+		sdp_record_free(rec);
+		return btd_error_failed(msg, "Failed to append record handle");
+	}
+
+	return reply;
+
+failed_to_alloc:
+	return btd_error_failed(msg, "Failed to allocate SDP record");
+}
+
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_ASYNC_METHOD("StartDiscovery", NULL, NULL, start_discovery) },
 	{ GDBUS_METHOD("SetDiscoveryFilter",
@@ -3438,6 +3848,10 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("ConnectDevice",
 				GDBUS_ARGS({ "properties", "a{sv}" }), NULL,
 				connect_device) },
+	{ GDBUS_METHOD("CreateServiceRecord",
+			GDBUS_ARGS({"record", "a{q(yuv)}"}),
+			GDBUS_ARGS({"handle", "u"}),
+			create_service_record)},
 	{ }
 };
 
-- 
2.24.1

