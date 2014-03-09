Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 2/3] android: Cancel all pending confirm name before stop discovery
Date: Mon, 10 Mar 2014 00:06:36 +0100
Message-ID: <1394406397-6843-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394406397-6843-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394406397-6843-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If user wants to cancel discovery we should remove all the confirm name 
requests from mgmt queues.

It is in order to make sure that stop discovery have a free way to
reach kernel.

This improves scenario when there is a big inflow of device found events and
mgmt queues become full of confirm name requests. In such case stop discovery 
might stack in the queue.
---
 android/bluetooth.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 60ca17d..9286c67 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2467,6 +2467,14 @@ static bool start_discovery(void)
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
@@ -2481,6 +2489,9 @@ static bool stop_discovery(void)
 
 	DBG("type=0x%x", cp.type);
 
+	/* Lets drop all confirm name request as we don't need it anymore */
+	g_slist_foreach(cached_devices, cancel_pending_confirm_name, NULL);
+
 	if (mgmt_send(mgmt_if, MGMT_OP_STOP_DISCOVERY, adapter.index,
 					sizeof(cp), &cp, NULL, NULL, NULL) > 0)
 		return true;
-- 
1.8.4

