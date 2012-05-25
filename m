Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/10] sap-dummy: Fix DBus connection leak if interface registration failed
Date: Fri, 25 May 2012 16:21:01 +0200
Message-ID: <1337955662-19016-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
References: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If DBus interface registration failed dbus connection should be
unreferenced.
---
 sap/sap-dummy.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index fd185c9..7ea4e92 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -342,6 +342,8 @@ int sap_init(void)
 				NULL, NULL) == FALSE) {
 		error("sap-dummy interface %s init failed on path %s",
 					SAP_DUMMY_IFACE, SAP_DUMMY_PATH);
+		dbus_connection_unref(connection);
+		connection = NULL;
 		return -1;
 	}
 
-- 
on behalf of ST-Ericsson

