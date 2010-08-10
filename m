Return-Path: <cyrus@holtmann.org>
From: David Scherba <dscherba@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com,
	marcel@holtmann.org,
	rshaffer@codeaurora.org,
	David Scherba <dscherba@codeaurora.org>
Subject: [PATCH 2/2] Use HCI device type to gate BR/EDR-specific HCI commands
Date: Tue, 10 Aug 2010 11:45:45 -0400
Message-Id: <1281455145-1777-1-git-send-email-dscherba@codeaurora.org>
In-Reply-To: <4C6173CA.8060308@codeaurora.org>
References: <4C6173CA.8060308@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Use the hci_dev_info structure member 'type' to classify whether a HCI device
is BR/EDR, or not.  If not, gate BR/EDR-specific HCI commands.
---
 lib/hci_lib.h    |    5 +++++
 plugins/hciops.c |   20 +++++++++++++-------
 src/adapter.c    |    2 +-
 src/security.c   |    4 ++--
 4 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index b63a2a4..814672d 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -169,6 +169,11 @@ static inline int hci_test_bit(int nr, void *addr)
 	return *((uint32_t *) addr + (nr >> 5)) & (1 << (nr & 31));
 }
 
+static inline int ignore_device(struct hci_dev_info *di)
+{
+	return hci_test_bit(HCI_RAW, &di->flags) || di->type >> 4 != HCI_BREDR;
+}
+
 /* HCI filter tools */
 static inline void hci_filter_clear(struct hci_filter *f)
 {
diff --git a/plugins/hciops.c b/plugins/hciops.c
index 3e3e172..9c97c5a 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -85,7 +85,7 @@ static void device_devup_setup(int index)
 	if (hci_devinfo(index, &di) < 0)
 		return;
 
-	if (hci_test_bit(HCI_RAW, &di.flags))
+	if (ignore_device(&di))
 		return;
 
 	dd = hci_open_dev(index);
@@ -122,6 +122,7 @@ static void device_devup_setup(int index)
 static void init_device(int index)
 {
 	struct hci_dev_req dr;
+	struct hci_dev_info di;
 	pid_t pid;
 	int dd, err;
 
@@ -159,12 +160,17 @@ static void init_device(int index)
 					index, strerror(err), err);
 	}
 
-	/* Set link policy */
-	dr.dev_opt = main_opts.link_policy;
-	if (ioctl(dd, HCISETLINKPOL, (unsigned long) &dr) < 0 &&
+	/* Set link policy for BR/EDR HCI devices */
+	if (hci_devinfo(index, &di) < 0)
+		goto fail;
+
+	if (!ignore_device(&di)) {
+		dr.dev_opt = main_opts.link_policy;
+		if (ioctl(dd, HCISETLINKPOL, (unsigned long) &dr) < 0 &&
 							errno != ENETDOWN) {
-		error("Can't set link policy on hci%d: %s (%d)",
-					index, strerror(errno), errno);
+			error("Can't set link policy on hci%d: %s (%d)",
+						index, strerror(errno), errno);
+		}
 	}
 
 	/* Start HCI device */
@@ -196,7 +202,7 @@ static void device_devreg_setup(int index)
 
 	devup = hci_test_bit(HCI_UP, &di.flags);
 
-	if (!hci_test_bit(HCI_RAW, &di.flags))
+	if (!ignore_device(&di))
 		manager_register_adapter(index, devup);
 }
 
diff --git a/src/adapter.c b/src/adapter.c
index af44a59..fc1e123 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2300,7 +2300,7 @@ int adapter_start(struct btd_adapter *adapter)
 	if (hci_devinfo(adapter->dev_id, &di) < 0)
 		return -errno;
 
-	if (hci_test_bit(HCI_RAW, &di.flags)) {
+	if (ignore_device(&di)) {
 		dev->ignore = 1;
 		return -1;
 	}
diff --git a/src/security.c b/src/security.c
index ca394e1..667f1f1 100644
--- a/src/security.c
+++ b/src/security.c
@@ -999,7 +999,7 @@ static gboolean io_security_event(GIOChannel *chan, GIOCondition cond,
 
 	ioctl(dev, HCIGETDEVINFO, (void *) di);
 
-	if (hci_test_bit(HCI_RAW, &di->flags))
+	if (ignore_device(di))
 		return TRUE;
 
 	switch (eh->evt) {
@@ -1185,7 +1185,7 @@ void start_security_manager(int hdev)
 	io_data[hdev].channel = chan;
 	io_data[hdev].pin_length = -1;
 
-	if (hci_test_bit(HCI_RAW, &di->flags))
+	if (ignore_device(di))
 		return;
 
 	bacpy(&cp.bdaddr, BDADDR_ANY);
-- 
1.7.0.2
-- 
David Scherba
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
