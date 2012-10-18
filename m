Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 06/15] adapter: Read pairable timeout in storage at init
Date: Thu, 18 Oct 2012 11:00:49 +0200
Message-Id: <1350550858-12239-7-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1350550858-12239-1-git-send-email-frederic.danis@linux.intel.com>
References: <1350550858-12239-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 74c36ec..6d2aadc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2117,16 +2117,6 @@ static int get_discoverable_timeout(const char *src)
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
@@ -2253,7 +2243,6 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	adapter->off_requested = FALSE;
 	adapter->up = TRUE;
 	adapter->discov_timeout = get_discoverable_timeout(address);
-	adapter->pairable_timeout = get_pairable_timeout(address);
 	adapter->off_timer = 0;
 
 	if (adapter->scan_mode & SCAN_INQUIRY)
@@ -2502,6 +2491,10 @@ static void load_config(struct btd_adapter *adapter)
 {
 	char name[MAX_NAME_LENGTH + 1];
 	uint8_t class[3];
+	char address[18];
+	int timeout;
+
+	ba2str(&adapter->bdaddr, address);
 
 	/* Get name */
 	if (read_local_name(&adapter->bdaddr, name) < 0)
@@ -2519,6 +2512,12 @@ static void load_config(struct btd_adapter *adapter)
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

