Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F9713A24B
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 18:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717440801; cv=none; b=LDMkur//pkpqCnTggWkfCUJTeZcyBKqjIGk0cUB6/sLfIcSwM4b5+FdQCAjGRKv9XEmVsRCEpFKbN37WwVZTwlwSrSXqtiys0eiyYGVMrVwOOsGs/bRW+LS5eo5gLrFNZxq+GKWgchnvpvkdDV9JFgHoQAwg+tik50fg/f/pE+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717440801; c=relaxed/simple;
	bh=Utr1b1s+QbLd3QWfNltY5j3vVWsGJaT5qjN1KF+2Gi0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqBpZH9zmHzOLd1lQMXRYc3JYFMutoOfldH7R59vYaFbxFDSfztyqRSvJ2FOpkfY9SMd0/uPJ2USGoVMWbnZTfWOuaS+PFTXNH0Xcn4VLz/hytXC1IBkpJqUaNdfNdp2hYEiepDfCtRyAmDSva6Iwu4Zd6ppCGeKNU/m2HeregA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xx4PUfLK; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xx4PUfLK"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4eb270d92eeso298905e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Jun 2024 11:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717440798; x=1718045598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GRcAJxyronPVZcX3Qf21BpeiFl3m59jKgvmWujKkls=;
        b=Xx4PUfLKXt0g/CiiuE4W97ZNDE8H52zonkuccCPBOEs3yLAtLZOYQw9UNkKfg7htof
         PLgaWXP++JT0mnRvJyYGZ7J1+k96qzjynsXzE264sMtg79iYyGcr15CHNyUs/8VU2wAe
         YqzdHTuooE7gPC7lVxFXoLw18h8c7AKs5m0GEJVB3blSZy8njl8uHCMn+h4nIqIpsEZs
         FCBCuxbUafGKPgtW66YMV5oxzJP0waWjMkGkWxazDksFYwl29ZkzVZLT8KlQQXfgKR+k
         WnBJDDGXs8Vbuo5GyTqRGbjXKkJu1oy6jM+7AWudUN1K9PbyQcIUf5+5M98uvWJMKU9r
         1QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717440798; x=1718045598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GRcAJxyronPVZcX3Qf21BpeiFl3m59jKgvmWujKkls=;
        b=D6zPqRXq5rDb7AjuACaa272aVeHCOQXjVJk7Iab+6v4ibg6DL82f1qaJgBT5gzQWZD
         tqDAcmEm9beGbWR40W5FtJgDpzlUHIBmg4nqhW5AE7QY9ZfDsP5/u4vpD063sK/r1UHE
         GXWW1TbbdEEeFF+4GEq+S474pHrEQZBCsAOBAL0ae+kip8BnRzZeaCY9aEbWaGIDnMry
         mwilAMc18E+yKNC60RZ+4nC2zBlj4BjmRwn+BnTMcyigM6mD4ANbiQdUSluGq+eY/5+P
         wg4UYZ4t0boZUVZQNnusZJOsBC4OXBdmLQ42OEdKiJOARjPGOMEAX/mZAG4X93bPRhyQ
         6vCQ==
X-Gm-Message-State: AOJu0Yw8W5EAlJbEPF4QKDTs2IdF2aPLe9QyLyrtRAdNTlrowIfC0lM+
	zfrzLtiYqCM8wd8+nulKiKwjDCau2ksA4SAnlxLAIttsWAN36RXwbanTgQ==
X-Google-Smtp-Source: AGHT+IHCr5IIETawENqUgJlC7U8Zh0yXWmG1PveESInD0f2bXd46/1kkVYd6ZUbZzsB3W5Af3bIrBw==
X-Received: by 2002:a1f:7284:0:b0:4e4:ecf6:c7fa with SMTP id 71dfb90a1353d-4eb02ea92a5mr8384412e0c.15.1717440798161;
        Mon, 03 Jun 2024 11:53:18 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4eafecbab81sm1231658e0c.0.2024.06.03.11.53.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 11:53:16 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] set: Attempt to use existing set gatt-db
Date: Mon,  3 Jun 2024 14:53:12 -0400
Message-ID: <20240603185312.162337-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240603185312.162337-1-luiz.dentz@gmail.com>
References: <20240603185312.162337-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Most sets should be clone of each other, or at least very similar, so
this attempts to clone the existing gatt-db of the first member found
when connecting new sets, this substantially speed up the process of
bonding sets if their database matches which is something that is
currently ranging from 20-30 seconds depending on the manufacturer and
with this changes it cuts 5-10 seconds by bypassing discovery all
procedure of other members.

If the dbs don't really match bt_gatt_client instance will attempt to
rediscover the ranges that don't match.
---
 src/device.c         | 21 +++++++++++++++++++++
 src/device.h         |  1 +
 src/set.c            | 22 ++++++++++++++++++++--
 src/shared/gatt-db.c |  4 ++--
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/src/device.c b/src/device.c
index 620bbd55ebad..5dc1cd0cdbf2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6994,6 +6994,27 @@ struct gatt_db *btd_device_get_gatt_db(struct btd_device *device)
 	return device->db;
 }
 
+bool btd_device_set_gatt_db(struct btd_device *device, struct gatt_db *db)
+{
+	struct gatt_db *clone;
+
+	if (!device)
+		return false;
+
+	clone = gatt_db_clone(db);
+	if (clone)
+		return false;
+
+	gatt_db_unregister(device->db, device->db_id);
+	gatt_db_unref(device->db);
+
+	device->db = clone;
+	device->db_id = gatt_db_register(device->db, gatt_service_added,
+					gatt_service_removed, device, NULL);
+
+	return true;
+}
+
 struct bt_gatt_client *btd_device_get_gatt_client(struct btd_device *device)
 {
 	if (!device)
diff --git a/src/device.h b/src/device.h
index a2b7bb15d200..0794f92d0178 100644
--- a/src/device.h
+++ b/src/device.h
@@ -66,6 +66,7 @@ struct gatt_primary *btd_device_get_primary(struct btd_device *device,
 							const char *uuid);
 GSList *btd_device_get_primaries(struct btd_device *device);
 struct gatt_db *btd_device_get_gatt_db(struct btd_device *device);
+bool btd_device_set_gatt_db(struct btd_device *device, struct gatt_db *db);
 struct bt_gatt_client *btd_device_get_gatt_client(struct btd_device *device);
 struct bt_gatt_server *btd_device_get_gatt_server(struct btd_device *device);
 bool btd_device_is_initiator(struct btd_device *device);
diff --git a/src/set.c b/src/set.c
index bf35ee403b39..4ca2f78c3702 100644
--- a/src/set.c
+++ b/src/set.c
@@ -28,6 +28,8 @@
 #include "src/shared/queue.h"
 #include "src/shared/ad.h"
 #include "src/shared/crypto.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
 
 #include "log.h"
 #include "error.h"
@@ -277,8 +279,24 @@ static void foreach_rsi(void *data, void *user_data)
 
 	bt_crypto_unref(crypto);
 
-	if (!memcmp(ad->data, res, sizeof(res)))
-		device_connect_le(set->device);
+	if (memcmp(ad->data, res, sizeof(res)))
+		return;
+
+	/* Attempt to use existing gatt_db from set if device has never been
+	 * connected before.
+	 *
+	 * If dbs don't really match bt_gatt_client will attempt to rediscover
+	 * the ranges that don't match.
+	 */
+	if (gatt_db_isempty(btd_device_get_gatt_db(set->device))) {
+		struct btd_device *device;
+
+		device = queue_get_entries(set->devices)->data;
+		btd_device_set_gatt_db(set->device,
+					btd_device_get_gatt_db(device));
+	}
+
+	device_connect_le(set->device);
 }
 
 static void foreach_device(struct btd_device *device, void *data)
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index d8d21392fee6..16abcba2ec1c 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -278,8 +278,8 @@ static void service_clone(void *data, void *user_data)
 	for (i = 0; i < service->num_handles; i++) {
 		struct gatt_db_attribute *attr = service->attributes[i];
 
-		/* Only clone values for characteristics since that is
-		 * cacheable.
+		/* Only clone values for characteristics declaration since that
+		 * is considered when calculating the db hash.
 		 */
 		if (bt_uuid_len(&attr->uuid) == 2 &&
 				attr->uuid.value.u16 == GATT_CHARAC_UUID)
-- 
2.45.1

