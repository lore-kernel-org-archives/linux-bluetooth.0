Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] audio/avrcp: Always notify about disconnecting service
Date: Wed, 11 Mar 2015 10:34:22 +0100
Message-Id: <1426066462-32151-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1426066462-32151-1-git-send-email-marcin.kraglak@tieto.com>
References: <1426066462-32151-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If there is a call to avrcp_connect, state of service is changed to
BTD_SERVICE_STATE_CONNECTING. If connection failed, state didn't change
to BTD_SERVICE_STATE_DISCONNECTED because controller_destroy() and
target_destroy() was not called. Set state of services in session_destroy()
instead.
---
 profiles/audio/avrcp.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index a57756e..a67b81e 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3486,19 +3486,11 @@ static void session_init_control(struct avrcp *session)
 static void controller_destroy(struct avrcp *session)
 {
 	struct avrcp_data *controller = session->controller;
-	struct btd_service *service;
 
 	DBG("%p", controller);
 
 	g_slist_free_full(controller->players, player_destroy);
 
-	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
-
-	if (session->control_id == 0)
-		btd_service_connecting_complete(service, -EIO);
-	else
-		btd_service_disconnecting_complete(service, 0);
-
 	g_free(controller);
 }
 
@@ -3506,31 +3498,40 @@ static void target_destroy(struct avrcp *session)
 {
 	struct avrcp_data *target = session->target;
 	struct avrcp_player *player = target->player;
-	struct btd_service *service;
 
 	DBG("%p", target);
 
 	if (player != NULL)
 		player->sessions = g_slist_remove(player->sessions, session);
 
-	service = btd_device_get_service(session->dev, AVRCP_REMOTE_UUID);
-
-	if (session->control_id == 0)
-		btd_service_connecting_complete(service, -EIO);
-	else
-		btd_service_disconnecting_complete(service, 0);
-
 	g_free(target);
 }
 
 static void session_destroy(struct avrcp *session)
 {
 	struct avrcp_server *server = session->server;
+	struct btd_service *service;
 
 	server->sessions = g_slist_remove(server->sessions, session);
 
 	session_abort_pending_pdu(session);
 
+	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
+	if (service != NULL) {
+		if (session->control_id == 0)
+			btd_service_connecting_complete(service, -EIO);
+		else
+			btd_service_disconnecting_complete(service, 0);
+	}
+
+	service = btd_device_get_service(session->dev, AVRCP_REMOTE_UUID);
+	if (service != NULL) {
+		if (session->control_id == 0)
+			btd_service_connecting_complete(service, -EIO);
+		else
+			btd_service_disconnecting_complete(service, 0);
+	}
+
 	if (session->browsing_timer > 0)
 		g_source_remove(session->browsing_timer);
 
-- 
2.1.0

