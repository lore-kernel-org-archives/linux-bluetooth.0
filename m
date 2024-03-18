Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEAE524D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778118; cv=none; b=mCVzAmLliBWCjcStqyaj27BM0ffr1XL2XTKqppYeWrs52UkBvspqoJ/kBuNSGH0nKIn0WbDhRP7Qw98EBAC/3JDHYkTjmISkhzrr3Cs1G702zpLAfgPRgmMQQlHVjxuly57Ea4I4mrB7XccrSHlmr65FmHo3pet0P2wu3GA+qNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778118; c=relaxed/simple;
	bh=9VbhXpgHzUgQJu9IFDvwDMdvKT6B3joEPMCqbScH2G0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=FpeiJ1wo2ieiD65vjwbIVPZ/zJGptAtuctsbU6uyWJAQhbAXZOFCSmfmTFqUmPC2o0JUakcK3Bx+MiVLRHjyPNjTi1TEu75ZWm71Mw62/RcdV/TNXWezt8wXKVMBzE0ZnntN6L88bKPGXQKJ5TW0jdgiy8uDxYkmDHfxmT7jZaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaDDUtV+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaDDUtV+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41413d116f6so5117285e9.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 09:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710778114; x=1711382914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=688Oa3pVNei7pc+xdUk174lTU1EQp6WO10bjNFM1Q8c=;
        b=AaDDUtV+V8jTWSGByPPNkImcnD6eGcUuFnQyCfqObMbtABUlUCkx3RRpMwWY/LIcfJ
         E+0AlVyiP7Zb5ePwyzxTwcgstgonPn2vRbaQ8XcJqd4JKIJK3k/rAvOpt55chmP5jjJi
         gCl4v17pxAFIL825hvu5XijLxBBdBjUn15WOKZ4CRxfcOW7auv7taHWNMDwfpQPGod0a
         BD2M4j9r2mJI+sme9kIbPSe5uU85gRhg23ZqxIGfh51TV7c3Cb9ZVfQMz3e86B7Wr5iK
         Jfyt2w6iaMOBpWmusw3w/JpHxKEjRSEvndMHC47zALPhn09G1rUzn4aJhlu2D4CpJd5l
         /59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710778114; x=1711382914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=688Oa3pVNei7pc+xdUk174lTU1EQp6WO10bjNFM1Q8c=;
        b=KGnyb3wSqUvhf6ybjBpFo/nK1B8zcndN2RHaDhb/4TQxnKkOIZT4AnkDNbGp/xqjJQ
         9IuNdJnO8ExAipis0sMuI6SLy3C/JQzRmvoZeXtZ+Ts5/Lp23SW383czwR1yxS00xzqM
         ywuAsAghn6hvhnSgN+9KpO8HqQ1Jr28nSCPUzk4Yk9yJYMT1wMhw9z+m0bcmlJQTj9p0
         jfmvhXeIjOXQzT3M66grwY97GikJlF5cXyyxMX8Rb9oFUUtftF/toxsmsnv2Si/D/uS+
         9PFpcGMDeAP+8Z6GaiMVvCRL84Qp5sp9wApWOR7iueOT0eb+A5Y+K35NLlMV4UQ7sHIC
         zFuw==
X-Gm-Message-State: AOJu0YwmyDorcL8n4LbukKAv2JCMW/prXYwbKDZE06v6T03GI2VyoemM
	8qFIDlW8EkS9ku9Vvlo4UYzYtxfq8R4xu1fkX6nzYrxK7njGC7X2aIzinoTnneQISA==
X-Google-Smtp-Source: AGHT+IE316aaDWH3dn7CGZZm0UcVO8F9PZ1+mrTaOXDJyONru8XTdUEWW29WNFHU8OWknianBLHZmQ==
X-Received: by 2002:adf:f04e:0:b0:33e:b7a0:4790 with SMTP id t14-20020adff04e000000b0033eb7a04790mr7213540wro.50.1710778113556;
        Mon, 18 Mar 2024 09:08:33 -0700 (PDT)
Received: from lvondent-mobl3.. (ftip004290803.acc4.faraday.21cn-nte.bt.net. [109.144.76.63])
        by smtp.gmail.com with ESMTPSA id dd15-20020a0560001e8f00b0033ce727e728sm10117727wrb.94.2024.03.18.09.08.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 09:08:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] device: Fix device_is_connected checking for services being connected
Date: Mon, 18 Mar 2024 16:08:31 +0000
Message-ID: <20240318160831.354442-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Change 44d3f67277f83983e1e9697eda7b9aeb40ca231d since to have introduced
quite a few bugs related to device_is_connected return true which
prevents proper cleanup of connection.

Fixes: https://github.com/bluez/bluez/issues/774
Fixes: https://github.com/bluez/bluez/issues/778
Fixes: https://github.com/bluez/bluez/issues/783
Fixes: https://github.com/bluez/bluez/issues/784
---
 src/device.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/src/device.c b/src/device.c
index aecceb100..b5b574233 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3324,22 +3324,24 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type,
 								"Connected");
 }
 
+static bool device_service_connected(struct btd_device *dev)
+{
+	if (find_service_with_state(dev->services,
+					BTD_SERVICE_STATE_CONNECTING))
+		return true;
+
+	return find_service_with_state(dev->services,
+					BTD_SERVICE_STATE_CONNECTED);
+}
+
 static bool device_disappeared(gpointer user_data)
 {
 	struct btd_device *dev = user_data;
 
-	if (btd_device_is_connected(dev)) {
-		char addr[18];
-		ba2str(&dev->bdaddr, addr);
-		DBG("Device %s is marked as connected", dev->path);
-		return TRUE;
-	}
-
-	/* If there are services connecting restart the timer to give more time
+	/* If there are services connected restart the timer to give more time
 	 * for the service to either complete the connection or disconnect.
 	 */
-	if (find_service_with_state(dev->services,
-					BTD_SERVICE_STATE_CONNECTING))
+	if (device_service_connected(dev))
 		return TRUE;
 
 	dev->temporary_timer = 0;
-- 
2.44.0

