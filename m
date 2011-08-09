Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 2/2] Fix ATT disconnect callback not being called
Date: Tue,  9 Aug 2011 13:47:44 -0300
Message-Id: <1312908464-20064-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1312908464-20064-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1312908464-20064-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GAttrib disconnect function needs to be set after discovering the
primary services if the connection callback list is not empty. After
creating a device the connection can stay up, for this scenario the
registered disconnection callbacks are not being called.
---
 src/device.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 9dd657c..13749bf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1661,7 +1661,9 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	if (device->attios == NULL && device->attios_offline == NULL) {
 		g_attrib_unref(device->attrib);
 		device->attrib = NULL;
-	}
+	} else
+		g_attrib_set_disconnect_function(device->attrib,
+						attrib_disconnected, device);
 
 	g_slist_free(uuids);
 
-- 
1.7.6

