Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/7] audio/AVRCP: Fix not connecting Browsing channel when supported
Date: Mon, 29 Jul 2013 17:04:34 +0300
Message-Id: <1375106679-14645-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1375106679-14645-1-git-send-email-luiz.dentz@gmail.com>
References: <1375106679-14645-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Both controller and target services can initiate the connection but
probably only one of the services will be in CONNECTING state which may
happen to not have browsing feature set.

Currently this happens when connecting BlueZ vs BlueZ where the CT record
does not have browsing feature set so if the corresponding service start
connecting it wont connect the browsing channel due to lack of feature.
---
 profiles/audio/avrcp.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 1160f68..b2135c5 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3303,7 +3303,6 @@ static void target_init(struct avrcp *session)
 	struct avrcp_data *target;
 	struct avrcp_player *player;
 	struct btd_service *service;
-	btd_service_state_t old_state = BTD_SERVICE_STATE_UNAVAILABLE;
 
 	if (session->target != NULL)
 		return;
@@ -3314,10 +3313,8 @@ static void target_init(struct avrcp *session)
 	DBG("%p version 0x%04x", target, target->version);
 
 	service = btd_device_get_service(session->dev, AVRCP_REMOTE_UUID);
-	if (service != NULL) {
-		old_state = btd_service_get_state(service);
+	if (service != NULL)
 		btd_service_connecting_complete(service, 0);
-	}
 
 	if (target->version < 0x0103)
 		return;
@@ -3342,7 +3339,7 @@ static void target_init(struct avrcp *session)
 		avrcp_get_capabilities(session);
 
 	/* Auto-connect browsing channel only if initiator */
-	if (old_state == BTD_SERVICE_STATE_CONNECTING &&
+	if (avctp_is_initiator(session->conn) &&
 				target->features & AVRCP_FEATURE_BROWSING)
 		avctp_connect_browsing(session->conn);
 }
@@ -3352,7 +3349,6 @@ static void controller_init(struct avrcp *session)
 	struct avrcp_player *player;
 	struct btd_service *service;
 	struct avrcp_data *controller;
-	btd_service_state_t old_state = BTD_SERVICE_STATE_UNAVAILABLE;
 
 	if (session->controller != NULL)
 		return;
@@ -3366,10 +3362,8 @@ static void controller_init(struct avrcp *session)
 		session->supported_events |= (1 << AVRCP_EVENT_VOLUME_CHANGED);
 
 	service = btd_device_get_service(session->dev, AVRCP_TARGET_UUID);
-	if (service != NULL) {
-		old_state = btd_service_get_state(service);
+	if (service != NULL)
 		btd_service_connecting_complete(service, 0);
-	}
 
 	/* Only create player if category 1 is supported */
 	if (!(controller->features & AVRCP_FEATURE_CATEGORY_1))
@@ -3388,7 +3382,7 @@ static void controller_init(struct avrcp *session)
 		return;
 
 	/* Auto-connect browsing channel only if initiator */
-	if (old_state == BTD_SERVICE_STATE_CONNECTING &&
+	if (avctp_is_initiator(session->conn) &&
 				controller->features & AVRCP_FEATURE_BROWSING)
 		avctp_connect_browsing(session->conn);
 }
-- 
1.8.3.1

