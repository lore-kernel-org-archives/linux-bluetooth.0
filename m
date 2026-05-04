Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAE918A6CF
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777914001; cv=none; b=Yn2wFc4QeV4KNPbrekLSIw8xpo8dARiOPncPY9KNokSD57BGDipI3aQ65fkhBfIsdDoyc1q6ptzYt/H0Bq1XE53DdlTImNYzvIyDKgVXUT4OJGJ7d4K7DrUzCFGEtxHaIsLML4Y7AN5cbN/954y6hXp6mv2fOCNkuAez+wr0Ajk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777914001; c=relaxed/simple;
	bh=enizCQBovmyScyul883qPwWN+b6IC5USDCTS0GHkSgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=atPumSH6rzf3lHV27SnrUJLaaASyZsd/oNmtj82imbcGrJ0JSn9oyWhb+u+50HoiQd8WMiN+fzYQVAfy7u2eKfLb8Or1Ab0n8486bpD0pgAsfQwiQ/ZHw45oTe1x7TmsB1uq0xa5cnVLIMYvtZIaj1WjYdzIu6ZLRQgptPursfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtHW0SSd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtHW0SSd"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48371104ffdso5760475e9.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 May 2026 10:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777913999; x=1778518799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZNVVJaEf59v0tNfZrr/2wUFWhOf+mkPJZCjMA0H4BGM=;
        b=FtHW0SSdwbiED5kHVTdxTnETkgXl4M7pDx6jRMYLg0Y3zFWe3as6YuvzJxT9F/sV9b
         lyuPUSmpdf66D41ocins+vFOBVIAR4fV9xxcIV647Y/kDdGXkyklLfvHG7K7jeYGYg7F
         RIUweZIxJ4QADaZ5DANVFJI8PIRrv3NqbxTkxWDcljGMW3/z7bk2/+U+WyFFaThHYNlA
         tWAT0qVt2yJyuq1+HYoDKTPggsLmK01bagsbgfHlbH81/eBvxJKPCR0zdtZrEqhGrKIW
         JYzu2qXvieXXzqzOHRGkIHW7MpjKOg5CFwJW5A8SScg/a3Wn71bLD4UrYqy6MubrAJTH
         Wg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777913999; x=1778518799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZNVVJaEf59v0tNfZrr/2wUFWhOf+mkPJZCjMA0H4BGM=;
        b=boSw9aIuvRP8oK5KeuMWsCdDMn7exmj17SZfcPvHXE/3yD4jqABGv3lHZ+tFJHTWWL
         jj5JQYxAXH1FBqzJUttAzDAFNnfRtP/Ul+LILc3ueXin4Q9gFzkGtWy8q6A6+P8TgbeE
         kstOYO+K0T1ND9vjLnGTd105fiWKSIXS3ACwVqJKyMwBFGr+48SFGHVltf878Zj8exiL
         ohxnzS7XI/GTf8NUpM8BeYGt4g3Hka2PI18ZuyV20D3nSeSBO/SM+A8bvN/zflfie/YZ
         qB+sf+HCl3jbiKg4dkZT5xZpOXU5THt+Q32gzACvisbabYFC9yrGQ5Ftm8SwxmgnCKCZ
         QYaA==
X-Gm-Message-State: AOJu0YzpYLyuFjMAJVSllUixgp0poJAfiC05euGxjRhF34qF85e1c31N
	Rk+U+l2ci90IXDYkyd6Tx5/nAm7GRf9JqGLOi3Q6QQfvkX3JDWTRyogv
X-Gm-Gg: AeBDiesBiY5J8he6To4bVjtYIrK+xhQBpTYD5Lcok0pJCwdqCE6KxNSYG5I3eSUixJZ
	aENoNvPmbbjgPJttSWRhzefHoGfxE1rTvRgmyzvQYqivW+J1H1vkHITIsFvu1RUb9vKJA+yFM5J
	xmUYfQbfd+zc6hebv9hsNUtQpLb9r/Y8I3RixuqinOIM3v04Mp0NpwXfuXp+jYiP4v/PgZxNQ7d
	YBU4dBfJ9N70WAQRypl1Ge8T/qLfnb867FMTYSiExZiCZs6EkLUDxs44peBGzbZESR6MxjN+1Kx
	bGyiRY+T0bg+3EHn/Lv9cphFktmwAhnA9gr8AHP9jG9LoPAnn4/KJMikwlwL931hwjadpu/aoa4
	7+2fORz1kiRYzYq8TT32U+8yD3qdVLE2T8Bdm0T8npK04t0bU3WIQtJdUXHljOW1KgDJSkE1wwO
	SpxCPyaFOlkipmPypj8/Qt
X-Received: by 2002:a05:600c:3b9b:b0:488:a797:f099 with SMTP id 5b1f17b1804b1-48c6d4553edmr86499675e9.3.1777913998836;
        Mon, 04 May 2026 09:59:58 -0700 (PDT)
Received: from lucas ([2a01:e0a:354:c290:234c:5dad:48b0:9188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fe8sm292936395e9.8.2026.05.04.09.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 09:59:58 -0700 (PDT)
From: Lucas Poupeau <lucasp.linux@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas Poupeau <lucasp.linux@gmail.com>
Subject: [PATCH] Bluetooth: ath3k: add missing blank line after declarations
Date: Mon,  4 May 2026 18:59:56 +0200
Message-ID: <20260504165956.35199-1-lucasp.linux@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a missing blank line after variable declarations in ath3k.c
to comply with the Linux kernel coding style and improve code
readability.

Reported by checkpatch.pl.

Signed-off-by: Lucas Poupeau <lucasp.linux@gmail.com>
---
 drivers/bluetooth/ath3k.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index fc796f1dbda9..0f8260524ca1 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -218,6 +218,7 @@ static int ath3k_load_firmware(struct usb_device *udev,
 	err = usb_control_msg_send(udev, 0, USB_REQ_DFU_DNLOAD, USB_TYPE_VENDOR,
 				   0, 0, firmware->data, FW_HDR_SIZE,
 				   USB_CTRL_SET_TIMEOUT, GFP_KERNEL);
+
 	if (err) {
 		BT_ERR("Can't change to loading configuration err");
 		goto error;
-- 
2.54.0

