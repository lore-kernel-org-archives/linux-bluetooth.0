Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] SAP: Fix not unregistering dummy interface on exit
Date: Thu,  3 May 2012 17:41:23 +0300
Message-Id: <1336056083-21126-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Dummy interface is registered on plugin init and is never unregistered
---
 sap/sap-dummy.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index acdec77..3060dde 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -340,6 +340,8 @@ int sap_init(void)
 
 void sap_exit(void)
 {
+	g_dbus_unregister_interface(connection, SAP_DUMMY_PATH, SAP_DUMMY_IFACE);
+
 	dbus_connection_unref(connection);
 	connection = NULL;
 }
-- 
1.7.7.6

