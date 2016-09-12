Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/8] deviceinfo: Implement disconnect callback
Date: Mon, 12 Sep 2016 17:07:38 +0300
Message-Id: <1473689259-9523-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
References: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements the profile disconnect so the service state is updated
properly.
---
 profiles/deviceinfo/deviceinfo.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index 34d9e20..0ce7edb 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -141,6 +141,13 @@ static int deviceinfo_driver_accept(struct btd_service *service)
 	return 0;
 }
 
+static int deviceinfo_disconnect(struct btd_service *service)
+{
+	btd_service_disconnecting_complete(service, 0);
+
+	return 0;
+}
+
 static struct btd_profile deviceinfo_profile = {
 	.name		= "deviceinfo",
 	.remote_uuid	= DEVICE_INFORMATION_UUID,
@@ -148,6 +155,7 @@ static struct btd_profile deviceinfo_profile = {
 	.device_probe	= deviceinfo_driver_probe,
 	.device_remove	= deviceinfo_driver_remove,
 	.accept		= deviceinfo_driver_accept,
+	.disconnect	= deviceinfo_disconnect,
 };
 
 static int deviceinfo_init(void)
-- 
2.7.4

