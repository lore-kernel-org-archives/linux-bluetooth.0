Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH 2/2] gdbus: Remove reduntant copy of GSList* from function
Date: Thu, 11 Aug 2011 00:14:47 +0530
Message-Id: <1313001887-29644-2-git-send-email-syamsidhardh@gmail.com>
In-Reply-To: <1313001887-29644-1-git-send-email-syamsidhardh@gmail.com>
References: <1313001887-29644-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Local copy of the pointer to list is not required, because these
functions already has a copy, through the arguments.
---
 gdbus/object.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 8bc12f5..dafb6b5 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -399,15 +399,13 @@ static void generic_unregister(DBusConnection *connection, void *user_data)
 	g_free(data);
 }
 
-static struct interface_data *find_interface(GSList *interfaces,
+static struct interface_data *find_interface(GSList *list,
 						const char *name)
 {
-	GSList *list;
-
 	if (name == NULL)
 		return NULL;
 
-	for (list = interfaces; list; list = list->next) {
+	for (; list; list = list->next) {
 		struct interface_data *iface = list->data;
 		if (!strcmp(name, iface->name))
 			return iface;
-- 
1.7.4.1

