Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] hciops: fix adapter initialization when commands are missed
Date: Mon, 17 Oct 2011 12:47:28 +0300
Message-Id: <1318844848-25379-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Sometimes after e.g, suspend we miss some initialization commands from
the kernel, even though we had a workaround for this it doesn't really
work as expected since the adapter must be up in order to resend.

To fix this problem the resend logic is moved after DEVUP.
---
 plugins/hciops.c |   40 ++++++++++++++++++++++++----------------
 1 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 9fb28c8..d0ba3ad 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -1482,21 +1482,6 @@ static void read_local_name_complete(int index, read_local_name_rp *rp)
 
 	DBG("Got name for hci%d", index);
 
-	/* Even though it shouldn't happen (assuming the kernel behaves
-	 * properly) it seems like we might miss the very first
-	 * initialization commands that the kernel sends. So check for
-	 * it here (since read_local_name is one of the last init
-	 * commands) and resend the first ones if we haven't seen
-	 * their results yet */
-
-	if (hci_test_bit(PENDING_FEATURES, &dev->pending))
-		hci_send_cmd(dev->sk, OGF_INFO_PARAM,
-					OCF_READ_LOCAL_FEATURES, 0, NULL);
-
-	if (hci_test_bit(PENDING_VERSION, &dev->pending))
-		hci_send_cmd(dev->sk, OGF_INFO_PARAM,
-					OCF_READ_LOCAL_VERSION, 0, NULL);
-
 	if (!dev->pending && dev->up)
 		init_adapter(index);
 }
@@ -2502,8 +2487,31 @@ static void device_devup_setup(int index)
 	hci_send_cmd(dev->sk, OGF_HOST_CTL, OCF_READ_STORED_LINK_KEY,
 					READ_STORED_LINK_KEY_CP_SIZE, &cp);
 
-	if (!dev->pending)
+	if (!dev->pending) {
 		init_adapter(index);
+		return;
+	}
+
+	/* Even though it shouldn't happen (assuming the kernel behaves
+	 * properly) it seems like we might miss the very first
+	 * initialization commands that the kernel sends. So check for
+	 * it here and resend the ones we haven't seen their results yet */
+
+	if (hci_test_bit(PENDING_FEATURES, &dev->pending))
+		hci_send_cmd(dev->sk, OGF_INFO_PARAM,
+					OCF_READ_LOCAL_FEATURES, 0, NULL);
+
+	if (hci_test_bit(PENDING_VERSION, &dev->pending))
+		hci_send_cmd(dev->sk, OGF_INFO_PARAM,
+					OCF_READ_LOCAL_VERSION, 0, NULL);
+
+	if (hci_test_bit(PENDING_NAME, &dev->pending))
+		hci_send_cmd(dev->sk, OGF_HOST_CTL,
+					OCF_READ_LOCAL_NAME, 0, 0);
+
+	if (hci_test_bit(PENDING_BDADDR, &dev->pending))
+		hci_send_cmd(dev->sk, OGF_INFO_PARAM,
+					OCF_READ_BD_ADDR, 0, NULL);
 }
 
 static void init_pending(int index)
-- 
1.7.6.4

