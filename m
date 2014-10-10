Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 09/14] tools/btgatt-client: Print type of service
Date: Fri, 10 Oct 2014 11:15:43 +0200
Message-Id: <1412932548-28363-10-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1412932548-28363-1-git-send-email-marcin.kraglak@tieto.com>
References: <1412932548-28363-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btgatt-client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index d900e08..5c692ff 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -182,8 +182,9 @@ static void print_service(const bt_gatt_service_t *service)
 		return;
 	}
 
-	printf(COLOR_RED "service" COLOR_OFF " - start: 0x%04x, "
+	printf(COLOR_RED "service %s" COLOR_OFF " - start: 0x%04x, "
 				"end: 0x%04x, uuid: ",
+				service->primary ? "primary" : "second.",
 				service->start_handle, service->end_handle);
 	print_uuid(service->uuid);
 
-- 
1.9.3

