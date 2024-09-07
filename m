Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD0715AAC8
	for <linux-bluetooth@vger.kernel.org>; Sat,  7 Sep 2024 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725744791; cv=none; b=dtL2WWf+OmJqVUfLZB8fhFZe2cpvJoI0FgIcTqLqTweeN39wHx6uqlKmdcH4V94BSoyDTZ2LxwWe6TQ/uvRWuUvLLv/Av2jYEjrmGLtdzGSILSlDP1fRzKVfikjG85ZBwSXar6hGdTuBS6rM4sjg//f9yQc4trcfNvGgXJpytxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725744791; c=relaxed/simple;
	bh=0OyBCVtRngUMYpqK2RrtQo+A0NjEZ6EERZPEqFdwCq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkuJjXkhIc3m2uHr/TCYKeamIEQ3pPMZznf9dbLcWsnuecCbsLEwEHIv3mkUzJFy/qIG21vxd2OrwR857owP3kUX++5q1BWG9R1OtLLx2aClUaro2lN+QezeuzaiaBaNKiIisAa7iQ1bQGsZ5J0TXRWY4/P9FWkIbaeG21pJXcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EQTAI+wM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQTAI+wM"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2055136b612so36428695ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 Sep 2024 14:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725744789; x=1726349589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=te18yLnr7D6dun2xhLOm/i/WdeDqS/oy1PpACfSuLlQ=;
        b=EQTAI+wM8dDS0+Nw0qqYFrZUY7Ne1zAt5E30TVcwx80IyhJPbF7pmUTGbCnqEG2L9M
         LdxNsKrpe4ehS1b3j8tLd8sMr8J+whEB/1YbH73lIPKQjKnJSmvDa2dsvEsyN/HlYegN
         3kcYoPMQPCymS43jtaaZbkfkov4bWV85WqzAUUURv6pxrFblJ9oJSKexA2ddEZE6PRgH
         7bBIFy2yJtGnq4QrgH0S0q3BP9fTKE1Jb93J+4UfikNQjalix23MyvmjzRJyesbJZo6z
         ayHd3+5AUYYUc3QbqFUM+rycmmuXkx8kIGbgzTZSIGKBijjMWnyfnjlL/+f66/Io4aH3
         d+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725744789; x=1726349589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te18yLnr7D6dun2xhLOm/i/WdeDqS/oy1PpACfSuLlQ=;
        b=dJ2+MdXS29LQ22PAM4Sr4TKWhTSaoAtM8Fr9bR7btUZFHFhOO7kUrSDrbTYN4oCJyD
         2C66d06ATRkUUw53/1DTe+AH7Bkx2U/2X5HbVPxaxZBo5yH1oaeCPFxYuEkDUXRvONRl
         26oPzmGBnFwU0TpT0BxC4r9AEUkESjt+rxT6vXLs7XMTvlM0gjWzZfuRAJc7zCTLEw5f
         C3w3nJhCxzld/daS/rgZP+XlHZT9p/plAMSg8G7CZOiseghrPRnCnzV3gz8Vx+teNWH8
         88aIl1wOGykaCfZraHOgcQ1UxobpkDsUCfWVXjjXLXxXXHes4BVh1qgVopL+cZXx2jc9
         AQ0g==
X-Gm-Message-State: AOJu0Yz3nJfRH6fbhM+8PzlSdPpVHSDpl52rAw+gDW+O2KC742GuKSvU
	b0WmMXnej2LXLOJEoPV0O7DTut2E62RnJvxoFTvT1TeoEbrO80alvXyJGg==
X-Google-Smtp-Source: AGHT+IHVZsOyTSwsY4wXlQSE6SC192OUtXfyqzs+l8LYaHWcnYMm5Eswc+no9ZslN/pEpBs1/t9IHg==
X-Received: by 2002:a17:902:d505:b0:203:a116:7953 with SMTP id d9443c01a7336-206f04c9d83mr105800595ad.10.1725744788726;
        Sat, 07 Sep 2024 14:33:08 -0700 (PDT)
Received: from vibhavp-an515-58.lan ([2401:4900:1c62:13d2:d7f9:63c9:9aab:1368])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8241be950sm1229781a12.44.2024.09.07.14.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 14:33:08 -0700 (PDT)
From: Vibhav Pant <vibhavp@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vibhav Pant <vibhavp@gmail.com>
Subject: [PATCH BlueZ 1/2] device: Add method GetServiceRecords
Date: Sun,  8 Sep 2024 03:03:00 +0530
Message-ID: <20240907213301.14000-2-vibhavp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240907213301.14000-1-vibhavp@gmail.com>
References: <20240907213301.14000-1-vibhavp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GetServiceRecords returns all currently known BR/EDR service records
for the device, as an array of array of bytes. Each individual byte
array represents a raw SDP record, as defined by the Bluetooth Service
Discovery Protocol spec.
This method is intended to be only used by compatibility layers like
Wine, that need to provide access to raw SDP records to implement the
Win32 Bluetooth API. Applications should instead use the Profile API
for services-related functionality.
---
 src/device.c | 83 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/src/device.c b/src/device.c
index 0f18c8c7f..6aa809c80 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3215,6 +3215,86 @@ static DBusMessage *cancel_pairing(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static sdp_list_t *read_device_records(struct btd_device *device);
+
+static DBusMessage *get_service_records(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	DBusMessage *reply;
+	DBusMessageIter records_arr, record;
+	struct btd_device *device = data;
+	sdp_list_t *cur;
+
+	if (!btd_adapter_get_powered(device->adapter))
+		return btd_error_not_ready(msg);
+
+	if (!btd_device_is_connected(device))
+		return btd_error_not_connected(msg);
+
+	if (!device->bredr_state.svc_resolved)
+		return btd_error_not_ready(msg);
+
+	if (!device->tmp_records) {
+		device->tmp_records = read_device_records(device);
+		if (!device->tmp_records)
+			return btd_error_does_not_exist(msg);
+	}
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return btd_error_failed(msg, "Could not create method reply");
+
+	dbus_message_iter_init_append(reply, &records_arr);
+	if (!dbus_message_iter_open_container(&records_arr, DBUS_TYPE_ARRAY,
+					      "ay", &record)) {
+		dbus_message_unref(reply);
+		return btd_error_failed(msg, "Could not initialize iterator");
+	}
+
+	for (cur = device->tmp_records; cur; cur = cur->next) {
+		DBusMessageIter record_bytes;
+		sdp_record_t *rec = cur->data;
+		sdp_buf_t buf;
+		int result;
+
+		result = sdp_gen_record_pdu(rec, &buf);
+		if (result) {
+			dbus_message_iter_abandon_container(&records_arr,
+							    &record);
+			dbus_message_unref(reply);
+			return btd_error_failed(
+				msg, "Could not marshal service record");
+		}
+		if (!dbus_message_iter_open_container(&record, DBUS_TYPE_ARRAY,
+						      "y", &record_bytes)) {
+			bt_free(buf.data);
+			dbus_message_iter_abandon_container(&records_arr,
+							    &record);
+			dbus_message_unref(reply);
+			return btd_error_failed(
+				msg, "Could not initialize iterator");
+		}
+		if (!dbus_message_iter_append_fixed_array(
+			    &record_bytes, DBUS_TYPE_BYTE, &buf.data,
+			    buf.data_size)) {
+			bt_free(buf.data);
+			dbus_message_iter_abandon_container(&record,
+							    &record_bytes);
+			dbus_message_iter_abandon_container(&records_arr,
+							    &record);
+			dbus_message_unref(reply);
+			return btd_error_failed(
+				msg, "Could not append record data to reply");
+		}
+		dbus_message_iter_close_container(&record, &record_bytes);
+		bt_free(buf.data);
+	}
+
+	dbus_message_iter_close_container(&records_arr, &record);
+
+	return reply;
+}
+
 static const GDBusMethodTable device_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, dev_disconnect) },
 	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, dev_connect) },
@@ -3224,6 +3304,9 @@ static const GDBusMethodTable device_methods[] = {
 						NULL, disconnect_profile) },
 	{ GDBUS_ASYNC_METHOD("Pair", NULL, NULL, pair_device) },
 	{ GDBUS_METHOD("CancelPairing", NULL, NULL, cancel_pairing) },
+	{ GDBUS_EXPERIMENTAL_METHOD("GetServiceRecords", NULL,
+				    GDBUS_ARGS({ "Records", "aay" }),
+				    get_service_records) },
 	{ }
 };
 
-- 
2.46.0

