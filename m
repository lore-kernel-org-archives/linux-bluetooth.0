Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/10] android/hal-bluetooth: Handle dut mode receive event
Date: Tue, 19 Nov 2013 16:51:52 +0100
Message-Id: <1384876314-31347-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
References: <1384876314-31347-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Pass received data to callback if it is present.
---
 android/hal-bluetooth.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 18e805b..b8ffce6 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -300,9 +300,17 @@ static void handle_acl_state_changed(void *buf, uint16_t len)
 
 static void handle_dut_mode_receive(void *buf, uint16_t len)
 {
+	struct hal_ev_dut_mode_receive *ev = buf;
+
 	DBG("");
 
-	/* TODO */
+	if (len != sizeof(*ev) + ev->len) {
+		error("invalid dut mode receive event (%u), aborting", len);
+		exit(EXIT_FAILURE);
+	}
+
+	if (bt_hal_cbacks->dut_mode_recv_cb)
+		bt_hal_cbacks->dut_mode_recv_cb(ev->opcode, ev->data, ev->len);
 }
 
 /* handlers will be called from notification thread context,
-- 
1.8.4.3

