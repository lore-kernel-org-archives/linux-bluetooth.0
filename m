Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Enable reconnection in Proximity monitor
Date: Sun,  4 Nov 2012 17:31:47 -0300
Message-Id: <1352061107-23757-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to Proximity Profile spec, when a connection is terminated
due to link loss a Proximity Monitor should attempt to reconnect.
---
 profiles/proximity/monitor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index 1a14265..e45fa4a 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -652,6 +652,8 @@ int monitor_register(struct btd_device *device,
 							attio_disconnected_cb,
 							monitor);
 
+	device_set_auto_connect(device, TRUE);
+
 	return 0;
 }
 
-- 
1.8.0

