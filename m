Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/6] android/hal: Verify if command response service ID match
Date: Wed, 23 Oct 2013 15:46:25 +0200
Message-ID: <1382535986-30684-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382535986-30684-1-git-send-email-szymon.janc@tieto.com>
References: <1382535986-30684-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Received response service ID should match command service ID in
command, abort if it doesn't.
---
 android/hal-ipc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 97a3d29..8f13e88 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -335,6 +335,12 @@ int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
 		exit(EXIT_FAILURE);
 	}
 
+	if (hal_msg.service_id != service_id) {
+		error("Invalid service id (%u vs %u), aborting",
+					hal_msg.service_id, service_id);
+		exit(EXIT_FAILURE);
+	}
+
 	if (ret != (ssize_t) (sizeof(hal_msg) + hal_msg.len)) {
 		error("Malformed response received(%zd bytes), aborting", ret);
 		exit(EXIT_FAILURE);
-- 
1.8.4

