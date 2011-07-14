Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 08/12] Drop GAttrib ref if callback list is empty
Date: Thu, 14 Jul 2011 13:36:58 -0300
Message-Id: <1310661418-31047-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <CAKT1EBdM2rPSBj5SFsGj_k5FAuifK83o+msRNjBzyfeHdRU3MQ@mail.gmail.com>
References: <CAKT1EBdM2rPSBj5SFsGj_k5FAuifK83o+msRNjBzyfeHdRU3MQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If all ATT connection callbacks are unregistered, GAttrib reference
can be dropped.
---
 src/device.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index 1f45211..571a287 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2603,10 +2603,18 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 
 	g_free(attio);
 
+	if (device->attios != NULL)
+		return TRUE;
+
 	if (device->attioid) {
 		g_source_remove(device->attioid);
 		device->attioid = 0;
 	}
 
+	if (device->attrib) {
+		g_attrib_unref(device->attrib);
+		device->attrib = NULL;
+	}
+
 	return TRUE;
 }
-- 
1.7.6

