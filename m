Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 2/6] Add Tx Power and Immediate Alert UUID
Date: Thu, 28 Jul 2011 11:43:12 -0300
Message-Id: <1311864192-16191-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1311803586-5405-3-git-send-email-claudio.takahasi@openbossa.org>
References: <1311803586-5405-3-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes Proximity Monitor driver declaration adding the Tx Power and
Immediate Alert UUIDs. UUIDs are required to support Path Loss and
Find ME.
---
 proximity/manager.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/proximity/manager.c b/proximity/manager.c
index 8d0aee1..98ac59f 100644
--- a/proximity/manager.c
+++ b/proximity/manager.c
@@ -35,7 +35,9 @@
 #include "reporter.h"
 #include "manager.h"
 
-#define LINK_LOSS_UUID "00001803-0000-1000-8000-00805f9b34fb"
+#define IMMEDIATE_ALERT_UUID	"00001802-0000-1000-8000-00805f9b34fb"
+#define LINK_LOSS_UUID		"00001803-0000-1000-8000-00805f9b34fb"
+#define TX_POWER_UUID		"00001804-0000-1000-8000-00805f9b34fb"
 
 static DBusConnection *connection = NULL;
 
@@ -51,7 +53,7 @@ static void attio_device_remove(struct btd_device *device)
 
 static struct btd_device_driver monitor_driver = {
 	.name = "Proximity GATT Driver",
-	.uuids = BTD_UUIDS(LINK_LOSS_UUID),
+	.uuids = BTD_UUIDS(IMMEDIATE_ALERT_UUID, LINK_LOSS_UUID, TX_POWER_UUID),
 	.probe = attio_device_probe,
 	.remove = attio_device_remove,
 };
-- 
1.7.6

