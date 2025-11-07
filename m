Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED872F6599
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Nov 2025 20:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546728; cv=none; b=MJj/SNjUAcH+Kt75Z31mc5Omla/z4Br2Qoxjvr9smz/CB8zLq8V0RZPdoqzzc8CvmmTsdOIun6VN5pGMlqRK7BrmtIyAfvN0AKs4YZ3NSVjm9bZtSHJM3xw52VHUYgnQEu2OTTqyDrqtw/QhApeYp/GylB5vVh9uYdROUvgipqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546728; c=relaxed/simple;
	bh=O8Tjgxi65zQlnvjeOm+qazynJnq3RiLDWvmU9upKhxI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eA3LBTbsE6xMM/FsmTOSCwP5X0xuwzaPooxinPTY1p095I+FaMh8w+zVby5Zwp6mFkqbtHXWLHsmTDhaZis+OGiIGTbTGi5lGJwbRGcU70X5XZncq/JneEarXTJGBLGSLRDB7+F3jOBacKZqs5MNjB/OSjNZD9uxaqM681JK0yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwXE0lDt; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwXE0lDt"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5597330a34fso784804e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Nov 2025 12:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762546725; x=1763151525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnioEKLUvZBVEpY9uD1HJxeI35K6OMh2tLHZhuiZNUE=;
        b=BwXE0lDtTZmry6CPEvuczLsAQ4ykYH1HEEi+autlrAo40pswsTCdxv7v5IEFm56fpF
         rCOGfAON61fzEhtbVHDwoeRsU3ls+MtvHfm3way2YN2hs05H+ahk67/MJf95xWwEH5ni
         AurVS8bJNFveFoI4VaokhJP+uYVdmynlZPfLt6m0LmW4cVM0t1++SQWENsOxuHyU4Rbg
         6PmynnYB0dkHku3WbiMzfYFbpq5/DMBPx5XDKvPy4WzmLBe3zKjKhUP9ypi0c+bxxCxm
         ZXh7ZCYhV8uD3AK6AcF187Fbvfa0sxvHWxzGTCisFsAaolglx7rDSV1bSzNciJ2INXxv
         Jx/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762546725; x=1763151525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fnioEKLUvZBVEpY9uD1HJxeI35K6OMh2tLHZhuiZNUE=;
        b=CNnzy30sC8hirFXXoW8gE+2MLCyWjyr0WTJ2CrWhrs3IIKAoaX8QicrGTiN9VWGT3b
         f1fb2t4riOSaRPgBVjNNYqPeCJi0Z7jwYmrbm6W8mMEDJoAyPt2v/Dw7f2UmJ2mcd7h7
         qym+HdIoXTf6HYofu0XjHfkzSf6yjVEx8qrT2BBLaGkLqGwPLOUAlZ8txP6Yh0J1GcvP
         +UJBmDI/kzJJpIbdcw/0gCkJdz80BMSsOPgeaAi/ck/rV14oWgqDUjTDYnxNmJsDn1YS
         qVey4rYsdilrBzQ81o4hxk1ZpZ+Wqu96iTUSDH916EzknYlShXz1wBiE2P7XiUPJYhjZ
         NiMg==
X-Gm-Message-State: AOJu0YyFt6UHNNDW37ioqUnJal81rxOEbOQ/IGVkzKR9CI4faSXS/ECD
	XksxAR85uAnADEmZQrsVcjLqJsgOWWG/rz5pqm9PXnCXS54Huy3b13bEGjBzYw==
X-Gm-Gg: ASbGncvFRySH4dAFBeVoVHU+WhmmnmsMB4hRUrQ3uw3lNGCZI4zoHs4PwOZLgs2Efsg
	jf5il3okwgIuLOKD/COlmO6ogn37MgJkxqT3ODmFx8eZSn0fTWgC5rikqL+q6IMEblT2hP2THCf
	fOhZq1ERJlhcIG877G5VY7bcgH8rNoJ/58DODgYFvjhRkqdDO2mh5NICgHxo9qomJ/IKNYAu1ll
	02RR6jBDT9z0dl3O1CELQPthAiOu2OVqfCTp2WWKYHrkW/aZoqE8x7WFI12OnEIFRiXG3KY4mAU
	dYXLjEzjePy/hTX5S+LKIGXGeAwF4OoUJjeIMZwJVfBjLMedUvV6bdSDmODdEO7JtweOsjxVaTX
	wSEPYs/r1+or2wKlfQ2A3PqwYJdTeQeaCaHmvljxNAevyMduf/l4JH71t/lJO+5TUJQmxcOvE8T
	up25D+e198aZB1zg==
X-Google-Smtp-Source: AGHT+IFCnzv4dAz5ONeM16mJuG9oyc4Y6mXrBa3haHTymsM01H+/t8ynMRboKr0zZVjxKnIT2+F2xQ==
X-Received: by 2002:a05:6122:17a4:b0:559:7077:9a8f with SMTP id 71dfb90a1353d-559b32252c7mr355471e0c.5.1762546724980;
        Fri, 07 Nov 2025 12:18:44 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5599582860asm3562921e0c.16.2025.11.07.12.18.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:18:43 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/5] bass: Fix not cleaning up delegator properly
Date: Fri,  7 Nov 2025 15:18:26 -0500
Message-ID: <20251107201827.1235953-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107201827.1235953-1-luiz.dentz@gmail.com>
References: <20251107201827.1235953-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When BIG sync is lost, or the assistant modify removing all streams,
delegator should be freed to so the assistant can start over and share
another stream.
---
 profiles/audio/bap.c  |  27 +++---
 profiles/audio/bass.c | 208 ++++++++++++++++++++++--------------------
 2 files changed, 126 insertions(+), 109 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index c10f019edfea..0883f6c47902 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3270,14 +3270,6 @@ static void pac_removed_broadcast(struct bt_bap_pac *pac, void *user_data)
 	ep_unregister(ep);
 }
 
-static bool match_device(const void *data, const void *match_data)
-{
-	const struct bap_data *bdata = data;
-	const struct btd_device *device = match_data;
-
-	return bdata->device == device;
-}
-
 static struct bap_data *bap_data_new(struct btd_device *device)
 {
 	struct bap_data *data;
@@ -3673,6 +3665,14 @@ static int bap_bcast_probe(struct btd_service *service)
 	return 0;
 }
 
+static bool match_service(const void *data, const void *match_data)
+{
+	const struct bap_data *bdata = data;
+	const struct btd_service *service = match_data;
+
+	return bdata->service == service;
+}
+
 static void bap_bcast_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -3682,7 +3682,10 @@ static void bap_bcast_remove(struct btd_service *service)
 	ba2str(device_get_address(device), addr);
 	DBG("%s", addr);
 
-	data = queue_find(sessions, match_device, device);
+	/* Lookup the bap session for this service since in case of
+	 * bass_delegator its user data is set by bass plugin.
+	 */
+	data = queue_find(sessions, match_service, service);
 	if (!data) {
 		error("BAP service not handled by profile");
 		return;
@@ -3791,10 +3794,12 @@ static int bap_disconnect(struct btd_service *service)
 
 static int bap_bcast_disconnect(struct btd_service *service)
 {
-	struct btd_device *device = btd_service_get_device(service);
 	struct bap_data *data;
 
-	data = queue_find(sessions, match_device, device);
+	/* Lookup the bap session for this service since in case of
+	 * bass_delegator its user data is set by bass plugin.
+	 */
+	data = queue_find(sessions, match_service, service);
 	if (!data) {
 		error("BAP service not handled by profile");
 		return -EINVAL;
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 0ba29f939f61..9ace372376f9 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -269,14 +269,6 @@ static void bass_req_bcode(struct bt_bap_stream *stream,
 		dg->timeout = g_timeout_add_seconds(10, req_timeout, dg);
 }
 
-static bool delegator_match_device(const void *data, const void *match_data)
-{
-	const struct bass_delegator *dg = data;
-	const struct btd_device *device = match_data;
-
-	return dg->device == device;
-}
-
 static int stream_get_bis(struct bt_bap_stream *stream)
 {
 	char *path = bt_bap_stream_get_user_data(stream);
@@ -366,6 +358,33 @@ static void setup_free(void *data)
 	free(setup);
 }
 
+static void delegator_disconnect(struct bass_delegator *dg)
+{
+	struct btd_device *device = dg->device;
+	struct btd_service *service = dg->service;
+
+	DBG("%p", dg);
+
+	/* Disconnect service so BAP driver is cleanup properly and bt_bap is
+	 * detached from the device.
+	 */
+	btd_service_disconnect(service);
+
+	/* Remove service since delegator shold have been freed at this point */
+	device_remove_profile(device, btd_service_get_profile(service));
+
+	/* If the device is no longer consider connected  it means no other
+	 * service was connected so it has no longer any use and can be safely
+	 * removed.
+	 */
+	if (!btd_device_is_connected(device)) {
+		struct btd_adapter *adapter;
+
+		adapter = device_get_adapter(device);
+		btd_adapter_remove_device(adapter, device);
+	}
+}
+
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
@@ -459,6 +478,8 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 		setup->stream = NULL;
 		queue_remove(setup->dg->setups, setup);
 		setup_free(setup);
+		if (queue_isempty(dg->setups))
+			delegator_disconnect(dg);
 		break;
 	}
 }
@@ -1296,15 +1317,65 @@ static void bap_bc_attached(struct bt_bap *bap, void *user_data)
 	bass_data_add(data);
 }
 
+static bool delegator_match_device(const void *data, const void *match_data)
+{
+	const struct bass_delegator *dg = data;
+	const struct btd_device *device = match_data;
+
+	return dg->device == device;
+}
+
+static void delegator_attach(struct bt_bap *bap, struct btd_device *device,
+				struct btd_service *service)
+{
+	struct bass_delegator *dg;
+	GError *err = NULL;
+
+	dg = queue_find(delegators, delegator_match_device, device);
+	if (!dg)
+		/* Only probe devices added via Broadcast Assistants */
+		return;
+
+	DBG("delegator %p", dg);
+
+	if (dg->service)
+		/* Service has already been probed */
+		return;
+
+	dg->service = service;
+	dg->bap = bap;
+
+	dg->io = bt_io_listen(NULL, confirm_cb, dg,
+		NULL, &err,
+		BT_IO_OPT_SOURCE_BDADDR,
+		btd_adapter_get_address(device_get_adapter(device)),
+		BT_IO_OPT_SOURCE_TYPE,
+		btd_adapter_get_address_type(device_get_adapter(device)),
+		BT_IO_OPT_DEST_BDADDR,
+		device_get_address(device),
+		BT_IO_OPT_DEST_TYPE,
+		btd_device_get_bdaddr_type(device),
+		BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+		BT_IO_OPT_QOS, &bap_sink_pa_qos,
+		BT_IO_OPT_ISO_BC_SID, dg->sid,
+		BT_IO_OPT_INVALID);
+	if (!dg->io) {
+		error("%s", err->message);
+		g_error_free(err);
+		return;
+	}
+
+	/* Take ownership for the service by setting the user data. */
+	btd_service_set_user_data(service, dg);
+}
+
 static void bap_attached(struct bt_bap *bap, void *user_data)
 {
 	struct btd_service *service;
 	struct btd_profile *p;
 	struct btd_device *device;
 	struct btd_adapter *adapter;
-	struct bass_delegator *dg;
 	struct bass_data *data;
-	GError *err = NULL;
 
 	service = bt_bap_get_user_data(bap);
 	if (!service)
@@ -1330,40 +1401,7 @@ static void bap_attached(struct bt_bap *bap, void *user_data)
 
 	bass_data_add(data);
 
-	dg = queue_find(delegators, delegator_match_device, device);
-	if (!dg)
-		/* Only probe devices added via Broadcast Assistants */
-		return;
-
-	if (dg->service)
-		/* Service has already been probed */
-		return;
-
-	dg->service = service;
-	dg->bap = bap;
-
-	dg->io = bt_io_listen(NULL, confirm_cb, dg,
-		NULL, &err,
-		BT_IO_OPT_SOURCE_BDADDR,
-		btd_adapter_get_address(adapter),
-		BT_IO_OPT_SOURCE_TYPE,
-		btd_adapter_get_address_type(adapter),
-		BT_IO_OPT_DEST_BDADDR,
-		device_get_address(device),
-		BT_IO_OPT_DEST_TYPE,
-		btd_device_get_bdaddr_type(device),
-		BT_IO_OPT_MODE, BT_IO_MODE_ISO,
-		BT_IO_OPT_QOS, &bap_sink_pa_qos,
-		BT_IO_OPT_ISO_BC_SID, dg->sid,
-		BT_IO_OPT_INVALID);
-	if (!dg->io) {
-		error("%s", err->message);
-		g_error_free(err);
-		return;
-	}
-
-	/* Take ownership for the service by setting the user data. */
-	btd_service_set_user_data(service, dg);
+	delegator_attach(bap, device, service);
 }
 
 static bool match_bap(const void *data, const void *match_data)
@@ -1417,12 +1455,35 @@ static void delegator_free(struct bass_delegator *dg)
 	free(dg);
 }
 
+static bool match_service(const void *data, const void *match_data)
+{
+	const struct bass_data *bdata = data;
+	const struct btd_service *service = match_data;
+
+	return bdata->service == service;
+}
+
+static void delegator_detach(struct btd_service *service)
+{
+	struct bass_delegator *dg;
+
+	dg = btd_service_get_user_data(service);
+	if (!dg)
+		return;
+
+	if (!queue_remove(delegators, dg))
+		return;
+
+	DBG("%p", dg);
+
+	delegator_free(dg);
+
+	btd_service_set_user_data(service, NULL);
+}
+
 static void bap_detached(struct bt_bap *bap, void *user_data)
 {
 	struct btd_service *service;
-	struct btd_profile *p;
-	struct btd_device *device;
-	struct bass_delegator *dg;
 	struct bass_data *data;
 
 	data = queue_find(sessions, match_bap, bap);
@@ -1435,31 +1496,15 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 	if (!service)
 		return;
 
-	p = btd_service_get_profile(service);
-	if (!p)
-		return;
-
-	/* Only handle sessions with Broadcast Sources */
-	if (!g_str_equal(p->remote_uuid, BCAAS_UUID_STR))
-		return;
-
-	device = btd_service_get_device(service);
-
 	/* Remove BASS session with the Broadcast Source device */
-	data = queue_find(sessions, match_device, device);
+	data = queue_find(sessions, match_service, service);
 	if (data) {
 		bt_bap_bis_cb_unregister(bap, data->bis_id);
 		bt_bap_state_unregister(bap, data->state_id);
 		bass_data_remove(data);
 	}
 
-	dg = queue_remove_if(delegators, delegator_match_device, device);
-	if (!dg)
-		return;
-
-	delegator_free(dg);
-
-	btd_service_set_user_data(service, NULL);
+	delegator_detach(service);
 }
 
 static void bis_probe(uint8_t sid, uint8_t bis, uint8_t sgrp,
@@ -1807,39 +1852,6 @@ static int handle_mod_src_req(struct bt_bcast_src *bcast_src,
 	switch (sync_state) {
 	case BT_BASS_SYNCHRONIZED_TO_PA:
 		bass_update_bis_sync(dg, bcast_src);
-
-		/* Check if there are any setups left since it means the PA
-		 * should be no longer synchronized.
-		 */
-		if (queue_isempty(dg->setups)) {
-			/* IO is no longer needed since there are no setups */
-			g_io_channel_shutdown(dg->io, TRUE, NULL);
-			g_io_channel_unref(dg->io);
-			dg->io = NULL;
-
-			bt_bass_set_pa_sync(dg->src,
-						BT_BASS_NOT_SYNCHRONIZED_TO_PA);
-
-			if (!dg->service)
-				return 0;
-
-			/* Disconnect service so BAP driver is cleanup
-			 * properly.
-			 */
-			btd_service_disconnect(dg->service);
-
-			/* If the device is no longer consider connected
-			 * it means no other service was connected so it
-			 * has no longer any use and can be safely removed.
-			 */
-			if (!btd_device_is_connected(dg->device)) {
-				struct btd_adapter *adapter;
-
-				adapter = device_get_adapter(dg->device);
-				btd_adapter_remove_device(adapter, dg->device);
-			}
-		}
-
 		break;
 	case BT_BASS_NOT_SYNCHRONIZED_TO_PA:
 		if (params->pa_sync == PA_SYNC_NO_PAST) {
-- 
2.51.1

