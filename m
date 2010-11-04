Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Fix invalid reference to GATT service structure
Date: Thu,  4 Nov 2010 19:43:30 +0000
Message-Id: <1288899810-18722-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1288899810-18722-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1288899810-18722-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 attrib/client.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index bcc903b..1f2c217 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -1342,13 +1342,9 @@ int attrib_client_register(struct btd_device *device, int psm)
 	bacpy(&gatt->dba, &dba);
 	gatt->psm = psm;
 
-	gatt_services = g_slist_append(gatt_services, gatt);
-
-	/* FIXME: we should also listen for incoming connections */
-
 	if (load_primary_services(gatt)) {
 		DBG("Primary services loaded");
-		return 0;
+		goto done;
 	}
 
 	if (psm < 0) {
@@ -1385,6 +1381,9 @@ int attrib_client_register(struct btd_device *device, int psm)
 	g_attrib_set_disconnect_function(gatt->attrib, attrib_disconnect,
 									gatt);
 
+done:
+	gatt_services = g_slist_append(gatt_services, gatt);
+
 	return 0;
 }
 
-- 
1.7.3.2

