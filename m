Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ] adapter: Fix segfault when icon is uninitialized
Date: Mon,  2 Apr 2012 15:20:27 -0400
Message-Id: <1333394427-9803-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If device type is LE and GAP Appearance characteristic does not exist,
the icon will not be initialized.
---
 src/adapter.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f8f46f8..9ebfe66 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2664,7 +2664,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 {
 	struct btd_device *device;
 	char peer_addr[18], local_addr[18];
-	const char *icon, *paddr = peer_addr;
+	const char *icon = NULL, *paddr = peer_addr;
 	dbus_bool_t paired = FALSE, trusted = FALSE;
 	dbus_int16_t rssi = dev->rssi;
 	char *alias;
-- 
1.7.5.4

