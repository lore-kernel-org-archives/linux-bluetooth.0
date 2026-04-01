Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E66839DBC9
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Apr 2026 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044671; cv=none; b=ihIyna3cqSjr6VHcXRTEjGKRbAsBKeJ550GmeOg9LynMD9fS3r0hnkgKSTYUhTGBvdIbwgfrMnsX82tkYh/b+JzIOtBr2z2pIhRD+GGt4LLEuZTE5EolGczKv8IoCJqS9+0B7v94M9htfbY9gqxEq6/Ca+q+sJO6nyPbxaBAgnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044671; c=relaxed/simple;
	bh=HVUscjAdLI5nKxRMHCNPyaVi63vEj9ZuOhQ/sLYoL1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UspCv7hUlXpqw49Ar2I5DPyhZCpTaHnUncHiVHvLEJQmHJShzNBEQ3Hx6X6zwcYaiVyzkMrCbLPVftXPU0l4ReYjScyEVl0k0+Sfjuw4yJ8WDUws+eJwOJcToaTZ4f8DT6XPEBZHu7V7tQIAITsqPPzUphL/uaDUjtd5wwOwC+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from sambura-Nitro-AN515-43.omp.ru (95.26.77.187) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 1 Apr
 2026 14:42:26 +0300
From: Kirill Samburskiy <k.samburskiy@omp.ru>
To: <linux-bluetooth@vger.kernel.org>
CC: Kirill Samburskiy <k.samburskiy@omp.ru>
Subject: [PATCH BlueZ 1/1] audio/avrcp: Track TG and CT events separately
Date: Wed, 1 Apr 2026 14:42:02 +0300
Message-ID: <20260401114202.625377-2-k.samburskiy@omp.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401114202.625377-1-k.samburskiy@omp.ru>
References: <20260401114202.625377-1-k.samburskiy@omp.ru>
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 04/01/2026 10:09:51
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 201856 [Apr 01 2026]
X-KSE-AntiSpam-Info: Version: 6.1.1.22
X-KSE-AntiSpam-Info: Envelope from: k.samburskiy@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 96 0.3.96
 f0df504111d78c4fb91ce829559989c2d1ddd192
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {date_rfc_vio_soft_silent}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {Tracking_repetitive_subdir_in_url}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 95.26.77.187 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 95.26.77.187 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	github.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 95.26.77.187
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/01/2026 10:12:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/1/2026 9:10:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Since we support both target and controller AVRCP roles, we need to
track events for each role separately to avoid confusing events that we
registered for notification from remote TG, and events that remote CT
registered for notification from us. This change is only relevant if
both sides support both CT and TG roles.

Fixes: https://github.com/bluez/bluez/issues/1997
---
 profiles/audio/avrcp.c | 48 ++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 18 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 326dfdab7..2968bff63 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -263,6 +263,8 @@ struct avrcp_data {
 	int features;
 	uint16_t obex_port;
 	GSList *players;
+	uint16_t registered_events;
+	uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
 };
 
 struct avrcp {
@@ -280,9 +282,7 @@ struct avrcp {
 	unsigned int browsing_id;
 	unsigned int browsing_timer;
 	uint16_t supported_events;
-	uint16_t registered_events;
 	uint8_t transaction;
-	uint8_t transaction_events[AVRCP_EVENT_LAST + 1];
 	struct pending_pdu *pending_pdu;
 };
 
@@ -852,11 +852,12 @@ done:
 		struct avrcp *session = l->data;
 		int err;
 
-		if (!(session->registered_events & (1 << id)))
+		if (session->target == NULL || 
+					!(session->target->registered_events & (1 << id)))
 			continue;
 
 		err = avctp_send_vendordep(session->conn,
-					session->transaction_events[id],
+					session->target->transaction_events[id],
 					code, AVC_SUBUNIT_PANEL,
 					buf, size + AVRCP_HEADER_LENGTH);
 
@@ -864,7 +865,7 @@ done:
 			continue;
 
 		/* Unregister event as per AVRCP 1.3 spec, section 5.4.2 */
-		session->registered_events ^= 1 << id;
+		session->target->registered_events ^= 1 << id;
 	}
 
 	return;
@@ -1644,6 +1645,12 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	if (!(session->supported_events & (1 << pdu->params[0])))
 		goto err;
 
+	if (session->target == NULL) {
+		pdu->params_len = cpu_to_be16(1);
+		pdu->params[0] = AVRCP_STATUS_INVALID_COMMAND;
+		return AVC_CTYPE_REJECTED;
+	}
+
 	switch (pdu->params[0]) {
 	case AVRCP_EVENT_STATUS_CHANGED:
 		len = 2;
@@ -1686,8 +1693,8 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	}
 
 	/* Register event and save the transaction used */
-	session->registered_events |= (1 << pdu->params[0]);
-	session->transaction_events[pdu->params[0]] = transaction;
+	session->target->registered_events |= (1 << pdu->params[0]);
+	session->target->transaction_events[pdu->params[0]] = transaction;
 
 	pdu->params_len = cpu_to_be16(len);
 
@@ -3949,6 +3956,9 @@ static gboolean avrcp_handle_event(struct avctp *conn, uint8_t code,
 	if (!pdu)
 		return FALSE;
 
+	if (session->controller == NULL)
+		return FALSE;
+
 	if ((code != AVC_CTYPE_INTERIM && code != AVC_CTYPE_CHANGED)) {
 		if (pdu->params[0] == AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED &&
 				code == AVC_CTYPE_REJECTED) {
@@ -3956,7 +3966,7 @@ static gboolean avrcp_handle_event(struct avctp *conn, uint8_t code,
 
 			/* Lookup event by transaction */
 			for (i = 0; i <= AVRCP_EVENT_LAST; i++) {
-				if (session->transaction_events[i] ==
+				if (session->controller->transaction_events[i] ==
 								transaction) {
 					event = i;
 					goto changed;
@@ -4008,14 +4018,14 @@ static gboolean avrcp_handle_event(struct avctp *conn, uint8_t code,
 		break;
 	}
 
-	session->registered_events |= (1 << event);
-	session->transaction_events[event] = transaction;
+	session->controller->registered_events |= (1 << event);
+	session->controller->transaction_events[event] = transaction;
 
 	return TRUE;
 
 changed:
-	session->registered_events ^= (1 << event);
-	session->transaction_events[event] = 0;
+	session->controller->registered_events ^= (1 << event);
+	session->controller->transaction_events[event] = 0;
 	avrcp_register_notification(session, event);
 	return FALSE;
 }
@@ -4667,7 +4677,8 @@ static int avrcp_event(struct avrcp *session, uint8_t id, const void *data)
 	int err;
 
 	/* Verify that the event is registered */
-	if (!(session->registered_events & (1 << id)))
+	if (session->target == NULL || 
+				!(session->target->registered_events & (1 << id)))
 		return -ENOENT;
 
 	memset(buf, 0, sizeof(buf));
@@ -4692,21 +4703,22 @@ static int avrcp_event(struct avrcp *session, uint8_t id, const void *data)
 	pdu->params_len = cpu_to_be16(size);
 
 	err = avctp_send_vendordep(session->conn,
-					session->transaction_events[id],
+					session->target->transaction_events[id],
 					code, AVC_SUBUNIT_PANEL,
 					buf, size + AVRCP_HEADER_LENGTH);
 	if (err < 0)
 		return err;
 
 	/* Unregister event as per AVRCP 1.3 spec, section 5.4.2 */
-	session->registered_events ^= 1 << id;
+	session->target->registered_events ^= 1 << id;
 
 	return err;
 }
 
-static bool avrcp_event_registered(struct avrcp *session, uint8_t event)
+static bool avrcp_target_event_registered(struct avrcp *session, uint8_t event)
 {
-	return session->registered_events & (1 << event);
+	return session->target &&
+			session->target->registered_events & (1 << event);
 }
 
 int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
@@ -4741,7 +4753,7 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 		 * for it), allow the call to pass through if the remote
 		 * controller registered for a volume changed event.
 		 */
-		if (!session->controller && !avrcp_event_registered(session,
+		if (!session->controller && !avrcp_target_event_registered(session,
 						AVRCP_EVENT_VOLUME_CHANGED))
 			return -ENOTSUP;
 	} else if (!avrcp_volume_supported(session->controller)) {
-- 
2.34.1

