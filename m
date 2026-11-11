Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429594;
	b=k4+IdK2Gan7DXKCmTEEw/iWHsCVMC8qssj+qv+ROz5ezx2N7x/Wz6oQbNi885kcYwSq2
	 DG+4px/X50MFoDUYIpMhTY/l2qkFtatfgKesyhXgFxmrz1lqfSSrTZbt1BBpboSh2rgei
	 of4B3z0qHG7DqPYWBSwWcvl1kIHhvhaYRf5UxkFQVO3pDBbzD851QnonZIM/D43W2BxQq
	 hu/E3akiu6Bj+QWFAQEchTgFI5wZ36PM/H18uI9Rwz+NXbVM13mzCzZNE1DzG4LIEJEtK
	 aH0swgo4drhme3KITpdBhcLZuNmQaT2nL4k3wZjGlRuSlohMPebBGDpUdhxNOC4gTKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429594;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PwdVsTlK9xWMzjslSSqC7Uhv1yWxnDc1+cGHBSKsW2c=;
	b=xLGnUSAGqieMW0vQ8CedZ3rKZNFcq0C1MN2N+v8wMVkXHSNrs5FKeFx1cTbifJNJbk5i
	 iUD0sYf7fl24kJ1gHCSVEsVvZ+2AkITYMF4O7LwSb609Ya8aDMjP2d1GHkXRnoU53ipQX
	 M2JIQtTudIKrVHA9Vq8Wr3/UgwTsm4HVLpApBpKEhdcOJf8uoto4DOmfKtupD+jHClfTP
	 ubL8GDhPLqA4Ejbte3off+sQ/YdPk069C4yEjwMfkbb37R24mGOs8VK1zZr03XpkAQC10
	 X/WRKOgTcCLcMH9rJs5BiIGI2yRRv/ESH3eAEbdjG/DkyM5e5h+jewhzgrcKD1+igQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CHIXpeBD;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E7606A335
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 564E7606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CHIXpeBD
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5eaeb7fdda2so2161279e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429593; x=1795034393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PwdVsTlK9xWMzjslSSqC7Uhv1yWxnDc1+cGHBSKsW2c=;
        b=CHIXpeBD7dV5GYybGf4mCepMWfM5equ6sokHAtiaLjgGsk0GHjYVJKHdkq9FRn+mi9
         bSyYHdLOD0htmitqqGOLURoFvS60w9A2QdPPvdAUgLacYsVAyYS5bamsNO5Fl9fL+kTg
         qPDMPwcAoZ9ObpY7aBWiaIgUcdTQc3APY99WkAFffQHbVMuXZAsan7uIC4xFfsxOItBv
         zwa0JVJWC4xUmIu41LmOE22hKrCusQcUrT598Nwo36miClxBVGerEDsZRvjQXGTg1NlQ
         QY5bdieWr+Vs27HEWnKBAepmlR+qgSOlgaSLvPmSLH9iujfUhKVDnQwc87wHPz85yQUz
         y4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429593; x=1795034393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=PwdVsTlK9xWMzjslSSqC7Uhv1yWxnDc1+cGHBSKsW2c=;
        b=YVoBIHDIOxk48cJ1H73ry5iUQlSsl8RDU98s0Y8xw24OdWr4v3bDGeOVV2JYzCWMTP
         FDfu136yy8hvKTZXtdZq2RKDJb0W4Inrf32FJH00lPnYC/St0zUgfN981jZ6I7i7WI0B
         A3fKeeIdXQstJK89VEvvDGRSp4aRWZ5DaRJV2eQQMD5Y4biRxGdf47HPLVifw7ULiSgB
         X0jxyBxDRUzmZzHYRukb6cvrZlyn8cXHQG1+/aqoc2SiIbWQvxzxHtLie0YThFnNxeHM
         0CfRVsSz4GIOyuXKY/jvXPjJbcEDeU3hSw1LB8DFuHJCG1uvTu+je4uYt4NkHt5ragUY
         J+yA==
X-Gm-Message-State: APuU4Z+q1w8u/Sf7j98Qf9BlNqbVr+rIYaI4GtuYEqsErfQ5vHOpf5OM
	qb+g6N7+xusalkXe9y7l/WH3wcueeg1eOQMJqZq1bj7pVY+cMNNheLKIlL65ag==
X-Gm-Gg: AYBFou0a7+6b1fITP7gZVBuPaZcVM3KvJiT9UFcumMjUPJqxsaBk7qYKOa99gy+S2TB
	yrOW9PWwqV/dSU2KVapajTSIe2Xtn0gztKGmRyLXVigfC6Xp0mCgcVjD3LqGcNPG+7oJ/Fkbv2Z
	39v95wRHNu1JKlomqX49cpVJIZ/iV0cG+2yzE7RWUIlCj7Vr0k3/sDY8O4Y1jXIyETg3mBFEjYk
	ULTQQtukGhb3yG5j0m8dY+GpV2sPGXggEuBzcFNrr5N6J1OqcUSwadwrn6CRk8wBU0v+6Znmb0M
	AR9+EzWv5YKBfK/R+d787ZouB5kL2qXYZSS4+6ue4NmQptvwn/ywRxeDSw28IFABagIEDWIkNZK
	LSAGQQ4dQSoOzeDzIRLxZ3wyotVUfL7p9cl7xgpmbDSF0nkapOqrS6TmyJNJ5dzSzAq7QD+GAmt
	DAT3BhZm/026WR0Wn93FFiuQaQS8rbJBUyAX+QDwt1+7gSSh8jRJTmlokXE/Zt9kISwGQTe90ZA
	ABi2dJVAvVCNDGpLQN1fpjIEiDBWRdd5HCPGDUBj50Ol2kyelRP0CskNLwGs/L5MBFQxcf1Yq0g
	tWVw0LgGmnqouYPIBfCczcDC6HFg9TwQO2BOUWVK3lU+/XtyDK7eReVU+YHNhpx3KDJLWHNqwaW
	Twun46D25exhQxnUmngZH7ysQiPtcIEztjDkjYsCIc7ThQkSdZ3MQ3iKeeW63xh1+v/yhBuzls9
	OVCD4=
X-Received: by 2002:a05:6122:3d10:b0:5ec:b8f0:774a with SMTP id 71dfb90a1353d-5ee1c2c2bf1mr1531613e0c.3.1794429593112;
        Wed, 11 Nov 2026 12:39:53 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c2f3bfasm4301380e0c.0.2026.11.11.12.39.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:39:52 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/5] shared/gatt-db: Use util_iov helpers to build and parse values
Date: Wed, 11 Nov 2026 15:39:45 -0500
Message-ID: <20261111203949.3874673-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111203949.3874673-1-luiz.dentz@gmail.com>
References: <20261111203949.3874673-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Build the hash input, characteristic, include and service declarations
with util_iov_push_*, and parse declaration values in the
gatt_db_attribute_get_*_data functions with util_iov_pull_* so they are
checked against the stored value length.

The hash input allocation is now also checked. If it fails the hash is
not updated from the incomplete input and the update is retried later.

Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/gatt-db.c | 215 ++++++++++++++++++++++++++-----------------
 1 file changed, 129 insertions(+), 86 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 23c705bd9d16..76f06899f6aa 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -372,13 +372,14 @@ static void handle_notify(void *data, void *user_data)
 struct hash_data {
 	struct iovec *iov;
 	uint16_t i;
+	bool failed;
 };
 
 static void gen_hash_m(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct hash_data *hash = user_data;
-	uint8_t *data;
-	size_t len;
+	struct iovec iov = {};
+	bool with_value;
 
 	if (!attr || !attr->value)
 		return;
@@ -391,30 +392,33 @@ static void gen_hash_m(struct gatt_db_attribute *attr, void *user_data)
 	case GATT_SND_SVC_UUID:
 	case GATT_INCLUDE_UUID:
 	case GATT_CHARAC_UUID:
-		/* Allocate space for handle + type + value */
-		len = 2 + 2 + attr->value_len;
-		data = malloc(2 + 2 + attr->value_len);
-		put_le16(attr->handle, data);
-		bt_uuid_to_le(&attr->uuid, data + 2);
-		memcpy(data + 4, attr->value, attr->value_len);
+		with_value = true;
 		break;
 	case GATT_CHARAC_USER_DESC_UUID:
 	case GATT_CLIENT_CHARAC_CFG_UUID:
 	case GATT_SERVER_CHARAC_CFG_UUID:
 	case GATT_CHARAC_FMT_UUID:
 	case GATT_CHARAC_AGREG_FMT_UUID:
-		/* Allocate space for handle + type  */
-		len = 2 + 2;
-		data = malloc(2 + 2 + attr->value_len);
-		put_le16(attr->handle, data);
-		bt_uuid_to_le(&attr->uuid, data + 2);
+		with_value = false;
 		break;
 	default:
 		return;
 	}
 
-	hash->iov[hash->i].iov_base = data;
-	hash->iov[hash->i].iov_len = len;
+	/* Allocate space for handle + type + value */
+	iov.iov_base = malloc(2 + 2 + attr->value_len);
+	if (!iov.iov_base) {
+		hash->failed = true;
+		return;
+	}
+
+	util_iov_push_le16(&iov, attr->handle);
+	util_iov_push_le16(&iov, attr->uuid.value.u16);
+
+	if (with_value)
+		util_iov_push_mem(&iov, attr->value_len, attr->value);
+
+	hash->iov[hash->i] = iov;
 
 	hash->i++;
 
@@ -439,10 +443,17 @@ static bool db_hash_update(void *user_data)
 
 	hash.iov = new0(struct iovec, db->last_handle + 1);
 	hash.i = 0;
+	hash.failed = false;
 
 	gatt_db_foreach_service(db, NULL, service_gen_hash_m, &hash);
-	bt_crypto_gatt_hash(db->crypto, hash.iov, db->last_handle + 1,
-				db->hash);
+
+	/* Don't hash incomplete input, keep the hash and try again later */
+	if (hash.failed)
+		db->hash_id = timeout_add(HASH_UPDATE_TIMEOUT, db_hash_update,
+						db, NULL);
+	else
+		bt_crypto_gatt_hash(db->crypto, hash.iov,
+					db->last_handle + 1, db->hash);
 
 	for (i = 0; i < hash.i; i++)
 		free(hash.iov[i].iov_base);
@@ -563,41 +574,57 @@ bool gatt_db_isempty(struct gatt_db *db)
 	return queue_isempty(db->services);
 }
 
-static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
+static bool push_uuid_le(struct iovec *iov, const bt_uuid_t *uuid)
 {
 	bt_uuid_t uuid128;
+	void *data;
 
-	if (uuid->type == BT_UUID16) {
-		put_le16(uuid->value.u16, dst);
-		return bt_uuid_len(uuid);
-	}
+	if (uuid->type == BT_UUID16)
+		return util_iov_push_le16(iov, uuid->value.u16) != NULL;
 
 	bt_uuid_to_uuid128(uuid, &uuid128);
-	bswap_128(&uuid128.value.u128, dst);
-	return bt_uuid_len(&uuid128);
+
+	data = util_iov_push(iov, sizeof(uuid128.value.u128));
+	if (!data)
+		return false;
+
+	bswap_128(&uuid128.value.u128, data);
+
+	return true;
 }
 
-static bool le_to_uuid(const uint8_t *src, size_t len, bt_uuid_t *uuid)
+/* Pull a 16, 32 or 128 bits UUID taking all the remaining data in iov */
+static bool pull_uuid_le(struct iovec *iov, bt_uuid_t *uuid)
 {
 	uint128_t u128;
+	uint16_t u16;
+	uint32_t u32;
+	void *data;
 
-	if (len == 2) {
-		bt_uuid16_create(uuid, get_le16(src));
+	switch (iov->iov_len) {
+	case 2:
+		if (!util_iov_pull_le16(iov, &u16))
+			return false;
+
+		bt_uuid16_create(uuid, u16);
 		return true;
-	}
+	case 4:
+		if (!util_iov_pull_le32(iov, &u32))
+			return false;
 
-	if (len == 4) {
-		bt_uuid32_create(uuid, get_le32(src));
+		bt_uuid32_create(uuid, u32);
 		return true;
-	}
+	case 16:
+		data = util_iov_pull_mem(iov, sizeof(u128));
+		if (!data)
+			return false;
 
-	if (len != 16)
+		bswap_128(data, &u128);
+		bt_uuid128_create(uuid, u128);
+		return true;
+	default:
 		return false;
-
-	bswap_128(src, &u128);
-	bt_uuid128_create(uuid, u128);
-
-	return true;
+	}
 }
 
 static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
@@ -608,7 +635,7 @@ static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
 	struct gatt_db_service *service;
 	const bt_uuid_t *type;
 	uint8_t value[16];
-	uint16_t len;
+	struct iovec iov = { value, 0 };
 
 	if (num_handles < 1)
 		return NULL;
@@ -621,10 +648,10 @@ static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
 	else
 		type = &secondary_service_uuid;
 
-	len = uuid_to_le(uuid, value);
+	push_uuid_le(&iov, uuid);
 
 	service->attributes[0] = new_attribute(service, handle, type, value,
-									len);
+								iov.iov_len);
 	if (!service->attributes[0]) {
 		gatt_db_service_destroy(service);
 		return NULL;
@@ -943,6 +970,14 @@ static uint16_t service_get_attribute_index(struct gatt_db_service *service,
 	return i;
 }
 
+static void push_chrc_decl(struct iovec *iov, uint8_t properties,
+				uint16_t value_handle, const bt_uuid_t *uuid)
+{
+	util_iov_push_u8(iov, properties);
+	util_iov_push_le16(iov, value_handle);
+	push_uuid_le(iov, uuid);
+}
+
 static struct gatt_db_attribute *
 service_insert_characteristic(struct gatt_db_service *service,
 					uint16_t handle,
@@ -956,7 +991,7 @@ service_insert_characteristic(struct gatt_db_service *service,
 {
 	struct gatt_db_attribute **chrc;
 	uint8_t value[MAX_CHAR_DECL_VALUE_LEN];
-	uint16_t len = 0;
+	struct iovec iov = { value, 0 };
 	int i;
 
 	/* Check if handle is in within service range */
@@ -980,17 +1015,12 @@ service_insert_characteristic(struct gatt_db_service *service,
 	if (!i)
 		return NULL;
 
-	value[0] = properties;
-	len += sizeof(properties);
-
 	/* We set handle of characteristic value, which will be added next */
-	put_le16(value_handle, &value[1]);
-	len += sizeof(uint16_t);
-	len += uuid_to_le(uuid, &value[3]);
+	push_chrc_decl(&iov, properties, value_handle, uuid);
 
 	service->attributes[i] = new_attribute(service, handle,
 							&characteristic_uuid,
-							value, len);
+							value, iov.iov_len);
 	if (!service->attributes[i])
 		return NULL;
 
@@ -1014,7 +1044,8 @@ service_insert_characteristic(struct gatt_db_service *service,
 	}
 
 	/* Update handle of characteristic value_handle if it has changed */
-	put_le16(value_handle, &value[1]);
+	iov.iov_len = 0;
+	push_chrc_decl(&iov, properties, value_handle, uuid);
 
 	if (!(*chrc)->value) {
 		free(*chrc);
@@ -1022,8 +1053,8 @@ service_insert_characteristic(struct gatt_db_service *service,
 		return NULL;
 	}
 
-	if (memcmp((*chrc)->value, value, len))
-		memcpy((*chrc)->value, value, len);
+	if (memcmp((*chrc)->value, iov.iov_base, iov.iov_len))
+		memcpy((*chrc)->value, iov.iov_base, iov.iov_len);
 
 	set_attribute_data(service->attributes[i], read_func, write_func,
 							permissions, user_data);
@@ -1349,7 +1380,8 @@ service_insert_included(struct gatt_db_service *service, uint16_t handle,
 {
 	struct gatt_db_service *included;
 	uint8_t value[MAX_INCLUDED_VALUE_LEN];
-	uint16_t included_handle, len = 0;
+	struct iovec iov = { value, 0 };
+	uint16_t included_handle;
 	int index;
 
 	if (!include || !include->value || !include->service || !service)
@@ -1363,19 +1395,14 @@ service_insert_included(struct gatt_db_service *service, uint16_t handle,
 
 	included_handle = include->handle;
 
-	put_le16(included_handle, &value[len]);
-	len += sizeof(uint16_t);
-
-	put_le16(included_handle + included->num_handles - 1, &value[len]);
-	len += sizeof(uint16_t);
+	util_iov_push_le16(&iov, included_handle);
+	util_iov_push_le16(&iov, included_handle + included->num_handles - 1);
 
 	/* The Service UUID shall only be present when the UUID is a 16-bit
 	 * Bluetooth UUID. Vol 2. Part G. 3.2
 	 */
-	if (include->value_len == sizeof(uint16_t)) {
-		memcpy(&value[len], include->value, include->value_len);
-		len += include->value_len;
-	}
+	if (include->value_len == sizeof(uint16_t))
+		util_iov_push_mem(&iov, include->value_len, include->value);
 
 	index = service_get_attribute_index(service, &handle, 0);
 	if (!index)
@@ -1383,7 +1410,7 @@ service_insert_included(struct gatt_db_service *service, uint16_t handle,
 
 	service->attributes[index] = new_attribute(service, handle,
 							&included_service_uuid,
-							value, len);
+							value, iov.iov_len);
 	if (!service->attributes[index])
 		return NULL;
 
@@ -1953,28 +1980,19 @@ bool gatt_db_attribute_get_service_uuid(const struct gatt_db_attribute *attrib,
 							bt_uuid_t *uuid)
 {
 	struct gatt_db_service *service;
+	struct gatt_db_attribute *decl;
 
 	if (!attrib || !uuid)
 		return false;
 
 	service = attrib->service;
+	decl = service->attributes[0];
 
-	if (service->attributes[0]->value_len == sizeof(uint16_t)) {
-		uint16_t value;
-
-		value = get_le16(service->attributes[0]->value);
-		bt_uuid16_create(uuid, value);
-
-		return true;
-	}
-
-	if (service->attributes[0]->value_len == sizeof(uint128_t)) {
-		uint128_t value;
-
-		bswap_128(service->attributes[0]->value, &value);
-		bt_uuid128_create(uuid, value);
+	if (decl->value_len == sizeof(uint16_t) ||
+				decl->value_len == sizeof(uint128_t)) {
+		struct iovec iov = { decl->value, decl->value_len };
 
-		return true;
+		return pull_uuid_le(&iov, uuid);
 	}
 
 	return false;
@@ -2005,6 +2023,7 @@ bool gatt_db_attribute_get_service_data(const struct gatt_db_attribute *attrib,
 {
 	struct gatt_db_service *service;
 	struct gatt_db_attribute *decl;
+	struct iovec iov;
 
 	if (!attrib)
 		return false;
@@ -2024,7 +2043,10 @@ bool gatt_db_attribute_get_service_data(const struct gatt_db_attribute *attrib,
 	 * The service declaration attribute value is the 16 or 128 bit service
 	 * UUID.
 	 */
-	return le_to_uuid(decl->value, decl->value_len, uuid);
+	iov.iov_base = decl->value;
+	iov.iov_len = decl->value_len;
+
+	return pull_uuid_le(&iov, uuid);
 }
 
 static void read_ext_prop_value(struct gatt_db_attribute *attrib,
@@ -2091,6 +2113,10 @@ bool gatt_db_attribute_get_char_data(const struct gatt_db_attribute *attrib,
 							uint16_t *ext_prop,
 							bt_uuid_t *uuid)
 {
+	struct iovec iov;
+	uint8_t props;
+	uint16_t vhandle;
+
 	if (!attrib)
 		return false;
 
@@ -2117,22 +2143,29 @@ bool gatt_db_attribute_get_char_data(const struct gatt_db_attribute *attrib,
 						attrib->value_len != 19))
 		return false;
 
+	iov.iov_base = attrib->value;
+	iov.iov_len = attrib->value_len;
+
+	if (!util_iov_pull_u8(&iov, &props) ||
+			!util_iov_pull_le16(&iov, &vhandle))
+		return false;
+
+	if (uuid && !pull_uuid_le(&iov, uuid))
+		return false;
+
 	if (handle)
 		*handle = attrib->handle;
 
 	if (properties)
-		*properties = attrib->value[0];
+		*properties = props;
 
 	if (ext_prop)
 		*ext_prop = get_char_extended_prop(attrib);
 
 	if (value_handle)
-		*value_handle = get_le16(attrib->value + 1);
-
-	if (!uuid)
-		return true;
+		*value_handle = vhandle;
 
-	return le_to_uuid(attrib->value + 3, attrib->value_len - 3, uuid);
+	return true;
 }
 
 bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
@@ -2140,6 +2173,9 @@ bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
 							uint16_t *start_handle,
 							uint16_t *end_handle)
 {
+	struct iovec iov;
+	uint16_t start, end;
+
 	if (!attrib)
 		return false;
 
@@ -2155,6 +2191,13 @@ bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
 	if (!attrib->value || attrib->value_len < 4 || attrib->value_len > 6)
 		return false;
 
+	iov.iov_base = attrib->value;
+	iov.iov_len = attrib->value_len;
+
+	if (!util_iov_pull_le16(&iov, &start) ||
+			!util_iov_pull_le16(&iov, &end))
+		return false;
+
 	/*
 	 * We only return the handles since the UUID can be easily obtained
 	 * from the corresponding attribute.
@@ -2163,10 +2206,10 @@ bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
 		*handle = attrib->handle;
 
 	if (start_handle)
-		*start_handle = get_le16(attrib->value);
+		*start_handle = start;
 
 	if (end_handle)
-		*end_handle = get_le16(attrib->value + 2);
+		*end_handle = end;
 
 	return true;
 }
-- 
2.56.0

