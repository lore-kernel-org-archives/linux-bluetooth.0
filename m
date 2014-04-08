Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 08/15] android/gatt: Add msg size check for get included service
Date: Tue, 8 Apr 2014 11:22:25 +0200
Message-ID: <1396948952-2035-9-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1396948952-2035-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index 6ac930d..b95962d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1272,6 +1272,13 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 
 	DBG("");
 
+	if (len != sizeof(*cmd) + (cmd->number * sizeof(cmd->srvc_id[0]))) {
+		error("Invalid get incl services size (%u bytes), terminating",
+									len);
+		raise(SIGTERM);
+		return;
+	}
+
 	device = find_device_by_conn_id(cmd->conn_id);
 	if (!device) {
 		status = HAL_STATUS_FAILED;
-- 
1.8.4

