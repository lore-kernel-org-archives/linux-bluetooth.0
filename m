Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 03/11] Add continuous connection attempt
Date: Mon, 26 Sep 2011 14:48:20 -0300
Message-Id: <1317059308-20038-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1317059308-20038-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If auto connect is enabled, queue another connection attempt until
the adapter sets auto connect to FALSE. The behaviour depends on if the
address is found in the advertising cache or not.
---
 src/device.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 410cf4c..ab4792b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1674,6 +1674,8 @@ done:
 	browse_request_free(req, shutdown);
 }
 
+static gboolean att_connect(gpointer user_data);
+
 static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -1691,7 +1693,8 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 
 			device->browse = NULL;
 			browse_request_free(req, TRUE);
-		}
+		} else if (device->auto_connect)
+			g_idle_add(att_connect, device);
 
 		return;
 	}
@@ -1932,6 +1935,13 @@ void device_set_auto_connect(struct btd_device *device, gboolean enable)
 	DBG("%s auto connect: %d", addr, enable);
 
 	device->auto_connect = enable;
+
+	if (device->attrib) {
+		DBG("Already connected");
+		return;
+	}
+
+	g_idle_add(att_connect, device);
 }
 
 void device_set_type(struct btd_device *device, device_type_t type)
-- 
1.7.6.1

