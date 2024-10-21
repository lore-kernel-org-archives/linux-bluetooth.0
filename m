Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6037A1F6695
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513553; cv=none; b=Az675W50WtV/l6mhfQ1jD8oXXrTfth5SmDWNl/wTskwNayLc1rEvePZ9UY8M+p8xeCYQqu6JhZJgyMaGaGI+omLU9WBbgzH4G1CUFgOnBEgMSR9uEcMwuHXEEx21hPZobv9JDWFdxaIiUvsD+mxXNzHTGxhFYMqfGCviJL0LrAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513553; c=relaxed/simple;
	bh=pN6iwQ8rrAa16RpqTV5wySvw3c8HXFhur+2WDNzT7Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwpcLXgEGBmuy1jdX6G6ug2SFjtoogZ5iN67Tm8s2XPA6CogrcTMJEbVnsKjvecfB34QDL1K83eJUSJHqhggKyva7AZEfBwO6UvASmvS6jvMhfQ6A0neELM7O9q2KHrJTPWR55fvTTogbxvY5k36aYCGHi59bdawN/HSJ1Imh/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxqS2y5w; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxqS2y5w"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f6e1f756so5075361e87.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 05:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729513549; x=1730118349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBO5EpvMGaOIjapAVQEA8TCLKFaLwRBTYf1umN1QslU=;
        b=IxqS2y5waGFXFVTaiO9+41TqiRRUwFEHD+7VxdQSNzX5m2ecsT8qsg7iraFLrPIY2Y
         iNb4xcxDA82vbH43KtC18jk1VVT9i5ULVLY5UMfVZET1acmkplgjpyC1ft/QSP2uLMzm
         ThfjUYU4XaShBeY+4wU1ixD2IUB8DVyQvk0LpFrT7u21rOroMH6LoCK/Pfe3rkJP18Ta
         q3GSjqqlC7LgS7ei7ZX4OUN5OWQS21w2GMyCgDar1FbFTUXPY8PHVJzX2G3358oT+BnS
         FryOz/TJewVNbqoWVe3cDG29AGFCuhzzRT5dPyMbKM1J6A7dvhV7AMFFv1cQx76i+J09
         KDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729513549; x=1730118349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBO5EpvMGaOIjapAVQEA8TCLKFaLwRBTYf1umN1QslU=;
        b=f/leAoKJzdTazP6IC+n3D7jEj68wCHUs8LNkNWNok7qY7skLtphw43YMzdvBRKmCYM
         YaAVC9TnucH8P50lpOpYO+sl3+cVe3E5ETdAJMx50pA+j4dbbncfRXhDoYm9676zaESo
         xjmLXPLT1eY8zqFd2jSbGbPRG6QXbsMpfW+RJSkxgbDQmIMJp3t794w2xSZ6D27Ohej5
         eyqdUDENzh9mE3mcbIVDU0gBBTs88jWHDMYcV59aSWk7gjnGZdI4bCP4pP3ZVPWqd/zw
         sWx/bgVdln8P8NzMXXrdAeifphFVDyi4kvPZm/ODrTHrwF13G82ysq00rva70oZ/OZrv
         Szng==
X-Gm-Message-State: AOJu0Yy0KFdpIrupnYf6h3lc6sdoPK8Vh2N+2uL+loNiErNqXrO/ekD/
	C7gu3itFrwDoqLafU+oQII5DcUIYkgx1JDD/M2UmE/wiFPsyOzh4CS11efAfO0o=
X-Google-Smtp-Source: AGHT+IE+C7VRACpBMiyAehANCxJN2HDChru249TpqLd8e96nnaOsCaUptpGR1CxjGbsGtac6R9HPUg==
X-Received: by 2002:a05:6512:350e:b0:539:fc42:e5ee with SMTP id 2adb3069b0e04-53a15229cf4mr4956278e87.29.1729513549268;
        Mon, 21 Oct 2024 05:25:49 -0700 (PDT)
Received: from ha.lan ([185.52.141.89])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223f02c1sm464015e87.111.2024.10.21.05.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:25:47 -0700 (PDT)
From: Danil Pylaev <danstiv404@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: uhrmar@gmail.com,
	raul.cheleguini@gmail.com,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	Danil Pylaev <danstiv404@gmail.com>
Subject: [PATCH 3/3] Bluetooth: Set quirks for ATS2851
Date: Mon, 21 Oct 2024 12:22:46 +0000
Message-ID: <20241021122246.1569235-4-danstiv404@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241021122246.1569235-1-danstiv404@gmail.com>
References: <20241021122246.1569235-1-danstiv404@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds quirks for broken ats2851 features.

Signed-off-by: Danil Pylaev <danstiv404@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0317d27d5365..9970470c9d15 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3930,6 +3930,8 @@ static int btusb_probe(struct usb_interface *intf,
 		set_bit(HCI_QUIRK_BROKEN_SET_RPA_TIMEOUT, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_EXT_SCAN, &hdev->quirks);
 		set_bit(HCI_QUIRK_BROKEN_READ_ENC_KEY_SIZE, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_EXT_CREATE_CONN, &hdev->quirks);
+		set_bit(HCI_QUIRK_BROKEN_WRITE_AUTH_PAYLOAD_TIMEOUT, &hdev->quirks);
 	}
 
 	if (!reset)
-- 
2.43.0

