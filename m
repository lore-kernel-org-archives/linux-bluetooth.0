Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Aleksander Drewnicki <ext.aleksander.drewnicki@tieto.com>
Subject: [PATCH 08/10] android/client: Add code for mce callback
Date: Thu,  9 Oct 2014 14:45:12 +0200
Message-Id: <1412858714-2845-9-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412858714-2845-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Aleksander Drewnicki <ext.aleksander.drewnicki@tieto.com>

This adds implementation for mce callback.
---
 android/client/if-mce.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/client/if-mce.c b/android/client/if-mce.c
index f9ff5f1..c671fb2 100644
--- a/android/client/if-mce.c
+++ b/android/client/if-mce.c
@@ -28,6 +28,16 @@ static void btmce_remote_mas_instances_cb(bt_status_t status,
 						int num_instances,
 						btmce_mas_instance_t *instances)
 {
+	int i;
+
+	haltest_info("%s: status=%s bd_addr=%s num_instance=%d\n", __func__,
+				bt_status_t2str(status), bdaddr2str(bd_addr),
+				num_instances);
+
+	for (i = 0; i < num_instances; i++)
+		haltest_info("id=%d scn=%d msg_types=%d name=%s\n",
+				instances[i].id, instances[i].scn,
+				instances[i].msg_types, instances[i].p_name);
 }
 
 static btmce_callbacks_t mce_cbacks = {
-- 
1.9.3

