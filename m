Return-Path: <cyrus@holtmann.org>
From: Alex Deymo <deymo@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	keybuk@chromium.org,
	Alex Deymo <deymo@chromium.org>
Subject: [PATCH v7 4/5] input: Fix memory leak for hidp_connadd_req.
Date: Tue, 16 Apr 2013 14:58:40 -0700
Message-Id: <1366149521-26908-5-git-send-email-deymo@chromium.org>
In-Reply-To: <1366149521-26908-1-git-send-email-deymo@chromium.org>
References: <1366149521-26908-1-git-send-email-deymo@chromium.org>
List-ID: <linux-bluetooth.vger.kernel.org>

If the struct input_device is destroyed while a hidp_connad_req
is pending, the input_device will be destroyed leaking the associated
memory.

==30790== 492 (168 direct, 324 indirect) bytes in 1 blocks are definitely lost in loss record 199 of 216
==30790==    at 0x4C29DB4: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==30790==    by 0x4E7FAE0: g_malloc0 (gmem.c:189)
==30790==    by 0x4378E4: hidp_add_connection (device.c:365)
==30790==    by 0x438055: input_device_connected (device.c:525)
==30790==    by 0x4380DA: interrupt_connect_cb (device.c:548)
==30790==    by 0x443508: connect_cb (btio.c:230)
==30790==    by 0x4E79D52: g_main_context_dispatch (gmain.c:2539)
==30790==    by 0x4E7A09F: g_main_context_iterate.isra.23 (gmain.c:3146)
==30790==    by 0x4E7A499: g_main_loop_run (gmain.c:3340)
==30790==    by 0x448CCC: main (main.c:583)
---
 profiles/input/device.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 13c74cb..6ffc199 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -121,6 +121,11 @@ static void input_device_free(struct input_device *idev)
 	if (idev->ctrl_io)
 		g_io_channel_unref(idev->ctrl_io);
 
+	if (idev->req) {
+		g_free(idev->req->rd_data);
+		g_free(idev->req);
+	}
+
 	g_free(idev->uuid);
 
 	g_free(idev);
-- 
1.8.1.3
