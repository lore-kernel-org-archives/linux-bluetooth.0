Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD463932E8
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 17:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791567231; cv=none; b=UuEYYpAj1FjRrwY/I5Ay/x+rx0VR76xEyqBD7afVafUwsAnc2fINKixJT1m9JBHI6nyzL8Cn6BOGmHMqhYIqqneRurrahvOEcBGZ4zl7V6+D0LebS+zubCgVEP/A3b/Y02dAZHqsuAJdfvJAsH0gLfJkrPVpdsgJCFEYGEAeYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791567231; c=relaxed/simple;
	bh=Ae5eol8H5PY7ST3EuNWB+7S4sa/6MzISQRthiYGGuws=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Mj69eB+yWg5j41evQSIKfeJqAGJDKn9WVvINUzWChTOqgkb64stn22+y2aiQ4HNj00ru43QTob+a+8Pj6UgGyECmAriN0imzZ79lzesSAWXnFRao3l0sX6bIosEg0iw1rkAUbN0AVzh1pOW8Ye/xif/DeGNEL7i5xeVIj4u7L1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/M/oqkW; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/M/oqkW"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5e519c39196so1565533e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 10:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791567228; x=1792172028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5G4WrUER/pMQN0OkBzJVx59CmI+t+UKXjjbiKnwpZc0=;
        b=K/M/oqkWXLGFL5n3QlsjBQJZvtlg6ZCQjYW03WDq3VAAVE4IVZKaqTu3M8rxyKoxbB
         hsNkGKAqWdVQ1ekuv89NDlpLDK+zeJZhmkpKVNp/5Kt+RS+ZMRz3127BNcpA8+7D2ABZ
         TUkVeSCApkDl+hCkHHZg753uEwukOPY8EpKdq+HVGSUL8rW7OVZZPJqXjZsj8p2BiWWo
         FmZPKHIW/zRnMUUt1B1wzPxKxlcHcpE18pHL3Lz5N7HbdjyBOAspWllcEzIYoSK7kUpg
         XHvCX9YJgcxzSX2yUSL3VfvTrj869qYhCYr9WNHpbPJnaoVCw+amr8ycn4bu2zYp6pQ5
         5XAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791567228; x=1792172028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5G4WrUER/pMQN0OkBzJVx59CmI+t+UKXjjbiKnwpZc0=;
        b=wxUUqtpEC1LZDDObhisZPOjcIw3+NNAAOiXPE0GlKfjdxB3OEsafyd2nguv1vuPj84
         Jfbt4tMi5+7v+Vok8UthPj+Ck3+xn6WL2bOX5wfLdpn5l2kQouJbPhhnj/qTCPZJghHF
         JrGAtJ90ucvdN3asyk+mdrbDVA3h8WLuSIBKGM77Wihux2BL3WxazpPwLC8555xEMZgF
         dOpssYrU17u/uJaXIThF/vHChRyCe/XjjNZcGvRE2l23QXBqPV17aTJra4BnM9lSFQjm
         IgfTdDtSKnMiCNu340qVm1FypKfzuKUf4tKDNDX+2oX9FZEZ/FRW5Db+lzI+POrfIJLN
         5wPw==
X-Gm-Message-State: AFq9FYIO+J4OA8cyFNdiELiDIuPJn1b5YlM7e+dUPKgNEhCzYjsMGJnt
	+MN7BtKcYEtyRbRd3RuYfFfFoYJFjbB+c1TL4Gpn/nVFyXW48ETTjw7Yp+2Kag==
X-Gm-Gg: AYBFou0gqMm6yBFgTlE610nlTzK4e9yQ3HR/VByHaLi4fA7bKc6MTbEDiRVvwwJdbyC
	ozlYZmBL7CtnUifDq4l2l73ATImBa6+iWptlfQS4FuyfwXlrafsqqgGC2Rm8xOfzkN9EqNq5upq
	Jc6K6/6tDcSFKiifUEe0h7NGOu/QAmpVkKZbL8N5uGd/oVOoJGJN1CppX4SrBexLKdKHfiKXLbP
	3HfqyXUeaT6zqFY6infcag6Bpdtzbx9UDErmKduZPbo8+/XLFO5LS+5YsjOBSxBCw2Blh5pN91o
	xO1YvNQFVG59tehciuN0UU6DW86qgIHgv47Gub6LeL3pswowa0yzjjUrebgPN9MXphwwdwKsq8A
	9v7TotUk4j/gcnft2+6NlNYAurnn0cbcpjc3N4ZrSLQTHkRXu59p1OLiVuXBo796xhU+NL5HPib
	jk53qWrudgci6Whjxd1vbkA9GJJYjbGCacCboVAxf0yKwuWr3s6z2p+XYzHWW6Vhbh9Wcc1ofDD
	BVQbZfsHbXVy3kcghoaZFU0IMIYtsssIMswofrEzA3NHSX/R3w+G6PMmLNvxSDQFA==
X-Received: by 2002:a05:6122:218f:b0:5d9:82c1:b343 with SMTP id 71dfb90a1353d-5e91f250d84mr967956e0c.1.1791567228295;
        Fri, 09 Oct 2026 10:33:48 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5e91cb3117esm2187732e0c.9.2026.10.09.10.33.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 10:33:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/rap: Track RAS CCC state per connection
Date: Fri,  9 Oct 2026 13:33:41 -0400
Message-ID: <20261009173341.1143848-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The Real-time, On-demand, Ranging Data Ready and Ranging Data Overwritten
CCC values were stored on the RAS service shared by all connections, while
ranging data is sent on the ATT channel of the connection that produced
it. One central's subscription could therefore decide whether, and with
which transport, another central was sent ranging data, and the Real-time
vs On-demand exclusivity check rejected a central because of another
central's configuration.

Store the values on the bt_rap session of the writing connection instead
and use them for the mode, transport and subscription checks.

Fixes: a9b39d71597d ("src/shared: Add RAS packet format and notification support")
Fixes: 2ac9fc0901c4 ("shared/rap: Honor CCCD transport for RAS on-demand ranging data")
Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/rap.c | 86 ++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 36 deletions(-)

diff --git a/src/shared/rap.c b/src/shared/rap.c
index dae83a17947c..ebf12a6bba31 100644
--- a/src/shared/rap.c
+++ b/src/shared/rap.c
@@ -395,23 +395,17 @@ struct ras {
 	uint16_t ready_counter;
 	uint16_t overwritten_counter;
 
-	/* CCC state tracking for mutual exclusivity */
-	uint16_t realtime_ccc_value;
-	uint16_t ondemand_ccc_value;
-	/* CCC state for Ready/Overwritten so notifications are sent with
-	 * the transport (notification or indication) the client enabled.
-	 */
-	uint16_t ready_ccc_value;
-	uint16_t overwritten_ccc_value;
-
 	/* Initiator role: pending RAS Control Point request state */
 	struct ras_ondemand_client client;
 };
 
-static inline bool ras_is_ondemand_mode(const struct ras *ras)
-{
-	return ras && ras->ondemand_ccc_value != 0;
-}
+/* Responder role: CCC values written by the client of one connection. */
+struct ras_ccc_state {
+	uint16_t realtime;
+	uint16_t ondemand;
+	uint16_t ready;
+	uint16_t overwritten;
+};
 
 /* Initiator role: forward declaration needed by bt_rap_detach() below;
  * defined alongside the other RAS Control Point client helpers.
@@ -494,6 +488,11 @@ struct bt_rap {
 	 */
 	struct ras_ondemand_cache cache;
 
+	/* Responder role: this connection's RAS CCC values, so one central's
+	 * subscription cannot select what another central receives.
+	 */
+	struct ras_ccc_state ras_ccc;
+
 	/* Serialized real-time segments await transport-paced delivery. */
 	struct queue *realtime_segments;
 	unsigned int realtime_send_id;
@@ -501,6 +500,11 @@ struct bt_rap {
 	bool realtime_indicating;
 };
 
+static inline bool ras_is_ondemand_mode(const struct bt_rap *rap)
+{
+	return rap && rap->ras_ccc.ondemand != 0;
+}
+
 static struct queue *rap_db;
 static struct queue *bt_rap_cbs;
 static struct queue *sessions;
@@ -1415,6 +1419,7 @@ static void ras_ranging_data_ccc_write_cb(struct gatt_db_attribute *attrib,
 					void *user_data)
 {
 	struct ras *ras = user_data;
+	struct bt_rap *rap;
 	uint16_t ccc_value;
 	bool is_realtime;
 	uint16_t *this_ccc;
@@ -1426,7 +1431,12 @@ static void ras_ranging_data_ccc_write_cb(struct gatt_db_attribute *attrib,
 		return;
 	}
 
-	bt_rap_get_session(att, ras->rapdb->db);
+	rap = bt_rap_get_session(att, ras->rapdb->db);
+	if (!rap) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ATT_ERROR_UNLIKELY);
+		return;
+	}
 
 	if (offset) {
 		gatt_db_attribute_write_result(attrib, id,
@@ -1451,10 +1461,10 @@ static void ras_ranging_data_ccc_write_cb(struct gatt_db_attribute *attrib,
 
 	/* Determine which CCC this is */
 	is_realtime = (attrib == ras->realtime_chrc_ccc);
-	this_ccc = is_realtime ? &ras->realtime_ccc_value :
-				 &ras->ondemand_ccc_value;
-	other_ccc = is_realtime ? &ras->ondemand_ccc_value :
-				  &ras->realtime_ccc_value;
+	this_ccc = is_realtime ? &rap->ras_ccc.realtime :
+				 &rap->ras_ccc.ondemand;
+	other_ccc = is_realtime ? &rap->ras_ccc.ondemand :
+				  &rap->ras_ccc.realtime;
 
 	/* Check mutual exclusivity: reject if trying to enable realtime
 	 * while ondemand is already enabled.
@@ -1487,6 +1497,7 @@ static void ras_ready_overwritten_ccc_write_cb(struct gatt_db_attribute *attrib,
 					void *user_data)
 {
 	struct ras *ras = user_data;
+	struct bt_rap *rap;
 	uint16_t ccc_value;
 
 	if (!ras) {
@@ -1495,6 +1506,13 @@ static void ras_ready_overwritten_ccc_write_cb(struct gatt_db_attribute *attrib,
 		return;
 	}
 
+	rap = bt_rap_get_session(att, ras->rapdb->db);
+	if (!rap) {
+		gatt_db_attribute_write_result(attrib, id,
+					BT_ATT_ERROR_UNLIKELY);
+		return;
+	}
+
 	if (offset) {
 		gatt_db_attribute_write_result(attrib, id,
 					BT_ATT_ERROR_INVALID_OFFSET);
@@ -1517,9 +1535,9 @@ static void ras_ready_overwritten_ccc_write_cb(struct gatt_db_attribute *attrib,
 	}
 
 	if (attrib == ras->ready_ccc)
-		ras->ready_ccc_value = ccc_value;
+		rap->ras_ccc.ready = ccc_value;
 	else if (attrib == ras->overwritten_ccc)
-		ras->overwritten_ccc_value = ccc_value;
+		rap->ras_ccc.overwritten = ccc_value;
 
 	gatt_db_attribute_write_result(attrib, id, 0);
 }
@@ -1921,7 +1939,7 @@ static void ras_send_ranging_data_ready(struct bt_rap *rap, struct ras *ras,
 
 	ras->ready_counter = counter;
 	put_le16(counter, value);
-	if (ras_ccc_use_indication(ras->ready_ccc_value))
+	if (ras_ccc_use_indication(rap->ras_ccc.ready))
 		gatt_db_attribute_indicate(ras->ready_chrc, value,
 					sizeof(value), bt_rap_get_att(rap));
 	else
@@ -1939,7 +1957,7 @@ static void ras_send_ranging_data_overwritten(struct bt_rap *rap,
 
 	ras->overwritten_counter = counter;
 	put_le16(counter, value);
-	if (ras_ccc_use_indication(ras->overwritten_ccc_value))
+	if (ras_ccc_use_indication(rap->ras_ccc.overwritten))
 		gatt_db_attribute_indicate(ras->overwritten_chrc, value,
 					sizeof(value), bt_rap_get_att(rap));
 	else
@@ -2121,7 +2139,7 @@ static bool send_ondemand_segment_data_cb(void *user_data)
 		 * The delay also bounds a transfer, so keep it short: at a
 		 * 247 byte MTU a 13 KB procedure is 57 segments.
 		 */
-		if (ras_data_ccc_use_indication(ras->ondemand_ccc_value)) {
+		if (ras_data_ccc_use_indication(rap->ras_ccc.ondemand)) {
 			uint16_t vhandle =
 				gatt_db_attribute_get_handle(
 					gatt_db_attribute_get_value(
@@ -2217,7 +2235,7 @@ static void send_ondemand_segment_data(struct bt_rap *rap, struct ras *ras)
 		return;
 
 	/* Ranging data must only reach a client that subscribed to it. */
-	if (!ras->ondemand_ccc_value) {
+	if (!rap->ras_ccc.ondemand) {
 		ras_cp_send_response_code(rap, ras,
 					RAS_CP_RSP_CODE_SERVER_BUSY);
 		return;
@@ -2285,7 +2303,7 @@ static bool send_realtime_segment_cb(void *user_data)
 	if (!segment)
 		return false;
 
-	if (ras_data_ccc_use_indication(ras->realtime_ccc_value)) {
+	if (ras_data_ccc_use_indication(rap->ras_ccc.realtime)) {
 		uint16_t vhandle = gatt_db_attribute_get_handle(
 					gatt_db_attribute_get_value(
 						ras->realtime_chrc));
@@ -2348,7 +2366,7 @@ static void send_ras_segment_data(struct bt_rap *rap,
 		return;
 
 	/* Ranging data must only reach a client that subscribed to it. */
-	if (!rap->lrapdb->ras->realtime_ccc_value)
+	if (!rap->ras_ccc.realtime)
 		return;
 
 	value_max = ras_att_value_payload_max(rap);
@@ -2828,7 +2846,7 @@ static void handle_local_subevent_result(struct bt_rap *rap,
 			/* A new real-time procedure supersedes queued
 			 * old ranging data.
 			 */
-			if (!ras_is_ondemand_mode(rap->lrapdb->ras))
+			if (!ras_is_ondemand_mode(rap))
 				ras_realtime_segments_clear(rap);
 
 			resptracker_reset_current_proc(resptracker);
@@ -2904,20 +2922,16 @@ static void handle_local_subevent_result(struct bt_rap *rap,
 	/* Ensure first segment body starts with the 4-byte RangingHeader */
 	ras_maybe_prepend_ranging_header(proc);
 
-	if (subevt_done_status != SUBEVENT_DONE_PARTIAL_RESULTS) {
-		struct ras *ras = rap->lrapdb ? rap->lrapdb->ras : NULL;
-
-		/* Real-time Ranging mode
-		 */
-		if (!ras_is_ondemand_mode(ras))
-			send_ras_segment_data(rap, proc);
-	}
+	/* Real-time Ranging mode */
+	if (subevt_done_status != SUBEVENT_DONE_PARTIAL_RESULTS &&
+			!ras_is_ondemand_mode(rap))
+		send_ras_segment_data(rap, proc);
 
 	/* Procedure complete? Clean up */
 	if (proc_done_status == CS_PROC_ALL_RESULTS_COMPLETE) {
 		struct ras *ras = rap->lrapdb ? rap->lrapdb->ras : NULL;
 
-		if (ras_is_ondemand_mode(ras)) {
+		if (ras_is_ondemand_mode(rap)) {
 			if (rap->cache.valid) {
 				uint16_t evicted_counter = rap->cache.counter;
 
-- 
2.55.0

