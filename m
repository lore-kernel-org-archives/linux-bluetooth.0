Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A31812836A
	for <linux-bluetooth@vger.kernel.org>; Wed,  8 May 2024 15:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183177; cv=none; b=MSWyhYZDp4PflIxIefun5anzr/e01filhwvaNf1hUPFC+8jqvI+FMUmymQsb0uNrlUi6jVtA63K6fl09bNVVYFH5Q/dzlaVW73ns7BqvV8pAoihyathyFg7BYuwba3sQqbulv9HgVCirRd9R4lbWNJ7rlEoRNVrzOCZBaZY8ojA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183177; c=relaxed/simple;
	bh=qjoqmkW5BwDTnAc03MbNt7KdI8uD+mLMJxTKw9oHdLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yj9G0O1sR1pSHqPyCrmj6sPVKKmWUUkoZ0dMhk0H/NpJ274nnvzRxY/70kO0Q5usHZifa3OOIPf9pIDxtZ//sBHAgM3HdZY1GEHrXR2aNNUgKygSaZ8xt7bdgZOegeLzBEcosxU0yXMriZRWB2ytYCS5DdXlrvtIw10tCCRkh4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=eIYTYaiH; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="eIYTYaiH"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43ae9962c17so13285591cf.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 May 2024 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1715183174; x=1715787974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aipf2HOsl81RhQIqSKDgR4j/JsalsFZkCBYK1tn5rFo=;
        b=eIYTYaiHW8QmGyCi/A0GUsfontJd0UqbBETmghHDPed+JQzH6MEt4c2zyTbxA6sHOp
         P4NHM//+VPQKd/sEFaXUSwRmG+O9IxMm10Y8f7N6t8v8NXHlow7H0tUuDlWXKzUaDoNl
         sjs9dRdxh+7iTWt2d7lSXe0t55mQbMIRVsLKExCdw0o7YjtT3sMzoyLxvYKYaBN/dUQN
         +WzvxJWBVJEyTPFoFnRe9AHoD9Qv56+t73wzUcVqK2NeSgCXQ6vQfEO7RH0x8Q62Eyll
         lc3RgaYSWXVekRYXruEeSN7xbwO6nsrcXE5Hc/sOd4Xofybi6uysrVFf1aT5JaBdHyf5
         i1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715183174; x=1715787974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aipf2HOsl81RhQIqSKDgR4j/JsalsFZkCBYK1tn5rFo=;
        b=oSQM1FdGWms2po8VCL9M8YeCgLIgLDQMIuLQ2SqZdHYLrYmERE0iED1HoWNoON/ug9
         YgDICpGBCPgj0vw7+RoYyo25gjFsO9UWaL026U40yytthwe86Am2OZZvs+Lup5Ge5m+8
         nrrMTVUqXtIt2CISkvC1uhkABrIzvgGRQnblOrQwX78GiumWbdd1/1FNvHinZxrSmk5e
         vEUQtgvOqpfdj4nShcnm55aS/1SHomGMYy/8kv0doBpF6ZXJK/ctq9QX9Q9iUDUbspPK
         pQYSDi9WwXJTI0KMnwS8j2Tl3XM1M5WLHnesCQeYGNLiamGagQMwqQzXkU1+JPSZhFmt
         e+VA==
X-Gm-Message-State: AOJu0YwpQYShuSpn8MZy2WWl9cowUxuJgLa4AieV1QPhXqrPHsqq2NNK
	d1Odgvmmy5TcUhwOUDvDqAHsFM/yKyvuP1HHBmvksvbjG3BcQ5V+k6kGymBwRzylre2wbnpVTh+
	v
X-Google-Smtp-Source: AGHT+IFotrZyIAUqayZc9/YrXIBsuzz3yy0gdM/mQaw9HlldKXnM4gEzGEgGqTuJK/3P781oRRNVgQ==
X-Received: by 2002:a05:622a:d3:b0:43a:ed55:f3a9 with SMTP id d75a77b69052e-43dbed3b59bmr33956271cf.30.1715183173855;
        Wed, 08 May 2024 08:46:13 -0700 (PDT)
Received: from andromeda.lan (bras-base-toroon0359w-grc-19-74-15-47-99.dsl.bell.ca. [74.15.47.99])
        by smtp.gmail.com with ESMTPSA id cd14-20020a05622a418e00b0043791f7d831sm7756513qtb.63.2024.05.08.08.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:46:13 -0700 (PDT)
From: Arun Raghavan <arun@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ 2/5] asha: Implement volume on transport
Date: Wed,  8 May 2024 11:46:01 -0400
Message-ID: <20240508154604.276763-3-arun@asymptotic.io>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508154604.276763-1-arun@asymptotic.io>
References: <20240508154604.276763-1-arun@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We convert from the spec definition of the range to the DBus API range
to make it easier for clients to not have to worry about that detail,
and share an implementation with other uses of MediaTransport1.
---
 profiles/audio/asha.c      | 88 +++++++++++++++++++++++++++++++++++---
 profiles/audio/asha.h      |  4 ++
 profiles/audio/transport.c | 28 +++++++++++-
 3 files changed, 112 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
index c6769038f..a372e0db3 100644
--- a/profiles/audio/asha.c
+++ b/profiles/audio/asha.c
@@ -65,7 +65,9 @@ struct asha_device {
 	struct gatt_db *db;
 	struct gatt_db_attribute *attr;
 	uint16_t acp_handle;
-	unsigned int notify_id;
+	uint16_t volume_handle;
+	unsigned int status_notify_id;
+	unsigned int volume_notify_id;
 
 	uint16_t psm;
 	bool right_side;
@@ -75,6 +77,7 @@ struct asha_device {
 	uint8_t hisyncid[8];
 	uint16_t render_delay;
 	uint16_t codec_ids;
+	int8_t volume;
 
 	struct media_transport *transport;
 	int fd;
@@ -95,9 +98,15 @@ static struct asha_device *asha_device_new(void)
 
 static void asha_device_reset(struct asha_device *asha)
 {
-	if (asha->notify_id)
+	if (asha->status_notify_id) {
 		bt_gatt_client_unregister_notify(asha->client,
-				asha->notify_id);
+						asha->status_notify_id);
+	}
+
+	if (asha->volume_notify_id) {
+		bt_gatt_client_unregister_notify(asha->client,
+						asha->volume_notify_id);
+	}
 
 	gatt_db_unref(asha->db);
 	asha->db = NULL;
@@ -244,6 +253,7 @@ unsigned int asha_device_start(struct asha_device *asha, asha_cb_t cb,
 		0x01, // START
 		0x01, // G.722, 16 kHz
 		0,   // Unknown media type
+		asha->volume, // Volume
 		0,   // Other disconnected
 	};
 	int ret;
@@ -290,6 +300,24 @@ unsigned int asha_device_stop(struct asha_device *asha, asha_cb_t cb,
 	return asha->resume_id;
 }
 
+int8_t asha_device_get_volume(struct asha_device *asha)
+{
+	return asha->volume;
+}
+
+bool asha_device_set_volume(struct asha_device *asha, int8_t volume)
+{
+	if (!bt_gatt_client_write_value(asha->client, asha->volume_handle,
+				(const uint8_t *)&volume, 1, NULL, NULL,
+				NULL)) {
+		error("Error writing ACP start");
+		return false;
+	}
+
+	asha->volume = volume;
+	return true;
+}
+
 static char *make_endpoint_path(struct asha_device *asha)
 {
 	char *path;
@@ -410,6 +438,39 @@ void audio_status_notify(uint16_t value_handle, const uint8_t *value,
 	}
 }
 
+static void read_volume(bool success,
+			uint8_t att_ecode,
+			const uint8_t *value,
+			uint16_t length,
+			void *user_data)
+{
+	struct asha_device *asha = user_data;
+
+	if (!success) {
+		DBG("Reading volume failed with ATT errror: %u", att_ecode);
+		return;
+	}
+
+	if (length != 2) {
+		DBG("Reading volume failed: unexpected length %u", length);
+		return;
+	}
+
+	asha->volume = get_s8(value);
+
+	DBG("Got volume: %d", asha->volume);
+}
+
+void volume_notify(uint16_t value_handle, const uint8_t *value,
+					uint16_t length, void *user_data)
+{
+	struct asha_device *asha = user_data;
+
+	asha->volume = get_s8(value);
+
+	DBG("Volume changed: %d", asha->volume);
+}
+
 static void handle_characteristic(struct gatt_db_attribute *attr,
 								void *user_data)
 {
@@ -430,16 +491,29 @@ static void handle_characteristic(struct gatt_db_attribute *attr,
 	} if (uuid_cmp(ASHA_CHRC_READ_ONLY_PROPERTIES_UUID, &uuid)) {
 		if (!bt_gatt_client_read_value(asha->client, value_handle,
 					read_rops, asha, NULL))
-			DBG("Failed to send request to read battery level");
+			DBG("Failed to send request for readonly properties");
 	} if (uuid_cmp(ASHA_CHRC_AUDIO_CONTROL_POINT_UUID, &uuid)) {
 		// Store this for later writes
 		asha->acp_handle = value_handle;
+	} if (uuid_cmp(ASHA_CHRC_VOLUME_UUID, &uuid)) {
+		// Store this for later reads and writes
+		asha->volume_handle = value_handle;
+		asha->volume_notify_id =
+			bt_gatt_client_register_notify(asha->client,
+				value_handle, NULL, volume_notify, asha,
+				NULL);
+		if (!asha->status_notify_id)
+			DBG("Failed to send request to notify volume");
+		if (!bt_gatt_client_read_value(asha->client, value_handle,
+					read_volume, asha, NULL))
+			DBG("Failed to send request to volume");
 	} if (uuid_cmp(ASHA_CHRC_AUDIO_STATUS_UUID, &uuid)) {
-		asha->notify_id = bt_gatt_client_register_notify(asha->client,
+		asha->status_notify_id =
+			bt_gatt_client_register_notify(asha->client,
 				value_handle, NULL, audio_status_notify, asha,
 				NULL);
-		if (!asha->notify_id)
-			DBG("Failed to send request to read battery level");
+		if (!asha->status_notify_id)
+			DBG("Failed to send request to notify AudioStatus");
 	} else {
 		char uuid_str[MAX_LEN_UUID_STR];
 
diff --git a/profiles/audio/asha.h b/profiles/audio/asha.h
index 0fc28e8a3..20bcaa65b 100644
--- a/profiles/audio/asha.h
+++ b/profiles/audio/asha.h
@@ -10,6 +10,7 @@
  *
  */
 
+#include <stdbool.h>
 #include <stdint.h>
 
 struct asha_device;
@@ -32,3 +33,6 @@ unsigned int asha_device_start(struct asha_device *asha, asha_cb_t cb,
 		void *user_data);
 unsigned int asha_device_stop(struct asha_device *asha, asha_cb_t cb,
 		void *user_data);
+
+int8_t asha_device_get_volume(struct asha_device *asha);
+bool asha_device_set_volume(struct asha_device *asha, int8_t volume);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index a104d27c0..b85d96914 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1841,6 +1841,32 @@ static guint transport_asha_suspend(struct media_transport *transport,
 	return ret;
 }
 
+static int8_t transport_asha_get_volume(struct media_transport *transport)
+{
+	struct asha_device *asha = transport->data;
+	int8_t volume;
+	int scaled_volume;
+
+	volume = asha_device_get_volume(asha);
+
+	// Convert -128-0 to 0-127
+	scaled_volume = ((((int) volume) + 128) * 127) / 128;
+
+	return scaled_volume;
+}
+
+static int transport_asha_set_volume(struct media_transport *transport,
+					int8_t volume)
+{
+	struct asha_device *asha = transport->data;
+	int scaled_volume;
+
+	// Convert 0-127 to -128-0
+	scaled_volume = ((((int) volume) * 128) / 127) - 128;
+
+	return asha_device_set_volume(asha, scaled_volume) ? 0 : -EIO;
+}
+
 static void *transport_asha_init(struct media_transport *transport, void *data)
 {
 	/* We just store the struct asha_device on the transport */
@@ -1893,7 +1919,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_asha_init, \
 			transport_asha_resume, transport_asha_suspend, \
 			NULL, NULL, NULL, \
-			NULL, NULL, \
+			transport_asha_get_volume, transport_asha_set_volume, \
 			NULL)
 
 static const struct media_transport_ops transport_ops[] = {
-- 
2.45.0

