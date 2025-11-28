Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7EB2DAFBA
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Nov 2025 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764360175; cv=pass; b=urqY4I1F1pSLhiYiNK7GUuzBe5iKA6Y6H3Yy3Y1IrahaC4jagjuHFGRVK47mhWCzjg1qwVXmUXCokJb+zPI1CLu7M7DhggfD7ZY2icYCfARqE6C3urlV8iXhLq4JLRKeYllDnRv3FyjFU3nE4r/fDYylhsRlMxy9S6z2ZYTGIoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764360175; c=relaxed/simple;
	bh=f+JCITPWZqn76ixpDW6D1kJhkZUC3c3acq/LGqsP+24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5ES0VUS6xzFf67ZmbbXeF2/IkU72QgrmoTn4IgEJCYJ9ArYuCxeyJ0J3rXJYgKjOEmIo4isrxMRwyIsCvtfIt4BS547rbQIswG/BgzOej50VkLsgWkKVvcyoJYzgi52iOFf0pGYTYVSx7F1MYJsR0UgnW8YgB+fOBtpJq/PWjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=uSoR5yPP; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="uSoR5yPP"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dJ4353Rp2z10H4;
	Fri, 28 Nov 2025 22:02:41 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764360161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+ppCJKkG7Nilg9Hi2Q7vjtbKqewj7HwTyWvSKKjrkg=;
	b=uSoR5yPP+ohmXpTrt49FaVNp7JIIYP3T2gK+QTRT16pgsCKkBv2B7VsbCJABjFIhEJsEwF
	OcW/l6bo/bceQpzYifVGqYJtdSfB269KwOQuH1fsIkk86B82rmIMVrohQaDVunCOqbi6bq
	b0RsblXHFotccZ8W4VD+74LodMVIVFo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764360161;
	b=xRB8OrR8L3Qig4aZCIMV3Lw3Wqhk7IkfrM0WM7+sZIc0ZUNqiqjEmh7+DzIfoajNugtEhB
	TpBb0VHBKwb/XO+28fTT7gcttFFvIoDRRT5kKWCUrv2Yfdk24DISpGP9dYA2bVk1oa8Owo
	b5uae70SRAuwtrSDzZiI9ev8+3jDgKU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764360161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w+ppCJKkG7Nilg9Hi2Q7vjtbKqewj7HwTyWvSKKjrkg=;
	b=jI0LZc02NUABpwH0+Llzm5bMBUQYGNqKq/tDJID6g2ZZcLjTf/DgdzdT4q0PiL1cWEQBlR
	NgKQWWC991dK4v0qeXmZ2oclHJ7SUURc18Hefb0vWNCPFCdhDAy751f/qr9qZ1OSXreTM3
	RE3IH8lbtb0W6dIcGgrPXfFuhIUV5s0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 7/9] device: use after_uuids in service autoconnect and sort also GATT
Date: Fri, 28 Nov 2025 22:02:26 +0200
Message-ID: <a70dbe05e5a56492edbbaef74db75c13306088b7.1764360140.git.pav@iki.fi>
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

Use btd_profile_sort_list() for selecting the order in which services
are connected: first by priority, then by after_uuids.

Probe and accept also GATT services in profile order. Previously this
was done in the order they were in GATT db.
---

Notes:
    v2:
    - new commit

 src/device.c | 74 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 12 deletions(-)

diff --git a/src/device.c b/src/device.c
index eb184633a..3ecbfd67c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2523,14 +2523,6 @@ static struct btd_service *find_connectable_service(struct btd_device *dev,
 	return NULL;
 }
 
-static int service_prio_cmp(gconstpointer a, gconstpointer b)
-{
-	struct btd_profile *p1 = btd_service_get_profile(a);
-	struct btd_profile *p2 = btd_service_get_profile(b);
-
-	return p2->priority - p1->priority;
-}
-
 bool btd_device_all_services_allowed(struct btd_device *dev)
 {
 	GSList *l;
@@ -2581,6 +2573,12 @@ void btd_device_update_allowed_services(struct btd_device *dev)
 	}
 }
 
+static const struct btd_profile *get_service_profile(void *data,
+								void *user_data)
+{
+	return btd_service_get_profile(data);
+}
+
 static GSList *create_pending_list(struct btd_device *dev, const char *uuid)
 {
 	struct btd_service *service;
@@ -2619,10 +2617,13 @@ static GSList *create_pending_list(struct btd_device *dev, const char *uuid)
 						BTD_SERVICE_STATE_DISCONNECTED)
 			continue;
 
-		dev->pending = g_slist_insert_sorted(dev->pending, service,
-							service_prio_cmp);
+		dev->pending = g_slist_append(dev->pending, service);
 	}
 
+	/* Connect in priority order */
+	dev->pending = btd_profile_sort_list(dev->pending, get_service_profile,
+									NULL);
+
 	return dev->pending;
 }
 
@@ -4630,9 +4631,42 @@ done:
 	service_accept(service, btd_device_is_initiator(device));
 }
 
+
+static const struct btd_profile *get_gatt_profile(void *data, void *user_data)
+{
+	struct gatt_db_attribute *attr = data;
+	struct btd_profile *profile;
+	bt_uuid_t uuid;
+	struct btd_profile *dummy_profile = user_data;
+	char *uuid_str = (char *)dummy_profile->remote_uuid;
+
+	gatt_db_attribute_get_service_uuid(attr, &uuid);
+	bt_uuid_to_string(&uuid, uuid_str, MAX_LEN_UUID_STR);
+
+	profile = btd_profile_find_remote_uuid(uuid_str);
+	if (!profile)
+		profile = dummy_profile;
+
+	return profile;
+}
+
+static void get_gatt_attrs(struct gatt_db_attribute *attr,
+							void *user_data)
+{
+	GSList **list = user_data;
+
+	*list = g_slist_append(*list, attr);
+}
+
 static void device_add_gatt_services(struct btd_device *device)
 {
 	char addr[18];
+	GSList *attrs = NULL;
+	GSList *entry;
+	char uuid_str[MAX_LEN_UUID_STR];
+	struct btd_profile dummy_profile = {
+		.remote_uuid = uuid_str,
+	};
 
 	ba2str(&device->bdaddr, addr);
 
@@ -4641,18 +4675,34 @@ static void device_add_gatt_services(struct btd_device *device)
 		return;
 	}
 
-	gatt_db_foreach_service(device->db, NULL, add_gatt_service, device);
+	/* Probe and accept in profile priority order */
+	gatt_db_foreach_service(device->db, NULL, get_gatt_attrs, &attrs);
+
+	attrs = btd_profile_sort_list(attrs, get_gatt_profile,
+							&dummy_profile);
+
+	for (entry = attrs; entry; entry = g_slist_next(entry))
+		add_gatt_service(entry->data, device);
+
+	g_slist_free(attrs);
 }
 
 static void device_accept_gatt_profiles(struct btd_device *device)
 {
 	GSList *l;
 	bool initiator = btd_device_is_initiator(device);
+	GSList *services;
 
 	DBG("initiator %s", initiator ? "true" : "false");
 
-	for (l = device->services; l != NULL; l = g_slist_next(l))
+	/* Accept in profile priority order */
+	services = g_slist_copy(device->services);
+	services = btd_profile_sort_list(services, get_service_profile, NULL);
+
+	for (l = services; l != NULL; l = g_slist_next(l))
 		service_accept(l->data, initiator);
+
+	g_slist_free(services);
 }
 
 static void device_remove_gatt_service(struct btd_device *device,
-- 
2.51.1

