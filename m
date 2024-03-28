Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328A6446A1
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656963; cv=none; b=HcrbCgDpcPPH3SRNaHlJQuoFW4lCJimFn0JfQasoP6DrdxJrinETmIRV2TLIB0HLRALEDnpezhQV74mHM7qhvg/iTdmhY/6MQw/l3jkEujvn4j2bifg+335CKNK1bn4+ZGWl/M7goOyxuxQJZgTZBpYT0E0Gdb7XTTkFXEUdP8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656963; c=relaxed/simple;
	bh=swDVcEBKfJWM3Jc+KkgsyDt85Jdwu1FH8GjNjNVN2nI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5XyMO24yDl4N4fmaFAzUG3NRyifpgrmXAQOkAimR4egrQxCNnjG6vbsmyo8HXFiOAddIM1S4b1HrW3c8bo0gVQWeB5B3CRZnT234l7qCVgFsLGcKhuz+8cFDe6hm3ey3FI+8NrkT3KVBNRjmybxGmkSLq4MXHBswweZnugv0AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fb999hFc; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb999hFc"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcd9e34430cso1474988276.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 13:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711656960; x=1712261760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jGas7RiDNbFXYQR8O8WcPt0FvlzO6IlJ18cxDs+H1CM=;
        b=Fb999hFcfxkHzm7WWKwDETKF7NNDtDuOy7PtRYs+dlMIVEUC83fSKfDt5DUFAKwkRy
         eFPWDc1AjArRbTXGt+sPR4JQlMFOGbwisw/289U7YNpwGOGy0amWy5BGtCQnBFMXXJMl
         E/uwHP+pGgJhZltiQb7yOnU2VTqZc3naJaV5hGjIH2TKXozGOiC984+ZNTwRUYwaX4cO
         0N1dqVhyr7eBNpiZjzg8chyVK86SuuM129EFT3HfYN2m1/O5VCSThGcunhrygBPgyhM0
         Q8O/gwMndCgj8wYLtIFMhpvWMz4wiLJBXKBDQpcK6W5JV9fwbs0AdAitHq8Dn6Myca5e
         aTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711656960; x=1712261760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jGas7RiDNbFXYQR8O8WcPt0FvlzO6IlJ18cxDs+H1CM=;
        b=jD3kPn6gtTdNxrVMLXhF2p5bjuRlhl/WmTDghYsRS3Vr+5m8CaiWMLQdNK1YzRerIV
         IqJKQnFtsR6XkfbkDrn1lMdLf70jh2zGLlmdtBMcXngUf42hyqUpiSE8Gl7d7t1KnIws
         WoSqO4+IVQY2Aryo6pU3rc5KoK11g4SD8l4Li3brVqVMc0bDWUmiwRvGxmw4zOktCJLv
         Qv4Jowzg0+ck9Iojz3JZEA2LyU+AH82BiI88NiECajJP5cwmOQZHxihWFHKN7EIdjHKx
         RveGwJ9LT2/G5CxxL21PqYPWYWxarEpNSt1kemR2JPV5h5ug84d9miLqgsZPAyWf6cAg
         FFzQ==
X-Gm-Message-State: AOJu0Ywj6f1bQuOIT2acaY3uMmzR9/2f1asms/f8OtVHBILHPymPF45D
	VXC7BtcrON1Xx377doSTgY8j1hSApW8D5Pk/hZScn/HpJznS+e9Cs3SM13+U
X-Google-Smtp-Source: AGHT+IHasdW3Ze5P1yZqC5K7IguLgeHQmIVilMn3NtvkB0Ze0s1D4iXXf8DzO5JBueblzDVDFH9MxQ==
X-Received: by 2002:a25:71d6:0:b0:dd9:1cf2:e3d3 with SMTP id m205-20020a2571d6000000b00dd91cf2e3d3mr351301ybc.59.1711656960040;
        Thu, 28 Mar 2024 13:16:00 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id v10-20020a2583ca000000b00dcc620f4139sm453750ybm.14.2024.03.28.13.15.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:15:58 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 2/2] Bluetooth: hci_sync: Fix using the same interval and window for Coded PHY
Date: Thu, 28 Mar 2024 16:15:54 -0400
Message-ID: <20240328201554.1791904-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328201554.1791904-1-luiz.dentz@gmail.com>
References: <20240328201554.1791904-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Coded PHY recommended intervals are 3 time bigger than the 1M PHY so
this aligns with that by multiplying by 3 the values given to 1M PHY
since the code already used recommended values for that.

Fixes: 288c90224eec ("Bluetooth: Enable all supported LE PHY by default")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 8fe02921adf1..c5d8799046cc 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2814,8 +2814,8 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 				if (qos->bcast.in.phy & BT_ISO_PHY_CODED) {
 					cp->scanning_phys |= LE_SCAN_PHY_CODED;
 					hci_le_scan_phy_params(phy, type,
-							       interval,
-							       window);
+							       interval * 3,
+							       window * 3);
 					num_phy++;
 					phy++;
 				}
@@ -2835,7 +2835,7 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 
 	if (scan_coded(hdev)) {
 		cp->scanning_phys |= LE_SCAN_PHY_CODED;
-		hci_le_scan_phy_params(phy, type, interval, window);
+		hci_le_scan_phy_params(phy, type, interval * 3, window * 3);
 		num_phy++;
 		phy++;
 	}
-- 
2.44.0

