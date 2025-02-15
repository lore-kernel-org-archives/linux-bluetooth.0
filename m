Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FBD1624FD
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 19:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739646192; cv=none; b=Fza325kzs3WtsgzG/YqAdrKyZzmsBnQiKZT4hZ6f7hAW6wpZCuksiIzv2fnonQBkyzdM6FVAEHxAlAzPmQLn3DJg+qPsLDherGtu76yMuyxueleVXUGIevsKZdTN9B60IsHCYGeQIsd1ee4fJZ14MiiCaWdoXt40imBE+rlOYOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739646192; c=relaxed/simple;
	bh=6njaOHzFA6bQRWtjXhfFY20/HR+LsDcukOf+6C+N4Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PuSU+lZ1a3+0nFGtiiFhoqnobgyqKG2xGGx3A/95OM7A4jg4yTMj2gUPCZQ9XCnY/lIAv+mrkMo6x2tUA5cHLwBRq+TJq8SYOHeB/v44u99TE/4E4S30f9iiuoUIud7hunzU5wSVyjwZTdO2BTb87S0pkVAJY5fXBK3mZwlZ4tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ll6X0qoJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ll6X0qoJ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aba868c6e88so227634166b.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Feb 2025 11:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739646189; x=1740250989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rprknBGlaktq5L7X5N43nVP0QKtI9uvWEgMeoiBCVX8=;
        b=ll6X0qoJ20Q91WQZ9SBEJTVdajyC2u5XyoEMB5G3cYh+zuuS1boQJ4OCfPrd0KYcei
         u3z3GH5xesR8EMR2dWN4XMJV+gdAqd5dvXuZPhgvRndtd+oc43LOr2jZcJCBJEPsePDA
         6jR9XV/I9VUXbG7MQIGYT53ti0SDG7ly9a1yqV+PFUl+xBvmBjWx89cUKbbR9f91EQIx
         PaNnyK0ZAC2GK+C7N6lPAOTIexI/vf9Xxly/q0gcmIu+10QXrkflqUDUOZ1EYciPWjAT
         XGPmhyYJYI2vNSEqFqSt8iyaLJMHsgvhtRjC3je6ujlU7uDmOPdYDi9FWKneR/EIWvWb
         VwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739646189; x=1740250989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rprknBGlaktq5L7X5N43nVP0QKtI9uvWEgMeoiBCVX8=;
        b=myiCyX+dOiYIDJSn4zoewTdpy6Irc3w4dixM17NnIlhSNLfbSo2YNK3ykULQQBxiDF
         gllnEW7o4CZoT8VU8ErrWYY9ZL9fuUY2s6PIliMqCGd4oWx7U4L+Vh92d2zMXHEAHdKd
         nmHSJUqL1jANElQsSBIEfFuIVDHfb7lQ3GTElL9bCMHuTKp2XFfdlSLW+6YEZRCF64tn
         PpYVLUm64DGhjqAQx8Qx9x/GdKcbe8GVA0SN+WpOtdZxzWj2iotPR+rePlU8xqbahSUE
         4giO1TIuqoAMfdjoP1UXSDe5LreIx6T07DtW3+Og0fEfVWN8+a1GMFjdUeT+AnK1kh6X
         DTtA==
X-Gm-Message-State: AOJu0Yxwypi3tQk8ossXylYpfipeli1cJDU1/UCVvkbehiVOxYiJrDKv
	uOjLgTc/9VwySaSnbqz5gR8KuBZMX/JIE4FbtRuW7pZg1igql/Qq3fAsBw==
X-Gm-Gg: ASbGncuW40WDjBHpq3TDMqydnp5UdFMTZFVyjZqsCxmbzJ+niD8hMrF5sZHLQf9pgI8
	CR89DjaxcLFe2TI1P53Ys/61thLJrvYY8S7t8t+IS7L5wP5Y0x/rYSkIRC19rz+jvv9k4sDeXF4
	H8B1SW63RIzpjxvxT8iEldZ68P0CyXi4Zz70jvC9sgwfACoxeVPDKBkDC421jYJ1J/uVYeOSbG9
	ZPUmNlYjQEg9H/YkgQFkmzjvkQIkCzFma+9z1JTnBWhesRQuHt54JojUPxkbIDkJ+T0xBwte+Vy
	mrWwpBWwWsf2ZBcFXYcr6+JQqhTxO/Qwl6cc9HfrInSKnpPU7tRVAf2SR7zi+KOUz6CgSTIp6x3
	1X0yaP1yN9CE=
X-Google-Smtp-Source: AGHT+IGl3yE6O6MLmeZ0gqXapLsTpqo8A+Vng2XJ5xiMZsj9kl7WO+aEJX07eoo4kxRz4nlHx9CbXw==
X-Received: by 2002:a17:907:60c9:b0:aa6:7a81:3077 with SMTP id a640c23a62f3a-abb70e61e75mr335713366b.54.1739646188664;
        Sat, 15 Feb 2025 11:03:08 -0800 (PST)
Received: from localhost.localdomain (46.205.193.135.nat.ftth.dynamic.t-mobile.pl. [46.205.193.135])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53398364sm577621866b.128.2025.02.15.11.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 11:03:08 -0800 (PST)
From: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ] bthost: Set advertising intervals to valid value
Date: Sat, 15 Feb 2025 20:02:51 +0100
Message-Id: <20250215190251.173383-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The range for LE advertising intervals shall be in range between 20 ms
and 10,485,759.375 ms. Requesting other value should result in the
unsupported feature or parameter value error code (0x11).

After the modification in fa4d477, the btdev emulator no longer accepts
uninitialized LE advertising intervals. To fix that, set the default LE
advertising interval to the lowest possible value - 20 ms - in order to
minimize tests delay cause by device discovery.

Also, this commit fixes the detection of the high duty cycle directed
connectable advertising and sets the advertising interval to 3 ms for
such cases in order to be complaint with the spec.
---
 emulator/btdev.c  | 11 ++++++-----
 emulator/bthost.c |  3 +++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index d7f61deb0..c0872ad55 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -4870,14 +4870,15 @@ static int cmd_set_ext_adv_params(struct btdev *dev, const void *data,
 
 	ext_adv->type = le16_to_cpu(cmd->evt_properties);
 
-	/* In case of direct advertising (type == 0x01) the advertising
-	 * intervals shall be ignored and high duty cycle shall be used.
+	/* In case of high duty cycle directed connectable advertising
+	 * intervals shall be ignored and high duty cycle shall be used
+	 * (advertising interval <= 3.75 ms).
 	 */
-	if (ext_adv->type == 0x01)
-		ext_adv->interval = 10;
+	if (ext_adv->type & 0x0D == 0x0D /* 0b1101 */)
+		ext_adv->interval = 3;
 	else {
 		unsigned int min_interval = get_le24(cmd->min_interval);
-		if (min_interval < 0x0020 || min_interval > 0x4000) {
+		if (min_interval < 0x0020 || min_interval > 0xFFFFFF) {
 			rsp.status = BT_HCI_ERR_UNSUPPORTED_FEATURE;
 			cmd_complete(dev, BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
 						&rsp, sizeof(rsp));
diff --git a/emulator/bthost.c b/emulator/bthost.c
index 95160506d..a76b02ecc 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3249,11 +3249,14 @@ void bthost_set_scan_enable(struct bthost *bthost, uint8_t enable)
 
 void bthost_set_ext_adv_params(struct bthost *bthost)
 {
+	const uint8_t interval_20ms[] = { 0x20, 0x00, 0x00 };
 	struct bt_hci_cmd_le_set_ext_adv_params cp;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.handle = 0x01;
 	cp.evt_properties = cpu_to_le16(0x0013);
+	memcpy(cp.min_interval, interval_20ms, sizeof(cp.min_interval));
+	memcpy(cp.max_interval, interval_20ms, sizeof(cp.max_interval));
 	send_command(bthost, BT_HCI_CMD_LE_SET_EXT_ADV_PARAMS,
 							&cp, sizeof(cp));
 }
-- 
2.39.5

