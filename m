Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259142F2376
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752263455; cv=none; b=t3HaPfttxFFY/BbozJttS58qZNICIQk825uTLkqPEsJNS5V/mWMrM8nHVfu8qbet+IjspCr1pFBxsjecKLLufOjSxIZrTwnKYVGpD3uM2VDyYVVW8UMWgbs0z5XiJwM7NFV2EXb5YZmTxl43YN/37WZdRPHmsV5/94t3Jw+Wut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752263455; c=relaxed/simple;
	bh=UOX/S+4oHmPT8gRXsIb/g4vR3OhIb0mKAdkH6xtprdU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=T47lkp6Otacsiz2VbMoJwlXk9t2hL7ID7paBHxwk8ySuSGFmFuEmdoyj/mKZZpzeQmLVfzqiJuBXSH+tg8b2hjSRxYI8XPeeY9NAkIwjOAsI6LBtWu8GBvK6adpr+I0a6AEo1lpO7RelyRl3vvLCbUa+ginKvFQsAoVM+aRV6lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHrp9IOd; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHrp9IOd"
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5346b405d1aso2134283e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 12:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752263452; x=1752868252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z7TNC2hDeAZbCa2PfL2ZvB9M3TFOnVbKwuQ501N2T4=;
        b=VHrp9IOdlOo90SlwjRQlvLimj1NsocAMaayuApcTbTII7rxSTXKowvy/oh1KeCNA1G
         qR6zAme+eNa5q1JjPZQ50u8RdQc6e25at0JIWT+21zrGJKtGSb62OTK0oA7Yqi8cs1p4
         T2DS/vkiSDwJ39Iz8weMtmveSnmA2CuTKbhdmIZGcluIt0kL6ask4EjPHkePcy++BfKP
         jIpFfpTUr0HEJEm9bK/BwvlUOendfxIiEFu+tJNtpPIOtdh1jx1HhqAlQooiifeLYsbi
         hITEUlhMGN4NlB6lTInNdzJcs1lOsbfcGfIRRrViKH+80hT/oGcaf+GrZQHHWPfT8wx6
         at8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752263452; x=1752868252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Z7TNC2hDeAZbCa2PfL2ZvB9M3TFOnVbKwuQ501N2T4=;
        b=NASQw4VYf+dwRE1PRm8N26V7MKTJ+ZaysCe+RPIUvmojbxNDE9wG0Denh2iYQYXzgO
         3tK5xMdMq4SBpXBLzGLMaLE1QmR1V22UBb0LMK9fi0x6uOQl8ITo2yt+Pk/DSfHgklWa
         /yz4uo5AgMbM9Om9dtWfIKpwWVaJLYWMHlom8495wWrcU6xEkYNFHlo0zyxP/1HcLTpA
         juDOc6ubPgEzHieud9EtlqVYYHbWEt/0clTE+GkFO0W5b4CJiOLQ2OP/N6uxjj39DNp+
         f6L8tHT/FVoylSW8XCEYf2QvBTJtGjc8yQuiw2W6S1ePeAyjMB58VcPARVIeJhM6/ZBN
         ByRA==
X-Gm-Message-State: AOJu0YzY16UwcmTrPK+FQTxDGkaAZ6cxqw4hETmtUfm1veNvXioY3ilN
	VMACRnZPvy39dmYfq5LUEVPAxUYG2DlZnSF76Lq++jktLY13BLHKgEigFarH9Q==
X-Gm-Gg: ASbGncs/+WjJsKh5ZqGtlaCCxlzs4lvX8ze1nJX27HXUU6Mwjcd40AY7gjkyRZUWMdF
	cz9O0e9pNQK1Rj50ePoPuJeP5rn+5GJJLFFKah93aBls1WvTrxrq+Rugh9l3Y8EvTJHbyWJE0kd
	LsHnzs2WoMCqYMUMKG3NiwrM35oR4RULOure4B2LXT2IeLsXTxgw4PVjYx5SOxk741pIbDHfkr0
	c7HtYj8e9bWbwv6AArYNZOktPD6/ydmCgFDSfe0YZDHbOSu3ulfmu4VzNO0nVn/T9p8Qym7UIZX
	pzynILujDpw+y8Ptwj++493bBbR7xVXG28cjxqv5xw02Gn5dKcYExaPhTDYbG5rEIbkHQfFAFGz
	dclRNCivokPB7MCU5uFso9p0z498cV0O4jngGpfZ5Byy4bCmYZla/f4PTCkEiWqjN
X-Google-Smtp-Source: AGHT+IFc2zOdvB1jUCcfO2uKrR369+tqNmk4q480zfwJ8DVEH7S9wq7wiCr4wus9p5T2kjxf+BxS1A==
X-Received: by 2002:a05:6122:1797:b0:531:236f:1283 with SMTP id 71dfb90a1353d-535f4a02db7mr3849208e0c.10.1752263452042;
        Fri, 11 Jul 2025 12:50:52 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-535e72192ebsm867100e0c.1.2025.07.11.12.50.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 12:50:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ vRFC 1/3] device: Add btd_device_bdaddr_type_connected
Date: Fri, 11 Jul 2025 15:50:41 -0400
Message-ID: <20250711195043.3875400-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds btd_device_bdaddr_type_connected which can return the
connected state based on the address type.
---
 src/device.c | 8 ++++++++
 src/device.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/src/device.c b/src/device.c
index a50d9ad5cee5..eed2edcf0dfc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3632,6 +3632,14 @@ bool btd_device_bearer_is_connected(struct btd_device *dev)
 	return dev->bredr_state.connected || dev->le_state.connected;
 }
 
+bool btd_device_bdaddr_type_connected(struct btd_device *dev, uint8_t type)
+{
+	if (type == BDADDR_BREDR)
+		return dev->bredr_state.connected;
+
+	return dev->le_state.connected;
+}
+
 static void clear_temporary_timer(struct btd_device *dev)
 {
 	if (dev->temporary_timer) {
diff --git a/src/device.h b/src/device.h
index 4eebcebe9d5c..9e7c30ad7186 100644
--- a/src/device.h
+++ b/src/device.h
@@ -110,6 +110,7 @@ void device_set_tx_power(struct btd_device *device, int8_t tx_power);
 void device_set_flags(struct btd_device *device, uint8_t flags);
 bool btd_device_is_connected(struct btd_device *dev);
 bool btd_device_bearer_is_connected(struct btd_device *dev);
+bool btd_device_bdaddr_type_connected(struct btd_device *dev, uint8_t type);
 uint8_t btd_device_get_bdaddr_type(struct btd_device *dev);
 bool device_is_retrying(struct btd_device *device);
 void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
-- 
2.50.0

