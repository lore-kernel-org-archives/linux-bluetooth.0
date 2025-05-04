Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B80D146A72
	for <linux-bluetooth@vger.kernel.org>; Sun,  4 May 2025 16:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746374544; cv=pass; b=q8+qC8FIrW1ahbGBYR53FFBff3DBqaAwiU9wnvfTTivAMwnNue5vZxU4yOxzq8kO6Sge9NieLaDurd86uuhuXLVNYukLqeGVeZZ8MRo6SCgvknzQVwxP/vsH8tk29bF0KxglmfRggXnqSjgdCaB0FIKLr819ocEFM5eIB/80vaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746374544; c=relaxed/simple;
	bh=UNT2KJVtcRN5DvwjG1mcVTLxxALZm78kpkCPz0Va+nQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ovEVy81hswedcQ4poN5Ty/9qfFQeHgmBFp1iRrDwmIB94FJpxF9WJoa4k6awCIuX/HmiViaXd4R9s5yMlQ9irf/wqZWF5ta6waFw7cpPAYHfd/+gXYXBV8EHZKeQimI9IkEGkPEApNvT9x5WCZkfQbBtp4rFLVGMEDpfEeQp3CU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Zk+OAECg; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Zk+OAECg"
Received: from monolith.lan (unknown [185.77.218.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Zr8Yh45Vgz10F9;
	Sun,  4 May 2025 19:02:16 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1746374536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p91dG9VMLPxEXrslQmhBYgA9RFNaQ1iKD+9yuU5bGg0=;
	b=Zk+OAECgqWFby9W79Y8SgEeAW8c38TgwvaxV93+ETaUYqN2JDV2M78k+cgXiHfLlq+mg42
	Rmcs8k6Bv9MNDga8mT2Oz4HnwaCRQOVlZ//UzV/0sRRaT+ldagrQY3AB5xiwL7i2jZ2cLU
	zxbnRg1jiDKSYL5biQr2twR39e/K6v8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1746374536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p91dG9VMLPxEXrslQmhBYgA9RFNaQ1iKD+9yuU5bGg0=;
	b=Q6IEXALTsDaWyQ/ZaK0y8md0iMGcPsqyZeOggXZL/0DWQ6SY1vAL3KcbJVeSmHQklXGwU6
	giouYxNVsmXfuTOI+RJlMKoGsMyPaK/jCF8glubaJomSOyafd8cIftVLJZK5tuMHcwzurW
	8/QBkXaQLDTfPpbkkfb0JQnaTwr4IBE=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1746374536; a=rsa-sha256; cv=none;
	b=tTJGs/Hjcy6Anfk/HQ7r1rYHPM4MELrsxz0gvJCBoy7iPnqJTpqtUsE35w3dJr/vHVnhmq
	yC28xLhSTcwO++0lG6w4gGod4VKutFijLNor34jfyM+3k1CqNgXIUgYRxRwfaDtBn1uyWy
	TQjjI5Cfpyc4eWdWwuJYwrvQdOQk1Nw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH BlueZ v2 11/11] bap: delay recreating IO after ongoing configuration
Date: Sun,  4 May 2025 19:02:03 +0300
Message-ID: <04be9eb6246b1dad5234c3ddcb8eeda4ba3500aa.1746374514.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
References: <3c9eb72cf7b16ea0b710d62221436e2777f7360b.1746374514.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Delay creating IO if setup reconfiguration is ongoing.

TODO: this is not fully right, also new stream QoS should be delayed if
CIG is active, so that it doesn't get assigned into a new CIG which
controllers may not support
---
 profiles/audio/bap.c | 108 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 81 insertions(+), 27 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 20d610e6f..ce1c349c6 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -86,6 +86,7 @@ struct bap_setup {
 	bool cig_active;
 	uint8_t sid;
 	bool config_pending;
+	bool readying;
 	bool closing;
 	struct iovec *caps;
 	struct iovec *metadata;
@@ -727,15 +728,23 @@ fail:
 	return -EINVAL;
 }
 
+static void setup_recreate_cig(struct bap_setup *setup);
+
 static void setup_ready(struct bap_setup *setup, int code,
 							uint8_t reason)
 {
-	if (!setup->ready_cb)
+	if (!setup->readying)
 		return;
 
-	setup->ready_cb(setup, code, reason, setup->ready_cb_data);
-	setup->ready_cb = NULL;
-	setup->ready_cb_data = NULL;
+	setup->readying = false;
+
+	if (setup->ready_cb) {
+		setup->ready_cb(setup, code, reason, setup->ready_cb_data);
+		setup->ready_cb = NULL;
+		setup->ready_cb_data = NULL;
+	}
+
+	setup_recreate_cig(setup);
 }
 
 static void qos_cb(struct bt_bap_stream *stream, uint8_t code, uint8_t reason,
@@ -770,7 +779,7 @@ static int setup_qos(struct bap_setup *setup)
 
 	setup_create_io(data, setup, stream, true);
 	if (!setup->io) {
-		error("Unable to create io");
+		DBG("io pending");
 		goto error;
 	}
 
@@ -1741,6 +1750,8 @@ static int setup_config(struct bap_setup *setup, bap_setup_ready_func_t cb,
 	if (!setup->id)
 		return -EINVAL;
 
+	setup->readying = true;
+
 	switch (bt_bap_stream_get_type(setup->stream)) {
 	case BT_BAP_STREAM_TYPE_UCAST:
 		setup->config_pending = true;
@@ -2215,7 +2226,11 @@ static bool match_cig_active(const void *data, const void *match_data)
 	const struct bap_setup *setup = data;
 	const struct cig_busy_data *info = match_data;
 
-	return (setup->qos.ucast.cig_id == info->cig) && setup->cig_active;
+	if (info->cig != BT_ISO_QOS_CIG_UNSET &&
+					setup->qos.ucast.cig_id != info->cig)
+		return false;
+
+	return setup->cig_active || setup->readying;
 }
 
 static bool cig_busy_ep(const void *data, const void *match_data)
@@ -2242,6 +2257,10 @@ static bool is_cig_busy(struct bap_data *data, uint8_t cig)
 {
 	struct cig_busy_data info;
 
+	/* TODO: this is not quite right --- it may results to allocation of a
+	 * new CIG which won't work if controller supports only one. Instead we
+	 * should be delaying stream QoS until CIG deactivates.
+	 */
 	if (cig == BT_ISO_QOS_CIG_UNSET)
 		return false;
 
@@ -2251,30 +2270,22 @@ static bool is_cig_busy(struct bap_data *data, uint8_t cig)
 	return queue_find(sessions, cig_busy_session, &info);
 }
 
-static gboolean setup_io_recreate(void *user_data)
-{
-	struct bap_setup *setup = user_data;
-
-	DBG("%p", setup);
-
-	setup->io_id = 0;
-
-	setup_create_io(setup->ep->data, setup, setup->stream, true);
-
-	return FALSE;
-}
-
 static void setup_recreate(void *data, void *match_data)
 {
 	struct bap_setup *setup = data;
 	struct cig_busy_data *info = match_data;
 
-	if (setup->qos.ucast.cig_id != info->cig || !setup->recreate ||
-						setup->io_id)
+	if (info->cig != BT_ISO_QOS_CIG_UNSET &&
+			setup->qos.ucast.cig_id != BT_ISO_QOS_CIG_UNSET &&
+			setup->qos.ucast.cig_id != info->cig)
+		return;
+	if (!setup->recreate || !setup->stream)
 		return;
 
+	DBG("%p", setup);
+
 	setup->recreate = false;
-	setup->io_id = g_idle_add(setup_io_recreate, setup);
+	setup_create_io(setup->ep->data, setup, setup->stream, true);
 }
 
 static void recreate_cig_ep(void *data, void *match_data)
@@ -2284,6 +2295,34 @@ static void recreate_cig_ep(void *data, void *match_data)
 	queue_foreach(ep->setups, setup_recreate, match_data);
 }
 
+static void setup_reenable(void *data, void *match_data)
+{
+	struct bap_setup *setup = data;
+	struct cig_busy_data *info = match_data;
+
+	if (info->cig != BT_ISO_QOS_CIG_UNSET &&
+			setup->qos.ucast.cig_id != BT_ISO_QOS_CIG_UNSET &&
+			setup->qos.ucast.cig_id != info->cig)
+		return;
+	if (!setup->recreate || !setup->stream)
+		return;
+
+	DBG("%p", setup);
+
+	switch (bt_bap_stream_get_state(setup->stream)) {
+	case BT_BAP_STREAM_STATE_ENABLING:
+		setup_create_io(setup->ep->data, setup, setup->stream, false);
+		break;
+	}
+}
+
+static void reenable_cig_ep(void *data, void *match_data)
+{
+	struct bap_ep *ep = data;
+
+	queue_foreach(ep->setups, setup_reenable, match_data);
+}
+
 static void recreate_cig_session(void *data, void *match_data)
 {
 	struct bap_data *session = data;
@@ -2294,13 +2333,19 @@ static void recreate_cig_session(void *data, void *match_data)
 
 	queue_foreach(session->snks, recreate_cig_ep, match_data);
 	queue_foreach(session->srcs, recreate_cig_ep, match_data);
+
+	queue_foreach(session->snks, reenable_cig_ep, match_data);
+	queue_foreach(session->srcs, reenable_cig_ep, match_data);
 }
 
-static void recreate_cig(struct bap_setup *setup)
+static void setup_recreate_cig(struct bap_setup *setup)
 {
 	struct bap_data *data = setup->ep->data;
 	struct cig_busy_data info;
 
+	if (is_cig_busy(setup->ep->data, setup->qos.ucast.cig_id))
+		return;
+
 	info.adapter = device_get_adapter(data->device);
 	info.cig = setup->qos.ucast.cig_id;
 
@@ -2309,25 +2354,34 @@ static void recreate_cig(struct bap_setup *setup)
 
 	if (setup->qos.ucast.cig_id == BT_ISO_QOS_CIG_UNSET) {
 		recreate_cig_ep(setup->ep, &info);
+		reenable_cig_ep(setup->ep, &info);
 		return;
 	}
 
 	queue_foreach(sessions, recreate_cig_session, &info);
 }
 
+static gboolean recreate_cig_cb(void *user_data)
+{
+	struct bap_setup *setup = user_data;
+
+	setup->io_id = 0;
+	setup_recreate_cig(setup);
+	return FALSE;
+}
+
 static void setup_io_disconnected(int cond, void *user_data)
 {
 	struct bap_setup *setup = user_data;
 
-	DBG("%p recreate %s", setup, setup->recreate ? "true" : "false");
-
 	setup->io_id = 0;
 
+	DBG("%p recreate %s", setup, setup->recreate ? "true" : "false");
+
 	setup_io_close(setup, NULL);
 
 	/* Check if connecting recreate IO */
-	if (!is_cig_busy(setup->ep->data, setup->qos.ucast.cig_id))
-		recreate_cig(setup);
+	setup->io_id = g_idle_add(recreate_cig_cb, setup);
 }
 
 static void bap_connect_bcast_io_cb(GIOChannel *chan, GError *err,
-- 
2.49.0

