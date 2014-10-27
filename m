Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 5/7] tools/btgatt-client: Print prompt on service changed.
Date: Mon, 27 Oct 2014 07:35:40 -0700
Message-Id: <1414420542-15336-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1414420542-15336-1-git-send-email-armansito@chromium.org>
References: <1414420542-15336-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The service changed handler now prints the command line prompt if the
changed service list empty.
---
 tools/btgatt-client.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index ea9acb7..5eedfd0 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -304,8 +304,11 @@ static void service_changed_cb(uint16_t start_handle, uint16_t end_handle,
 	printf("\nService Changed handled - start: 0x%04x end: 0x%04x\n",
 						start_handle, end_handle);
 
-	if (!bt_gatt_service_iter_next_by_handle(&iter, start_handle, &service))
+	if (!bt_gatt_service_iter_next_by_handle(&iter, start_handle,
+								&service)) {
+		print_prompt();
 		return;
+	}
 
 	print_service(service);
 
-- 
2.1.0.rc2.206.gedb03e5

