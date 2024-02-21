Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FD37F7FF
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708526299; cv=none; b=bjwerqVu4vXLPJHoBGZqArAe4SstzNAQzzYE75ZMzyrgMILS9cpjLa+RKEau3wJP8FPbEzcgqNQlZ2wF1CnS1msY2bKfGAV/zReFfRsNaZTjELQ0BdVzdpFr+JjFz9pbomkNNXSk8/oEghpaOCO6EAiOhAKhn1+tgWfG0blhJxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708526299; c=relaxed/simple;
	bh=DM6JF+QL2M3d/jC2Z9vqrIxg02qCUo8rLp2G+5UDybM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH5OB7yef2rdf20/X8YDmTJL2oOV92CxyOZxFadN8SRVPor2VWXzNVb/Dn/GxPRCWu7zAfwsz/VMYRbbE8TcYHs+4dqIyKjdhkvorAtQxcYTNQRh8MNRe7C2+WUW1zDt3EJhzbSDDebphWn2rJ9kbM4evxLeau4SmHzcp9u8fuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBwKFr1L; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBwKFr1L"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7d698a8d93cso4682842241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 06:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708526296; x=1709131096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1tGRYuxSFtXOP2N+3nyu8coKSL2XnN9J/yyXp1uPW4=;
        b=mBwKFr1LvN8t191BZBd0+g9Ou3xe/7aaK9voeyma5q0Fzi31kxnVpFOV1o1PqwBSKz
         /FeBp9u2ZuCmMnXbFmxX9shVU06AsPyBushhqSQ3+eQXnV2AUoh7uT7oRBtHxepI3Rwc
         9ayZLAPDI1Yi4P5xUSGp4srnLqVJPW3UQ3x+2AHu67gtYofYYKKmI/RRRZPF5DJTDuyp
         d61fzZpC++k8hP0PU1W4Byq8cUou/OIkNu8zkSdRDZQ8/dEv9ExfdWDv9q5WnECmVBEr
         AgtOSemU0PIZ9sDLH21sdWNTYhq1gEtvk5WvI6QHRMASov2tXk+w/wLnYvUNZR/r1DRA
         Mruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708526296; x=1709131096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1tGRYuxSFtXOP2N+3nyu8coKSL2XnN9J/yyXp1uPW4=;
        b=hKVdTW9fUmwW1QcrSaQeK0jwu5Zpt5Tg44lp7ZVp43VPAub4JXbC1xNAabeK5lXYeD
         BzYUrKqMe6tvaF9U7D3e7hzjopxspPsOr0QQjg3t5oc1I/JXN794Fm+fUHhGFLHyyckO
         7QNn8L2APAy4XS2Zi9C2I/ivSxKPG+6Cgv7/3P+hBFejy8xwqT8DGHbEWoqASc85+bga
         XWjSaVao1dqIHxzpXE5yERVPP+1h59xOhjLEVXolzYRkvVYsFn3eHGmw+2JcY+/mnn8G
         MElLAOeMkjjuF0iwRb9LGjIg1+Cgvs2Exw4KX1zSYbetzf794c4ln8Tfs2I6mx/T/k4q
         fXrw==
X-Gm-Message-State: AOJu0Yx1F+EEwj82ZrybOuD39RJmu+soT3KtGppCTf/tTjGQHEgYS/5W
	/7MIYgCmgzRJRX2EsSeOLlbrB2dQPz9n7DgTPREocwKc1FuOYChA5UFsWEos
X-Google-Smtp-Source: AGHT+IHckf3qPCrh34XoLAMa4Qj68JCoehsdevtUtTS/XBDPgXwaVALYsnXi9qSPEM0md7hPWypL6w==
X-Received: by 2002:a05:6102:492:b0:470:5b6f:5ee9 with SMTP id n18-20020a056102049200b004705b6f5ee9mr8081178vsa.17.1708526295880;
        Wed, 21 Feb 2024 06:38:15 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id db22-20020a056130239600b007d9150e1596sm1807716uab.33.2024.02.21.06.38.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:38:12 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/2] Bluetooth: hci_sync: Don't scan on Coded PHY when HCI_PA_SYNC is set
Date: Wed, 21 Feb 2024 09:38:10 -0500
Message-ID: <20240221143810.531710-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221143810.531710-1-luiz.dentz@gmail.com>
References: <20240221143810.531710-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This disables Coded PHY when HCI_PA_SYNC is enabled.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ab609089ac4c..e7ac9a993a07 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2786,7 +2786,7 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 		phy++;
 	}
 
-	if (scan_coded(hdev)) {
+	if (scan_coded(hdev) && !hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
 		cp->scanning_phys |= LE_SCAN_PHY_CODED;
 
 		phy->type = type;
-- 
2.43.0

