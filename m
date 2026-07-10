Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD1224B04
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 17:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704311; cv=none; b=azQo/+TR27py7Pa6vu4EXIHY1r87kYujKCUYd3LPCzVBmX2Z2V0LkR9MoftR70SrDckVK+SStcLCA4ZBnTyN/xnZUP9udI21Xdwb8Xgpwsq5rmdG/1chn5EwBvKArnZ2j6LkJaQ4hI3ODrSZl62N6oUFEZKCXabm7CFLZHWZlG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704311; c=relaxed/simple;
	bh=65JrXnG8w3WfFz2sW7/e04u1FduXp2dNUbY8SsZkw48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VO38iYYHSIQM755gipb87MNW4v2mYpmGyeStk6TpPkDLTxP8Gg8h9VegZKRX6gvMUx1Rr8OpzfCsQMtmP1REpyx5JiqJafffibheJmRZvsEqBjnHpbZZWdkICzaB3xPf8hdejsZeOocxpTd0ACeW7d6+yfk1V/uf48XKxqiAMQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayr0b8jJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayr0b8jJ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc80b585bfso8502365ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jul 2026 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783704310; x=1784309110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=icxOE2DFF2D1zfrc2ISsm6d2uJsR1A14htLOcSkm9H8=;
        b=ayr0b8jJFpJdlNWn1DP+FXAU+ai8JGneluaJEq4IgzMr4Ylfm/mK3KSSyfkwBhjALP
         tVcNGgDKGDeah8DIraZnqwiF/fGGWF4x8cFobzIgdfYiVj2u9+9/nN39q97YnO2JhRb/
         YOE7C+v0XxUGx0sdF3qzqLFqBW5oZyojJuFUJ4newORr3q5h3Tx74QM5yCPrWYDE+Stg
         e0OSddrUlUxhqhFRo0D00l4O3sVe2nvIzVdASEtsTl3OlJGskeyo7izT+8lmFa2q/BkZ
         HW0OcVCLQI2l+zM0cXhC3OMAU2eykgwuRfSUwFKFhJmPYieNglO2RbhqdEkFfg9zD3JF
         MccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783704310; x=1784309110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=icxOE2DFF2D1zfrc2ISsm6d2uJsR1A14htLOcSkm9H8=;
        b=lHWudHoF92dIbrpr1uapC6ZtMrDdUWLLRKtUEtCMN06Q1zvOIOMuQAkhuTIOgnTqMe
         pLBcYSLnaKkLJu67cHHhvT5apdOV5boN8cIJyERGUZsEvYsbX8iGfnKtuaTwEEFBvwsP
         x6sQ70rBIuhWJVbh4La8VSlYJi2CVG0h0jUp0qRaoRLU0i9FuVpGdsMqyfFBoIugXfPO
         2CHvf+jiSLsmgzBda3aKqBIPmu7crWoi5GriRP7oCK0C+vy8zKnH1w8zmKJHobKS5V0h
         GcrAMUU5LCPQVn7D8NiJ48LlULDIkab3r2QxMqEo9W5aRQu3XUMHueQROtce7F33mjZK
         46+g==
X-Forwarded-Encrypted: i=1; AHgh+RrLePkQniRLWLF0pkoLG331bF0BgkzOq1d0+3AzuvQ4Z3QJ7cJGhQdFMPUgfil5iGCFDPiPPzv5Ik9CxYyBf6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgF+EayX2vFFVNNUgGMe6RjhHWMqXylJrBu/Fqw7ZRKsc+TBPP
	6fgUJelVgCtN6T2gNMlZnAKJJG9LT0jg3xySb4y/U666jvX5Tw5ilyZ8pjUykQhD
X-Gm-Gg: AfdE7ckd9a8PWwDFwFj540ovbH8eQamYHi36GtPszp25m95AYiKzxNeIXUgk49I4hOE
	VNteh0mIEP5YZmR4UZ2pRsW/VYXt/NrkGYRIsGBT7gDs8CPij8gnH+obe6W4EoS0JBDRetIkWZ7
	t0Ep4/6utEU2arq0w4wFieEmTvUmMgSKLFsIikCoKYdBAUn5dEw9AhAn05hb+k7MNzsIVVeXs0G
	zFttIhDNvLMPLOB9W3qIewj5PJisfLkEuML2qC3IKwORbBKbEsW/FuaGk+0g/H2KMiYlYRbRRcP
	9nAhQ7b3w8CkRftn1tzXtXnII5BdTV0aSTlSg9kLtgQWQTLTw3s5vbgRQXYDJ+LBvIthfNPsC+O
	WQ5g2W2pXhJPTU8bWGskwn/+yKzH8eJOnXwAvck8JTwUYPkK3YS638m91YfOXeY6jK+NLoi1JlQ
	UnFtOk8XhYgiP/FoJR2sHkB0WbRb4A99CRKDpyhAyXr4LPJoKKKzXbn+SYke/78g==
X-Received: by 2002:a05:6a20:914b:b0:3bf:735d:7fb8 with SMTP id adf61e73a8af0-3c0bcec9fc8mr14760591637.27.1783704309572;
        Fri, 10 Jul 2026 10:25:09 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:5177:3103:5737:1752:bd47])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31189cd8234sm32885135eec.9.2026.07.10.10.25.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Jul 2026 10:25:09 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btrtl: validate firmware patch bounds
Date: Fri, 10 Jul 2026 23:10:03 +0545
Message-ID: <20260710172503.64964-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtlbt_parse_firmware() copies patch_length - 4 bytes before appending the
firmware version. A malformed firmware patch shorter than the version field
can make this subtraction underflow and turn the copy into an oversized
read and write during Bluetooth setup.

The existing patch_offset + patch_length check can also wrap on 32-bit
architectures. Validate the patch length and range without arithmetic
overflow before allocating or copying the patch.

Fixes: db33c77dddc2 ("Bluetooth: btrtl: Create separate module for Realtek BT driver")
Cc: stable@vger.kernel.org
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/bluetooth/btrtl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 49ecb18fea45..7f54d2d2d13a 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -797,8 +797,9 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 	}
 
 	BT_DBG("length=%x offset=%x index %d", patch_length, patch_offset, i);
-	min_size = patch_offset + patch_length;
-	if (btrtl_dev->fw_len < min_size)
+	if (patch_length < sizeof(epatch_info->fw_version) ||
+	    patch_offset > btrtl_dev->fw_len ||
+	    patch_length > btrtl_dev->fw_len - patch_offset)
 		return -EINVAL;
 
 	/* Copy the firmware into a new buffer and write the version at
-- 
2.51.2

