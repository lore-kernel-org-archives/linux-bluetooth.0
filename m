Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D88F3B8950
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150637; cv=none; b=ctytg7241ris8wVEHfAmEIhQrIEgqpDBEIliZBQaLcT7sIWEXgcozM3X7Cz0LQr3nG06esW112o4BXnWgY+aghLpph1AL41j4nAzgSK8VTOuFmlmpnUqmLGGEfEeIhDj+hwIff9CX8G0Cr32iuaep5dKHoMHRUQwg4ErN/njVdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150637; c=relaxed/simple;
	bh=0Xz3FZuHEj6NUFExMB9SXcT/0h38u9WxFq7/ZI0Q0Gg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOUbTOyWsHx/IT+xItaSbp0s7AuEPUAzgo5OHF/s5YZKJUEaLt39UZBwhq7T4VFGsUUrZB9/udre62HV2bREFn7dOEaa4TE8t8IqUdJunWYlrbgEI2kLgFBXGo31rZlyhMmsT1ZVk7kkRFB0On5sda6YZ6+9h3RAyexdHayQ/Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cgf0ogkV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cgf0ogkV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787150628;
	bh=0Xz3FZuHEj6NUFExMB9SXcT/0h38u9WxFq7/ZI0Q0Gg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cgf0ogkV1CKB2eYiP3Eid4OZQvvTO7CQWVlUCn37LtLem4YwwsVSN3VKGvIUvxHze
	 2KauyQz1YANNjpCJjgE8Nh7kcniHwDJTGuwd8JzCBZENzjRtJJ1XBu0li5Z5JfFp6e
	 8rHBDc/Yl9a09IBSrnLVci8RVp201CX1TGImvNEfDi1lAnUpnO8KBsOQnGFpMotvsu
	 Hr8d84RJvYVWWMozP7bh0KjodCxFOTMalqepqQwZa+aNLIbQtkVuxLlx+h/gTKQaz3
	 x3wbA0e7ptqjgkaf31nTrtWI9XOwk5mA7PNhgDUSU0pIBfvu/Bp/14Tg/Rlz4ZkoGh
	 bFw1lhg8DWyZA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E300617E0892
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 16:43:47 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/7] src/adapter: enforce allowlist for local services
Date: Wed, 19 Aug 2026 16:43:33 +0200
Message-ID: <20260819144337.889893-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260819144337.889893-1-frederic.danis@collabora.com>
References: <20260819144337.889893-1-frederic.danis@collabora.com>
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
- Map both a2dp-source and a2dp-sink admin policy checks to
  ADVANCED_AUDIO_UUID (0x110d). This keeps A2DP profile infrastructure
  enabled when the A2DP class UUID is allowed, while specific local
  Audio Source/Sink records remain filtered by their own UUID allowlist
  checks

Assisted-by: GPT:GPT-5.3-Codex
---
 src/adapter.c | 141 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h |   1 +
 2 files changed, 142 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index c21b3e7fb..0cc87f649 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1359,6 +1359,7 @@ done:
 
 int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec)
 {
+	char *svc_uuid;
 	int ret;
 
 	/*
@@ -1370,6 +1371,18 @@ int adapter_service_add(struct btd_adapter *adapter, sdp_record_t *rec)
 
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
@@ -5335,6 +5348,72 @@ static void load_drivers(struct btd_adapter *adapter)
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
+ * Profiles listed below are exceptions.
+ *
+ * A2DP profiles map to ADVANCED_AUDIO_UUID so profile probe gating matches
+ * the A2DP profile class (0x110d), while adapter service registration/removal
+ * still filters specific Source/Sink records by their own UUIDs.
+ */
+static const struct profile_allowlist_map profile_allowlist_map[] = {
+	{ "a2dp-source", ADVANCED_AUDIO_UUID, false },
+	{ "a2dp-sink", ADVANCED_AUDIO_UUID, false },
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
@@ -5343,6 +5422,11 @@ static void probe_profile(struct btd_profile *profile, void *data)
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
@@ -5353,6 +5437,63 @@ static void probe_profile(struct btd_profile *profile, void *data)
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
index a9e1bbf66..a1c887c45 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -299,6 +299,7 @@ bool btd_adapter_set_allowed_uuids(struct btd_adapter *adapter,
 							struct queue *uuids);
 bool btd_adapter_is_uuid_allowed(struct btd_adapter *adapter,
 							const char *uuid_str);
+void btd_adapter_reapply_allowed_uuids(struct btd_adapter *adapter);
 
 void btd_adapter_load_conn_param(struct btd_adapter *adapter,
 				const bdaddr_t *peer, uint8_t bdaddr_type,
-- 
2.43.0

