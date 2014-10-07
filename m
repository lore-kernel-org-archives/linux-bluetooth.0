Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] shared/gatt: Add Secondary services to service_list
Date: Tue,  7 Oct 2014 09:19:23 +0200
Message-Id: <1412666365-9562-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1412666365-9562-1-git-send-email-marcin.kraglak@tieto.com>
References: <1412666365-9562-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If included service was found and doesn't exist on service list,
create Secondary Service and insert it.
---
 src/shared/gatt-client.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 16b1630..54e6fec 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -471,6 +471,7 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 						&includes[i].start_handle,
 						&includes[i].end_handle,
 						includes[i].uuid)) {
+		struct service_list *service;
 		uuid_to_string(includes[i].uuid, uuid_str);
 		util_debug(client->debug_callback, client->debug_data,
 				"handle: 0x%04x, start: 0x%04x, end: 0x%04x,"
@@ -478,7 +479,56 @@ static void discover_incl_cb(bool success, uint8_t att_ecode,
 				includes[i].start_handle,
 				includes[i].end_handle, uuid_str);
 
-		/* TODO check if included service is on list */
+
+		/*
+		 * Check if included service was found previously in this
+		 * session
+		 */
+		for (service = op->result_head; service; service =
+								service->next) {
+			if (service->service.start_handle ==
+						includes[i].start_handle)
+				break;
+		}
+
+		/*
+		 * Check if included service was found in previous session
+		 */
+		if (!service) {
+			for (service = client->svc_head; service; service =
+								service->next) {
+				if (service->service.start_handle ==
+						includes[i].start_handle)
+					break;
+			}
+		}
+
+		if (!service) {
+			service = new0(struct service_list, 1);
+			if (!service) {
+				free(includes);
+				success = false;
+				goto done;
+			}
+
+			service->service.primary = false;
+			service->service.start_handle =
+						includes[i].start_handle;
+			service->service.end_handle = includes[i].end_handle;
+			memcpy(service->service.uuid, includes[i].uuid,
+								UUID_BYTES);
+
+			service_list_insert_services(&op->result_head,
+							&op->result_tail,
+							service, service);
+
+			/*
+			 * TODO: Newly created Secondary Service can contain
+			 * Included Services too. They should be discovered
+			 * before characteristic discovery.
+			 */
+		}
+
 		i++;
 	}
 
-- 
1.9.3

