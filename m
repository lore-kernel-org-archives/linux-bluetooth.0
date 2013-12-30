Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 4/7] android/hal-bluetooth: Add debug print to config_hci_snoop_log
Date: Mon, 30 Dec 2013 23:43:38 +0100
Message-Id: <1388443421-6295-4-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1388443421-6295-1-git-send-email-szymon.janc@gmail.com>
References: <1388443421-6295-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Improves debugs and make it consistent with other methods.
---
 android/hal-bluetooth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index a95c4ea..7accdcc 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -829,6 +829,8 @@ static int le_test_mode(uint16_t opcode, uint8_t *buf, uint8_t len)
 #if PLATFORM_SDK_VERSION > 18
 static int config_hci_snoop_log(uint8_t enable)
 {
+	DBG("enable %u", enable);
+
 	if (enable && property_set("ctl.start", SNOOP_SERVICE_NAME) < 0) {
 		error("Failed to start service %s", SNOOP_SERVICE_NAME);
 		return BT_STATUS_FAIL;
-- 
1.8.5.2

