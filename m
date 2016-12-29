Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Juha Kuikka <juha.kuikka@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: juha.kuikka@synapse.com, juha.kuikka@gmail.com,
        frank.praznik@gmail.com, roderick.colenbrander@sony.com
Subject: [PATCH v2 4/4] Add new DS4 controller PID into special case handler
Date: Wed, 28 Dec 2016 16:32:43 -0800
Message-Id: <1482971563-15745-5-git-send-email-juha.kuikka@gmail.com>
In-Reply-To: <1482971563-15745-1-git-send-email-juha.kuikka@gmail.com>
References: <1482971563-15745-1-git-send-email-juha.kuikka@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is a special path for various game controllers where they connect
to the hid service before bluetoothd knows what they are.

This patch adds another PID for the Dualshock4 controller. This new PID
matches with the model number CUH-ZCT2U.
---
 profiles/input/server.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/profiles/input/server.c b/profiles/input/server.c
index eb3fcf8..3576f2b 100644
--- a/profiles/input/server.c
+++ b/profiles/input/server.c
@@ -135,8 +135,10 @@ static bool dev_is_sixaxis(const bdaddr_t *src, const bdaddr_t *dst)
 	if (vid == 0x054c && pid == 0x0268)
 		return true;
 
-	/* DualShock 4 */
-	if (vid == 0x054c && pid == 0x05c4)
+	/* DualShock 4 CUH-ZCT1U (PID 0x05c4)
+	 * DualShock 4 CUH-ZCT2U (PID 0x09cc) (slim/pro)
+	 */
+	if (vid == 0x054c && (pid == 0x05c4 || pid == 0x09cc))
 		return true;
 
 	/* Navigation Controller */
-- 
2.7.4

