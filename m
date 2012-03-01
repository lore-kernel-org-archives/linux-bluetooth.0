Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2 v2] core: remove set_limited_discoverable from adapter_ops driver
Date: Thu,  1 Mar 2012 11:15:04 +0200
Message-Id: <1330593304-7309-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1330593304-7309-1-git-send-email-luiz.dentz@gmail.com>
References: <1330593304-7309-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Core should not longer need to take care of details of discoverable bits
---
v2: Merge changes in hciops and mgmtops

 plugins/hciops.c  |    1 -
 plugins/mgmtops.c |    7 -------
 src/adapter.c     |    8 --------
 src/adapter.h     |    1 -
 4 files changed, 0 insertions(+), 17 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 61fb718..c166027 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -3877,7 +3877,6 @@ static struct btd_adapter_ops hci_ops = {
 	.cleanup = hciops_cleanup,
 	.set_powered = hciops_set_powered,
 	.set_discoverable = hciops_set_discoverable,
-	.set_limited_discoverable = hciops_set_limited_discoverable,
 	.set_pairable = hciops_set_pairable,
 	.start_discovery = hciops_start_discovery,
 	.stop_discovery = hciops_stop_discovery,
diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 3cc2c90..07dc8ac 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1841,12 +1841,6 @@ static void mgmt_cleanup(void)
 	}
 }
 
-static int mgmt_set_limited_discoverable(int index, gboolean limited)
-{
-	DBG("index %d limited %d", index, limited);
-	return -ENOSYS;
-}
-
 static int mgmt_start_discovery(int index)
 {
 	char buf[MGMT_HDR_SIZE + sizeof(struct mgmt_cp_start_discovery)];
@@ -2392,7 +2386,6 @@ static struct btd_adapter_ops mgmt_ops = {
 	.set_powered = mgmt_set_powered,
 	.set_discoverable = mgmt_set_discoverable,
 	.set_pairable = mgmt_set_pairable,
-	.set_limited_discoverable = mgmt_set_limited_discoverable,
 	.start_discovery = mgmt_start_discovery,
 	.stop_discovery = mgmt_stop_discovery,
 	.set_name = mgmt_set_name,
diff --git a/src/adapter.c b/src/adapter.c
index 208f4c8..c5f4d0d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -206,14 +206,6 @@ static uint8_t get_mode(const bdaddr_t *bdaddr, const char *mode)
 		return MODE_UNKNOWN;
 }
 
-static void adapter_set_limited_discoverable(struct btd_adapter *adapter,
-							gboolean limited)
-{
-	DBG("%s", limited ? "TRUE" : "FALSE");
-
-	adapter_ops->set_limited_discoverable(adapter->dev_id, limited);
-}
-
 static struct session_req *session_ref(struct session_req *req)
 {
 	req->refcount++;
diff --git a/src/adapter.h b/src/adapter.h
index 611e86f..345e308 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -186,7 +186,6 @@ struct btd_adapter_ops {
 	int (*set_discoverable) (int index, gboolean discoverable,
 							uint16_t timeout);
 	int (*set_pairable) (int index, gboolean pairable);
-	int (*set_limited_discoverable) (int index, gboolean limited);
 	int (*start_discovery) (int index);
 	int (*stop_discovery) (int index);
 
-- 
1.7.7.6

