Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF511F936
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 14:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150640; cv=none; b=uiyya7QJRSmWdlhoID190uWis0bamODB2+QNkNgDRskK3+K/bWc/H+I3k5Qkz0oD6P7fcun9FDNlkQUmcYiKkQg603r24S2690KZQGuDGzbBBQ/uHQIYzyebkQndOCrU5y3YMK6WwF0Ph9QCyXjiX0Qdn9U9qO11Z7wQJGu41qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150640; c=relaxed/simple;
	bh=OiLLCNvAXstTt4KrVaCvT/AcrlhVSlHxzVjAsvl0Htg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z85A7CxeU+3Csvq/Km1m8J+Q7W6xRR4LMWoYyC7Wvp03a96TdyMkLLTG2QhiyALDQ9sE1Xlvu5nQiOhyHXMuUG0nZ9aoosxxPkyDKVCm1CXEyT6YcEXRHW49nOZa5VFHQpB8Re88gH2F1tZgtd+S2jF6oBBcqIPf61i4Fp2CCiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UY7Dhomf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UY7Dhomf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787150628;
	bh=OiLLCNvAXstTt4KrVaCvT/AcrlhVSlHxzVjAsvl0Htg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UY7Dhomf1s6xrYftMcqAd6EEjRxq4qnjp6cZ3mie/LzBGw2MCHS6ckUYcKffVRXio
	 2stVZL2DeVHZhXaD0Tl+nynbXUHxAy7Q1BQk8nCNltrQJtTz9EqAA3lebPFk/qCUd1
	 Tzo3PhMKca9tZghVlpKq+x6kLOycwwUGFX0gOUEj5LzfgLTBMJ/5w7T09fSALSJxiA
	 j7UrMDI2vEf8cglSGunEmtCGpYd3DFWyUfJNQ3HB0oKlrJw+o5rd6tI2jJfiroildf
	 VjjBEijWK/WLueoj1zya9Ks4hTKS5/3+ThYLp4aOK9JacImUY/1lzfepjm95ri2sBh
	 2nMPMlYuqCXfg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A94E617E0FC9
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 16:43:48 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 6/7] device: unify admin allowlist checks for device services
Date: Wed, 19 Aug 2026 16:43:36 +0200
Message-ID: <20260819144337.889893-7-frederic.danis@collabora.com>
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

Consolidate device-side admin policy handling into one coherent model so
incoming and outgoing A2DP behavior follows the configured allowlist
consistently.

Why:
- The initial profile-aware adapter mapping fixed role-inverted A2DP cases
  for some paths, but device-side service gating still used mixed criteria.
- Host-initiated Connect() could evaluate A2DP services with the wrong UUID
  perspective, leading to valid flows being blocked (or blocked flows being
  considered valid) under partial allowlists.

What changed:
- Use direct UUID allowlist checks for device service eligibility updates.
- Add A2DP role-aware mapping for device policy UUID selection:
  - a2dp-sink -> A2DP Source UUID (110a)
  - a2dp-source -> A2DP Sink UUID (110b)
- Apply the same policy UUID resolution in:
  - btd_device_all_services_allowed()
  - btd_device_update_allowed_services()

Result:
- Device-service policy decisions now align with intended local A2DP role
  semantics for both remote-initiated and host-initiated connection paths.
- Admin allowlist enforcement remains strict while eliminating the observed
  false block during host->remote A2DP connect attempts.

Assisted-by: GPT:GPT-5.3-Codex
---
 src/adapter.c |  6 +++---
 src/adapter.h |  3 +++
 src/device.c  | 35 +++++++++++++++++++++++++++++++----
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 0cc87f649..138c57800 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5403,7 +5403,7 @@ static const char *profile_allowlist_uuid(const struct btd_profile *profile)
 	return NULL;
 }
 
-static bool adapter_profile_is_allowed(struct btd_adapter *adapter,
+bool btd_adapter_is_profile_allowed(struct btd_adapter *adapter,
 					const struct btd_profile *profile)
 {
 	const char *uuid = profile_allowlist_uuid(profile);
@@ -5422,7 +5422,7 @@ static void probe_profile(struct btd_profile *profile, void *data)
 	if (profile->adapter_probe == NULL)
 		return;
 
-	if (!adapter_profile_is_allowed(adapter, profile)) {
+	if (!btd_adapter_is_profile_allowed(adapter, profile)) {
 		DBG("%s blocked by admin allowlist", profile->name);
 		return;
 	}
@@ -5447,7 +5447,7 @@ static void reapply_profile(struct btd_profile *profile, void *data)
 
 	active = g_slist_find(adapter->profiles, profile) != NULL;
 
-	if (adapter_profile_is_allowed(adapter, profile)) {
+	if (btd_adapter_is_profile_allowed(adapter, profile)) {
 		if (!active)
 			probe_profile(profile, adapter);
 		return;
diff --git a/src/adapter.h b/src/adapter.h
index a1c887c45..583168f4b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -27,6 +27,7 @@
 
 struct btd_adapter;
 struct btd_device;
+struct btd_profile;
 struct queue;
 
 struct btd_adapter *btd_adapter_get_default(void);
@@ -299,6 +300,8 @@ bool btd_adapter_set_allowed_uuids(struct btd_adapter *adapter,
 							struct queue *uuids);
 bool btd_adapter_is_uuid_allowed(struct btd_adapter *adapter,
 							const char *uuid_str);
+bool btd_adapter_is_profile_allowed(struct btd_adapter *adapter,
+					const struct btd_profile *profile);
 void btd_adapter_reapply_allowed_uuids(struct btd_adapter *adapter);
 
 void btd_adapter_load_conn_param(struct btd_adapter *adapter,
diff --git a/src/device.c b/src/device.c
index 65d84be56..c396372be 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2547,21 +2547,44 @@ static struct btd_service *find_connectable_service(struct btd_device *dev,
 	return NULL;
 }
 
+static const char *service_policy_uuid(const struct btd_profile *profile)
+{
+	if (!profile)
+		return NULL;
+
+	/*
+	 * For A2DP device services, apply admin policy by local role UUID:
+	 * - a2dp-sink profile is local source role  (110a)
+	 * - a2dp-source profile is local sink role  (110b)
+	 */
+	if (profile->name) {
+		if (!strcmp(profile->name, "a2dp-sink"))
+			return A2DP_SOURCE_UUID;
+
+		if (!strcmp(profile->name, "a2dp-source"))
+			return A2DP_SINK_UUID;
+	}
+
+	return profile->remote_uuid;
+}
+
 bool btd_device_all_services_allowed(struct btd_device *dev)
 {
 	GSList *l;
 	struct btd_adapter *adapter = dev->adapter;
 	struct btd_service *service;
 	struct btd_profile *profile;
+	const char *uuid;
 
 	for (l = dev->services; l != NULL; l = g_slist_next(l)) {
 		service = l->data;
 		profile = btd_service_get_profile(service);
+		uuid = service_policy_uuid(profile);
 
-		if (!profile || !profile->auto_connect)
+		if (!profile || !profile->auto_connect || !uuid)
 			continue;
 
-		if (!btd_adapter_is_uuid_allowed(adapter, profile->remote_uuid))
+		if (!btd_adapter_is_uuid_allowed(adapter, uuid))
 			return false;
 	}
 
@@ -2575,6 +2598,7 @@ void btd_device_update_allowed_services(struct btd_device *dev)
 	struct btd_profile *profile;
 	GSList *l;
 	bool is_allowed;
+	const char *uuid;
 	char addr[18];
 
 	/* If service discovery is ongoing, let the service discovery complete
@@ -2590,9 +2614,12 @@ void btd_device_update_allowed_services(struct btd_device *dev)
 	for (l = dev->services; l != NULL; l = g_slist_next(l)) {
 		service = l->data;
 		profile = btd_service_get_profile(service);
+		uuid = service_policy_uuid(profile);
+
+		if (!profile || !uuid)
+			continue;
 
-		is_allowed = btd_adapter_is_uuid_allowed(adapter,
-							profile->remote_uuid);
+		is_allowed = btd_adapter_is_uuid_allowed(adapter, uuid);
 		btd_service_set_allowed(service, is_allowed);
 	}
 }
-- 
2.43.0

