Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/15] android: Add missing SSP Variant definitions to IPC document
Date: Fri, 25 Oct 2013 10:56:13 +0200
Message-ID: <1382691378-31940-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
References: <1382691378-31940-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those are used to specify SSP association model.
---
 android/hal-ipc-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index a5437c1..0c2fd25 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -281,6 +281,11 @@ Commands and responses:
 		                    Passkey (4 octets)
 		Response parameters: <none>
 
+		Valid SSP variant values: 0x00 = Passkey Confirmation
+		                          0x01 = Passkey Entry
+		                          0x02 = Consent (for Just Works)
+		                          0x03 = Passkey Notification
+
 		In case of an error, the error response will be returned.
 
 	Opcode 0x12 - DUT Mode Configure command/response
-- 
1.8.4.1

