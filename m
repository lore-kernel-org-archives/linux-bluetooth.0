Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] audio/avrcp: Pass error to session_destroy()
Date: Wed, 11 Mar 2015 19:11:01 +0100
Message-Id: <1426097463-5288-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1426097463-5288-1-git-send-email-marcin.kraglak@tieto.com>
References: <1426097463-5288-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will allow us to invoke btd_service_connecting_complete() or
btd_service_disconnecting_complete() with correct error code.
---
 profiles/audio/avrcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index dc57770..414ee25 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3507,7 +3507,7 @@ static void target_destroy(struct avrcp *session)
 	g_free(target);
 }
 
-static void session_destroy(struct avrcp *session)
+static void session_destroy(struct avrcp *session, int err)
 {
 	struct avrcp_server *server = session->server;
 	struct btd_service *service;
@@ -3519,7 +3519,7 @@ static void session_destroy(struct avrcp *session)
 	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
 	if (service != NULL) {
 		if (session->control_id == 0)
-			btd_service_connecting_complete(service, -EIO);
+			btd_service_connecting_complete(service, err);
 		else
 			btd_service_disconnecting_complete(service, 0);
 	}
@@ -3527,7 +3527,7 @@ static void session_destroy(struct avrcp *session)
 	service = btd_device_get_service(session->dev, AVRCP_REMOTE_UUID);
 	if (service != NULL) {
 		if (session->control_id == 0)
-			btd_service_connecting_complete(service, -EIO);
+			btd_service_connecting_complete(service, err);
 		else
 			btd_service_disconnecting_complete(service, 0);
 	}
@@ -3586,7 +3586,7 @@ static void state_changed(struct btd_device *device, avctp_state_t old_state,
 		if (session == NULL)
 			break;
 
-		session_destroy(session);
+		session_destroy(session, err);
 
 		break;
 	case AVCTP_STATE_CONNECTING:
-- 
2.1.0

