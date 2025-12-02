Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6A22F83A2
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 20:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708497; cv=pass; b=hs7IxyBVbzW26Q6fHgZ0F/YdNEDDdPznqCSWNDOyWdUfDLdAYYWlT/of+ZYPwaiKGuRsV4bMot2cO6qDkvLw1AsW3ISpJbl0dQFG+KG8WMocLNjPhJ/RgCbr2PO9FwGJJ9uHZvE5wLfRym+K+O8Px+ZwfjNzV7u2lTLCOMnxpwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708497; c=relaxed/simple;
	bh=+ECREZ+zhMnxB5ry4fL01z8l6NJUddtatGkf6CvdDqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8rQ+beh/mVroAuf664ePQuEzyyIESDEuDhzGcWQWRJwi/epdc0+w0ysvdbMQLYL1XBueDzPcL2eHiaRIsbZnpYXWqWxhweTfVj9WoUoeiFJqbgQ+OIBPOMk08T7fNrEUHViaq5ttlyacjG9YpNd7DF+N4WcsqiADuliLmZZzEY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=uFarlFCp; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=nrVPaeXk; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="uFarlFCp";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="nrVPaeXk"
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4dLXsZ6B37z49Q4P
	for <linux-bluetooth@vger.kernel.org>; Tue, 02 Dec 2025 22:48:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1764708482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJF3YvnIsvij4PKNCMoZFuQJKYoWoHXwhYfkbDgC7tU=;
	b=uFarlFCpI/CnmftresG8iTu3eAe8YtJz0RQ7tkH5EXccxXtS7ffag9ORzf7PqIO8IBkmeJ
	DX02DVUAldL/mWEUPNYPIKBfVyiZRLPWTSA5a8qFvZTM6LM26dI97igckNSY8XJ/Dw1bcJ
	vXKoh5RDA9bi5wksA3QSJx2lM05xNzqlOSYFM2NKeAuJL6cgBS4c0VRpp/pJIq+n2m0yfz
	1AsDHI3o23F/oEVGb8f+c/2CTfeYSZ1IGxoR51yKGaB8y3NraSBRN0JmZsub5FI9Jege3W
	j7gB9n9vzBaCouwrNG7It7NqWpi5ae3cXHXddvq8AwLyigixEhVKJ6o+ZsTFcw==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dLXsR1WBCz10LB;
	Tue,  2 Dec 2025 22:47:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764708475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJF3YvnIsvij4PKNCMoZFuQJKYoWoHXwhYfkbDgC7tU=;
	b=nrVPaeXkbsxtz93hrvlt+TvGd8LZs60nciSUyNlrvMdFXf429R8FSywiRzA2NWOIMIOc5j
	eenYlUNlh+yoAPYC6BBPeq+pFYMBI6xbAgJnF+ZSVd2S//Ee2S5mm0YdYALaXaZHmnM/7K
	hUSibc0b9/S6r0VB3ymDywubtsmFu0o=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764708475;
	b=myQnakMHG6U4rdu4tZUnsQvjsDHEZUeExPM9p/FmQ0D0slnzeGKe8SgoADiw/1x+CyiocH
	zfUXN9Ca/4usHDEEhLRKwtrYM4kKfbZOzFy5ZJ5m8dLIambNX+gXeD42jdbNJJzWc0zT3L
	ehGTpVfN1/69+ZveWMzyqG++ITOtixw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764708475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJF3YvnIsvij4PKNCMoZFuQJKYoWoHXwhYfkbDgC7tU=;
	b=KtsyF7jHc04gtUesgiDrjtX3rIsyDlbslqtnuNQl9qFbtyUA5CltBK8MDEIIGtaCVDrUFF
	YLdhmEZYKsU7nxA7TSMQp9xtler1RIzfBXDP247iQ4FFofi+CxoZcLRJIAllwew4NR289E
	WQ6o19PgoYg9OfXuAr/avFtImh7VG0E=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 3/7] device: use after_services in service autoconnect and sort also GATT
Date: Tue,  2 Dec 2025 22:47:48 +0200
Message-ID: <efb6103c34abdc72d6039e1c30760dc47f4d919a.1764708372.git.pav@iki.fi>
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

Use btd_profile_sort_list() for selecting the order in which services
are connected: first by priority, then by after_services.

Probe and accept also GATT services in profile order. Previously this
was done in the order they were in GATT db.
---

Notes:
    v3:
    - no change
    - GSList *pending -> struct queue *pending refactoring left for later...

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

