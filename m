Return-Path: <cyrus@holtmann.org>
From: Damjan Cvetko <damjan.cvetko@monotek.net>
To: linux-bluetooth@vger.kernel.org
Cc: Damjan Cvetko <damjan.cvetko@monotek.net>
Subject: [PATCH] Add heartrate monitoring LE device to auto connect list.
Date: Mon, 28 Jan 2013 22:27:21 +0100
Message-Id: <1359408442-8002-1-git-send-email-damjan.cvetko@monotek.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/heartrate/heartrate.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 5c56d3f..1788d4f 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -801,6 +801,8 @@ static int heartrate_device_register(struct btd_device *device,
 	hr->attioid = btd_device_add_attio_callback(device, attio_connected_cb,
 						attio_disconnected_cb, hr);
 
+	device_set_auto_connect(device, TRUE);
+
 	return 0;
 }
 
-- 
1.7.10.4

