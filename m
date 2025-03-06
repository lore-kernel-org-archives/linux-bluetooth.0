Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229EF151990
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297133; cv=none; b=gigjuzmCVA8CuZWgOIveKLWqrJxCs0se7hb+1W2WpqfS/ygj3HcVU3JtUjPMEtD8D8mqFW5scD6gnFhwR4nB0LuBjP1GdsI7zw4FxBqzdVYczrkd80Bj/qLfSR2IIKo1vWg1dx3BvZxl+nynCvinHblwI8eNv1atwCIB4aRp2X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297133; c=relaxed/simple;
	bh=jbrkIyER0bHIl3tvELc+9y50gFNeD9uzr+mt/uFa09Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rb3OcRCFT+duGEmAJpyKijl5zI3ipFLmviYWoFqqoqq2tJTvpPToECiW3dFgkDREsqivtNLe/ijSGcs8SuuhjTRJ3gQLTbgykWdlAq8DBFPOx0KIddhrSk+6hbBIhTairLl/LY59U4PKkZfuN6UqkHFY5rK4f5PuJ9/w59mlsn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2Ka8BGr; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2Ka8BGr"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5239bc14a41so517559e0c.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Mar 2025 13:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741297130; x=1741901930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=BxFhFfd6PLAWiM8UogTEHGqL/Jfduzdat7XdoCLt6/w=;
        b=I2Ka8BGry57IjktMdEkDF1cwXX1A0/PUtJVokI/khX/suzWeYr8WJQGnv2z6OF+RFP
         nQGqQDtfTaiQaOKO6Us7mBDoMxQ7YDMrgK112udNI5mMlJp1iqdW6RhNRsoclXNmzKyO
         MzefpP4Om4ekgYs0NwqTAQXngHaejLiOwSId4o3Y29jkXG+CLMYZG0uLkeMtkUBONjr+
         H19EPoh5sHGQNUOAwi++rr21OBxtdTZd0J87HJWoTJqTbhd1ujAI+UCHEsV7mG95IwNv
         DbkWTlpEAIWnOTkTdWRu4WBlG7IsfCaOpgd1fQ0r0fR9WWc8nv/IoRs8d9ya1xiqr9Ht
         Ug7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741297130; x=1741901930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxFhFfd6PLAWiM8UogTEHGqL/Jfduzdat7XdoCLt6/w=;
        b=VQi4s34ysX5xoHyw7VfT7Ccgm8Ut+VtDbcigOAD0dgTaQbwMb0Iq0Mxp5V3L4iaW6R
         dkMimctBfcx6yxHNJ0R8WMohnhieVGdocPeqoq75VYYPu20icwN3/BVFR6HPoTuQ9NYl
         2ZWUhrMOMcg3rga/oVx72xXfiJqeCOV5TxFVdGLBkm1GJo7BF6rifTPhE5F+jwRPGvkL
         KkvBIE4TxxE2l/oTVkJfOkgQtcWK3MeQfssf+ZdqKEHPLYujJfUI6mgLX38iKKwoQAr0
         9UoiGtn6xA6Iabks0wMfhWxUdtzI5mcDc4YvFA3zkhWw0MulPX71uM4H7fl6KCxaxnuz
         2R6A==
X-Gm-Message-State: AOJu0Yy1ojGhmPWrkbQ0aiiJSfrc0s9/bAuKstR7/8T42qwtoodT8Yp+
	SfUbiM7Fo1IwpsBHGjmo0neaCc5ykXP6I/J4sa8ePU/YDSEqknpHFFAIEhuu
X-Gm-Gg: ASbGncugnvxHSx6xPaVr1StN5akuPYi8fD9+l7ml1iZaEVOmZnl1Wc9j5IbxJefKZ6X
	lOGYk8JlsHaq2XTSAxB/nW5WUGfhMk5rHogx8HvzuVxi/B0yDtM6CVT7jJDTkIJosFDsab6gbRJ
	BXdprOUZPWbBqZGcWbWguGW0JF+hQjTxV6tUU43GSe+pNvDfgsscznGOcr0DcVUaF6gVlImuYnf
	Oo32TxrovTDfjTV8CDnoXNhiUGrEV3Hm7Nd5TTl/xO7uUW8bVgcZzddoaoWpE06AZ8WiXGKOUI1
	sGEGJdWNXwKXDptrGUBZAY907ifJF540T3KsO+JCbgpT0FBqAHogdyXeJRk7j0q+2RoLWOE/9Ae
	LF4Xm4aPunWivEw==
X-Google-Smtp-Source: AGHT+IHrThYDVfA35lTs7x6ArXgyWKnbMFD0eVwmvpcMitFEN7M2Jhdrdw7nkY00EFlPqlCne6vEWw==
X-Received: by 2002:a05:6102:3fa5:b0:4c1:b339:e4f with SMTP id ada2fe7eead31-4c30a500d86mr730734137.4.1741297130273;
        Thu, 06 Mar 2025 13:38:50 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86d33be2da4sm367395241.13.2025.03.06.13.38.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 13:38:49 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: btintel_pci: Fix build warning
Date: Thu,  6 Mar 2025 16:38:46 -0500
Message-ID: <20250306213846.704638-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warning:

drivers/bluetooth/btintel_pcie.c:695:20: warning: unused function 'btintel_pcie_in_rom' [-Wunused-function]
  695 | static inline bool btintel_pcie_in_rom(struct btintel_pcie_data *data)
      |                    ^~~~~~~~~~~~~~~~~~~

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index f3ab5b41b050..9114be1fc3ce 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -685,20 +685,6 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
 	return 0;
 }
 
-/* BIT(0) - ROM, BIT(1) - IML and BIT(3) - OP
- * Sometimes during firmware image switching from ROM to IML or IML to OP image,
- * the previous image bit is not cleared by firmware when alive interrupt is
- * received. Driver needs to take care of these sticky bits when deciding the
- * current image running on controller.
- * Ex: 0x10 and 0x11 - both represents that controller is running IML
- */
-static inline bool btintel_pcie_in_rom(struct btintel_pcie_data *data)
-{
-	return data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_ROM &&
-		!(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_IML) &&
-		!(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_OPFW);
-}
-
 static inline bool btintel_pcie_in_op(struct btintel_pcie_data *data)
 {
 	return data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_OPFW;
-- 
2.48.1

