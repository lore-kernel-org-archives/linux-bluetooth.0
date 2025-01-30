Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6149E25634
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 09:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738227735; cv=none; b=Y8SY8DWShiY1kOuZrKCM2/d5UMf4YlhPi5tOgWsRFV4Nw3JZ4Qghfzx2hEZq/on8w57JixeNCAfcoLPVHfL9Zrkki2DoDCyDUSIZAvFNcBzQnDLk6pCk2RbIidUQXDwmD8Vp8lfv44nnfWPYz6cTcFXP/gZ/+uCX5YMsTmB/XKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738227735; c=relaxed/simple;
	bh=4WROyHJmyXJKglrRRQzVk4n9BNYr0xzaGCJIqOlkNUY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TfOmXdJid4gj07GIXOZ4l68crI4sWBJ7jGtS0an6KHBkzhoCfHGhJZqPxv+omVIxTVN6N+XCrX8gYo16ku/RkDgYoADoP0dke4NldVbS+X/SjxDQOi3y79Bw6WbtPDOkG1SqCo804TourUcvfu22PjHuqM4XoG9n6PjSlRRU6rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=f767hWKM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="f767hWKM"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21654fdd5daso7948165ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jan 2025 01:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1738227732; x=1738832532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fqzAKqQD3RkD2QBicC0izo5rCHNBLTAGqEMuGzK2x40=;
        b=f767hWKMRJ25gTjSmIyE6yzLEw7TqC4zlAPUeV+Lu0md3oJANmEipVj/83OD3vldRn
         YMOlU3kh4dox9HLTRE3Xal69fgN836FYmmRh5HBdwb4vvkX+ZNkIDmS7UbNjQKmDMwQ7
         PBchOdSIVLU2OJsVivv1CWdUfjSp/8I5/McMrzh0/TRgqM6amFOG9ZC2rNEaZ/Y7XJlY
         6g8ajl7kSqEHgi2JiQ5/j51zIUkz+SNWBJXnNy+kxH0WXfn0ZiGHLCjC64E3RLegDERd
         TyJNDZUddcTDWMUXooxk32t8oVMnWtZa4rHJIHMxG7JFeUy9fTKpUmx19CgI7PqWjeaS
         2a5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738227732; x=1738832532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqzAKqQD3RkD2QBicC0izo5rCHNBLTAGqEMuGzK2x40=;
        b=jb4s1CetGVLRAXY5N5mfPSM3Isemzt+yowRheWKEHY8TSFMjDVqYFTFHzL9pmduQ9l
         a5sYN6ujipr9SfYx2oTwEjEYAEfsDOEv0ac0d9/m8CQsN7JCHX4MLTtGYOYKBKLgbt79
         lPRcBrITnz6eogqOKkeHUFUxMV/DKUtxbV201vGxgm0J0JQv4HchXdcMigM7uocqjHpg
         hAn9lcgDPG9kU2K0MwP6LUIWLyTd2pzHdnZLegWolmmibHrO2wzLOYERtG8sLCrC1/lu
         EjhfsXcMXUvUyBhYrNAAoRu9/QcVUmZ6prffx3IuMeJPJO9lKExCURkZn1EWjQNMf18U
         CcVw==
X-Gm-Message-State: AOJu0Yy4Q214fKNTg3DAFEJRADwKus3lx2do7EeRoSuT39nSvgMAaNZd
	SkBdZsNnBzmKWtSIIS5d8n/OV9AP1KKmS+3tobU5O6zFoveJK11Se2V/J2eiQmO8qAYPlnsJBbG
	5
X-Gm-Gg: ASbGncu8MxDtoDpNTg3tGLFvqUc9rlmC76W0JRV+mOl0JuL5dj0izYA3kvz0kZBaXq6
	MaP+IeTumzVSjAYpNkRyMU6UUDLImgRGUUzLu2mZKKRfmmt3McQYe29Ir5zQ8ZplILCsZkDA1r0
	YMSczKaYHNgH8GDQIOu79uwsqxkx1uWGwqy/GDKOnYLuIFFcjUKYMh1INfFuWwdK0nnQ6sll6TA
	qzB5DBU0IT0RB8hXMBgX8CZ3BhWNXY6YNhPbT+AUQtQ4wd2bKXL08eijw3/VchmzSIQ9LrqZvsA
	A/picPp7J9mQ00r5WB8vRA==
X-Google-Smtp-Source: AGHT+IGhzVi9OirCrCIQSnfd9vbee0Jilsy8qaxOzfl08kK4D7PSatI1OZOIVzscdrZyYrQoPdLaKA==
X-Received: by 2002:a17:90b:4ecb:b0:2f6:dc00:3af with SMTP id 98e67ed59e1d1-2f83ac8adedmr7639937a91.34.1738227732083;
        Thu, 30 Jan 2025 01:02:12 -0800 (PST)
Received: from localhost ([2401:4900:8838:6d28:6067:cc51:1124:aabf])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-2f83bcd0ddbsm3628884a91.11.2025.01.30.01.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 01:02:11 -0800 (PST)
From: Sanchayan Maity <sanchayan@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: arun@asymptotic.io
Subject: [PATCH BlueZ] shared/asha: Add support for other side update
Date: Thu, 30 Jan 2025 14:31:58 +0530
Message-ID: <20250130090158.266044-1-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.48.1
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
 src/shared/asha.c | 163 +++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/asha.h |   8 +++
 2 files changed, 168 insertions(+), 3 deletions(-)

diff --git a/src/shared/asha.c b/src/shared/asha.c
index 67f2631cd..f2170d758 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -32,55 +32,166 @@
 
 #include "asha.h"
 
 /* We use strings instead of uint128_t to maintain readability */
 #define ASHA_CHRC_READ_ONLY_PROPERTIES_UUID "6333651e-c481-4a3e-9169-7c902aad37bb"
 #define ASHA_CHRC_AUDIO_CONTROL_POINT_UUID "f0d4de7e-4a88-476c-9d9f-1937b0996cc0"
 #define ASHA_CHRC_AUDIO_STATUS_UUID "38663f1a-e711-4cac-b641-326b56404837"
 #define ASHA_CHRC_VOLUME_UUID "00e4ca9e-ab14-41e4-8823-f9e70c7e91df"
 #define ASHA_CHRC_LE_PSM_OUT_UUID "2d410339-82b6-42aa-b34e-e2e01df8cc1a"
 
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
@@ -103,61 +214,101 @@ static int asha_send_acp(struct bt_asha *asha, uint8_t *cmd,
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
@@ -231,43 +382,46 @@ static void read_rops(bool success,
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
 
@@ -348,12 +502,15 @@ bool bt_asha_probe(struct bt_asha *asha, struct gatt_db *db,
 
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
index c2c232fff..1a970e67a 100644
--- a/src/shared/asha.h
+++ b/src/shared/asha.h
@@ -40,20 +40,28 @@ struct bt_asha {
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
+static struct queue *asha_devices;
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

