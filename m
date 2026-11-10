Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346530;
	b=4sSmcLW1TfOAj+FONZAITTbA5lx8iQbLbB0+cKAjy3glOzK6lFYiG9eP85eB2vUX2Xgr
	 1sY1HOvG1vi+ch9raRYIjdfHmwjACZ9isE74r/HKN+En483KwV/RKT97JoeyMCAFCSD5s
	 Hj8fAuC8cH8r0pmUiwEHT85dRDC/4wtGKcS0bMZemFhKlmmdzXVk7VOogr3EO7/i74iRl
	 gFt3oX4gVi6/7Zyz160yv2V3/A+9MqRvutcx93KIDZAM9OmGUAFmjnhlNjdO+vWg0/zmz
	 z1q7eH+OwG01H82qiqsStMTZ2CkzNM7S+uq9Ms7Ig+veYDqNA97LRrOcTf2VheoIeDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LKC3z2pRL2BepN28bm/DvmmljY6VFeRK6Dn5WER5/bM=;
	b=pLPPwtBPJr9i8zCHKxjiBYs7Sl/S81tFv29cY/FK8dmNvMNibRJd6xG9+LPHDL+2n7r6
	 r2WBrP3nuTb4er4xL4t1j16m7aATOZUgIw0XY0aov8xGOk7IN8eicArjJKF2d1HbSi8G6
	 2PRLf8knS5QZOiWJlChHA0RD6uC8K1qVgpfnvICtGN9TAuo9nUUFL7gKrmEcvYCe0eOvO
	 SO3/inKa4xnQ0BfzjLmlW5zeJKL25mAivGdVOgTuJqqyFs1L/kKdsMISmG+enc+0t3vTS
	 Q+K1Fct4vrSISVG49LfNhD6KGoFla7zA8r+qkkZFbm7NyGTgkF1D41AThAnyNLkXceQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k8QQC5Zn;
	arc=none smtp.remote-ip=209.85.221.179
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29917606A32E
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 21:35:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29917606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k8QQC5Zn
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so1817066e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 13:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794346529; x=1794951329; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LKC3z2pRL2BepN28bm/DvmmljY6VFeRK6Dn5WER5/bM=;
        b=k8QQC5Zn8IzFgWj9SbkKdqZMSn2LFCAmFYfoZUm9xdPI5cVLoYvDwBH7AlMhz6mTFJ
         qLLGruuF+BJXHiIqKl6RUkG54jeKF9gAhY8bD6zOwOb7eUacSVZHdfNTE5OOTwD0Y7+W
         asWaaZiPVOY3flUOSqDm8TGk4vUcLNBk06NVyowbW0ye/hUqfiJfjd0jfdo2rtOUQLh9
         MTOuKjDx7ecOrN3Hu2P9HcKx6twd1vUmRnZmb58xECuPG77ZspkCi8ssdCRYBEIdq63V
         SSq5iZprvGAjntEHYQhXTGlbVO9ZkqRwj4a0ybHPfBBqEiZtuwkAIIXNK0bJOWUhdee+
         yO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794346529; x=1794951329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LKC3z2pRL2BepN28bm/DvmmljY6VFeRK6Dn5WER5/bM=;
        b=vQx3uCYcRhH/4yMSjuE0R+3nVGzxZ7oY9k+/Ka9Cw92xJHXovchNXx0JQWGbWRTxjD
         5u/QRlTgGKnrtrV6/buhBryQseNKE9itYL3DWquZ2BoiuvcaVR9XNB4Yloy9hjhneEne
         szr2XrYX8QLPTkwLNG1iBuznbQaZ2KbE/gsfzbg6emjkAPqcCG0w09L7SSupBeSWNli8
         EVx26UU97UcRi09g4XO734AW4WqEXoiR+gm5UM6bduAvdJ6bdzFxbd373Yr0lbzJjEGr
         RFeytxXS3N/ibg4mC9FG8U/HKKDus8AFtbt44jMRNAm5qCYv5K3Gm1Lz5H1KRVvogMZd
         Qz5A==
X-Gm-Message-State: APuU4Z828yYmcenqYHy9vlJDc8siCQyhsm3fAEHmsfCkJaCAs7axIgbF
	/I/QILdpPpyeUfHbs/h2FHH3LKMvR8S6tqRjO6+fx2fMkqxCW7V1KIr55OFOxw==
X-Gm-Gg: AYBFou19vKJ7/k7mXr8XjQGmwAR+vDvSwnAl4mru0aboADYbEj8iwJws6yAlk0XR6AG
	WP9JnnZ+4TmHIg3YAZLaAMsvICuYZs/29kw1W8neVR9F2KrpQGoWQ2nnJ5uzqp/Njz+mW0q6c/T
	i/LkNewPwQCxoaxZ8ErqWhu5qEyBCo4zOiv7mmiQh/pqeRGZ++LDGdI7KiOZ2W3qdqGwz305lE0
	Q5xzrhJTSZkaB23bhGpHPqiktuRmBElUqXeyixeVv6ptUPLqU0xVeC5EvmU5CpheRRZUZ/b1JPj
	FmAROBa5Bq/OuggEw+4YDf9Oue5NCqIIngdP5prNKRnnI7cag0cYtMpj8ZtdryVdA3eUr9fHuf2
	oxf+00fBknTvMEZrU18uTUrGkOBPC9tHnsWIxct/7GghvJqXS0zjm7ZW6uhVeeNw/2NuEdR65OY
	dJp+L5MJUvbE2EyA5z8tkHdsT9EWfiXQUvGdNsZzoqZNuIb+YuDAmaRFOjkL6rVcFjJ97JKCBVX
	BlNYw2CtTWMQf21kbBRbxkrci4v2qH7goWMW4SgJ4zX0swmrHD8FiyjHDCLuiGBr3Z6znVIZsED
	pYdifBbrfTgf6V4fafptVVHHjixKI4wfsJJvKHAe94Q38c8ZYrgqsGVaUwGWttOlIpZC6fVh0za
	VjuLmFHK8+XOiYhGQhXcEiUsWxcmaGzec4Suorg1/g3tLhwEl6o+85iyhhkoLk6VArS7Lczk3hw
	z94DaWQe7qkULBNXiUvrU3F9dy
X-Received: by 2002:a05:6102:6f05:b0:7be:25d4:7ff0 with SMTP id ada2fe7eead31-7d4edd1caf9mr111179137.4.1794346529082;
        Tue, 10 Nov 2026 13:35:29 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c614572sm2482189e0c.17.2026.11.10.13.35.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:35:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/5] shared/gatt-db: Use util_iov helpers to build and parse values
Date: Tue, 10 Nov 2026 16:35:21 -0500
Message-ID: <20261110213525.2942339-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110213525.2942339-1-luiz.dentz@gmail.com>
References: <20261110213525.2942339-1-luiz.dentz@gmail.com>
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

The hash input allocation is now also checked.

Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/gatt-db.c | 201 +++++++++++++++++++++++++------------------
 1 file changed, 117 insertions(+), 84 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 23c705bd9d16..3e9c3d6ae55f 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -377,8 +377,8 @@ struct hash_data {
 static void gen_hash_m(struct gatt_db_attribute *attr, void *user_data)
 {
 	struct hash_data *hash = user_data;
-	uint8_t *data;
-	size_t len;
+	struct iovec iov = {};
+	bool with_value;
 
 	if (!attr || !attr->value)
 		return;
@@ -391,30 +391,31 @@ static void gen_hash_m(struct gatt_db_attribute *attr, void *user_data)
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
+	if (!iov.iov_base)
+		return;
+
+	util_iov_push_le16(&iov, attr->handle);
+	util_iov_push_le16(&iov, attr->uuid.value.u16);
+
+	if (with_value)
+		util_iov_push_mem(&iov, attr->value_len, attr->value);
+
+	hash->iov[hash->i] = iov;
 
 	hash->i++;
 
@@ -563,41 +564,57 @@ bool gatt_db_isempty(struct gatt_db *db)
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
@@ -608,7 +625,7 @@ static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
 	struct gatt_db_service *service;
 	const bt_uuid_t *type;
 	uint8_t value[16];
-	uint16_t len;
+	struct iovec iov = { value, 0 };
 
 	if (num_handles < 1)
 		return NULL;
@@ -621,10 +638,10 @@ static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
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
@@ -943,6 +960,14 @@ static uint16_t service_get_attribute_index(struct gatt_db_service *service,
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
@@ -956,7 +981,7 @@ service_insert_characteristic(struct gatt_db_service *service,
 {
 	struct gatt_db_attribute **chrc;
 	uint8_t value[MAX_CHAR_DECL_VALUE_LEN];
-	uint16_t len = 0;
+	struct iovec iov = { value, 0 };
 	int i;
 
 	/* Check if handle is in within service range */
@@ -980,17 +1005,12 @@ service_insert_characteristic(struct gatt_db_service *service,
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
 
@@ -1014,7 +1034,8 @@ service_insert_characteristic(struct gatt_db_service *service,
 	}
 
 	/* Update handle of characteristic value_handle if it has changed */
-	put_le16(value_handle, &value[1]);
+	iov.iov_len = 0;
+	push_chrc_decl(&iov, properties, value_handle, uuid);
 
 	if (!(*chrc)->value) {
 		free(*chrc);
@@ -1022,8 +1043,8 @@ service_insert_characteristic(struct gatt_db_service *service,
 		return NULL;
 	}
 
-	if (memcmp((*chrc)->value, value, len))
-		memcpy((*chrc)->value, value, len);
+	if (memcmp((*chrc)->value, iov.iov_base, iov.iov_len))
+		memcpy((*chrc)->value, iov.iov_base, iov.iov_len);
 
 	set_attribute_data(service->attributes[i], read_func, write_func,
 							permissions, user_data);
@@ -1349,7 +1370,8 @@ service_insert_included(struct gatt_db_service *service, uint16_t handle,
 {
 	struct gatt_db_service *included;
 	uint8_t value[MAX_INCLUDED_VALUE_LEN];
-	uint16_t included_handle, len = 0;
+	struct iovec iov = { value, 0 };
+	uint16_t included_handle;
 	int index;
 
 	if (!include || !include->value || !include->service || !service)
@@ -1363,19 +1385,14 @@ service_insert_included(struct gatt_db_service *service, uint16_t handle,
 
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
@@ -1383,7 +1400,7 @@ service_insert_included(struct gatt_db_service *service, uint16_t handle,
 
 	service->attributes[index] = new_attribute(service, handle,
 							&included_service_uuid,
-							value, len);
+							value, iov.iov_len);
 	if (!service->attributes[index])
 		return NULL;
 
@@ -1953,28 +1970,19 @@ bool gatt_db_attribute_get_service_uuid(const struct gatt_db_attribute *attrib,
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
@@ -2005,6 +2013,7 @@ bool gatt_db_attribute_get_service_data(const struct gatt_db_attribute *attrib,
 {
 	struct gatt_db_service *service;
 	struct gatt_db_attribute *decl;
+	struct iovec iov;
 
 	if (!attrib)
 		return false;
@@ -2024,7 +2033,10 @@ bool gatt_db_attribute_get_service_data(const struct gatt_db_attribute *attrib,
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
@@ -2091,6 +2103,10 @@ bool gatt_db_attribute_get_char_data(const struct gatt_db_attribute *attrib,
 							uint16_t *ext_prop,
 							bt_uuid_t *uuid)
 {
+	struct iovec iov;
+	uint8_t props;
+	uint16_t vhandle;
+
 	if (!attrib)
 		return false;
 
@@ -2117,22 +2133,29 @@ bool gatt_db_attribute_get_char_data(const struct gatt_db_attribute *attrib,
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
@@ -2140,6 +2163,9 @@ bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
 							uint16_t *start_handle,
 							uint16_t *end_handle)
 {
+	struct iovec iov;
+	uint16_t start, end;
+
 	if (!attrib)
 		return false;
 
@@ -2155,6 +2181,13 @@ bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
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
@@ -2163,10 +2196,10 @@ bool gatt_db_attribute_get_incl_data(const struct gatt_db_attribute *attrib,
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

