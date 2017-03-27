Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: hyuk0512@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Lee Hyuk <hyuk0512.lee@samsung.com>
Subject: [PATCH BlueZ] src/adapter: Add the NULL check for response
Date: Mon, 27 Mar 2017 10:18:27 +0900
Message-id: <1490577507-28351-2-git-send-email-hyuk0512@gmail.com>
In-reply-to: <1490577507-28351-1-git-send-email-hyuk0512@gmail.com>
References: <1490577507-28351-1-git-send-email-hyuk0512@gmail.com>
 <CGME20170327011834epcas1p33f7e12ea5b0032ded858aa6f611aa016@epcas1p3.samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lee Hyuk <hyuk0512.lee@samsung.com>

The response can be NULL pointer. It should be checked.
---
 src/adapter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 3dac7d6..472b817 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1227,6 +1227,9 @@ static void passive_scanning_complete(uint8_t status, uint16_t length,
 	struct btd_adapter *adapter = user_data;
 	const struct mgmt_cp_start_discovery *rp = param;
 
+	if (!rp)
+		return;
+
 	DBG("status 0x%02x", status);
 
 	if (length < sizeof(*rp)) {
-- 
1.9.1

