Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 4/5] Fix device version in GetProperties
Date: Mon, 26 Mar 2012 14:45:27 +0200
Message-Id: <1332765928-6251-5-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1332765928-6251-1-git-send-email-chen.ganir@ti.com>
References: <1332765928-6251-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Fix how device version is added to the property dictionay.
---
 src/device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index eab7e4c..3b772ee 100644
--- a/src/device.c
+++ b/src/device.c
@@ -383,7 +383,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 							&device->product);
 
 	/* Version */
-	if (device->product)
+	if (device->version)
 		dict_append_entry(&dict, "Version", DBUS_TYPE_UINT16,
 							&device->version);
 
-- 
1.7.4.1

