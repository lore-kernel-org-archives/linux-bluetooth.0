Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACF1198A2F
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749137002; cv=none; b=DvjPTkudvSds5kgV6pNQB4tLw1SzeceE36rVf2EiKJJRhLKIx9YFqxNhP8ufym/Khx+e5JxDPRo7IeSrO8jyB4Gw3YY5aIG8yD7j+LeVocZGGbw9g4Cpooa7STMcGUghce2zqbnPQ95xIidGKUUEV5TD9bp4D9GjCUTOJkETJSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749137002; c=relaxed/simple;
	bh=UDVnVovEJNMlIbhNwqAgQ2c4zHn/UjcWlVHTl8CCXMU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CSwJKA8Dtn0zi/BXMu7lgTA5QAa5NUH+2TOtLeCzMMgddHd6nUwInMyPO9ryYkIn7iKzMufsHyHAMTXuFJPmzMkC5b8Bt2PWVbsYA2gpKyzpx77K0ey494OjzV60T7cChkH57tinas4Rgt5S30PIPTXyd3BHLqTYFklZXL5UFao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvJab3QC; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvJab3QC"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-605fda00c30so690760eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jun 2025 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749136999; x=1749741799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QuAev6ItmI0AfTnXcTojR28G9ub7l9Nn1BZH8GEVQPs=;
        b=QvJab3QCIVEktkDFXZiRseqt0cb9XuEZSi/U+GFJoz2LBJ9yqC3maImVpFPrA+xYZ5
         vDIkKYPCaxWQwA7DFlxpAfnhx2u9qJYwe+qZLVfVyYPYo4h9zPQEhP2tjy8vPBufFL4i
         oFTVMDShquvT56tCZEBj2F9JU178CgbgmYeXF+OZETjMUBSGEuB4XMBWFBGw5dmR7Kn7
         kQRDRrH5dqcuqkwMUbOVSwGmhyzaZqzoI5Uyh9gYvVQTZiniGzu8aZchYUlkvbQ9XRcU
         saOBV6iW5+mLkCUPIswH4Hx0N22efQhRAnXL9BAKiqU1unLOl8NReCoLuKxCVYBTZIa6
         JGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749136999; x=1749741799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QuAev6ItmI0AfTnXcTojR28G9ub7l9Nn1BZH8GEVQPs=;
        b=pZNNjs/nSqSk6VE0HM6S7GbKdQxZmTkBQHbnSHYKCeq9/gtgYPfpJN8DlCWgqqoDr2
         DJsuq+T4ib6uJwJbSoZPLe5mXgA+gLXjtJF55RdniEREZrbeL/pyrNQAYB6ATn/T+FsZ
         soNEf2GHAdD9EZDrWGLvsLSAJIfNBIf9pZ4srKddBzJ8yxdquU9J+Uw+fDgw2gRxW+9V
         WhH40mK+nqcudtRfaOj4aH1DYwWiKyiXEBz+6EqKZvrVRYAIyriKZaAlkcnArh1PDQwA
         Hn/4UxbIjyKUyC1x3mi7qHzKAtehx8s9I9V0TMjlV8kj8ezEOVQwn3LlnB//P3C2FW5P
         0Fww==
X-Gm-Message-State: AOJu0YxnAo4y1CTV0t7y7tt/lRw/7E1xUbNvnN+ZB4M78KwgMgREgNd0
	R84yXq/SvvSzAoPe+6t0/w3Jhf+EzUpGoOfExH4UISB9CCZQNOFajmx6Y9vD6IZIfsI=
X-Gm-Gg: ASbGncvQh2Kj8FazL8OsoOzPye1x9/fE6clUv2UCw/99oT/29eXQbftSKjw1qk6AEgu
	Va8fLnhDafww4kLAaPpJflWO+PC+I7YOfu6Pn6I4+6of+lFuzMMu17NLb+NuGM0xIDiPrEMQbr1
	q3bokm984Pt9C4V2w+WoRM/mVyRAGc3MCWxvj8wbZvin8/ID8eebg0HtEGBc3LDIgOYhuPFWJu4
	DC9cWA8LbiMwZu7ZibM4TNT2UgVtWZYfr9haJH3y0/RFEu92HY9JYN0DtsRz2XZMEqgVh6UcCyd
	TF6p9h8tFPfKlNCuO7clLrlWLain6ci044LITS+A/CEMmyFD/lagP0UrJ/mN6iWzUkkjtA0pt3q
	V+pZLTXsKjPtcfyphcgy3
X-Google-Smtp-Source: AGHT+IHCczaJ7AF09Xa9MDrOxBIQFfuqGrNJuq0RMc58XMd7hs/nEjjXYdlVB/GTGsXhv6ErKIeykA==
X-Received: by 2002:a05:6871:287:b0:2d5:4b92:a787 with SMTP id 586e51a60fabf-2e9bf4ce8f5mr4698467fac.18.1749136998700;
        Thu, 05 Jun 2025 08:23:18 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87ea70e5ac1sm2295592241.17.2025.06.05.08.23.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 08:23:17 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 1/2] Bluetooth: Fix NULL pointer deference on eir_get_service_data
Date: Thu,  5 Jun 2025 11:23:15 -0400
Message-ID: <20250605152316.807664-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The len parameter is considered optional so it can be NULL so it cannot
be used for skipping to next entry of EIR_SERVICE_DATA.

Fixes: 8f9ae5b3ae80 ("Bluetooth: eir: Add helpers for managing service data")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/eir.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/eir.c b/net/bluetooth/eir.c
index 1bc51e2b05a3..3e1713673ecc 100644
--- a/net/bluetooth/eir.c
+++ b/net/bluetooth/eir.c
@@ -366,17 +366,19 @@ u8 eir_create_scan_rsp(struct hci_dev *hdev, u8 instance, u8 *ptr)
 
 void *eir_get_service_data(u8 *eir, size_t eir_len, u16 uuid, size_t *len)
 {
-	while ((eir = eir_get_data(eir, eir_len, EIR_SERVICE_DATA, len))) {
+	size_t dlen;
+
+	while ((eir = eir_get_data(eir, eir_len, EIR_SERVICE_DATA, &dlen))) {
 		u16 value = get_unaligned_le16(eir);
 
 		if (uuid == value) {
 			if (len)
-				*len -= 2;
+				*len = dlen - 2;
 			return &eir[2];
 		}
 
-		eir += *len;
-		eir_len -= *len;
+		eir += dlen;
+		eir_len -= dlen;
 	}
 
 	return NULL;
-- 
2.49.0

