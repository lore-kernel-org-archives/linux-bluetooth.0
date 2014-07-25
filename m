Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/5] android/tester-ng: Fix not initializing step
Date: Fri, 25 Jul 2014 12:45:04 +0200
Message-Id: <1406285106-14588-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406285106-14588-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406285106-14588-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes the following vagrind report:

==12708== 4 errors in context 1 of 1:
==12708== Conditional jump or move depends on uninitialised value(s)
==12708==    at 0x40E359: verify_step (tester-main.c:416)
==12708==    by 0x40E5FD: verify_action (tester-main.c:540)
==12708==    by 0x5083CE4: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
==12708==    by 0x5084047: ??? (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
==12708==    by 0x5084309: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.4000.0)
==12708==    by 0x40D51C: tester_run (tester.c:812)
==12708==    by 0x40251E: main (tester-main.c:1496)
---
 android/tester-socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/tester-socket.c b/android/tester-socket.c
index bd067ea..f462bb0 100644
--- a/android/tester-socket.c
+++ b/android/tester-socket.c
@@ -255,7 +255,7 @@ static void socket_verify_channel_action(void)
 	struct step *current_data_step = queue_peek_head(data->steps);
 	struct bt_action_data *action_data = current_data_step->set_data;
 	int channel, len;
-	struct step *step = g_new(struct step, 1);
+	struct step *step = g_new0(struct step, 1);
 
 	if (!*action_data->fd) {
 		tester_warn("Ups no action_data->fd");
-- 
1.9.1

