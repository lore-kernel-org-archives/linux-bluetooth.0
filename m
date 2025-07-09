Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0B1C1F13
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 13:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752068316; cv=none; b=ij5eaueMRi/k4pqPfYMygKy0qo6bLQaU6xix2dWQ0N+ke9141DjpqiqTejErLVxGmn1VxSUJoB0cYJD0FzoqJdas9TuHniDtVEuBSLMxRCG0JUuPitq/Kb1ePfxZGOYoRit4Q19pZ/X1YsAyS1v+c1xxcDigqMCStZpqk5USaJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752068316; c=relaxed/simple;
	bh=i0Wc7PmT+vdKhYtJlhyaNkaeAFE91tqT8luE2Vh8xug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MU5ZZi09ALwA+mqmYWQM4unT2b1yl9pFl3+2rNvia3dPEfKM4y93w5fmT1wuAoCvLP+4BSJ0oIaZwpb/NEa576YHV33RuLSS37jsVSRD0bIBBO2NkAgqxDQfJS2tREPy3OzriGBxQEEKCtVvkQYsl+/D7TZ6MCjHpkKj6WzDeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from inp1wst013.omp.ru (81.22.207.138) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 9 Jul
 2025 16:38:21 +0300
From: Ismagil Iskakov <i.iskakov@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Ismagil Iskakov <i.iskakov@omp.ru>
Subject: [PATCH BlueZ v4 2/4] profiles/audio: add nullity checks
Date: Wed, 9 Jul 2025 16:36:20 +0300
Message-ID: <20250709133622.2819849-3-i.iskakov@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709133622.2819849-1-i.iskakov@omp.ru>
References: <20250709133622.2819849-1-i.iskakov@omp.ru>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 07/09/2025 13:27:26
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 194682 [Jul 09 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: i.iskakov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 63 0.3.63
 9cc2b4b18bf16653fda093d2c494e542ac094a39
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;inp1wst013.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;81.22.207.138:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 81.22.207.138
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/09/2025 13:29:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 7/9/2025 11:17:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Cover bass_setup unsuccessful search and btd_device_get_service.
This change is motivated by the other usages where checks for
NULL exist.
---
 profiles/audio/a2dp.c  | 34 ++++++++++++++++++++++++----------
 profiles/audio/avrcp.c | 24 +++++++++++++++++++++---
 profiles/audio/bass.c  |  3 +++
 3 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index d2c2bec65..8b0b16ff1 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -646,6 +646,18 @@ static gboolean auto_config(gpointer data)
 	struct btd_service *service;
 	struct a2dp_stream *stream;
 
+	dev = avdtp_get_device(setup->session);
+
+	if (setup->sep->type == AVDTP_SEP_TYPE_SOURCE)
+		service = btd_device_get_service(dev, A2DP_SINK_UUID);
+	else
+		service = btd_device_get_service(dev, A2DP_SOURCE_UUID);
+
+	if (service == NULL) {
+		error("Unable to find btd service");
+		return FALSE;
+	}
+
 	/* Check if configuration was aborted */
 	stream = queue_find(setup->sep->streams, match_stream, setup->stream);
 	if (!stream)
@@ -654,16 +666,12 @@ static gboolean auto_config(gpointer data)
 	if (setup->err != NULL)
 		goto done;
 
-	dev = avdtp_get_device(setup->session);
-
 	avdtp_stream_add_cb(setup->session, setup->stream,
 				stream_state_changed, setup->sep);
 
 	if (setup->sep->type == AVDTP_SEP_TYPE_SOURCE) {
-		service = btd_device_get_service(dev, A2DP_SINK_UUID);
 		sink_new_stream(service, setup->session, setup->stream);
 	} else {
-		service = btd_device_get_service(dev, A2DP_SOURCE_UUID);
 		source_new_stream(service, setup->session, setup->stream);
 	}
 
@@ -995,10 +1003,20 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	struct btd_service *service;
 	int ret;
 
-	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
+	dev = avdtp_get_device(session);
+
+	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK) {
 		DBG("Sink %p: Set_Configuration_Cfm", sep);
-	else
+		service = btd_device_get_service(dev, A2DP_SOURCE_UUID);
+	} else {
 		DBG("Source %p: Set_Configuration_Cfm", sep);
+		service = btd_device_get_service(dev, A2DP_SINK_UUID);
+	}
+
+	if (service == NULL) {
+		error("Unable to find btd service");
+		return;
+	}
 
 	setup = find_setup_by_session(session);
 
@@ -1024,14 +1042,10 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (!setup)
 		return;
 
-	dev = avdtp_get_device(session);
-
 	/* Notify D-Bus interface of the new stream */
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SOURCE) {
-		service = btd_device_get_service(dev, A2DP_SINK_UUID);
 		sink_new_stream(service, session, setup->stream);
 	} else {
-		service = btd_device_get_service(dev, A2DP_SOURCE_UUID);
 		source_new_stream(service, session, setup->stream);
 	}
 
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index b3e69874d..e2797112f 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3062,8 +3062,14 @@ static void set_ct_player(struct avrcp *session, struct avrcp_player *player)
 	if (session->controller->player == player)
 		goto done;
 
-	session->controller->player = player;
 	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
+
+	if (service == NULL) {
+		error("Unable to find btd service");
+		return;
+	}
+
+	session->controller->player = player;
 	control_set_player(service, player ?
 			media_player_get_path(player->user_data) : NULL);
 
@@ -4258,12 +4264,18 @@ static void target_init(struct avrcp *session)
 	if (session->target != NULL)
 		return;
 
+	service = btd_device_get_service(session->dev, AVRCP_REMOTE_UUID);
+
+	if (service == NULL) {
+		error("Unable to find btd service");
+		return;
+	}
+
 	target = data_init(session, AVRCP_REMOTE_UUID);
 	session->target = target;
 
 	DBG("%p version 0x%04x", target, target->version);
 
-	service = btd_device_get_service(session->dev, AVRCP_REMOTE_UUID);
 	btd_service_connecting_complete(service, 0);
 
 	player = g_slist_nth_data(server->players, 0);
@@ -4312,6 +4324,13 @@ static void controller_init(struct avrcp *session)
 	if (session->controller != NULL)
 		return;
 
+	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
+
+	if (service == NULL) {
+		error("Unable to find btd service");
+		return;
+	}
+
 	controller = data_init(session, AVRCP_TARGET_UUID);
 	session->controller = controller;
 
@@ -4319,7 +4338,6 @@ static void controller_init(struct avrcp *session)
 	if (controller->obex_port)
 		DBG("%p OBEX PSM 0x%04x", controller, controller->obex_port);
 
-	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
 	btd_service_connecting_complete(service, 0);
 
 	/* Only create player if category 1 is supported */
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index c853fbc4a..87db130da 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -349,6 +349,9 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 	struct bass_setup *setup = queue_find(dg->setups,
 				match_setup_stream, stream);
 
+	if (setup == NULL)
+		return;
+
 	if (dg->bap != bap)
 		return;
 
-- 
2.34.1

