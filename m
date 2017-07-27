Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH Bluez 1/6] core: Add group information to warning message for
 main.conf
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <ac398a4f-72dd-0d1c-05df-3deac33df599@jp.fujitsu.com>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <a01ab0f0-af5c-cc3b-ff1d-561b9c1f15b9@jp.fujitsu.com>
Date: Thu, 27 Jul 2017 20:21:35 +0900
MIME-Version: 1.0
In-Reply-To: <ac398a4f-72dd-0d1c-05df-3deac33df599@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Into warning message for main.conf, this adds group information like:
  bluetoothd[XXXX]: Unknown key PirableTimeout for group General in main.conf
---
 src/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index b88cf11..578b262 100644
--- a/src/main.c
+++ b/src/main.c
@@ -206,7 +206,8 @@ static void check_config(GKeyFile *config)
 		}
 
 		if (!found)
-			warn("Unknown key %s in main.conf", keys[i]);
+			warn("Unknown key %s for group %s in main.conf",
+							keys[i], "General");
 	}
 
 	g_strfreev(keys);
-- 
2.7.4

