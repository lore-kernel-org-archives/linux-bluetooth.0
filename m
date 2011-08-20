Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 3/8] Set the Paired property of a device when restoring from storage
Date: Fri, 19 Aug 2011 21:09:24 -0300
Message-Id: <1313798969-8772-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index 44d2586..b0adac0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -945,6 +945,11 @@ struct btd_device *device_create(DBusConnection *conn,
 		device_set_bonded(device, TRUE);
 	}
 
+	if (type == DEVICE_TYPE_LE && has_longtermkeys(&src, &device->bdaddr)) {
+		device_set_paired(device, TRUE);
+		device_set_bonded(device, TRUE);
+	}
+
 	return btd_device_ref(device);
 }
 
-- 
1.7.6

