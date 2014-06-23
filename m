Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] android/pics-hogp: Do not set Suspend feature
Date: Mon, 23 Jun 2014 15:46:17 +0300
Message-Id: <1403527577-16254-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403527577-16254-1-git-send-email-luiz.dentz@gmail.com>
References: <1403527577-16254-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This requires integration with Android power management so leave it out
for now.
---
 android/pics-hogp.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/pics-hogp.txt b/android/pics-hogp.txt
index 6544b54..aefdf2b 100644
--- a/android/pics-hogp.txt
+++ b/android/pics-hogp.txt
@@ -244,11 +244,11 @@ TSPC_HOGP_11_11a True		Report characteristic configuration with 0x0000
 
 TSPC_HOGP_11_12	True		Read HID Information characteristic
 					(M)
-TSPC_HOGP_11_13	True		Suspend State (O)
-TSPC_HOGP_11_14	True		Exit Suspend State (C.1)
-TSPC_HOGP_11_15	True		Write HID Control Point characteristic: Suspend
+TSPC_HOGP_11_13	False		Suspend State (O)
+TSPC_HOGP_11_14	False		Exit Suspend State (C.1)
+TSPC_HOGP_11_15	False		Write HID Control Point characteristic: Suspend
 					command (C.1)
-TSPC_HOGP_11_16	True		Write HID Control Point characteristic: Exit
+TSPC_HOGP_11_16	False		Write HID Control Point characteristic: Exit
 					Suspend command (C.1)
 TSPC_HOGP_11_17	True		Read Protocol Mode characteristic: Get Protocol
 					command (O)
-- 
1.9.3

