Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [RFC BlueZ 1/1] core: Fix adapter mode inconsistency
Date: Mon, 23 Apr 2012 10:34:35 +0200
Message-Id: <1335170075-12363-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1335170075-12363-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1335170075-12363-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The mode change in btd_adapter_start() doesn't check if the adapter is
discoverable, creating an inconsistency between the plugin and the core.

Using the management interface it is easy to reproduce the problem, by
starting BlueZ while the adapter is discoverable. After this, the state
cannot be changed.
---
 src/adapter.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 12b6aeb..a4180b1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2183,9 +2183,13 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	adapter->up = TRUE;
 	adapter->discov_timeout = get_discoverable_timeout(address);
 	adapter->pairable_timeout = get_pairable_timeout(address);
-	adapter->mode = MODE_CONNECTABLE;
 	adapter->off_timer = 0;
 
+	if (adapter->scan_mode & SCAN_INQUIRY)
+		adapter->mode = MODE_DISCOVERABLE;
+	else
+		adapter->mode = MODE_CONNECTABLE;
+
 	powered = TRUE;
 	emit_property_changed(connection, adapter->path,
 					ADAPTER_INTERFACE, "Powered",
-- 
1.7.7.6

