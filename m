Return-Path: <cyrus@holtmann.org>
From: David Scherba <dscherba@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, marcel@holtmann.org,
	rshaffer@codeaurora.org, David Scherba <dscherba@codeaurora.org>
Subject: [PATCH 2/2] Use HCI device type to gate BR/EDR-specific HCI commands
Date: Mon,  9 Aug 2010 17:07:39 -0400
Message-Id: <1281388059-15945-3-git-send-email-dscherba@codeaurora.org>
In-Reply-To: <1281388059-15945-1-git-send-email-dscherba@codeaurora.org>
References: <1281388059-15945-1-git-send-email-dscherba@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the hci_dev_info structure member 'type' to classify whether a HCI device
is BR/EDR, or not.  If not, gate BR/EDR-specific HCI commands.
---
 lib/hci_lib.h    |    5 +++++
 plugins/hciops.c |   23 +++++++++++++++--------
 src/adapter.c    |    3 ++-
 src/security.c   |    6 ++++--
 4 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/lib/hci_lib.h b/lib/hci_lib.h
index b63a2a4..c0786ab 100644
--- a/lib/hci_lib.h
+++ b/lib/hci_lib.h
@@ -169,6 +169,11 @@ static inline int hci_test_bit(int nr, void *addr)
 	return *((uint32_t *) addr + (nr >> 5)) & (1 << (nr & 31));
 }
 
+static inline int is_bredr_hci_device_type(uint8_t type)
+{
+  return (type >> 4) == HCI_BREDR;
+}
+
 /* HCI filter tools */
 static inline void hci_filter_clear(struct hci_filter *f)
 {
diff --git a/plugins/hciops.c b/plugins/hciops.c
index b38c056..705e9dd 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -85,7 +85,8 @@ static void device_devup_setup(int index)
 	if (hci_devinfo(index, &di) < 0)
 		return;
 
-	if (hci_test_bit(HCI_RAW, &di.flags))
+	if (!is_bredr_hci_device_type(di.type) ||
+	    hci_test_bit(HCI_RAW, &di.flags))
 		return;
 
 	dd = hci_open_dev(index);
@@ -160,12 +161,17 @@ static void init_device(int index)
 					index, strerror(err), err);
 	}
 
-	/* Set link policy */
-	dr.dev_opt = main_opts.link_policy;
-	if (ioctl(dd, HCISETLINKPOL, (unsigned long) &dr) < 0 &&
-							errno != ENETDOWN) {
-		error("Can't set link policy on hci%d: %s (%d)",
-					index, strerror(errno), errno);
+	/* Set link policy for BR/EDR HCI devices */
+	if (hci_devinfo(index, &di) < 0)
+		goto fail;
+
+	if (is_bredr_hci_device_type(di.type)) {
+		dr.dev_opt = main_opts.link_policy;
+		if (ioctl(dd, HCISETLINKPOL, (unsigned long) &dr) < 0 &&
+								errno != ENETDOWN) {
+			error("Can't set link policy on hci%d: %s (%d)",
+						index, strerror(errno), errno);
+		}
 	}
 
 	/* Start HCI device */
@@ -198,7 +204,8 @@ static void device_devreg_setup(int index)
 
 	devup = hci_test_bit(HCI_UP, &di.flags);
 
-	if (!hci_test_bit(HCI_RAW, &di.flags))
+	if (is_bredr_hci_device_type(di.type) &&
+	    !hci_test_bit(HCI_RAW, &di.flags))
 		manager_register_adapter(index, devup);
 }
 
diff --git a/src/adapter.c b/src/adapter.c
index 7d0e34d..acc1068 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2314,7 +2314,8 @@ int adapter_start(struct btd_adapter *adapter)
 	if (hci_devinfo(adapter->dev_id, &di) < 0)
 		return -errno;
 
-	if (hci_test_bit(HCI_RAW, &di.flags)) {
+	if (!is_bredr_hci_device_type(di.type) ||
+	    hci_test_bit(HCI_RAW, &di.flags)) {
 		dev->ignore = 1;
 		return -1;
 	}
diff --git a/src/security.c b/src/security.c
index ca394e1..6d07d86 100644
--- a/src/security.c
+++ b/src/security.c
@@ -999,7 +999,8 @@ static gboolean io_security_event(GIOChannel *chan, GIOCondition cond,
 
 	ioctl(dev, HCIGETDEVINFO, (void *) di);
 
-	if (hci_test_bit(HCI_RAW, &di->flags))
+	if (!is_bredr_hci_device_type(di->type) ||
+	    hci_test_bit(HCI_RAW, &di->flags))
 		return TRUE;
 
 	switch (eh->evt) {
@@ -1185,7 +1186,8 @@ void start_security_manager(int hdev)
 	io_data[hdev].channel = chan;
 	io_data[hdev].pin_length = -1;
 
-	if (hci_test_bit(HCI_RAW, &di->flags))
+	if (!is_bredr_hci_device_type(di->type) ||
+	    hci_test_bit(HCI_RAW, &di->flags))
 		return;
 
 	bacpy(&cp.bdaddr, BDADDR_ANY);
-- 
1.7.0
-- 
David Scherba
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
