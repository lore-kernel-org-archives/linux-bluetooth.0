Return-Path: <cyrus@holtmann.org>
From: Pawel Wieczorkiewicz <pawel.wieczorkiewicz@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Pawel Wieczorkiewicz <pawel.wieczorkiewicz@tieto.com>
Subject: [PATCH] Setting default Link Policy according to the chip supported features
Date: Mon, 13 Dec 2010 13:26:42 +0100
Message-Id: <1292243202-6821-1-git-send-email-pawel.wieczorkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

By default all features are enabled (RSWITCH, HOLD, PARK, SNIFF).
When "read local supported features" complete event occurs, not supported
features are disabled and then "Write default link policy" command with
supported features is sent.

On behalf of ST-Ericsson SA
---
 plugins/hciops.c |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 4af137c..404422e 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -896,9 +896,25 @@ static void read_local_version_complete(int index,
 static void read_local_features_complete(int index,
 				const read_local_features_rp *rp)
 {
+    uint16_t policy;
+
 	if (rp->status)
 		return;
 
+	/* Set default link policy */
+	if (!(rp->features[0] & LMP_RSWITCH))
+		main_opts.link_policy &= ~HCI_LP_RSWITCH;
+	if (!(rp->features[0] & LMP_HOLD))
+		main_opts.link_policy &= ~HCI_LP_HOLD;
+	if (!(rp->features[0] & LMP_SNIFF))
+		main_opts.link_policy &= ~HCI_LP_SNIFF;
+	if (!(rp->features[1] & LMP_PARK))
+		main_opts.link_policy &= ~HCI_LP_PARK;
+
+	policy = htobs(main_opts.link_policy);
+	hci_send_cmd(SK(index), OGF_LINK_POLICY,
+				OCF_WRITE_DEFAULT_LINK_POLICY, 2, &policy);
+
 	memcpy(FEATURES(index), rp->features, 8);
 
 	if (!PENDING(index))
@@ -1949,7 +1965,6 @@ static void at_child_exit(void)
 static void device_devup_setup(int index)
 {
 	struct hci_dev_info di;
-	uint16_t policy;
 	read_stored_link_key_cp cp;
 
 	DBG("hci%d", index);
@@ -1972,11 +1987,6 @@ static void device_devup_setup(int index)
 					WRITE_PAGE_TIMEOUT_CP_SIZE, &cp);
 	}
 
-	/* Set default link policy */
-	policy = htobs(main_opts.link_policy);
-	hci_send_cmd(SK(index), OGF_LINK_POLICY,
-				OCF_WRITE_DEFAULT_LINK_POLICY, 2, &policy);
-
 	bacpy(&cp.bdaddr, BDADDR_ANY);
 	cp.read_all = 1;
 	hci_send_cmd(SK(index), OGF_HOST_CTL, OCF_READ_STORED_LINK_KEY,
@@ -2046,15 +2056,6 @@ static void init_device(int index)
 	if (hci_devinfo(index, &di) < 0)
 		goto fail;
 
-	if (!ignore_device(&di)) {
-		dr.dev_opt = main_opts.link_policy;
-		if (ioctl(dd, HCISETLINKPOL, (unsigned long) &dr) < 0 &&
-							errno != ENETDOWN) {
-			error("Can't set link policy on hci%d: %s (%d)",
-						index, strerror(errno), errno);
-		}
-	}
-
 	/* Start HCI device */
 	if (ioctl(dd, HCIDEVUP, index) < 0 && errno != EALREADY) {
 		error("Can't init device hci%d: %s (%d)",
-- 
1.7.0.4

