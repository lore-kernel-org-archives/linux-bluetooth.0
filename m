Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 1/2] Code cleanup in adapter.c.
Date: Wed,  6 May 2009 14:07:56 +0530
Message-Id: <1241599077-26438-1-git-send-email-alok.barsode@azingo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

Not passing device descriptor to adater_up.
---
 src/adapter.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index d9914e2..99dd2eb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1999,11 +1999,12 @@ static int get_pairable_timeout(const char *src)
 	return main_opts.pairto;
 }
 
-static int adapter_up(struct btd_adapter *adapter, int dd)
+static int adapter_up(struct btd_adapter *adapter)
 {
 	char mode[14], srcaddr[18];
 	uint8_t scan_mode;
 	gboolean powered, dev_down = FALSE;
+	int dd;
 
 	ba2str(&adapter->bdaddr, srcaddr);
 
@@ -2046,7 +2047,7 @@ static int adapter_up(struct btd_adapter *adapter, int dd)
 		else
 			write_device_mode(&adapter->bdaddr, mode);
 
-		return adapter_up(adapter, dd);
+		return adapter_up(adapter);
 	} else if (!g_str_equal(mode, "connectable") &&
 			adapter->discov_timeout == 0) {
 		/* Set discoverable only if timeout is 0 */
@@ -2056,6 +2057,11 @@ static int adapter_up(struct btd_adapter *adapter, int dd)
 	}
 
 proceed:
+	dd = hci_open_dev(adapter->dev_id);
+
+	if (dd < 0)
+		return -EIO;
+
 	if (dev_down == FALSE)
 		hci_send_cmd(dd, OGF_HOST_CTL, OCF_WRITE_SCAN_ENABLE,
 				1, &scan_mode);
@@ -2084,6 +2090,8 @@ proceed:
 					ADAPTER_INTERFACE, "Powered",
 					DBUS_TYPE_BOOLEAN, &powered);
 
+	hci_close_dev(dd);
+
 	return 0;
 }
 
@@ -2197,10 +2205,10 @@ setup:
 	adapter->state &= ~STD_INQUIRY;
 
 	adapter_setup(adapter, dd);
-	err = adapter_up(adapter, dd);
-
 	hci_close_dev(dd);
 
+	err = adapter_up(adapter);
+
 	info("Adapter %s has been enabled", adapter->path);
 
 	return err;
-- 
1.5.6.3
