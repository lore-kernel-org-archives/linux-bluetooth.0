Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v0 2/4] adapter: Remove dead code from
 adapter_emit_device_found()
Date: Fri, 14 Sep 2012 21:40:09 +0530
Message-id: <1347639011-22924-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1347639011-22924-1-git-send-email-s.syam@samsung.com>
References: <1347639011-22924-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 1c13b2d..facfa23 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2725,7 +2725,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 						struct remote_dev_info *dev)
 {
 	struct btd_device *device;
-	char peer_addr[18], local_addr[18];
+	char peer_addr[18];
 	const char *icon, *paddr = peer_addr;
 	dbus_bool_t paired = FALSE, trusted = FALSE;
 	dbus_int16_t rssi = dev->rssi;
@@ -2733,7 +2733,6 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	size_t uuid_count;
 
 	ba2str(&dev->bdaddr, peer_addr);
-	ba2str(&adapter->bdaddr, local_addr);
 
 	device = adapter_find_device(adapter, paddr);
 	if (device) {
-- 
1.7.4.1

