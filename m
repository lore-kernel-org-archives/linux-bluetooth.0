Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 09/14] tools/btgatt-client: Print type of service
Date: Thu, 23 Oct 2014 12:15:32 +0200
Message-Id: <1414059337-12040-10-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1414059337-12040-1-git-send-email-marcin.kraglak@tieto.com>
References: <1414059337-12040-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btgatt-client.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index d900e08..d21bc34 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -183,8 +183,9 @@ static void print_service(const bt_gatt_service_t *service)
 	}
 
 	printf(COLOR_RED "service" COLOR_OFF " - start: 0x%04x, "
-				"end: 0x%04x, uuid: ",
-				service->start_handle, service->end_handle);
+				"end: 0x%04x, type: %s, uuid: ",
+				service->start_handle, service->end_handle,
+				service->primary ? "primary" : "secondary");
 	print_uuid(service->uuid);
 
 	while (bt_gatt_characteristic_iter_next(&iter, &chrc)) {
-- 
1.9.3

