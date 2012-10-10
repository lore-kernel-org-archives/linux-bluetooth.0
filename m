Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/7] adapter: Read pairable timeout in storage at init
Date: Wed, 10 Oct 2012 10:58:37 +0200
Message-Id: <1349859520-8824-5-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1349859520-8824-1-git-send-email-frederic.danis@linux.intel.com>
References: <1349859520-8824-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 357b717..b869d81 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2278,16 +2278,6 @@ static int get_discoverable_timeout(const char *src)
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
@@ -2432,7 +2422,6 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	adapter->off_requested = FALSE;
 	adapter->up = TRUE;
 	adapter->discov_timeout = get_discoverable_timeout(address);
-	adapter->pairable_timeout = get_pairable_timeout(address);
 	adapter->off_timer = 0;
 
 	if (adapter->scan_mode & SCAN_INQUIRY)
@@ -2685,6 +2674,10 @@ void btd_adapter_unref(struct btd_adapter *adapter)
 static void load_config(struct btd_adapter *adapter)
 {
 	char name[MAX_NAME_LENGTH + 1];
+	char address[18];
+	int timeout;
+
+	ba2str(&adapter->bdaddr, address);
 
 	/* Get name */
 	if (read_local_name(&adapter->bdaddr, name) < 0)
@@ -2701,6 +2694,12 @@ static void load_config(struct btd_adapter *adapter)
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

