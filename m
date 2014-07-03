Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2] android/hal-health: Fix do not modify fd flags in non connected state
Date: Thu,  3 Jul 2014 16:29:21 +0300
Message-Id: <1404394161-31721-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only on BTHL_CONN_STATE_CONNECTED state valid fd will be passed. Other states
fd value is -1. Just call channel status call back.
---
 android/hal-health.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/hal-health.c b/android/hal-health.c
index 1ed9fb1..01bc432 100644
--- a/android/hal-health.c
+++ b/android/hal-health.c
@@ -49,6 +49,9 @@ static void handle_channel_state(void *buf, uint16_t len, int fd)
 	struct hal_ev_health_channel_state *ev = buf;
 	int flags;
 
+	if (fd < 0)
+		goto end;
+
 	flags = fcntl(fd, F_GETFL, 0);
 	if (flags < 0) {
 		error("health: fcntl GETFL error: %s", strerror(errno));
@@ -61,6 +64,7 @@ static void handle_channel_state(void *buf, uint16_t len, int fd)
 		return;
 	}
 
+end:
 	if (cbacks->channel_state_cb)
 		cbacks->channel_state_cb(ev->app_id, (bt_bdaddr_t *) ev->bdaddr,
 						ev->mdep_index, ev->channel_id,
-- 
1.9.1

