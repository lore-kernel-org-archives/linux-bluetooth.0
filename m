Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280101EEA5F
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 16:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323169; cv=none; b=INd7az++nh60h9ObLfUORAQ4qAHstQOEalbEG3sqHJoG3rgzumcxnd2xFQn5s8PzXiZXqJO2/h9fLroHS5F8zLCVVoPVfx9YfZsSCvWW+QsrH9eiBiWImgCZw0G0Q7qV2BT5fmjBUg3Dr+9U1YicYZqeso2XK4cw4elYPYvmb+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323169; c=relaxed/simple;
	bh=/wZxtbhhp/fZSAxoaFMBpK9zHu9WYI+O1xLg7sOVpA0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gf+VwtsZu9EJYfNQLfA0k/u+l96lF3LbV7IpLswsI5VeVXSNu6RzQFLnOooTw3A5aMCNiTZLiklJXr9KfOtcRXv1V8JRFJvFJb+KPWx3m0dOwZZjfGT+Y14xGqZRpFZRa8P4vaabVQ/ApA0d/3KeAn9++WJ4tveZXw/TFaXebk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfV0B6Op; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfV0B6Op"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-556a4651cfcso803067e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Oct 2025 09:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761323164; x=1761927964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EsTo5GNmHpEVYtCUH4QrdfN7DdS3/zVcmlk1BgnNuIk=;
        b=SfV0B6OpVVLIaFazBScMLU9c5r8oQMLC6JNijhyv9AeKb6ex1M09cZd4r4DrYtxtN/
         dt69bWIQPPAus6GPRE2d5Cd1Ogvs+wqhPxPQwDFgtrHngFt86rS5QCZ+8ujvTtJKPD5w
         IuMIvQxVBsRLc5IBUl4+jNTqCE1/LKU7HbpjPP8/Q8N/X6ZWWbvbE5CTPDfvEPpWLK7C
         BE1GHBFTKWlDSdywWf9KHpV/cpamdSvmBV63kZL1JJIVpEkwJN2hiNYG4DGWagX1DNkX
         f78/TWPlyE98a1+HFWr6KRkOLI+NNesL0d2CWNbqqHhelpi+FER9HfCBUHBdBQzn0Xs6
         3drg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761323164; x=1761927964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EsTo5GNmHpEVYtCUH4QrdfN7DdS3/zVcmlk1BgnNuIk=;
        b=KnlH2G6r6H2XTxWo4AZ5Uj14wqW0Vn9HFEWKOu9fG4JE4KdruaGfIPBdr/6I64W3QJ
         r9xqzxnpN72omofb0AYEcJMDkLxL5kJRZuVxUErKifKgbsSEEPHbY/b07AIHXXB+p1cG
         zDek58DtVfzprsb3ATjuCcqdZwIXbOwKp6x2jbgz0hBeWXwgsgkzeNbLfhyjFiwe+sNf
         QdAX3hADxJJquK3WPxiIgVKW6Vyf/C7JCCdNl1OcIZrzOzxsdYid0LztnuHJOkq4BTND
         CD5a0fg+9rMhxVXMjFuSoXJLrK3qihy1sNLn1Q0SCtQbzsAh9vfVFWNJZxvyQ/t47+TG
         ohtw==
X-Gm-Message-State: AOJu0YzKHxi0jnYiVI7ZECRV1KYPztmSQ6xN42aAyXYXVRYBFO4Rousw
	Ibg9v61jzrlmL970qFZjgtKb5sZVSdPc0gOLSDviEA9eiqrQjUxnCDzASFobbw==
X-Gm-Gg: ASbGncuB88YouJRzGBz8dLLcHvcw0j77NYEyN9l67nZuukQoKMctV7A+IraT0wh3XVb
	QT/AaZuCwsWRCTuSHTuCut/kMf1QuutWEHVodpZOzXOC7ca0aH4guOCIkrdFQRML9IVnxgrfG/f
	PlNqNHie45k42wJy0qVztKB5BYHV3ARguZ9gTsrxuRVVp3uLWcsfwTeQIp5jAkb6C1agqf9Na5H
	tQdx7RMJMfuHh/DuwrrBYAD8V4D6W0A+lIEkmMUJ9cL5OvShHgY+2LgRCcNITbYxBNmhcNxyn4Y
	12bwzzjRnzTlLlUuPSlbpIHU0rCXi5YwSiR0K9TLsB8nnFNKGM1FUdH3ABGZtH8e7ePs8/iBRCM
	AQv3PkP9wkUfPqb85VCTX2K5hXagZW1aZSi70rIlzGveaXboW1aTbJT4BUSdSjU+25JKa5RUpwy
	3mTmK5RKNXHM7X3Q==
X-Google-Smtp-Source: AGHT+IE/g1DAIPH1Dxs0rws9IYS/0W9/qIwuPoutvKwFdwbRx5I+LC+B57zz29ISeOy4RN2YDXPfmw==
X-Received: by 2002:a05:6122:860d:b0:557:cc2d:edf3 with SMTP id 71dfb90a1353d-557cc2df3bfmr1182534e0c.11.1761323164197;
        Fri, 24 Oct 2025 09:26:04 -0700 (PDT)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557bef22a61sm2386516e0c.24.2025.10.24.09.26.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:26:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] bass: Fix handling of BT_BASS_MOD_SRC
Date: Fri, 24 Oct 2025 12:25:53 -0400
Message-ID: <20251024162553.469037-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If BT_BASS_MOD_SRC is received and the sync_state is set to
BT_BASS_SYNCHRONIZED_TO_PA it doesn't necessarily mean that the device
shall be removed, specially in case the assistant and broadcast source
are the same device.

In order to fix this behavior this attempts to free the setups that were
used for the BIS being modified, then if all setups are freed in the
process proceed to disconnect the service and then check if the
device is still considered connected after that, only if is not
connected then remove it.
---
 profiles/audio/bass.c | 139 +++++++++++++++++++++++++-----------------
 1 file changed, 82 insertions(+), 57 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index d42740ca4afb..6501d361e6ee 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -335,6 +335,25 @@ static bool link_enabled(const void *data, const void *match_data)
 			bt_bap_stream_get_io(stream));
 }
 
+static void setup_free(void *data)
+{
+	struct bass_setup *setup = data;
+
+	DBG("setup %p", setup);
+
+	util_iov_free(setup->qos.bcast.bcode, 1);
+	util_iov_free(setup->meta, 1);
+	util_iov_free(setup->config, 1);
+	free(setup->path);
+
+	/* Clear bis index from the bis sync bitmask, if it
+	 * has been previously set.
+	 */
+	bt_bass_clear_bis_sync(setup->dg->src, setup->bis);
+
+	free(setup);
+}
+
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
@@ -426,6 +445,8 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 	case BT_BAP_STREAM_STATE_IDLE:
 		bt_bass_clear_bis_sync(dg->src, bis);
 		setup->stream = NULL;
+		queue_remove(setup->dg->setups, setup);
+		setup_free(setup);
 		break;
 	}
 }
@@ -695,23 +716,6 @@ static void bap_attached(struct bt_bap *bap, void *user_data)
 	btd_service_set_user_data(service, dg);
 }
 
-static void setup_free(void *data)
-{
-	struct bass_setup *setup = data;
-
-	DBG("setup %p", setup);
-
-	util_iov_free(setup->qos.bcast.bcode, 1);
-	util_iov_free(setup->meta, 1);
-	util_iov_free(setup->config, 1);
-	free(setup->path);
-
-	/* Clear bis index from the bis sync bitmask, if it
-	 * has been previously set.
-	 */
-	bt_bass_clear_bis_sync(setup->dg->src, setup->bis);
-}
-
 static bool match_device(const void *data, const void *match_data)
 {
 	const struct bass_data *bdata = data;
@@ -720,6 +724,41 @@ static bool match_device(const void *data, const void *match_data)
 	return bdata->device == device;
 }
 
+static void delegator_free(struct bass_delegator *dg)
+{
+	DBG("%p", dg);
+
+	if (dg->io_id)
+		g_source_remove(dg->io_id);
+
+	if (dg->io) {
+		g_io_channel_shutdown(dg->io, TRUE, NULL);
+		g_io_channel_unref(dg->io);
+	}
+
+	queue_destroy(dg->setups, setup_free);
+
+	/* Update Broadcast Receive State characteristic value and notify
+	 * peers.
+	 */
+	if (bt_bass_set_pa_sync(dg->src, BT_BASS_NOT_SYNCHRONIZED_TO_PA))
+		DBG("Failed to update Broadcast Receive State characteristic");
+
+	/* Unregister BAP stream state changed callback. */
+	bt_bap_state_unregister(dg->bap, dg->state_id);
+
+	bt_bap_bcode_cb_unregister(dg->bap, dg->bcode_id);
+
+	if (dg->timeout)
+		g_source_remove(dg->timeout);
+
+	queue_destroy(dg->bcode_reqs, free);
+
+	free(dg->bcode);
+
+	free(dg);
+}
+
 static void bap_detached(struct bt_bap *bap, void *user_data)
 {
 	struct btd_service *service;
@@ -755,37 +794,7 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 	if (!dg)
 		return;
 
-	DBG("%p", dg);
-
-	if (dg->io_id)
-		g_source_remove(dg->io_id);
-
-	if (dg->io) {
-		g_io_channel_shutdown(dg->io, TRUE, NULL);
-		g_io_channel_unref(dg->io);
-	}
-
-	queue_destroy(dg->setups, setup_free);
-
-	/* Update Broadcast Receive State characteristic value and notify
-	 * peers.
-	 */
-	if (bt_bass_set_pa_sync(dg->src, BT_BASS_NOT_SYNCHRONIZED_TO_PA))
-		DBG("Failed to update Broadcast Receive State characteristic");
-
-	/* Unregister BAP stream state changed callback. */
-	bt_bap_state_unregister(dg->bap, dg->state_id);
-
-	bt_bap_bcode_cb_unregister(dg->bap, dg->bcode_id);
-
-	if (dg->timeout)
-		g_source_remove(dg->timeout);
-
-	queue_destroy(dg->bcode_reqs, free);
-
-	free(dg->bcode);
-
-	free(dg);
+	delegator_free(dg);
 
 	btd_service_set_user_data(service, NULL);
 }
@@ -1468,22 +1477,37 @@ static int handle_mod_src_req(struct bt_bcast_src *bcast_src,
 
 	switch (sync_state) {
 	case BT_BASS_SYNCHRONIZED_TO_PA:
-		if (params->pa_sync == PA_SYNC_NO_SYNC) {
-			struct btd_adapter *adapter =
-					device_get_adapter(dg->device);
+		bass_update_bis_sync(dg, bcast_src);
 
+		/* Check if there are any setups left since it means the PA
+		 * should be no longer synchronized.
+		 */
+		if (queue_isempty(dg->setups)) {
+			/* IO is no longer needed since there are no setups */
 			g_io_channel_shutdown(dg->io, TRUE, NULL);
 			g_io_channel_unref(dg->io);
 			dg->io = NULL;
 
-			bt_bass_set_pa_sync(dg->src,
-				BT_BASS_NOT_SYNCHRONIZED_TO_PA);
+			if (!dg->service)
+				return 0;
 
-			/* Remove device of BIS source*/
-			btd_adapter_remove_device(adapter, dg->device);
-		} else {
-			bass_update_bis_sync(dg, bcast_src);
+			/* Disconnect service so BAP driver is cleanup
+			 * properly.
+			 */
+			btd_service_disconnect(dg->service);
+
+			/* If the device is no longer consider connected
+			 * it means no other service was connected so it
+			 * has no longer any use and can be safely removed.
+			 */
+			if (!btd_device_is_connected(dg->device)) {
+				struct btd_adapter *adapter;
+
+				adapter = device_get_adapter(dg->device);
+				btd_adapter_remove_device(adapter, dg->device);
+			}
 		}
+
 		break;
 	case BT_BASS_NOT_SYNCHRONIZED_TO_PA:
 		if (params->pa_sync == PA_SYNC_NO_PAST) {
@@ -1720,6 +1744,7 @@ static void bass_remove(struct btd_service *service)
 
 	bass_data_remove(data);
 }
+
 static int bass_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
-- 
2.51.0

