Return-Path: <SRS0=i/J9=5R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F7FC2D0F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 22:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CBA42078C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Apr 2020 22:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PnCInX5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbgDAWOs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 18:14:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33214 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732385AbgDAWOr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 18:14:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id ay1so553467plb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Apr 2020 15:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cnr8sX96FwFefBpNfK1OURK+QmvGZXJ+UB3/+cWm9+0=;
        b=PnCInX5HoKujI1CGrEwuDxvlEPW8Y06B8C3aR6HVi49EuJId51YTDlm+CuMz5le10O
         hM5HKKiiLUyT13/l4iqb9uHPEAjCNkaI/svdwuz4p3ncmUPQlqRPM7nAlGAiF2o6eeKy
         Ngbjk64uAXG8p+YuSgl0+CagYJX55O/WBKG8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cnr8sX96FwFefBpNfK1OURK+QmvGZXJ+UB3/+cWm9+0=;
        b=qW3R1kFPeHGZ9NnyHhLG81U+mR7Ft9iarnlQJdoP3XOy6XWMyPWVlCTCU1OZV2libF
         0THqSozEWrCbA7aHe2b6NgIiAxMwLK8Izsu6Urcg6h64ehyDenW1xbtnq46S3NNqyCDM
         ffZHqFp6itpjpEBNjF4RQVphOQM2JawCoCE6/S9Pgba9Iu9IpeKRwpq5ic05hXeWI+X0
         C3K0Rc0iUnoWxT/cq8q0vEzxU4gkVCCb8g8bvFEGGcnWMgFoCFf4jL5MxMtfNhrSSLtX
         sneEqCdSaB/YaeYXJSFIrcIPasVUjZhJ6SSOfdOJa8dHdROIHvD1QZpweXOCCLwWC8lU
         Mz3g==
X-Gm-Message-State: AGi0PuZ5p3/ZdXcKTTgTkcwUkS210/4LluMTvtme+B9ZKBUe5rJ+apdq
        2anBe5nLe4bGf5lcicOtBdD+3KUcDDc=
X-Google-Smtp-Source: APiQypKz0YdyJREgPJdwLP0+Ed/rW2NWFt10xhWU+IeLOvcMeGLP91yVKlohlbZ3rrVNVgvKYw7HWA==
X-Received: by 2002:a17:902:7583:: with SMTP id j3mr38895pll.196.1585779283933;
        Wed, 01 Apr 2020 15:14:43 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:b7e2:9910:bd78:608d])
        by smtp.gmail.com with ESMTPSA id z6sm2394666pjt.42.2020.04.01.15.14.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 15:14:43 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Miao Chou <mcchou@chromium.org>
Subject: [PATCH 2/5] Implement GetServiceRecords method
Date:   Wed,  1 Apr 2020 15:14:31 -0700
Message-Id: <20200401221434.12185-2-sonnysasaka@chromium.org>
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

This implements the GetServiceRecords method of org.bluez.Device1 interface.
---
 lib/sdp.h    |  13 +++
 src/device.c | 293 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 306 insertions(+)

diff --git a/lib/sdp.h b/lib/sdp.h
index f586eb5eb..c6fdf3d3a 100644
--- a/lib/sdp.h
+++ b/lib/sdp.h
@@ -396,6 +396,19 @@ extern "C" {
 #define SDP_URL_STR16		0x46
 #define SDP_URL_STR32		0x47
 
+/*
+ * These are Chromium specific SDP data types which map the above SDP datatype
+ * but without specifying the sizes of types.
+ */
+#define SDP_VAL_TYPE_NIL	0x00
+#define SDP_VAL_TYPE_UINT	0x01
+#define SDP_VAL_TYPE_INT	0x02
+#define SDP_VAL_TYPE_UUID	0x03
+#define SDP_VAL_TYPE_STRING	0x04
+#define SDP_VAL_TYPE_BOOL	0x05
+#define SDP_VAL_TYPE_SEQUENCE	0x06
+#define SDP_VAL_TYPE_URL	0x07
+
 /*
  * The PDU identifiers of SDP packets between client and server
  */
diff --git a/src/device.c b/src/device.c
index ace9c348c..1b5afc226 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2762,6 +2762,296 @@ static DBusMessage *cancel_pairing(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static dbus_bool_t append_attr_value(sdp_data_t* val,
+					DBusMessageIter *val_entry)
+{
+	DBusMessageIter val_struct;
+	DBusMessageIter val_variant;
+	DBusMessageIter val_seq_array;
+
+	uint8_t value_type;
+	void* value = NULL;
+	uint32_t value_size = (uint32_t) val->unitSize;
+	sdp_data_t *data;
+	char *str = NULL;
+
+	int type;
+	const char *type_sig;
+
+	if (!dbus_message_iter_open_container(val_entry, DBUS_TYPE_STRUCT,
+						NULL, &val_struct))
+		return FALSE;
+
+	switch (val->dtd) {
+	case SDP_DATA_NIL:
+		goto val_nil;
+	case SDP_BOOL:
+		value_type = SDP_VAL_TYPE_BOOL;
+		value = &val->val.uint8;
+		value_size = sizeof(uint8_t);
+		type_sig = DBUS_TYPE_BOOLEAN_AS_STRING;
+		type = DBUS_TYPE_BOOLEAN;
+		break;
+	case SDP_UINT8:
+		value_type = SDP_VAL_TYPE_UINT;
+		value = &val->val.uint8;
+		value_size = sizeof(uint8_t);
+		type_sig = DBUS_TYPE_BYTE_AS_STRING;
+		type = DBUS_TYPE_BYTE;
+		break;
+	case SDP_UINT16:
+		value_type = SDP_VAL_TYPE_UINT;
+		value = &val->val.uint16;
+		value_size = sizeof(uint16_t);
+		type_sig = DBUS_TYPE_UINT16_AS_STRING;
+		type = DBUS_TYPE_UINT16;
+		break;
+	case SDP_UINT32:
+		value_type = SDP_VAL_TYPE_UINT;
+		value = &val->val.uint32;
+		value_size = sizeof(uint32_t);
+		type_sig = DBUS_TYPE_UINT32_AS_STRING;
+		type = DBUS_TYPE_UINT32;
+		break;
+	case SDP_UINT64:
+		value_type = SDP_VAL_TYPE_UINT;
+		value = &val->val.uint64;
+		value_size = sizeof(uint64_t);
+		type_sig = DBUS_TYPE_UINT64_AS_STRING;
+		type = DBUS_TYPE_UINT64;
+		break;
+	case SDP_INT8:
+		value_type = SDP_VAL_TYPE_INT;
+		value = &val->val.int8;
+		value_size = sizeof(int8_t);
+		type_sig = DBUS_TYPE_BYTE_AS_STRING;
+		type = DBUS_TYPE_BYTE;
+		break;
+	case SDP_INT16:
+		value_type = SDP_VAL_TYPE_INT;
+		value = &val->val.int16;
+		value_size = sizeof(int16_t);
+		type_sig = DBUS_TYPE_INT16_AS_STRING;
+		type = DBUS_TYPE_INT16;
+		break;
+	case SDP_INT32:
+		value_type = SDP_VAL_TYPE_INT;
+		value = &val->val.int32;
+		value_size = sizeof(int32_t);
+		type_sig = DBUS_TYPE_INT32_AS_STRING;
+		type = DBUS_TYPE_INT32;
+		break;
+	case SDP_INT64:
+		value_type = SDP_VAL_TYPE_INT;
+		value = &val->val.int64;
+		value_size = sizeof(int64_t);
+		type_sig = DBUS_TYPE_INT64_AS_STRING;
+		type = DBUS_TYPE_INT64;
+		break;
+	case SDP_UUID16:
+	case SDP_UUID32:
+	case SDP_UUID128:
+		// Although a UUID is passed as a string in format
+		// "0000XXXX-0000-1000-8000-00805F9B34FB", |value_size|
+		// should hold the original length of a UUID. The length unit
+		// is byte, so a length can be 2, 4, 16.
+		if (val->dtd == SDP_UUID16)
+			value_size = sizeof(uint16_t);
+		else if (val->dtd == SDP_UUID32)
+			value_size = sizeof(uint32_t);
+		else
+			value_size = sizeof(uint128_t);
+		value_type = SDP_VAL_TYPE_UUID;
+		str = bt_uuid2string(&val->val.uuid);
+		value = &str;
+		type_sig = DBUS_TYPE_STRING_AS_STRING;
+		type = DBUS_TYPE_STRING;
+		break;
+	case SDP_TEXT_STR8:
+	case SDP_TEXT_STR16:
+	case SDP_TEXT_STR32:
+		// TODO(chromium:633929): Distinguish string and data array by
+		// checking if the given string is in UTF-8 format or not. For
+		// now the binary case is skipped by setting |str| as a empty
+		// string.
+		str = val->val.str;
+		if (!dbus_validate_utf8(str, NULL))
+			str = "";
+		value_size = strlen(str);
+		value_type = SDP_VAL_TYPE_STRING;
+		value = &str;
+		type_sig = DBUS_TYPE_STRING_AS_STRING;
+		type = DBUS_TYPE_STRING;
+		break;
+	case SDP_URL_STR8:
+	case SDP_URL_STR16:
+	case SDP_URL_STR32:
+		value_type = SDP_VAL_TYPE_URL;
+		str = val->val.str;
+		value_size = strlen(str);
+		value = &str;
+		type_sig = DBUS_TYPE_STRING_AS_STRING;
+		type = DBUS_TYPE_STRING;
+		break;
+	case SDP_ALT8:
+	case SDP_ALT16:
+	case SDP_ALT32:
+	case SDP_SEQ8:
+	case SDP_SEQ16:
+	case SDP_SEQ32: {
+		uint32_t size = 0;
+
+		value_type = SDP_VAL_TYPE_SEQUENCE;
+
+		// Calculate the number of elements in the sequence.
+		for (data = val->val.dataseq; data; data = data->next)
+			size++;
+
+		if (!dbus_message_iter_append_basic(&val_struct,
+						DBUS_TYPE_BYTE, &value_type))
+			return FALSE;
+		if (!dbus_message_iter_append_basic(&val_struct,
+						DBUS_TYPE_UINT32, &size))
+			return FALSE;
+		if (!dbus_message_iter_open_container(&val_struct,
+				DBUS_TYPE_VARIANT, "a(yuv)", &val_variant))
+			return FALSE;
+		if (!dbus_message_iter_open_container(&val_variant,
+				DBUS_TYPE_ARRAY, "(yuv)", &val_seq_array))
+			return FALSE;
+
+		for (data = val->val.dataseq; data; data = data->next)
+			append_attr_value(data, &val_seq_array);
+
+		if (!dbus_message_iter_close_container(&val_variant,
+							&val_seq_array))
+			return FALSE;
+		if (!dbus_message_iter_close_container(&val_struct,
+							&val_variant))
+			return FALSE;
+		goto done;
+	}
+	default:
+		goto val_nil;
+	}
+
+	if (!dbus_message_iter_append_basic(&val_struct,
+						DBUS_TYPE_BYTE, &value_type))
+		goto failed_to_append;
+	if (!dbus_message_iter_append_basic(&val_struct,
+						DBUS_TYPE_UINT32, &value_size))
+		goto failed_to_append;
+	if (!dbus_message_iter_open_container(&val_struct, DBUS_TYPE_VARIANT,
+						type_sig, &val_variant))
+		goto failed_to_append;
+	if (!dbus_message_iter_append_basic(&val_variant, type, value))
+		goto failed_to_append;
+
+	if (value_type == SDP_VAL_TYPE_UUID)
+		free(str);
+
+	if (!dbus_message_iter_close_container(&val_struct, &val_variant))
+		return FALSE;
+
+val_nil:
+done:
+	if (!dbus_message_iter_close_container(val_entry, &val_struct))
+		return FALSE;
+	return TRUE;
+
+failed_to_append:
+	if (value_type == SDP_VAL_TYPE_UUID)
+		free(str);
+	return FALSE;
+}
+
+static dbus_bool_t append_attr(sdp_data_t *attr, DBusMessageIter *attr_dict)
+{
+	DBusMessageIter attr_entry;
+
+	if (!dbus_message_iter_open_container(attr_dict, DBUS_TYPE_DICT_ENTRY,
+				NULL, &attr_entry))
+		return FALSE;
+
+	if (!dbus_message_iter_append_basic(&attr_entry, DBUS_TYPE_UINT16,
+						&attr->attrId))
+		return FALSE;
+
+	if (!append_attr_value(attr, &attr_entry))
+		return FALSE;
+
+	if (!dbus_message_iter_close_container(attr_dict, &attr_entry))
+		return FALSE;
+
+	return TRUE;
+}
+
+static dbus_bool_t append_record(const sdp_record_t *rec,
+					DBusMessageIter *attr_array)
+{
+	sdp_list_t *seq;
+	DBusMessageIter attr_dict;
+
+	if (!dbus_message_iter_open_container(attr_array, DBUS_TYPE_ARRAY,
+						"{q(yuv)}", &attr_dict))
+		return FALSE;
+
+	for (seq = rec->attrlist; seq; seq = seq->next) {
+		sdp_data_t *attr = (sdp_data_t *) seq->data;
+		if (!append_attr(attr, &attr_dict))
+			return FALSE;
+	}
+
+	if (!dbus_message_iter_close_container(attr_array, &attr_dict))
+		return FALSE;
+
+	return TRUE;
+}
+
+static DBusMessage *get_service_records(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct btd_device *dev = data;
+	sdp_list_t *seq;
+	DBusMessage *reply;
+	DBusMessageIter rec_array;
+	DBusMessageIter attr_array;
+
+	if (!btd_adapter_get_powered(dev->adapter))
+		return btd_error_not_ready(msg);
+
+	if (!btd_device_is_connected(dev))
+		return btd_error_not_connected(msg);
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return btd_error_failed(msg, "Failed to create method reply");
+
+	/* Load records from storage if there is nothing in cache */
+	if (!dev->tmp_records)
+		return btd_error_failed(msg, "SDP record not found");
+
+	dbus_message_iter_init_append(reply, &rec_array);
+
+	if (!dbus_message_iter_open_container(&rec_array, DBUS_TYPE_ARRAY,
+						"a{q(yuv)}", &attr_array))
+		return FALSE;
+
+	for (seq = dev->tmp_records; seq; seq = seq->next) {
+		sdp_record_t *rec = (sdp_record_t *) seq->data;
+		if (!rec)
+			continue;
+		if (!append_record(rec, &attr_array))
+			return btd_error_failed(msg,
+						"SDP record attachment failed");
+	}
+
+	if (!dbus_message_iter_close_container(&rec_array, &attr_array))
+		return FALSE;
+
+	return reply;
+}
+
 static const GDBusMethodTable device_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, dev_disconnect) },
 	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, dev_connect) },
@@ -2771,6 +3061,9 @@ static const GDBusMethodTable device_methods[] = {
 						NULL, disconnect_profile) },
 	{ GDBUS_ASYNC_METHOD("Pair", NULL, NULL, pair_device) },
 	{ GDBUS_METHOD("CancelPairing", NULL, NULL, cancel_pairing) },
+	{ GDBUS_ASYNC_METHOD("GetServiceRecords", NULL,
+			GDBUS_ARGS({"records", "aa{q(yuv)}"}),
+			get_service_records) },
 	{ }
 };
 
-- 
2.24.1

