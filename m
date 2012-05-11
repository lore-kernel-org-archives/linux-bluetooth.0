Return-Path: <cyrus@holtmann.org>
From: Paulo Alcantara <paulo.alcantara@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Alcantara <paulo.alcantara@openbossa.org>
Subject: [PATCH BlueZ v2] core: Remove unused variable
Date: Fri, 11 May 2012 12:45:35 -0300
Message-Id: <1336751135-21337-1-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"srcaddr" variable is not used for anything else in
btd_event_remote_name() function. So, remove it for now.
---
 src/event.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/src/event.c b/src/event.c
index 514744b..8ecb942 100644
--- a/src/event.c
+++ b/src/event.c
@@ -318,7 +318,6 @@ void btd_event_remote_class(bdaddr_t *local, bdaddr_t *peer, uint32_t class)
 void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
 {
 	struct btd_adapter *adapter;
-	char srcaddr[18];
 	struct btd_device *device;
 	struct remote_dev_info *dev_info;
 
@@ -339,8 +338,6 @@ void btd_event_remote_name(bdaddr_t *local, bdaddr_t *peer, char *name)
 	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
 		return;
 
-	ba2str(local, srcaddr);
-
 	dev_info = adapter_search_found_devices(adapter, peer);
 	if (dev_info) {
 		g_free(dev_info->name);
-- 
1.7.5.4

