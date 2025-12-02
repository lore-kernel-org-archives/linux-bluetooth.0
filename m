Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6332F747F
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708497; cv=pass; b=VQCx1EnZ4sI1ARS4esZpZ1FTs+feYKY6CxOkNaUfcSZ0leAB/8vE+cKeKQJlhLHzVuA0zAK6IQQPSAEAfv7lBzxInWW0u3PR6d2mkRYL3b5x8dEd41ixh93Hata7+KPeojcqeHG+Azd2kRT2UJUYxNWXyuGfT4Yp6Yzd5KeHAh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708497; c=relaxed/simple;
	bh=LVNU7s9kp0AaOSVPJFMwOShJGsSeZVifFfIqg4poKn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rurNXWHqlmK54gah4BToZxdngeciUnnudorEioXcII0jGNKKthvURn9DCbxS7VufE2xWO6L3H+uxHeuAdHTM8hQdqMwS40NRdtMvpDKxnhOnQbEjlbfx4uVWKFGtHCq58kVfUAgPjZoUrXykz3lZ6iV90RmaNgEbVUndR6iTajk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=qWK+LVFS; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=fk4lA8O7; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="qWK+LVFS";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="fk4lA8O7"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4dLXsZ5zWgz49Q10
	for <linux-bluetooth@vger.kernel.org>; Tue, 02 Dec 2025 22:48:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1764708482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dcPqt+xMRb6EVu6+XwEZCRjBOBICyTR1wHOiCIU9k0=;
	b=qWK+LVFSFGcq3rvjGBfnXYOsIxn8L9Vc+QVfxuPn3v7bKsQcFbYK7T1eqLWfDAv7PsapsT
	Fm1yO/+d7EV/rYOVUpbv0rs3T/mtgt0yFhf60MKanZFbavUPkkaXR+GaxGZs/kq3uvHT+0
	XNH8OtOwxJGl9/LpArSTVeZ364IvRCJlLZvm9spJBbVSgzddKAFimIFsSvrhvlt28+fC19
	Wz6+C+8X2R9/iFbyKOb3oUd234f7wiEBVnrXRT3pbnb6NjjOQYjVIe8nd7locNzM3cp/xz
	qp3bDm2XFa9dzzOX1G8nsUTosObrS3HphK6b6mCh22DTPpIjJB/krCrsZ2o6pw==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dLXsQ3nwxz104T;
	Tue,  2 Dec 2025 22:47:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764708474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dcPqt+xMRb6EVu6+XwEZCRjBOBICyTR1wHOiCIU9k0=;
	b=fk4lA8O7wAKLItK9GwHHokwDaALQWvtZ25fA1IgqFrd8VWxGozPi0EW6SjaVI27d7tRNx6
	K16ZZ4wk2l+a9xMUP1WOsv3erzeHgwz8daW0r0+JAFVbIj/bxbS/dJ3yQ9gpyHCjJ6ex0T
	A2KxWD4qO90zQXr+zA3k7lM7NjAGttw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764708474;
	b=ZkLD+H2G3c98JiRQlMbUWKzC3FmPqooe2YvhwE5CCjrR55HI0p/jpazWxDRP2AN9f+MIG3
	r6ewd3o9pAlEmr8jZkV7w/in4iJP87jwl4cvjAluVV+z6AfAfVdyqYHcKFgdHFWsxSJbs5
	Zluw+j7o/zn2Ir15Utsa4yrsd1qliZA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764708474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7dcPqt+xMRb6EVu6+XwEZCRjBOBICyTR1wHOiCIU9k0=;
	b=vw7RWTy+ukzJAWj4IoIYTd/fBc/Y1jktkLW6pCzSO6G0AE2kq4NZph1IRsbhJgcyAP/gUZ
	giKXYWoav+NYwicJqcnIKgWv/LwhAe8XxT0VglidjRpNpWEmlsy1l7KLdpqjJe2rjb7gzI
	R4SqNpofhbZmI5fzy8KKxQlyon5AHzs=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 1/7] profile: add after_services for ordering profile startup
Date: Tue,  2 Dec 2025 22:47:46 +0200
Message-ID: <a65f8e789d415e02537be797bee0f6172bd2adf4.1764708372.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1764708372.git.pav@iki.fi>
References: <cover.1764708372.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add btd_profile::after_servicess to specify the profile connect/accept
order for autoconnect.  This is a "soft" dependency so it doesn't fail
if the other services fail to start nor try to start them if they
otherwise wouldn't.

Add btd_profile_sort_list() for sorting a list according to profile
ordering, taking account priority and after_services.

Add btd_profile_find_remote_uuid() lookup utility, needed when using
btd_profile_sort_list() with uuid lists.
---

Notes:
    v3:
    - rename to after_services
    - put callback and uuids inside a struct

 src/profile.c | 90 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/profile.h | 26 +++++++++++++++
 2 files changed, 116 insertions(+)

diff --git a/src/profile.c b/src/profile.c
index 66405d7e4..46a3d3b45 100644
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
@@ -2650,3 +2674,69 @@ void btd_profile_cleanup(void)
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
 				"/org/bluez", "org.bluez.ProfileManager1");
 }
+
+/* Stable sort of a list according to profile priority & after_services */
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
+			unsigned int i;
+
+			p = get(entry->data, user_data);
+			if (p->priority < max_priority)
+				continue;
+
+			for (i = 0; i < p->after_services.count; ++i)
+				if (g_hash_table_contains(uuids,
+						p->after_services.uuids[i]))
+					break;
+			if (i == p->after_services.count)
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
index 424ce55ad..6f236a38a 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -14,6 +14,19 @@
 
 struct btd_service;
 
+#define BTD_PROFILE_UUID_CB(func_, ...) \
+	{ \
+		.func = (func_), \
+		.count = ARRAY_SIZE(((const char *[]) { __VA_ARGS__ })), \
+		.uuids = ((const char *[]) { __VA_ARGS__ }), \
+	}
+
+struct btd_profile_uuid_cb {
+	void (*func)(struct btd_service *service);
+	unsigned int count;
+	const char **uuids;
+};
+
 struct btd_profile {
 	const char *name;
 	int priority;
@@ -38,6 +51,12 @@ struct btd_profile {
 	 */
 	bool testing;
 
+	/* Indicates the profile should be ordered after profiles providing
+	 * these remote uuids when connecting. The callback function is called
+	 * when all uuids have finished connecting (successfully or not).
+	 */
+	struct btd_profile_uuid_cb after_services;
+
 	int (*device_probe) (struct btd_service *service);
 	void (*device_remove) (struct btd_service *service);
 
@@ -76,3 +95,10 @@ bool btd_profile_remove_custom_prop(const char *uuid, const char *name);
 
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

