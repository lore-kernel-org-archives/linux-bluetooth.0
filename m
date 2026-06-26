Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8483E5599
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 08:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782464122; cv=none; b=Y9NHNdLySSXh1J2VV8cJZc93owYGE+2kodN3M8gRDYv8IcVxLCehTqHm6FMuPXmJ58oSn/iOcwEV8Ac8Ns3pwR4uaqc7ui/1OpXwf+sW7h0PPTTLSkRHND4mpD9EEvrNEWh7KDQoDIKOXfilwdmjrqWSU+sSISCITVRHXtZBNTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782464122; c=relaxed/simple;
	bh=Sv1k2GLnPHQVqcDj/5WdcJdGbcOVWFX0XIVLHb+n3YQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iwk6xL5J3PIgjqcgXs1fJsvPTTr7EWsJQNIekKgSfV6QDIhizco44FtbK2jtBzU9grJzglMP7UpBFipzxoo4C78CV5WKA8GI/zBkpjhgTmbSpqkc105J2cRolYxeZNth5uSiaK2woHEGodapUpfFU4AdC58ws4yAoFnxOIpFFkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mw7AGt1E; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mw7AGt1E"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c7f123b1acso9177465ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 01:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782464119; x=1783068919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H0bENK6HErqfKBzvbZN9XyWCD6ZqRSHH4z7WXCI1P4c=;
        b=Mw7AGt1EEEb3dXYyVTNkN2WFlGSxoWAHEU+OF97doWxamDYRcdZHFTe3J6j1AaLzvU
         cnd++RsRhuWyJLsjxXUnS3RKG+frVjYsqbzqol25EAmmD/3qXt96RzFwj1roLhbdW/Av
         h/enrE2XCdX44QiD/ho58Ihq2DSslLVlW4CQt4akW5lcGWBKqYjqRNXV9/1mxH0HO22P
         7tGCYPNQw1JlsZ6hDGDy/s2tjE1VCBwlxfr9miClP/3oAOqn4qfzyPBZWHy0fyON9cIL
         xCznR657ePgKxS2zj23zaQpjuQYk8JkS3R7dNohRiHMlauoOnuPgXhMrWzvAmwh5pZ+A
         0o4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782464119; x=1783068919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0bENK6HErqfKBzvbZN9XyWCD6ZqRSHH4z7WXCI1P4c=;
        b=JQ8o2Lc57ATMPwzOq3HmVXujcuY5zoQTttucQOZ0+lx9cSEbjfGteLg1rq7ag2G7KP
         R9+A6UASXAAfmCwg2p4mVOrspvmEeZG380nmTGvUezGbTpmFmiZfXsrfLJsFJARCvHAY
         A3Vu++W9zPH1Rr9lOTGRwpItzqOXJG1FHC+1s9yGEXgVethqjmIBAqe0RAzeDAlDdlUQ
         Qa+P+sUM8c024/RVGAkRSSOfjhRN6mwZddCDfIbDYZS2Q52UbRXBWU80SdrsL8nqVJ+X
         CJa7ye/uJbakX/nUNPn1tTP+g18XmazxspRWZS9yDF7blY5lc62zGnBzu071bjD9ZOA8
         kyYQ==
X-Gm-Message-State: AOJu0Yw0yDdzSKSl6//PShxBogTiY0W7f1zamBJVoloHG4VXoNRlrdl8
	04fAAJESvswbK5VUNAWtwPJJ21Kuea6p7b7qMlYq3ghw0r1pran3deY=
X-Gm-Gg: AfdE7ckcQJW+7oPRz8ZLTQooP0t0lDvC9KZLVs/TADQ5p4cOkz8ZX6XNDPlv7qKFEXB
	0NpIolgz7Xt8MH9AbwoJLJHR9WEGPmb6OE85uyvfQLTZqApCMzTQ09XbzTL/LHXUwyIw4zdn6yD
	ToxQcQLtPi//Etj/NGlkjHtBP17T9VBKirqAIvnfvJ5F5qE54iepdn6/pCCfqL5HLA8DkxKmQHY
	1mHV6s+PXdc1wza9bLKRSB8CshWlJ+mc+Mz7/ViNq+T0OQrqx6/T38HmjzLdaiVsfSF8mrZQPIB
	VK5xnb5BNuAtECOZ8BaQhtHwVNBkcrPdzuKRkTa1+f3Qse+lUETWBtXkqoakEocYrRH1gxhdqJ9
	Nv/AqilnrWOUGzh8LcQ/PXb1JU5Wo4keCwS0+j65BiY+OvONJ6AHuIcA3Si/B3vz3h6/BK5K8O3
	Mk8ZkP1iRK5oDMHVs+kyVw4D/T1fupDJDvxKEwW0vt/QwxcYlQcDZOLKyVJhD+Y+g9
X-Received: by 2002:a17:903:3b88:b0:2c6:9d3d:dfbd with SMTP id d9443c01a7336-2c7fc6785b1mr61871445ad.16.1782464119323;
        Fri, 26 Jun 2026 01:55:19 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f63b27e9sm35520725ad.49.2026.06.26.01.55.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 26 Jun 2026 01:55:18 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Neeraj Kale <neeraj.sanjaykale@nxp.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] Bluetooth: btnxpuart: unregister HCI device on probe failure
Date: Fri, 26 Jun 2026 17:55:06 +0900
Message-Id: <20260626085506.37500-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If hci_register_dev() succeeds but ps_setup() fails, nxp_serdev_probe()
jumps to probe_fail and frees the HCI device without first unregistering
it. The remove path unregisters the HCI device before freeing it, and the
probe error path needs the same ordering once registration has succeeded.

Send failures after successful registration through a new label that calls
hci_unregister_dev(), then fall through to the existing reset and free
cleanup. Keep hci_register_dev() failures on the original path because the
device was not registered in that case.

Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/bluetooth/btnxpuart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index e7036a48ce..6778b883ab 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1907,13 +1907,15 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	}
 
 	if (ps_setup(hdev))
-		goto probe_fail;
+		goto unregister_dev;
 
 	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr,
 			   nxp_coredump_notify);
 
 	return 0;
 
+unregister_dev:
+	hci_unregister_dev(hdev);
 probe_fail:
 	reset_control_assert(nxpdev->pdn);
 	hci_free_dev(hdev);
-- 
2.53.0

