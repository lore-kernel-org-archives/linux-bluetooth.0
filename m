Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8661E285A
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060462; cv=none; b=iPpIYSbrauyzW8uGw8h9omfllWq08KwO4H3k/7gb1eOTDsz+Bjn5K2WYFgi7JQOUQKBvydtMTpg6eboroOxACavIJ/C2EFlHFfnxsHDr0KxE2BdAWGrWaPwMyyCN1aLHPPW44+kVun8Ni30a+lrklZYwuaikoSSfVeJHaSuyzUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060462; c=relaxed/simple;
	bh=I8ZZj4kVDxmfG1ZfPI43Ps7A0+D9Pcy0wpxBXGYENf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FoJ7jRua4cdyM/KYPor5LlSis/cYppWbkxsiueb4pixG7KQUj52K9jT453KatpOs80ohekIP4Iex+7bZ2yVPuFhvURV5+8EaffLDMnqk1U7J6gA/iCifQRybLBDex96wtnB8QwQ/IYVhZWEgMXW45b5C+U9DpnzqlYgS8Z0H6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=oKu9tYYm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="oKu9tYYm"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-741b3e37a1eso3515519b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 07:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1747060458; x=1747665258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DUP+l0MFXiogaS2mLshxsj8yb29EDfG184TPkYXMIs=;
        b=oKu9tYYmbCLCjhma23760o7adbeXRZWOxyLLM5+3rHDVc/dBsCDauSbqh4kXaKHq4g
         iqDfKuIYPBrOQQ2Qe75yY5a4jPzfp+cMOLAzj3qrtXFGpswtLKbWdJ5WQuKKaOd4AR4b
         oWc5N+ZMpqBimMRK+eWctJW+GsMV/r4F+SVNQERE73wjvLPtIczXGYf0dYpZJm0CyALt
         jAOm8zdovGEEzLO98qjpDUXYFXi0+c9WmEvqFVY8nElwodKV5iFEEopf8UQOPpDAfYnE
         QX2ZgRbT0bnVL6UQMxTyGpUOEXY+qeJVeyZYomVWtoMedisQuut2j2WP8bmh0xLgQbsj
         bmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747060458; x=1747665258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DUP+l0MFXiogaS2mLshxsj8yb29EDfG184TPkYXMIs=;
        b=NMizfAXIrDI4ol6tqXnbskCqFSUzL5DPH+zSue5BdaqkjhJNlTLWp2X767LkrKQjzi
         S9mdvSJn34Fsd/QVIW205qcMiXvCQpC3YycmiTdbaH/CwtitOsXqipQgJcQuBzPHbzF4
         smDvTTc9auYnNepJ5IX8musqrCIB7QV7E6GoVGzx07axEmSMV+6I4RWT9g6gnUHElRPX
         RnfCPE3APV+Q4Vu9c/fxpfnR6zYfCvylFLIvYZ8mYuaBo/W0w8JIXBNbdyFi7rKjt9Io
         78Sp5zTZ+DR6hcaaLzeyUJ2xyJfIaOpjVrLa8PU77gO/bTI0mToc/cqBvRSmYtCnYDdw
         DPYA==
X-Gm-Message-State: AOJu0Ywlt+PZwvNdrzKW4liahID8bZxaB+DgqJMcItTcbgv/DaohLY+F
	w6z6n5QjrmFf5iF381mWwURywKD6qE40We3gvTWiN+5xrCRrooms9yqfeYSPAp3EdjQOupsKqGo
	/
X-Gm-Gg: ASbGncvh0g079qUvGfKXRgioYXjbEhinX5eZbdhcMgeQq8txwLuRceB4I5buLjwWTTN
	c5ZZTxuyM4fbVVdPK59deKaz44wb5xLKNUHKS1IWCDPkgSNnkh/A2hr72EE808C27AWJBYFt4jM
	6XRIU6DTL0rO9QJVaZXH/VVbnr92WlzOjerEOKrVYGXk0dEth2G0wnVjBJvbkx3gUgolqjSiOde
	kzIyYyB9/bmzQssUxa9NGBHXVErMm+OMDaGk8O4VR5WS2f0r4gMxp/kudrzhtohq0lsXkIGt1Fz
	9GpS9B3J+bCw7/Ty+2WazvAS4p6hh+TlbTPz9k/E+kZoBWbv8lsZmh4h
X-Google-Smtp-Source: AGHT+IFrTxQoIeRcWiBlTwLB6VEy/CIWN82zx7UxFi4znHyxMzJFO/wLBAKoHsCj+299/3TBf2DFMQ==
X-Received: by 2002:a05:6a00:6c96:b0:740:b3d9:551 with SMTP id d2e1a72fcca58-7423c07585amr18661302b3a.22.1747060458353;
        Mon, 12 May 2025 07:34:18 -0700 (PDT)
Received: from localhost ([2401:4900:1cb9:9be3:2edb:7ff:fe58:f2f5])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74237a11447sm6277611b3a.105.2025.05.12.07.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 07:34:18 -0700 (PDT)
From: Sanchayan Maity <sanchayan@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [PATCH BlueZ v2 1/2] shared/asha: Don't wait for status notification on stop
Date: Mon, 12 May 2025 20:04:07 +0530
Message-ID: <20250512143408.283938-2-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512143408.283938-1-sanchayan@asymptotic.io>
References: <20250512143408.283938-1-sanchayan@asymptotic.io>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arun Raghavan <arun@asymptotic.io>

Not all devices respond with the status update, so let's just send it
out and assume it worked.
---
 profiles/audio/asha.c      |  5 ++---
 profiles/audio/asha.h      |  3 +--
 profiles/audio/transport.c | 16 ++++------------
 src/shared/asha.c          | 19 ++++++++++---------
 src/shared/asha.h          |  4 +---
 5 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/profiles/audio/asha.c b/profiles/audio/asha.c
index d478faf11..9bd57d780 100644
--- a/profiles/audio/asha.c
+++ b/profiles/audio/asha.c
@@ -163,24 +163,23 @@ unsigned int bt_asha_device_start(struct bt_asha_device *asha_dev,
 			0x0064 /* 1s timeout */);
 
 	ret = asha_connect_socket(asha_dev, cb, user_data);
 
 	if (ret < 0)
 		return 0;
 	else
 		return (++asha_dev->resume_id);
 }
 
-unsigned int bt_asha_device_stop(struct bt_asha_device *asha_dev,
-					bt_asha_cb_t cb, void *user_data)
+unsigned int bt_asha_device_stop(struct bt_asha_device *asha_dev)
 {
-	bt_asha_stop(asha_dev->asha, cb, user_data);
+	bt_asha_stop(asha_dev->asha);
 
 	if (asha_dev->io) {
 		g_io_channel_shutdown(asha_dev->io, TRUE, NULL);
 		g_io_channel_unref(asha_dev->io);
 		asha_dev->io = NULL;
 	};
 
 	return asha_dev->resume_id;
 }
 
diff --git a/profiles/audio/asha.h b/profiles/audio/asha.h
index afd23e137..9ffd9d307 100644
--- a/profiles/audio/asha.h
+++ b/profiles/audio/asha.h
@@ -12,22 +12,21 @@
 
 #include <stdbool.h>
 #include <stdint.h>
 
 #include "src/shared/asha.h"
 
 struct bt_asha_device;
 
 unsigned int bt_asha_device_start(struct bt_asha_device *asha_dev,
 					bt_asha_cb_t cb, void *user_data);
-unsigned int bt_asha_device_stop(struct bt_asha_device *asha_dev,
-					bt_asha_cb_t cb, void *user_data);
+unsigned int bt_asha_device_stop(struct bt_asha_device *asha_dev);
 
 void bt_asha_device_state_reset(struct bt_asha_device *asha_dev);
 unsigned int bt_asha_device_device_get_resume_id(
 					struct bt_asha_device *asha_dev);
 
 uint16_t bt_asha_device_get_render_delay(struct bt_asha_device *asha_dev);
 enum bt_asha_state_t bt_asha_device_get_state(
 					struct bt_asha_device *asha_dev);
 
 int bt_asha_device_get_fd(struct bt_asha_device *asha_dev);
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 3d1f55b70..c5ae3a71b 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2240,23 +2240,20 @@ static void asha_transport_sync_state(struct media_transport *transport,
 	switch (bt_asha_device_get_state(asha_dev)) {
 	case ASHA_STOPPED:
 		transport_set_state(transport, TRANSPORT_STATE_IDLE);
 		break;
 	case ASHA_STARTING:
 		transport_set_state(transport, TRANSPORT_STATE_REQUESTING);
 		break;
 	case ASHA_STARTED:
 		transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
 		break;
-	case ASHA_STOPPING:
-		transport_set_state(transport, TRANSPORT_STATE_SUSPENDING);
-		break;
 	}
 }
 
 static void asha_transport_state_cb(int status, void *user_data)
 {
 	struct media_owner *owner = user_data;
 	struct media_transport *transport = owner->transport;
 	struct bt_asha_device *asha_dev;
 	enum bt_asha_state_t state;
 
@@ -2317,53 +2314,48 @@ static guint transport_asha_resume(struct media_transport *transport,
 	return ret > 0 ? ret : 0;
 }
 
 static guint transport_asha_suspend(struct media_transport *transport,
 						struct media_owner *owner)
 {
 	struct bt_asha_device *asha_dev = transport->data;
 	guint ret = 0;
 
 	if (owner) {
-		ret = bt_asha_device_stop(asha_dev, asha_transport_state_cb,
-									owner);
+		ret = bt_asha_device_stop(asha_dev);
 		asha_transport_sync_state(transport, asha_dev);
+		asha_transport_state_cb(-1, owner);
 	} else {
-		ret = bt_asha_device_stop(asha_dev, NULL, NULL);
+		ret = bt_asha_device_stop(asha_dev);
 		/* We won't have a callback to set the final state */
 		transport_set_state(transport, TRANSPORT_STATE_IDLE);
 	}
 
 	return ret;
 }
 
 static void transport_asha_cancel(struct media_transport *transport, guint id)
 {
 	struct bt_asha_device *asha_dev = transport->data;
 	enum bt_asha_state_t state = bt_asha_device_get_state(asha_dev);
 
 	if (id != bt_asha_device_device_get_resume_id(asha_dev)) {
 		/* Not current, ignore */
 		DBG("Ignoring cancel request for id %d", id);
 		return;
 	}
 
 	if (state == ASHA_STARTING || state == ASHA_STARTED) {
 		DBG("Cancel requested, stopping");
-		bt_asha_device_stop(asha_dev, NULL, NULL);
+		bt_asha_device_stop(asha_dev);
 		/* We won't have a callback to set the final state */
 		transport_set_state(transport, TRANSPORT_STATE_IDLE);
-	} else if (state == ASHA_STOPPING) {
-		DBG("Cancel requested, resetting transport state");
-		/* We already dispatched a stop, just reset our state */
-		bt_asha_device_state_reset(asha_dev);
-		transport_set_state(transport, TRANSPORT_STATE_IDLE);
 	}
 }
 
 static int transport_asha_get_volume(struct media_transport *transport)
 {
 	struct bt_asha_device *asha_dev = transport->data;
 	int8_t volume;
 	int scaled_volume;
 
 	volume = bt_asha_device_get_volume(asha_dev);
diff --git a/src/shared/asha.c b/src/shared/asha.c
index 33bec40da..3e1673488 100644
--- a/src/shared/asha.c
+++ b/src/shared/asha.c
@@ -265,37 +265,40 @@ unsigned int bt_asha_start(struct bt_asha *asha, bt_asha_cb_t cb,
 	ret = asha_send_acp(asha, acp_start_cmd, sizeof(acp_start_cmd), cb,
 			user_data);
 	if (ret < 0)
 		return ret;
 
 	asha->state = ASHA_STARTING;
 
 	return 0;
 }
 
-unsigned int bt_asha_stop(struct bt_asha *asha, bt_asha_cb_t cb,
-								void *user_data)
+unsigned int bt_asha_stop(struct bt_asha *asha)
 {
 	uint8_t acp_stop_cmd[] = {
 		0x02, /* STOP */
 	};
 	int ret;
 
 	if (asha->state != ASHA_STARTED)
 		return 0;
 
-	asha->state = ASHA_STOPPING;
+	asha->state = ASHA_STOPPED;
 
-	ret = asha_send_acp(asha, acp_stop_cmd, sizeof(acp_stop_cmd),
-			cb, user_data);
+	ret = asha_send_acp(asha, acp_stop_cmd, sizeof(acp_stop_cmd), NULL,
+			NULL);
 	asha_set_send_status(asha, false);
 
+	/* We reset our state without waiting for a response */
+	bt_asha_state_reset(asha);
+	DBG("ASHA stop done");
+
 	return ret;
 }
 
 static unsigned int bt_asha_status(struct bt_asha *asha, bool other_connected)
 {
 	uint8_t status = other_connected ? 1 : 0;
 	uint8_t acp_status_cmd[] = {
 		0x03, /* STATUS */
 		status,
 	};
@@ -434,34 +437,32 @@ static void audio_status_register(uint16_t att_ecode, void *user_data)
 
 static void audio_status_notify(uint16_t value_handle, const uint8_t *value,
 					uint16_t length, void *user_data)
 {
 	struct bt_asha *asha = user_data;
 	uint8_t status = *value;
 	/* Back these up to survive the reset paths */
 	bt_asha_cb_t state_cb = asha->state_cb;
 	bt_asha_cb_t state_cb_data = asha->state_cb_data;
 
+	DBG("ASHA status %u", status);
+
 	if (asha->state == ASHA_STARTING) {
 		if (status == 0) {
 			asha->state = ASHA_STARTED;
 			DBG("ASHA start complete");
 			update_asha_set(asha, true);
 			asha_set_send_status(asha, true);
 		} else {
 			bt_asha_state_reset(asha);
 			DBG("ASHA start failed");
 		}
-	} else if (asha->state == ASHA_STOPPING) {
-		/* We reset our state, regardless */
-		bt_asha_state_reset(asha);
-		DBG("ASHA stop %s", status == 0 ? "complete" : "failed");
 	}
 
 	if (state_cb) {
 		state_cb(status, state_cb_data);
 		asha->state_cb = NULL;
 		asha->state_cb_data = NULL;
 	}
 }
 
 static void handle_characteristic(struct gatt_db_attribute *attr,
diff --git a/src/shared/asha.h b/src/shared/asha.h
index 680a27010..9e62fcde8 100644
--- a/src/shared/asha.h
+++ b/src/shared/asha.h
@@ -12,21 +12,20 @@
 
 #
 
 #include <stdbool.h>
 #include <stdint.h>
 
 enum bt_asha_state_t {
 	ASHA_STOPPED = 0,
 	ASHA_STARTING,
 	ASHA_STARTED,
-	ASHA_STOPPING,
 };
 
 typedef void (*bt_asha_cb_t)(int status, void *data);
 typedef void (*bt_asha_attach_cb_t)(void *data);
 
 struct bt_asha {
 	struct bt_gatt_client *client;
 	struct gatt_db *db;
 	struct gatt_db_attribute *attr;
 	uint16_t acp_handle;
@@ -57,18 +56,17 @@ struct bt_asha_set {
 	struct bt_asha *right;
 };
 
 struct bt_asha *bt_asha_new(void);
 void bt_asha_reset(struct bt_asha *asha);
 void bt_asha_state_reset(struct bt_asha *asha);
 void bt_asha_free(struct bt_asha *asha);
 
 unsigned int bt_asha_start(struct bt_asha *asha, bt_asha_cb_t cb,
 							void *user_data);
-unsigned int bt_asha_stop(struct bt_asha *asha, bt_asha_cb_t cb,
-							void *user_data);
+unsigned int bt_asha_stop(struct bt_asha *asha);
 
 bool bt_asha_set_volume(struct bt_asha *asha, int8_t volume);
 
 bool bt_asha_attach(struct bt_asha *asha, struct gatt_db *db,
 		struct bt_gatt_client *client, bt_asha_attach_cb_t probe_cb,
 							void *cb_user_data);
-- 
2.49.0

