Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] deviceinfo: Enable external flag
Date: Wed,  7 Oct 2015 15:41:47 +0300
Message-Id: <1444221707-29732-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enable attributes to be accessed over D-Bus.
---
 profiles/deviceinfo/deviceinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index a0e9951..6ee018c 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -191,6 +191,7 @@ static int deviceinfo_driver_probe(struct btd_service *service)
 static struct btd_profile deviceinfo_profile = {
 	.name		= "deviceinfo",
 	.remote_uuid	= DEVICE_INFORMATION_UUID,
+	.external	= true,
 	.device_probe	= deviceinfo_driver_probe,
 	.device_remove	= deviceinfo_driver_remove
 };
-- 
2.4.3

