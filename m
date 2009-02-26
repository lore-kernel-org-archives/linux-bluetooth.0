Return-Path: <cyrus@holtmann.org>
From: Frieder Buerzele <evermind@tuxfamily.org>
To: linux-bluetooth@vger.kernel.org
Cc: Frieder Buerzele <evermind@tuxfamily.org>
Subject: [PATCH] Fix segfault: If the interface name is NULL the bluetoothd daemon will crash
Date: Thu, 26 Feb 2009 09:35:06 +0100
Message-Id: <1235637306-15025-2-git-send-email-evermind@tuxfamily.org>
In-Reply-To: <1235637306-15025-1-git-send-email-evermind@tuxfamily.org>
References: <1235637306-15025-1-git-send-email-evermind@tuxfamily.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/object.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 0786aeb..7bc9860 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -222,6 +222,9 @@ static void generic_unregister(DBusConnection *connection, void *user_data)
 static struct interface_data *find_interface(GSList *interfaces,
 						const char *name)
 {
+	if (NULL == name)
+		return NULL;
+
 	GSList *list;
 
 	for (list = interfaces; list; list = list->next) {
-- 
1.5.6.3

