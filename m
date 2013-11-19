Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 1/4] android/hal-pan: Return error in case of unsupported PAN roles
Date: Tue, 19 Nov 2013 16:56:25 +0200
Message-Id: <1384872988-19914-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-pan.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/android/hal-pan.c b/android/hal-pan.c
index 2bc560e..a2e6060 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -77,6 +77,9 @@ static bt_status_t pan_enable(int local_role)
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
+	if (!(local_role == BTPAN_ROLE_PANU || local_role == BTPAN_ROLE_PANNAP))
+		return BT_STATUS_UNSUPPORTED;
+
 	cmd.local_role = local_role;
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_PAN, HAL_OP_PAN_ENABLE,
@@ -112,6 +115,20 @@ static bt_status_t pan_connect(const bt_bdaddr_t *bd_addr, int local_role,
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
 
+	switch (local_role) {
+	case BTPAN_ROLE_PANNAP:
+		if (remote_role != BTPAN_ROLE_PANU)
+			return BT_STATUS_UNSUPPORTED;
+		break;
+	case BTPAN_ROLE_PANU:
+		if (remote_role != BTPAN_ROLE_PANNAP &&
+						remote_role != BTPAN_ROLE_PANU)
+			return BT_STATUS_UNSUPPORTED;
+		break;
+	default:
+		return BT_STATUS_UNSUPPORTED;
+	}
+
 	memcpy(cmd.bdaddr, bd_addr, sizeof(cmd.bdaddr));
 	cmd.local_role = local_role;
 	cmd.remote_role = remote_role;
-- 
1.8.3.2

