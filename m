Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 2/2] client: Clear ad manufacturer/service data when too
 much data
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <64c3c710-09a3-2379-9a5f-51f9001f2cc4@jp.fujitsu.com>
Message-ID: <5a1bab61-58a1-0bcf-2e70-568d6eb5b7e9@jp.fujitsu.com>
Date: Thu, 2 Nov 2017 16:50:32 +0900
MIME-Version: 1.0
In-Reply-To: <64c3c710-09a3-2379-9a5f-51f9001f2cc4@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When data is too much, the data may include values not making sense, so
this patch clears the advertising manufacturer/service data corresponding
to the running command.
---
 client/advertising.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/client/advertising.c b/client/advertising.c
index 76eda3c97..e950aa278 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -456,6 +456,7 @@ void ad_advertise_service(DBusConnection *conn, const char *arg)
 
 		if (i >= G_N_ELEMENTS(data->data)) {
 			rl_printf("Too much data\n");
+			ad_clear_service();
 			goto done;
 		}
 
@@ -511,6 +512,7 @@ void ad_advertise_manufacturer(DBusConnection *conn, const char *arg)
 	for (i = 1; i < w.we_wordc; i++) {
 		if (i >= G_N_ELEMENTS(data->data)) {
 			rl_printf("Too much data\n");
+			ad_clear_manufacturer();
 			goto done;
 		}
 
-- 
2.14.1

