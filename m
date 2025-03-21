Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E461EE033
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742587534; cv=none; b=KzID2AUiOxegWJ56gVUMABkCI/djVysCQih3bPL4slnQTuhwpCfj3EOoNkiR05Z1GF5QOGZ4wCIdntswv1HbUwwkGT1QDCdke9/Z2u8qOsKQrwRTeix7vVQ6Q+8LXISe3U/f/jxLbv40AmmBXfQATICfLx9bNMLsfXnMtHEzi0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742587534; c=relaxed/simple;
	bh=p4zQ1Amo9bpnWbkdJzy76zgxzEpjUGs5MopgMkKIsc4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HrMALFB42hCNUbc76TkqOIForr55EdeMk/akots+hyf9r+yspvFQKWvW9TwBbuzb+uhIOyy2LG3WFCMI3RoY2EjRbzkm233OiVBpizc7D9HLw4wkfut0IsrW8Whhl2EpIbPQwCMMdFkcSpuPq5XvK4KUEKpFtth+4Ilkyz72Las=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HeFL93Sw; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeFL93Sw"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-523f1b31cf8so1097338e0c.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742587531; x=1743192331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=S+IJCs20ayJvqpwTabpBp+CXyeTUrQfFWQ6r/aehIM0=;
        b=HeFL93Sw+duyRbej28VkCQylNAWmdpkF3E9TQVMJVFNLW7Hm3fMIwpYi6EvL9+yMQr
         /JLaPfEjGj6U03xq5uQXGvFpQ1t4+VUBx5VqyLNsZB7p7QNG7OylEODjX9wWAzL0Mnxz
         nOwhPEboYCcUlKWK5hYMDhD7iDBbYTKYtV8bR2JYICP4zbx0bNGj5djbzDlp5Nx3QfFK
         HhxTsQdzaMeYcVf33MMbH2AwJJHrQD54L6HnYGdut1VwgSpEHo3HdKdi0HFAYQphbl70
         OG0QypV7MLB4jVQygHtooF/k/ASopiEbSKdWySWBmywyHrOYG2lpb4WeMLqevTyljMIl
         Czaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742587531; x=1743192331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+IJCs20ayJvqpwTabpBp+CXyeTUrQfFWQ6r/aehIM0=;
        b=KyubbhQ16TdAHjcCtUHt2iETZ2gjIQaNbj72RYIUWgxRRxS3rtOi89pviHb8Bu7Jht
         pVSp+LaQMiqcBloFtMbNfmjGcgkl4s69q4bdHkSLn0+/sjYu+uazkadRfMx50/eNZGOc
         sa4RamB69RGrObTlOcGvumgXEKWt+8lY+trhSkIM7tjTuqWGJxd1BSwE5vXCXBziT+uG
         6x0rGB7pXU1eokFLIYZ8Rf/2yL5OuC1cRm6YpK4kbskla7KNc8R0U1eOz5wUB0X6uwQN
         NAFuFyYe4QPp1pudHAVLqYdE68QWHwneDTqIXLGLIBpFJQFttGt0kooZBL+hC9238VEr
         qkew==
X-Gm-Message-State: AOJu0YyBzZU17K1ob93WwahSAeaKg2d3zm/ULLtP/CC0jWf1rxMXDN5H
	4fFAHRIoBXBUSb11ynmIPRbZmMrId5s38U6fK1g2zdPy0yb4p7JmNPiu3Chx8vw=
X-Gm-Gg: ASbGncuEO29lc6UnB1/eF+DmWKuyECehIZBG8XTMBROooWUe0RYEiJRkcZeOH7lq04K
	TROhgs8vjAYwI3HMnI73yLk79tczrz5+qZbT7sd4iYyj8F+nXiigOwR5w0IVVGuLTdlFejZTAn6
	76T5FobyoQ6fRbpIR7GzwJgLeGiGWapLtGfWq6H3cdhy2d6y04mb5sD4O/MROG0HNeyZ7NVqmc5
	zvwT13p3Lh8/yNc7Ss/oB3dotify3NW+gcG3Ei2y28rkGThDDNF06F9kkI/4jJa3HozyO9H2Ssk
	0ziUsaQ8A1T+VCgVZ3x/fAiCrNPMGkdqljLalUsS9M7vAi0zmXxRt/gCuZ7qq++8JoPO8V/jfGZ
	pG3ClaHCVCvs5Xg==
X-Google-Smtp-Source: AGHT+IEqZeGdtgj7IWgjEjP/FdOSFFp0kajFiwKftFAtiURnJ2A1MHlMriUxPqJv6IZMysGIMutsLQ==
X-Received: by 2002:a05:6122:8c04:b0:520:51a4:b84f with SMTP id 71dfb90a1353d-525a8339647mr5171381e0c.4.1742587530622;
        Fri, 21 Mar 2025 13:05:30 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-525a7644684sm513015e0c.35.2025.03.21.13.05.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 13:05:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] device: Attempt to elevate security on Pair while connected
Date: Fri, 21 Mar 2025 16:05:27 -0400
Message-ID: <20250321200527.1733821-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This would make Pair act behave the same as when the device reconnect
and bonding already exists.

Fixes: https://github.com/bluez/bluez/issues/1125
---
 src/device.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 57577e57920a..a04eebe1dff6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3185,10 +3185,13 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 
 		if (!state->connected && btd_le_connect_before_pairing())
 			err = device_connect_le(device);
-		else
+		else if (!state->connected || !bt_att_set_security(device->att,
+						BT_ATT_SECURITY_MEDIUM))
 			err = adapter_create_bonding(adapter, &device->bdaddr,
 							device->bdaddr_type,
 							io_cap);
+		else
+			err = 0;
 	} else {
 		err = adapter_create_bonding(adapter, &device->bdaddr,
 							BDADDR_BREDR, io_cap);
-- 
2.48.1

