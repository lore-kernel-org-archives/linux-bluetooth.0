Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 04/15] android/gatt: Use cached primary services if possible
Date: Tue, 8 Apr 2014 11:22:21 +0200
Message-ID: <1396948952-2035-5-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index f4cf569..eb99d54 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1148,6 +1148,14 @@ static void handle_client_search_service(const void *buf, uint16_t len)
 
 	/*TODO:  Handle filter uuid */
 
+	/* Use cache if possible */
+	if (!queue_isempty(dev->services)) {
+		status = HAL_STATUS_SUCCESS;
+		send_client_all_primary(GATT_SUCCESS, dev->services,
+								dev->conn_id);
+		goto reply;
+	}
+
 	if (!gatt_discover_primary(dev->attrib, NULL, primary_cb, dev)) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
-- 
1.8.4

