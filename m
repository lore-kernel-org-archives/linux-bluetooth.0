Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 04/12] Notify the GAttrib instance if already connected
Date: Wed,  6 Jul 2011 18:23:17 -0300
Message-Id: <1309987397-9966-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1309874168-32716-5-git-send-email-claudio.takahasi@openbossa.org>
References: <1309874168-32716-5-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When registering the connect and disconnect callbacks for ATT, GAttrib
instance should be informed to the caller if the link is up.
---
 src/device.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index b14e6e7..eeeb25f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -132,6 +132,7 @@ struct btd_device {
 	struct bonding_req *bonding;
 	struct authentication_req *authr;	/* authentication request */
 	GSList		*disconnects;		/* disconnects message */
+	GAttrib		*attrib;
 	GSList		*attios;
 
 	gboolean	connected;
@@ -2475,6 +2476,9 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 
 	device->attios = g_slist_append(device->attios, attio);
 
+	if (device->attrib && func)
+		func(device->attrib, user_data);
+
 	return attio->id;
 }
 
-- 
1.7.6

