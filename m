Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v2 01/14] core: Control connections based on adapter state
Date: Wed, 15 Aug 2012 11:50:40 -0300
Message-Id: <1345042253-15053-2-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1345042253-15053-1-git-send-email-jprvita@openbossa.org>
References: <1345042253-15053-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

This patch disable automatic ATTIO connections when the adapter is
powered down and enable automatic connection when the adapter is powered
on.
---
 src/adapter.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index e6b5559..8709a91 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2098,6 +2098,14 @@ static int get_pairable_timeout(const char *src)
 	return main_opts.pairto;
 }
 
+static void set_auto_connect(gpointer data, gpointer user_data)
+{
+	struct btd_device *device = data;
+	gboolean enable = GPOINTER_TO_INT(user_data);
+
+	device_set_auto_connect(device, enable);
+}
+
 static void call_adapter_powered_callbacks(struct btd_adapter *adapter,
 						gboolean powered)
 {
@@ -2107,7 +2115,10 @@ static void call_adapter_powered_callbacks(struct btd_adapter *adapter,
 		btd_adapter_powered_cb cb = l->data;
 
 		cb(adapter, powered);
-       }
+	}
+
+	g_slist_foreach(adapter->devices, set_auto_connect,
+						GINT_TO_POINTER(powered));
 }
 
 static void emit_device_disappeared(gpointer data, gpointer user_data)
@@ -3318,15 +3329,10 @@ static gboolean disable_auto(gpointer user_data)
 	return FALSE;
 }
 
-static void set_auto_connect(gpointer data, gpointer user_data)
-{
-	struct btd_device *device = data;
-
-	device_set_auto_connect(device, TRUE);
-}
-
 void btd_adapter_enable_auto_connect(struct btd_adapter *adapter)
 {
+	gboolean enable = TRUE;
+
 	if (!adapter->up)
 		return;
 
@@ -3335,7 +3341,8 @@ void btd_adapter_enable_auto_connect(struct btd_adapter *adapter)
 	if (adapter->auto_timeout_id)
 		return;
 
-	g_slist_foreach(adapter->devices, set_auto_connect, NULL);
+	g_slist_foreach(adapter->devices, set_auto_connect,
+						GINT_TO_POINTER(enable));
 
 	adapter->auto_timeout_id = g_timeout_add_seconds(main_opts.autoto,
 						disable_auto, adapter);
-- 
1.7.11.2

