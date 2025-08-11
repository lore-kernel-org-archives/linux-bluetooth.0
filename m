Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA41E0B91
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 15:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754924654; cv=none; b=mF0S83fcP8VA6ifA/lVaLU8jaYq7p+p4eWWVOowPVUT3A8hgNelzvJr5QcG58Lge1WZdlqPSMbNsVNtm7uka7iiYjkkrpxsv7JEqoGnPkhYpr3KZKitAr9vC8xSYnnoxkpMLj8swGj1XKINUbguXkQt5a5RDTuKPx8T/7pz9rwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754924654; c=relaxed/simple;
	bh=go1LK2KwIv9bOBtJoPVqpan3/GxOSDQsRCCrqOTX41I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kavPTCve5fZYGNCpUEaEbSKhOCPTz+K7CkCi5eMWg4tKgaXcKU8cfuXJ2QMWGxnuXRUs8SHseu8dtAmT6mD+lwx0e7NAFYBXiENa2Q+rXcTfX5PJCcKMWvjFuUYHqPXC8cgMxuPTCVTWkzZGOCHxgdId7p1VX9hqycOhLdPH0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jL8L+J30; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jL8L+J30"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b79bd3b1f7so2070952f8f.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Aug 2025 08:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1754924652; x=1755529452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5RlVEC+aTLY5+N9Mh6FGBCNE6f9ARS3XfPyHyJ93cc4=;
        b=jL8L+J30UIefYSD7OQpysfjUoXmu+NW6vsSl4+tQBD+Uz0OLVOmVa1/eYtAQ1ciyc2
         D/75x5tD4VP4MuRF3gSPtCArjhreVrNkkziUY5iAkHA+66TD6gnpb+UGWdHPCQnJFQWb
         BvoPDrRFnKU39JhJHA03vRf3TtfMd+6hyF0tiUBEFsBaN+LKpsszf2jF/708/YArooPG
         u2ce4kYMzXJrhuIQkPdW4bBoXjFjI6vcSkDtXcWvLXmLB4kL4Kl6l+DvwrQqKsMoVK94
         xmizRMU6r1FNVAbX6fSdfYfOmPtRrf8NGFD+tdzo0Qd0sO+8XFu5Fj6P+Ih76pk6Omez
         FSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754924652; x=1755529452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5RlVEC+aTLY5+N9Mh6FGBCNE6f9ARS3XfPyHyJ93cc4=;
        b=uj5m3p9fvfChL8kFnDukLtGNAiRyP2kSEEXPPs1n8Gh9yqexGYVieu2RJ3LtzkDtAz
         tenUKBQQC3RI1CcEBEc5LkZScSjjxqdbyCKqP1Vzgkp2EcaiPrHOx/MgXMG5c1LHh2tS
         lcBlJehh26t17fj8arJbo1aJruOfo9LES1K3wj/TOPjTGH9Z5YGSZtL5VWC6D+N5jHwv
         5gfQszyKCKrQoULSF7SS1AaO/DuED2U9abXS/ZWrNCtDECbXp4bs3qVUUex48R3ujjVl
         mLcaegnmdNhNIT6MnX9VP48kcPxjdHS1mbhAw3MgHXFEN87JBPNWiRojlWGLJDpMccdU
         oHTw==
X-Forwarded-Encrypted: i=1; AJvYcCUHL1y6jbcoFx6H2hrzRwSNGo66ZkoSBGZbWXb4oSQieGy9jqp790OLCCg+pkQd/rRxGZhW0C7tux5D6EHrhuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYLmj7hPy93efUgxpewnUNm2j+eJBz/o897lA/kLrKzFiK112h
	Bs4YnNp9Cv1JTaAk9tkwR388Pcx43o5vTRk7mG6ZyH/WPbKRTM1k6igkOKYEnkGGocA=
X-Gm-Gg: ASbGncuN/AHxPHiC+w93jfM9m/4ByrrvKmS6wpgNGs/qeFGn4+VVB1+t8lgr2DaZe6h
	w6MUTqQ3Muj2hS1xTPg/wAKbbfO4ACq5yF35hXFfy/bDOB0OOqhe98soGlfubHBgSSiAxG82vrs
	MeOzTXpcBWsEPLqGerZVGkifrMG9UWrBwuiYPhhqSeqg1JV0tdLNfpcs7vfB/xjXjE0eoW4Iuc+
	aJC3BBIyWk/GN3BdpME58omhwlomhVNAThpA9d2hXQQWOXUjFhTn/FCLxYuq/cV2dbQvRg7teqR
	Dzmy+ZL3IP/2P/SCA378SOQGjHXET9DiY0Eg8tiPO+nQIdoCCgsNbTH8QjZaKkJV0TIjMxcQmcf
	mSx+2po6+M/oR1TdAfiritGjg
X-Google-Smtp-Source: AGHT+IErrHO1m9HgaSb9y76gv3JeAANqPlGpoK5F8aU4R+7lrtTdLrB7aKC4QbEySQ2hh4TjE9oVHw==
X-Received: by 2002:a05:6000:4312:b0:3b7:97c8:daad with SMTP id ffacd0b85a97d-3b91101718fmr36718f8f.55.1754924651630;
        Mon, 11 Aug 2025 08:04:11 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6841:8926:4410:c880])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3bf956sm41850591f8f.24.2025.08.11.08.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 08:04:11 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc: Shuai Zhang <quic_shuaz@quicinc.com>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-bluetooth@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Subject: [RESEND PATCH] MAINTAINERS: add a sub-entry for the Qualcomm bluetooth driver
Date: Mon, 11 Aug 2025 17:04:00 +0200
Message-ID: <20250811150400.86926-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Patches modifying drivers/bluetooth/hci_qca.c should be Cc'ed to the
linux-arm-msm mailing list so that Qualcomm maintainers and reviewers
can get notified about proposed changes to it. Add a sub-entry that adds
the mailing list to the list of addresses returned by get_maintainer.pl.

Acked-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
Resending as this never went anywhere. Rebased on top of v6.17-rc1.

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa45..4663146de10a0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20641,6 +20641,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
 F:	drivers/net/wwan/qcom_bam_dmux.c
 
+QUALCOMM BLUETOOTH DRIVER
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	drivers/bluetooth/btqca.[ch]
+F:	drivers/bluetooth/btqcomsmd.c
+F:	drivers/bluetooth/hci_qca.c
+
 QUALCOMM CAMERA SUBSYSTEM DRIVER
 M:	Robert Foss <rfoss@kernel.org>
 M:	Todor Tomov <todor.too@gmail.com>
-- 
2.48.1

