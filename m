Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 7/8] android/gatt: Add IPC message verification for service_search
Date: Thu, 17 Apr 2014 01:10:32 +0200
Message-Id: <1397689833-17557-8-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index aa258f1..e339789 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1458,6 +1458,13 @@ static void handle_client_search_service(const void *buf, uint16_t len)
 
 	DBG("");
 
+	if (len != sizeof(*cmd) + (cmd->filtered ? 16 : 0)) {
+		error("Invalid search service size (%u bytes), terminating",
+									len);
+		raise(SIGTERM);
+		return;
+	}
+
 	dev = find_device_by_conn_id(cmd->conn_id);
 	if (!dev) {
 		error("gatt: dev with conn_id=%d not found", cmd->conn_id);
-- 
1.9.2

