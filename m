Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/gatt: Format string with address properly
Date: Thu, 10 Apr 2014 20:40:37 +0200
Message-Id: <1397155238-8578-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1397155238-8578-1-git-send-email-marcin.kraglak@tieto.com>
References: <1397155238-8578-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 857ffe0..b246137 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1150,12 +1150,14 @@ static void handle_client_disconnect(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_gatt_client_disconnect *cmd = buf;
 	struct gatt_device *dev;
+	bdaddr_t bdaddr;
 	uint8_t status;
 	char addr[18];
 
 	DBG("");
 
-	ba2str((bdaddr_t *)&cmd->bdaddr, addr);
+	android2bdaddr(cmd->bdaddr, &bdaddr);
+	ba2str(&bdaddr, addr);
 
 	dev = find_device_by_conn_id(cmd->conn_id);
 	if (!dev) {
-- 
1.8.3.1

