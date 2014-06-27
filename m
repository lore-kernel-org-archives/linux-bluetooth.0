Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 01/10] android/health: Add error check when creating app
Date: Fri, 27 Jun 2014 18:16:02 +0300
Message-Id: <1403882171-16308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/health.c b/android/health.c
index 7d64a63..0eeb0bd 100644
--- a/android/health.c
+++ b/android/health.c
@@ -820,6 +820,8 @@ static void bt_health_register_app(const void *buf, uint16_t len)
 
 	app = create_health_app(app_name, provider, srv_name, srv_descr,
 							cmd->num_of_mdep);
+	if (!app)
+		goto fail;
 
 	if (!queue_push_tail(apps, app))
 		goto fail;
-- 
1.8.3.2

