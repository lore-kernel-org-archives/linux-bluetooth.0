Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B04E20370C
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 06:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738651279; cv=none; b=E0HUqzqiBCgGt7kwa+55viUNMhNHDFaHmGdWYyWj5MUJJTBHWTMF1NmF0sMQR9S0J2tsM1LEGdsR/1lw33qAno4LdEpNWN65PugEGpwka1cprqheYt34Tvk8ULQzhXC0Cnqu8DonD8JBTLowRdgGS+XNU7zuJHDeSzBdWd7D7/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738651279; c=relaxed/simple;
	bh=Y1XB3ZWUsHYqa0OsJtnLaQg6kmoXlWErlvsCtQpEYA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fp3x6/e7aYNcRJlqQY3N0AWbgUFBvNgWp/sDig1Ko/BmoUjtmf3KQGEUM0HyFfGkdjGmEuvcaOFQe/BhKBZw9VsDyyWgNCYezesk0xi5KyZDIYMhyEfYHsVWP2ueVNjA5ttYIqzhLxgcuUI5L+hs1eJvR5FdVVrrCDilOAxybJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=COLwABQm; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="COLwABQm"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so9069123a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Feb 2025 22:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1738651276; x=1739256076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tU/aXgLT/m8RdI+rf4BRDEJ80TdNJ2lt3lZ8Lx3+Zps=;
        b=COLwABQmalFPdFZrMnDAZR4YUfybYp297MMZuXbGSPM2dHHyYIIn+Fq3JxQpkUVVa2
         ZuB1i8OvITZrkyQ7CpBoM+8Ll0PsU/AWHXHPzvH/yK/6SK4dWOwAF9llydwA7HTDvFgG
         IM2qRBsnFPYUmn/mqKSrwVE1yMzpv6vRmzgUDg/mrJ4xBSWa9jDFtO9pwK9vYmzJ5OnD
         d5Pyny3mIMl3yLg3mueaA+vfGQAd1+SMlFL/CHTge1QrtOkaQhdqphIoQ3GokynH4N67
         K9c8qXKmNLWqlCgvdLxa0Y4hTWtnA43B2UmmT2l935ZvBVQP6U68XkkxCgGZGdWzurZL
         jkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738651276; x=1739256076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tU/aXgLT/m8RdI+rf4BRDEJ80TdNJ2lt3lZ8Lx3+Zps=;
        b=bvQeMG1pDdYi0kKiaizpqDS86zSgxrapQ+kch+w7SQzWw5m0hcs5vo7ff2py/kl8pD
         ulsh2ef65TheAlk/8RlaG6ncYwSQjZQscMyIpacf5kM1T1GKhg2xOpBPPUNkridiB7O2
         X8RGS/CmFm3K8mL8L5rjnfQ/ebJV+zOe7QoVgz6rtq+LhcaJ2TXvxbJmFRQ+u5cx4GQH
         ZVONFHCydwkcJiXFXvrf+If5C2U8mbksxb+XVUP6cDlUMmM8Q8Hp1r/ZurEdpeeegZTw
         OhLvNX50pb1sNpLs1yF29WKVjBoYUbOHeAM23GmFY4gaBgXcrXfBtTyoHXjZmrJpqUIT
         fiWw==
X-Gm-Message-State: AOJu0Yzt38fgcCzeplmxTOzdRIX3kBPFDaQ4LSofFy1kuxWe2r4u1Fpg
	+g3OzIyeZ52MbPMUuOFJ/KNr9iHYTu9PW+Ii2IZQcuG8XL/DyqN2pYtm99lCdIpxxIvKrA/Lrux
	H
X-Gm-Gg: ASbGnctuT9iFiotowxVD4zed4IyJV8/RXn5SPvsgZu2Tc2TcK107qJDl+cfkScsult1
	STaG1+HjeM8I0nkX4tlFC4+JC3D3OjVz/yzneqLk3RMpnehMk/9K970MkMiLSKJ3zGR4pQD0UNF
	J9ENjNuYkwf4C4ZMz9yepJvFS2rkM1dfed4HsN6VaVU+7wmcVtWj16CSoQ7ZnGNHzH0AwUS2EPI
	dQH2gLLQVuBwKoiP7myqRvCmD1I67ckgNV7ubMASKrJv70m5JW7yHCgwYAxVza2m9eMyckMf1Sr
	OJ6zwv1ASSHTEYaOTHxGlg==
X-Google-Smtp-Source: AGHT+IGSzjjW8Be+N1M0BITOwospyEodn2SLKnlUAw7yTZtYOF2nAllycS3Vsv0gE8rMR6vYj31KYQ==
X-Received: by 2002:a05:6a00:130c:b0:728:e1e3:3d88 with SMTP id d2e1a72fcca58-72fd0be17f5mr35712493b3a.7.1738651275941;
        Mon, 03 Feb 2025 22:41:15 -0800 (PST)
Received: from localhost ([2401:4900:1cb8:94e9:54ba:1973:453d:16b0])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72fe69ce9f4sm9915862b3a.146.2025.02.03.22.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 22:41:15 -0800 (PST)
From: Sanchayan Maity <sanchayan@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: arun@asymptotic.io,
	Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [PATCH BlueZ v2 1/1] shared/asha: Add support for other side update
Date: Tue,  4 Feb 2025 12:10:54 +0530
Message-ID: <20250204064103.672327-2-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204064103.672327-1-sanchayan@asymptotic.io>
References: <20250204064103.672327-1-sanchayan@asymptotic.io>
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

https://source.android.com/docs/core/connect/bluetooth/asha#audiocontrolpoint
---
 src/shared/asha.c | 165 +++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/asha.h |   6 ++
 2 files changed, 168 insertions(+), 3 deletions(-)

diff --git a/src/shared/asha.c b/src/shared/asha.c
index 67f2631cd..28d5880a3 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -32,55 +32,168 @@
 
 #include "asha.h"
 
 /* We use strings instead of uint128_t to maintain readability */
 #define ASHA_CHRC_READ_ONLY_PROPERTIES_UUID "6333651e-c481-4a3e-9169-7c902aad37bb"
 #define ASHA_CHRC_AUDIO_CONTROL_POINT_UUID "f0d4de7e-4a88-476c-9d9f-1937b0996cc0"
 #define ASHA_CHRC_AUDIO_STATUS_UUID "38663f1a-e711-4cac-b641-326b56404837"
 #define ASHA_CHRC_VOLUME_UUID "00e4ca9e-ab14-41e4-8823-f9e70c7e91df"
 #define ASHA_CHRC_LE_PSM_OUT_UUID "2d410339-82b6-42aa-b34e-e2e01df8cc1a"
 
+static struct queue *asha_devices;
+
+unsigned int bt_asha_status(struct bt_asha *asha, bool connected);
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
+			DBG("ASHA left side update: %d, ret: %d", other_connected, ret);
+		}
+
+		if (!asha->right_side && set->right) {
+			ret = bt_asha_status(set->right, other_connected);
+			DBG("ASHA right side update: %d, ret: %d", other_connected, ret);
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
@@ -103,61 +216,101 @@ static int asha_send_acp(struct bt_asha *asha, uint8_t *cmd,
 		error("Error writing ACP command");
 		return -1;
 	}
 
 	asha->cb = cb;
 	asha->cb_user_data = user_data;
 
 	return 0;
 }
 
+static int asha_send_acp_without_response(struct bt_asha *asha, uint8_t *cmd,
+		unsigned int len)
+{
+	if (!bt_gatt_client_write_without_response(asha->client, asha->acp_handle,
+				false, cmd, len)) {
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
+unsigned int bt_asha_status(struct bt_asha *asha, bool other_connected)
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
+		DBG("ASHA %s device not started for status update", side);
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
@@ -231,43 +384,46 @@ static void read_rops(bool success,
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
 
@@ -348,12 +504,15 @@ bool bt_asha_probe(struct bt_asha *asha, struct gatt_db *db,
 
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

