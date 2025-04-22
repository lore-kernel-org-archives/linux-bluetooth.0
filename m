Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF91A76DE
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Apr 2025 05:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745300773; cv=none; b=NU83h2SAGmqWYO3TLELk0XBYkfh7uuBV9tgWYU3HA9gqrWdvO8pa1Pc0JIomfpWCZqzUpzk3HPPwnmTa7wf7WCWdeheWrUfhImHKZ1iQjuBnlayjlsm/I1f5Lwo8oH108PT7ba3JDiVkIkSPFz6ol6Xb3D4V0so0xt8jRdBODOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745300773; c=relaxed/simple;
	bh=WJyRHJYySj52Or/w6Up1DwBR6bV7HNKzPklle7usGXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjWNPEHbhIpLf+bXothlHYWV5PF17O04GxSb8EBTHouLAhnyePRKmkFPpqmSYZTRF+7Kjv06c+neIRGOTzNuOzqRI47mLjfBYMjpRNjbs2LSdkGWTFWwyNisjdTgd46c6dLVSluyM4NGTqYnXpiaAc5HY4y03SU/Iy73H434Wrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=BRBffstz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="BRBffstz"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2255003f4c6so52425875ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Apr 2025 22:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1745300771; x=1745905571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RREQK8DchZaO9ulBsCN4q0uW7t8LYMa5fy+ibbMstJg=;
        b=BRBffstzVEgNLmaH7V7YQRAH/tfEBrG1VfIT87MRR1J57b2MTu+HsptBgEI3DlQSN6
         BDduDBGvijaniumhCtw4Otu9Huq41h93zBxO71X95QSA1tn5zdmj2O8EJvfy1+2uK0+x
         YVcYAk12BajlvgxIJVF6s9Fvqu28kKxVX+evn2y06eGtIgnSlTIjrpWyMiv0GhW5AjWH
         JtUd73UVudtxHGwxyFamaPPnv+Xw0cl7LOAH9vrFD0+0ZeM373lgSPd5vLXgdbFfTzVu
         qgzODI/yzNygQXWZEsE5UkfUyDMjRnc4ZdA1Kj1s4WcECKIFaJZqdDAiscOmtEdc35zY
         WW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745300771; x=1745905571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RREQK8DchZaO9ulBsCN4q0uW7t8LYMa5fy+ibbMstJg=;
        b=fcsYcrVVcui8O2j2Cb1ADXqiPjqI/iDjf85rqx3GDPpaEoNVKKO/uvL7VZE9KBe1eW
         nixNZE994uZHRNWFbCA88b/JYWLvT3TzIK+QJoWnMWkY+jAvepCFVcFmFCc2zsrukKWK
         BUfYEhYEiLJR8thsNNHw5ZnWqZkSnlx++yU/wa0ZID5My35qsvTdaZ9Nh/H9K8EPhIYU
         fxSwg+hjAqLuGVnLn8k5/l/59MueVAZgbAe8pDiTWBOEJ/EG2KJtJvov6ntWynw9uOvR
         nO3xUi3ZZIAd5HnMzWQ6NIqgYeh7hVtFpB/Vpn7bdoFJiRmLYVZ/yINbVwKHGEQsNtOa
         mvWg==
X-Gm-Message-State: AOJu0YwsfkJoxRtm7j1klN2zsCuQcHjV9P5X1W9bqQDG4r10gNdwotcs
	4BlLnMACuh8OKTSAC2KEeBpf25pEl9Fpm+awYq7GFQTWUxPq4wYmybIxjHShhqbSJhCY0HccObP
	v
X-Gm-Gg: ASbGnctxiHbXoP5qO1G+4CWFCGCM5tIUyA/wPRw9PVBu+eEBjqsrButNwcWF8w2/2Rt
	1KKonMsErGrY4Z0j16QTVT89Z1jsoXECdk8/mY5SFHgVpoBswQXxS5RibyVJmZJbr1DCw0wX2Jt
	bcJSEqsBJKLVjoVa4NvnNy/5PoHLU5R81PXMlo7kR5NAPS2LruDFfYi+PcsjlOLTM0Z1jin8xbA
	cuxz2yqXhU5dNpB4J7NOyWVhoZd0q5A+HNTCor7DByBDGbOhaZQiNJPfla8nCmdCzNUtp/Dqik+
	go82uo6qEwjyVMDj70qI203pL57bbDJTo7nx7IUzX+7lAw==
X-Google-Smtp-Source: AGHT+IGyOGtDia7Le40ZNqq5KAbcQ47cacIsTVzmK1zSzD9OYr76kSKnrZDags13MjWXrNALfpcBFA==
X-Received: by 2002:a17:903:3c6b:b0:223:fb3a:8631 with SMTP id d9443c01a7336-22c535b45b5mr253447785ad.24.1745300770741;
        Mon, 21 Apr 2025 22:46:10 -0700 (PDT)
Received: from localhost ([2401:4900:1cba:4d5f:668:74ff:fe9f:7991])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50bde206sm76008045ad.14.2025.04.21.22.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 22:46:10 -0700 (PDT)
From: Sanchayan Maity <sanchayan@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>
Subject: [PATCH BlueZ 2/2] profiles/audio: asha: Only expose device after we have attributes
Date: Tue, 22 Apr 2025 11:15:47 +0530
Message-ID: <20250422054547.132400-3-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250422054547.132400-1-sanchayan@asymptotic.io>
References: <20250422054547.132400-1-sanchayan@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arun Raghavan <arun@asymptotic.io>

Let's get the PSM and read-only properties before we expose the device
and transport.
---
 profiles/audio/asha.c |  6 +++---
 src/shared/asha.c     | 30 +++++++++++++++++++++++++++++-
 src/shared/asha.h     |  7 ++++++-
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
index df283dd22..39c165855 100644
--- a/profiles/audio/asha.c
+++ b/profiles/audio/asha.c
@@ -451,24 +451,24 @@ static int asha_source_accept(struct btd_service *service)
 
 	ba2str(device_get_address(device), addr);
 	DBG("Accepting ASHA connection on %s", addr);
 
 	if (!asha_dev) {
 		/* Can this actually happen? */
 		DBG("Not handling ASHA profile");
 		return -1;
 	}
 
-	if (!bt_asha_probe(asha_dev->asha, db, client))
+	if (!bt_asha_probe(asha_dev->asha, db, client,
+		(bt_asha_probe_cb_t) asha_source_endpoint_register, asha_dev)) {
 		return -1;
-
-	asha_source_endpoint_register(asha_dev);
+	}
 
 	btd_service_connecting_complete(service, 0);
 
 	return 0;
 }
 
 static int asha_source_disconnect(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct bt_asha_device *asha_dev = btd_service_get_user_data(service);
diff --git a/src/shared/asha.c b/src/shared/asha.c
index e7bba4cc4..4033a4386 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -168,20 +168,24 @@ void bt_asha_reset(struct bt_asha *asha)
 						asha->status_notify_id);
 	}
 
 	gatt_db_unref(asha->db);
 	asha->db = NULL;
 
 	bt_gatt_client_unref(asha->client);
 	asha->client = NULL;
 
 	asha->psm = 0;
+	memset(asha->hisyncid, 0, sizeof(asha->hisyncid));
+
+	asha->probe_cb = NULL;
+	asha->probe_cb_data = NULL;
 
 	update_asha_set(asha, false);
 }
 
 void bt_asha_state_reset(struct bt_asha *asha)
 {
 	asha->state = ASHA_STOPPED;
 
 	asha->cb = NULL;
 	asha->cb_user_data = NULL;
@@ -326,41 +330,59 @@ bool bt_asha_set_volume(struct bt_asha *asha, int8_t volume)
 
 static bool uuid_cmp(const char *uuid1, const bt_uuid_t *uuid2)
 {
 	bt_uuid_t lhs;
 
 	bt_string_to_uuid(&lhs, uuid1);
 
 	return bt_uuid_cmp(&lhs, uuid2) == 0;
 }
 
+static void check_probe_done(struct bt_asha *asha)
+{
+	uint8_t zeroes[8] = { 0, };
+
+	/* Once we have ROPs & PSM, we should be good to go */
+	if (asha->psm == 0 ||
+		memcmp(asha->hisyncid, zeroes, sizeof(zeroes) == 0))
+		return;
+
+	if (asha->probe_cb) {
+		asha->probe_cb(asha->probe_cb_data);
+		asha->probe_cb = NULL;
+		asha->probe_cb_data = NULL;
+	}
+}
+
 static void read_psm(bool success,
 			uint8_t att_ecode,
 			const uint8_t *value,
 			uint16_t length,
 			void *user_data)
 {
 	struct bt_asha *asha = user_data;
 
 	if (!success) {
 		DBG("Reading PSM failed with ATT error: %u", att_ecode);
 		return;
 	}
 
 	if (length != 2) {
 		DBG("Reading PSM failed: unexpected length %u", length);
 		return;
 	}
 
 	asha->psm = get_le16(value);
 
 	DBG("Got PSM: %u", asha->psm);
+
+	check_probe_done(asha);
 }
 
 static void read_rops(bool success,
 			uint8_t att_ecode,
 			const uint8_t *value,
 			uint16_t length,
 			void *user_data)
 {
 	struct bt_asha *asha = user_data;
 
@@ -391,20 +413,22 @@ static void read_rops(bool success,
 	asha->render_delay = get_le16(&value[11]);
 	/* byte 13 & 14 are reserved */
 	/* Codec IDs */
 	asha->codec_ids = get_le16(&value[15]);
 
 	DBG("Got ROPS: side %u, binaural %u, csis: %u, delay %u, codecs: %u",
 			asha->right_side, asha->binaural, asha->csis_supported,
 			asha->render_delay, asha->codec_ids);
 
 	update_asha_set(asha, true);
+
+	check_probe_done(asha);
 }
 
 static void audio_status_register(uint16_t att_ecode, void *user_data)
 {
 	if (att_ecode)
 		DBG("AudioStatusPoint register failed 0x%04x", att_ecode);
 	else
 		DBG("AudioStatusPoint register succeeded");
 }
 
@@ -493,27 +517,31 @@ static void foreach_asha_service(struct gatt_db_attribute *attr,
 	struct bt_asha *asha = user_data;
 
 	DBG("Found ASHA GATT service");
 
 	asha->attr = attr;
 	gatt_db_service_set_claimed(attr, true);
 	gatt_db_service_foreach_char(asha->attr, handle_characteristic, asha);
 }
 
 bool bt_asha_probe(struct bt_asha *asha, struct gatt_db *db,
-						struct bt_gatt_client *client)
+		struct bt_gatt_client *client, bt_asha_probe_cb_t probe_cb,
+							void *cb_user_data)
 {
 	bt_uuid_t asha_uuid;
 
 	asha->db = gatt_db_ref(db);
 	asha->client = bt_gatt_client_clone(client);
 
+	asha->probe_cb = probe_cb;
+	asha->probe_cb_data = cb_user_data;
+
 	bt_uuid16_create(&asha_uuid, ASHA_SERVICE);
 	gatt_db_foreach_service(db, &asha_uuid, foreach_asha_service, asha);
 
 	if (!asha->attr) {
 		error("ASHA attribute not found");
 		bt_asha_reset(asha);
 		return false;
 	}
 
 	if (!asha_devices)
diff --git a/src/shared/asha.h b/src/shared/asha.h
index e87a9fc3f..821c2a625 100644
--- a/src/shared/asha.h
+++ b/src/shared/asha.h
@@ -16,54 +16,59 @@
 #include <stdint.h>
 
 enum bt_asha_state_t {
 	ASHA_STOPPED = 0,
 	ASHA_STARTING,
 	ASHA_STARTED,
 	ASHA_STOPPING,
 };
 
 typedef void (*bt_asha_cb_t)(int status, void *data);
+typedef void (*bt_asha_probe_cb_t)(void *data);
 
 struct bt_asha {
 	struct bt_gatt_client *client;
 	struct gatt_db *db;
 	struct gatt_db_attribute *attr;
 	uint16_t acp_handle;
 	uint16_t volume_handle;
 	unsigned int status_notify_id;
 
 	uint16_t psm;
 	bool right_side;
 	bool binaural;
 	bool csis_supported;
 	bool coc_streaming_supported;
 	uint8_t hisyncid[8];
 	uint16_t render_delay;
 	uint16_t codec_ids;
 	int8_t volume;
 
 	enum bt_asha_state_t state;
 	bt_asha_cb_t cb;
 	void *cb_user_data;
+
+	bt_asha_probe_cb_t probe_cb;
+	void *probe_cb_data;
 };
 
 struct bt_asha_set {
 	uint8_t hisyncid[8];
 	struct bt_asha *left;
 	struct bt_asha *right;
 };
 
 struct bt_asha *bt_asha_new(void);
 void bt_asha_reset(struct bt_asha *asha);
 void bt_asha_state_reset(struct bt_asha *asha);
 void bt_asha_free(struct bt_asha *asha);
 
 unsigned int bt_asha_start(struct bt_asha *asha, bt_asha_cb_t cb,
 							void *user_data);
 unsigned int bt_asha_stop(struct bt_asha *asha, bt_asha_cb_t cb,
 							void *user_data);
 
 bool bt_asha_set_volume(struct bt_asha *asha, int8_t volume);
 
 bool bt_asha_probe(struct bt_asha *asha, struct gatt_db *db,
-						struct bt_gatt_client *client);
+		struct bt_gatt_client *client, bt_asha_probe_cb_t probe_cb,
+							void *cb_user_data);
-- 
2.49.0

