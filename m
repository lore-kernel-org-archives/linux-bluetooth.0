Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D935435C693
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065753; cv=none; b=KCBVQExLTtn/TwMMDmAoSMsgxbXIYy6lETVdXCCWrbexPWmITccOcsziLJ14vK3QaMYEX5v/e4Y+b/dDugV1HmM28P5GYFuYgs4XB+GLW8TCU5yt+OTZJORVIYWpc76oiFscE0tiM17lfORJ8bKX3IIbVnxFXq+kF8/LFIYWrhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065753; c=relaxed/simple;
	bh=PON1pscLKJ4JW2IeHs/P6UNzFtK9jlaLapGXoxeo2vU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lbb35xipZl38QCJjZik1/inD3Dx2ZjHMexAHaCgzXwoUN6to44iAPFQUkZFADjBa6ZaA8///Mkbn8bvhSjNO1OwR0BAquNjQj3FFhrZRIqUkmj9sR61adF+r2CAvCsjVUmBAdhtMRXUmoJYpJBNI0b4yxsG0JCsRUFMEl5qIMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvmxYUWw; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvmxYUWw"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e4d9197so150945e0c.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789065749; x=1789670549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vvud6rVWlBreblggXpzGDwFOmcJ79IuVOiu/pyFMAs0=;
        b=jvmxYUWwxvoFkOmqQHngmJqMkOA71X3AdkhxCz4MnF8LAJFPyuLICzDIdRtbfXNJGH
         1rU7yzs1gA1D/IPJbtOAwfpw9rLLM23Q/tDHG4Nbb/07gOBx5xoJT6zPbHET6Mjyzs8c
         dkDWqcX82JpUpQq6Vljr7k7yIfbx6WBuWtgQsnmWe1jRUPUZCM3ZBQ79+JzpzDZRzKgo
         lhBIj28JSiTMSgkuadKYmhyDm9MjLCYohZeiztrtxp9+PHJeAZwCt3rU6KUMNJemEHnp
         2wioLA/EhrZr7Sq3aoG5VKm+tUcEr25XEmfoaj42HZE2YmJZVhZsy4qB6MNJo62hPqUp
         8h4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789065749; x=1789670549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vvud6rVWlBreblggXpzGDwFOmcJ79IuVOiu/pyFMAs0=;
        b=mKPy+rMpGK2P/qqB3tljGdtfMgtAFAhFYgZq+HSNnHLcMB2NglGMysrfyZvjlGr9Za
         5LPoFxlbSxW9pfeEcPCbYVJfzDBUP50eLGlWDLyW1Ps6eGuugEDevi/sfCtWkCqlT5ha
         957ygVZdU43inwmZez/xOyFEceCqLDmjcmIIrU7mGe/fGc/uU6zFy8WLBggzxQAhgQ6F
         9EOrqnCYiRYPlcEQOHFzM0aRZrPupjqTIm8pczHh6vjkLwTXKaUB/1HWpevx674a1eq9
         AHRlC7IOPOjN3JwQWCkbui+bV3djJ2IhiW2wQFmbItwWxYw17weGMQC+XD+k+2rMLl1k
         0gXw==
X-Gm-Message-State: AFuF++kW37un5nCEMOKzRK0wPz1exz7MGqKsXiiW9VvBRArUPkXWlRWd
	yadjSNA30EQFkt00XYhUoZnu6PRipRvKgzCnLJzc+VGjZq9GE5GRaWXkpO4hs0h9
X-Gm-Gg: AYBFou2idloIfPO5XfPWW1l8BzFWTmQGX7yQOi3LrF9Mda1Nv9liXGyjr7Qmi0jdVSc
	9NcFHHtTI3D7XQHe4ogZbvAPhLcFr8yFr1eZqVUE1erWHW8jTtRyKzA7G62inCKT8B0uAU7IKuX
	5AFc0rLz7IZ0TlMaR5zVx8E82BN2x83DB+njMCh632s00bpVrdDDeG/xMbXv97gVFUToLBdQUsl
	0ADycmnXs07x0domrorLCPC5u3JwIzh0a99ruMcpXPam4rX48SVY/kLmcu89iVl+9NH1gaj35yV
	lrcZ6Ga1/OQJDbvRjZGTyCmuNL5pioKGuPVW+yULBFGakdiRUz6tVxLuoLp6fVmk1BWMw3R3KUV
	78Bdw9t3fQMmO/jsXohVLGE7+JkG1lPkcyYmPRsBDb6SSOumtFW30BSfGlWsW12GVumrOsf8Lxn
	1IDs/QK7pH5mucnYWsWPBBqqt0S37og8WHpdFscBZe4l4HL16nM5pfuaMlKIM71VJuIbyPCKQbo
	KBt/HoM9yUvtcZOoLC7JLhrC0kHWe2FWCWKjTmiS/wERAiBOY+wQNO1/SLWruxKvnlwZyNW1zXz
X-Received: by 2002:a05:6122:4894:b0:5c8:c5f:e8fa with SMTP id 71dfb90a1353d-5c846256c9emr643574e0c.4.1789065748772;
        Thu, 10 Sep 2026 11:42:28 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c8470ae7dcsm222256e0c.4.2026.09.10.11.42.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 11:42:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/4] adapter: Unify the A2DP admin allowlist UUID mapping
Date: Thu, 10 Sep 2026 14:42:14 -0400
Message-ID: <20260910184216.1601639-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910184216.1601639-1-luiz.dentz@gmail.com>
References: <20260910184216.1601639-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The allowlist enforcement added across the adapter, device and A2DP
layers ended up using three different UUIDs for the same two profiles:
adapter.c mapped both a2dp-source and a2dp-sink to ADVANCED_AUDIO_UUID
(0x110d), while device.c and a2dp.c mapped them to the local role UUIDs
0x110a and 0x110b. An allowlist containing only 0x110a therefore blocked
the a2dp-sink adapter probe outright, so the finer grained SEP checks in
a2dp.c never ran.

Add btd_profile_get_policy_uuid() as the single place resolving a
profile to the UUID of the local service it provides. btd_profile names
and remote_uuid describe the remote role, so the A2DP profiles are
inverted there: "a2dp-source" registers the local Sink server and
"a2dp-sink" registers the local Source server. This matches what
device.c and a2dp.c already do.

Note that allowlisting 0x110d alone no longer enables A2DP; the local
role UUIDs 0x110a and/or 0x110b have to be listed.

This also drops the hardcoded profile name table in adapter.c. Every
entry but the two A2DP ones just returned profile->remote_uuid, and any
profile without a local_uuid that was missing from the table resolved to
NULL, i.e. was allowed unconditionally regardless of the allowlist.

Assisted-by: opencode:claude-opus-5
---
 src/adapter.c | 49 +------------------------------------------------
 src/device.c  | 25 ++-----------------------
 src/profile.c | 24 ++++++++++++++++++++++++
 src/profile.h |  7 +++++++
 4 files changed, 34 insertions(+), 71 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 157d7392d32c..fc734424be07 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5353,59 +5353,12 @@ static void load_drivers(struct btd_adapter *adapter)
 		probe_driver(adapter, l->data);
 }
 
-struct profile_allowlist_map {
-	const char *name;
-	const char *uuid;
-	bool use_remote_uuid;
-};
-
-/*
- * Adapter server policy UUID defaults to local_uuid when available.
- * Profiles listed below are exceptions.
- *
- * A2DP profiles map to ADVANCED_AUDIO_UUID so profile probe gating matches
- * the A2DP profile class (0x110d), while adapter service registration/removal
- * still filters specific Source/Sink records by their own UUIDs.
- */
-static const struct profile_allowlist_map profile_allowlist_map[] = {
-	{ "a2dp-source", ADVANCED_AUDIO_UUID, false },
-	{ "a2dp-sink", ADVANCED_AUDIO_UUID, false },
-	{ "audio-avrcp-target", NULL, true },
-	{ "avrcp-controller", NULL, true },
-	{ "vcp", NULL, true },
-	{ "micp", NULL, true },
-	{ "ccp", NULL, true },
-	{ "gmap", NULL, true },
-	{ "tmap", NULL, true },
-	{ "bass", NULL, true },
-	{ "bap", NULL, true },
-	{ "mcp-gmcs", NULL, true },
-};
-
 static const char *profile_allowlist_uuid(const struct btd_profile *profile)
 {
-	size_t i;
-
 	if (profile->local_uuid)
 		return profile->local_uuid;
 
-	if (!profile->name)
-		return NULL;
-
-	for (i = 0; i < ARRAY_SIZE(profile_allowlist_map); i++) {
-		const struct profile_allowlist_map *entry =
-						&profile_allowlist_map[i];
-
-		if (strcmp(profile->name, entry->name))
-			continue;
-
-		if (entry->use_remote_uuid)
-			return profile->remote_uuid;
-
-		return entry->uuid;
-	}
-
-	return NULL;
+	return btd_profile_get_policy_uuid(profile);
 }
 
 bool btd_adapter_is_profile_allowed(struct btd_adapter *adapter,
diff --git a/src/device.c b/src/device.c
index 8da576ec5932..ec74c44ac4aa 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2547,27 +2547,6 @@ static struct btd_service *find_connectable_service(struct btd_device *dev,
 	return NULL;
 }
 
-static const char *service_policy_uuid(const struct btd_profile *profile)
-{
-	if (!profile)
-		return NULL;
-
-	/*
-	 * For A2DP device services, apply admin policy by local role UUID:
-	 * - a2dp-sink profile is local source role  (110a)
-	 * - a2dp-source profile is local sink role  (110b)
-	 */
-	if (profile->name) {
-		if (!strcmp(profile->name, "a2dp-sink"))
-			return A2DP_SOURCE_UUID;
-
-		if (!strcmp(profile->name, "a2dp-source"))
-			return A2DP_SINK_UUID;
-	}
-
-	return profile->remote_uuid;
-}
-
 bool btd_device_all_services_allowed(struct btd_device *dev)
 {
 	GSList *l;
@@ -2579,7 +2558,7 @@ bool btd_device_all_services_allowed(struct btd_device *dev)
 	for (l = dev->services; l != NULL; l = g_slist_next(l)) {
 		service = l->data;
 		profile = btd_service_get_profile(service);
-		uuid = service_policy_uuid(profile);
+		uuid = btd_profile_get_policy_uuid(profile);
 
 		if (!profile || !profile->auto_connect || !uuid)
 			continue;
@@ -2614,7 +2593,7 @@ void btd_device_update_allowed_services(struct btd_device *dev)
 	for (l = dev->services; l != NULL; l = g_slist_next(l)) {
 		service = l->data;
 		profile = btd_service_get_profile(service);
-		uuid = service_policy_uuid(profile);
+		uuid = btd_profile_get_policy_uuid(profile);
 
 		if (!profile || !uuid)
 			continue;
diff --git a/src/profile.c b/src/profile.c
index 97fffe9b4d5c..e5b1cdfc5d33 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -16,6 +16,7 @@
 #include <stdbool.h>
 #include <stdint.h>
 #include <stdlib.h>
+#include <string.h>
 #include <errno.h>
 
 #include <glib.h>
@@ -753,6 +754,29 @@ void btd_profile_foreach(void (*func)(struct btd_profile *p, void *data),
 	}
 }
 
+const char *btd_profile_get_policy_uuid(const struct btd_profile *profile)
+{
+	if (!profile)
+		return NULL;
+
+	/*
+	 * The admin allowlist is expressed in terms of the services the local
+	 * adapter exposes, while btd_profile names and remote_uuid describe
+	 * the remote role. The A2DP profiles therefore have to be inverted:
+	 * the "a2dp-source" profile drives the local Sink server and the
+	 * "a2dp-sink" profile drives the local Source server.
+	 */
+	if (profile->name) {
+		if (!strcmp(profile->name, "a2dp-source"))
+			return A2DP_SINK_UUID;
+
+		if (!strcmp(profile->name, "a2dp-sink"))
+			return A2DP_SOURCE_UUID;
+	}
+
+	return profile->remote_uuid;
+}
+
 static struct btd_profile *btd_profile_find_uuid(const char *uuid)
 {
 	GSList *l, *next;
diff --git a/src/profile.h b/src/profile.h
index 04a99528b4be..270f09ea2b96 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -84,6 +84,13 @@ struct btd_profile {
 void btd_profile_foreach(void (*func)(struct btd_profile *p, void *data),
 								void *data);
 
+/*
+ * Return the UUID of the local service a profile provides, for use by the
+ * admin policy allowlist. Returns NULL when the profile has no service to
+ * match against.
+ */
+const char *btd_profile_get_policy_uuid(const struct btd_profile *profile);
+
 int btd_profile_register(struct btd_profile *profile);
 void btd_profile_unregister(struct btd_profile *profile);
 
-- 
2.55.0

