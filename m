Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DCE2837E
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 13:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bisq7DID"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704980404;
	bh=iHr806pmzHBJUgwzLVZNj4CqQHw71rq4AUfwHN+ZXmk=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bisq7DIDr8r1KMuyr5Ak1eCV4/a8q6jygQ7ubZpB43VxS8sae/xGxDriDRPSjJJ4A
	 v9Blh3B46ZAabQdF0e404vfSwAstodCwjUrsmiT65L3mZ0DeO56AR1G9jsb0N84rDt
	 wLbWkJ5wxoqbkXaehToz2fIRXIEQ9M1DzLfal9+XHo61mQ9eajQLi9HnA37+WHddNf
	 M7XDrWOi6kskgMCS1TFwrezIkeITQN4OJ+hLVTCGoPblNyVQmsdrL/Hug2ZS8HXyNx
	 H1AlZvvIxqJILvr9OBC/YyrrVVGI/PKEJqIxrJtqiQSiRSdFjBKBnUtWeUh3AMgj6N
	 VtLw/Cn/G0Dag==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 598363781FCF
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jan 2024 13:40:04 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 1/2] shared/gatt-db: Fix munmap_chunk invalid pointer
Date: Thu, 11 Jan 2024 14:39:54 +0100
Message-Id: <20240111133955.65686-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111133955.65686-1-frederic.danis@collabora.com>
References: <20240111133955.65686-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

PTS test GATT/CL/GAD/BV-03-C published a service starting at handle 0xfffd
and ending at 0xffff.
This resets the next_handle to 0 in gatt_db_insert_service() instead of
setting it to 0x10000. Other services are added later.
This could end-up by a crash in db_hash_update() if not enough space has
been allocated for hash.iov and some entries are overwritten.

Next_handle can be replaced by a last_handle variable which will not loop
over. This can be replaced by queue_peek_tail() and computing the value,
but keeping last_handle will avoid this sort of lookup.
---
 src/shared/gatt-db.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 676f963ec..9559583d1 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -58,7 +58,7 @@ struct gatt_db {
 	struct bt_crypto *crypto;
 	uint8_t hash[16];
 	unsigned int hash_id;
-	uint16_t next_handle;
+	uint16_t last_handle;
 	struct queue *services;
 
 	struct queue *notify_list;
@@ -255,7 +255,7 @@ struct gatt_db *gatt_db_new(void)
 	db->crypto = bt_crypto_new();
 	db->services = queue_new();
 	db->notify_list = queue_new();
-	db->next_handle = 0x0001;
+	db->last_handle = 0x0000;
 
 	return gatt_db_ref(db);
 }
@@ -356,14 +356,15 @@ static bool db_hash_update(void *user_data)
 
 	db->hash_id = 0;
 
-	if (!db->next_handle)
+	if (gatt_db_isempty(db))
 		return false;
 
-	hash.iov = new0(struct iovec, db->next_handle);
+	hash.iov = new0(struct iovec, db->last_handle + 1);
 	hash.i = 0;
 
 	gatt_db_foreach_service(db, NULL, service_gen_hash_m, &hash);
-	bt_crypto_gatt_hash(db->crypto, hash.iov, db->next_handle, db->hash);
+	bt_crypto_gatt_hash(db->crypto, hash.iov, db->last_handle + 1,
+				db->hash);
 
 	for (i = 0; i < hash.i; i++)
 		free(hash.iov[i].iov_base);
@@ -624,7 +625,7 @@ bool gatt_db_clear_range(struct gatt_db *db, uint16_t start_handle,
 
 done:
 	if (gatt_db_isempty(db))
-		db->next_handle = 0;
+		db->last_handle = 0;
 
 	return true;
 }
@@ -700,7 +701,7 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 		return NULL;
 
 	if (!handle)
-		handle = db->next_handle;
+		handle = db->last_handle + 1;
 
 	if (num_handles < 1 || (handle + num_handles - 1) > UINT16_MAX)
 		return NULL;
@@ -747,8 +748,8 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 	service->attributes[0]->handle = handle;
 	service->num_handles = num_handles;
 
-	/* Fast-forward next_handle if the new service was added to the end */
-	db->next_handle = MAX(handle + num_handles, db->next_handle);
+	/* Fast-forward last_handle if the new service was added to the end */
+	db->last_handle = MAX(handle + num_handles - 1, db->last_handle);
 
 	return service->attributes[0];
 
-- 
2.34.1

