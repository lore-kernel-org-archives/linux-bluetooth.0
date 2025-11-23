Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2182D94A9
	for <linux-bluetooth@vger.kernel.org>; Sun, 23 Nov 2025 16:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763914656; cv=pass; b=tZGraL+eN9Ny15p67tnMCKk47nm9p81tOvv74zpUo1hF9jWkcudQpnT96W/ihNEFIOTYkBrNA2pY0h2xr8N1JGriwPgy238cseZzeVGX5SlWAzBgy8YzDuWs1OCXYHUFmtwP5KudNQLUvVAbP2pDK7laOfzUzgVZ8I352EJb0ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763914656; c=relaxed/simple;
	bh=+edoYo6A6Hq7kmuecoDOLdSV4sk+Z6/gB8+AcoiUVXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFEELJvnQCFEzLlMjfA+Pyo2+f8r99Aewiz9gFODmqjiIzgk6B41bvVoq1jUJjZNqFkgpvdQLgGHf6jhHFlfzuvUhVlEQ+gGROP/gEVSW89t2PrZrKx6R7a3vYxbQcaDSuKeXn7oM04NWnVSZCc5D3LF0XobLEvYAgdBvSyHh60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=mYmpESUB; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="mYmpESUB"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dDvHb0lT7z10LB;
	Sun, 23 Nov 2025 18:17:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763914651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZW0wYwApKFCamVBZvEiCZpBHiYv+lf0uflLK+IHb7ak=;
	b=mYmpESUB7ypvHiqaumqhzXJvTy9e7m8SgLJYhAGgUG66GUYTaM6iVu021cWsAyK2Drj/7f
	9g+5/tZgIhgHgv/pwLCaolKA4OP4sRd9/fxYK8D3vlZtWKQUZrzIMCLZR8Rmu24kX6EpOi
	VkCmzqungAGiBsUjkLAEY0iEvZ11N8Y=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763914651;
	b=cdCJbixhjCEeEcfuMQEb9k4pWxd29J9aK0aXm9/N6S0SrUjobylCsDKDGMYOP0hsBqQAGP
	j3AotsUCL0Tf6bwJYmrJbyOdhZw6qrASqE2IUGn69SspHycVcwT+JXiFLd+hRzqc6+BsFr
	8qckgYEXXxqbWCUjJjvTxb/1hIxz5kk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763914651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZW0wYwApKFCamVBZvEiCZpBHiYv+lf0uflLK+IHb7ak=;
	b=hdLaSZx2OwDcjuGGK5RCAHX1jqEdX53Q7t9PHmhFEHfApkKkaiG4sN/Ibli5d9MWD6vcgZ
	4YttHfqsCG1y/VBxWa2KH4jg5lEK7bq2hvpXy1ILjzFGL4gMuPkLTMoVo5CkxwUD2gCGCC
	498GYmxt+2G0O7VGh6TJqmVQ0Yn8BRU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 10/10] bap: add SupportedFeatures for MediaEndpoints
Date: Sun, 23 Nov 2025 18:17:15 +0200
Message-ID: <65982084a3541bc79f18db20bd0d9e4e9b6079ff.1763914558.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1763914558.git.pav@iki.fi>
References: <cover.1763914558.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Indicate TMAP & GMAP capabilities in SupportedFeatures.
---
 profiles/audio/bap.c | 76 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 17a040a71..ec75fb5ce 100644
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
@@ -444,6 +446,78 @@ static gboolean get_qos(const GDBusPropertyTable *property,
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
+static const struct {
+	const char *name;
+	bool (*probe)(struct bap_ep *ep, uint32_t data);
+	uint32_t data;
+} features[] = {
+	{ "tmap-cg", probe_tmap_role, BT_TMAP_ROLE_CG },
+	{ "tmap-ct", probe_tmap_role, BT_TMAP_ROLE_CT },
+	{ "tmap-ums", probe_tmap_role, BT_TMAP_ROLE_UMS },
+	{ "tmap-umr", probe_tmap_role, BT_TMAP_ROLE_UMR },
+	{ "tmap-bms", probe_tmap_role, BT_TMAP_ROLE_BMS },
+	{ "tmap-bmr", probe_tmap_role, BT_TMAP_ROLE_BMR },
+	{ "gmap-ugg", probe_gmap_role, BT_GMAP_ROLE_UGG },
+	{ "gmap-ugt", probe_gmap_role, BT_GMAP_ROLE_UGT },
+	{ "gmap-bgs", probe_gmap_role, BT_GMAP_ROLE_BGS },
+	{ "gmap-bgr", probe_gmap_role, BT_GMAP_ROLE_BGR },
+	{ "gmap-ugg-multiplex", probe_gmap_feature, BT_GMAP_UGG_MULTIPLEX },
+	{ "gmap-ugg-96kbps-source", probe_gmap_feature, BT_GMAP_UGG_96KBPS },
+	{ "gmap-ugg-multisink", probe_gmap_feature, BT_GMAP_UGG_MULTISINK },
+	{ "gmap-ugt-source", probe_gmap_feature, BT_GMAP_UGT_SOURCE },
+	{ "gmap-ugt-80kbps-source", probe_gmap_feature,
+						BT_GMAP_UGT_80KBPS_SOURCE },
+	{ "gmap-ugt-sink", probe_gmap_feature, BT_GMAP_UGT_SINK },
+	{ "gmap-ugt-64kbps-sink", probe_gmap_feature, BT_GMAP_UGT_64KBPS_SINK },
+	{ "gmap-ugt-multiplex", probe_gmap_feature, BT_GMAP_UGT_MULTIPLEX },
+	{ "gmap-ugt-multisink", probe_gmap_feature, BT_GMAP_UGT_MULTISINK },
+	{ "gmap-ugt-multisource", probe_gmap_feature, BT_GMAP_UGT_MULTISOURCE },
+	{ "gmap-bgs-96kbps", probe_gmap_feature, BT_GMAP_BGS_96KBPS },
+	{ "gmap-bgr-multisink", probe_gmap_feature, BT_GMAP_BGR_MULTISINK },
+	{ "gmap-bgr-multiplex", probe_gmap_feature, BT_GMAP_BGR_MULTIPLEX },
+};
+
+static gboolean supported_features(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct bap_ep *ep = data;
+	DBusMessageIter entry;
+	size_t i;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING_AS_STRING, &entry);
+
+	for (i = 0; i < ARRAY_SIZE(features); ++i)
+		if (features[i].probe(ep, features[i].data))
+			dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+							&features[i].name);
+
+	dbus_message_iter_close_container(iter, &entry);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable ep_properties[] = {
 	{ "UUID", "s", get_uuid, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
@@ -463,6 +537,8 @@ static const GDBusPropertyTable ep_properties[] = {
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "QoS", "a{sv}", get_qos, NULL, qos_exists,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "SupportedFeatures", "as", supported_features, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
-- 
2.51.1

