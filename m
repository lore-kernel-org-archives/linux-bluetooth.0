Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Subject: [PATCH Bluez 3/6] core: Fix General options in main.conf
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <ac398a4f-72dd-0d1c-05df-3deac33df599@jp.fujitsu.com>
Message-ID: <7409d04d-99d5-1090-ea5a-6d8770d338f5@jp.fujitsu.com>
Date: Thu, 27 Jul 2017 20:30:07 +0900
MIME-Version: 1.0
In-Reply-To: <ac398a4f-72dd-0d1c-05df-3deac33df599@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For supported_options struct,
 - adds FastConnectable.
   (That was added at 1cd65e52665cfbf939c923baea51748e359abfa5.)
 - removes AlwaysPairable.
   (That was removed at 12464916d39fa88f2ade96ccbc1d8efd6ea37789.)
---
 src/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/main.c b/src/main.c
index 7482706..90ff6e7 100644
--- a/src/main.c
+++ b/src/main.c
@@ -80,7 +80,6 @@ static const char * const supported_options[] = {
 	"Name",
 	"Class",
 	"DiscoverableTimeout",
-	"AlwaysPairable",
 	"PairableTimeout",
 	"AutoConnectTimeout",
 	"DeviceID",
@@ -89,6 +88,7 @@ static const char * const supported_options[] = {
 	"DebugKeys",
 	"ControllerMode",
 	"MultiProfile",
+	"FastConnectable",
 	"Privacy",
 	NULL
 };
-- 
2.7.4


