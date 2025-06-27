Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F742E92BE
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 14:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035920; cv=none; b=UL6MYGd/sZIh4oUxGEyfbSyFSt1iWJj4mDDJ+r/FaWkhIu1+zLHI1MxeH613iv+SUjqdtUE3h41eLi219mKDiYaSPJ9ehjcHbISJ0l8uSAE3Uj/LA2uuSTSveczwIGdJDkk9//hDKS2mtSHOUtKD1Ig8d7cbJovq9Fe4CBS9LE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035920; c=relaxed/simple;
	bh=Cz59CSvKXIuNorKiOVZafKMD+P1L2W5Pa9l+lJDubDE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cxr7yUxS6W/2uwrbG4hEj4GpE76I6mORYfuy/iutF5RozuHeKVX+Qomx2/On7QWzqPE2FMIPkSXz9mx6mDvWTYD7vgbq3RxnNbp4Wb30jJR3CfJ8OInzQeMrHF6C8aUSRxttkqKYlcYDp2UkdRhRdnsxvnFrd8C7kStTNMoNIxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DyRf/z8w; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DyRf/z8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751035907;
	bh=Cz59CSvKXIuNorKiOVZafKMD+P1L2W5Pa9l+lJDubDE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=DyRf/z8wOyjWwzpPFi1jABRDPEk15hYpvNh4acZfJdJfWEs6KCeAzPLVIknRhV53x
	 rSCba2u1hDdqo0qJMsahyhFSE3K/thN3J7tavhaF1wR2g48bBxDCdWKR64MQnRJ9IY
	 vBv+Orzi4jltmyWIXPSfotbvO50ptvOH7K3rMqTcr3QaEKaYJLJ7G5OnwJIN7p7l7E
	 Ayh3Vg/aNjyxvbJTvpm2uZQpe1soHGTJXYNKg+5kbL6nGtx3kHdlY3nFlKQpbtn97P
	 5OlNWgDaADqnINvce+YGa9WIxY0mzMIkZQ5bkXRzORWHIGvNAJVYJp3EZU3+blzvGr
	 BskkHXWaczdnQ==
Received: from fdanis-ThinkPad-X1.. (2A02-8428-Af44-1001-81C9-67b7-a328-2001.rev.sfr.net [IPv6:2a02:8428:af44:1001:81c9:67b7:a328:2001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A3BDC17E0B8B
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 16:51:47 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v2 19/27] audio/hfp-hf: Add HFP HF server and SDP record
Date: Fri, 27 Jun 2025 16:51:28 +0200
Message-ID: <20250627145136.421853-20-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250627145136.421853-1-frederic.danis@collabora.com>
References: <20250627145136.421853-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 profiles/audio/hfp-hf.c | 253 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 253 insertions(+)

diff --git a/profiles/audio/hfp-hf.c b/profiles/audio/hfp-hf.c
index 9a659a281..b49d40a43 100644
--- a/profiles/audio/hfp-hf.c
+++ b/profiles/audio/hfp-hf.c
@@ -45,6 +45,9 @@
 
 #include "telephony.h"
 
+#define HFP_HF_VERSION		0x0109
+#define HFP_HF_DEFAULT_CHANNEL	7
+
 #define CALL_IND_NO_CALL_IN_PROGRESS	0x00
 #define CALL_IND_CALL_IN_PROGRESS	0x01
 
@@ -56,6 +59,16 @@
 #define CHLD_FEAT_MERGE		0x00000020
 #define CHLD_FEAT_MERGE_DETACH	0x00000040
 
+#define HFP_HF_SDP_ECNR					0x0001
+#define HFP_HF_SDP_3WAY					0x0002
+#define HFP_HF_SDP_CLIP					0x0004
+#define HFP_HF_SDP_VOICE_RECOGNITION			0x0008
+#define HFP_HF_SDP_REMOTE_VOLUME_CONTROL		0x0010
+#define HFP_HF_SDP_WIDE_BAND_SPEECH			0x0020
+#define HFP_HF_SDP_ENHANCED_VOICE_RECOGNITION_STATUS	0x0040
+#define HFP_HF_SDP_VOICE_RECOGNITION_TEXT		0x0080
+#define HFP_HF_SDP_SUPER_WIDE_BAND_SPEECH		0x0100
+
 #define HFP_HF_FEAT_ECNR				0x00000001
 #define HFP_HF_FEAT_3WAY				0x00000002
 #define HFP_HF_FEAT_CLIP				0x00000004
@@ -84,6 +97,10 @@
 #define HFP_AG_FEAT_ENHANCED_VOICE_RECOGNITION_STATUS	0x00001000
 #define HFP_AG_FEAT_VOICE_RECOGNITION_TEXT		0x00001000
 
+#define HFP_HF_SDP_FEATURES	(HFP_HF_SDP_ECNR | HFP_HF_SDP_3WAY |\
+				HFP_HF_SDP_CLIP |\
+				HFP_HF_SDP_REMOTE_VOLUME_CONTROL)
+
 #define HFP_HF_FEATURES		(HFP_HF_FEAT_ECNR | HFP_HF_FEAT_3WAY |\
 				HFP_HF_FEAT_CLIP |\
 				HFP_HF_FEAT_REMOTE_VOLUME_CONTROL |\
@@ -140,6 +157,26 @@ struct hfp_device {
 	GSList			*calls;
 };
 
+struct hfp_server {
+	struct btd_adapter	*adapter;
+	GIOChannel		*io;
+	uint32_t		record_id;
+};
+
+static GSList *servers;
+
+static struct hfp_server *find_server(GSList *list, struct btd_adapter *a)
+{
+	for (; list; list = list->next) {
+		struct hfp_server *server = list->data;
+
+		if (server->adapter == a)
+			return server;
+	}
+
+	return NULL;
+}
+
 static void device_destroy(struct hfp_device *dev)
 {
 	DBG("%s", telephony_get_path(dev->telephony));
@@ -1427,6 +1464,219 @@ static void hfp_remove(struct btd_service *service)
 	g_free(dev);
 }
 
+static sdp_record_t *hfp_record(void)
+{
+	sdp_record_t *record;
+	uuid_t root_uuid, hfphf, genericaudio, l2cap, rfcomm;
+	sdp_list_t *root, *svclass_id, *aproto, *proto[2], *apseq, *pfseq;
+	sdp_data_t *channel, *features;
+	uint8_t hf_channel = HFP_HF_DEFAULT_CHANNEL;
+	sdp_profile_desc_t profile;
+	uint16_t feat = HFP_HF_SDP_FEATURES;
+
+	record = sdp_record_alloc();
+	if (!record) {
+		error("Unable to allocate new service record");
+		return NULL;
+	}
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(NULL, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	/* Service Class ID List */
+	sdp_uuid16_create(&hfphf, HANDSFREE_SVCLASS_ID);
+	svclass_id = sdp_list_append(NULL, &hfphf);
+	sdp_uuid16_create(&genericaudio, GENERIC_AUDIO_SVCLASS_ID);
+	svclass_id = sdp_list_append(svclass_id, &genericaudio);
+	sdp_set_service_classes(record, svclass_id);
+
+	/* Protocol Descriptor List */
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+	proto[0] = sdp_list_append(NULL, &l2cap);
+	apseq = sdp_list_append(NULL, proto[0]);
+
+	sdp_uuid16_create(&rfcomm, RFCOMM_UUID);
+	proto[1] = sdp_list_append(NULL, &rfcomm);
+	channel = sdp_data_alloc(SDP_UINT8, &hf_channel);
+	proto[1] = sdp_list_append(proto[1], channel);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	/* Bluetooth Profile Descriptor List */
+	sdp_uuid16_create(&profile.uuid, HANDSFREE_PROFILE_ID);
+	profile.version = HFP_HF_VERSION;
+	pfseq = sdp_list_append(NULL, &profile);
+	sdp_set_profile_descs(record, pfseq);
+
+	sdp_set_info_attr(record, "Hands-Free unit", NULL, NULL);
+
+	features = sdp_data_alloc(SDP_UINT16, &feat);
+	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
+
+	free(channel);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(pfseq, NULL);
+	sdp_list_free(aproto, NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(svclass_id, NULL);
+	sdp_list_free(root, NULL);
+
+	return record;
+}
+
+static void server_connect_cb(GIOChannel *chan, GError *err, gpointer data)
+{
+	uint8_t channel;
+	bdaddr_t src, dst;
+	char address[18];
+	GError *gerr = NULL;
+	struct btd_device *device;
+	struct btd_service *service;
+	struct hfp_device *dev;
+	const sdp_record_t *rec;
+	sdp_list_t *list;
+	sdp_profile_desc_t *desc;
+
+	if (err) {
+		error("%s", err->message);
+		return;
+	}
+
+	bt_io_get(chan, &gerr,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_CHANNEL, &channel,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		g_io_channel_shutdown(chan, TRUE, NULL);
+		return;
+	}
+
+	ba2str(&dst, address);
+	DBG("Incoming connection from %s on Channel %d", address, channel);
+
+	device = btd_adapter_find_device(adapter_find(&src), &dst,
+							BDADDR_BREDR);
+	if (!device)
+		return;
+
+	service = btd_device_get_service(device, HFP_AG_UUID);
+	if (!service)
+		return;
+
+	dev = btd_service_get_user_data(service);
+
+	rec = btd_device_get_record(telephony_get_device(dev->telephony),
+					HFP_AG_UUID);
+	if (!rec)
+		return;
+
+	if (sdp_get_profile_descs(rec, &list) == 0) {
+		desc = list->data;
+		dev->version = desc->version;
+	}
+	sdp_list_free(list, free);
+
+	telephony_register_interface(dev->telephony);
+
+	connect_cb(chan, err, dev);
+}
+
+static GIOChannel *server_socket(struct btd_adapter *adapter)
+{
+	GIOChannel *io;
+	GError *err = NULL;
+
+	io = bt_io_listen(server_connect_cb, NULL, NULL, NULL, &err,
+		BT_IO_OPT_SOURCE_BDADDR,
+		btd_adapter_get_address(adapter),
+		BT_IO_OPT_CHANNEL, HFP_HF_DEFAULT_CHANNEL,
+		BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+		BT_IO_OPT_INVALID);
+	if (!io) {
+		error("%s", err->message);
+		g_error_free(err);
+	}
+
+	return io;
+}
+
+static int hfp_adapter_probe(struct btd_profile *p,
+				struct btd_adapter *adapter)
+{
+	struct hfp_server *server;
+	sdp_record_t *record;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	server = find_server(servers, adapter);
+	if (server != NULL)
+		goto done;
+
+	server = g_new0(struct hfp_server, 1);
+
+	server->io = server_socket(adapter);
+	if (!server->io) {
+		g_free(server);
+		return -1;
+	}
+
+done:
+	record = hfp_record();
+	if (!record) {
+		error("Unable to allocate new service record");
+		g_free(server);
+		return -1;
+	}
+
+	if (adapter_service_add(adapter, record) < 0) {
+		error("Unable to register HFP HF service record");
+		sdp_record_free(record);
+		g_free(server);
+		return -1;
+	}
+	server->record_id = record->handle;
+
+	server->adapter = btd_adapter_ref(adapter);
+
+	servers = g_slist_append(servers, server);
+
+	return 0;
+}
+
+static void hfp_adapter_remove(struct btd_profile *p,
+				struct btd_adapter *adapter)
+{
+	struct hfp_server *server;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	server = find_server(servers, adapter);
+	if (!server)
+		return;
+
+	if (server->io) {
+		g_io_channel_shutdown(server->io, TRUE, NULL);
+		g_io_channel_unref(server->io);
+	}
+
+	if (server->record_id != 0) {
+		adapter_service_remove(adapter, server->record_id);
+		server->record_id = 0;
+	}
+
+	servers = g_slist_remove(servers, server);
+
+	btd_adapter_unref(server->adapter);
+	g_free(server);
+}
+
 static struct btd_profile hfp_hf_profile = {
 	.name		= "hfp",
 	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
@@ -1439,6 +1689,9 @@ static struct btd_profile hfp_hf_profile = {
 	.connect	= hfp_connect,
 	.disconnect	= hfp_disconnect,
 
+	.adapter_probe  = hfp_adapter_probe,
+	.adapter_remove = hfp_adapter_remove,
+
 	.experimental	= true,
 };
 
-- 
2.43.0

