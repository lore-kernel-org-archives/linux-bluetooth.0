Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] adapter: Read pairable timeout in storage at init
Date: Tue,  9 Oct 2012 17:58:35 +0200
Message-Id: <1349798318-12689-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1349798318-12689-1-git-send-email-frederic.danis@linux.intel.com>
References: <1349798318-12689-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 3dc91df..ed9f848 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2276,16 +2276,6 @@ static int get_discoverable_timeout(const char *src)
 	return main_opts.discovto;
 }
 
-static int get_pairable_timeout(const char *src)
-{
-	int timeout;
-
-	if (read_pairable_timeout(src, &timeout) == 0)
-		return timeout;
-
-	return main_opts.pairto;
-}
-
 static void set_auto_connect(gpointer data, gpointer user_data)
 {
 	struct btd_device *device = data;
@@ -2429,7 +2419,6 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	adapter->off_requested = FALSE;
 	adapter->up = TRUE;
 	adapter->discov_timeout = get_discoverable_timeout(address);
-	adapter->pairable_timeout = get_pairable_timeout(address);
 	adapter->off_timer = 0;
 
 	if (adapter->scan_mode & SCAN_INQUIRY)
@@ -2681,6 +2670,10 @@ void btd_adapter_unref(struct btd_adapter *adapter)
 static void load_config(struct btd_adapter *adapter)
 {
 	char name[MAX_NAME_LENGTH + 1];
+	char address[18];
+	int timeout;
+
+	ba2str(&adapter->bdaddr, address);
 
 	/* Get name */
 	if (read_local_name(&adapter->bdaddr, name) < 0)
@@ -2697,6 +2690,12 @@ static void load_config(struct btd_adapter *adapter)
 	/* Get pairable mode */
 	if (read_device_pairable(&adapter->bdaddr, &adapter->pairable) < 0)
 		adapter->pairable = TRUE;
+
+	/* Get pairable timeout */
+	if (read_pairable_timeout(address, &timeout) < 0)
+		adapter->pairable_timeout = main_opts.pairto;
+	else
+		adapter->pairable_timeout = timeout;
 }
 
 gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
-- 
1.7.9.5

