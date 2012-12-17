Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/11] mgmt: Remove not needed power state change in read_info_complete
Date: Mon, 17 Dec 2012 15:44:57 +0100
Message-ID: <1355755498-2700-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
References: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial power state is no longer set up by bluetoothd.
---
 src/mgmt.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/src/mgmt.c b/src/mgmt.c
index 3c7e014..7e3f670 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1160,7 +1160,7 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 	struct controller_info *info;
 	struct btd_adapter *adapter;
 	const char *name;
-	uint8_t mode, major, minor;
+	uint8_t major, minor;
 	char addr[18];
 
 	if (len < sizeof(*rp)) {
@@ -1213,18 +1213,9 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 	btd_adapter_get_major_minor(adapter, &major, &minor);
 	mgmt_set_dev_class(index, major, minor);
 
-	btd_adapter_get_mode(adapter, &mode);
-	if (mode == MODE_OFF && mgmt_powered(info->current_settings)) {
-		mgmt_set_powered(index, FALSE);
-		return;
-	}
-
-	if (mode != MODE_OFF) {
-		if (mgmt_powered(info->current_settings)) {
-			get_connections(sk, index);
-			btd_adapter_start(adapter);
-		} else
-			mgmt_set_powered(index, TRUE);
+	if (mgmt_powered(info->current_settings)) {
+		get_connections(sk, index);
+		btd_adapter_start(adapter);
 	}
 
 	btd_adapter_unref(adapter);
-- 
1.8.0

