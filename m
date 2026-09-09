Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94FA3B47D5
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981812; cv=none; b=GAgRt/qFXu87aNnU5EV8I7LM85NN20fWrqvEzmFFtUX4J2mBKtheJfnT+PouInB5nthsFEAnZxBKcc1bSO6ePuYEyhrJ4/KI6whB/lkyHmllWgRT39CEyisfFV/b4PSm4TLyD72XBDyHGVq0Xeb65AAEfLXMnCxjLQTlFCelee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981812; c=relaxed/simple;
	bh=+GtsRwuwUBK3NpdrRNlbiecnFj4KlwmLSmHRFSVm3FE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGQ3moZs73Pb8cHYDOUEPGsZaZeFwgRNxZ7hqXgJxF1u2TEfUzWptkBoPnShh+saRC8iB/Kj9CTmPmZ+RGTjF7F7OwbRQqllPYOH1ddL1gI6ti2iqiPHzypDFAc1dEdA8B6aT3F/sd7WhoQ+ff8+ryaTm20GLuSuGZOAY78F41k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ykq0keER; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ykq0keER"
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-97c441e66f0so3705270241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 12:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981809; x=1789586609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gdFea15jHfSIvO/syohBeszqCy6Nq144v4Dj4HKuNfI=;
        b=Ykq0keERUKIGmbF8ADVi4hr8x12b9re8F+P6vs4uOh76cKINaqf/UhN2U9zwlKwG/X
         RgzumVBzSwNU5TipPO+axVml0s/1hghnkLKW1l7haxdXRG/GeTHv/f6pmfh7cyzX6fZt
         ZWNydycnq267sUkM1XdsZFF1VNHYg029hHfSJ/W1MMB+m8FMScVuj8EJBP/t2ERTjq3c
         mOxW3vC6wX1Ty9te/HTyjo7aQR7ENZ0kEjsfd6B8wMgrhnnr2CdhqviyO6ygMrJWefC5
         rJ1X+51dUn9Wz8WyavoXI6bta8+/cQO1VyeZwE6EZqp1HbrY/SKzyoIPbw1FOT8gjSyg
         bJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981809; x=1789586609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gdFea15jHfSIvO/syohBeszqCy6Nq144v4Dj4HKuNfI=;
        b=Jmazja6dbnDGLHpthZTUG6Mgg29REn+ho1Un8HkjkcebMucDTYb0Qdw2q3gX3qLBhH
         XBdI9bbPkiZFSguThYdOmQ5HYGR7NBbbzm+yaju5bRXYBlBquweCNfP/4Q6piKvqZoFF
         jOtDTwiRI0GL/RCuHa/1mivNLgC9Q3PXTqPwl2CWm55iKcR+v6UkjQjS14+Pg+HY54L+
         YwBiYvI6y6v1ewlwnYwgAMXUEC64Fqbb7Jb69mEMq28qJHQORUL7yNYGbCkBuLB4n1NA
         TlPvPbKJhLGDb38PkgZiSIHRH1pSPLlVtRL/RGLWH4KkwyyKBj1pxKq/DKxbyoAVjdaT
         UxBg==
X-Gm-Message-State: AFuF++nqq54tR5Gi4445SuIyYCZnVWdx9V7TITyvqWUtkDJk7lTX9gEO
	woFiGd93dwt8JWiXRBalgo/peIfy0/uEwqnse/yXO4hmQ5tQjvaZjmqkXxEhKn55
X-Gm-Gg: AYBFou0M3s/XgsOdVfEwRXr5M2bXns416wXqbaoi/DzFoisYH2YhVzsGk0gv34VMvCX
	S5cYtt4XGCDryt7bw9pefsrDKevq7IxCdTIGe1PPL4SAbXwiSVC7pFuKwRqQqjyAWLOcsFQeYkN
	sGfccIVSi2BVNDbx0caEvjz7XzVBEAOYsWx05834SE5v+orw2HmYW0tbAS95s8WDG7Y0Rha73i4
	WG9VXLOeaUiuCLQbSz0yPmE5hYyWnxOCB1NrPPayWOqmQeeLv7ldx0dNZgAnfgL3tzrxkC3l/mj
	0SheNXpd5RpETIvJtj5DPV2hpH9JAZqqVSfQrOV/3kyDECEX+TXW2E/ybZIS4ZeeM1aMwp1hTlx
	YPOrlJp/GVs7o1O26obrFlz3PT4vM7s/wYzo6OM5fmQ/0oCUBR/n+yK90SXJieopPmbmm5eli67
	Mq+YZDYp3jRWvtj8JxnJlxMOzI4PJFzYK0SU2ATcYzUF5aEtld1k4LnDrMzh8JmEZnNdwPzAszp
	E46Tk/MGPWzq+mC+9s0+vB+a7rahasN88Y6b+rgxiPQoZuUx9o=
X-Received: by 2002:a05:6102:e0d:b0:778:636c:71cb with SMTP id ada2fe7eead31-78a4a9c40c1mr19543448137.10.1788981809122;
        Wed, 09 Sep 2026 12:23:29 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee8039csm13162744241.11.2026.09.09.12.23.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:23:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 12/12] bap: reuse the PA sync established to discover a Broadcast Source
Date: Wed,  9 Sep 2026 15:23:08 -0400
Message-ID: <20260909192308.1306567-13-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909192308.1306567-1-luiz.dentz@gmail.com>
References: <20260909192308.1306567-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A Broadcast Sink creates a short lived PA sync to read the BASE of a
Broadcast Source, closes it, and creates a new one once a stream is
enabled, as syncing to the BIG requires a PA sync. The second sync has
to be established again before the BIG sync can be requested, which
delays the start of the stream.

Keep the sync of the BIG Info report around instead, and reuse it, but
only while there is nothing else to discover, as a sync holds resources
that are needed to discover other Broadcast Sources: it is released as
soon as another source is probed, and after a grace timeout if no
stream is enabled in the meantime.

Assisted-by: opencode:claude-opus-5
---
 profiles/audio/bap.c | 115 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 107 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ff8f58a12091..5771c9ae0fdf 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -139,6 +139,8 @@ struct bap_data {
 	struct queue *bcast_snks;
 	struct queue *server_streams;
 	GIOChannel *listen_io;
+	bool pa_synced;
+	unsigned int pa_timer;
 	unsigned int io_id;
 	unsigned int cig_update_id;
 	bool services_ready;
@@ -176,6 +178,9 @@ static void bap_data_free(struct bap_data *data)
 {
 	struct queue *bcast_snks = data->bcast_snks;
 
+	if (data->pa_timer)
+		g_source_remove(data->pa_timer);
+
 	if (data->listen_io) {
 		g_io_channel_shutdown(data->listen_io, TRUE, NULL);
 		g_io_channel_unref(data->listen_io);
@@ -1560,6 +1565,63 @@ static void bis_handler(uint8_t sid, uint8_t bis, uint8_t sgrp,
 									path);
 }
 
+/* Time a PA sync is kept around waiting for a stream to be enabled,
+ * before it is released.
+ */
+#define PA_SYNC_GRACE_TIMEOUT 5
+
+static void pa_sync_release(struct bap_data *data)
+{
+	if (!data->pa_synced)
+		return;
+
+	DBG("Release PA sync");
+
+	if (data->pa_timer) {
+		g_source_remove(data->pa_timer);
+		data->pa_timer = 0;
+	}
+
+	if (data->listen_io) {
+		g_io_channel_shutdown(data->listen_io, TRUE, NULL);
+		g_io_channel_unref(data->listen_io);
+		data->listen_io = NULL;
+	}
+
+	data->pa_synced = false;
+}
+
+static gboolean pa_sync_timeout(gpointer user_data)
+{
+	struct bap_data *data = user_data;
+
+	data->pa_timer = 0;
+	pa_sync_release(data);
+
+	return FALSE;
+}
+
+static bool pa_sync_pending(const void *data, const void *match_data)
+{
+	const struct bap_data *bdata = data;
+
+	if (bdata == match_data)
+		return false;
+
+	/* A session with a listener that has not synced yet is still
+	 * discovering a Broadcast Source.
+	 */
+	return bdata->listen_io && !bdata->pa_synced;
+}
+
+static void pa_sync_release_session(void *data, void *user_data)
+{
+	struct bap_data *bdata = data;
+
+	if (bdata != user_data)
+		pa_sync_release(bdata);
+}
+
 static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
@@ -1591,10 +1653,21 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 	g_io_channel_unref(data->listen_io);
 	data->listen_io = NULL;
 
-	/* For short-lived PA, the sync is no longer needed at
-	 * this point, so the io can be closed.
-	 */
-	g_io_channel_shutdown(io, TRUE, NULL);
+	if (queue_find(sessions, pa_sync_pending, data)) {
+		/* Other Broadcast Sources are still being discovered, so the
+		 * sync is closed to not hold the resources needed for them.
+		 */
+		g_io_channel_shutdown(io, TRUE, NULL);
+	} else {
+		/* Nothing else to discover: keep the sync for a while, as
+		 * syncing to the BIG requires one, so it does not have to be
+		 * established again if a stream is enabled.
+		 */
+		data->listen_io = g_io_channel_ref(io);
+		data->pa_synced = true;
+		data->pa_timer = g_timeout_add_seconds(PA_SYNC_GRACE_TIMEOUT,
+							pa_sync_timeout, data);
+	}
 
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
@@ -3592,6 +3665,11 @@ static int pa_sync(struct bap_data *data)
 
 	DBG("Create PA sync with this source");
 
+	/* Release any sync kept by another session, as it is not needed
+	 * to discover this source.
+	 */
+	queue_foreach(sessions, pa_sync_release_session, data);
+
 	data->listen_io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, data,
 		NULL, &err,
 		BT_IO_OPT_SOURCE_BDADDR,
@@ -3662,10 +3740,12 @@ static gboolean iso_do_big_sync(GIOChannel *io, GIOCondition cond,
 
 	DBG("BIG info received, do BIG sync");
 
-	g_io_channel_unref(data->listen_io);
-	g_io_channel_shutdown(data->listen_io, TRUE, NULL);
-	data->listen_io = io;
-	g_io_channel_ref(data->listen_io);
+	if (data->listen_io != io) {
+		g_io_channel_unref(data->listen_io);
+		g_io_channel_shutdown(data->listen_io, TRUE, NULL);
+		data->listen_io = io;
+		g_io_channel_ref(data->listen_io);
+	}
 
 	/* Append each linked BIS to the BIG sync request */
 	append_setup(setup->stream, &iso_bc_addr);
@@ -3714,6 +3794,25 @@ static void pa_and_big_sync(struct bap_setup *setup)
 {
 	GError *err = NULL;
 	struct bap_data *bap_data = setup->data;
+
+	if (bap_data->pa_synced) {
+		DBG("Reuse PA sync with this source");
+
+		/* The sync is in use from now on, so it is not released
+		 * while the BIG sync is being set up.
+		 */
+		bap_data->pa_synced = false;
+
+		if (bap_data->pa_timer) {
+			g_source_remove(bap_data->pa_timer);
+			bap_data->pa_timer = 0;
+		}
+
+		bap_data->io_id = g_io_add_watch(bap_data->listen_io, G_IO_OUT,
+							iso_do_big_sync, setup);
+		return;
+	}
+
 	DBG("Create PA sync with this source");
 
 	bap_data->listen_io = bt_io_listen(NULL, long_pa_sync_confirm_cb, setup,
-- 
2.55.0

