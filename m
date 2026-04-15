Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905C91552FD
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776294124; cv=none; b=LyeN4zOqPEBsh/CTTQKlJENMBgvsA3kIsFTeHs7RIsaxP7xzNFZWYUkN+KFHpiyT91/NwX4IEW15wCYJKoRPIa0+rgt5RYgyh5MHgfYz1odQ277L2i6ohNSjc0IrA3MwHxtRbljquXDq0WUwuQxzJOukd+8u6HzSwYWYHKr4+Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776294124; c=relaxed/simple;
	bh=erBODFHxB3eerf2uoeplED+Ky6AlXPF9a1q1K3XBXaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JK/0W3ewz9NaAvcv/Cw5NcOMsJk595kDfNZmGzAIqksCojXtXvosT4RlrXVG42vhparZQkVoPSg8CCJYwTq/QWCpTHq2XTPWf5ooc+3ZJbrfVUeuaW8S039DGzPPM5fF0ODQP59gOsq/e1MD2eOvXDAk743aARiOafNsycLTBQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5mowqPo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5mowqPo"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488a4bc360bso40812985e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776294122; x=1776898922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OKmdQeKtV+AFbzb9cVnp2KCouho3xgr2x8WACSZd2Vk=;
        b=E5mowqPonn66E5N2fx4H9M7zYqg2yf919gBn3iAx0MiQpFVz5QeaDOOPjggqj5q68L
         LJwGKFa4wenH0EkLoYGm3AVL9E2c1KO7kNeyOMSHfPSJpTt4ZjZTnaRWyKVGHXKRELXj
         3014rD0V9i09ub/bqIh7ls/F9MOhw6QaAlvUoHvvQq05jdKqnUZuSXHCIYgnD3dYNsrE
         mKEnY14WoDwsEKlfUuUtYfkwUbZyMwa7A61smzJIwW3Yu4SEyxcQllQw0PhmGcoWvpx5
         F+ujBKNlHJh+6GNOCBNUvLXrXzcpChmYlfW+FzLe/SFqgXbkBpJec0R0V6pR8PINfO7I
         Nl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776294122; x=1776898922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKmdQeKtV+AFbzb9cVnp2KCouho3xgr2x8WACSZd2Vk=;
        b=dEnL++bWZQzmsGj6oUr0WrrE9bMatw052kp/fmm1cCshcHB6z8sBJcuyrXXBKUZkE5
         M5hr7u+et2H/0knbjaW9Mm0FCBR6w5Pzc6h0mXLRxl3rkajzjfKQda9ISrlW48zkncFw
         q3nT6t7ikRfJqECC/eI3VKWw3f9fuO7U6wrU3NwtriA0ryhWwhZa2ylVNvC3fu+lZDKB
         7+8Wttb574gh8yy+Bx4xKunObjBa5bt0xUGEwOtDcoPpwuYJOIE8eQ3pYbKRcMcu6hIL
         S3f4R1OiiFwR/y3iWtJiL3fTzKFq7RyGkexRYSwB3AAsbWJ6xDY8gz0wUTiB9js/8iQM
         w3Gg==
X-Forwarded-Encrypted: i=1; AFNElJ/zuaL5OlkA89yuECvULsLTg+1iNMkSo9qzcXtsMN4/V4sG5lOwaxVB05lEE4JLqgb/duBVhWmxjV8GcPPnt7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq2YNR2aSmAAdckITJ24qmRXxKJuRYtUAWDSWszvdPv8rXMICF
	qJVUCbWC3sr4MoYEXZMkLO+mHGIh+JIBKc+Zqi3tXFGaEsPV9D+E8R4=
X-Gm-Gg: AeBDietSL3mJjyWRW1OWe/xFSXuxCs7W22TK3TiYj+xv6xzCmU9FotGTBDql/pnILLk
	6SEuy6hkAN5XYTCuinuIUnk3Qj1FQXp8laUaY19uRTQqSY/BB+EdbYDyjJaPZt9yeN9itaveRdx
	c8tXqoPQ5P/n9cpHe247OWdxi7vj3l9PxsyWwvtTHJe0xR+FiBIDOvYfaxhIQCFNjcNxwWgDyfw
	34P4g0W3Lk7xnzb3tkeKk23gUaxEu96qnpuKM28BXmQrSvDkS8DOVB/ZJwqq1oxyaRMykIgFACh
	0qWha8rXgU3EiLCtmNXoscFFSWeMn7V18AtPn8lSsKZWdtLiBsVEcevLc3aQL7YVS55yx5MY93N
	cqH+/SBoaD3vmy2dZq8+kN+G0+LL31h+6wDDBMyf6jV9XIRKafWMlRsU5Bs2WLqcfeXKJAznO1E
	4GEJaSG6t7S8Cow7zw
X-Received: by 2002:a05:600c:1987:b0:488:b187:d8ed with SMTP id 5b1f17b1804b1-488d67bf765mr329800595e9.2.1776294121926;
        Wed, 15 Apr 2026 16:02:01 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0e9a770sm29143005e9.19.2026.04.15.16.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 16:02:01 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: sven@svenpeter.dev
Cc: marcan@marcan.st,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	asahi@lists.linux.dev
Subject: [PATCH v2] Bluetooth: hci_bcm4377: fix OOB read from firmware event length in completion ring
Date: Wed, 15 Apr 2026 23:02:00 +0000
Message-ID: <20260415230200.1759546-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware-controlled entry->len is used as the memcpy size for inline
payload data without bounds checking when the PAYLOAD_MAPPED flag is not
set. This causes out-of-bounds reads from the completion ring DMA memory
for the HCI_D2H and SCO_D2H transfer rings.

Add a length validation against the completion ring payload_size.

Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v2: Resend with corrected diff context against current bluetooth-next tree.
    Fixed format specifiers for u16/size_t types. Original was sent via
    Gmail which caused formatting issues and stale context lines.

 drivers/bluetooth/hci_bcm4377.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 925d0a635..5129708fd 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -755,6 +755,13 @@ static void bcm4377_handle_completion(struct bcm4377_data *bcm4377,
 	msg_id = le16_to_cpu(entry->msg_id);
 	transfer_ring = le16_to_cpu(entry->ring_id);
 
+	if (data_len > ring->payload_size) {
+		dev_warn(&bcm4377->pdev->dev,
+			 "completion event data len %u exceeds payload size %u for ring %d\n",
+			 (unsigned int)data_len, ring->payload_size, ring->ring_id);
+		return;
+	}
+
 	if ((ring->transfer_rings & BIT(transfer_ring)) == 0) {
 		dev_warn(
 			&bcm4377->pdev->dev,
-- 
2.47.3

