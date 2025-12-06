Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621E82D8DA8
	for <linux-bluetooth@vger.kernel.org>; Sat,  6 Dec 2025 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765018908; cv=pass; b=fKTI8pzUxJ8Xj+1fkOgXjLkfRGyhbAnK1KK6v4keBBBnydcdv9TDKRqRrZHRHB+YV0Ln5GCWFpoqF1FAMUI9pWKr98Y4Fxrsc7FcQul6iilelWnc2C8+JlOxUKJVi/SoFu0x+++3Qsi/gQjYjzLVkUDiIp+az2fQJpg5kc6T9qA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765018908; c=relaxed/simple;
	bh=MZnHO4qcDQkB35u7JinC0IRdzu7k20d821v4pL6Dwx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sX9PuBAeCwI5/UGO8rfnZ5GKuQCSAX7f3d3r4PYu1+6kyrig5mgegGGcNvwCcWUDZhVaCO9thmtmmMqH0miROJyB5y4c9raiI7r2JwVppoXcfwHhA43ZefFzWz8Y5RN1K/0Ci1GBbY4+VS+zQnJ6onAQgHC6Ho/Kf1cNQiv6Ka0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=L9lMSeHz; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="L9lMSeHz"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dNlgB4hzwz108j;
	Sat,  6 Dec 2025 13:01:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765018903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fu6BWJHdMXXiZhT8UE0uQwOC2UX+qk0i7sa2Lw8FvfE=;
	b=L9lMSeHzc6S8IaYGN//pvCXs09iIwK2X/ACWMRxXDMzD2v3OVOQ336cDaRZ+xphvdCCP7g
	X4I4aHi8L4z65EyG1VCYxgtXmL4HGYPPczwQ9tOh+NBkaON4YhveJn/at+5NYbJsCRc5Uo
	vBe0lR/qTV0f4fcnfSG4rSGZuTH53Zc=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765018903;
	b=WxGqE4skZpz1wxL7h+LgLcLr7zLX9tD9O5m70+cvsBjOf7XtzGDok1VUd+uLOKEpbB8YQw
	gVbzeQ1Cj5rUwVIqhIISAH1hXHSkbyRsC64LDGEFuiTe6d2lOmBwIGn4GpxicyBXzIoPLX
	2H+7OWVckyrvAfZMiKgrWOtaGYLC7nI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765018903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fu6BWJHdMXXiZhT8UE0uQwOC2UX+qk0i7sa2Lw8FvfE=;
	b=FmWYxJmhGB/owCqa2qt6zS/YmICOP9tTyMcgjoXmq6M6fznuWytZ5oDMfhGp3EnDLEd5xH
	GkQs3svCjOt965eHGeHnpmBI4WdcZhHv0y0m4tdn/I3nkGs8MpJgu2KRQns8vUBdVoGdmn
	cjgYmFSkD9bSRDjrAI3WxhfuzAQ60q0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 09/11] media: parse SupportedFeatures from registered MediaEndpoints
Date: Sat,  6 Dec 2025 13:01:25 +0200
Message-ID: <2eb690d52ed1c1e8086527b60bc7f5ad7f280c05.1765018766.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765018766.git.pav@iki.fi>
References: <cover.1765018766.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse SupportedFeatures for TMAP and GMAP features, and update the
values to the local services if present.
---
 profiles/audio/media.c | 160 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 156 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 418a9d06b..9deeed1f4 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -55,6 +55,8 @@
 #include "src/shared/att.h"
 #include "src/shared/bap.h"
 #include "src/shared/bap-debug.h"
+#include "src/shared/tmap.h"
+#include "src/shared/gmap.h"
 
 #ifdef HAVE_A2DP
 #include "avdtp.h"
@@ -109,6 +111,12 @@ struct endpoint_request {
 	void			*user_data;
 };
 
+struct endpoint_features {
+	uint8_t			tmap_role;
+	uint8_t			gmap_role;
+	uint32_t		gmap_features;
+};
+
 struct media_endpoint {
 #ifdef HAVE_A2DP
 	struct a2dp_sep		*sep;
@@ -133,6 +141,7 @@ struct media_endpoint {
 	GSList			*requests;
 	struct media_adapter	*adapter;
 	GSList			*transports;
+	struct endpoint_features	features;
 };
 
 struct media_player {
@@ -247,6 +256,33 @@ static struct media_endpoint *media_adapter_find_endpoint(
 	return NULL;
 }
 
+static void update_features(struct media_adapter *adapter)
+{
+	struct endpoint_features all = { 0 };
+	GSList *list;
+	struct btd_gatt_database *database;
+	struct gatt_db *db;
+	struct bt_tmap *tmap;
+	struct bt_gmap *gmap;
+
+	for (list = adapter->endpoints; list; list = list->next) {
+		struct media_endpoint *endpoint = list->data;
+
+		all.tmap_role |= endpoint->features.tmap_role;
+		all.gmap_role |= endpoint->features.gmap_role;
+		all.gmap_features |= endpoint->features.gmap_features;
+	}
+
+	database = btd_adapter_get_database(adapter->btd_adapter);
+	db = btd_gatt_database_get_db(database);
+	tmap = bt_tmap_find(db);
+	gmap = bt_gmap_find(db);
+
+	bt_tmap_set_role(tmap, all.tmap_role);
+	bt_gmap_set_role(gmap, all.gmap_role);
+	bt_gmap_set_features(gmap, all.gmap_features);
+}
+
 static void media_endpoint_remove(void *data)
 {
 	struct media_endpoint *endpoint = data;
@@ -270,6 +306,8 @@ static void media_endpoint_remove(void *data)
 							"MediaEndpoints");
 
 	media_endpoint_destroy(endpoint);
+
+	update_features(adapter);
 }
 
 static void media_endpoint_exit(DBusConnection *connection, void *user_data)
@@ -1531,6 +1569,7 @@ media_endpoint_create(struct media_adapter *adapter,
 						int size,
 						uint8_t *metadata,
 						int metadata_size,
+						struct endpoint_features *feat,
 						int *err)
 {
 	struct media_endpoint *endpoint;
@@ -1550,6 +1589,9 @@ media_endpoint_create(struct media_adapter *adapter,
 	if (qos)
 		endpoint->qos = *qos;
 
+	if (feat)
+		endpoint->features = *feat;
+
 	if (size > 0) {
 		endpoint->capabilities = g_new(uint8_t, size);
 		memcpy(endpoint->capabilities, capabilities, size);
@@ -1596,11 +1638,98 @@ media_endpoint_create(struct media_adapter *adapter,
 	adapter->endpoints = g_slist_append(adapter->endpoints, endpoint);
 	info("Endpoint registered: sender=%s path=%s", sender, path);
 
+	update_features(adapter);
+
 	if (err)
 		*err = 0;
 	return endpoint;
 }
 
+static void parse_tmap_role(struct endpoint_features *features, uint32_t data)
+{
+	features->tmap_role |= data;
+}
+
+static void parse_gmap_role(struct endpoint_features *features, uint32_t data)
+{
+	features->gmap_role |= data;
+}
+
+static void parse_gmap_feature(struct endpoint_features *features,
+								uint32_t data)
+{
+	features->gmap_features |= data;
+}
+
+#define TMAP_ROLE(key) \
+	{ .uuid = TMAS_UUID_STR, .name = key ## _STR, .data = key, \
+	  .func = parse_tmap_role },
+#define GMAP_ROLE(key) \
+	{ .uuid = GMAS_UUID_STR, .name = key ## _STR, .data = key, \
+	  .func = parse_gmap_role },
+#define GMAP_FEATURE(key) \
+	{ .uuid = GMAS_UUID_STR, .name = key ## _STR, .data = key, \
+	  .func = parse_gmap_feature },
+
+static const struct endpoint_feature_dbus {
+	const char *uuid;
+	const char *name;
+	uint32_t data;
+	void (*func)(struct endpoint_features *features, uint32_t data);
+} endpoint_features[] = {
+	BT_TMAP_ROLE_LIST(TMAP_ROLE)
+	BT_GMAP_ROLE_LIST(GMAP_ROLE)
+	BT_GMAP_FEATURE_LIST(GMAP_FEATURE)
+};
+
+static void parse_endpoint_feature(const char *uuid, const char *value,
+					struct endpoint_features *features)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(endpoint_features); ++i) {
+		const struct endpoint_feature_dbus *f = &endpoint_features[i];
+
+		if (strcmp(uuid, f->uuid) == 0 && strcmp(value, f->name) == 0) {
+			f->func(features, f->data);
+			break;
+		}
+	}
+}
+
+static int parse_endpoint_features(DBusMessageIter *iter,
+					struct endpoint_features *features)
+{
+	while (dbus_message_iter_get_arg_type(iter) == DBUS_TYPE_DICT_ENTRY) {
+		const char *uuid, *name;
+		DBusMessageIter value, entry, array;
+		int var;
+
+		dbus_message_iter_recurse(iter, &entry);
+		dbus_message_iter_get_basic(&entry, &uuid);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+		if (var != DBUS_TYPE_ARRAY)
+			return -EINVAL;
+
+		dbus_message_iter_recurse(&value, &array);
+
+		while (dbus_message_iter_get_arg_type(&array)
+							== DBUS_TYPE_STRING) {
+			dbus_message_iter_get_basic(&array, &name);
+			parse_endpoint_feature(uuid, name, features);
+			dbus_message_iter_next(&array);
+		}
+
+		dbus_message_iter_next(iter);
+	}
+
+	return 0;
+}
+
 struct vendor {
 	uint16_t cid;
 	uint16_t vid;
@@ -1611,7 +1740,8 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 				uint16_t *cid, uint16_t *vid,
 				struct bt_bap_pac_qos *qos,
 				uint8_t **capabilities, int *size,
-				uint8_t **metadata, int *metadata_size)
+				uint8_t **metadata, int *metadata_size,
+				struct endpoint_features *features)
 {
 	gboolean has_uuid = FALSE;
 	gboolean has_codec = FALSE;
@@ -1708,6 +1838,15 @@ static int parse_properties(DBusMessageIter *props, const char **uuid,
 				return -EINVAL;
 			dbus_message_iter_get_basic(&value,
 						    &qos->supported_context);
+		} else if (strcasecmp(key, "SupportedFeatures") == 0) {
+			DBusMessageIter array;
+
+			if (var != DBUS_TYPE_ARRAY)
+				return -EINVAL;
+
+			dbus_message_iter_recurse(&value, &array);
+			if (parse_endpoint_features(&array, features) < 0)
+				return -EINVAL;
 		}
 
 		dbus_message_iter_next(props);
@@ -1727,6 +1866,7 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 	uint16_t cid = 0;
 	uint16_t vid = 0;
 	struct bt_bap_pac_qos qos = {};
+	struct endpoint_features features = { 0 };
 	uint8_t *capabilities = NULL;
 	uint8_t *metadata = NULL;
 	int size = 0;
@@ -1749,13 +1889,13 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 
 	if (parse_properties(&props, &uuid, &delay_reporting, &codec, &cid,
 			&vid, &qos, &capabilities, &size, &metadata,
-			&metadata_size) < 0)
+			&metadata_size, &features) < 0)
 		return btd_error_invalid_args(msg);
 
 	if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
 					codec, cid, vid, &qos, capabilities,
 					size, metadata, metadata_size,
-					&err) == NULL) {
+					&features, &err) == NULL) {
 		if (err == -EPROTONOSUPPORT)
 			return btd_error_not_supported(msg);
 		else
@@ -2786,6 +2926,7 @@ static void app_register_endpoint(void *data, void *user_data)
 	int size = 0;
 	uint8_t *metadata = NULL;
 	int metadata_size = 0;
+	struct endpoint_features features = { 0 };
 	DBusMessageIter iter, array;
 	struct media_endpoint *endpoint;
 
@@ -2918,12 +3059,23 @@ static void app_register_endpoint(void *data, void *user_data)
 		dbus_message_iter_get_basic(&iter, &qos.supported_context);
 	}
 
+	if (g_dbus_proxy_get_property(proxy, "SupportedFeatures", &iter)) {
+		DBusMessageIter array;
+
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
+			goto fail;
+
+		dbus_message_iter_recurse(&iter, &array);
+		if (parse_endpoint_features(&array, &features) < 0)
+			goto fail;
+	}
+
 	endpoint = media_endpoint_create(app->adapter, app->sender, path, uuid,
 						delay_reporting, codec,
 						vendor.cid, vendor.vid, &qos,
 						capabilities, size,
 						metadata, metadata_size,
-						&app->err);
+						&features, &app->err);
 	if (!endpoint) {
 		error("Unable to register endpoint %s:%s: %s", app->sender,
 						path, strerror(-app->err));
-- 
2.51.1

