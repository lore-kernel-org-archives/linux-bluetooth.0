Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 07/16] adapter: Read discoverable timeout in storage at init
Date: Wed, 24 Oct 2012 16:34:09 +0200
Message-Id: <1351089258-25179-8-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
References: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 918991c..a91e9bb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2097,16 +2097,6 @@ static void load_connections(struct btd_adapter *adapter)
 	g_slist_free_full(conns, g_free);
 }
 
-static int get_discoverable_timeout(const char *src)
-{
-	int timeout;
-
-	if (read_discoverable_timeout(src, &timeout) == 0)
-		return timeout;
-
-	return main_opts.discovto;
-}
-
 static void set_auto_connect(gpointer data, gpointer user_data)
 {
 	struct btd_device *device = data;
@@ -2151,7 +2141,7 @@ void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
 		*on_mode = get_mode(&adapter->bdaddr, "on");
 
 	if (discoverable_timeout)
-		*discoverable_timeout = get_discoverable_timeout(address);
+		*discoverable_timeout = adapter->discov_timeout;
 
 	if (pairable)
 		*pairable = adapter->pairable;
@@ -2232,7 +2222,6 @@ void btd_adapter_start(struct btd_adapter *adapter)
 
 	adapter->off_requested = FALSE;
 	adapter->up = TRUE;
-	adapter->discov_timeout = get_discoverable_timeout(address);
 	adapter->off_timer = 0;
 
 	if (adapter->scan_mode & SCAN_INQUIRY)
@@ -2502,6 +2491,12 @@ static void load_config(struct btd_adapter *adapter)
 		adapter->pairable_timeout = main_opts.pairto;
 	else
 		adapter->pairable_timeout = timeout;
+
+	/* Get discoverable timeout */
+	if (read_discoverable_timeout(address, &timeout) < 0)
+		adapter->discov_timeout = main_opts.discovto;
+	else
+		adapter->discov_timeout = timeout;
 }
 
 gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
-- 
1.7.9.5

