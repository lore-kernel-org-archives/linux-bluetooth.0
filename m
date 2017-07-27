Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH Bluez 5/6] core: Add checking for unknown GATT options
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <ac398a4f-72dd-0d1c-05df-3deac33df599@jp.fujitsu.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <e7afaaf5-ccab-651a-fb94-a5d6c688cb93@jp.fujitsu.com>
Date: Thu, 27 Jul 2017 20:23:40 +0900
MIME-Version: 1.0
In-Reply-To: <ac398a4f-72dd-0d1c-05df-3deac33df599@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds to check for unknown GATT options.
---
 src/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/main.c b/src/main.c
index 566a64c..2d00478 100644
--- a/src/main.c
+++ b/src/main.c
@@ -101,6 +101,11 @@ static const char * const policy_options[] = {
 	NULL
 };
 
+static const char * const gatt_options[] = {
+	"Cache",
+	NULL
+};
+
 GKeyFile *btd_get_main_conf(void)
 {
 	return main_conf;
@@ -230,6 +235,7 @@ static void check_config(GKeyFile *config)
 
 	check_options(config, "General", supported_options);
 	check_options(config, "Policy", policy_options);
+	check_options(config, "GATT", gatt_options);
 }
 
 static int get_mode(const char *str)
-- 
2.7.4



