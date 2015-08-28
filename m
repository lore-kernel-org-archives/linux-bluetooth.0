Return-Path: <cyrus@holtmann.org>
From: Will Wang <wiwang@mozilla.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, Will Wang <wiwang@mozilla.com>
Subject: [PATCH v2 1/3] android/hal-ipc-api: Fix missing HFP WBS callback
Date: Fri, 28 Aug 2015 18:40:28 +0800
Message-Id: <1440758430-24935-2-git-send-email-wiwang@mozilla.com>
In-Reply-To: <1440758430-24935-1-git-send-email-wiwang@mozilla.com>
References: <1440758430-24935-1-git-send-email-wiwang@mozilla.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add definition of HFP WBS Command notification
---
 android/hal-ipc-api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 503b47a..e3b7798 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1068,6 +1068,14 @@ Notifications:
 
 		Notification parameters: Remote address (6 octets)
 
+	Opcode 0x91 - WBS Command notification
+
+		Notification parameters: WBS types (1 octet)
+		                         Remote address (6 octets)
+
+		Valid WBS types: 0x00 = None
+		                 0x01 = No
+		                 0x02 = Yes
 
 Bluetooth Advanced Audio HAL (ID 6)
 Bluetooth Advanced Audio Sink HAL (ID 13)
-- 
1.9.1

