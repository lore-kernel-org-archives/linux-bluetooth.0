Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 05/18] Add support for storing the device type
Date: Tue, 21 Dec 2010 19:26:27 -0200
Message-Id: <1292966800-6264-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1292966800-6264-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the service discovery (SDP or GATT) is finished, write the device
type so it can be retrieved from storage when needed.
---
 src/device.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 4bf9b52..ca2c5bc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1463,8 +1463,16 @@ send_reply:
 	}
 
 cleanup:
-	if (!device->temporary)
+	if (!device->temporary) {
+		bdaddr_t sba, dba;
+
+		adapter_get_address(device->adapter, &sba);
+		device_get_address(device, &dba);
+
 		store_profiles(device);
+		write_device_type(&sba, &dba, device->type);
+	}
+
 	device->browse = NULL;
 	browse_request_free(req);
 }
@@ -1575,6 +1583,7 @@ static void primary_cb(GSList *services, int err, gpointer user_data)
 	adapter_get_address(adapter, &sba);
 	device_get_address(device, &dba);
 
+	write_device_type(&sba, &dba, device->type);
 	write_device_services(&sba, &dba, str);
 	g_free(str);
 
-- 
1.7.3.4

