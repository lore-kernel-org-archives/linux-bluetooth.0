Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Remove unused variable
Date: Wed,  4 May 2011 14:32:47 -0300
Message-Id: <1304530367-18791-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8dbd62c..426df15 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3255,8 +3255,6 @@ void adapter_add_connection(struct btd_adapter *adapter,
 void adapter_remove_connection(struct btd_adapter *adapter,
 						struct btd_device *device)
 {
-	bdaddr_t bdaddr;
-
 	DBG("");
 
 	if (!g_slist_find(adapter->connections, device)) {
@@ -3268,9 +3266,6 @@ void adapter_remove_connection(struct btd_adapter *adapter,
 
 	adapter->connections = g_slist_remove(adapter->connections, device);
 
-	/* clean pending HCI cmds */
-	device_get_address(device, &bdaddr);
-
 	if (device_is_authenticating(device))
 		device_cancel_authentication(device, TRUE);
 
-- 
1.7.5.rc3

