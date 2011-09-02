Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 03/11] Add continuous connection attempt
Date: Fri,  2 Sep 2011 18:38:33 -0300
Message-Id: <1314999521-11261-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1314999521-11261-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1314999521-11261-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If auto connect is enabled, queue another connection attempt until
the adapter sets auto connect to FALSE(after 3 minutes).
---
 src/device.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 4af6c1d..e812e01 100644
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
@@ -1928,6 +1931,13 @@ void device_set_auto_connect(struct btd_device *device, gboolean enable)
 	DBG("auto connect: %d", enable);
 
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
1.7.6

