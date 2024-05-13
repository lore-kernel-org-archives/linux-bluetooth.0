Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7336B1AACA;
	Mon, 13 May 2024 16:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715619589; cv=none; b=pRpape/D4q8Z9hBwiUc8f7LEMK4SUNWTD4LqgLz1jgSMV1+Rz5QTfMzinFRu/Kz9DHRyciv0l5284VClRw7HPRL3zLHJFYqND+yj2uo/nxybRVpN8znKBS+t9TKInvDAylNGw39RI569WAFadTq32ja0FiBDncVIQ6lHk97cHQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715619589; c=relaxed/simple;
	bh=ysyb2Jplk/f3vs0r/foaa32f7i2ZNfg5vNPzrga2Uh0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zn/46n4nwiS+4B525VtzKUtEyTD2zqd+QElzyGLNgh2C8mblBAd08GEnp3krkVImKBNDT2DoGqacaYWo0L0obwA6v2sQGCUq7DZGUJLFG9aDDRiiOncTE9QTSrcxL4thKCmWTCKs4VyXOPxTzvgQobfTsIYwKaU93IrYHxGY+Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1s6YRA-009a4I-MK;
	Mon, 13 May 2024 16:22:04 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Scott Ehlert <ehlert@battelle.org>,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] Bluetooth: btsdio: Do not bind to non-removable CYW4373
Date: Mon, 13 May 2024 09:22:00 -0700
Message-Id: <20240513162200.2658571-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Scott Ehlert <ehlert@battelle.org>

CYW4373 devices soldered onto the PCB (non-removable),
use a UART connection for Bluetooth and the advertised btsdio
support as an SDIO function should be ignored.

Signed-off-by: Scott Ehlert <ehlert@battelle.org>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/bluetooth/btsdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index f19d31ee37ea..bc9631bddc40 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -298,6 +298,7 @@ static int btsdio_probe(struct sdio_func *func,
 		case SDIO_DEVICE_ID_BROADCOM_4345:
 		case SDIO_DEVICE_ID_BROADCOM_43455:
 		case SDIO_DEVICE_ID_BROADCOM_4356:
+		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
 			return -ENODEV;
 		}
 	}
-- 
2.25.1

