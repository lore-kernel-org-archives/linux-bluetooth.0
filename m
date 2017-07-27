Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH Bluez 4/6] core: Add checking for unknown Policy options
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <ac398a4f-72dd-0d1c-05df-3deac33df599@jp.fujitsu.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <bb030026-3693-73d8-4c00-181f3535300c@jp.fujitsu.com>
Date: Thu, 27 Jul 2017 20:23:17 +0900
MIME-Version: 1.0
In-Reply-To: <ac398a4f-72dd-0d1c-05df-3deac33df599@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds to check for unknown Policy options.
---
 src/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/main.c b/src/main.c
index 90ff6e7..566a64c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -93,6 +93,14 @@ static const char * const supported_options[] = {
 	NULL
 };
 
+static const char * const policy_options[] = {
+	"ReconnectUUIDs",
+	"ReconnectAttempts",
+	"ReconnectIntervals",
+	"AutoEnable",
+	NULL
+};
+
 GKeyFile *btd_get_main_conf(void)
 {
 	return main_conf;
@@ -221,6 +229,7 @@ static void check_config(GKeyFile *config)
 	g_strfreev(keys);
 
 	check_options(config, "General", supported_options);
+	check_options(config, "Policy", policy_options);
 }
 
 static int get_mode(const char *str)
-- 
2.7.4


