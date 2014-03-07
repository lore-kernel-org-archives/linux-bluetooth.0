Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] android: Support LE discovery if adapter supports LE
Date: Fri, 7 Mar 2014 11:28:30 +0100
Message-ID: <1394188110-16336-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394188110-16336-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394188110-16336-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 6d08a50..c6e40ca 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2414,6 +2414,9 @@ static bool start_discovery(void)
 	else
 		cp.type = 0;
 
+	if (adapter.current_settings & MGMT_SETTING_LE)
+		cp.type |= (1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM);
+
 	DBG("type=0x%x", cp.type);
 
 	if (mgmt_send(mgmt_if, MGMT_OP_START_DISCOVERY, adapter.index,
@@ -2433,6 +2436,9 @@ static bool stop_discovery(void)
 	else
 		cp.type = 0;
 
+	if (adapter.current_settings & MGMT_SETTING_LE)
+		cp.type |= (1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM);
+
 	DBG("type=0x%x", cp.type);
 
 	if (mgmt_send(mgmt_if, MGMT_OP_STOP_DISCOVERY, adapter.index,
-- 
1.8.4

