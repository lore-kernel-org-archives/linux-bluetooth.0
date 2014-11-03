Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/3] emulator/bthost: Remove empty bthost_stop function
Date: Mon,  3 Nov 2014 17:20:56 +0100
Message-Id: <1415031656-3360-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1415031656-3360-1-git-send-email-szymon.janc@tieto.com>
References: <1415031656-3360-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/bthost.c | 4 ----
 emulator/bthost.h | 1 -
 emulator/hciemu.c | 2 --
 3 files changed, 7 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 104916b..2022e6b 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -2386,7 +2386,3 @@ void bthost_send_rfcomm_data(struct bthost *bthost, uint16_t handle,
 
 	free(uih_frame);
 }
-
-void bthost_stop(struct bthost *bthost)
-{
-}
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 62d415c..c0fa410 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -123,7 +123,6 @@ void bthost_send_rfcomm_data(struct bthost *bthost, uint16_t handle,
 					uint16_t len);
 
 void bthost_start(struct bthost *bthost);
-void bthost_stop(struct bthost *bthost);
 
 /* LE SMP support */
 
diff --git a/emulator/hciemu.c b/emulator/hciemu.c
index fcaeb70..c5bfa77 100644
--- a/emulator/hciemu.c
+++ b/emulator/hciemu.c
@@ -376,8 +376,6 @@ void hciemu_unref(struct hciemu *hciemu)
 
 	queue_destroy(hciemu->post_command_hooks, destroy_command_hook);
 
-	bthost_stop(hciemu->host_stack);
-
 	g_source_remove(hciemu->host_source);
 	g_source_remove(hciemu->client_source);
 	g_source_remove(hciemu->master_source);
-- 
1.9.1

