Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] control: Fix invalid access
Date: Thu, 23 Nov 2017 15:01:45 +0200
Message-Id: <20171123130145.10480-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When both controller and target roles are supported by a device they
would share the same btd_service user_data pointer which would lead to
use after free once either service is removed.
---
 profiles/audio/control.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 707276d29..4ab1f9b0f 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -275,11 +275,15 @@ static void path_unregister(void *data)
 
 	avctp_remove_state_cb(control->avctp_id);
 
-	if (control->target)
+	if (control->target) {
+		btd_service_set_user_data(control->target, NULL);
 		btd_service_unref(control->target);
+	}
 
-	if (control->remote)
+	if (control->remote) {
+		btd_service_set_user_data(control->remote, NULL);
 		btd_service_unref(control->remote);
+	}
 
 	devices = g_slist_remove(devices, control);
 	g_free(control);
-- 
2.13.6

