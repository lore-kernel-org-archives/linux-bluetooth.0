Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 1/7] shared/gatt-client: Fix bug in service changed queue.
Date: Sun, 26 Oct 2014 14:12:41 -0700
Message-Id: <1414357967-9371-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1414357967-9371-1-git-send-email-armansito@chromium.org>
References: <1414357967-9371-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a bug where the handle range for queued service changed
events weren't getting stored. This caused service discovery to be
initiated for the 0x0000-0x0000 range, which caused an error response.
---
 src/shared/gatt-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 57d3e1f..faae71c 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1095,6 +1095,9 @@ static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
 	if (!op)
 		return;
 
+	op->start_handle = start;
+	op->end_handle = end;
+
 	queue_push_tail(client->svc_chngd_queue, op);
 }
 
-- 
2.1.0.rc2.206.gedb03e5

