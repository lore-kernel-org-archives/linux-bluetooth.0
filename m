Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896BA1EA7E9
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Aug 2025 15:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320345; cv=none; b=hgoggRxtWIl26VJSpbl6kEm/Ocn7Z/jKDSYqjGsd2rLOA5AhmQufM8ZZ9DHi8H44wUvdNkfvu27p903kKF/TtiCNNGtr5NpimLtGP3a4MBro/quD8fRzoxtd0b3M94QpUZGF1aWTo9BIJXryaLqnzvRBUlBxMsYL0JUOLy2m8F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320345; c=relaxed/simple;
	bh=E7lF9ZEoYImwE3KwYevPyzmvs06LBETT9d8PEI9cjms=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=UVld3UDwur0IHtNOhFAxtUmUBFaG9e07GCA1CRA+JmrERyNt/gabAblbBVTYjFKn/hidqAXyUvUr26TESD1M1Ii8qd1x4yAuxXRay1YHxnCams648FO7E+ZBB3XBpwdC+XfYdRsvCgocHGa8ysI27pu0n6+ADGIY87007NXSUiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ji1bmVPW; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji1bmVPW"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-741a254d4a0so2109792a34.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Aug 2025 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754320342; x=1754925142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bM/7njGz7OJNFfqyWUJCVoG6cGlrZZ3qDHmawzle81Y=;
        b=ji1bmVPWEP5zVAcAZCHc4+4Dfl0QDY30NbJHUOKdxv9L/VMKoV5I7R3umOADsLZJ1N
         Rstl9JfL3YsL1RsSPi0ZX8Ie3KiK24nzxv+G6fs3P9xyBNIPpU8zUmKgTKuFzIdauo94
         wONgAP1Vycfx5dUY5zlPsggCRGiyYvBJ3K8NzW6lW3vnbrvpECugsFkdW+I6JiPMC18b
         rkZyItWetKhkc80wF/nGQ6/SKpFP1TqSRFh981t96BhJzOQn363nr/UdSeB+gL/f/HAj
         iC0hUvNfrzqBBBxS5S2gshWMhgTg6yKhOX2Sd4lp0VMMCEZFYQ7wLgfy60f4R+7pXPP6
         TD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754320342; x=1754925142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bM/7njGz7OJNFfqyWUJCVoG6cGlrZZ3qDHmawzle81Y=;
        b=o5qKR5BVNIRlgfwbZEx7a7MNiI1n43joQVmTDgDpr/k+2nQdiF88ICSnT0bWJY9ooh
         npTQ1VJESdiMjeGrjOCom65rHDPQ4WAMZ9s4+SKMxD8JXe8BQywX/7r4mTh9BCVoenGl
         ehDXn/PC28llGxbRjjnSeeBlZcXnuO9GerzkYMdAipL5YkAg+2EdfSLzF/HW7zt2MENl
         bsuJSIp9cw6PBv19K8W5tRmp21xsODF9OEbToKEmMlQCzDrt0CJk//YdoDQmhSz8q3sb
         igCd2CwZiH694yCs/XrygUrZxKacNd4fLzsSq5GheUFeG2T+sesFIGmh7g12UU/yiv9W
         iHaQ==
X-Gm-Message-State: AOJu0YxHu9kXh2W9i/hQ0+QffLeNhzpBGWtnqBtK6UOjgIN91p0JlHyF
	xUNaKie4v3F9Ah/MYGsoVo3Sugwkd0OocN1MfmnXsaif4mT75AHot556xvMhkxCg
X-Gm-Gg: ASbGncvEgUiiSmxkfuAYpVelGC9PT1gte8UfrRWYmATP7kLyS3Z4bK2Fc6wqJrLtub/
	VWcdFTAg7RXoTJ4BZRg1IDRQ/4Kof2Rwbpv+Sd+rnhMump9i4u6DgTdvo86+/pDlEAX9sXBvbE4
	edawzY6bOMxnHIrl3CNySXRgwqnocnXRYYezl56iWfXQRNlhDnyI5VzQxG0ueUk9xE0oZFR+M6J
	XZz3YqaYBEAETmAE2cz7ToWgcIM0yQ/tBQL8xBT0FOG7pjD+Q+Vb3uFTnJqWtiiyyxF0Edoa5Cn
	qvUbNE7I8UWLusdqpozn8oWBU4/3/q8J/bD40J9R4wtGtqnrQRt86YkpwWjSERUCnJgSPENIN89
	hHKy5eGHp2mrXcODAYZbH0MCwjvkE3vu3wISKACJrKGGMMBTPSiJf/khG16yYsdOu0llf2/pc4Q
	U=
X-Google-Smtp-Source: AGHT+IGVx/Mn0hjUIaPUAKg8y78et/3PHRGpDBdqLp1nmT/Ir0NfjF0W6wVtL0Xwj6PNL8X4L3kCWw==
X-Received: by 2002:a05:6808:f02:b0:434:1594:4821 with SMTP id 5614622812f47-43415944da1mr625269b6e.17.1754320341819;
        Mon, 04 Aug 2025 08:12:21 -0700 (PDT)
Received: from lvondent-mobl5 (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88dc8a095e7sm652762241.23.2025.08.04.08.12.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:12:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_core: Fix {cis,bis}_capable not checking if LE is enabled
Date: Mon,  4 Aug 2025 11:12:10 -0400
Message-ID: <20250804151210.1295329-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

{cis,bis}_capable shall check that LE is enabled otherwise its MGMT
settings would still be marked as supported when they shouldn't.

Fixes: 26afbd826ee3 ("Bluetooth: Add initial implementation of CIS connections")
Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")
Fixes: ae7533613133 ("Bluetooth: Check for ISO support in controller")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4dc11c66f7b8..d64f8dad978e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1984,11 +1984,17 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define cis_capable(dev) \
 	(cis_central_capable(dev) || cis_peripheral_capable(dev))
 #define cis_central_capable(dev) \
-	((dev)->le_features[3] & HCI_LE_CIS_CENTRAL)
+	(hci_dev_test_flag(hdev, HCI_LE_ENABLED) && \
+	 (dev)->le_features[3] & HCI_LE_CIS_CENTRAL)
 #define cis_peripheral_capable(dev) \
-	((dev)->le_features[3] & HCI_LE_CIS_PERIPHERAL)
-#define bis_capable(dev) ((dev)->le_features[3] & HCI_LE_ISO_BROADCASTER)
-#define sync_recv_capable(dev) ((dev)->le_features[3] & HCI_LE_ISO_SYNC_RECEIVER)
+	(hci_dev_test_flag(hdev, HCI_LE_ENABLED) && \
+	 (dev)->le_features[3] & HCI_LE_CIS_PERIPHERAL)
+#define bis_capable(dev) \
+	(hci_dev_test_flag(hdev, HCI_LE_ENABLED) && \
+	 (dev)->le_features[3] & HCI_LE_ISO_BROADCASTER)
+#define sync_recv_capable(dev) \
+	(hci_dev_test_flag(hdev, HCI_LE_ENABLED) && \
+	 (dev)->le_features[3] & HCI_LE_ISO_SYNC_RECEIVER)
 
 #define mws_transport_config_capable(dev) (((dev)->commands[30] & 0x08) && \
 	(!hci_test_quirk((dev), HCI_QUIRK_BROKEN_MWS_TRANSPORT_CONFIG)))
-- 
2.50.1

