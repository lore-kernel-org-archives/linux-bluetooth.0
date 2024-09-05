Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676E116F831;
	Thu,  5 Sep 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=108.161.129.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725561169; cv=none; b=KxeO79xpArwNtGJaNOK8tzD9gJbcIp48QSQbqZJzIdx/P2gUcg/PN1HU7n+tjLkX8yivf+OpnYvc+8KAnIDzzHW8qXfR6e1fIm491TzRVL2CvwcDxe1BwSSSXakXztX19rip4tKSGCT3zuvFRz7k+GfnNCpoFxwczZElrNgdqys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725561169; c=relaxed/simple;
	bh=xQA4CPG7n7H6uJZUderckdAz0EXW5IkWeUjkPgckOdY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cmPKyn5T0LsGuvMvURVTdDds27/53+kJOQQ+L8O5UPQV4U0/GCoK4of1kmIJxC/v1YORbR/w3bFQDo89szaxOwokXQqL2i6FOnF/xh1SAyQw8Vzdf68uGwLY5DGNfRJx60Bm9BQ4uv+zzIxVHbQOlBMTbTXE9XTK+rhxl1YweUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; arc=none smtp.client-ip=108.161.129.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: from syn-068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
	by finn.localdomain with esmtp (Exim 4.95)
	(envelope-from <tharvey@gateworks.com>)
	id 1smGn0-00C9I5-4Z;
	Thu, 05 Sep 2024 18:01:02 +0000
From: Tim Harvey <tharvey@gateworks.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Scott Ehlert <ehlert@battelle.org>,
	Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v2] Bluetooth: btsdio: Do not bind to non-removable CYW4373
Date: Thu,  5 Sep 2024 11:01:00 -0700
Message-Id: <20240905180100.507975-1-tharvey@gateworks.com>
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
v2: no changes; resending due to being dropped for unrelated CI failure
---
 drivers/bluetooth/btsdio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index fdcfe9c50313..a69feb08486a 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -295,6 +295,7 @@ static int btsdio_probe(struct sdio_func *func,
 		case SDIO_DEVICE_ID_BROADCOM_4345:
 		case SDIO_DEVICE_ID_BROADCOM_43455:
 		case SDIO_DEVICE_ID_BROADCOM_4356:
+		case SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373:
 			return -ENODEV;
 		}
 	}
-- 
2.25.1

