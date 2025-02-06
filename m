Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270531EA7D8
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Feb 2025 13:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848361; cv=none; b=ki31bAImxLg1dN6+5PXISzQpPPit7aMObR0BStdWN0BNf19Vo4D1ZetRxmFlx6JmAoFgsiuqnltvyLIa88nI6bb9+FM9nRwbVIsgpVxAun+xZm/GdjtEl5+4ZkkYz98gjOjfX7JpHl6fw2hIL0zufi+DubyDkCoATDF9BG96rUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848361; c=relaxed/simple;
	bh=iy9UoeR9WAAydpAdsCESuthb0rrNBW7X9KZK8G8Gaec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gdcTU6kCyxh9noZMxXAdX7UBIAnOtLzUIibxBHxRhJedZWVrnBfSFvIEmcWkxE6tFtsMDnbUK9P6Aw3p5ZI3uhRmsjmXglKTDpuPX0DNv02WdE8GPH6vF40xcOGQFBplSe+FDwLoMbtuxlt9JtQEJNkkEH9PRb9vmxS/yzf2Y1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=amPNBFYJ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="amPNBFYJ"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f9e415fa42so1487729a91.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Feb 2025 05:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1738848358; x=1739453158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v86eU19MJJ+rv5kgQzyEOHAOZkPOna20u4CK5wHF5kU=;
        b=amPNBFYJvXIAHoMbzcaN0WxZpKt0ax951yj16CD2ZLbY8YbnBhpTeeKtHyTft0woOF
         J29BJbliqsLCVvr9pRwaKy9410lwSVPm8I5M8hMFZQEHZvxdT/xcU/jK7of0KPAZKTYp
         n/XrP++4DVDPXOZLJzs6pvvH22fRuWuwTVWNjQLBV3kvAh9sW2aMKPxrb7LeiPyKZwIS
         Wd7OkC4+P0ycHs9Mu+0CR/DzOq0chj35azoUFXd7/MlplENvvs6aileqlUw4UYROpl9H
         HbjQ5P92Bq2AORmUlayrDFhSq03FRxAzQAlhd4wqSWEyNCpqfDJ+jeJygiKDoasrDkhO
         Sxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738848358; x=1739453158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v86eU19MJJ+rv5kgQzyEOHAOZkPOna20u4CK5wHF5kU=;
        b=LlwPyP/yyuj0w0MfpYzLphanQf0Ioc9OzkeM+zTvb0NnZuRXVfi9+E96Tmdh0mDAfn
         dvFPWyYutDYrVi447vTelHMHixQRRLFJ+IT/SUJD5KNuGZLDfgVvsrRM7q3TYvSiGYFT
         C1LnNzNHVV/2MX4kiW7oSop5WaR1JtNmX4vRLz82BMTK6SR9XsJOxJOa0b/BFW868010
         4AIrAXR9f+HCzYjN+XcmBdRVT764Y1lqFcYIA9hsv8ZjPALE02cnk3aLn66SgkY3HOWU
         ry/vIeJ7DiRGJ5MVpyrz39PfrxjB7Vl0zx7GlyI6JUt/20OAdlvWBT4LH75LzVmogsUY
         fljQ==
X-Gm-Message-State: AOJu0YwG2I5R1aGkAemZ8kDKZey63XiwMiLtfxs0CcBMQJNA/Qm93xbk
	uyRsjS5GcU+THqytdtnQZtxHNCdd9ildeNOLIKYDLVD6fTNUhQQs6F8b/N8+xJBbTk974kA/hVY
	g
X-Gm-Gg: ASbGnctPi0/WALRJRzScIvF6x3V/6acpRfmXdI4JF9PJ/kTTodWNjHNBshf0KF/wLeL
	mDddvCfuk1mNkdcL5x79P4B86jZTfG/iztjvWX6Tzgtsg8ViTFb9CmAKCGMqgGJCk9p/OW2nafQ
	ZSlHP8+KyZF7XXKeLO5CrUgVMwbcK6EaUbpfNdRcM4B4hme0HuxeHytbb2b0ejbXvAci8PhkZv2
	lmD/TDLqcx05FVUTLva1mQxYPphAipJuBFg47DOFhxutiVflvNtWtb4sUZqMCIb5ShTZxy1JP6p
	0OD83w8Fk5NdpnAHGFlOxA==
X-Google-Smtp-Source: AGHT+IGktYmRlTG1VuxpWMLIBqCe1GDfwQiYx7h5pDCp8leTec4RBOJp6KSEWnyOFuXzaX78xBg1JA==
X-Received: by 2002:a17:90b:4cc2:b0:2f5:63a:44f9 with SMTP id 98e67ed59e1d1-2f9e0811e4bmr8648382a91.23.1738848358003;
        Thu, 06 Feb 2025 05:25:58 -0800 (PST)
Received: from localhost ([2401:4900:1cba:442a:bf93:c2be:de2e:76b7])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f9e1d5ff70sm3537468a91.2.2025.02.06.05.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 05:25:57 -0800 (PST)
From: Sanchayan Maity <sanchayan@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: arun@asymptotic.io,
	Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [PATCH BlueZ v3 1/1] shared/asha: Add support for other side update
Date: Thu,  6 Feb 2025 18:55:47 +0530
Message-ID: <20250206132548.363559-2-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206132548.363559-1-sanchayan@asymptotic.io>
References: <20250206132548.363559-1-sanchayan@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ASHA specification requires that the status of the other side be
communicated with the start command. The status is also updated
if one of the device in the pair is connected/disconnected after
the other.
---
 src/shared/asha.c | 170 +++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/asha.h |   6 ++
 2 files changed, 173 insertions(+), 3 deletions(-)

diff --git a/src/shared/asha.c b/src/shared/asha.c
index 67f2631cd..e7bba4cc4 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -32,55 +32,171 @@
 
 #include "asha.h"
 
 /* We use strings instead of uint128_t to maintain readability */
 #define ASHA_CHRC_READ_ONLY_PROPERTIES_UUID "6333651e-c481-4a3e-9169-7c902aad37bb"
 #define ASHA_CHRC_AUDIO_CONTROL_POINT_UUID "f0d4de7e-4a88-476c-9d9f-1937b0996cc0"
 #define ASHA_CHRC_AUDIO_STATUS_UUID "38663f1a-e711-4cac-b641-326b56404837"
 #define ASHA_CHRC_VOLUME_UUID "00e4ca9e-ab14-41e4-8823-f9e70c7e91df"
 #define ASHA_CHRC_LE_PSM_OUT_UUID "2d410339-82b6-42aa-b34e-e2e01df8cc1a"
 
+static struct queue *asha_devices;
+
+static unsigned int bt_asha_status(struct bt_asha *asha, bool connected);
+
+static bool match_hisyncid(const void *data, const void *user_data)
+{
+	const struct bt_asha_set *set = data;
+	const struct bt_asha *asha = user_data;
+
+	return (memcmp(set->hisyncid, asha->hisyncid, 8) == 0);
+}
+
+static struct bt_asha_set *find_asha_set(struct bt_asha *asha)
+{
+	return queue_find(asha_devices, match_hisyncid, asha);
+}
+
+static uint8_t is_other_connected(struct bt_asha *asha)
+{
+	struct bt_asha_set *set = find_asha_set(asha);
+
+	if (set) {
+		if (asha->right_side && set->left) {
+			DBG("ASHA right and left side connected");
+			return 1;
+		}
+		if (!asha->right_side && set->right) {
+			DBG("ASHA left and right side connected");
+			return 1;
+		}
+	}
+
+	if (asha->right_side)
+		DBG("ASHA right side connected");
+	else
+		DBG("ASHA left side connected");
+
+	return 0;
+}
+
+static void update_asha_set(struct bt_asha *asha, bool connected)
+{
+	struct bt_asha_set *set;
+
+	set = queue_find(asha_devices, match_hisyncid, asha);
+
+	if (connected) {
+		if (!set) {
+			set = new0(struct bt_asha_set, 1);
+			memcpy(set->hisyncid, asha->hisyncid, 8);
+			queue_push_tail(asha_devices, set);
+			DBG("Created ASHA set");
+		}
+
+		if (asha->right_side) {
+			set->right = asha;
+			DBG("Right side registered for ASHA set");
+		} else {
+			set->left = asha;
+			DBG("Left side registered for ASHA set");
+		}
+	} else {
+		if (!set) {
+			error("Missing ASHA set");
+			return;
+		}
+
+		if (asha->right_side && set->right) {
+			set->right = NULL;
+			DBG("Right side unregistered for ASHA set");
+		} else if (!asha->right_side && set->left) {
+			set->left = NULL;
+			DBG("Left side unregistered for ASHA set");
+		}
+
+		if (!set->right && !set->left) {
+			if (queue_remove(asha_devices, set)) {
+				free(set);
+				DBG("Freeing ASHA set");
+			}
+
+			if (!queue_peek_tail(asha_devices)) {
+				queue_destroy(asha_devices, NULL);
+				asha_devices = NULL;
+			}
+		}
+	}
+}
+
+static int asha_set_send_status(struct bt_asha *asha, bool other_connected)
+{
+	struct bt_asha_set *set;
+	int ret = 0;
+
+	set = queue_find(asha_devices, match_hisyncid, asha);
+
+	if (set) {
+		if (asha->right_side && set->left) {
+			ret = bt_asha_status(set->left, other_connected);
+			DBG("ASHA left side update: %d, ret: %d",
+					other_connected, ret);
+		}
+
+		if (!asha->right_side && set->right) {
+			ret = bt_asha_status(set->right, other_connected);
+			DBG("ASHA right side update: %d, ret: %d",
+					other_connected, ret);
+		}
+	}
+
+	return ret;
+}
+
 struct bt_asha *bt_asha_new(void)
 {
 	struct bt_asha *asha;
 
 	asha = new0(struct bt_asha, 1);
 
 	return asha;
 }
 
 void bt_asha_reset(struct bt_asha *asha)
 {
 	if (asha->status_notify_id) {
 		bt_gatt_client_unregister_notify(asha->client,
 						asha->status_notify_id);
 	}
 
 	gatt_db_unref(asha->db);
 	asha->db = NULL;
 
 	bt_gatt_client_unref(asha->client);
 	asha->client = NULL;
 
 	asha->psm = 0;
+
+	update_asha_set(asha, false);
 }
 
 void bt_asha_state_reset(struct bt_asha *asha)
 {
 	asha->state = ASHA_STOPPED;
 
 	asha->cb = NULL;
 	asha->cb_user_data = NULL;
 }
 
 void bt_asha_free(struct bt_asha *asha)
 {
+	update_asha_set(asha, false);
 	gatt_db_unref(asha->db);
 	bt_gatt_client_unref(asha->client);
 	free(asha);
 }
 
 static void asha_acp_sent(bool success, uint8_t err, void *user_data)
 {
 	struct bt_asha *asha = user_data;
 
 	if (success) {
@@ -103,61 +219,103 @@ static int asha_send_acp(struct bt_asha *asha, uint8_t *cmd,
 		error("Error writing ACP command");
 		return -1;
 	}
 
 	asha->cb = cb;
 	asha->cb_user_data = user_data;
 
 	return 0;
 }
 
+static int asha_send_acp_without_response(struct bt_asha *asha,
+		uint8_t *cmd, unsigned int len)
+{
+	if (!bt_gatt_client_write_without_response(asha->client,
+			asha->acp_handle, false, cmd, len)) {
+		error("Error writing ACP command");
+		return -1;
+	}
+
+	return 0;
+}
+
 unsigned int bt_asha_start(struct bt_asha *asha, bt_asha_cb_t cb,
 								void *user_data)
 {
+	uint8_t other_connected = is_other_connected(asha);
 	uint8_t acp_start_cmd[] = {
 		0x01,		/* START */
 		0x01,		/* G.722, 16 kHz */
 		0,			/* Unknown media type */
 		asha->volume,	/* Volume */
-		0,			/* Other disconnected */
+		other_connected,
 	};
 	int ret;
 
 	if (asha->state != ASHA_STOPPED) {
 		error("ASHA device start failed. Bad state %d", asha->state);
 		return 0;
 	}
 
 	ret = asha_send_acp(asha, acp_start_cmd, sizeof(acp_start_cmd), cb,
 			user_data);
 	if (ret < 0)
 		return ret;
 
 	asha->state = ASHA_STARTING;
 
 	return 0;
 }
 
 unsigned int bt_asha_stop(struct bt_asha *asha, bt_asha_cb_t cb,
 								void *user_data)
 {
 	uint8_t acp_stop_cmd[] = {
 		0x02, /* STOP */
 	};
+	int ret;
 
 	if (asha->state != ASHA_STARTED)
 		return 0;
 
 	asha->state = ASHA_STOPPING;
 
-	return asha_send_acp(asha, acp_stop_cmd, sizeof(acp_stop_cmd),
-								cb, user_data);
+	ret = asha_send_acp(asha, acp_stop_cmd, sizeof(acp_stop_cmd),
+			cb, user_data);
+	asha_set_send_status(asha, false);
+
+	return ret;
+}
+
+static unsigned int bt_asha_status(struct bt_asha *asha, bool other_connected)
+{
+	uint8_t status = other_connected ? 1 : 0;
+	uint8_t acp_status_cmd[] = {
+		0x03, /* STATUS */
+		status,
+	};
+	int ret;
+
+	if (asha->state != ASHA_STARTED) {
+		const char *side = asha->right_side ? "right" : "left";
+
+		DBG("ASHA %s device not started for status update", side);
+
+		return 0;
+	}
+
+	ret = asha_send_acp_without_response(asha, acp_status_cmd,
+			sizeof(acp_status_cmd));
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 bool bt_asha_set_volume(struct bt_asha *asha, int8_t volume)
 {
 	if (!bt_gatt_client_write_without_response(asha->client,
 						asha->volume_handle, false,
 						(const uint8_t *)&volume, 1)) {
 		error("Error writing volume");
 		return false;
 	}
@@ -231,43 +389,46 @@ static void read_rops(bool success,
 	asha->coc_streaming_supported = (value[10] & 0x1) != 0;
 	/* RenderDelay */
 	asha->render_delay = get_le16(&value[11]);
 	/* byte 13 & 14 are reserved */
 	/* Codec IDs */
 	asha->codec_ids = get_le16(&value[15]);
 
 	DBG("Got ROPS: side %u, binaural %u, csis: %u, delay %u, codecs: %u",
 			asha->right_side, asha->binaural, asha->csis_supported,
 			asha->render_delay, asha->codec_ids);
+
+	update_asha_set(asha, true);
 }
 
 static void audio_status_register(uint16_t att_ecode, void *user_data)
 {
 	if (att_ecode)
 		DBG("AudioStatusPoint register failed 0x%04x", att_ecode);
 	else
 		DBG("AudioStatusPoint register succeeded");
 }
 
 static void audio_status_notify(uint16_t value_handle, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
 	struct bt_asha *asha = user_data;
 	uint8_t status = *value;
 	/* Back these up to survive the reset paths */
 	bt_asha_cb_t cb = asha->cb;
 	bt_asha_cb_t cb_user_data = asha->cb_user_data;
 
 	if (asha->state == ASHA_STARTING) {
 		if (status == 0) {
 			asha->state = ASHA_STARTED;
 			DBG("ASHA start complete");
+			asha_set_send_status(asha, true);
 		} else {
 			bt_asha_state_reset(asha);
 			DBG("ASHA start failed");
 		}
 	} else if (asha->state == ASHA_STOPPING) {
 		/* We reset our state, regardless */
 		bt_asha_state_reset(asha);
 		DBG("ASHA stop %s", status == 0 ? "complete" : "failed");
 	}
 
@@ -348,12 +509,15 @@ bool bt_asha_probe(struct bt_asha *asha, struct gatt_db *db,
 
 	bt_uuid16_create(&asha_uuid, ASHA_SERVICE);
 	gatt_db_foreach_service(db, &asha_uuid, foreach_asha_service, asha);
 
 	if (!asha->attr) {
 		error("ASHA attribute not found");
 		bt_asha_reset(asha);
 		return false;
 	}
 
+	if (!asha_devices)
+		asha_devices = queue_new();
+
 	return true;
 }
diff --git a/src/shared/asha.h b/src/shared/asha.h
index c2c232fff..e87a9fc3f 100644
--- a/src/shared/asha.h
+++ b/src/shared/asha.h
@@ -40,20 +40,26 @@ struct bt_asha {
 	uint8_t hisyncid[8];
 	uint16_t render_delay;
 	uint16_t codec_ids;
 	int8_t volume;
 
 	enum bt_asha_state_t state;
 	bt_asha_cb_t cb;
 	void *cb_user_data;
 };
 
+struct bt_asha_set {
+	uint8_t hisyncid[8];
+	struct bt_asha *left;
+	struct bt_asha *right;
+};
+
 struct bt_asha *bt_asha_new(void);
 void bt_asha_reset(struct bt_asha *asha);
 void bt_asha_state_reset(struct bt_asha *asha);
 void bt_asha_free(struct bt_asha *asha);
 
 unsigned int bt_asha_start(struct bt_asha *asha, bt_asha_cb_t cb,
 							void *user_data);
 unsigned int bt_asha_stop(struct bt_asha *asha, bt_asha_cb_t cb,
 							void *user_data);
 
-- 
2.48.1

