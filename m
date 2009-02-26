Return-Path: <cyrus@holtmann.org>
From: Frieder Buerzele <evermind@tuxfamily.org>
To: linux-bluetooth@vger.kernel.org
Cc: Frieder Buerzele <evermind@tuxfamily.org>
Subject: [PATCH] Fix segfault: If the interface name is NULL the bluetoothd daemon will crash
Date: Thu, 26 Feb 2009 09:46:47 +0100
Message-Id: <1235638007-22946-2-git-send-email-evermind@tuxfamily.org>
In-Reply-To: <1235638007-22946-1-git-send-email-evermind@tuxfamily.org>
References: <1235638007-22946-1-git-send-email-evermind@tuxfamily.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/object.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 0786aeb..dde654b 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -224,6 +224,9 @@ static struct interface_data *find_interface(GSList *interfaces,
 {
 	GSList *list;
 
+	if (NULL == name)
+		return NULL;
+
 	for (list = interfaces; list; list = list->next) {
 		struct interface_data *iface = list->data;
 		if (!strcmp(name, iface->name))
-- 
1.5.6.3

