Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] device: Remove unused fields from browse_req
Date: Wed,  8 Feb 2012 17:35:49 -0300
Message-Id: <1328733349-29731-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1328733349-29731-1-git-send-email-andre.guedes@openbossa.org>
References: <1328733349-29731-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index a85dd57..cc7d11a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -100,8 +100,6 @@ struct authentication_req {
 struct browse_req {
 	DBusConnection *conn;
 	DBusMessage *msg;
-	GIOChannel *io;
-	GAttrib *attrib;
 	struct btd_device *device;
 	GSList *match_uuids;
 	GSList *profiles_added;
-- 
1.7.9

