Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87D9C43461
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 06:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36A1207BB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 06:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="V3nCmh4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgINGKD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 02:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgINGKA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 02:10:00 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC6FC061788
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2020 23:10:00 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id f4so9045473qvw.15
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Sep 2020 23:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=1LyqgXu5Psw2sRR9U9KlRbCocKTP6YVjaIZ4PjZiU+Y=;
        b=V3nCmh4thAbVQp2hGyxmLWma5N2ViDlIZ+TDiSUZr4fZHj7guP414BaaRaWtH1NGo0
         NeutxRBMTdP2qJBVXhcnvOrCLV8z5uW+9V2/QkOQUt+Jp1glwFyb+YCTLW6AXK61OPmj
         G8AFK/g6VCZG+9ur/ybHT9KvpRJHXfST7hoC7EdxCU3eyRllTuuXyz2n99z+NOvYsz2X
         MKFYmsv4kTr4QnilTZqgJwtK1dartDySmPsp0HmPrkCL+oay7eRNaGkU426Cm7hgC3az
         Js49DVbE3lRNQ7GQW3RkoCADRuucSAYnwYeXTUGcr2OtE0Musakaso2ijgwIbM/XaZKk
         ViqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=1LyqgXu5Psw2sRR9U9KlRbCocKTP6YVjaIZ4PjZiU+Y=;
        b=YFLUSyxYFKEMF9pbWSToOruvZdakwuNWR+IQrSRGyXQzWPsLeXQm5v0U2+F9mHdRLy
         r06tIf4hwNQYwuL2agFyJHUpr+/YA0wu2AlHAbldXiH8eyoAYVSxybmL836rZ23PQcbl
         cfUr/YDL13lLApKE6PT5LpVcJ7Ejvyi6/mpT7xG0gQ2R0kHB3AJP91xC39AcAJ6Xrt5Z
         2bb1IRez2JFZigNbDUgdm36pWmDOH6vzbxmdZxmPVHZvAhYs3nx7+8kf9PcXZb3Pv5NV
         0hmJyhvacKJgx0N43GqWsYkDNGYm34NUezDYd/HMa/+9o/l/Yihh92uxUjYjHmmjUYKq
         8IdA==
X-Gm-Message-State: AOAM532LeRCQgZR3eXmuMpyujvjkei2lyzSy038lZBm1QE7CF/n8klX1
        M/XV5sOuCUf07CG5Z5uiyCvrOesPp+cwnaYqA/SHUdU2k1H4a4aWDcSvopRt1SR6bbBhaB9X8ju
        x6WSW2GqFxt42f7Yb07a2ZKeNagq7KStoUhm31G39Re9wx/oLa6jk2tZSeMPtRPUCW00IQBw1BF
        tJ
X-Google-Smtp-Source: ABdhPJzvHkSdpHwe5gE0sOLW9Z4gApRjvYi3FzBxkhNq5OI1N8Pc28i8LA1732q5sil5it2v2PQ+g20+j/hR
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:2347])
 (user=apusaka job=sendgmr) by 2002:a05:6214:903:: with SMTP id
 dj3mr7569613qvb.14.1600063797823; Sun, 13 Sep 2020 23:09:57 -0700 (PDT)
Date:   Mon, 14 Sep 2020 14:09:52 +0800
Message-Id: <20200914140931.Bluez.v1.1.I59718e11885aba51acaa2b4263a1f446c94626a8@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
Subject: [Bluez PATCH v1] avrcp: issue ADDRESSED_PLAYED_CHANGED_EVENT on
 player addition/removal
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

There is a possibility of us assigning a session to a different player
upon addition/deletion of some player. If this happens, we should
issue the notification event ADDRESSED_PLAYED_CHANGED_EVENT as well.

Reviewed-by: Michael Sun <michaelfsun@google.com>

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
---

 profiles/audio/avrcp.c | 90 +++++++++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 23 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 5ef98acd1..373616426 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -251,6 +251,7 @@ struct avrcp_player {
 	uint8_t *features;
 	char *path;
 	guint changed_id;
+	bool pending_player_changed;
 
 	struct pending_list_items *p;
 	char *change_path;
@@ -784,8 +785,8 @@ static uint16_t player_settings_changed(struct avrcp_player *player,
 	return size;
 }
 
-void avrcp_player_event(struct avrcp_player *player, uint8_t id,
-							const void *data)
+static void avrcp_send_event(struct avrcp_player *player, GSList *sessions,
+						uint8_t id, const void *data)
 {
 	uint8_t buf[AVRCP_HEADER_LENGTH + 9];
 	struct avrcp_header *pdu = (void *) buf;
@@ -793,7 +794,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 	uint16_t size;
 	GSList *l;
 
-	if (player->sessions == NULL)
+	if (sessions == NULL)
 		return;
 
 	memset(buf, 0, sizeof(buf));
@@ -804,7 +805,8 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 
 	DBG("id=%u", id);
 
-	if (id != AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED && player->changed_id) {
+	if (id != AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED &&
+					player->pending_player_changed) {
 		code = AVC_CTYPE_REJECTED;
 		size = 1;
 		pdu->params[0] = AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED;
@@ -834,8 +836,8 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 		break;
 	case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		size = 5;
-		memcpy(&pdu->params[1], &player->id, sizeof(uint16_t));
-		memcpy(&pdu->params[3], &player->uid_counter, sizeof(uint16_t));
+		bt_put_be16(player->id, &pdu->params[1]);
+		bt_put_be16(player->uid_counter, &pdu->params[3]);
 		break;
 	case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
 		size = 1;
@@ -848,7 +850,7 @@ void avrcp_player_event(struct avrcp_player *player, uint8_t id,
 done:
 	pdu->params_len = htons(size);
 
-	for (l = player->sessions; l; l = l->next) {
+	for (l = sessions; l; l = l->next) {
 		struct avrcp *session = l->data;
 		int err;
 
@@ -870,6 +872,21 @@ done:
 	return;
 }
 
+void avrcp_player_event(struct avrcp_player *player, uint8_t id,
+							const void *data)
+{
+	avrcp_send_event(player, player->sessions, id, data);
+}
+
+static void avrcp_player_single_session_event(struct avrcp_player *player,
+			struct avrcp *session, uint8_t id, const void *data)
+{
+	GSList *session_list = g_slist_append(NULL, session);
+
+	avrcp_send_event(player, session_list, id, data);
+	g_slist_free(session_list);
+}
+
 static const char *metadata_to_str(uint32_t id)
 {
 	switch (id) {
@@ -1796,7 +1813,8 @@ static struct avrcp_player *find_tg_player(struct avrcp *session, uint16_t id)
 
 static gboolean notify_addressed_player_changed(gpointer user_data)
 {
-	struct avrcp_player *player = user_data;
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = target_get_player(session);
 	uint8_t events[6] = { AVRCP_EVENT_STATUS_CHANGED,
 					AVRCP_EVENT_TRACK_CHANGED,
 					AVRCP_EVENT_TRACK_REACHED_START,
@@ -1806,17 +1824,21 @@ static gboolean notify_addressed_player_changed(gpointer user_data)
 				};
 	uint8_t i;
 
-	avrcp_player_event(player, AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED, NULL);
+	avrcp_player_single_session_event(player, session,
+				AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED, NULL);
 
 	/*
 	 * TG shall complete all player specific
 	 * notifications with AV/C C-Type REJECTED
 	 * with error code as Addressed Player Changed.
 	 */
+	player->pending_player_changed = true;
 	for (i = 0; i < sizeof(events); i++)
-		avrcp_player_event(player, events[i], NULL);
+		avrcp_player_single_session_event(player, session, events[i],
+									NULL);
 
 	player->changed_id = 0;
+	player->pending_player_changed = false;
 
 	return FALSE;
 }
@@ -1826,6 +1848,7 @@ static uint8_t avrcp_handle_set_addressed_player(struct avrcp *session,
 						uint8_t transaction)
 {
 	struct avrcp_player *player;
+	struct avrcp_player *old_player;
 	uint16_t len = ntohs(pdu->params_len);
 	uint16_t player_id = 0;
 	uint8_t status;
@@ -1839,21 +1862,32 @@ static uint8_t avrcp_handle_set_addressed_player(struct avrcp *session,
 	player = find_tg_player(session, player_id);
 	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
 
-	if (player) {
-		player->addressed = true;
-		status = AVRCP_STATUS_SUCCESS;
-		pdu->params_len = htons(len);
-		pdu->params[0] = status;
-	} else {
+	if (!player) {
 		status = AVRCP_STATUS_INVALID_PLAYER_ID;
 		goto err;
 	}
 
+	old_player = target_get_player(session);
+
+	if (old_player != player) {
+		if (old_player)
+			old_player->sessions = g_slist_remove(
+						old_player->sessions, session);
+
+		session->target->player = player;
+		player->sessions = g_slist_append(player->sessions, session);
+	}
+
+	player->addressed = true;
+	status = AVRCP_STATUS_SUCCESS;
+	pdu->params_len = htons(len);
+	pdu->params[0] = status;
+
 	/* Don't emit player changed immediately since PTS expect the
 	 * response of SetAddressedPlayer before the event.
 	 */
 	player->changed_id = g_idle_add(notify_addressed_player_changed,
-								player);
+								session);
 
 	return AVC_CTYPE_ACCEPTED;
 
@@ -4137,6 +4171,7 @@ static void target_init(struct avrcp *session)
 		int8_t init_volume;
 		target->player = player;
 		player->sessions = g_slist_prepend(player->sessions, session);
+		player->addressed = true;
 
 		init_volume = media_player_get_device_volume(session->dev);
 		media_transport_update_device_volume(session->dev, init_volume);
@@ -4430,11 +4465,12 @@ struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
 			target->player = player;
 			player->sessions = g_slist_append(player->sessions,
 								session);
+			player->addressed = true;
+			notify_addressed_player_changed(session);
 		}
 	}
 
-	avrcp_player_event(player,
-				AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
+	avrcp_player_event(player, AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
 
 	return player;
 }
@@ -4442,9 +4478,11 @@ struct avrcp_player *avrcp_register_player(struct btd_adapter *adapter,
 void avrcp_unregister_player(struct avrcp_player *player)
 {
 	struct avrcp_server *server = player->server;
+	struct avrcp_player *substitute;
 	GSList *l;
 
 	server->players = g_slist_remove(server->players, player);
+	substitute = g_slist_nth_data(server->players, 0);
 
 	/* Remove player from sessions using it */
 	for (l = player->sessions; l; l = l->next) {
@@ -4454,12 +4492,18 @@ void avrcp_unregister_player(struct avrcp_player *player)
 		if (target == NULL)
 			continue;
 
-		if (target->player == player)
-			target->player = g_slist_nth_data(server->players, 0);
+		if (target->player == player) {
+			target->player = substitute;
+			if (substitute) {
+				substitute->addressed = true;
+				substitute->sessions = g_slist_append(
+						substitute->sessions, session);
+				notify_addressed_player_changed(session);
+			}
+		}
 	}
 
-	avrcp_player_event(player,
-				AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
+	avrcp_player_event(player, AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED, NULL);
 
 	player_destroy(player);
 }
-- 
2.28.0.618.gf4bc123cb7-goog

