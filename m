Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C3F4D8D93
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896095; cv=none; b=lP9atzJHWUoYyXJtW8SlVXeAsoq+zluOAInTdZ9N6bi6iTfP57HLx0m7Yx63Xze+fRzdhOQ9r6sMT+X9Sp6YWluFJbFb9HLYO8JG6DVwaIi1KcGMNAeFyWOWhjQJ5P/ILg1d0xsVwlqfELcsItb7bW632UzI9hOlDm30HpPqKVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896095; c=relaxed/simple;
	bh=g9ZBkxWQkJ/c+RVm6Yxc9chr+fL1IMnzCQEXKVZqpT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q+mvA+uAApGbf5kYBS01dcmGs4RUdrIsI/teCdF+RsjfJ4g8O4//ba+qUhrBccH6elHS9A3snyEwEnFzamqlzHVFURTomwZRXO0sQvJ0LXAgjUU/eAFbE5jp2ABKiklri55DtODTTh3lhUTejBvqSHYtFbjvy/P3ueFIZAcNX9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=hkOtcR1I; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="hkOtcR1I"
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6553A3F5A6
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 12:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1791896090;
	bh=0xB5BDPUdJFu48nRTbI7VW4KLiWRolohDwA7T2NysT4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=hkOtcR1IkdZ+yl5WxM9Ioux4fpXILBRzHAWC93rOjauhjhfy4k945sT6q0S/mg2bV
	 f4IKXwqqgnQe2Gxd3f2qHM9iLw9kb44mIYmEVR1dcEl9xIPD2AU82HXEUqCAtggdjt
	 KWgInk6XTNFla5u/y2aorc9Nzt7JvyKvvmRmKkD+Va1A45GGPAIsUQIwu66OFFxEax
	 Q9wxnKbdW7ivCTlXhwpm30BaZmEadCFlzJETx1jbvT4XSphu0jpyrN5WZ3qGpQyPKE
	 KqjSmZDdmjt3vpNwy6uJ2NJp3r2LP2dolFlBW1u4Mxi0Pier9A/7lX2283bkofy13o
	 xqEsfmoszFJ8wF2yoTFWhp0PE5hvoEp7sX4csl+95SiI2iDEKpb9x79VamzAgD/HlS
	 6jOawttEb4WMvcMGGCgUUSqcBUm+quysEN02g+uXpChlLkLXmVhbiSqgxtzcqI/ExL
	 E/ubnuLXqJodZs992+QwS5ZK6KPT9OPIJVQpG4swdtrbWcnBejboYHe99j1HcF1MN/
	 +acQVNWvbo6ga4S+hY9wP/ofiJ5YM7XhBIiJnbq5EgGUs+4BJziSJOjLyiTrpyPpnM
	 XYmFL7CkmW1509fivvMwu2ek7WWbrvb09B4kHO/Vxe72t1MlftVsEQzqmhBeBLYwqi
	 XUiP4bM0wpK6VnHXex0Sc6pU=
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2e83e0cbbadso3249345ad.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 05:54:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791896089; x=1792500889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0xB5BDPUdJFu48nRTbI7VW4KLiWRolohDwA7T2NysT4=;
        b=UwROOa6AQ9Hln/AwuVj2cmSSNH5zRQ7e2aDmqgfZ7uusw39dmIErXMD5VA1teMZ/lm
         QxoVRps18zxTxwXciaIv9cByh+DTgm7z+Q8RllWuzArcGfzx/Q4D8m5r4mYo4CRjh65v
         YPaOw9fRbqca0YEoGxxOB0ly7EXymHqEXf1+rME0wZHorw9v6T/UOmltd26/xRXIHOn+
         LzgVcuuqWToK4LI55mBSlqTmMorIqj4C9nt3w7PjJF5Qhmi0Hg9XIqrX5G229JWn30Kj
         c/2cUw3A/cPlIGMH1n/qTqKWt75GrGjTpGyQPbJdzzQ3gmLUn6lP6sRqBryoGpK7jgBD
         1C0Q==
X-Gm-Message-State: AFq9FYKa81tfqGhbGXJ3/hAwU6W7C4z5s5bkLtixh24yVF7ILow6my2w
	Kh5bOYNBkrzyEM4Hz66Y9zgy1NQ9Jn+4LS8nSOfJEcZW+zYPj2pDDSSYyX8UdIN+fp5XkVD62eZ
	9j6+TOxblcrcL43ZGSornBL+8aKR/r+sXbfxccrx2Df6yaogs32OMsDAsaycgjIsjxxi6n8Iiud
	gi+SPS5IgL3WmPRsRDKQ==
X-Gm-Gg: AYBFou3E8ukXONUcOhmHPjmokjlV+uL4y4sH5/7phkIRcAsGpUAN/Wp2FCkhkOLKb4M
	UaahZ3nyJT8SYkJOhHqtyGY2BzvEIICd3409RqsQUKhmHrWMRSKnsyWYrdZ4/7N6UHvTSYg+FCC
	Mukea173rUP6YZon4hBf46MjF1vZX7T4TbjGb/vBfUQ6RPsm4t6mf7sB9nrCGZ9t3COz75u7jk+
	5+wihutAHfoNkzShNE0wj9L1300PaHwnRKOjozRvoMOz62xUu4mSB2sieJ7KnRIUsbQpLEkyqvf
	hBm4WpS0US374OeN6FscYyvW1fNw+jx2BCwZzfuuxWQTHbo8OrHIDqCoqPQD8Si46GDNvgnwAuP
	RCJSMuMg2mFTyOS4LZ+wGpoZB4ewopJZqJlPKX53egjv6sz+igdu6Rq5/jfS8F02BlYdJH1LODh
	mA5myiy/kJaSG5FyZfc/eHR2mg23dCyUdGBJpnaQefRGIBLgOoHtCAyym5lbbTybr05q5Ku6NxA
	mFisSq/iWWMzYMc8FNU/JIu3kj734EUPZhUIUdUhjE=
X-Received: by 2002:a17:902:dac2:b0:2dd:b95a:e1db with SMTP id d9443c01a7336-2e8429a9f89mr170224555ad.3.1791896088686;
        Tue, 13 Oct 2026 05:54:48 -0700 (PDT)
X-Received: by 2002:a17:902:dac2:b0:2dd:b95a:e1db with SMTP id d9443c01a7336-2e8429a9f89mr170224335ad.3.1791896088316;
        Tue, 13 Oct 2026 05:54:48 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-d938-97aa-f951-52ea.dynamic-ip6.hinet.net. [2001:b011:2008:445c:d938:97aa:f951:52ea])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a05f70sm54894715ad.7.2026.10.13.05.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 05:54:47 -0700 (PDT)
From: ChunAn Wu <an.wu@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	kiran.k@intel.com,
	chandrashekar.devegowda@intel.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btintel_pcie: guard debug dump before hdev setup
Date: Tue, 13 Oct 2026 20:52:41 +0800
Message-Id: <20261013125241.1230408-1-an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An MSI-X interrupt can reach the debug-dump helper before
btintel_pcie_setup_hdev() initializes data->hdev. The helper then
passes NULL to hci_get_drvdata() and crashes the interrupt thread.

Return early when hdev is not available. This covers the GP1 and GP0
error paths while leaving interrupt handling unchanged.

Fixes: 190377500fde ("Bluetooth: btintel_pcie: Dump debug registers on error")
Cc: stable@vger.kernel.org
Signed-off-by: ChunAn Wu <an.wu@canonical.com>
---
Changes in v2:
- Add the missing Fixes: tag required for the stable CC.

---
 drivers/bluetooth/btintel_pcie.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index ac7193400769..8d7927bd75b6 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -297,12 +297,17 @@ static void btintel_pcie_prepare_tx(struct txq *txq, u16 tfd_index,
 
 static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hdev)
 {
-	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+	struct btintel_pcie_data *data;
 	u16 cr_hia, cr_tia;
 	u32 reg, mbox_reg;
 	struct sk_buff *skb;
 	u8 buf[80];
 
+	if (!hdev)
+		return;
+
+	data = hci_get_drvdata(hdev);
+
 	skb = alloc_skb(1024, GFP_ATOMIC);
 	if (!skb)
 		return;

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.34.1
