Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01402D9EF4
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 20:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764360173; cv=pass; b=J+4WwjOQIxV6Sp0kw9LQxc77UrYZwaGnN7xSTAMzc4IYGjwkX2CH/6WwBbSooEISOCGbF/ibvhM1+CX9aaIy3zSVLFt+1ZpLB624xFVC67CgnzR2/q+IFNDbUQ9d6hlnAwONWoeJ3BGmN6Eh4rk8vQckSHSzPrsowUBvZvBZoWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764360173; c=relaxed/simple;
	bh=qfec75MjKhDMTt2+bLohDDFPAvefCeici+INMYHStKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uYxGXFxkNKnd2HkEdiSzxqKliBkbRJjF4RydAaavHMkOLlG6ROYuIONlsf/Ajd8XY446ztNE9eNBTzR0T6rdfWXygjVJvfVcmlMR/rdEHkrYzujKyk9f694wF6CPiDk8lW4p8PCSa3ZC4xropLsyN6DTcq6eWcHWrbqXCSbnlnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=REUy+NPR; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="REUy+NPR"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dJ4351ClNz10Cm;
	Fri, 28 Nov 2025 22:02:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764360161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k727lEht4jQzltEzHGowh/NS4fNidJsZ2orgr9I3jfk=;
	b=REUy+NPReZSXUCh1gx5gNnfi4RubvO31i69jFh/ObyWGRcAZTTUEvH7dn0/H/4d5Z7vBNu
	amJXb3EiSzDn1vJgxvuZvIPYfColRzoW+t46nrm1x5oO6YElToSBZEs5NvZjqeNvd3F1eq
	/SI/V/FylebtSawvsN/2oNLP+gSRMig=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764360161;
	b=V4ziNmPsAVdmTk+kI+SGJhMnIf3CaNZG8vStNhkWPSRemdZfBcUzan33RJFWTTdghtcgrn
	gfDG6CyzuXM1igloOtBq047G1RS57W5IPwdXqu0DzCY+oCt4R3nqLFKzsbGJsuC9cZVKj+
	OmLUC2VJWVLLPHzK3Hmb4AnQ5ku9jAo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764360161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k727lEht4jQzltEzHGowh/NS4fNidJsZ2orgr9I3jfk=;
	b=r0sBSWHuOZgB3Qz/QREk6A7wIRq3NWy9MLpkxIs/kLfbvspp0j3WBtf77yHd+dtsA7DD6I
	0Xswu/yaWeikXeEKXxOM416KavN9z/PWIxQIuTf1bc5+VEl81c0ogvlUvfdQKHdeN98rCj
	wKuYh/+zxU3fFiHE9EpnAtaL6DmZZL8=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 6/9] profile: add after_uuids for ordering profile startup
Date: Fri, 28 Nov 2025 22:02:25 +0200
Message-ID: <0e68b96a2adb2f49be8ee961496d3033f32139fe.1764360140.git.pav@iki.fi>
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

Add btd_profile::after_uuids to specify the profile connect/accept order
for autoconnect.  This is a "soft" dependency so it doesn't fail if the
other services fail to start nor try to start them if they otherwise
wouldn't.

Add btd_profile_sort_list() for sorting a list according to profile
ordering, taking account priority and after_uuids.

Add btd_profile_find_remote_uuid() lookup utility, needed when using
btd_profile_sort_list() with uuid lists.
---

Notes:
    v2:
    - new commit

 src/profile.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/profile.h | 13 ++++++++
 2 files changed, 102 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index 66405d7e4..eaf368a4a 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -773,6 +773,30 @@ static struct btd_profile *btd_profile_find_uuid(const char *uuid)
 	return NULL;
 }
 
+struct btd_profile *btd_profile_find_remote_uuid(const char *uuid)
+{
+	GSList *l, *next;
+
+	for (l = profiles; l != NULL; l = next) {
+		struct btd_profile *p = l->data;
+
+		if (!g_strcmp0(p->remote_uuid, uuid))
+			return p;
+		next = g_slist_next(l);
+	}
+
+	for (l = ext_profiles; l != NULL; l = next) {
+		struct ext_profile *ext = l->data;
+		struct btd_profile *p = &ext->p;
+
+		if (!g_strcmp0(p->remote_uuid, uuid))
+			return p;
+		next = g_slist_next(l);
+	}
+
+	return NULL;
+}
+
 int btd_profile_register(struct btd_profile *profile)
 {
 	if (profile->experimental && !(g_dbus_get_flags() &
@@ -2650,3 +2674,68 @@ void btd_profile_cleanup(void)
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
 				"/org/bluez", "org.bluez.ProfileManager1");
 }
+
+/* Stable sort of a list according to profile priority & after_uuids */
+GSList *btd_profile_sort_list(GSList *list, btd_profile_list_get get,
+							void *user_data)
+{
+	GSList *result = NULL;
+	GSList *remain = list;
+	GHashTable *uuids;
+	GSList *entry;
+	const struct btd_profile *p;
+
+	uuids = g_hash_table_new_full(g_str_hash, g_str_equal, g_free, NULL);
+
+	/* Unsatisfied remote uuids */
+	for (entry = remain; entry; entry = g_slist_next(entry)) {
+		p = get(entry->data, user_data);
+		if (p->remote_uuid)
+			g_hash_table_add(uuids, g_strdup(p->remote_uuid));
+	}
+
+	/* Sort */
+	while (remain) {
+		GSList *first_entry = remain;
+		int max_priority = INT_MIN;
+
+		/* Find max priority */
+		for (entry = remain; entry; entry = g_slist_next(entry)) {
+			p = get(entry->data, user_data);
+			if (p->priority > max_priority) {
+				first_entry = entry;
+				max_priority = p->priority;
+			}
+		}
+
+		/* Find max priority entry with no unsatisfied dependencies */
+		for (entry = remain; entry; entry = g_slist_next(entry)) {
+			const char **uuid;
+
+			p = get(entry->data, user_data);
+			if (p->priority < max_priority)
+				continue;
+
+			for (uuid = p->after_uuids; uuid && *uuid; uuid++)
+				if (g_hash_table_contains(uuids, *uuid))
+					break;
+			if (!(uuid && *uuid))
+				break;
+		}
+
+		/* If cyclic dependencies: break preserving priority & order */
+		if (!entry)
+			entry = first_entry;
+
+		p = get(entry->data, user_data);
+		if (p->remote_uuid)
+			g_hash_table_remove(uuids, p->remote_uuid);
+
+		remain = g_slist_remove_link(remain, entry);
+		result = g_slist_concat(result, entry);
+	}
+
+	g_hash_table_destroy(uuids);
+
+	return result;
+}
diff --git a/src/profile.h b/src/profile.h
index 424ce55ad..a8c2443e3 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -38,6 +38,12 @@ struct btd_profile {
 	 */
 	bool testing;
 
+	/* Indicates the profile should be ordered after profiles providing
+	 * these remote uuids when connecting. A NULL-terminated array of
+	 * strings.
+	 */
+	const char **after_uuids;
+
 	int (*device_probe) (struct btd_service *service);
 	void (*device_remove) (struct btd_service *service);
 
@@ -76,3 +82,10 @@ bool btd_profile_remove_custom_prop(const char *uuid, const char *name);
 
 void btd_profile_init(void);
 void btd_profile_cleanup(void);
+
+struct btd_profile *btd_profile_find_remote_uuid(const char *uuid);
+
+typedef const struct btd_profile *(*btd_profile_list_get)(void *item,
+							void *user_data);
+GSList *btd_profile_sort_list(GSList *list, btd_profile_list_get get,
+							void *user_data);
-- 
2.51.1

