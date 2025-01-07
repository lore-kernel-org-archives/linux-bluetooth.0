Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA31F0E51
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 20:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281865; cv=none; b=QJWHRNjQxMZwRfru8B9xXs92lqbbAPjUWrYuBpQt5XG7J02nBDhA5tFSdAb5z54r4SRa0R8i6BT0+6DVYT5vTTyOjnl9Yr/H2a9qD1Bfa5KnszKKzUY/iMBFvThWDdszhAxMYJNd+OEqyWP0FF7uvJvw3kYLVR3QWvVOm2PRlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281865; c=relaxed/simple;
	bh=+4tB4yz5wbfa0Q8O2SC/vvg/Iley1GAKbOw3jxV1W7k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=g2WHj0FD7M8Yozl2xDeHQGkWStDPO6RFQTK/iYY1rOyZ9cW+0P4Xy2j+NuJrxeatM1RYdywAiipZcVYhsPg5CaUUSvhHnJ8WwhwGpY1OdRI++CijUDf041KmlEXcCZBjqaXFP8EZLlr1Qhpet65sqWxna+rAnRsKE+Is5UCRLK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBjRZ5Ue; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBjRZ5Ue"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5160f1870f3so4927901e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2025 12:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736281859; x=1736886659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=av4Sp6yl62RdNVWbo+zCVHoEH1XIxT703xuf9S1JZoo=;
        b=mBjRZ5UeLcHz9MeMLfiKtDOzj/LhCiyrP+4+YjarkU8AbPhnDpGoJIWaHAVDnT7qVN
         6eg0KW+7kktQtBtVGGpFqg6DHV+3GMyxQ1s2zmVOQXc+AXAG8oUwgir0WRYksa6qj3KY
         xhFHPgMHvxObIEPkCP8B/zg14VMNfB+d32IcTD3ZeyD3Blm70ZiBOZU7QxZehFfpy2W9
         NYa/K696szvvmH53AGe2Vi1z597yjW4xuS0nK57Z0tIzIZQalgxpvJQSEOlk/vRWJYmi
         kK7IWBgzwxnIt1d4h7GYO4wlKzNYT53zHhHCW6xdcpbbFe0sGJH0IrJEpjBus2vayoN+
         PKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736281859; x=1736886659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=av4Sp6yl62RdNVWbo+zCVHoEH1XIxT703xuf9S1JZoo=;
        b=tdOFl+h6oQaSRcRTKGrz08wLx3K1OMfmBHyrUMsxgsgXbLt8wkRexKPmOzImXUxZWC
         D8B6Wjz1kzAyqaEWwPNMXahgi/d5Pc7yEkfs3lXc4kQbro4Z17JwZFYS+lHC+nBJ361l
         NE43ekkASF0cSCIwV5pS9wzZJN5n6BjcM6oEixU9NG8R2nK0yQ4j+4cehhDwbsQJtn/0
         gCcMn83ExkUqHZeZA2oJs9jo2OFUS08ADse/vcYSsQVOw4ElBaH6Tk9x+bN+1xBY2ofH
         o9F5CmGmtG+T7V3opBsC+Rjh16LzgoNM00Jc2p+/e5uRiiJx7jvuhdP/mA0FlRoWwdsV
         vEBg==
X-Gm-Message-State: AOJu0YyS1p7B5eL7iGc19vuy9eAhnLQfzdpGfk6Ostjo9wrTqIskbQmz
	+BByEypSaFhm6X/GrOF6/PHniA978SgXuCBEwwOSG+7WHZMZGKFnf4b5zw==
X-Gm-Gg: ASbGncuNcgRokXZqGuUNud8kO2oWgW7SkBJJuEJiCLhlhfZEtxeUhlTreGYvB/K0M5a
	OCmaV7Q4ADCYDz0O/cVpqYkO/2cqU+v2JGYqovXqIE4Mq6EwHFCw09s9fVZ6Jzji8cfMFKvXluR
	6KqG+4ci8z15r0ysmbP8WWGe6qDxx50zCJxKfNG0xatlLr2hETA5eg/ad1eoPT+A2gRH4gQKftn
	hXxmHyjLi5EDtvgDmgkEk+kz6dV8+ZTW8jchta7iM5894+ZmC/UeoHflMIGGjGcL8yIw5O73+C8
	bh6p+L4hiGApRRr23UTyl+npcAXh
X-Google-Smtp-Source: AGHT+IHD8yNdZ3UzHdTDk2hjVgifqjGTrhj+tOP6z0lS0u0qaV80CnxDSJWUEzNJ1PcGM7LRkwREkw==
X-Received: by 2002:a05:6122:2207:b0:518:d26a:a819 with SMTP id 71dfb90a1353d-51c6c2b7b50mr644552e0c.0.1736281859729;
        Tue, 07 Jan 2025 12:30:59 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51b68b7d5e2sm4690312e0c.10.2025.01.07.12.30.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 12:30:58 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] input: Switch back to kernel hidp if uhid cannot be initialized
Date: Tue,  7 Jan 2025 15:30:56 -0500
Message-ID: <20250107203056.1470303-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If bt_uhid_new_default doesn't work it is likely that the underline
kernel doesn't support it so this attempts to switch back to kernel
mode (hidp).
---
 profiles/input/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 8cf8e5ea78e1..3627573e79c8 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1527,9 +1527,9 @@ int input_device_register(struct btd_service *service)
 	if (uhid_state) {
 		idev->uhid = bt_uhid_new_default();
 		if (!idev->uhid) {
-			error("bt_uhid_new_default: failed");
-			input_device_free(idev);
-			return -EIO;
+			DBG("bt_uhid_new_default failed, switching to kernel "
+			    "mode");
+			uhid_state = UHID_DISABLED;
 		}
 	}
 
-- 
2.47.1

