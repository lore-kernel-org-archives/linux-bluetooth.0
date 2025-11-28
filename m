Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00CB2D9EE7
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764360174; cv=pass; b=oDWzFRscnOM2VVAVomS7jV27GC2dMzt9WprYll+AKrCRJ1NxkILLWrpl3oA30E/J4rRlQrxkTwWehCAVjd83Z8ga2V7w4G3MpBmQss5wtTJatqJ3BrV4ivNBHdCNw0PWpjc1FQiy1H9jdip5H2NpQoRSmGqsXdRnGyub7MA2Ibk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764360174; c=relaxed/simple;
	bh=hy9dgkEqpm5Trb/jQQ32dPxR86XXZ6p9UJagUZPKmqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L97zUG5LyeicthueFLgiUM5cGsYyoLSu2uxdOFbPpcerz3iHkKEGVs3iHANH+hC2OK96kOdBdiy+uV4Bq+giyKc2MvKKPWnb7yB/TdbwZIuneJ+l4oSoS12Ffm1Rtga6/QX2GY3NJK7oB5gF4MiUPtBTIGIyc+3GLA8J9rnuwtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=gQhcteBG; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="gQhcteBG"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dJ4345rBSz109Q;
	Fri, 28 Nov 2025 22:02:40 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764360160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6WW/LbWZ9Der3Aa+r+VY9mKZkKEMkw3mhkwvpJkZFQ=;
	b=gQhcteBGIqLOlteFC2piuy8Ws7u83w5Rv+FsTCzGvB2ThIZunE5tc+W4G4R0wNagHx8IVJ
	j7OxiyV5ff+rzf9DOUI5dhF/b5brmJLoxmA55PzR2hyGlY5FbCiBeGQEsS9ELcF1XrWJnG
	M9fr7Tpx+DzpnYXd3DhTrHo+MNwyqrA=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764360160;
	b=iB6QU604N1qVw0iDllwQ+sr2gz4QMWej8dK/o3DVvUId44Y/1PB55bmGtcPinY+j/BoGY2
	lBbSRkpDszPsAfmjDU901XLI3jzJRQmug3WbJjtCq7bvT8efzoB9dNpORNWBdXvYSCFmkT
	d5UriZlCaEpnaFPLlvJfdFIqkHApRLg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764360160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k6WW/LbWZ9Der3Aa+r+VY9mKZkKEMkw3mhkwvpJkZFQ=;
	b=ODcJzx/+7PALQix8N584OnQnosCFEXSGX/ePGMsTwxESQ5Eo1mPZt9pUp/nAbxk2t/r5+k
	4S/iIlwHry8+G01yeaS0sXmjY+NEX0WskupNQhQS+9wGg9+B7gQFqSH658q2Wx9OEp0Av3
	QGe1O48q8BElUSX3WOw44ufWh93ml68=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 5/9] bap: add SupportedFeatures for MediaEndpoints
Date: Fri, 28 Nov 2025 22:02:24 +0200
Message-ID: <da848f8cc1c85683386cdf475743ff448c5ce00d.1764360140.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1764360140.git.pav@iki.fi>
References: <cover.1764360140.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indicate TMAP & GMAP capabilities in SupportedFeatures.
---

Notes:
    v2:
    - make it a dict uuid -> features

 profiles/audio/bap.c | 122 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b07d65e68..0dcc57eb5 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -46,6 +46,8 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/gatt-server.h"
 #include "src/shared/bap.h"
+#include "src/shared/tmap.h"
+#include "src/shared/gmap.h"
 
 #include "btio/btio.h"
 #include "src/plugin.h"
@@ -65,6 +67,10 @@
 #define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint1"
 #define MEDIA_INTERFACE "org.bluez.Media1"
 
+#define VCS_UUID_STR "00001844-0000-1000-8000-00805f9b34fb"
+#define TMAS_UUID_STR "00001855-0000-1000-8000-00805f9b34fb"
+#define GMAS_UUID_STR "00001858-0000-1000-8000-00805f9b34fb"
+
 struct bap_setup;
 
 typedef void (*bap_setup_ready_func_t)(struct bap_setup *setup, int code,
@@ -438,6 +444,120 @@ static gboolean get_qos(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static bool probe_tmap_role(struct bap_ep *ep, uint32_t data)
+{
+	struct gatt_db *db = bt_bap_get_db(ep->data->bap, true);
+
+	return bt_tmap_get_role(bt_tmap_find(db)) & data;
+}
+
+static bool probe_gmap_role(struct bap_ep *ep, uint32_t data)
+{
+	struct gatt_db *db = bt_bap_get_db(ep->data->bap, true);
+
+	return bt_gmap_get_role(bt_gmap_find(db)) & data;
+}
+
+static bool probe_gmap_feature(struct bap_ep *ep, uint32_t data)
+{
+	struct gatt_db *db = bt_bap_get_db(ep->data->bap, true);
+
+	return bt_gmap_get_features(bt_gmap_find(db)) & data;
+}
+
+struct feature {
+	const char *name;
+	bool (*probe)(struct bap_ep *ep, uint32_t data);
+	uint32_t data;
+};
+
+static const struct feature tmap_features[] = {
+	{ "cg", probe_tmap_role, BT_TMAP_ROLE_CG },
+	{ "ct", probe_tmap_role, BT_TMAP_ROLE_CT },
+	{ "ums", probe_tmap_role, BT_TMAP_ROLE_UMS },
+	{ "umr", probe_tmap_role, BT_TMAP_ROLE_UMR },
+	{ "bms", probe_tmap_role, BT_TMAP_ROLE_BMS },
+	{ "bmr", probe_tmap_role, BT_TMAP_ROLE_BMR },
+};
+
+static const struct feature gmap_features[] = {
+	{ "ugg", probe_gmap_role, BT_GMAP_ROLE_UGG },
+	{ "ugt", probe_gmap_role, BT_GMAP_ROLE_UGT },
+	{ "bgs", probe_gmap_role, BT_GMAP_ROLE_BGS },
+	{ "bgr", probe_gmap_role, BT_GMAP_ROLE_BGR },
+	{ "ugg-multiplex", probe_gmap_feature, BT_GMAP_UGG_MULTIPLEX },
+	{ "ugg-96kbps-source", probe_gmap_feature, BT_GMAP_UGG_96KBPS },
+	{ "ugg-multisink", probe_gmap_feature, BT_GMAP_UGG_MULTISINK },
+	{ "ugt-source", probe_gmap_feature, BT_GMAP_UGT_SOURCE },
+	{ "ugt-80kbps-source", probe_gmap_feature,
+						BT_GMAP_UGT_80KBPS_SOURCE },
+	{ "ugt-sink", probe_gmap_feature, BT_GMAP_UGT_SINK },
+	{ "ugt-64kbps-sink", probe_gmap_feature, BT_GMAP_UGT_64KBPS_SINK },
+	{ "ugt-multiplex", probe_gmap_feature, BT_GMAP_UGT_MULTIPLEX },
+	{ "ugt-multisink", probe_gmap_feature, BT_GMAP_UGT_MULTISINK },
+	{ "ugt-multisource", probe_gmap_feature, BT_GMAP_UGT_MULTISOURCE },
+	{ "bgs-96kbps", probe_gmap_feature, BT_GMAP_BGS_96KBPS },
+	{ "bgr-multisink", probe_gmap_feature, BT_GMAP_BGR_MULTISINK },
+	{ "bgr-multiplex", probe_gmap_feature, BT_GMAP_BGR_MULTIPLEX },
+};
+
+static const struct {
+	const char *uuid;
+	const struct feature *items;
+	size_t count;
+} features[] = {
+	{ TMAS_UUID_STR, tmap_features, ARRAY_SIZE(tmap_features) },
+	{ GMAS_UUID_STR, gmap_features, ARRAY_SIZE(gmap_features) },
+};
+
+static gboolean supported_features(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bap_ep *ep = data;
+	DBusMessageIter dict, entry, variant, list;
+	size_t i, j;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
+
+	for (i = 0; i < ARRAY_SIZE(features); ++i) {
+		for (j = 0; j < features[i].count; ++j) {
+			const struct feature *feature = &features[i].items[j];
+
+			if (feature->probe(ep, feature->data))
+				break;
+		}
+		if (j == features[i].count)
+			continue;
+
+		dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY,
+								NULL, &entry);
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+							&features[i].uuid);
+		dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
+								"as", &variant);
+		dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+								"s", &list);
+
+		for (j = 0; j < features[i].count; ++j) {
+			const struct feature *feature = &features[i].items[j];
+
+			if (!feature->probe(ep, feature->data))
+				continue;
+
+			dbus_message_iter_append_basic(&list, DBUS_TYPE_STRING,
+								&feature->name);
+		}
+
+		dbus_message_iter_close_container(&variant, &list);
+		dbus_message_iter_close_container(&entry, &variant);
+		dbus_message_iter_close_container(&dict, &entry);
+	}
+
+	dbus_message_iter_close_container(iter, &dict);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable ep_properties[] = {
 	{ "UUID", "s", get_uuid, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
@@ -457,6 +577,8 @@ static const GDBusPropertyTable ep_properties[] = {
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "QoS", "a{sv}", get_qos, NULL, qos_exists,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "SupportedFeatures", "a{sv}", supported_features, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
-- 
2.51.1

