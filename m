Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: deymo@chromium.org, Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v0 3/4] avrcp: Fix service connections not reported to core
Date: Thu, 23 May 2013 11:28:28 +0200
Message-Id: <1369301309-25189-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1369301309-25189-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1369301309-25189-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Similarly to disconnections, control.c cannot rely on the role
information used in avrcp.c in order to report the core about service
state changes. Therefore, consider both roles as connected once the
AVRCP session has been created if the core had previouls requested the
connection of the other role.
---
 profiles/audio/control.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index f17e271..d2cc163 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -71,11 +71,19 @@ struct control {
 void control_target_connected(struct control *control)
 {
 	btd_service_connecting_complete(control->target, 0);
+
+	if (control->remote != NULL && btd_service_get_state(control->remote) ==
+						BTD_SERVICE_STATE_CONNECTING)
+		btd_service_connecting_complete(control->remote, 0);
 }
 
 void control_remote_connected(struct control *control)
 {
 	btd_service_connecting_complete(control->remote, 0);
+
+	if (control->target != NULL && btd_service_get_state(control->target) ==
+						BTD_SERVICE_STATE_CONNECTING)
+		btd_service_connecting_complete(control->target, 0);
 }
 
 void control_disconnected(struct control *control)
-- 
1.8.1.4

