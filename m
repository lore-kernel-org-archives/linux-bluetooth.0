Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 05/16] adapter: Move pairable read to load_config()
Date: Wed, 24 Oct 2012 16:34:07 +0200
Message-Id: <1351089258-25179-6-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
References: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 310d1cf..d0a8404 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2499,6 +2499,10 @@ static void load_config(struct btd_adapter *adapter)
 
 	/* Set class */
 	adapter->dev_class = main_opts.class;
+
+	/* Get pairable mode */
+	if (read_device_pairable(&adapter->bdaddr, &adapter->pairable) < 0)
+		adapter->pairable = TRUE;
 }
 
 gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
@@ -2526,10 +2530,6 @@ gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
 	clear_blocked(adapter);
 	load_devices(adapter);
 
-	/* Set pairable mode */
-	if (read_device_pairable(&adapter->bdaddr, &adapter->pairable) < 0)
-		adapter->pairable = TRUE;
-
 	/* retrieve the active connections: address the scenario where
 	 * the are active connections before the daemon've started */
 	load_connections(adapter);
-- 
1.7.9.5

