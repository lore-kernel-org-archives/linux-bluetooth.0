Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 5/7] Modifying load_connections method.
Date: Tue, 12 May 2009 17:56:54 +0530
Message-Id: <1242131216-4081-5-git-send-email-alok.barsode@azingo.com>
In-Reply-To: <1242131216-4081-4-git-send-email-alok.barsode@azingo.com>
References: <1242131216-4081-1-git-send-email-alok.barsode@azingo.com>
 <1242131216-4081-2-git-send-email-alok.barsode@azingo.com>
 <1242131216-4081-3-git-send-email-alok.barsode@azingo.com>
 <1242131216-4081-4-git-send-email-alok.barsode@azingo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/adapter.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index cd18412..73e6d80 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1935,11 +1935,15 @@ static void load_drivers(struct btd_adapter *adapter)
 	}
 }
 
-static void load_connections(struct btd_adapter *adapter, int dd)
+static void load_connections(struct btd_adapter *adapter)
 {
 	struct hci_conn_list_req *cl = NULL;
 	struct hci_conn_info *ci;
-	int i;
+	int i, dd;
+
+	dd = hci_open_dev(adapter->dev_id);
+	if (dd < 0)
+		return;
 
 	cl = g_malloc0(10 * sizeof(*ci) + sizeof(*cl));
 
@@ -1949,6 +1953,7 @@ static void load_connections(struct btd_adapter *adapter, int dd)
 
 	if (ioctl(dd, HCIGETCONNLIST, cl) != 0) {
 		g_free(cl);
+		hci_close_dev(dd);
 		return;
 	}
 
@@ -1963,6 +1968,7 @@ static void load_connections(struct btd_adapter *adapter, int dd)
 	}
 
 	g_free(cl);
+	hci_close_dev(dd);
 }
 
 static int get_discoverable_timeout(const char *src)
@@ -1990,7 +1996,7 @@ static int adapter_up(struct btd_adapter *adapter)
 	char mode[14], srcaddr[18];
 	uint8_t scan_mode;
 	gboolean powered, dev_down = FALSE;
-	int dd, err;
+	int err;
 
 	ba2str(&adapter->bdaddr, srcaddr);
 
@@ -2055,19 +2061,14 @@ proceed:
 		load_drivers(adapter);
 		load_devices(adapter);
 
-		dd = hci_open_dev(adapter->dev_id);
-		if (dd < 0)
-			return -EIO;
-
 		/* retrieve the active connections: address the scenario where
 		 * the are active connections before the daemon've started */
-		load_connections(adapter, dd);
+		load_connections(adapter);
 
 		adapter->initialized = TRUE;
 
 		manager_add_adapter(adapter->path);
 
-		hci_close_dev(dd);
 	}
 
 	if (adapter->svc_cache)
-- 
1.5.6.3
