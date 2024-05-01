Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8822137F;
	Wed,  1 May 2024 12:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714566914; cv=none; b=u4nY3mshLC4rKzAUYIhocZjo1G8rNUgnc4Z9wKhe377FFBdT7fPb3X114Acmp9crwlrXPkJMI7KOhbHRyjs+cRGZG2IY7veVf1Goi46DUTck8Ol3Ey8Mdvuf8nCYj9/Ak21AoKPFtOCL8uOyms+WdAZnKgoBe3bsnMXM/YOHb1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714566914; c=relaxed/simple;
	bh=S5cbOf4wzYWFaZnxwKUPJYwrWwfrm64ZxfqElfQ3dUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBVKw/cAkL1eYeTpoyu+PF+vhxAxHPfrFFy5OtsYlugCNRGJvX8j1oWQeD+/RSdNJ136wTEi+sgMiALOFuWtoHItXuI3xozdg18UC+UvDRIx2tBg2pWjhfR8djEiJFaSHWbiA8ESkGRnJXH1FFMvAfHfi3swDsB7lLJ6JtdFy54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rr2+9ToM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rr2+9ToM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370BEC4AF1B;
	Wed,  1 May 2024 12:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714566914;
	bh=S5cbOf4wzYWFaZnxwKUPJYwrWwfrm64ZxfqElfQ3dUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rr2+9ToM8ykgR9t0p0CU6MACKpuWcMzoDCthW1srAeuXcr9T36+U9dmSAgv8UbF5v
	 8aV7usk9zVKCkSmD9rwrwkCgNlMvSUPsru39fTsH79SLJyoOFkfejrlRqSBUl5jEpq
	 JnFgDhd+oXmpNkUr4vT7i+1d7dAyEdxj5BRPJEVWr2RvTdR5wfuzyEztsTLcX1x6jQ
	 9Eh1+Yc8/DcRXU+wkwo1k4gIRgOmO7ewh6d28VYrmcJB0Jo8bPphbe9fLgfxP/enDv
	 +z0jV5zvj+T9z5l8rgTrEnB462T57UjStQf95i5XxXiCS8dbB6qYlWqeBcxpbijG81
	 7GC5Xf0LUy66w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1s29B7-000000001l6-0PWw;
	Wed, 01 May 2024 14:35:17 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 4/5] Bluetooth: qca: drop bogus module version
Date: Wed,  1 May 2024 14:34:55 +0200
Message-ID: <20240501123456.6712-5-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240501123456.6712-1-johan+linaro@kernel.org>
References: <20240501123456.6712-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Random module versions serves no purpose, what matters is the kernel
version.

Drop the bogus module version which has never been updated.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 drivers/bluetooth/btqca.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 2ba1f21f0320..8980e31e5094 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -13,8 +13,6 @@
 
 #include "btqca.h"
 
-#define VERSION "0.1"
-
 int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version *ver,
 			 enum qca_btsoc_type soc_type)
 {
@@ -941,6 +939,5 @@ EXPORT_SYMBOL_GPL(qca_set_bdaddr);
 
 
 MODULE_AUTHOR("Ben Young Tae Kim <ytkim@qca.qualcomm.com>");
-MODULE_DESCRIPTION("Bluetooth support for Qualcomm Atheros family ver " VERSION);
-MODULE_VERSION(VERSION);
+MODULE_DESCRIPTION("Bluetooth support for Qualcomm Atheros family");
 MODULE_LICENSE("GPL");
-- 
2.43.2

