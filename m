Return-Path: <cyrus@holtmann.org>
From: Arkadiusz Lichwa <arkadiusz.lichwa@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] emulator: Swap max and min interval
Date: Wed, 12 Aug 2015 16:40:08 +0200
Message-Id: <1439390408-537-1-git-send-email-arkadiusz.lichwa@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes btdev controller bits when assigning actual parameters,
max and min interval, in LE Meta event for LE Connection Update to be sent 
to host.
---
 emulator/btdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index cd211ef..57e51a0 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -3322,8 +3322,8 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 			return;
 		lecu = data;
 		le_conn_update(btdev, le16_to_cpu(lecu->handle),
-				le16_to_cpu(lecu->min_interval),
 				le16_to_cpu(lecu->max_interval),
+				le16_to_cpu(lecu->min_interval),
 				le16_to_cpu(lecu->latency),
 				le16_to_cpu(lecu->supv_timeout),
 				le16_to_cpu(lecu->min_length),
-- 
1.8.2.2

