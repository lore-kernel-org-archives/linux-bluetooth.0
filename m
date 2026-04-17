Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156C73A9D8B
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 10:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776422805; cv=none; b=g/nXCV2xbKBrVmvrNuej9xiCkidCf1vwJHRtARvbhzTzRLP+9PRlMQ5UBhQCWKZLtkK10VWaa8N5NKugBLvRt1kM161qKXmtq/5XwBQ9wCliYMAN1ig19VN2SVGNOPMZFbqHURda9A3DBBYnxSV1PJNdf0adcanazAuAAehl4tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776422805; c=relaxed/simple;
	bh=xxPE7p8J+Km72Fu9cE2Qxt25fuNU7Me/NosNShaHNjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VRnYVlXJhKx4YgwgItQCuokwYv9a9bjznemsbgNLY164e8d+aVsOGZeEgFgfff0Ont6PWbr7jNGrdQH6v/F2FpSMfpRdImvPuq+JnUZoX3T4JDNacgsN09acbAnw7dLjmLdbpdKEIuwGWZGAGJ3wYkyJpHFON5gY6DF3f6LH3Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D98juoyW; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D98juoyW"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d73422431so386324f8f.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Apr 2026 03:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776422801; x=1777027601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QNXTybxJ7WUCuHtax9bzQlVrZGGr1HrE+ejN+oTzKns=;
        b=D98juoyWwpuagggfgPldpCLQTma6O2DSeNa0amhIguhyD4ZAon7rSMtBELy2OEPrJ5
         WUmg1o3t6nnm9+0IotJoLynClIGT3CAWVNaJEMwAIcG84cG1s7qExFqR3aBMPyMlx97s
         ptVceuYlyMBagQN6WuSD3t+RPyBj3Jg/fw/zGdouRpBD02kdSjJlorTWHmqXYAVPJmc/
         GnxtfkCcNyewVwgEtIGIBjdYeeA/KgvqYjUPLfPkKRL7oy9t9nn7Zm8cJjrWUJJG1e45
         nPsCLH8UX9I5sgu5/ftK93rIvyn8s82vphtkq1+usJuNn4uAE9W7o/ftKnarLdmnDz/q
         OjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776422801; x=1777027601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNXTybxJ7WUCuHtax9bzQlVrZGGr1HrE+ejN+oTzKns=;
        b=PQtkESnO41MqF6GvYyj0rkwvIbnUK1+R1oiMvnjr6Ikz8rQiChZNzbmMZJBS3sqLfv
         kUBFVWMKggK+CO1Fk/qSjAIesoKjVZ8hnPgzfRHIda9KB5uLgUmkoZRg/V9oKmxsiyS1
         7d4qz0gv8s+rB1T+VUkssre27aYdiCTcy8w07Rd9/47fd7eJM9l34jQ1mcCL693Wrk1d
         8nnHejU7uo7o9bGAZ6ilhoytgbRpJwDbK110IReV1Qt79w9AvJHiMslfBB4GEwqLchqx
         rtDnk5A2WYcspmKFMIuu6ndiVIq2YfflxCvo0HTQ4s4zY1sq949SBrqNXn4ciQgnsA9C
         bk3Q==
X-Gm-Message-State: AOJu0YzQb1+8Vl/i3jKtXiAd5SsGcChMV3kpRoaVG4Dta5Cngo6mH+g/
	fqOTKeOCFw/Ju0h2/phY42tMnUqvID3aotON33Bxd4K+2xtsS6fo9jfl8SPsvCk=
X-Gm-Gg: AeBDies/XA7jdtj6xslkjZ0YdKG1wXFUhQ61cgaJsvCyjcgE9yesaHinPy0FJyuvwnH
	9bs/1UOQ57J3XE/XiNv90zDTVPoMqEwKF+X6HQQ1XipmVK5y0LcMDsQEN88GLtA+kutdCDOhC1v
	63/klJH3GUEcg46Y+elywh6jScnFf5xIbuf8FEuTXByzYRQ9rvDi2Tz7WdeFn6dmaTVaJyu1pkU
	rCx9VPa2qdp6ZvFjPJRZoMUeH5DJtpcUYNT9hFh6wzIfRK4ch53+ERdhk9SprZAUoBFCtRZ5LBG
	lUICWmU3P/ffYn1hdJ3y5F6cQteyjye2Y6PYkxWu8GTxUrOBqkgMFCobiMfTSR0VwMDeuKgFG4Y
	l1Vw1OOEDg7iXGKp74JUDSJj7bNiAxWDb2C1CqW1IAmT+rPtA2H9QSBzge//s98f3wERgpZLZZ4
	AnaW8=
X-Received: by 2002:a05:6000:2387:b0:43d:7c91:49c with SMTP id ffacd0b85a97d-43fe3e255ccmr3448516f8f.44.1776422800911;
        Fri, 17 Apr 2026 03:46:40 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb13a0sm3699809f8f.8.2026.04.17.03.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 03:46:40 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	sven@svenpeter.dev,
	marcan@marcan.st,
	asahi@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v3] Bluetooth: hci_bcm4377: validate firmware event length in completion ring
Date: Fri, 17 Apr 2026 10:46:39 +0000
Message-ID: <20260417104639.2608008-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

The firmware-controlled entry->len is used as the memcpy size for inline
payload data without bounds checking when the PAYLOAD_MAPPED flag is not
set. This causes out-of-bounds reads from the completion ring DMA memory
for the HCI_D2H and SCO_D2H transfer rings.

Add a length validation against the completion ring payload_size.

Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/bluetooth/hci_bcm4377.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 925d0a635..5d2f594c2 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -755,6 +755,13 @@ static void bcm4377_handle_completion(struct bcm4377_data *bcm4377,
 	msg_id = le16_to_cpu(entry->msg_id);
 	transfer_ring = le16_to_cpu(entry->ring_id);
 
+	if (data_len > ring->payload_size) {
+		dev_warn(&bcm4377->pdev->dev,
+			 "event data len %zu exceeds payload size %zu for ring %d\n",
+			 data_len, ring->payload_size, ring->ring_id);
+		return;
+	}
+
 	if ((ring->transfer_rings & BIT(transfer_ring)) == 0) {
 		dev_warn(
 			&bcm4377->pdev->dev,
-- 
2.47.3

