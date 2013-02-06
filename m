Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v1 6/7] health: Split health into two btd_profile
Date: Wed,  6 Feb 2013 10:16:26 +0100
Message-Id: <1360142187-15347-7-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1360142187-15347-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1360142187-15347-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Register a separate btd_profile for each health device role.
---
 profiles/health/hdp_manager.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/profiles/health/hdp_manager.c b/profiles/health/hdp_manager.c
index 87e70cd..9df5b2b 100644
--- a/profiles/health/hdp_manager.c
+++ b/profiles/health/hdp_manager.c
@@ -65,9 +65,9 @@ static void hdp_driver_remove(struct btd_profile *p, struct btd_device *device)
 	hdp_device_unregister(device);
 }
 
-static struct btd_profile hdp_profile = {
-	.name		= "hdp-profile",
-	.remote_uuids	= BTD_UUIDS(HDP_UUID, HDP_SOURCE_UUID, HDP_SINK_UUID),
+static struct btd_profile hdp_source_profile = {
+	.name		= "hdp-source",
+	.remote_uuids	= BTD_UUIDS(HDP_SOURCE_UUID),
 
 	.device_probe	= hdp_driver_probe,
 	.device_remove	= hdp_driver_remove,
@@ -76,19 +76,29 @@ static struct btd_profile hdp_profile = {
 	.adapter_remove	= hdp_adapter_remove,
 };
 
+static struct btd_profile hdp_sink_profile = {
+	.name		= "hdp-sink",
+	.remote_uuids	= BTD_UUIDS(HDP_SINK_UUID),
+
+	.device_probe	= hdp_driver_probe,
+	.device_remove	= hdp_driver_remove,
+};
+
 int hdp_manager_init(void)
 {
 	if (hdp_manager_start() < 0)
 		return -1;
 
-	btd_profile_register(&hdp_profile);
+	btd_profile_register(&hdp_source_profile);
+	btd_profile_register(&hdp_sink_profile);
 
 	return 0;
 }
 
 void hdp_manager_exit(void)
 {
-	btd_profile_unregister(&hdp_profile);
+	btd_profile_unregister(&hdp_sink_profile);
+	btd_profile_unregister(&hdp_source_profile);
 
 	hdp_manager_stop();
 }
-- 
1.8.1

