Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/4] android: Rename send_adapter_name to send_adapter_address
Date: Mon, 28 Oct 2013 13:46:12 +0100
Message-ID: <1382964375-7589-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make function name match what it acctually does.
---
 android/adapter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 80a9e6d..f393c49 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -370,7 +370,7 @@ static bool set_discoverable(uint8_t mode, uint16_t timeout)
 	return false;
 }
 
-static void send_adapter_name(void)
+static void send_adapter_address(void)
 {
 	struct hal_ev_adapter_props_changed *ev;
 	int len;
@@ -398,7 +398,7 @@ static bool get_property(void *buf, uint16_t len)
 
 	switch (cmd->type) {
 	case HAL_PROP_ADAPTER_ADDR:
-		send_adapter_name();
+		send_adapter_address();
 		return true;
 	case HAL_PROP_ADAPTER_NAME:
 	case HAL_PROP_ADAPTER_UUIDS:
-- 
1.8.4.1

