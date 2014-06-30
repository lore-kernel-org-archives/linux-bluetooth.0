Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/client: Fix using unvalidated index to access array
Date: Mon, 30 Jun 2014 14:48:24 +0300
Message-Id: <1404128905-27695-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404128905-27695-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404128905-27695-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes static analyzers warnings.
---
 android/client/if-hl.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index 949c574..7b75575 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -295,7 +295,16 @@ static void close_channel_p(int argc, const char **argv)
 	}
 
 	app_id = (uint32_t) atoi(argv[2]);
+	if (app_id >= APP_ID_SIZE) {
+		haltest_error("Wrong app_id specidied: %u\n", app_id);
+		return;
+	}
+
 	mdep_cfg_index = (uint8_t) atoi(argv[3]);
+	if (mdep_cfg_index >= MDEP_CFG_SIZE) {
+		haltest_error("Wrong mdep cgf index: %u\n", mdep_cfg_index);
+		return;
+	}
 
 	if (app_info[app_id][mdep_cfg_index][2] >= 0) {
 		shutdown(app_info[app_id][mdep_cfg_index][2], SHUT_RDWR);
-- 
1.8.3.2

