Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/3] emulator/bthost: Move smp_start to bthost_create
Date: Mon,  3 Nov 2014 17:20:55 +0100
Message-Id: <1415031656-3360-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1415031656-3360-1-git-send-email-szymon.janc@tieto.com>
References: <1415031656-3360-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This creates smp while creating bthost allowing for early bailout if
kernel doesn't support crypto. Fix crash if smp_start failed due to
SMP code always assuming valid pointer.
---
 emulator/bthost.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index a123228..104916b 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -223,6 +223,12 @@ struct bthost *bthost_create(void)
 	if (!bthost)
 		return NULL;
 
+	bthost->smp_data = smp_start(bthost);
+	if (!bthost->smp_data) {
+		free(bthost);
+		return NULL;
+	}
+
 	/* Set defaults */
 	bthost->io_capability = 0x03;
 
@@ -436,6 +442,8 @@ void bthost_destroy(struct bthost *bthost)
 	if (bthost->rfcomm_conn_data)
 		free(bthost->rfcomm_conn_data);
 
+	smp_stop(bthost->smp_data);
+
 	free(bthost);
 }
 
@@ -2268,8 +2276,6 @@ void bthost_start(struct bthost *bthost)
 	if (!bthost)
 		return;
 
-	bthost->smp_data = smp_start(bthost);
-
 	bthost->ncmd = 1;
 
 	send_command(bthost, BT_HCI_CMD_RESET, NULL, 0);
@@ -2383,8 +2389,4 @@ void bthost_send_rfcomm_data(struct bthost *bthost, uint16_t handle,
 
 void bthost_stop(struct bthost *bthost)
 {
-	if (bthost->smp_data) {
-		smp_stop(bthost->smp_data);
-		bthost->smp_data = NULL;
-	}
 }
-- 
1.9.1

