Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/7] adapter: Move pairable read to load_config()
Date: Wed, 10 Oct 2012 10:58:36 +0200
Message-Id: <1349859520-8824-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1349859520-8824-1-git-send-email-frederic.danis@linux.intel.com>
References: <1349859520-8824-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 93dc0fb..357b717 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2697,6 +2697,10 @@ static void load_config(struct btd_adapter *adapter)
 		uint32_t class = htobl(main_opts.class);
 		memcpy(adapter->config.class, &class, 3);
 	}
+
+	/* Get pairable mode */
+	if (read_device_pairable(&adapter->bdaddr, &adapter->pairable) < 0)
+		adapter->pairable = TRUE;
 }
 
 gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
@@ -2724,10 +2728,6 @@ gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
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

