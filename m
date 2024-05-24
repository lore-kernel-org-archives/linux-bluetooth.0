Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B004712F37F
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 17:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570717; cv=none; b=iVpEU5VYvuicLYd9GMH0eSfV6lTGZIhhlv9WF825EQNHN5PRwTKXjeb5rOdOEq6JmstfDo1ct8ce2aUTNm8W3j/z6HDfl6xsgxGqlwNYcOdY/D//W+dEaibR/1qnFYuaNE2qbaO96/Dm18AvlrGvg3WQAGmSejnUQETfm2EcCiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570717; c=relaxed/simple;
	bh=HXWN0zTDul6ayGihyYGbtmkCozuuUhZ9B1AzDIze3rU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hl4YJ0j2SI8G3ejMUkFPT/dzRqW6b5MP24wEhQORpTC69rbb28xBBiJuVdh5UH5Fw6arSn/2fxanAnaFf9nR+//TJludtJAYC+WmZNGAtVGJ/RkitVqhzqqKaWRwBUOdkWlMwJOzbI/TSmLI1KecRztQ9ulVrCZkBZwtebkX1Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6SLJG0s; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6SLJG0s"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6f10092c8c7so4701035a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 May 2024 10:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716570714; x=1717175514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RsqxAXu1+uvHb4FWDtAGaP/L0RYLDqIjQFYbG0JlUA=;
        b=d6SLJG0sOP0Kuwb4y0k8vZtRsdWUM/HHbK45K4BQsfZJk65bIezUu5MdZbTH0CwBJQ
         dk4u7qhVC9V2/pTTL460tUtJa+HuXovfQIxAOc3L+AfrANHXS1W0lqPdDAL0dcAdM8h9
         dlOzDSejpaPwqrbwQIhkd99ySQx90yAfmoAa/M1sjNjdKR6W7E3RlOkqoAuZuGofD/Qt
         6zrNcj93KTy/V/0D5tv5fLKzBCj7OUEVzf49fcmLN4m3DxOXDgpGnDLevrnP7xgktKz/
         jR/JJgGPCDNF+vDJR/RCATMRmGLwlc4V4Pyt0fj7Jh0DXN676dK+sZMBeuGxCh4IxSzM
         mYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716570714; x=1717175514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RsqxAXu1+uvHb4FWDtAGaP/L0RYLDqIjQFYbG0JlUA=;
        b=ErZyqZCoDE0gWywmv4NJiPrvurGCqEQLfFkVDktbLrLyjII8ELvle+KZozoDZlw0Bc
         VAVizx+SYzeon7U+8AJRHtBOr+Y8Xhu41SX90Bn47eSQl9hZuHqL6DYXGf6+XpM1MXy6
         knHkdGhC1aG9u+xTpHvl6yDk5QtjqBcKCNRszEvQcgC3PgXD4tde86kjMnkdH6YJIOTo
         POHm3uN30MuaWG+IENtgRO6zDQNd62JCqBdSRMcUGfCFAZckUpx0nHq3mxFu5sAJUgRr
         75ktI0Nfl9DL3lZ0oSuDkD/0vOky7/ue3E3QrecBiutRNRZI6nzxFeZZPGciuZ1dMyYt
         CuRA==
X-Gm-Message-State: AOJu0YzMryHuFFxceGayCQvBBRypgXsFkh7L86QdxXv6xyOmo+wPqvYJ
	+LjiJFkLyEKqspQd0x36i065BBtKJjMrMnnO3G8iwxTvejQHBKhKBqb7Hg==
X-Google-Smtp-Source: AGHT+IGjWwcxbVUSypgOB0c21RsimQCZ1uwi29k3FAGAP7X7wDm4hYYMl5oV0Wg5obs3jqw7vii0ug==
X-Received: by 2002:a05:6871:829:b0:24c:aada:a58b with SMTP id 586e51a60fabf-24caadac300mr3054870fac.33.1716570713635;
        Fri, 24 May 2024 10:11:53 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-804cc1158ebsm256676241.29.2024.05.24.10.11.51
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 10:11:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] set: Attempt to use existing set gatt-db
Date: Fri, 24 May 2024 13:11:47 -0400
Message-ID: <20240524171147.2733570-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240524171147.2733570-1-luiz.dentz@gmail.com>
References: <20240524171147.2733570-1-luiz.dentz@gmail.com>
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
with this changes it takes a good 5-10 seconds.

If the dbs don't really match bt_gatt_client instance will attempt to
rediscover the ranges that don't match.
---
 src/device.c | 21 +++++++++++++++++++++
 src/device.h |  1 +
 src/set.c    | 22 ++++++++++++++++++++--
 3 files changed, 42 insertions(+), 2 deletions(-)

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
-- 
2.45.1

