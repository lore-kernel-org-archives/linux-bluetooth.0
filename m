Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDFA25E476
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742824172; cv=none; b=hUKAqTTw/U3SwIgeNxvBIYbAvwkAmx6aXdFabQHIej4ttfCVgE8IYuW5hN4igmrCTaObTRormwmYClhrVyVFbXrclzqBDDIT8wmBaJEVtmuAaiiEZVbYY6VhUSv41H4XzyULlN/LAdtLraGwCMqaKYgtqbgFMC/9/KqQKjmZSAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742824172; c=relaxed/simple;
	bh=twyj47WMg4IFJ0gOy9506DV1Qq8RF2mGfLyWQnLYyrk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miSRXszjYXT2APt9gV7iraUph+Zejggrma9SuFugPWJDV4WJgK58BUT1V0GUJdnfoioJS+k5/3LQN24ehzvM3iXYRtlLlPCAHX76g2W9zPqhbicxsWKPGEz+nihg8JExV1g4geyibtXfak10Jnsz0G6zDqi6mCYdeYEdJc3dOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euZ1v3gc; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euZ1v3gc"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-52446b21cfdso1896149e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 06:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742824169; x=1743428969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tatSE/r5CYak+9Z6BPPWFBTkdHhGdx0ulDG7+j/WkEQ=;
        b=euZ1v3gc9m8ySy0oadKU0eDFJDqx6Du4TJgzoL0K9D2as5504Wn+AhTZlKCYISVJoD
         +YZi7YhtWQIS7gzJwjzuG95U9jNNCC2qY4flQP66tIohq29H0PBqkvgmCHJVUfjNDC1Q
         mSr6sc/sclGvwba6o7De9FlFmr1vRlbcWKd1bxWnCqBZJZse0bbbT+2T3tCL+AeT82po
         sMsP93KyRxKDNpJdqujcwZJuQzBXKtkdc8vNHo/22atvBYKlxYwhTpr4Xb8iQLZ396Zi
         RMo0AGZ+b6SduXPM3INJJ1MFK0TEAAykWt9SOAcZvXkWStxAcl03MwyS6eyG4eHvTpx+
         IWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742824169; x=1743428969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tatSE/r5CYak+9Z6BPPWFBTkdHhGdx0ulDG7+j/WkEQ=;
        b=dQdbRUgUdpOnjda4uvfVWxNUCckt+b4XfgrEVLDQ2jC2h3K0m8e7veC68MBaWq8Cd3
         yRv3ui8UBwnGr00+2dTJnLhbqRjWmSUIYRwh5R5K9vECQkJhdLv9O5R8Ydwd1M82RAYz
         8OwF3PF8oQMAD+s+R9mdZzc4RCs+NIVIac9Ef8sY8MUDQMApNqIw+uGwICFG4ed96bXi
         V+6g7c+X0DmecT1UJCWuWCKznxq1EL3BFL1/SLbksWPOSXTpspfwKnvMdUPkoafyvitn
         iq8j/zzfv146lie23294Jg8Vk/hOoMbfrhiDEoDcm1lJLOj7jrXi+cMOd4BrfNc2H1jQ
         RcEw==
X-Gm-Message-State: AOJu0Ywt+USN8Dp0poQieivE8Lxwn3JcinH3ZQS/wfneDH0q1VeWmmJK
	ebuAH+2lZ0uBnOZ+EokpaKzldUqktao0DrKZIITyRU9dAF1s4s7WDBUdlOnS
X-Gm-Gg: ASbGnctpONIY1K2dm1bFstf0BmMCxTvArAYW/fLGRHIJpwIo7bcoixDi1ohUB2H25lV
	ZZe3/xuKHJcyaO7tMZm5CE96BjRA6wAw29q952TJZb63ClRaoZftXlfrHl7zQcjCbpIUW/6J+Ol
	I5+EgqL4zKHeZN69hdiVtzVzXsCbAviIzIW/OUR9QYk4DoUYv0FJo5XmVaYq09EsE9aik8pKQTi
	FmHZmMGIg6dnKhjnW0k8FBhpZqsnY7syjuLTsVZ8ZhhCWJDSY831tVZ0ygu4k/ev7kNSjZ5OiLU
	NQKqm4efZweKgpMnAewQNzM9Oa4VTZkg0pTT+JYtQpS4xofyJBHdmi8SNyE1yNp7Htyq01W5mf0
	WaOtd3tEZnXHy5hyW7Jx6F10a
X-Google-Smtp-Source: AGHT+IHPobpqo6A+UtRm6pOSHdDMdACVWOaJolFVZMGqxstcTwvmjQMNPaky0B4RPbRxJ4wr6bKt+Q==
X-Received: by 2002:a05:6122:4013:b0:518:7ab7:afbb with SMTP id 71dfb90a1353d-525a8519e0bmr7738796e0c.8.1742824169071;
        Mon, 24 Mar 2025 06:49:29 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a73ed878sm1398381e0c.26.2025.03.24.06.49.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:49:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/5] gatt-database: Fix always registering CentralAddressResolution
Date: Mon, 24 Mar 2025 09:49:18 -0400
Message-ID: <20250324134920.2111414-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324134920.2111414-1-luiz.dentz@gmail.com>
References: <20250324134920.2111414-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

CentralAddressResolution shall be conditional to LL Privacy to avoid
peripherals assuming Directed Advertising can be used which may lead
to issues like:

Fixes: https://github.com/bluez/bluez/issues/1138
---
 lib/mgmt.h          |  1 +
 src/gatt-database.c | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 6a397645bcf2..6af82fc4a1a5 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -104,6 +104,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_CIS_PERIPHERAL	BIT(19)
 #define MGMT_SETTING_ISO_BROADCASTER	BIT(20)
 #define MGMT_SETTING_ISO_SYNC_RECEIVER	BIT(21)
+#define MGMT_SETTING_LL_PRIVACY		BIT(22)
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
diff --git a/src/gatt-database.c b/src/gatt-database.c
index 239a0dc72be9..1498720ad5a4 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -749,7 +749,7 @@ static void gap_car_read_cb(struct gatt_db_attribute *attrib,
 		device = btd_adapter_find_device_by_fd(bt_att_get_fd(att));
 		if (device)
 			value = btd_device_flags_enabled(device,
-					DEVICE_FLAG_ADDRESS_RESOLUTION);
+						DEVICE_FLAG_ADDRESS_RESOLUTION);
 	}
 
 	gatt_db_attribute_read_result(attrib, id, 0, &value, sizeof(value));
@@ -873,10 +873,13 @@ static void populate_gap_service(struct btd_gatt_database *database)
 {
 	bt_uuid_t uuid;
 	struct gatt_db_attribute *service, *attrib;
+	bool ll_privacy = btd_adapter_has_settings(database->adapter,
+						MGMT_SETTING_LL_PRIVACY);
 
 	/* Add the GAP service */
 	bt_uuid16_create(&uuid, UUID_GAP);
-	service = gatt_db_add_service(database->db, &uuid, true, 7);
+	service = gatt_db_add_service(database->db, &uuid, true,
+						ll_privacy ? 7 : 5);
 
 	/*
 	 * Device Name characteristic.
@@ -898,15 +901,19 @@ static void populate_gap_service(struct btd_gatt_database *database)
 							NULL, database);
 	gatt_db_attribute_set_fixed_length(attrib, 2);
 
-	/*
-	 * Central Address Resolution characteristic.
-	 */
-	bt_uuid16_create(&uuid, GATT_CHARAC_CAR);
-	attrib = gatt_db_service_add_characteristic(service, &uuid,
+	/* Only enable Central Address Resolution if LL Privacy is supported */
+	if (ll_privacy) {
+		/*
+		 * Central Address Resolution characteristic.
+		 */
+		bt_uuid16_create(&uuid, GATT_CHARAC_CAR);
+		attrib = gatt_db_service_add_characteristic(service, &uuid,
 							BT_ATT_PERM_READ,
 							BT_GATT_CHRC_PROP_READ,
 							gap_car_read_cb,
 							NULL, database);
+	}
+
 	gatt_db_attribute_set_fixed_length(attrib, 1);
 
 	gatt_db_service_set_active(service, true);
-- 
2.48.1

