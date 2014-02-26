Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 16/17] android: Cancel all pending confirm name before stop discovery
Date: Wed, 26 Feb 2014 02:57:27 +0100
Message-ID: <1393379848-4031-17-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make sure there is nothing outstdanign related to discovery before
sending stop discovery.

It is also in order to make sure that stop discovery have a free way to
get the kernel.
---
 android/bluetooth.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index e0bc730..fb33976 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2456,6 +2456,14 @@ static bool start_discovery(void)
 	return false;
 }
 
+static void cancel_pending_confirm_name(gpointer data, gpointer user_data)
+{
+	struct device *dev = data;
+
+	mgmt_cancel(mgmt_if, dev->confirm_id);
+	dev->confirm_id = 0;
+}
+
 static bool stop_discovery(void)
 {
 	struct mgmt_cp_stop_discovery cp;
@@ -2468,6 +2476,9 @@ static bool stop_discovery(void)
 
 	DBG("type=0x%x", type);
 
+	/* Lets drop all confirm name request as we don't need it anymore */
+	g_slist_foreach(cached_devices, cancel_pending_confirm_name, NULL);
+
 	if (mgmt_send(mgmt_if, MGMT_OP_STOP_DISCOVERY, adapter.index,
 					sizeof(cp), &cp, NULL, NULL, NULL) > 0)
 		return true;
-- 
1.8.4

