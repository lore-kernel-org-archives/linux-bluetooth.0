Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1D212C461
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 15:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715353783; cv=none; b=bId96yj9vCPfx6V0Dzo2yosVXpQyNT199PS08CJhakQkxsWAoJMEwpew8otPUB2MIzb6RjF2/AIikosk4fxv1KzDsAGrgvZUBe6dnWBpQeb/G5Awh0X0WbSSZ0d3c+a5sHsBEHTZsHbZeyVCcQf1fc0uORY6XXY8K5vInDR0AQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715353783; c=relaxed/simple;
	bh=pKT4XZRJiT2XEYiakeoujvfG6MFJfdzhucZn7yPT3y8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WzIYtlaGaBCOyISh3C0O/4Z9MPzsMbkxCIq4IAZmKyUook1KHvokbBzcNxNcoxAU58z8Vcw1wBgaH/FBpAzoCp3yox2DoulxIAAePAsyHFc9AK3hvm1gg4oGEC9n4yg9NrfA35HNLme6oY68uDSGqDrWuWog6hy7w6xeMqpty7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtqkewZq; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtqkewZq"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-47eff2a6699so736841137.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715353780; x=1715958580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TKr1PFTun9Ztejswu5ybhumSHAh4M/2Oe9Hkl89jau8=;
        b=PtqkewZqMl7vOwIYo8LeU5hlM192wRoNAUgA40zrMDCdgmHRejwHHo/buCx2Pnt/b1
         7Y8QJ2N1bfkLrdmwYmojVvKh3u5Q0mlF9nW1GSBSFiry3uYas/KaD2drYWxtHJbJC4Ev
         QmqOyb/T/zAat7xcLjiusEnrGFwQr5RYZgXU6D+XeqbtAezPd9EALuemhpYgufRNf1PQ
         k9/xLbkbnrZSgkmz0IVBbnHonFKPOXZh7c4eJYs5cCzNLtYlbks96sLolU5nEc0Ryt0N
         dYca8iw/jw7xlMVXC2KcZAks0x+FdTVo5j1IROWm6x5K4uJv8YBUYCy/YUrEwLzfKzHX
         6dKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715353780; x=1715958580;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TKr1PFTun9Ztejswu5ybhumSHAh4M/2Oe9Hkl89jau8=;
        b=wpKMHA7sepdatlSTkbDGgZHbzwJhoL3/TFAzAJRT62ODDGJ+g5GkxNuETMK5603hnU
         GeTHB0QGHAlty5gS0Ynii6BO9nOgJTrOvm+8f7qKhw+ThdJ8z62HrhuVeWYQWuykIsw5
         +F0Ic75CqtqQHdeLWHL2wDtf1BlzyutkYExM5xUwFejeDWmT5zxTtDhSayUk7skGI4W7
         b/jO65iO4KMI0fhC2R8/s/0FmXZJywxikmVODq7f8AZl2jw4RL/DDx8KdP7gjWmPUjJ6
         KRS927xlq9XLnnwBArMQuASd5+EbpKtnpV/PaivSswD1hZrk6nW4+Jy/BbH4aZYHTN0o
         rcsA==
X-Gm-Message-State: AOJu0YyMFAdduu7B2hrwyLGd6Eu/haH6FMnmECH/JKf8nUhrrZS5zIIy
	5ay+6lz69RYHwHVVaGm7AB41FqXtTBenEvpEY1gDuoEAJf87O7z4K9sgFg==
X-Google-Smtp-Source: AGHT+IF4tIWdLjw1Ciyg7vOq6+2L3NgEM7PDPvlMwejk/WEtRZ70NFxmpr4QbvmCM0EdIEP9MCkNQg==
X-Received: by 2002:a05:6102:3e86:b0:47c:2599:9d99 with SMTP id ada2fe7eead31-48077ea51cdmr3124743137.31.1715353780176;
        Fri, 10 May 2024 08:09:40 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4806cb008d2sm510050137.2.2024.05.10.08.09.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:09:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/4] profiles/gap: Some code cleanup
Date: Fri, 10 May 2024 11:09:35 -0400
Message-ID: <20240510150938.1492169-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Felipe F. Tonello" <eu@felipetonello.com>

Just removing unecessary function and code duplication.
---
 profiles/gap/gas.c | 42 ++++++++++++++++++++----------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 400818d67591..713b9aaf28f2 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -50,10 +50,18 @@ struct gas {
 	struct gatt_db_attribute *attr;
 };
 
+static void gas_reset(struct gas *gas)
+{
+	gas->attr = NULL;
+	gatt_db_unref(gas->db);
+	gas->db = NULL;
+	bt_gatt_client_unref(gas->client);
+	gas->client = NULL;
+}
+
 static void gas_free(struct gas *gas)
 {
-	gatt_db_unref(gas->db);
-	bt_gatt_client_unref(gas->client);
+	gas_reset(gas);
 	btd_device_unref(gas->device);
 	g_free(gas);
 }
@@ -152,7 +160,7 @@ static void handle_appearance(struct gas *gas, uint16_t value_handle)
 		DBG("Failed to send request to read appearance");
 }
 
-static bool uuid_cmp(uint16_t u16, const bt_uuid_t *uuid)
+static inline bool uuid_cmp(uint16_t u16, const bt_uuid_t *uuid)
 {
 	bt_uuid_t lhs;
 
@@ -188,11 +196,6 @@ static void handle_characteristic(struct gatt_db_attribute *attr,
 	}
 }
 
-static void handle_gap_service(struct gas *gas)
-{
-	gatt_db_service_foreach_char(gas->attr, handle_characteristic, gas);
-}
-
 static int gap_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -246,16 +249,7 @@ static void foreach_gap_service(struct gatt_db_attribute *attr, void *user_data)
 	}
 
 	gas->attr = attr;
-	handle_gap_service(gas);
-}
-
-static void gas_reset(struct gas *gas)
-{
-	gas->attr = NULL;
-	gatt_db_unref(gas->db);
-	gas->db = NULL;
-	bt_gatt_client_unref(gas->client);
-	gas->client = NULL;
+	gatt_db_service_foreach_char(gas->attr, handle_characteristic, gas);
 }
 
 static int gap_accept(struct btd_service *service)
@@ -266,13 +260,15 @@ static int gap_accept(struct btd_service *service)
 	struct gas *gas = btd_service_get_user_data(service);
 	char addr[18];
 	bt_uuid_t gap_uuid;
+	int err = 0;
 
 	ba2str(device_get_address(device), addr);
 	DBG("GAP profile accept (%s)", addr);
 
 	if (!gas) {
 		error("GAP service not handled by profile");
-		return -1;
+		err = -1;
+		goto _finish;
 	}
 
 	gas->db = gatt_db_ref(db);
@@ -285,12 +281,14 @@ static int gap_accept(struct btd_service *service)
 	if (!gas->attr) {
 		error("GAP attribute not found");
 		gas_reset(gas);
-		return -1;
+		err = -1;
 	}
 
-	btd_service_connecting_complete(service, 0);
+_finish:
 
-	return 0;
+	btd_service_connecting_complete(service, err);
+
+	return err;
 }
 
 static int gap_disconnect(struct btd_service *service)
-- 
2.44.0

