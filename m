Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2504A0EEE
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529899; cv=none; b=sJMR26ykzoC0BAOXCvX62rlOgx5aAvXI4YYHnIXEpqFhpqswPWWmEXe4SaOwNroHvYj644ChMC9N211xaZvWKXjuxlbHwhAn1eV+9XnWmTCIIl67p3gDqK6qZ8+fp7vPgIKSMN6zQWvfESjdYynjb48y5f8yKTSk5eNxxvWiROA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529899; c=relaxed/simple;
	bh=pquTc+bL9ThFILMlDFyN1C5A5MDmFLDVzwbGO17l8ww=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kh/oXFSpbtKkLcDunR7OM0+Gw/IgdeoIJAGtNzSvfgMzePTfRBWGevT+CiuorJ+VpGytImSJs8My2Jf61tcjTkHMTJNG2yIySd3Ue9LvigGFwgKjJGZXC4l3pXUvNC9M4Mc+rAZSlNWmxCnnXNpk1QZdPGFaiR/j5wQzKlbjFcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Fr769vd/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Fr769vd/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788529890;
	bh=pquTc+bL9ThFILMlDFyN1C5A5MDmFLDVzwbGO17l8ww=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Fr769vd/3qfTEWMCGEsu5noExYN8yqP7U1Pv9LGFTKl2ZLgZwAoxsNEzRVYDSdmrf
	 hWTOOsoWNawNzj9MhNzulQQIkxTxvwGpf3maAK0HMl+vf5/4Tal6+93fMiZRL86Qcn
	 2H9GSQCp+zKoI5mC0b4lnXcAhcKi6jzh4pj1chGrwIe28qeGIHsrmW38M+xQpyfpyE
	 UkunLlANTIt09WY64HDlEYknz6lrhTwGMkopLtO933Wu13Ahfm/x+VYUfaeJ9uAlZY
	 FB/0ynbxyYMcdfqEoNkGBPJm+Fn6lJmuRGAaU158SzDPUu69twSUq8AGm3bfskbpws
	 JitzCitblGsNA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D799317E0C10
	for <linux-bluetooth@vger.kernel.org>; Fri, 04 Sep 2026 15:51:29 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/8] client/btpclient: Get Codec capabilities on ASE reply
Date: Fri,  4 Sep 2026 15:51:18 +0200
Message-ID: <20260904135124.981346-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904135124.981346-1-frederic.danis@collabora.com>
References: <20260904135124.981346-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 Makefile.tools         |  2 +-
 client/btpclient/bap.c | 94 ++++++++++++++++++++++++++++++++++++++++--
 src/shared/btp.h       | 12 ++++++
 3 files changed, 104 insertions(+), 4 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 4a59b6dee..5c4a6070a 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -567,7 +567,7 @@ noinst_PROGRAMS += client/btpclient/btpclient client/btpclient/btpclientctl
 
 client_btpclient_btpclient_SOURCES = client/btpclient/btpclient.c \
 				client/btpclient/btpclient.h \
-				src/shared/btp.c src/shared/btp.h \
+				src/shared/btp.c src/shared/btp.h src/shared/bap-defs.h \
 				client/btpclient/bap.c client/btpclient/bap.h \
 				client/btpclient/core.c client/btpclient/core.h \
 				client/btpclient/gap.c client/btpclient/gap.h \
diff --git a/client/btpclient/bap.c b/client/btpclient/bap.c
index cdbae4ac2..d30d931f1 100644
--- a/client/btpclient/bap.c
+++ b/client/btpclient/bap.c
@@ -17,6 +17,7 @@
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/uuid.h"
+#include "src/shared/bap-defs.h"
 #include "src/shared/btp.h"
 #include "btpclient.h"
 #include "bap.h"
@@ -59,6 +60,13 @@ failed:
 	btp_send_error(btp, BTP_BAP_SERVICE, index, BTP_ERROR_FAIL);
 }
 
+static bool match_attribute_uuid(const void *attr, const void *uuid)
+{
+	const struct gatt_attribute *attribute = attr;
+
+	return !bt_uuid_cmp(&attribute->uuid, uuid);
+}
+
 static void btp_bap_discover(uint8_t index, const void *param, uint16_t length,
 								void *user_data)
 {
@@ -110,17 +118,17 @@ static void bap_charac_read_setup(struct l_dbus_message *message,
 	l_dbus_message_builder_destroy(builder);
 }
 
-static void bap_read_ase_reply(struct l_dbus_proxy *proxy,
+static void bap_read_pac_reply(struct l_dbus_proxy *proxy,
 						struct l_dbus_message *result,
 						void *user_data)
 {
 	struct btp_ase *ase = user_data;
 	struct btp_device *device = ase->device;
 	struct btp_adapter *adapter = find_adapter_by_device(device);
-	struct btp_bap_ase_found_ev *rp;
+	struct btp_bap_codec_cap_found_ev *rp;
 	struct l_dbus_message_iter iter;
 	uint8_t *data;
-	uint32_t n;
+	uint32_t n, i, capa_length;
 
 	if (l_dbus_message_is_error(result)) {
 		const char *name, *desc;
@@ -141,6 +149,73 @@ static void bap_read_ase_reply(struct l_dbus_proxy *proxy,
 		goto failed;
 	}
 
+	rp = l_new(struct btp_bap_codec_cap_found_ev, 1);
+	rp->address_type = device->address_type;
+	rp->address = device->address;
+	rp->dir = ase->dir;
+	rp->coding_format = data[1];
+	capa_length = data[6];
+	i = 0;
+	while (i < capa_length) {
+		struct bt_ltv *ltv = (struct bt_ltv *)(data + i + 7);
+
+		if ((i + ltv->len >= capa_length) || (!ltv->len))
+			goto failed;
+
+		if (ltv->type == 0x01)
+			rp->frequencies = bt_get_le16(ltv->value);
+		else if (ltv->type == 0x02)
+			rp->frame_durations = ltv->value[0];
+		else if (ltv->type == 0x03)
+			rp->channel_counts = ltv->value[0];
+		else if (ltv->type == 0x04)
+			rp->octets_per_frame = bt_get_le32(ltv->value);
+
+		i += ltv->len + 1;
+	}
+
+	btp_send(btp, BTP_BAP_SERVICE, BTP_BAP_EV_CODEC_CAP_FOUND,
+		adapter->index, sizeof(struct btp_bap_codec_cap_found_ev), rp);
+
+	free(rp);
+
+	return;
+
+failed:
+	btp_send_error(btp, BTP_BAP_SERVICE, adapter->index, BTP_ERROR_FAIL);
+}
+
+static void bap_read_ase_reply(struct l_dbus_proxy *proxy,
+						struct l_dbus_message *result,
+						void *user_data)
+{
+	struct btp_ase *ase = user_data;
+	struct btp_device *device = ase->device;
+	struct btp_adapter *adapter = find_adapter_by_device(device);
+	struct btp_bap_ase_found_ev *rp;
+	struct l_dbus_message_iter iter;
+	uint8_t *data;
+	uint32_t n;
+	bt_uuid_t uuid;
+	struct gatt_attribute *attribute;
+
+	if (l_dbus_message_is_error(result)) {
+		const char *name, *desc;
+
+		l_dbus_message_get_error(result, &name, &desc);
+		l_error("Failed to read value (%s), %s", name, desc);
+
+		goto failed;
+	}
+
+	if (!l_dbus_message_get_arguments(result, "ay", &iter))
+		goto failed;
+
+	if (!l_dbus_message_iter_get_fixed_array(&iter, &data, &n)) {
+		l_debug("Cannot read value");
+		goto failed;
+	}
+
 	ase->ase_id = data[0];
 
 	rp = l_new(struct btp_bap_ase_found_ev, 1);
@@ -154,6 +229,19 @@ static void bap_read_ase_reply(struct l_dbus_proxy *proxy,
 
 	free(rp);
 
+	if (bt_uuid16_cmp(&ase->uuid, ASE_SINK_UUID))
+		bt_uuid16_create(&uuid, PAC_SINK_CHRC_UUID);
+	else
+		bt_uuid16_create(&uuid, PAC_SOURCE_CHRC_UUID);
+	attribute = l_queue_find(device->characteristics,
+						match_attribute_uuid, &uuid);
+	if (!attribute)
+		goto failed;
+
+	l_dbus_proxy_method_call(attribute->proxy, "ReadValue",
+				bap_charac_read_setup, bap_read_pac_reply,
+				ase, NULL);
+
 	return;
 
 failed:
diff --git a/src/shared/btp.h b/src/shared/btp.h
index 9757301f2..100308de1 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -443,6 +443,18 @@ struct btp_bap_discovery_completed_ev {
 	uint8_t status;
 } __packed;
 
+#define BTP_BAP_EV_CODEC_CAP_FOUND		0x81
+struct btp_bap_codec_cap_found_ev {
+	uint8_t address_type;
+	bdaddr_t address;
+	uint8_t dir;
+	uint8_t coding_format;
+	uint16_t frequencies;
+	uint8_t frame_durations;
+	uint32_t octets_per_frame;
+	uint8_t channel_counts;
+} __packed;
+
 #define BTP_EV_BAP_ASE_FOUND			0x82
 struct btp_bap_ase_found_ev {
 	uint8_t address_type;
-- 
2.43.0

