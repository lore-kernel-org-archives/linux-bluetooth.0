Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C4825EFBA
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742823686; cv=none; b=QoN7gdYGeNVr5kbcU9v256wtP5Pblo3uXKGj7VC/F0QCT8UpAT+/FANCEzsjljRGk02g91TNW3dm6xhEaX1iMVH8fwE4QldHa0ARoVi6yBOZRKqERu8Bzns23T047siS829pKVR61Mj8aHokhZ4bGbIJ0VfQUbspSNL8R1ggdP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742823686; c=relaxed/simple;
	bh=twyj47WMg4IFJ0gOy9506DV1Qq8RF2mGfLyWQnLYyrk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZXqVfIjNTQDF3XoBHdjPbkE9CvVQSbzuNOq70A36+P9QYWviNrCcjodDtmOm9SUjlgrqeUkQ1LxkzKi3T+ARahi4jVhnSxyOnIC4mwZH+fx/an17iq1rZUBM4EDagDkSN88LDTQnGHHJh+5CPypZsr7i5aKOE8DvMLk5zkdPATo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brd/eWEG; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brd/eWEG"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-523ee30e0d4so2118452e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 06:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742823683; x=1743428483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tatSE/r5CYak+9Z6BPPWFBTkdHhGdx0ulDG7+j/WkEQ=;
        b=brd/eWEG8ivXXsBJf+tQ30h66TX5l5Pa1+5EwlQ7RxRBeeNRPwmKCb9nRrLG5pG4BL
         Lb+nRJg3ehNkjmOKpRQVcmzgQvTcGzG/cuk5JIPg//HOTVbJMA8xJyo4j5vbbkca+9u1
         5JDzT1hBctH3LhOVMdeBh5BK7a11Bx1ByDTwPmBj/DHADw1+V2EnvA4mr+MLkRI3c62+
         e/xIrIGjMFYOf3WUijAn36itVqkrD5fr6RgnuCMnCi4tfoTC/UnQ0Q0KWgaGtUSAEP9y
         jvfc3QSsJTCQ4mFO+1mdoqzkTnTQRGc7HTuCEQe3YvfdyurQqCrc1T76qBrMjT4tyOUy
         s8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742823683; x=1743428483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tatSE/r5CYak+9Z6BPPWFBTkdHhGdx0ulDG7+j/WkEQ=;
        b=DTr7WKnMieiefA4y1djh+jkDkbky2mVmKLGsVftyIccETL9kDkNqopw9RXUOaEX7Xu
         9qhxPvT1IzkQP0QSb5ccRBkE30Vl60rj+AlptUZR8RZIVrjvG8bxmoFX3fYkKVzj4a07
         QNZrjeG5jUrXm1vt57YPEgGAec05B5iZSA9q5xwtZhijBXGkMBBrZh6DASJHudiJ5+iE
         dzUT76inosibgqH+V1URMDD90XLKNgZuyiMaPXwnS9sIJs5detoLydc+Ds1B3vdU/DKj
         /RAQ5IwKZ8V1N5A7O/hzf/T1wCR3oBmUhXR17Qy4nMv8hOxFnhhnLCWmoHameVzFVoRI
         WUng==
X-Gm-Message-State: AOJu0YwAZo9bfM/5DJWoiwPUsAaLm6p2DreeRA+cHoz4HbQ9t318Rugk
	N044lH2iL363KJ9m9ZUXjvDicLAisjBpJ0YdJN0ZdRDnZm/MTlWwQZlgHdPB
X-Gm-Gg: ASbGnctyFvJt6MjOnqtfB58U767GtFHA2/1Caw6V760FhkCSVJAwu9W8W4HKD7WyrCg
	3cVN/UvbTvHX7VUPHQptfN9jIkznEEirmq6eM7PQNHB0QsiM7e3i+T7D9Q3IJymdEQArsrUgApO
	p5mZt5SxGocVX6+XUCDDIhhjCcU+gi6b3jK1P6l6D3G9zZI8SLA1Y+hOhRwhtrjt1DkszY25TK8
	zKXkXt6G2ij9zali/MuCWOassSgvxAtJLGCi40AcDxmX+Yy0JMWau+0vSJ3fWIAC19VZLf6xs2e
	YYuxtyIVjQBAvIenUCca1VB6YRcCPqBMCfwubp2uEUox95AAXd+QJzad8el9U6XjNkbAtNdc3U+
	w0MTF/FR5Cg+Lmg==
X-Google-Smtp-Source: AGHT+IHtIT+BjsGRcABsUiCfTJ6eDZ6A7g1ifmXINhmmt7j+wJMC5MoD8kp2DsOqKi2o9rZ+o3HxTg==
X-Received: by 2002:a05:6102:94c:b0:4b9:bd00:454b with SMTP id ada2fe7eead31-4c50d5267b4mr8278348137.13.1742823683224;
        Mon, 24 Mar 2025 06:41:23 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c50bc11d7asm1564850137.12.2025.03.24.06.41.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 06:41:21 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/5] gatt-database: Fix always registering CentralAddressResolution
Date: Mon, 24 Mar 2025 09:41:10 -0400
Message-ID: <20250324134112.2108216-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324134112.2108216-1-luiz.dentz@gmail.com>
References: <20250324134112.2108216-1-luiz.dentz@gmail.com>
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

