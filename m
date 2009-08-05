Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH] Fix Class of Device initialization.
Date: Wed,  5 Aug 2009 21:05:03 +0530
Message-Id: <1249486503-18208-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 plugins/hciops.c |   19 -------------------
 src/adapter.c    |   21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 2b43737..6f96dda 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -103,25 +103,6 @@ static void configure_device(int index)
 		return;
 	}
 
-	/* Set device class */
-	if ((main_opts.flags & (1 << HCID_SET_CLASS))) {
-		write_class_of_dev_cp cp;
-		uint8_t cls[3];
-
-		if (read_local_class(&di.bdaddr, cls) < 0) {
-			uint32_t class = htobl(main_opts.class);
-			memcpy(cp.dev_class, &class, 3);
-		} else {
-			if (!(main_opts.scan & SCAN_INQUIRY))
-				cls[1] &= 0xdf; /* Clear discoverable bit */
-			cls[2] = get_service_classes(&di.bdaddr);
-			memcpy(cp.dev_class, cls, 3);
-		}
-
-		hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_CLASS_OF_DEV,
-					WRITE_CLASS_OF_DEV_CP_SIZE, &cp);
-	}
-
 	/* Set page timeout */
 	if ((main_opts.flags & (1 << HCID_SET_PAGETO))) {
 		write_page_timeout_cp cp;
diff --git a/src/adapter.c b/src/adapter.c
index bf69fcc..873b1bd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1756,6 +1756,8 @@ static int adapter_setup(struct btd_adapter *adapter, const char *mode)
 	uint8_t inqmode;
 	int err , dd;
 	char name[MAX_NAME_LENGTH + 1];
+	uint8_t cls[3];
+	uint32_t class;
 
 	dd = hci_open_dev(adapter->dev_id);
 	if (dd < 0) {
@@ -1815,9 +1817,28 @@ static int adapter_setup(struct btd_adapter *adapter, const char *mode)
 							adapter->dev_id);
 
 	adapter_ops->set_name(adapter->dev_id, name);
+
 	if (g_str_equal(mode, "off"))
 		strncpy((char *) adapter->dev.name, name, MAX_NAME_LENGTH);
 
+	/* Set device class */
+	if (read_local_class(&adapter->bdaddr, cls) < 0) {
+		class = htobl(main_opts.class);
+		memcpy(cls, &class, 3);
+	}
+
+	cls[2] = adapter->svc_cache;
+
+	class = (cls[2] << 16 | cls[1] << 8 | cls[0]);
+
+	if (hci_write_class_of_dev(dd, class, HCI_REQ_TIMEOUT) < 0) {
+		err = -errno;
+		error("Can't write class of device: %s (%d)",
+						strerror(errno), errno);
+		hci_close_dev(dd);
+		return err;
+	}
+
 done:
 	hci_close_dev(dd);
 	return 0;
-- 
1.5.6.3

