Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D3CDDCD
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747045206; cv=none; b=ZSJtt0StSWBCIVqEvDdvIzdHk6KhJKSkq80O4ZoXytOIHWwMnBQ0nnhhbVkRZ67QaGNFa1EqzL4Jp+0tcq2Mb34FU8CEUONQ7zPA3ovsBjmOGzS4RrLc8SnZtNLSFiAarYvBbCDiYPqY6Po7CBb4iJ/f8fxhYPrXMayVUgpfXLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747045206; c=relaxed/simple;
	bh=I8ZZj4kVDxmfG1ZfPI43Ps7A0+D9Pcy0wpxBXGYENf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePQW/b/MiTC0gdy5CTOG/KwfSP5IGtcFg+TZrpALcDgvSSkvCDT0RkdX7679dEc3h2vqWoOA3ErfcZDhmoQ+zN4Q9mTgbY9pQXrlbAsdMJRB5MN3ubPDR5OqSpXe+cUd55pfY1eZ3etqQ/5vbFDieG8L3y4NhjG/e8tCeGvHTfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io; spf=pass smtp.mailfrom=asymptotic.io; dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b=lccigf8l; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asymptotic.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asymptotic.io header.i=@asymptotic.io header.b="lccigf8l"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-30c1c4a8224so3099298a91.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 03:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asymptotic.io; s=google; t=1747045203; x=1747650003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DUP+l0MFXiogaS2mLshxsj8yb29EDfG184TPkYXMIs=;
        b=lccigf8l8Uzb9COC/V4XXX5IJuCCQjZY3wmRmCjmoGyhwAGid50TG6QmTJsxUx1Z8G
         /h+ye+tI6Ku9ZVrry+ylhfmAWANLT1BszjaBIikT+IqLIFUefHFNnWiPfsvNmBPY2vK1
         X+dpQqeO2a6GOVJqDhWu2d4TAT/zzXBNHiDS4UrltRkB3zR+DW18ZT2Vd+Txir7qYWCk
         DI5HkXvvMlZTtJBqhr6uoCRjIUljlpsLj8r9wXOrXfe0gVyRnXWXamZ/Oek7o4INTYmn
         4WY5aUxMV+B2Q4RDY+D+xQEZdczxtCCh5pd8nzhGSm/OxTvmEzToRCa83mjMGGBeOTUC
         U88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747045203; x=1747650003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9DUP+l0MFXiogaS2mLshxsj8yb29EDfG184TPkYXMIs=;
        b=RVceKL2ic7+w70SVVyvtGCVz83bA+JewpsGam047evfJrEwa1X3OWXq8Nby57TXwUf
         AdRg49Wxvg+P2KX5cIBCOJa3RarboZspJGkpUBy0Og4X3gELqFrJHUryNZCJhqnphWBD
         ezUN+SBu1055eABm5O+k7j4FN2w32y6tUguR7UO6RpBVTi4CGizOHj5qMfHq/sUc2B5l
         /Q+i9zcR2FQYZR6sDMiZ+Nj8V1AwSIHkLMjxkkac4xVp/o3K5AaSjipG/rszdwceB60h
         8PZ/EDu+WW8mFzCuxrJESQC9udalXQXqiqCRsBKxaz8iEUeUpf0zgYcpYUu4spp8usrU
         X+9Q==
X-Gm-Message-State: AOJu0Yz7bD3gmzjIVmM+u3CFD8+UeltKG4MpL7gJ4as15kSNBYHWJy7m
	RuH1gyLuvLVkdXXFHvb2+VUajBc1ZQOxgBLa6/tCo5i1HFykJiBx2H+8PkWZFSAMKxVY0yQbQFs
	W
X-Gm-Gg: ASbGncucn4mRptQBT2AteUujzYl5YiXuqpFovev2MU2omM1WPFomn8fmq+6TAPjzgyF
	axocZ/HlpHVr2d1ivbVBb/NdDV0ozgQU6I2hnY8edgSv5gTKRtjfC8SR2y9fqlGXKzhDaP/N1sh
	Z+4iXHJRtIqU/+FFZAQcYCpISsfXBRvYiwNh9GRQBXkZkpnZMC1rdihWi+f8L8SRcL7Pd4nJF1p
	/QMTddnBL3+IMIQjE7F7SYs2EQ2KlMa0jhYBO3GVXY60mPLCgtjsiq0806fsm5Is4bW+Yy8szOE
	bWPcTEejf6NaigPoSetv0yci+ss5zQ2KRW2L7uZu5XGilqovRUcfy+G6
X-Google-Smtp-Source: AGHT+IGzEKu1Y21ktu6UuxKUfZP37D2ECyvD1XKW+ik8XiVfIjVor+Ogo0ELQrdTOTuMFMfzsYHm7g==
X-Received: by 2002:a17:90b:1fcc:b0:2ee:dd9b:e402 with SMTP id 98e67ed59e1d1-30c3cff2babmr25473592a91.12.1747045203321;
        Mon, 12 May 2025 03:20:03 -0700 (PDT)
Received: from localhost ([2401:4900:1cb9:9be3:2edb:7ff:fe58:f2f5])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30c4ae5e81esm5652566a91.23.2025.05.12.03.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 03:20:03 -0700 (PDT)
From: Sanchayan Maity <sanchayan@asymptotic.io>
To: linux-bluetooth@vger.kernel.org
Cc: Arun Raghavan <arun@asymptotic.io>,
	Sanchayan Maity <sanchayan@asymptotic.io>
Subject: [PATCH BlueZ 1/2] shared/asha: Don't wait for status notification on stop
Date: Mon, 12 May 2025 15:49:51 +0530
Message-ID: <20250512101952.70203-2-sanchayan@asymptotic.io>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512101952.70203-1-sanchayan@asymptotic.io>
References: <20250512101952.70203-1-sanchayan@asymptotic.io>
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

