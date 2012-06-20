Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] sdp: Prevent duplicate records registration
Date: Wed, 20 Jun 2012 15:18:51 +0200
Message-Id: <1340198331-20807-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check if a record with same UUID and protocol descriptor already exists
before adding new record to server
---
 src/sdpd-service.c |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index 39e05ab..a76f8b4 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -231,6 +231,46 @@ void register_device_id(void)
 	update_db_timestamp();
 }
 
+static int sdpd_check_duplicate(sdp_record_t *rec)
+{
+	sdp_list_t *protos, *p;
+	int port = -1, psm = -1;
+
+	if (sdp_get_access_protos(rec, &protos) == 0) {
+		psm = sdp_get_proto_port(protos, L2CAP_UUID);
+		port = sdp_get_proto_port(protos, RFCOMM_UUID);
+
+		sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
+		sdp_list_free(protos, NULL);
+	}
+
+	for (p = sdp_get_record_list(); p; p = p->next) {
+		sdp_record_t *tmp = p->data;
+		int tmp_port = -1, tmp_psm = -1;
+
+		if (sdp_uuid_cmp(&tmp->svclass, &rec->svclass) != 0)
+			continue;
+
+		if (sdp_get_access_protos(tmp, &protos) == 0) {
+			tmp_psm = sdp_get_proto_port(protos, L2CAP_UUID);
+			tmp_port = sdp_get_proto_port(protos, RFCOMM_UUID);
+
+			sdp_list_foreach(protos,
+					 (sdp_list_func_t) sdp_list_free, NULL);
+			sdp_list_free(protos, NULL);
+		}
+
+		if (psm != tmp_psm || port != tmp_port)
+			continue;
+
+		DBG("Record duplicate: handle 0x%05x already exists with "
+				"same uuid and protos", tmp->handle);
+		return 1;
+	}
+
+	return 0;
+}
+
 int add_record_to_server(const bdaddr_t *src, sdp_record_t *rec)
 {
 	sdp_data_t *data;
@@ -245,6 +285,9 @@ int add_record_to_server(const bdaddr_t *src, sdp_record_t *rec)
 			return -EEXIST;
 	}
 
+	if (sdpd_check_duplicate(rec))
+		return -EEXIST;
+
 	DBG("Adding record with handle 0x%05x", rec->handle);
 
 	sdp_record_add(src, rec);
-- 
1.7.9.5

