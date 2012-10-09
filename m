Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] adapter: Move pairable read to load_config()
Date: Tue,  9 Oct 2012 17:58:34 +0200
Message-Id: <1349798318-12689-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1349798318-12689-1-git-send-email-frederic.danis@linux.intel.com>
References: <1349798318-12689-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f66d2ab..3dc91df 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2693,6 +2693,10 @@ static void load_config(struct btd_adapter *adapter)
 		uint32_t class = htobl(main_opts.class);
 		memcpy(adapter->config.class, &class, 3);
 	}
+
+	/* Get pairable mode */
+	if (read_device_pairable(&adapter->bdaddr, &adapter->pairable) < 0)
+		adapter->pairable = TRUE;
 }
 
 gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
@@ -2720,10 +2724,6 @@ gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
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

