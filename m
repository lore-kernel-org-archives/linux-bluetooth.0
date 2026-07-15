Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22DD3E3D8F
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106153; cv=none; b=d3Np03qCT5xgtK0fMCZ1zn5uOuZPL+XQm7fxEFLfUiizhlmoTYiHYv2zW3+fBmiRklhFKzyu9W3r+ahqA2BLtBGbmj1M8IWTVUfjZzpl8DBzfo0b+wERy/VQV+iHf7ynvW6L6gHu84sQ2fKSIehGYnOGa2gj4yP+J4Sd9D1sBDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106153; c=relaxed/simple;
	bh=NkPIlqmTjrYTAKgiosoQsWPjqh2tSHtVwml9mH/BWS0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXrJHSPvWka9B6wB7DxawP32CeCjzA4c78JQISefuqi+yYku+gHcT9szu0r3w7SsVJgBKb1E6ewiSresstfKh5SP8cHBkSJjXCh1A7gzDNF1U5jBSWTC84m7F+ooOjz+87QidSXyRDw4kgZHiWqCeajI9fTGLX4DzW7zMLAB0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pRJHpOlU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pRJHpOlU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784106135;
	bh=NkPIlqmTjrYTAKgiosoQsWPjqh2tSHtVwml9mH/BWS0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pRJHpOlUjFMT7FCvZnDF5eWT3FL2gAJHLhWIp6VT60xayd0TgiIZTdNoPgph0nDwo
	 mGY3DRmRb8po2D9ow3uwddaIwCls2sHxHZCM3KqN3z6iUTi8l+EeVZIrwdsrPUb4od
	 zPXc/4jRMwODZZsKUOhjXoK80Xboq/Ex96zzpqXV0PewHZD/ghxMwGW1YsisSkRWcx
	 ptPceetMrNGA2XvHfbKKWETg08r6V6md9nBh0VjbErsRo7LrUls7EL+f5AknbbbD6N
	 hHExUCGmD2uDvRO4nLelv3Q+ls6KcyVON7SAAh8u1duf4I9Bfrs/qDx+bXsnB0p9i6
	 2Jt7PMyYXrwnA==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B7AE217E0FB0
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 11:02:15 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 8/8] device: apply profile-aware admin allowlist checks for device services
Date: Wed, 15 Jul 2026 11:02:06 +0200
Message-ID: <20260715090206.212130-9-frederic.danis@collabora.com>
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

Use adapter profile-aware policy mapping when evaluating device service
allowance, so device-side filtering matches adapter-side allowlist
semantics.

This updates device policy checks to call
btd_adapter_is_profile_allowed() instead of directly matching
profile->remote_uuid. It fixes A2DP role-inverted cases where allowing
source UUID policy should still permit connecting to the corresponding
remote sink profile.

Changes:
- Export profile-aware allowlist helper in adapter policy API
- Reuse that helper in device service allowance evaluation and refresh
  paths

Behavioral effect:
- admin allowlist decisions remain strict, but now consistent across
  adapter profile probing and device connection filtering.

Assisted-by: GPT:GPT-5.3-Codex
---
 src/adapter.c | 6 +++---
 src/adapter.h | 3 +++
 src/device.c  | 5 ++---
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 843fc7d76..e5b09b5e8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5267,7 +5267,7 @@ static const char *profile_allowlist_uuid(const struct btd_profile *profile)
 	return NULL;
 }
 
-static bool adapter_profile_is_allowed(struct btd_adapter *adapter,
+bool btd_adapter_is_profile_allowed(struct btd_adapter *adapter,
 					const struct btd_profile *profile)
 {
 	const char *uuid = profile_allowlist_uuid(profile);
@@ -5286,7 +5286,7 @@ static void probe_profile(struct btd_profile *profile, void *data)
 	if (profile->adapter_probe == NULL)
 		return;
 
-	if (!adapter_profile_is_allowed(adapter, profile)) {
+	if (!btd_adapter_is_profile_allowed(adapter, profile)) {
 		DBG("%s blocked by admin allowlist", profile->name);
 		return;
 	}
@@ -5311,7 +5311,7 @@ static void reapply_profile(struct btd_profile *profile, void *data)
 
 	active = g_slist_find(adapter->profiles, profile) != NULL;
 
-	if (adapter_profile_is_allowed(adapter, profile)) {
+	if (btd_adapter_is_profile_allowed(adapter, profile)) {
 		if (!active)
 			probe_profile(profile, adapter);
 		return;
diff --git a/src/adapter.h b/src/adapter.h
index cec528c56..b5faf611c 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -27,6 +27,7 @@
 
 struct btd_adapter;
 struct btd_device;
+struct btd_profile;
 struct queue;
 
 struct btd_adapter *btd_adapter_get_default(void);
@@ -295,6 +296,8 @@ bool btd_adapter_set_allowed_uuids(struct btd_adapter *adapter,
 							struct queue *uuids);
 bool btd_adapter_is_uuid_allowed(struct btd_adapter *adapter,
 							const char *uuid_str);
+bool btd_adapter_is_profile_allowed(struct btd_adapter *adapter,
+					const struct btd_profile *profile);
 void btd_adapter_reapply_allowed_uuids(struct btd_adapter *adapter);
 
 void btd_adapter_load_conn_param(struct btd_adapter *adapter,
diff --git a/src/device.c b/src/device.c
index 65d84be56..773cde35a 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2561,7 +2561,7 @@ bool btd_device_all_services_allowed(struct btd_device *dev)
 		if (!profile || !profile->auto_connect)
 			continue;
 
-		if (!btd_adapter_is_uuid_allowed(adapter, profile->remote_uuid))
+		if (!btd_adapter_is_profile_allowed(adapter, profile))
 			return false;
 	}
 
@@ -2591,8 +2591,7 @@ void btd_device_update_allowed_services(struct btd_device *dev)
 		service = l->data;
 		profile = btd_service_get_profile(service);
 
-		is_allowed = btd_adapter_is_uuid_allowed(adapter,
-							profile->remote_uuid);
+		is_allowed = btd_adapter_is_profile_allowed(adapter, profile);
 		btd_service_set_allowed(service, is_allowed);
 	}
 }
-- 
2.43.0

