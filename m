Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5787F1D8A16
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736264536; cv=none; b=VqMOkDb6j8ErNlyMptqh/n6F86d0uwV3R9oyyvz6yDzm0KqNgeObIsnmd6oLx91JAcBeyIobj7sdkv1AoF44LRtLypKfvNjlTArYRtHjUag02qu36LtS8tn2kvWNxsZqLynfIF5WPSXFUogQrIp+L+jcZ+OnttMSjPMTTlPgK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736264536; c=relaxed/simple;
	bh=PzxrYqevjN6o/ecFbdS/M5zGtBcBhByVq0InfpJRtCY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=nDd+sPEi6y9yVI0V/ehCeZBzsCU5dvU9A0q9ZuimguATGjRu6nK0jzFOI7bhxx6etblr/PXHR34UY9g1gDY7qwqirJa3CszqLG0YXidRK42SkKxrWC7xxlX8esLTppjYFib3eNCyWSA/0Hdve95EqXGm0n2YTGa9Y/Ux6aASJeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NZ+J63Bb; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZ+J63Bb"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-518a52c8b5aso4779889e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2025 07:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736264531; x=1736869331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=glTU2BRxmDO+0r5gPEtN2TK4RH9et+avcqLqh+NWbkk=;
        b=NZ+J63BbycfMOjOX6NMsWsvZ8dJSPKUh6kItUBwqToZP3RY0D07ODH+yDN1S2EETyV
         cocNN7j5XwIfzfTuJwKsMPGwaPE6HTMWcYvsjiz8PqzushINKw+kxs0WDevZARc1Bd94
         fmjq/oWQznjklt0ZK1ZZXjGtqo7X1SZxqFsTqoec7D7g7nYDLmj+S5dDMvcKlizk9H1M
         +qgXWV8WOCzPkwI15c03mUy4TmZtJ8Hl6/ytsLMr3l8UBkO0ztsQkKDy3Pklyv8da0kq
         X4fUIjrEgOXZqWCtiZnvxm7FpPz+uZ7l2HufuZ3sCGqEjsVZVhmk6No6h1IsQG+f5hbP
         SaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736264531; x=1736869331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glTU2BRxmDO+0r5gPEtN2TK4RH9et+avcqLqh+NWbkk=;
        b=TbIJe/aPbS9kpKjv2A1jVKjvhMlUkpzMWTanLRpWJvaIpoAR0lkjdGKSBFuKGQJwVM
         kYUu8DdwqONFWkVhp4rMOb6R/k4ub/2llPEVpBoAU9QnPHX6H1tlzIMqwtQlWcNtc6KD
         yPiSmAkxwNw5Uz1K1TKGXy8lB/iT4REuhQu0Dq2ImKBRwQUkkJkuJnKrh/jOXNZPg6x4
         serDKDryi6lRiyZmeZBL57yEvghkeEeisfV73fKezHiCIxQzsFqXPfRP9ouhol275ZBN
         KUuIVFcp95mkl7qEijdHXysiDldR8VOdJAEgW4+7D7wUdbWN3RgHZZLVtttDMuS+O1VU
         XSYQ==
X-Gm-Message-State: AOJu0YwsHZac8xFz+hmfxf2Dd/6+0dZporbrJauC7WHYMLBCpnGQHTgn
	mMO93LxW7n4GP9M/w/ICt8qh4nl4ZLwacZJoHRQPl1oKDckhYk5AeC5/wQ==
X-Gm-Gg: ASbGncu9kv7s2ScIgirTYYu3RV4rqM4Wq3hP9Ds/53dbQ+U94wwxXFHMmKPcvnkTNzf
	0Q9E4rBmRNAocJH0kA0sYMSZSfbqgc/KzNPO6f3XNrOcIKneajedSZsqUmCkZf3h3U19QQ1pzJB
	GiDYXMV0G1UBM/Z/Ies3GaeSeCSzYMt1CauVwG8LCl/si1zyKaECAL+o7AE4aqLvsqGxsrW2//S
	NTSmBw2frXJPgP0i55TyTiofqLnhqiu0RDpPvSfW9o5GCllqp15sfBlgygf8DetKQML0a6RivSX
	PzN8yjQbduoJ38DfafRQUEt6T8tC
X-Google-Smtp-Source: AGHT+IEAY46JYNkNoZY82sM+2KjGOFFpLzAOlD4LD6IGXhVlMUen1TOt7R3KGagDgPhwqSqwL347yg==
X-Received: by 2002:a05:6122:660b:b0:518:78c7:9b4f with SMTP id 71dfb90a1353d-51b75c2af33mr49919164e0c.3.1736264531541;
        Tue, 07 Jan 2025 07:42:11 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-8610ad5a3fesm7999762241.33.2025.01.07.07.42.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 07:42:10 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] autopair: Move handling of wii controllers
Date: Tue,  7 Jan 2025 10:42:07 -0500
Message-ID: <20250107154208.1414463-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This moves the pairing handling of wii controllers to autopair plugin.

Link: https://github.com/bluez/bluez/issues/911#issuecomment-2571606630
---
 plugins/autopair.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index 0b09e893f817..2274b5e2f897 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -30,6 +30,80 @@
 #include "src/storage.h"
 #include "src/shared/util.h"
 
+/*
+ * Nintendo Wii Remote devices require the bdaddr of the host as pin input for
+ * authentication. This plugin registers a pin-callback and forces this pin
+ * to be used for authentication.
+ *
+ * There are two ways to place the wiimote into discoverable mode.
+ *  - Pressing the red-sync button on the back of the wiimote. This module
+ *    supports pairing via this method. Auto-reconnect should be possible after
+ *    the device was paired once.
+ *  - Pressing the 1+2 buttons on the front of the wiimote. This module does
+ *    not support this method since this method never enables auto-reconnect.
+ *    Hence, pairing is not needed. Use it without pairing if you want.
+ * After connecting the wiimote you should immediately connect to the input
+ * service of the wiimote. If you don't, the wiimote will close the connection.
+ * The wiimote waits about 5 seconds until it turns off again.
+ * Auto-reconnect is only enabled when pairing with the wiimote via the red
+ * sync-button and then connecting to the input service. If you do not connect
+ * to the input service, then auto-reconnect is not enabled.
+ * If enabled, the wiimote connects to the host automatically when any button
+ * is pressed.
+ */
+
+static uint16_t wii_ids[][2] = {
+	{ 0x057e, 0x0306 },		/* 1st gen */
+	{ 0x054c, 0x0306 },		/* LEGO wiimote */
+	{ 0x057e, 0x0330 },		/* 2nd gen */
+};
+
+static const char *wii_names[] = {
+	"Nintendo RVL-CNT-01",		/* 1st gen */
+	"Nintendo RVL-CNT-01-TR",	/* 2nd gen */
+	"Nintendo RVL-CNT-01-UC",	/* Wii U Pro Controller */
+	"Nintendo RVL-WBC-01",		/* Balance Board */
+};
+
+static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
+						char *pinbuf, bool *display,
+						unsigned int attempt)
+{
+	uint16_t vendor, product;
+	char addr[18], name[25];
+	unsigned int i;
+
+	/* Only try the pin code once per device. If it's not correct then it's
+	 * an unknown device.
+	 */
+	if (attempt > 1)
+		return 0;
+
+	ba2str(device_get_address(device), addr);
+
+	vendor = btd_device_get_vendor(device);
+	product = btd_device_get_product(device);
+
+	device_get_name(device, name, sizeof(name));
+
+	for (i = 0; i < G_N_ELEMENTS(wii_ids); ++i) {
+		if (vendor == wii_ids[i][0] && product == wii_ids[i][1])
+			goto found;
+	}
+
+	for (i = 0; i < G_N_ELEMENTS(wii_names); ++i) {
+		if (g_str_equal(name, wii_names[i]))
+			goto found;
+	}
+
+	return 0;
+
+found:
+	DBG("Forcing fixed pin on detected wiimote %s", addr);
+	memcpy(pinbuf, btd_adapter_get_address(adapter), 6);
+	return 6;
+}
+
 /*
  * Plugin to handle automatic pairing of devices with reduced user
  * interaction, including implementing the recommendation of the HID spec
@@ -51,6 +125,12 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
 	char name[25];
 	uint32_t class;
 	uint32_t val;
+	ssize_t ret;
+
+	/* Try with the wii_pincb first */
+	ret = wii_pincb(adapter, device, pinbuf, display, attempt);
+	if (ret > 0)
+		return ret;
 
 	ba2str(device_get_address(device), addr);
 
-- 
2.47.1

