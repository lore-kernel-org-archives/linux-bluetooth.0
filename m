Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/daemon: Save adapter name on complete event
Date: Tue,  5 Nov 2013 12:08:48 +0200
Message-Id: <1383646128-8077-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <CABBYNZKJV-h82WQ5_J3z+ArC3=Gy00qTpKHhWSF7v+fFC7KTrA@mail.gmail.com>
References: <CABBYNZKJV-h82WQ5_J3z+ArC3=Gy00qTpKHhWSF7v+fFC7KTrA@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Saving adapter name was missing from set name complete event.
Refactor code to function and reuse it in both places where
name is changed.
---
 android/adapter.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index b6f6096..6b0dc8b 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -88,6 +88,17 @@ static void adapter_name_changed(const uint8_t *name)
 			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev, -1);
 }
 
+static void adapter_set_name(const uint8_t *name)
+{
+	if (!g_strcmp0(adapter->name, (const char *) name))
+		return;
+
+	DBG("Cnage name: %s -> %s", adapter->name, name);
+
+	g_free(adapter->name);
+	adapter->name = g_strdup((const char *) name);
+}
+
 static void mgmt_local_name_changed_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -98,13 +109,7 @@ static void mgmt_local_name_changed_event(uint16_t index, uint16_t length,
 		return;
 	}
 
-	if (!g_strcmp0(adapter->name, (const char *) rp->name))
-		return;
-
-	DBG("name: %s", rp->name);
-
-	g_free(adapter->name);
-	adapter->name = g_strdup((const char *) rp->name);
+	adapter_set_name(rp->name);
 
 	adapter_name_changed(rp->name);
 }
@@ -879,6 +884,8 @@ static void set_adapter_name_complete(uint8_t status, uint16_t length,
 		return;
 	}
 
+	adapter_set_name(rp->name);
+
 	adapter_name_changed(rp->name);
 }
 
-- 
1.7.10.4

