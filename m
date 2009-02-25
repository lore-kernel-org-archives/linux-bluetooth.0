Return-Path: <cyrus@holtmann.org>
From: evermind@tuxfamily.org
To: linux-bluetooth@vger.kernel.org
Cc: Frieder Buerzele <evermind@tuxfamily.org>
Subject: [PATCH] Fix segfault: If the interface name is NULL the bluetoothd daemon will crash
Date: Wed, 25 Feb 2009 12:56:51 +0100
Message-Id: <1235563011-1432-1-git-send-email-evermind@tuxfamily.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Frieder Buerzele <evermind@tuxfamily.org>

---
 gdbus/object.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 0786aeb..d920eac 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -224,11 +224,12 @@ static struct interface_data *find_interface(GSList *interfaces,
 {
 	GSList *list;
 
-	for (list = interfaces; list; list = list->next) {
-		struct interface_data *iface = list->data;
-		if (!strcmp(name, iface->name))
-			return iface;
-	}
+	if (name)
+		for (list = interfaces; list; list = list->next) {
+			struct interface_data *iface = list->data;
+			if (!strcmp(name, iface->name))
+				return iface;
+		}
 
 	return NULL;
 }
-- 
1.5.6.3

