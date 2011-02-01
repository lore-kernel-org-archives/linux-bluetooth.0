Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Fix sending HCIDEVUP when adapter is already up
Date: Tue,  1 Feb 2011 17:47:27 +0200
Message-Id: <1296575248-20185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

There is no need for HCIDEVUP/fork in such cases it will just consume
more resources for no reason.

To fix this HCI_DEV_REG is no longer generate for adapter already up
instead init_device is called directly which simplify the code path.
---
 plugins/hciops.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index ecfcec3..80ae61a 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -2458,7 +2458,7 @@ static void init_pending(int index)
 	hci_set_bit(PENDING_NAME, &dev->pending);
 }
 
-static void init_device(int index)
+static void init_device(int index, gboolean already_up)
 {
 	struct hci_dev_req dr;
 	int dd;
@@ -2482,6 +2482,10 @@ static void init_device(int index)
 	init_pending(index);
 	start_hci_dev(index);
 
+	/* Avoid forking if nothing else has to be done */
+	if (already_up)
+		return;
+
 	/* Do initialization in the separate process */
 	pid = fork();
 	switch (pid) {
@@ -2562,7 +2566,7 @@ static void device_event(int event, int index)
 	switch (event) {
 	case HCI_DEV_REG:
 		info("HCI dev %d registered", index);
-		init_device(index);
+		init_device(index, FALSE);
 		break;
 
 	case HCI_DEV_UNREG:
@@ -2648,12 +2652,15 @@ static gboolean init_known_adapters(gpointer user_data)
 
 	for (i = 0; i < dl->dev_num; i++, dr++) {
 		struct dev_info *dev;
+		gboolean already_up;
+
+		already_up = hci_test_bit(HCI_UP, &dr->dev_opt);
 
-		device_event(HCI_DEV_REG, dr->dev_id);
+		init_device(dr->dev_id, already_up);
 
 		dev = &devs[dr->dev_id];
 
-		dev->already_up = hci_test_bit(HCI_UP, &dr->dev_opt);
+		dev->already_up = already_up;
 
 		if (!dev->already_up)
 			continue;
-- 
1.7.1

