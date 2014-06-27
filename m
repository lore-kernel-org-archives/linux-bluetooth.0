Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/9] android/health: Add error check when creating app
Date: Fri, 27 Jun 2014 10:39:55 +0300
Message-Id: <1403854803-28850-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403784265-1455-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1403784265-1455-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/health.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index 42c9a6e..de67475 100644
--- a/android/health.c
+++ b/android/health.c
@@ -820,6 +820,8 @@ static void bt_health_register_app(const void *buf, uint16_t len)
 
 	app = create_health_app(app_name, provider, srv_name, srv_descr,
 							cmd->num_of_mdep);
+	if (!app)
+		goto fail;
 
 	if (!queue_push_tail(apps, app))
 		goto fail;
@@ -830,7 +832,9 @@ static void bt_health_register_app(const void *buf, uint16_t len)
 	return;
 
 fail:
-	free_health_app(app);
+	if (app)
+		free_health_app(app);
+
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HEALTH, HAL_OP_HEALTH_MDEP,
 							HAL_STATUS_FAILED);
 }
-- 
1.8.3.2

