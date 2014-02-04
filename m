Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/11] android/unit: Add support for variable length data
Date: Tue,  4 Feb 2014 15:39:03 +0100
Message-Id: <1391524749-2518-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391524749-2518-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds sending messages larger than just hal_hdr, and fixes
response verification which worked only for empty messages but was
failing when sending something more than just header.
---
 android/test-ipc.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/android/test-ipc.c b/android/test-ipc.c
index cb6f518..a2d3085 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -44,7 +44,7 @@
 
 struct test_data {
 	uint32_t expected_signal;
-	const struct hal_hdr *cmd;
+	const void *cmd;
 	uint16_t cmd_size;
 	uint8_t service;
 	const struct ipc_handler *handlers;
@@ -79,9 +79,16 @@ static gboolean cmd_watch(GIOChannel *io, GIOCondition cond,
 {
 	struct context *context = user_data;
 	const struct test_data *test_data = context->data;
+	const struct hal_hdr *sent_msg = test_data->cmd;
 	uint8_t buf[128];
 	int sk;
 
+	struct hal_hdr success_resp = {
+		.service_id = sent_msg->service_id,
+		.opcode = sent_msg->opcode,
+		.len = 0,
+	};
+
 	g_assert(test_data->expected_signal == 0);
 
 	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
@@ -91,8 +98,8 @@ static gboolean cmd_watch(GIOChannel *io, GIOCondition cond,
 
 	sk = g_io_channel_unix_get_fd(io);
 
-	g_assert(read(sk, buf, sizeof(buf)) == test_data->cmd_size);
-	g_assert(!memcmp(test_data->cmd, buf, test_data->cmd_size));
+	g_assert(read(sk, buf, sizeof(buf)) == sizeof(struct hal_hdr));
+	g_assert(!memcmp(&success_resp, buf, sizeof(struct hal_hdr)));
 
 	context_quit(context);
 
-- 
1.8.5.2

