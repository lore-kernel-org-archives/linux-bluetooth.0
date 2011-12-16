Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 07/11] attrib-server: Attah gatt channels to a adapters
Date: Fri, 16 Dec 2011 17:09:55 +0100
Message-Id: <1324051799-21439-8-git-send-email-sancane@gmail.com>
In-Reply-To: <1324051799-21439-7-git-send-email-sancane@gmail.com>
References: <1324051799-21439-1-git-send-email-sancane@gmail.com>
 <1324051799-21439-2-git-send-email-sancane@gmail.com>
 <1324051799-21439-3-git-send-email-sancane@gmail.com>
 <1324051799-21439-4-git-send-email-sancane@gmail.com>
 <1324051799-21439-5-git-send-email-sancane@gmail.com>
 <1324051799-21439-6-git-send-email-sancane@gmail.com>
 <1324051799-21439-7-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a new field to gatt channel structure to referentiate
the adapter which the channel belongs
---
 src/attrib-server.c |   22 +++++++++++++---------
 1 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index c7a9a67..ad2dfd5 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -54,15 +54,6 @@
 
 static GSList *database = NULL;
 
-struct gatt_channel {
-	bdaddr_t src;
-	bdaddr_t dst;
-	GAttrib *attrib;
-	guint mtu;
-	gboolean le;
-	guint id;
-	gboolean encrypted;
-};
 
 struct group_elem {
 	uint16_t handle;
@@ -81,6 +72,17 @@ struct gatt_adapter {
 	GSList			*database;
 };
 
+struct gatt_channel {
+	bdaddr_t		src;
+	bdaddr_t		dst;
+	GAttrib			*attrib;
+	guint			mtu;
+	gboolean		le;
+	guint			id;
+	gboolean		encrypted;
+	struct gatt_adapter	*gatt_adapter;
+};
+
 static GSList *adapters = NULL;
 
 /* GAP attribute handles */
@@ -1046,6 +1048,8 @@ guint attrib_channel_attach(GAttrib *attrib, gboolean out)
 	if (gatt_adapter == NULL)
 		return 0;
 
+	channel->gatt_adapter = gatt_adapter;
+
 	ba2str(&channel->dst, addr);
 	device = adapter_find_device(gatt_adapter->adapter, addr);
 
-- 
1.7.8

