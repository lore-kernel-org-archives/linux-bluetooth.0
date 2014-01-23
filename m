Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/3] android/pan: Fix control state change callback parameters order
Date: Thu, 23 Jan 2014 15:39:25 +0200
Message-Id: <1390484367-6332-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Callback declared in bt_pan.h is
'typedef void (*btpan_control_state_callback)
(btpan_control_state_t state, bt_status_t error, int local_role,
const char* ifname);

But PanService.Java defined it wrong way.
private void onControlStateChanged(int local_role, int state,
int error, String ifname).
First and third parameters are misplaced, so sending data according
to PanService.Java, discard this fix if issue fixed in PanService.Java.
---
 android/hal-pan.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/android/hal-pan.c b/android/hal-pan.c
index 8c0f8d8..a596ffd 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -45,9 +45,18 @@ static void handle_ctrl_state(void *buf, uint16_t len)
 {
 	struct hal_ev_pan_ctrl_state *ev = buf;
 
+	/* FIXME: Callback declared in bt_pan.h is 'typedef void
+	 * (*btpan_control_state_callback)(btpan_control_state_t state,
+	 * bt_status_t error, int local_role, const char* ifname);
+	 * But PanService.Java defined it wrong way.
+	 * private void onControlStateChanged(int local_role, int state,
+	 * int error, String ifname).
+	 * First and third parameters are misplaced, so sending data according
+	 * to PanService.Java, fix this if issue fixed in PanService.Java.
+	 */
 	if (cbs->control_state_cb)
-		cbs->control_state_cb(ev->state, ev->status,
-					ev->local_role, (char *)ev->name);
+		cbs->control_state_cb(ev->local_role, ev->state, ev->status,
+							(char *)ev->name);
 }
 
 /* handlers will be called from notification thread context,
-- 
1.8.3.2

