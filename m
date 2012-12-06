Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] adapter: Fix unplugging adapter bug
Date: Thu,  6 Dec 2012 20:41:11 -0300
Message-Id: <1354837273-31712-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If we unplug an adapter in powered on state, once it is plugged
again, it doesn't go to powered on state as expected. This bug
happens because Powered info is stored when the adapter is
unplugged from the system.

This patch fixes this bug by only storing adapter info if mode
changing was requested by user application via D-Bus interface.
This patch basically reverts the changes in commit
985d8ac397a7c332c1badcb95430a167ec93e9e7 where the bug was
introduced.
---
 src/adapter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 0a0e6f0..25501c4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2230,8 +2230,6 @@ static void set_mode_complete(struct btd_adapter *adapter)
 	struct session_req *pending;
 	int err;
 
-	store_adapter_info(adapter);
-
 	DBG("%s", mode2str(adapter->mode));
 
 	if (adapter->mode == MODE_OFF) {
@@ -2271,6 +2269,8 @@ static void set_mode_complete(struct btd_adapter *adapter)
 	if (err != 0)
 		error("unable to set mode: %s", mode2str(pending->mode));
 
+	store_adapter_info(adapter);
+
 	session_unref(pending);
 }
 
-- 
1.8.0.1

