Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 08/12] Drop GAttrib ref if callback list is empty
Date: Wed,  6 Jul 2011 18:23:50 -0300
Message-Id: <1309987430-10111-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1309874168-32716-9-git-send-email-claudio.takahasi@openbossa.org>
References: <1309874168-32716-9-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If all ATT connection callbacks are unregistered, GAttrib reference
can be dropped.
---
 src/device.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index 2185b77..3d092e2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2605,10 +2605,15 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 
 	g_free(attio);
 
+	if (device->attios != NULL)
+		return TRUE;
+
 	if (device->attioid) {
 		g_source_remove(device->attioid);
 		device->attioid = 0;
 	}
 
+	g_attrib_unref(device->attrib);
+
 	return TRUE;
 }
-- 
1.7.6

