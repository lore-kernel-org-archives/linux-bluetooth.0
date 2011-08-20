Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 5/8] Fix not using the "bonded" property for new bondings
Date: Fri, 19 Aug 2011 21:09:26 -0300
Message-Id: <1313798969-8772-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When checking if a device was already bonded, we should
use the paired property instead of reading the link key
from storage. This method will work for LE links, also.
---
 src/device.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/src/device.c b/src/device.c
index b0adac0..04469d7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2125,29 +2125,15 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 					const char *agent_path,
 					uint8_t capability)
 {
-	char filename[PATH_MAX + 1];
-	char *str, srcaddr[18], dstaddr[18];
 	struct btd_adapter *adapter = device->adapter;
 	struct bonding_req *bonding;
-	bdaddr_t src;
 	int err;
 
-	adapter_get_address(adapter, &src);
-	ba2str(&src, srcaddr);
-	ba2str(&device->bdaddr, dstaddr);
-
 	if (device->bonding)
 		return btd_error_in_progress(msg);
 
-	/* check if a link key already exists */
-	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr,
-			"linkkeys");
-
-	str = textfile_caseget(filename, dstaddr);
-	if (str) {
-		free(str);
+	if (device_is_bonded(device))
 		return btd_error_already_exists(msg);
-	}
 
 	err = adapter_create_bonding(adapter, &device->bdaddr, capability);
 	if (err < 0)
-- 
1.7.6

