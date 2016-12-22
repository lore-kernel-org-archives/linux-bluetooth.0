Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@synapse.com>
To: linux-bluetooth@vger.kernel.org
Cc: Juha Kuikka <juha.kuikka@synapse.com>
Subject: [PATCH 1/3] Add new DS4 controller PID into special case handler
Date: Wed, 21 Dec 2016 21:20:52 -0800
Message-Id: <1482384054-59718-2-git-send-email-juha.kuikka@synapse.com>
In-Reply-To: <1482384054-59718-1-git-send-email-juha.kuikka@synapse.com>
References: <1482384054-59718-1-git-send-email-juha.kuikka@synapse.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is a special path for various game controllers where they connect
to the hid service before bluetoothd knows what they are.

This patch adds another PID for the Dualshock4 controller.
---
 profiles/input/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index eb3fcf8..61f084a 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -136,7 +136,7 @@ static bool dev_is_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
 		return true;
 
 	/* DualShock 4 */
-	if (vid == 0x054c && pid == 0x05c4)
+	if (vid == 0x054c && (pid == 0x05c4 || pid == 0x09cc))
 		return true;
 
 	/* Navigation Controller */
-- 
1.9.1

