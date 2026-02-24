Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A3379999
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931572; cv=none; b=V7Ekl50BoEdYkE5OatmQO1yFLLiqaK262omSYz30jA45dTn8JX39CYJwksQZldizP4veyPO4JeiZp55noFvZEkKdqGSki+5jXCEot3vQA2oiLU2K1pOL22eddiUIFOrwpBev+iufNhiNzPOD0qu7q7W/7TNJAW/vR6CNH7Yjt7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931572; c=relaxed/simple;
	bh=RwxN2MfipCgR418UuZSsP8mrLaJ4ASbiNxzJJ42mQLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nyqVkFu5+nLpHZPk+GznRWs5hN/XVTc1Axh4ze7yoTjYrxb5cDumXrwND12j5SQkTM7DXf3ZbJYwOb98VzfXm8l6cXKQ/rNuI7v0CXTG2KjCv3sEjTVj7Nvxzqzm5lH0df7sM6D8+8VuTeq3gBYqli6RR6mVCaY7bxK5vEjRxQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY21f4t/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY21f4t/"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48069a48629so55180455e9.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 03:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771931570; x=1772536370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OODqbL4ANJzyaR6iRPGqbWeycFnxpu3cwsIO8Dd0p9M=;
        b=DY21f4t/XSqvviLtbWbY1RyJU3smd9LY+DnzeFbh2uqZgOocs797hSAV8ZDuvqDtHd
         ZXByWYbtPCWbAEOZ1K2Ub+s20AElPBOX+A7RELxun35O4Dgszyj1J0Qf/vqbpcsFKZzU
         ARaQe8GaVTiGSUnvDaqzkpsJg81Z8FQML1gLq38f2LkQKLD7rO0paJLEebrjW/yHzOB9
         VkgPHAxApYlykfYRAHGfLso4REG5qxODZer8x44Qku7WYmfVBfCkgINTtNTuEwnSJ3k/
         vb2dQVuLJw1mwaVlrubziUiRSU6ZzMRAb7huqq9Kp1W53M4ZMCRZ6NTqJRCRs5Ipmc/0
         7TcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771931570; x=1772536370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OODqbL4ANJzyaR6iRPGqbWeycFnxpu3cwsIO8Dd0p9M=;
        b=GjHAHhYf64pymxmpt3Dx+9/1JzRBhUAatkApsGPys1NrV1/2549K53+9JXSXW+8qoa
         aa2m28jxZm2KPlxYJiPJHetd7J1IhOJbc2NDN+oA7tstC4Sd14TEHb16u37kBMYZVnns
         altZ/kzozvYRkqIINjDbcM6W3w1lQbPbCSoAEB/KPOJVkmqrYWXeWhz+cc0jLNDzKKdP
         nqCg6eal4cet9sSsdFVZdmPKLBMFRRA50fKazX9FNzwyfgn5D21499QxppcasbozQMYn
         GlOtHP5puLLKr8FvXaJ8W0qKgD3EhiXuyJ+VYYjmY/n609wG+1FU40GUf9DRxEaWXRJd
         ZEFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDeha/y8HveCBjhNpS9HbliYT3SmTm7mikZ6dCIBa2cuJ+9BtMqwADBDQS3fUQkmYn5RD9qf0YFh31BF6DcPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhGW23GRWxzZq8aVzCq3SZQ6sSccmnEqB35H8HEy069tvcZbxN
	n7ZyqmChCliKAqJ/NQq6Khzcbvfs4rEuGM49K+NDPjJVKsx98uA2eJOi
X-Gm-Gg: AZuq6aKZ+rHmAJt42L5LbgkOqVCBIb85BIoqhpbLMaa6c7hjja7fCBARcRBcogZVPIW
	bkFtX7hjj4sFuf5zPx3yeaiM2ca5+/FMR7GkJPEh/w4rGqq4F5ite0Cmij5bsGosiq/1R6FFsPV
	4BrgGsAZ4zdf4+UG8kCSALFZHmSnw3XaWVLnv4n5DU4aFaQQFPFgFMgCeT7aDezM5AIflTiYYDt
	DGKreO5ALKIvWW4yG5z8HzhEHpOCckUm6Rcf4fQHGa3rjVwQ9V7UGledkNb0V4s4XHm0bNOqaJA
	kyXqCESeibzxVDZqc80QEP1pvOYsRJY+nvld2qr7cxwRGZOrucuylnEnBF9SZbSMWlqsgEf6yA+
	Bz6kE9VvIRKJS2+xBk9ln0p3laVop6OM9gyqoX4TnD9vB5VAM7Byot0pjx/Czqj7MdxHI7gLoqi
	ne9ra/6Yhxh3gwKFkcnxqCYvFY0wFyFH7EwJwz8uFhcHK5Q6HahgeBqg6/jg1r5Iie3Db9nt5Ki
	fCQLCrj2U4nt7v/ZvK/NhmW5VKsN2NKtupXB1Zi
X-Received: by 2002:a05:600c:674f:b0:483:6ff1:18b with SMTP id 5b1f17b1804b1-483a9555bafmr199583055e9.0.1771931569673;
        Tue, 24 Feb 2026 03:12:49 -0800 (PST)
Received: from Lord-Beerus.station (net-188-152-100-94.cust.vodafonedsl.it. [188.152.100.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a9cb4bb3sm259474545e9.14.2026.02.24.03.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 03:12:49 -0800 (PST)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v2 0/1] Bluetooth: hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x
Date: Tue, 24 Feb 2026 12:12:34 +0100
Message-ID: <cover.1771930508.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While validating SCO audio on a platform using TI WL183x Bluetooth
modules with the hci_ll driver, we observed failures when the
HCI Enhanced Setup Synchronous Connection command was used.

Although the controller advertises support for the command, SCO setup
fails in certain configurations (e.g. BT_VOICE_TRANSPARENT/mSBC).
This matches the scenario described in commit 05abad857277
("Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk").

Initially, we considered setting the
HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk unconditionally in
hci_ll. However, this would affect all TI controllers handled by the
driver, including configurations where the enhanced setup command
works correctly.

To avoid hardcoding the quirk globally, we first proposed a DT-based
solution. Based on review feedback, the quirk is now enabled
automatically for the affected devices by deducing it from the
compatible string instead.

The issue has been observed on WL1831, WL1835 and WL1837 modules,
therefore the quirk is enabled for:
- "ti,wl1831-st"
- "ti,wl1835-st"
- "ti,wl1837-st"

This keeps the change limited to the affected WL183x family and avoids
impacting other TI controllers handled by hci_ll.

v1->v2:
 - Remove DT property, used compatible instead

v1:
Link: https://patchwork.kernel.org/project/bluetooth/patch/db4c7eab9d0c2f71eb61baff240957596f099401.1771847350.git.stefano.r@variscite.com/

Stefano Radaelli (1):
  Bluetooth: hci_ll: Enable BROKEN_ENHANCED_SETUP_SYNC_CONN for WL183x

 drivers/bluetooth/hci_ll.c | 10 ++++++++++
 1 file changed, 10 insertions(+)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.47.3

