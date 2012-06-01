Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 3/3] core: Remove pending connection attempt
Date: Fri,  1 Jun 2012 14:48:39 -0300
Message-Id: <1338572919-19071-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1338572919-19071-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1338572919-19071-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix connection attempt being triggered after device is removed. Pending
ATT re-connection attempt should be cancelled when all ATTIO callbacks
are unregistered.
---
 src/device.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index 5aec0c2..a95d449 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3144,6 +3144,11 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 	if (device->attios != NULL || device->attios_offline != NULL)
 		return TRUE;
 
+	if (device->auto_id) {
+		g_source_remove(device->auto_id);
+		device->auto_id = 0;
+	}
+
 	att_cleanup(device);
 
 	return TRUE;
-- 
1.7.8.6

