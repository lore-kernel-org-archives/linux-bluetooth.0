Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D7E7D07D
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 03:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736998653; cv=none; b=MPXvGxxW7trJl94M9o7Uio1/5B1jQsJAx3R6ULUktLdiE9HxcVL50k+PbEDOqQANkrIly1BThlhqnGhVLutLUj6JWz0uWKeKj1w7Z+bVQrOwwEEGcUlsDBUbQOkoBaGEcbxVc8xpcdTjVL+wBaVcoS/oUvIH2jkP2WvmSEbyEVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736998653; c=relaxed/simple;
	bh=KHWZN5ZFDg94FDuZuryDmRIpzCiUai3FggZl5hIskus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKUxS4WH79eLzAEGZ+Fg7To8lVWL7ABMVF5BAh6FjJaUBwcziX1NnMvQmGh9i2Dn7DkESz2jy8KXKHQCPINn/7TahzIgexXczKleema7ydx17KtirQcvp2B/KR17Xon5XD9olKDtakV2XAxzxO002iBo+Buq8MkgHieOjGlr27I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=clBHlL5z; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="clBHlL5z"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21654fdd5daso6747525ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jan 2025 19:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736998651; x=1737603451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kG+kMfLfgCnFcb2MQxw7I0LDYokEdblnCGk75vkECw=;
        b=clBHlL5zSCK4OfNV9WeCqGsj/ATxQRH+t7uKtMbb9W3WR0xLxBrgT/djC/xjanyAzw
         zVFh9ClJlG7cAOmH0pFbi6WYdS9aaS0upElm4gz/GRW+2ZOGDdZR7urMyxPPsde6pQJX
         DSrA2rWCL1J6LYkHdsa91L9wA6YwqVRIzbpkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736998651; x=1737603451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kG+kMfLfgCnFcb2MQxw7I0LDYokEdblnCGk75vkECw=;
        b=Qp/jnY8gwRHHmvX8nlxsoomjDM0zEcoeEGkHFc8KcjfpwvdGeN+TiV+996PzK/Itbv
         dLwso9zvM/ZTILbDWAk4RWy1jfytP4CAOJlCJlp8UJ0ESWsEKkAY3ItpN5yH4UEzRBhP
         iYH/WnpUY6AAW0deocVZ8hjFGW3bJw/XtzLxYgI+wYvOPaEKjYp5h1VUzZ/yn3aZPmr0
         xsiGaP2avbIxlraOiWIqZ5wVW7Eyyx1dV+TeV1FSvlv8fAWWQbkIie8LMZQzX6xZ4Rqq
         ewPV5ZifPC4gfzGnRul6UeaCfl03GarChs6RDMYZGgWcxq//Vq1qHJCsUBAQpWnhcE3n
         XI9g==
X-Forwarded-Encrypted: i=1; AJvYcCW7ibTCDVIg2Xzcz+9sI4lLuu7tEVr4J9crbue7Mt68z2ysm6sIOMiEZ8oO0qwj0xHEJkZp25fXSyV12IOU5Po=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXCjloRhkXRpbLN8z6BKQkcRWHiYVFXTmwj6V78ZVivKgaF61C
	Vz0heCfpWxYcwqqKTTMsRdbsH8PFYkxZrQf8QAeGL5RYgU2kxh8jtfVh/X9dPA==
X-Gm-Gg: ASbGncsCfoRI9psWAae2e9nkfuqL29Ao2gn/NJ6R9auE9m3vG9qdiE2C0c1Hdwk+VFG
	3+9T4QCRo2tcVRTctuiQzDYiY6eBxFxd25JeWuyVr0CB29CdCVBZHv9tEgVZrekvP5NjIXIwtyL
	VyRRIdJo4gCXnYHJ18zzRPaoZ6TcUih4PW/UueuQLESSYcQJpepZp+YXWmZ7+lVi2tz/wjt69E4
	ipE8e47N68Xzja2fXXzIrnDI10ciAf9vK70zkOErQ1LdD12PGn7I5aS1erBlMPD3KMjUUjfb7aP
X-Google-Smtp-Source: AGHT+IFmA5Gr4C+Te1MHWaygBwDL2sH6qF905UycWpwXiB4qOSlE+Mwnqw3EiqVpy4SvZI3CVgEcIg==
X-Received: by 2002:a17:902:d4d2:b0:215:9642:4d6d with SMTP id d9443c01a7336-21a83f55157mr459471665ad.17.1736998651180;
        Wed, 15 Jan 2025 19:37:31 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:534a:ac09:3752:7758])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f2339dasm87714485ad.177.2025.01.15.19.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 19:37:30 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Douglas Anderson <dianders@chromium.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH 2/2] Bluetooth: btusb: mediatek: Add err code to btusb claim iso printout
Date: Wed, 15 Jan 2025 19:36:37 -0800
Message-ID: <20250115193636.2.I5b800519fe573164417bbd14674bb811222826cd@changeid>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
In-Reply-To: <20250115193636.1.If8b655b5c6877bd9a1136ba0f1cd61cc6a4b6e9c@changeid>
References: <20250115193636.1.If8b655b5c6877bd9a1136ba0f1cd61cc6a4b6e9c@changeid>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the error code to the message "Failed to claim iso
interface". That allows us to know which error case
usb_driver_claim_interface() hit.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f69df515d668..df8889e8759b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2649,7 +2649,7 @@ static void btusb_mtk_claim_iso_intf(struct btusb_data *data)
 	device_unlock(&btmtk_data->isopkt_intf->dev);
 	if (err < 0) {
 		btmtk_data->isopkt_intf = NULL;
-		bt_dev_err(data->hdev, "Failed to claim iso interface");
+		bt_dev_err(data->hdev, "Failed to claim iso interface: %d", err);
 		return;
 	}
 
-- 
2.48.0.rc2.279.g1de40edade-goog

