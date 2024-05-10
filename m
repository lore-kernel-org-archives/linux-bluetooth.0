Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40FE17108A
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 15:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715353789; cv=none; b=MZUEI7xU3Vu3Hp07HdQb1BxWcAvgG1pPxt9SLfi1k2p7cZdPWJIOgmJ6+l5Q5wuE2v2ZoeY+80MPVJ1wEoaji/8I4j6VnDmDBCycyBgHstnRnySVaRkdH4NVyE/BuixzHstT+4D4pPmiw1gvv1QhQjMpixLZTDOSuT/zJtZCTnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715353789; c=relaxed/simple;
	bh=VpBIqUpo+QLnRCHMR8h3+FEQs4JEgsZ6vfhrhHL9L2M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EC2APF6LKcavv2bR+mkrp8g6/NvgF4012O7ot0N484Anv4ZYYbUsJcSwO+T9W08wE9Ulw32Ul/NVyAbwxgjXo7fJD+BLPzD5T6c1IYN1BiR91opapNuFPUux4Q6top08PXGO0C8IeXQA8Rngm/+sxJHX+fadCohLtKQeGr4lfGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+XAT2LC; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+XAT2LC"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4df76f2e3easo646415e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715353786; x=1715958586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5niJWmnTMJaWwLIzMOhrQKyuU/mu4Trq6xMfwRJ+dDA=;
        b=W+XAT2LCAeLHwOVSKjWmgoATYUvmDt7rNThcMatSnpeeTCvH4TDA3dzRpZJn2ZxiDy
         sjU4oQIzCJoRfzBo3WxfJj0dFoZPyHgrpKyv9kV7VpzLaYMAV1/sDjSxZoGqf48K4Jez
         lbSd1kNy7keAZ8nfM1mwnE8hzd7G1EllVGEeTJmDPatn9M/8hxt5R+4EeQZG8LyCs+OJ
         7aDFHUsFAUY0bzPm42GUIQiTG/SqDxmU+Wk72MXtW3ruV7Iac0Y+Kk3M/l6U/h/nic3V
         nOfBLkBGjVRG6gGpKogwyBMACZT3oiabF/p7VcvCtVVSB61orkJRg3DBh/sF0+7HYfy3
         18IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715353786; x=1715958586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5niJWmnTMJaWwLIzMOhrQKyuU/mu4Trq6xMfwRJ+dDA=;
        b=Q7oY/ymvgcmgld+pCf1lVx93B4Otl0hXcTTd+EfPzws0OHj/upmITKUkgHRtvITr2e
         pLd+vSEtdGUjkXI/khIIE9qxkrCtERxoWEC/PdE5+QIrcGqLfVSuPqA8kD1g3yVTR4Tc
         DsPrP9CxE7sRs/kabjspxz89mHM2kQoRIIRarRM4/xF4i6/OlKlnEkCfCY1HTCO/JHD1
         lDQYERsKQkTjcHfgvoHqziWc1do3yGahZoQouY78ZDi98o33zoluDlZdmSH6Jq7Etq5d
         aMIiEyOs8llf75wyy9UbQ6VW9U8pDIaaBeY5juCWykvib2GfW+wXTC22nfE4SRlpy8MR
         mEsg==
X-Gm-Message-State: AOJu0YxO3WusypDPbPksxh2iluxFCG6cFfG71eAx3DRD9NfsRaxb0k99
	le86iL6bxQC7ahALkqm++gAaRZwrx/rKiat7wxWIzk1QQdKovC93Ugnbdw==
X-Google-Smtp-Source: AGHT+IEj3cVFgL2UsPrOHIojk91SymtWmIru7PSpq7Q+eVK58+pCVFho7XH7Kae2Kv6uysSkj6GEIg==
X-Received: by 2002:a05:6102:e14:b0:47c:1cce:c465 with SMTP id ada2fe7eead31-48077ce81e1mr3370077137.0.1715353784960;
        Fri, 10 May 2024 08:09:44 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4806cb008d2sm510050137.2.2024.05.10.08.09.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 08:09:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/4] profiles/gap: Added support for PPCP characteristic
Date: Fri, 10 May 2024 11:09:38 -0400
Message-ID: <20240510150938.1492169-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240510150938.1492169-1-luiz.dentz@gmail.com>
References: <20240510150938.1492169-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Felipe F. Tonello" <eu@felipetonello.com>

The Peripheral Preferred Connection Parameters (PPCP) characteristic
contains the preferred connection parameters of a peripheral device.

These parameters are stored in the info file and loaded to Kernel using
MGMT's respective command.
---
 profiles/gap/gas.c | 71 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
index 713b9aaf28f2..b50a9c03acd1 100644
--- a/profiles/gap/gas.c
+++ b/profiles/gap/gas.c
@@ -160,6 +160,75 @@ static void handle_appearance(struct gas *gas, uint16_t value_handle)
 		DBG("Failed to send request to read appearance");
 }
 
+static void read_ppcp_cb(bool success, uint8_t att_ecode,
+			const uint8_t *value, uint16_t length,
+			void *user_data)
+{
+	struct gas *gas = user_data;
+	uint16_t min_interval, max_interval, latency, timeout, max_latency;
+
+	if (!success) {
+		DBG("Reading PPCP failed with ATT error: %u", att_ecode);
+		return;
+	}
+
+	if (length != 8) {
+		DBG("Malformed PPCP value");
+		return;
+	}
+
+	min_interval = get_le16(&value[0]);
+	max_interval = get_le16(&value[2]);
+	latency = get_le16(&value[4]);
+	timeout = get_le16(&value[6]);
+
+	DBG("GAP Peripheral Preferred Connection Parameters:");
+	DBG("\tMinimum connection interval: %u", min_interval);
+	DBG("\tMaximum connection interval: %u", max_interval);
+	DBG("\tSlave latency: %u", latency);
+	DBG("\tConnection Supervision timeout multiplier: %u", timeout);
+
+	/* 0xffff indicates no specific min/max */
+	if (min_interval == 0xffff)
+		min_interval = 6;
+
+	if (max_interval == 0xffff)
+		max_interval = 3200;
+
+	/* avoid persisting connection parameters that are not valid */
+	if (min_interval > max_interval ||
+	    min_interval < 6 || max_interval > 3200) {
+		warn("GAS PPCP: Invalid Connection Parameters values");
+		return;
+	}
+
+	if (timeout < 10 || timeout > 3200) {
+		warn("GAS PPCP: Invalid Connection Parameters values");
+		return;
+	}
+
+	if (max_interval >= timeout * 8) {
+		warn("GAS PPCP: Invalid Connection Parameters values");
+		return;
+	}
+
+	max_latency = (timeout * 4 / max_interval) - 1;
+	if (latency > 499 || latency > max_latency) {
+		warn("GAS PPCP: Invalid Connection Parameters values");
+		return;
+	}
+
+	btd_device_set_conn_param(gas->device, min_interval, max_interval,
+					latency, timeout);
+}
+
+static void handle_ppcp(struct gas *gas, uint16_t value_handle)
+{
+	if (!bt_gatt_client_read_value(gas->client, value_handle,
+						read_ppcp_cb, gas, NULL))
+		DBG("Failed to send request to read PPCP");
+}
+
 static inline bool uuid_cmp(uint16_t u16, const bt_uuid_t *uuid)
 {
 	bt_uuid_t lhs;
@@ -186,6 +255,8 @@ static void handle_characteristic(struct gatt_db_attribute *attr,
 		handle_device_name(gas, value_handle);
 	else if (uuid_cmp(GATT_CHARAC_APPEARANCE, &uuid))
 		handle_appearance(gas, value_handle);
+	else if (uuid_cmp(GATT_CHARAC_PERIPHERAL_PREF_CONN, &uuid))
+		handle_ppcp(gas, value_handle);
 	else {
 		char uuid_str[MAX_LEN_UUID_STR];
 
-- 
2.44.0

