Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH v3 3/5] android: Clear adapter uuids during initialization
Date: Tue, 12 Nov 2013 16:36:24 +0100
Message-ID: <1384270586-9853-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384270586-9853-1-git-send-email-szymon.janc@tieto.com>
References: <1384270586-9853-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

Clear adapter uuids during init. We have to do it before
other profiles will be able to register sdp records and add
their uuids.
---
 android/adapter.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 92949f9..a42cdcb 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -1208,6 +1208,17 @@ static uint8_t set_discoverable_timeout(uint8_t *timeout)
 
 	return HAL_STATUS_SUCCESS;
 }
+
+static void clear_uuids(void)
+{
+	struct mgmt_cp_remove_uuid cp;
+
+	memset(&cp, 0, sizeof(cp));
+
+	mgmt_send(adapter->mgmt, MGMT_OP_REMOVE_UUID, adapter->index,
+					sizeof(cp), &cp, NULL, NULL, NULL);
+}
+
 static void read_info_complete(uint8_t status, uint16_t length, const void *param,
 							void *user_data)
 {
@@ -1248,6 +1259,8 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 	/* TODO: Register all event notification handlers */
 	register_mgmt_handlers();
 
+	clear_uuids();
+
 	load_link_keys(NULL);
 
 	set_io_capability();
-- 
1.8.4.2

