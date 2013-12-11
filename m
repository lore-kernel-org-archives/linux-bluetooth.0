Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 05/10] profiles/network: Move pan sdp record function bnep and make it global
Date: Wed, 11 Dec 2013 12:13:40 +0200
Message-Id: <1386756825-934-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1386756825-934-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Moving pan sdp record function bnep, it is required in android/pan.
Even though it is not exactly related to bnep, but bnep.h|c is dbus
free files and shared with android/*.
---
 profiles/network/bnep.c   | 129 ++++++++++++++++++++++++++++++++++++++++++++++
 profiles/network/bnep.h   |   2 +
 profiles/network/server.c | 128 +--------------------------------------------
 3 files changed, 132 insertions(+), 127 deletions(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 08037e6..bbccd87 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -39,6 +39,8 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/l2cap.h>
 #include <bluetooth/bnep.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
 
 #include <glib.h>
 
@@ -542,3 +544,130 @@ uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
 
 	return BNEP_SUCCESS;
 }
+
+sdp_record_t *pan_record(const char *name, uint16_t id, gboolean security)
+{
+	sdp_list_t *svclass, *pfseq, *apseq, *root, *aproto;
+	uuid_t root_uuid, pan, l2cap, bnep;
+	sdp_profile_desc_t profile[1];
+	sdp_list_t *proto[2];
+	sdp_data_t *v, *p;
+	uint16_t psm = BNEP_PSM, version = 0x0100;
+	uint16_t security_desc = (security ? 0x0001 : 0x0000);
+	uint16_t net_access_type = 0xfffe;
+	uint32_t max_net_access_rate = 0;
+	const char *desc = "Network service";
+	sdp_record_t *record;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	record->attrlist = NULL;
+	record->pattern = NULL;
+
+	switch (id) {
+	case BNEP_SVC_NAP:
+		sdp_uuid16_create(&pan, NAP_SVCLASS_ID);
+		svclass = sdp_list_append(NULL, &pan);
+		sdp_set_service_classes(record, svclass);
+
+		sdp_uuid16_create(&profile[0].uuid, NAP_PROFILE_ID);
+		profile[0].version = 0x0100;
+		pfseq = sdp_list_append(NULL, &profile[0]);
+		sdp_set_profile_descs(record, pfseq);
+
+		sdp_set_info_attr(record, name, NULL, desc);
+
+		sdp_attr_add_new(record, SDP_ATTR_NET_ACCESS_TYPE,
+					SDP_UINT16, &net_access_type);
+		sdp_attr_add_new(record, SDP_ATTR_MAX_NET_ACCESSRATE,
+					SDP_UINT32, &max_net_access_rate);
+		break;
+	case BNEP_SVC_GN:
+		sdp_uuid16_create(&pan, GN_SVCLASS_ID);
+		svclass = sdp_list_append(NULL, &pan);
+		sdp_set_service_classes(record, svclass);
+
+		sdp_uuid16_create(&profile[0].uuid, GN_PROFILE_ID);
+		profile[0].version = 0x0100;
+		pfseq = sdp_list_append(NULL, &profile[0]);
+		sdp_set_profile_descs(record, pfseq);
+
+		sdp_set_info_attr(record, name, NULL, desc);
+		break;
+	case BNEP_SVC_PANU:
+		sdp_uuid16_create(&pan, PANU_SVCLASS_ID);
+		svclass = sdp_list_append(NULL, &pan);
+		sdp_set_service_classes(record, svclass);
+
+		sdp_uuid16_create(&profile[0].uuid, PANU_PROFILE_ID);
+		profile[0].version = 0x0100;
+		pfseq = sdp_list_append(NULL, &profile[0]);
+		sdp_set_profile_descs(record, pfseq);
+
+		sdp_set_info_attr(record, name, NULL, desc);
+		break;
+	default:
+		sdp_record_free(record);
+		return NULL;
+	}
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(NULL, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+	proto[0] = sdp_list_append(NULL, &l2cap);
+	p = sdp_data_alloc(SDP_UINT16, &psm);
+	proto[0] = sdp_list_append(proto[0], p);
+	apseq    = sdp_list_append(NULL, proto[0]);
+
+	sdp_uuid16_create(&bnep, BNEP_UUID);
+	proto[1] = sdp_list_append(NULL, &bnep);
+	v = sdp_data_alloc(SDP_UINT16, &version);
+	proto[1] = sdp_list_append(proto[1], v);
+
+	/* Supported protocols */
+	{
+		uint16_t ptype[] = {
+			0x0800,  /* IPv4 */
+			0x0806,  /* ARP */
+		};
+		sdp_data_t *head, *pseq;
+		int p;
+
+		for (p = 0, head = NULL; p < 2; p++) {
+			sdp_data_t *data = sdp_data_alloc(SDP_UINT16,
+								&ptype[p]);
+			if (head)
+				sdp_seq_append(head, data);
+			else
+				head = data;
+		}
+		pseq = sdp_data_alloc(SDP_SEQ16, head);
+		proto[1] = sdp_list_append(proto[1], pseq);
+	}
+
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_add_lang_attr(record);
+
+	sdp_attr_add_new(record, SDP_ATTR_SECURITY_DESC,
+				SDP_UINT16, &security_desc);
+
+	sdp_data_free(p);
+	sdp_data_free(v);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(root, NULL);
+	sdp_list_free(aproto, NULL);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(svclass, NULL);
+	sdp_list_free(pfseq, NULL);
+
+	return record;
+}
diff --git a/profiles/network/bnep.h b/profiles/network/bnep.h
index dd22c40..4f1f812 100644
--- a/profiles/network/bnep.h
+++ b/profiles/network/bnep.h
@@ -44,3 +44,5 @@ ssize_t bnep_send_ctrl_rsp(int sk, uint8_t type, uint8_t ctrl, uint16_t resp);
 uint16_t bnep_setup_chk(uint16_t dst_role, uint16_t src_role);
 uint16_t bnep_setup_decode(struct bnep_setup_conn_req *req, uint16_t *dst,
 								uint16_t *src);
+
+sdp_record_t *pan_record(const char *name, uint16_t id, gboolean security);
diff --git a/profiles/network/server.c b/profiles/network/server.c
index 73741ec..95564c6 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -125,132 +125,6 @@ static struct network_server *find_server_by_uuid(GSList *list,
 	return NULL;
 }
 
-static sdp_record_t *server_record_new(const char *name, uint16_t id)
-{
-	sdp_list_t *svclass, *pfseq, *apseq, *root, *aproto;
-	uuid_t root_uuid, pan, l2cap, bnep;
-	sdp_profile_desc_t profile[1];
-	sdp_list_t *proto[2];
-	sdp_data_t *v, *p;
-	uint16_t psm = BNEP_PSM, version = 0x0100;
-	uint16_t security_desc = (security ? 0x0001 : 0x0000);
-	uint16_t net_access_type = 0xfffe;
-	uint32_t max_net_access_rate = 0;
-	const char *desc = "Network service";
-	sdp_record_t *record;
-
-	record = sdp_record_alloc();
-	if (!record)
-		return NULL;
-
-	record->attrlist = NULL;
-	record->pattern = NULL;
-
-	switch (id) {
-	case BNEP_SVC_NAP:
-		sdp_uuid16_create(&pan, NAP_SVCLASS_ID);
-		svclass = sdp_list_append(NULL, &pan);
-		sdp_set_service_classes(record, svclass);
-
-		sdp_uuid16_create(&profile[0].uuid, NAP_PROFILE_ID);
-		profile[0].version = 0x0100;
-		pfseq = sdp_list_append(NULL, &profile[0]);
-		sdp_set_profile_descs(record, pfseq);
-
-		sdp_set_info_attr(record, name, NULL, desc);
-
-		sdp_attr_add_new(record, SDP_ATTR_NET_ACCESS_TYPE,
-					SDP_UINT16, &net_access_type);
-		sdp_attr_add_new(record, SDP_ATTR_MAX_NET_ACCESSRATE,
-					SDP_UINT32, &max_net_access_rate);
-		break;
-	case BNEP_SVC_GN:
-		sdp_uuid16_create(&pan, GN_SVCLASS_ID);
-		svclass = sdp_list_append(NULL, &pan);
-		sdp_set_service_classes(record, svclass);
-
-		sdp_uuid16_create(&profile[0].uuid, GN_PROFILE_ID);
-		profile[0].version = 0x0100;
-		pfseq = sdp_list_append(NULL, &profile[0]);
-		sdp_set_profile_descs(record, pfseq);
-
-		sdp_set_info_attr(record, name, NULL, desc);
-		break;
-	case BNEP_SVC_PANU:
-		sdp_uuid16_create(&pan, PANU_SVCLASS_ID);
-		svclass = sdp_list_append(NULL, &pan);
-		sdp_set_service_classes(record, svclass);
-
-		sdp_uuid16_create(&profile[0].uuid, PANU_PROFILE_ID);
-		profile[0].version = 0x0100;
-		pfseq = sdp_list_append(NULL, &profile[0]);
-		sdp_set_profile_descs(record, pfseq);
-
-		sdp_set_info_attr(record, name, NULL, desc);
-		break;
-	default:
-		sdp_record_free(record);
-		return NULL;
-	}
-
-	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(NULL, &root_uuid);
-	sdp_set_browse_groups(record, root);
-
-	sdp_uuid16_create(&l2cap, L2CAP_UUID);
-	proto[0] = sdp_list_append(NULL, &l2cap);
-	p = sdp_data_alloc(SDP_UINT16, &psm);
-	proto[0] = sdp_list_append(proto[0], p);
-	apseq    = sdp_list_append(NULL, proto[0]);
-
-	sdp_uuid16_create(&bnep, BNEP_UUID);
-	proto[1] = sdp_list_append(NULL, &bnep);
-	v = sdp_data_alloc(SDP_UINT16, &version);
-	proto[1] = sdp_list_append(proto[1], v);
-
-	/* Supported protocols */
-	{
-		uint16_t ptype[] = {
-			0x0800,  /* IPv4 */
-			0x0806,  /* ARP */
-		};
-		sdp_data_t *head, *pseq;
-		int p;
-
-		for (p = 0, head = NULL; p < 2; p++) {
-			sdp_data_t *data = sdp_data_alloc(SDP_UINT16, &ptype[p]);
-			if (head)
-				sdp_seq_append(head, data);
-			else
-				head = data;
-		}
-		pseq = sdp_data_alloc(SDP_SEQ16, head);
-		proto[1] = sdp_list_append(proto[1], pseq);
-	}
-
-	apseq = sdp_list_append(apseq, proto[1]);
-
-	aproto = sdp_list_append(NULL, apseq);
-	sdp_set_access_protos(record, aproto);
-
-	sdp_add_lang_attr(record);
-
-	sdp_attr_add_new(record, SDP_ATTR_SECURITY_DESC,
-				SDP_UINT16, &security_desc);
-
-	sdp_data_free(p);
-	sdp_data_free(v);
-	sdp_list_free(apseq, NULL);
-	sdp_list_free(root, NULL);
-	sdp_list_free(aproto, NULL);
-	sdp_list_free(proto[0], NULL);
-	sdp_list_free(proto[1], NULL);
-	sdp_list_free(svclass, NULL);
-	sdp_list_free(pfseq, NULL);
-
-	return record;
-}
-
 static int server_connadd(struct network_server *ns,
 				struct network_session *session,
 				uint16_t dst_role)
@@ -497,7 +371,7 @@ static uint32_t register_server_record(struct network_server *ns)
 {
 	sdp_record_t *record;
 
-	record = server_record_new(ns->name, ns->id);
+	record = pan_record(ns->name, ns->id, security);
 	if (!record) {
 		error("Unable to allocate new service record");
 		return 0;
-- 
1.8.3.2

