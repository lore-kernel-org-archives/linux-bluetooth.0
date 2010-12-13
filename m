Return-Path: <cyrus@holtmann.org>
From: Pawel Wieczorkiewicz <pawel.wieczorkiewicz@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Pawel Wieczorkiewicz <pawel.wieczorkiewicz@tieto.com>
Subject: [PATCH] Setting default Link Policy according to the chip supported features
Date: Mon, 13 Dec 2010 15:19:14 +0100
Message-Id: <1292249954-8544-1-git-send-email-pawel.wieczorkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

By default all features are enabled (RSWITCH, HOLD, PARK, SNIFF).
When "read local supported features" complete event occurs, not supported
features are disabled and then "Write default link policy" command with
supported features is sent.

On behalf of ST-Ericsson SA
---
 plugins/hciops.c |   35 +++++++++++++++--------------------
 1 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 4af137c..44039ba 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -297,6 +297,7 @@ static void start_adapter(int index)
 {
 	uint8_t events[8] = { 0xff, 0xff, 0xff, 0xff, 0xff, 0x1f, 0x00, 0x00 };
 	uint8_t inqmode;
+	uint16_t policy;
 
 	if (VER(index).lmp_ver > 1) {
 		if (FEATURES(index)[5] & LMP_SNIFF_SUBR)
@@ -345,6 +346,20 @@ static void start_adapter(int index)
 		hci_send_cmd(SK(index), OGF_HOST_CTL,
 				OCF_READ_INQ_RESPONSE_TX_POWER_LEVEL, 0, NULL);
 
+	/* Set default link policy */
+	if (!(FEATURES(index)[0] & LMP_RSWITCH))
+		main_opts.link_policy &= ~HCI_LP_RSWITCH;
+	if (!(FEATURES(index)[0] & LMP_HOLD))
+		main_opts.link_policy &= ~HCI_LP_HOLD;
+	if (!(FEATURES(index)[0] & LMP_SNIFF))
+		main_opts.link_policy &= ~HCI_LP_SNIFF;
+	if (!(FEATURES(index)[1] & LMP_PARK))
+		main_opts.link_policy &= ~HCI_LP_PARK;
+
+	policy = htobs(main_opts.link_policy);
+	hci_send_cmd(SK(index), OGF_LINK_POLICY,
+				OCF_WRITE_DEFAULT_LINK_POLICY, 2, &policy);
+
 	CURRENT_COD(index) = 0;
 	memset(EIR(index), 0, sizeof(EIR(index)));
 
@@ -1949,7 +1964,6 @@ static void at_child_exit(void)
 static void device_devup_setup(int index)
 {
 	struct hci_dev_info di;
-	uint16_t policy;
 	read_stored_link_key_cp cp;
 
 	DBG("hci%d", index);
@@ -1972,11 +1986,6 @@ static void device_devup_setup(int index)
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
@@ -1997,7 +2006,6 @@ static void init_pending(int index)
 static void init_device(int index)
 {
 	struct hci_dev_req dr;
-	struct hci_dev_info di;
 	int dd;
 	pid_t pid;
 
@@ -2042,19 +2050,6 @@ static void init_device(int index)
 		error("Can't set link mode on hci%d: %s (%d)",
 						index, strerror(errno), errno);
 
-	/* Set link policy for BR/EDR HCI devices */
-	if (hci_devinfo(index, &di) < 0)
-		goto fail;
-
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

