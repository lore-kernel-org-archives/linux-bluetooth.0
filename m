Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] tools: Fix using uninitialized value
Date: Tue, 25 Feb 2014 12:19:17 +0200
Message-Id: <1393323557-28101-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes warning:
tools/ibeacon.c:150:14: warning: The left expression of the compound
assignment is an uninitialized value. The computed value will also be
garbage
        cmd.data[2] |= 0x02;            /* LE General Discoverable Mode
*/
        ~~~~~~~~~~~ ^
1 warning generated.
---
 tools/ibeacon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/ibeacon.c b/tools/ibeacon.c
index 458f9e7..cd0ef65 100644
--- a/tools/ibeacon.c
+++ b/tools/ibeacon.c
@@ -145,6 +145,8 @@ static void adv_tx_power_callback(const void *data, uint8_t size,
 		return;
 	}
 
+	memset(&cmd, 0, sizeof(cmd));
+
 	cmd.data[0] = 0x02;		/* Field length */
 	cmd.data[1] = 0x01;		/* Flags */
 	cmd.data[2] |= 0x02;		/* LE General Discoverable Mode */
-- 
1.8.3.2

