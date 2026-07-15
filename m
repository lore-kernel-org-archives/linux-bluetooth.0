Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC743E5A23
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106148; cv=none; b=ZxMLaqOqerQNEiallf2kng5iVKrf77hemHoslmi8yRdwQbH0iPX+xQnO4ui8Wo7MbBz1+xiXUWAUm6OgnsTeKyOA1sJ99XxI9A0oI88ygokG2p+6og/Hoh2ffnd1zfY5A2mii7MnK2b9bheyGSNYo2gtLxTR0CrLjHASSGK9EyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106148; c=relaxed/simple;
	bh=6p7bEcRujNO63ybv+ISyZMUEfXbknkEsIY0Sj3z4Gw4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iezkd2kbnhtR/dLridVN2uEcdCwruLzBT/2Na8h2Kc7U+TORqu/9bx20bFf3BJthGVm04z6mbEYD6SiQn4MggLOWRJ0gd/BiSwe/OSt6OwQSqSYmoSwufEm1C+Rj/cY63B0IMI+pxknYy7jSxjfJ5T0qbKrZwYiHWT/v7RlYqOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JeaSc7CW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JeaSc7CW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784106134;
	bh=6p7bEcRujNO63ybv+ISyZMUEfXbknkEsIY0Sj3z4Gw4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=JeaSc7CWhmTrCJK5pSBPMo7QVwRmMcu6qK0bhNQ1agvhxZ5o3sCKbhxUQIU3+E+Db
	 Grn6p8BQBsfWtet1XNrZFC8F27ZFno4rt+hrOQ64u/hMlNpx9HDF+z6R8tkdOS9jKQ
	 isM92UxvIYCSDL52UZITjv4wKNBDDB/SNxjYllaySf1/at7sxOFzDnSf2Lkc6qUPDG
	 LQ2Agrmo/PoygNmGz3HK7/n6NatyhFHSL65GimLAK0Yq60E2wzLuCnJi7t95lAG9iI
	 EDV/E1Diy1OeGIJ/xKVyHEiMaiZfCTbUqtdIzlaSzHpR+ZJ6mzuS22WIMZcBKY+m9n
	 9deaJ4+xSQDdw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B254B17E0E2C
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 11:02:14 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/8] src/adapter: enforce allowlist for local services
Date: Wed, 15 Jul 2026 11:02:02 +0200
Message-ID: <20260715090206.212130-5-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715090206.212130-1-frederic.danis@collabora.com>
References: <20260715090206.212130-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Apply admin allowlist to adapter/server service startup and
registration, and reapply policy dynamically when allowlist changes.

- Gate adapter profile probe by allowlist-derived UUID policy
- Reapply active adapter profiles on allowlist updates (stop
  disallowed, start newly allowed)
- Block SDP service registration when UUID is not allowed
- Reapply existing local SDP registrations at runtime by removing
  services that become disallowed

Assisted-by: GPT:GPT-5.3-Codex
---
 src/adapter.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h |   1 +
 2 files changed, 140 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 4ffa32a52..843fc7d76 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1346,6 +1346,7 @@ done:
 
 int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec)
 {
+	char *svc_uuid;
 	int ret;
 
 	/*
@@ -1357,6 +1358,18 @@ int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec)
 
 	DBG("%s", adapter->path);
 
+	svc_uuid = bt_uuid2string(&rec->svclass);
+	if (!svc_uuid)
+		return -ENOMEM;
+
+	if (!btd_adapter_is_uuid_allowed(adapter, svc_uuid)) {
+		DBG("Service %s blocked by admin allowlist", svc_uuid);
+		free(svc_uuid);
+		return -EPERM;
+	}
+
+	free(svc_uuid);
+
 	ret = add_record_to_server(&adapter->bdaddr, rec);
 	if (ret < 0)
 		return ret;
@@ -5201,6 +5214,70 @@ static void load_drivers(struct btd_adapter *adapter)
 		probe_driver(adapter, l->data);
 }
 
+struct profile_allowlist_map {
+	const char *name;
+	const char *uuid;
+	bool use_remote_uuid;
+};
+
+/*
+ * Adapter server policy UUID defaults to local_uuid when available.
+ * Profiles listed below are exceptions where adapter-side server behavior
+ * needs a different UUID source (e.g. A2DP source/sink role inversion) or
+ * where server policy is derived from the profile remote_uuid.
+ */
+static const struct profile_allowlist_map profile_allowlist_map[] = {
+	{ "a2dp-source", A2DP_SINK_UUID, false },
+	{ "a2dp-sink", A2DP_SOURCE_UUID, false },
+	{ "audio-avrcp-target", NULL, true },
+	{ "avrcp-controller", NULL, true },
+	{ "vcp", NULL, true },
+	{ "micp", NULL, true },
+	{ "ccp", NULL, true },
+	{ "gmap", NULL, true },
+	{ "tmap", NULL, true },
+	{ "bass", NULL, true },
+	{ "bap", NULL, true },
+	{ "mcp-gmcs", NULL, true },
+};
+
+static const char *profile_allowlist_uuid(const struct btd_profile *profile)
+{
+	size_t i;
+
+	if (profile->local_uuid)
+		return profile->local_uuid;
+
+	if (!profile->name)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(profile_allowlist_map); i++) {
+		const struct profile_allowlist_map *entry =
+						&profile_allowlist_map[i];
+
+		if (strcmp(profile->name, entry->name))
+			continue;
+
+		if (entry->use_remote_uuid)
+			return profile->remote_uuid;
+
+		return entry->uuid;
+	}
+
+	return NULL;
+}
+
+static bool adapter_profile_is_allowed(struct btd_adapter *adapter,
+					const struct btd_profile *profile)
+{
+	const char *uuid = profile_allowlist_uuid(profile);
+
+	if (!uuid)
+		return true;
+
+	return btd_adapter_is_uuid_allowed(adapter, uuid);
+}
+
 static void probe_profile(struct btd_profile *profile, void *data)
 {
 	struct btd_adapter *adapter = data;
@@ -5209,6 +5286,11 @@ static void probe_profile(struct btd_profile *profile, void *data)
 	if (profile->adapter_probe == NULL)
 		return;
 
+	if (!adapter_profile_is_allowed(adapter, profile)) {
+		DBG("%s blocked by admin allowlist", profile->name);
+		return;
+	}
+
 	err = profile->adapter_probe(profile, adapter);
 	if (err < 0) {
 		btd_error(adapter->dev_id, "%s: %s (%d)", profile->name,
@@ -5219,6 +5301,63 @@ static void probe_profile(struct btd_profile *profile, void *data)
 	adapter->profiles = g_slist_prepend(adapter->profiles, profile);
 }
 
+static void reapply_profile(struct btd_profile *profile, void *data)
+{
+	struct btd_adapter *adapter = data;
+	bool active;
+
+	if (profile->adapter_probe == NULL)
+		return;
+
+	active = g_slist_find(adapter->profiles, profile) != NULL;
+
+	if (adapter_profile_is_allowed(adapter, profile)) {
+		if (!active)
+			probe_profile(profile, adapter);
+		return;
+	}
+
+	if (!active)
+		return;
+
+	adapter->profiles = g_slist_remove(adapter->profiles, profile);
+
+	if (profile->adapter_remove)
+		profile->adapter_remove(profile, adapter);
+}
+
+static void reapply_adapter_services(struct btd_adapter *adapter)
+{
+	sdp_list_t *l;
+
+	for (l = adapter->services; l != NULL;) {
+		sdp_list_t *next = l->next;
+		sdp_record_t *rec = l->data;
+		char *svc_uuid;
+
+		svc_uuid = bt_uuid2string(&rec->svclass);
+		if (!svc_uuid) {
+			l = next;
+			continue;
+		}
+
+		if (!btd_adapter_is_uuid_allowed(adapter, svc_uuid))
+			adapter_service_remove(adapter, rec->handle);
+
+		free(svc_uuid);
+		l = next;
+	}
+}
+
+void btd_adapter_reapply_allowed_uuids(struct btd_adapter *adapter)
+{
+	if (!adapter || !adapter->initialized)
+		return;
+
+	btd_profile_foreach(reapply_profile, adapter);
+	reapply_adapter_services(adapter);
+}
+
 void adapter_add_profile(struct btd_adapter *adapter, gpointer p)
 {
 	struct btd_profile *profile = p;
diff --git a/src/adapter.h b/src/adapter.h
index 4e07f71ad..cec528c56 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -295,6 +295,7 @@ bool btd_adapter_set_allowed_uuids(struct btd_adapter *adapter,
 							struct queue *uuids);
 bool btd_adapter_is_uuid_allowed(struct btd_adapter *adapter,
 							const char *uuid_str);
+void btd_adapter_reapply_allowed_uuids(struct btd_adapter *adapter);
 
 void btd_adapter_load_conn_param(struct btd_adapter *adapter,
 				const bdaddr_t *peer, uint8_t bdaddr_type,
-- 
2.43.0

