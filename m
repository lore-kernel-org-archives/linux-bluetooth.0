Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31A2432BC9
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 12:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784117798; cv=none; b=h8LLwml3DAU+gDJZC7HyLIh/wL/WV7dzZDPLoyDnpTBQywRjEMCDG+V6taq8Ipvj/tqWshjG1b2WBYKGf5FG9wJ4IInXZEoxH20f+wSV7HdCQ2xZCnojW4RTX+eQpGnAQf+QrTbg6faLMS1jC0TUsmz1BXfpETNfjBz83IrfZ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784117798; c=relaxed/simple;
	bh=Cfq5vJYMPMZEyYH8csDFncwJC2tCF6VnIfqVZToCwMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Up57heFVPBR7Z0bpglB3UOCjI7I3631Rwo357UQFlA8QHTkOebGtsbxxdMfLOIYVhF273zE4PGvQJc2NJnXFdaWLD4Ditr/GX00Q1UqZ+Xzq1/oLEE/dD8kvFxvQnb6EulebEnH/AKgK6uCoGqhJLjjxt9AY8RMymljyJ3E88+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d74KycAt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d74KycAt"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so4950719b3a.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jul 2026 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784117795; x=1784722595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5EjMm3Pe1hURXTuERE7/aHfs67oTRO5cGbYvCX8GSks=;
        b=d74KycAtduoGP5TsO34jrT3fE05gL6dspNjIOn9Ybc2SNiHB07/IzZtcmfaL07NiBW
         9FeBLpjVXt4+/CWo+K4vbdLwQoXp8DJDKIaUP0ZoudbI6Fhpv1ziWMD6FnOXhu1IX9g4
         nOE2EqN/2oZfEQDOS/y4YyW9Ex82aX8kAM0RyNsvN044TJ7c2zgaH2Tq76vBM9JYGxw7
         5SsHPQGPSjSg5hnSQCzh8J3PPRo8MEyqQWaF/ZZhWVlPU4K5QDimIfUhAVzcB/ssqWOz
         /8c5Q+arYS3jtYgoBHEbAPvFwNI1U5Mne3ibxUnxKvhJiYaWKBXjkgffhSSKsVLyQ2tB
         +S5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784117795; x=1784722595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5EjMm3Pe1hURXTuERE7/aHfs67oTRO5cGbYvCX8GSks=;
        b=SDcPGlGNFWSHY7KJoCaC+YwCY7zgoIzoUZHYwZyJaGlXPrqTxOysuo5S0MrDjkOpuO
         X7+k9le1SLEjbfufgug64LMeiI4jDJLebIIp5koHTj+2EHX1TXjv9iGb5jPNrr6OesXG
         jkhH7rhHzl04Sg4+alr7hWN/azIV3rnyFeTJNHcHKUErDRxAVphdFQCvUEiYU4CVIjjx
         +N3CekxB2sc+Y9wrG6nK9oCPswrHj6gFsYMVicIorvD9lEKx3hU/j9X3tbK5Bld9fEsS
         RCZo2Q0d7gF8xuXo03sphEzeV4TgEEEFL3VLdrQUeiBdn9bdrJHjcrAzfKkRkR6Ly6br
         GJjQ==
X-Gm-Message-State: AOJu0Yx9R9Q9CSrJjKrtpOeMHrPWy3yKlBE0AOJtkVZwzfB54ReYaIqx
	RELPNwH89ww9Vbt3/7J0o9XYarBVXX8SHYvtEse3wOIiyl9D9N+kDTRY
X-Gm-Gg: AfdE7ck3KVC1sfEKoaCW7RfYcUd+bRk2VFwkuwPLzkA1QUDoRxOVbXv1jUiRyhDlWaJ
	N8Uf/kGxa+808nOaGIIVvAtCDPKh5NV3Wd5rSFyOdFPkdiHoYiwOpg4W+c2WPJlJvQBqQFRBxwR
	EIL9HhtQjiu+BPiC0b6K/tF/CXNnJ3oc+88JsarfPC64BfE0pb5Mge7+Z6PUT0Js8RMhhGCLsrb
	JQVESzR8v0/PzEvVGEBMw/xNsEbdPARCyOXydDDYyztfXQVS/hNQtlicHVCqudxT0cFn3kKRaWc
	C2BVJ4n4f+d41+Vnud9vhH9jPTHQNHZxqW04s8XbGnkHs4KmCSJ5gTzkoWuDcCuICkXrAq3lQQv
	Ko8jhmZ0Per0P9zQ/Fk5TAxncJe1oli0H2UcqaH3qOi48yImPYm+iFY7LXGXVE9fPK5tejwmKDP
	spi3+zXN33IDU0w5hv4AfZOs9q0/PLqSZigOvhiT5XtgET4IP7BMw+T/Szkakr0W9NbYzXfLuDo
	dOQsA==
X-Received: by 2002:a05:6a00:1bc8:b0:848:57f3:8f8f with SMTP id d2e1a72fcca58-84a5162db64mr6653300b3a.51.1784117794637;
        Wed, 15 Jul 2026 05:16:34 -0700 (PDT)
Received: from nugod-NUC15CRHU5.tail9f095a.ts.net ([218.237.104.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f238901sm3126766b3a.12.2026.07.15.05.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 05:16:34 -0700 (PDT)
From: HyeongJun An <sammiee5311@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	HyeongJun An <sammiee5311@gmail.com>
Subject: [PATCH] Bluetooth: virtio_bt: avoid OOB read of build info string in virtbt_setup_zephyr()
Date: Wed, 15 Jul 2026 21:16:28 +0900
Message-ID: <20260715121628.1590321-1-sammiee5311@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

virtbt_setup_zephyr() sends the Zephyr vendor command 0xfc08 (Read Build
Information) and passes the response to bt_dev_info() and hci_set_fw_info()
as a "%s" string starting at skb->data + 1, without checking the length:

  bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
  hci_set_fw_info(hdev, "%s", skb->data + 1);

A backend that returns a one-byte response (status only) leaves
skb->data + 1 past the end of the received data, and the %s walk reads
adjacent slab memory until it meets a NUL. The same happens when the
payload is not NUL-terminated within skb->len. The out-of-bounds bytes
end up in the kernel log and the firmware-info debugfs file.

Print the build-information string with a bounded "%.*s" limited to
skb->len - 1 instead. This keeps the string readable for well-behaved
backends while never reading past the received data, and does not fail
setup, so a backend returning a short or unterminated response keeps
working.

This mirrors commit dd068ef04412 ("Bluetooth: bpa10x: avoid OOB read of
revision string in bpa10x_setup()"), which fixed the identical pattern;
the virtio backend is likewise treated as untrusted for the receive path.

Fixes: afd2daa26c7a ("Bluetooth: Add support for virtio transport driver")
Signed-off-by: HyeongJun An <sammiee5311@gmail.com>
Assisted-by: Claude:claude-opus-4-8
---
 drivers/bluetooth/virtio_bt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 140ab55c9fc5..c20d54088c8c 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -120,9 +120,13 @@ static int virtbt_setup_zephyr(struct hci_dev *hdev)
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
-	bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
+	/* Bounded print: the backend controls skb->len. */
+	if (skb->len > 1) {
+		int len = skb->len - 1;
 
-	hci_set_fw_info(hdev, "%s", skb->data + 1);
+		bt_dev_info(hdev, "%.*s", len, (char *)(skb->data + 1));
+		hci_set_fw_info(hdev, "%.*s", len, skb->data + 1);
+	}
 
 	kfree_skb(skb);
 	return 0;
-- 
2.43.0

