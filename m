Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH v2] Adapter: Fix Discovering state while Powering Off
Date: Tue, 3 Apr 2012 17:23:59 +0530
Message-ID: <1333454039-6961-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the adater discovering state while powering off.
Without this fix, BlueZ sends incorrect discovering state to upper
layers while switching off.
---
 src/adapter.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index eb9745f..f630196 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2319,10 +2319,17 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 					ADAPTER_INTERFACE, "Pairable",
 					DBUS_TYPE_BOOLEAN, &prop_false);
 
-	if (adapter->discovering)
+	if (adapter->discovering) {
 		emit_property_changed(connection, adapter->path,
 					ADAPTER_INTERFACE, "Discovering",
 					DBUS_TYPE_BOOLEAN, &prop_false);
+		/*
+		 * Change the discovering state to FALSE, otherwise
+		 * inquiry fails to start if BT is switched off and then on
+		 * while inquiry is already active.
+		 */
+		adapter->discovering = FALSE;
+	}
 
 	emit_property_changed(connection, adapter->path, ADAPTER_INTERFACE,
 				"Powered", DBUS_TYPE_BOOLEAN, &prop_false);
-- 
1.7.0.4

