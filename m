Received: from mail-ua2-f32.google.com (mail-ua2-f32.google.com [74.125.226.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D58349B19
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258176; cv=none; b=s6gL36NrI+lztCUwuaXzzjlyvv+eF90cNn6h5q/J+ztIqz7MD+kKZvwBO8cD2dKJPKfgZjhjZM8X8JpQKlgAO8wTtDiuYq9fZyQhTm6xDSh01Kw0dWWeUY5tuQnIUkf5IkzqCltYBDRBqtlAWi/07ts8LXc9yZbkmItys1PdJVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258176; c=relaxed/simple;
	bh=hydofXx5lt3/+OUalKkJthhd6RY7Ut+rNeW0zfyuXV4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BTCLBgnghWm+XOJXPEUpNda/yf6PgtUmVRzmFIZqqBdSe1jEDpGgzujRq5DKFPMLS4HrxbrIPobuBE/RKU+DJYlw8eOjuXQIbQsq/sC9sV+yvxnNePJSonAOBZbAdUrM4TRBHyF0lXDULgJefv1DzrHn4GB6OyNswoXc3LdZKtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRQYHOOm; arc=none smtp.client-ip=74.125.226.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRQYHOOm"
Received: by mail-ua2-f32.google.com with SMTP id a1e0cc1a2514c-97e97e2c7d4so1171678241.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 06:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790258173; x=1790862973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PJ3hVin/lAETWO+XOUj/W8/18I3Cize/tE10XlmBLvc=;
        b=fRQYHOOmQpEmZkMg9+SBSoBqwhiPQEjllbylVHtePJnZBNKQW0J6gMvSb/EQsXnG/H
         4p/x8Mn+7w3HxZ8XncNM5cvL/RB6VzX4NpW9Og0hzeTZIUgcGKiOBkwIsg7uCUKmPp64
         6+9WkU2O/mPg1GvzfkW94TtfQMVtMRmSx9bDn85rouKrCe9yGeqk24+nHcpFHzCRDGyE
         nXRaF4BRjsc1CyXdnXr1q64028eQdgULwPP8OApilDfzl5hDwKBuKZiffTktwBEYGCmd
         2cYW6+2o6erq4rykNwTIJsKDVbig71t9YJOhv7wSAGysunyxbgnBCiYFkvqVW1vFsjl8
         e5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258173; x=1790862973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PJ3hVin/lAETWO+XOUj/W8/18I3Cize/tE10XlmBLvc=;
        b=QLa88hPdEoWoy1S4qZuWafLvYsEXBfv68MDAV2LjnIX22+dvSmrP5o1HYhcmbpitoC
         wPoIc2il2LyCzw44htaVl3JCvr+aQpdbI1YxSi9PuhcF9tgOoHOI76B/D7jdmRN0dcig
         bsXeVN0loukys0dnbyFb5KnJY5dEZNFnj+8zVd7eNNnKygmWKovCVJ8Z1SvidvGta8LP
         bpcQfJs84ajFMJ/VOnQwX6E1ekwusso1tKjGQORlGeABp4hZ3JcwTrRNZKoUH5k86f9w
         opBDyMJRWWrkvAQUsXNh1Je6nbQJgBzLdTYwWLGCkw9vx2bgUSUzBmxoJzOtyJYms0SB
         7krA==
X-Gm-Message-State: AFuF++nZX143UqF2WgqO4YzDSUm+jzilOf0/cQqjkEFcrpXipZLBWMWt
	lteiTwlIIuwqAT++bBkXbzX/zj+1ORjtFoHAZDg1M1vWHyHEW3scC4K6I7VlSmKD5+olIg==
X-Gm-Gg: AYBFou0PpWmhmeS2RfOUFZalH7DGVJY9GD0j3yKU67odre82DAn22ZjOguespm+9s4i
	T4kqroNP/I5JBMGySp+byT7IhtHYzGkFhcGuHg3YYDkyqCDa+n4FHc+mWTqTL5JEhDhbu8Bo4kV
	BjTWApv5s75wgwcGTxKbKNej020jXDmrSyd9YTiC3HW8z29l5+Nd/m7LniItqM0PaUSIsKRGNdE
	4MzR1Gqjp0x7Xym2HZMiHvTxFfWeI5mdOZAYOtPuoK+YTbCRN4qWynLUmKqCNrkj+yv4lT4fEbv
	v57meAA+0D6uy7yEZJfAVJ7njz8ZWaHvqVLDG/3PBQUzTQYvml8U4/58xM9JrtNquaiODUWY5DS
	r/ljGe3vUgPkk7o+zkOIS1bZRwWPhIvqy1jutJJkXORVUh0YE8aBmil4r0sMgGiX2N6X8l1G95P
	7arGIdVzCooP+ltU+th94Dd9mmCfNh2bWraD03FRpUQ1iHokPvu5xoFmc5yCav2k5aGbeUKjtc/
	UvJKLdIUJzHX0cGWuf1Kcm7SpMwtDlFYYuWzXQp9NrRiF+8QVLaZHz5Bfdij4zuoRs4nx5987c=
X-Received: by 2002:a05:6102:3e84:b0:7a9:f088:14ef with SMTP id ada2fe7eead31-7af1cca0d2cmr1459828137.13.1790258173380;
        Thu, 24 Sep 2026 06:56:13 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7af8bdcde81sm1493194137.10.2026.09.24.06.56.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:56:12 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/8] attrib: Fix unregistering notifications registered with bt_gatt_client
Date: Thu, 24 Sep 2026 09:55:54 -0400
Message-ID: <20260924135601.330277-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924135601.330277-1-luiz.dentz@gmail.com>
References: <20260924135601.330277-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

g_attrib_register registers ATT_OP_HANDLE_NOTIFY with bt_gatt_client,
when there is one, returning its id, but g_attrib_unregister always
unregisters with bt_att, so the notification was never unregistered
and its destroy callback was called once bt_gatt_client was freed,
after the user data was freed, e.g. the reports of HoG:

 ERROR: AddressSanitizer: heap-use-after-free
 #11 report_notify_destroy profiles/input/hog-lib.c:359
 #12 attrib_callbacks_destroy attrib/gattrib.c:126
 #13 notify_data_unref src/shared/gatt-client.c:256
 ...
 #17 bt_gatt_client_free src/shared/gatt-client.c:2293
 #18 bt_gatt_client_unref src/shared/gatt-client.c:2605
 #19 g_attrib_unref attrib/gattrib.c:154
 #20 attio_cleanup src/device.c:874

Give out ids of our own, keeping track of how each one was registered
so it is unregistered accordingly.
---
 attrib/gattrib.c | 90 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 27 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 3a988e131e94..05a17ba9393f 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -45,6 +45,7 @@ struct _GAttrib {
 	uint8_t *buf;
 	int buflen;
 	struct queue *track_ids;
+	unsigned int next_reg_id;
 };
 
 struct attrib_callbacks {
@@ -55,6 +56,9 @@ struct attrib_callbacks {
 	gpointer user_data;
 	GAttrib *parent;
 	uint16_t notify_handle;
+	unsigned int reg_id;
+	unsigned int att_id;
+	unsigned int client_id;
 };
 
 GAttrib *g_attrib_new(GIOChannel *io, guint16 mtu, bool ext_signed)
@@ -363,38 +367,52 @@ guint g_attrib_register(GAttrib *attrib, guint8 opcode, guint16 handle,
 				GAttribNotifyFunc func, gpointer user_data,
 				GDestroyNotify notify)
 {
-	struct attrib_callbacks *cb = NULL;
+	struct attrib_callbacks *cb;
 
 	if (!attrib)
 		return 0;
 
-	if (func || notify) {
-		cb = new0(struct attrib_callbacks, 1);
-		if (!cb)
-			return 0;
-		cb->notify_func = func;
-		cb->notify_handle = handle;
-		cb->user_data = user_data;
-		cb->destroy_func = notify;
-		cb->parent = attrib;
-		queue_push_head(attrib->callbacks, cb);
-	}
+	cb = new0(struct attrib_callbacks, 1);
+	if (!cb)
+		return 0;
 
-	if (opcode == ATT_OP_HANDLE_NOTIFY && attrib->client) {
-		unsigned int id;
+	cb->notify_func = func;
+	cb->notify_handle = handle;
+	cb->user_data = user_data;
+	cb->destroy_func = notify;
+	cb->parent = attrib;
+	queue_push_head(attrib->callbacks, cb);
 
-		id = bt_gatt_client_register_notify(attrib->client, handle,
-						NULL, client_notify_cb, cb,
-						attrib_callbacks_remove);
-		if (id)
-			return id;
-	}
-
-	if (opcode == GATTRIB_ALL_REQS)
-		opcode = BT_ATT_ALL_REQUESTS;
-
-	return bt_att_register(attrib->att, opcode, attrib_callback_notify,
+	/* The notifications are registered with bt_gatt_client when there
+	 * is one, which uses ids of its own, so give out ids of our own to
+	 * know how to unregister them.
+	 */
+	if (opcode == ATT_OP_HANDLE_NOTIFY && attrib->client)
+		cb->client_id = bt_gatt_client_register_notify(attrib->client,
+						handle, NULL, client_notify_cb,
 						cb, attrib_callbacks_remove);
+
+	if (!cb->client_id) {
+		if (opcode == GATTRIB_ALL_REQS)
+			opcode = BT_ATT_ALL_REQUESTS;
+
+		cb->att_id = bt_att_register(attrib->att, opcode,
+						attrib_callback_notify, cb,
+						attrib_callbacks_remove);
+	}
+
+	if (!cb->client_id && !cb->att_id) {
+		queue_remove(attrib->callbacks, cb);
+		free(cb);
+		return 0;
+	}
+
+	if (++attrib->next_reg_id == 0)
+		++attrib->next_reg_id;
+
+	cb->reg_id = attrib->next_reg_id;
+
+	return cb->reg_id;
 }
 
 uint8_t *g_attrib_get_buffer(GAttrib *attrib, size_t *len)
@@ -456,12 +474,30 @@ gboolean g_attrib_attach_client(GAttrib *attrib, struct bt_gatt_client *client)
 	return TRUE;
 }
 
+static bool match_reg_id(const void *data, const void *match_data)
+{
+	const struct attrib_callbacks *cb = data;
+
+	return cb->reg_id && cb->reg_id == PTR_TO_UINT(match_data);
+}
+
 gboolean g_attrib_unregister(GAttrib *attrib, guint id)
 {
-	if (!attrib)
+	struct attrib_callbacks *cb;
+
+	if (!attrib || !id)
 		return FALSE;
 
-	return bt_att_unregister(attrib->att, id);
+	cb = queue_find(attrib->callbacks, match_reg_id, UINT_TO_PTR(id));
+	if (!cb)
+		return FALSE;
+
+	/* cb is freed by attrib_callbacks_remove once unregistered */
+	if (cb->client_id)
+		return bt_gatt_client_unregister_notify(attrib->client,
+							cb->client_id);
+
+	return bt_att_unregister(attrib->att, cb->att_id);
 }
 
 gboolean g_attrib_unregister_all(GAttrib *attrib)
-- 
2.55.0

