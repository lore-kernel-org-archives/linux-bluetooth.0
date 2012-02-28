Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] mgmtops: Remove set_limited_discoverable callback
Date: Tue, 28 Feb 2012 13:23:26 +0200
Message-Id: <1330428206-8185-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1330428206-8185-1-git-send-email-luiz.dentz@gmail.com>
References: <1330428206-8185-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/mgmtops.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 9e8398d..4e0716c 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1838,12 +1838,6 @@ static void mgmt_cleanup(void)
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
@@ -2389,7 +2383,6 @@ static struct btd_adapter_ops mgmt_ops = {
 	.set_powered = mgmt_set_powered,
 	.set_discoverable = mgmt_set_discoverable,
 	.set_pairable = mgmt_set_pairable,
-	.set_limited_discoverable = mgmt_set_limited_discoverable,
 	.start_discovery = mgmt_start_discovery,
 	.stop_discovery = mgmt_stop_discovery,
 	.set_name = mgmt_set_name,
-- 
1.7.7.6

