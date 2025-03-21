Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EEF91EF08F
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 19:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742586358; cv=none; b=KA0XLKYUvthNrjkbWIkezLY5VACdLkMDyKH/5wfuXOhti3uq7kqZs4zgUl3BiEdYla+jybKB11n2GF5C3Z07/WfPTwxnwBR9Cxx2P7XRLTonYSkmMZCql3yAn9hXze4BZwqDHZR+rBRGCrXuWCqXoNlKgQKLIfDo2UZYeFOlIic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742586358; c=relaxed/simple;
	bh=TsHcO60Doh/F9dJAx/j7knTU2Ga9Ykgsj+vLG8CDmtI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ktKLGK1MCv8T9bSlSKTjxGHp3ErSlJ0TB1mE5l4JkfeBDpzAKNhnOepIWaHrfyF2LNF/Cy3vw7eWurvqqn2BLzIRtBzwUlbbm/OS6tzAF371dpU1XBwiIVRi1MskjYjNqgrsg/fLAp5PmBV+mcYH+sF2iJZDv1HzGXQyoJ9FcrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiUH0srL; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiUH0srL"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-523ed8ac2a3so1143840e0c.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 12:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742586355; x=1743191155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W//AVeA/S/AgYB5djWx8LPevziOnuNP3pIFHfFSzRYk=;
        b=KiUH0srL3+xuib4WTdKWOnZjAD0NJqBjkM5Gl1Hy2MNXx8Kt4FHg6hzrlNuUGSm2bo
         d/pJEtSmfXdAw9lbwOlBLuZmrZM1DM/WQJlJMPn3uuG+AHHGFX9agD18l5/42KJeyfeU
         RxnXgCsRzSFx1/SERl46OAoFg+LvdXsCBTiJxbZq5bKr707eD2GmBXHumMq8ZFZMnOAS
         EFXCMW6oNzcNk1R8vSkh2UGeBmDtbqEG8kJNPKyzxXAY8Cg3Z5PpaHGOzc+JrGaNuerN
         b5tfjdq+RZj6iGqypos/eNDlq5oeYDdJVWP2NSaqvuWkKi1fL4tm75EAgPpho6PpRKko
         VpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742586355; x=1743191155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W//AVeA/S/AgYB5djWx8LPevziOnuNP3pIFHfFSzRYk=;
        b=ujRICPvyCAUXzO1P/7DvmKIFRoWFHI/RsaIQTx2gXVmMmFtA7zZHrFRHYAazd92XHG
         YXhcb7OxufMXrStrs0BSVUTrl21VuALJGJwpVlAqZrJhQ7az+Ct6F9IJGPCPMVKi16qy
         9Bvgrq/enFqwjUpzi6xZtr9aC4zKsXmXRiU4XcLpSgQPvCHzEv1Zc3K3/JDSPMvTSmds
         cI4RP1gOzJukFL7+F0Uz46c0zGVfKqurYptnKQtQqi/l/FzQUF+X82DiDIIWuVWY/cgz
         JSVRnmoe9Ts1nCcb1K4xA/9DOd6iV1SWQn6aIEeHAmr65rQ0omeiSFZyEN7i0R2jLpoo
         E4Gg==
X-Gm-Message-State: AOJu0YwntigBOtfq9PczOhGeo6ZGKfYH3UvGakJxNRb9I7UJ4P/SQ7qw
	yaeP6dB6YyL9ZjF6G7hd5iRrCD66vxOxEoHAGyEIZyAkxRI3ouKaCvSuzHped+A=
X-Gm-Gg: ASbGnctnL1Jnq28AxQ7PCERykdsVgUB4nyK/jjOYPXTky3ERQYJ2IyZyAOJFhgSLZPo
	sNEAj4J72u4Fq/ZGF6cyovPewm2CEEJoh4VUaN+Jg+AGDwHfgFvNF2o1d1WNAeIDNOClvqFM+Ee
	tMgBXWeMOAVYzQhedEPaWFPcFSgv72RGpokYSzRt3QxZEfC2MxCEkkDM2mbDpAmL3gaT3sdxmLI
	Z0Pd+WAMzGD8F4+Tw/eL/+lbD6ADLYa/Z/aq2cpp0xs0OyCzUIb7sz6mwuKJyXtssoyQLm1gUIC
	u1wI/P7ClgK6DxMkBbGcIj5BSl7y9Z/hieXEuuArXgpGMSzKLfmUxVxGclODmms42WYUk29pLWA
	yQByOXBcdX17NAg==
X-Google-Smtp-Source: AGHT+IFXgW18czDQNdbmmVXgPIiDNHqzXnlZ1ZTQpWv7cFGGONwzvPUmnC06U9SVz3lpbYWsxGj0Qw==
X-Received: by 2002:a05:6102:3ed3:b0:4c4:e0e0:f7bd with SMTP id ada2fe7eead31-4c50d5f1661mr4435609137.19.1742586354449;
        Fri, 21 Mar 2025 12:45:54 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86f9f47a3a1sm519917241.33.2025.03.21.12.45.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 12:45:52 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] gatt-database: Fix always registering CentralAddressResolution
Date: Fri, 21 Mar 2025 15:45:45 -0400
Message-ID: <20250321194545.1728631-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321194545.1728631-1-luiz.dentz@gmail.com>
References: <20250321194545.1728631-1-luiz.dentz@gmail.com>
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
 src/gatt-database.c | 30 +++++++++++++++++-------------
 2 files changed, 18 insertions(+), 13 deletions(-)

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
index 239a0dc72be9..a5706e61ce1e 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -740,17 +740,14 @@ static void gap_car_read_cb(struct gatt_db_attribute *attrib,
 					void *user_data)
 {
 	uint8_t value = 0x00;
+	struct btd_device *device;
 
 	DBG("GAP Central Address Resolution read request\n");
 
-	if (btd_opts.defaults.le.addr_resolution) {
-		struct btd_device *device;
-
-		device = btd_adapter_find_device_by_fd(bt_att_get_fd(att));
-		if (device)
-			value = btd_device_flags_enabled(device,
+	device = btd_adapter_find_device_by_fd(bt_att_get_fd(att));
+	if (device)
+		value = btd_device_flags_enabled(device,
 					DEVICE_FLAG_ADDRESS_RESOLUTION);
-	}
 
 	gatt_db_attribute_read_result(attrib, id, 0, &value, sizeof(value));
 }
@@ -873,10 +870,13 @@ static void populate_gap_service(struct btd_gatt_database *database)
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
@@ -898,15 +898,19 @@ static void populate_gap_service(struct btd_gatt_database *database)
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

