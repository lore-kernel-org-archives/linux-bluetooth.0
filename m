Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/4] device: Fix invalid memory read during GATT discovery
Date: Tue, 14 Feb 2012 12:06:02 -0400
Message-Id: <1329235564-12471-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1329235564-12471-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1329235564-12471-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

device->browse should be set to NULL before calling
browse_request_free(), otherwise it points to freed memory.
---
 src/device.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index 50ab339..b581564 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2005,6 +2005,7 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 				BT_IO_OPT_INVALID);
 
 	if (device->att_io == NULL) {
+		device->browse = NULL;
 		browse_request_free(req);
 		g_free(attcb);
 		return -EIO;
-- 
1.7.5.4

