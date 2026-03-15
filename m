Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638421624C5
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 10:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773571529; cv=none; b=pboSWUntJKvAzTknv7y7oCJlXrwgO12zYdzTg2DcpGLiM434qsWgGfl82P3tg/xXb8JYRL+SfFAcoRp/LagDl6Q0lSp5Ua9156jvstRwU4n5zX4hBDaN8U4fQwQrxbImMV5+iIsSfXurtsXUgUqGUlM/kDJcfdh2bkzG2BIYDNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773571529; c=relaxed/simple;
	bh=WrjYdAZ1gpPUidP+ex11mExhhOG06gOKsCA4QYX1FA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c2rkWZtz1of1/19hrmdk8ySW9Uv/KX2fE+ASWaGejAsGQnjgMuL6LX4kuxlc7cocmLLGrnZ2lIy9PeAH/8BrjdpdsO37dEkOMg3wAmQk/oSOTxM8PbNGvP1NeI/dW22mbjwE3tGYachaabeqxF1rzNZ01esobyT3TQT4YuuPeXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOuPHZLx; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOuPHZLx"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-829a568f3ccso1913602b3a.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 15 Mar 2026 03:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773571527; x=1774176327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FlSTVkt2Hr9uFmMrTVFBqTieBRyNKp6QC6tkoO2VILU=;
        b=OOuPHZLxtLPcMuPJH8AMczRvkZU28kzoJgkXKbz1jXFFP6LZ/EM1cTOcjRxwSXxBUE
         fHwfhe6yhzaccLPKbe26YCmgEOH+zDsLujkOPuPNdwwwmW7ArjPPcd8aGMfrOpZuk2uM
         o+jIFM0iqbEIeuc5XcxNOp8Wesvc7FcMQARvCDUp62k/wb0JB4hxe4cphQJDkoe6jNku
         BbmUjSFjjYgwP6W0xffCaZ49RKQkb7rIKU/AsmYRAnzHmUKFopknCzoskqzaC+7BjCrs
         fpX8X3Mh45DgFcxAC2hY8yZm1yHYlrDP44K2Mt5rZO7GQ+77ywn1rkDeJR1EbX3U+P/j
         nRkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773571527; x=1774176327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlSTVkt2Hr9uFmMrTVFBqTieBRyNKp6QC6tkoO2VILU=;
        b=SsmSyTZxgTufPwYeYD0XegNxnyJHrqUPhrlLkE16tWY3/yPLPUIZb/AgJbFYxuQ43O
         e/O6mPsuqEyc6htoRWVGQKXOo9wgwYM2efsJelYwVE4N0epBfPruwSXYBzDCbIJa4ea/
         Yt0Tn8hvvpo0JfDJYFS+eiDyBWNn/+xjP+32QYFaDNHEQ7Z/lrhbuyHfwzBVL5Xn7NN0
         aE/zrh0vkmcjraWZ/oc4QrZoY3IH9ej9W6oxdwrMO2RWxquT/kqbBbo5zIFNndMbtYV0
         IqTO/BkfvAiO5JVnRVrtsHOE+B2k2Tc7CBfxbBfWnKiCjGzSOWCT4t8Zb/VAcEeFfKgP
         PgTg==
X-Gm-Message-State: AOJu0YxA2DRG6ryzYPC4iw7MX6MKb77LIsFM7d5PzXQ7ttYDFOQd10Uf
	ktE0Rv5/PQnwGRGRVS6hjp70x8+a+fSdMJvWkbTb9ziOEW0yAwzBEN6ZtA3zNQf+oME=
X-Gm-Gg: ATEYQzzTDoIqa2VVWc+0Dx4g5pl7lvfmQKOaAtJAnIJKlAHIVx1y4q1ZCaZlAXFIeqM
	3KirdV/e3ojpIhIUmIoKl2yulj6qIK9plivA3JGC5gTyuSW9df4TrM15RskqLk8OHCYFAQ/H0Cp
	j9JwGLKZHk9XVA945ocj9OjFpA3HH8PfllAyVEU60VCBwVmRkbqnwnt/vmXUB3e3c5XTtg0tZcK
	5UB52VPfNgBSfu1YUZxIuWBQrQzj+/yaGazpzvayXP1On/htUIWRzL+lk4KP14djwA70bpePYxX
	ELUqPjpAZSXLn3eYbULnBfKH/KmcEL+3hUdgFEbBppCgtRWEnUuRy9cyCwl7tahUTBZYgI9n6sR
	anxqlxnZS7NdkOY2uGIe8FgSgVlDqBkklvCNmiAznbRzebLxAcZO+Pb/DRNsEROA4OrGDScFG9t
	aK/9yxV8+swXusxcpbdO6JwT2SQvE=
X-Received: by 2002:a05:6a00:4189:b0:827:4bca:f1a2 with SMTP id d2e1a72fcca58-82a19704166mr7796908b3a.10.1773571527291;
        Sun, 15 Mar 2026 03:45:27 -0700 (PDT)
Received: from ubuntu.. ([152.58.129.240])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07241bbesm10483700b3a.10.2026.03.15.03.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 03:45:26 -0700 (PDT)
From: Anas Iqbal <mohd.abd.6602@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	pmenzel@molgen.mpg.de,
	linux-kernel@vger.kernel.org,
	Anas Iqbal <mohd.abd.6602@gmail.com>
Subject: [PATCH] Bluetooth: hci_ll: Fix firmware leak on error path
Date: Sun, 15 Mar 2026 10:45:13 +0000
Message-ID: <20260315104513.1668-1-mohd.abd.6602@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch reports:

drivers/bluetooth/hci_ll.c:587 download_firmware() warn:
'fw' from request_firmware() not released on lines: 544.

In download_firmware(), if request_firmware() succeeds but the returned
firmware content is invalid (no data or zero size), the function returns
without releasing the firmware, resulting in a resource leak.

Fix this by calling release_firmware() before returning when
request_firmware() succeeded but the firmware content is invalid.

Fixes: 371805522f87 ("bluetooth: hci_uart: add LL protocol serdev driver support")
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
---
v2:
 - Fix grammar ("content is")
 - Add Fixes tag
 - Add Reviewed-by tag from Paul Menzel
---
 drivers/bluetooth/hci_ll.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 91acf24f1ef5..91c96ad12342 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -541,6 +541,8 @@ static int download_firmware(struct ll_device *lldev)
 	if (err || !fw->data || !fw->size) {
 		bt_dev_err(lldev->hu.hdev, "request_firmware failed(errno %d) for %s",
 			   err, bts_scr_name);
+		if (!err)
+			release_firmware(fw);
 		return -EINVAL;
 	}
 	ptr = (void *)fw->data;
-- 
2.43.0

