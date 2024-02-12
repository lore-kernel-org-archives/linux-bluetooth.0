Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C1E3EA78
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759560; cv=none; b=fbpXLzc3Uq06uSnbpMmiOSe6xysrhmeeV3DyRLtSSE+lkZ1mGwYL5h0lZpPC4BWyd2wMbAQa+SkzMc0ItOv1tGXeJHJacgINMC0koYp1p8fgfH0E0Vd/TDRozdm8x1BxyPTRivc4Gbq/AAuDrWem/7ZCOH8pUzaRZMSHrwPATCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759560; c=relaxed/simple;
	bh=RvyDHGhYb9qRK0GozMLCph6YUdvW3Eq/zyPgZ+7nXgk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjeESdyuKEQplIIYe9AwCtIqDOEwlpu2Jv47VCGoyw5ENKBXXAFfI0NfGlTWPQqWp0TlfWBc0N5SCNPskk3PqL+6vKf07bV4j0yMUChTGpthj5+wUl7qh3r+NKP2qBzYfg4ezebsDC1eNdnog5gGjFPxKH4XkpaW3IsDycldiAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SR0dUbaH; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR0dUbaH"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4c01ca67504so457380e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Feb 2024 09:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707759557; x=1708364357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Csi8k2wIa0lbwvBcpJhV1MNaSFF2B9iPCf3jqUMKa8=;
        b=SR0dUbaHwy3hDtvk/TwrCCI0yYzUt+De/GFKPzuDeiNqimeJnAJMKRWfSb82g0ftsy
         MQOof9D443BVCCD/1RswMalWcEWQaI841uY4bU831tLWDCE3F2c4GB4g9sv7DHSL6oIJ
         zSihHzzCcmMs2elSc35+SMTMVGmDIr5s9vd4jpEYpSvDJrOCvLhusAdeQ0MC0cTLzvUW
         jVHOQ8rYpqZP7b7joxabWiMjq4sZqLrGAlQ6ezjStqlnNDbaZ5sg35wPQVIAZFdBvQCA
         pqEN40ZSKdKKRSqLIUgomCzOnVpTJHYGnswrn/U+zulsQP6DZJ4ZxfbgHrAZnoIjjK1g
         NUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707759557; x=1708364357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Csi8k2wIa0lbwvBcpJhV1MNaSFF2B9iPCf3jqUMKa8=;
        b=GqVa4SEeK9caOb1nOpyO7H7NzI7kLNMIj8SQugmeEhUSBPYxk/aJGmyEhNrF8DAVXS
         thwpqvzL2bTh1aehvcFr0lsTcbhOKNKQI9BYqDRC8E2VEQFRBLzyu+IGqpste/pD2pf+
         2ImDVMKDNKEFm9YwJn4Ec/blkd/6DklpRObcMKc3Qc95QqGzw4nuIzPjXojB9AI0N/ZO
         kfzebc0oCBOrkxcahR/ZNeVF8NgjbB5b+L0Ydx5p7KnGu4Lwd+PbDDEqbnGskBkj6SIG
         MhKopVQR7PejhotCzPUyZDqybWBBgyvtDESXqISL0XGzkPj3iRQwsnobpHa5lMKGF2z1
         JpuQ==
X-Gm-Message-State: AOJu0Yx+GbYCbVQbadta1RQxNorqyplHacjdv+bDqLIEZkCXmeUSN91C
	zGsSpV8+sD7rP14CM2D6xl6156gB6kwMa2bkWa6VPl8ek7GKCMwUNlRD0PKg
X-Google-Smtp-Source: AGHT+IEThrkCiWVjrHvvW8DGwJ1e3aDRbBTz8Vx2iC0DdQE7DhzZjXod4+5eb9mlyEVOZmGexwRd7w==
X-Received: by 2002:a1f:4d43:0:b0:4b6:d63c:ca8f with SMTP id a64-20020a1f4d43000000b004b6d63cca8fmr2483939vkb.16.1707759556735;
        Mon, 12 Feb 2024 09:39:16 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id eu6-20020a0561221c8600b004b75720e155sm767686vkb.12.2024.02.12.09.39.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:39:14 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/3] input/device: Don't destroy UHID device on disconnect
Date: Mon, 12 Feb 2024 12:39:10 -0500
Message-ID: <20240212173910.4061556-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212173910.4061556-1-luiz.dentz@gmail.com>
References: <20240212173910.4061556-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes classic HID behave like HoG which keeps the UHID device
around while disconnected so it doesn't have to be recreated on every
reconnection.
---
 profiles/input/device.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index ff7e3482d0eb..08bdb30f1f3e 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -985,6 +985,10 @@ static int uhid_disconnect(struct input_device *idev)
 	if (!idev->uhid_created)
 		return 0;
 
+	/* Only destroy the node if virtual cable unplug flag has been set */
+	if (idev->virtual_cable_unplug)
+		return 0;
+
 	bt_uhid_unregister_all(idev->uhid);
 
 	memset(&ev, 0, sizeof(ev));
-- 
2.43.0

