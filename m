Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16D247ECFB
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 15:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152123; cv=none; b=coZJmhaKL+79e74yUx6CK5+bh5k4kF+uKcHcVOMKq5OkH26NcGZ3f4ooTkqmR//opTZtZAhbY1Tt8xPgAqTE385eDBV3dBVVbKrsI76KbmQBVIEch9lksllBXmc9V1QiPytsanYvi1Hibv1GNtwTSkmQjGShUp/uqiXBVGmz+xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152123; c=relaxed/simple;
	bh=BmDiD1s+oybyVgZXkg8VaJ90UQO6xGYIA+btSrQJmcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mS/46xRLkfG7xWI5e3sZPDjikfzHxT1XCZ94QaJjXw7cSGvQYPPpsIVn8cds9bfSMXpsVCFAiwbdO0c8p4NcZj5L2xILrR0QcaQfXGrRNwYhv+IUr4oheRXWRZbsgmB9MyhYfR3hW66WvtZxsPn4qKp/H0UyN6jRSwS52WyDF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=D+iU2QMg; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="D+iU2QMg"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9e7391839cso961491a12.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 08:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787152118; x=1787756918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T1QNXsKrDhs8IsNcJ4pL+2qJquZRkLocf4zm8nsnwJk=;
        b=D+iU2QMgaXCipNqmcERDuZFZVhtnNw/Q0cGfbT4XKv8eTgH/eqgamPn42JrnAq2AaQ
         zvWiA0AXbq/mou/ddh1RWqeX6BkjJIVytBrBxTdxVYVHbItR/hDzr54ff5XP7JUqItAv
         06zU3icDxWM/86wYn/obYYaLIRfaDQAreii8AKxQnmArJT1HrcViWwzYsZeCfDCjPGB5
         y9ibgY+tjEoMIVDt/wuWMfKBxMbUH4pd6uioyRSnDNDMZcGqh51/KRxFLqK/BRO9YYKt
         7wYGtaFqlntE50FOYuO0clRrhBjGD1E2yyfIJlvA9XJx2LyMjsOVFG5pb9a8ZTUT7W/g
         S3dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152118; x=1787756918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T1QNXsKrDhs8IsNcJ4pL+2qJquZRkLocf4zm8nsnwJk=;
        b=HCg6XZplI2kXOreSm0NJ3AC5cxgangn0m3++GEAiW1nI37eYd3s0CnNVHGqQeosHcm
         PZk6aL4m9plB6R8ccPAk6zXGVThrEKNu5fJbfOSThwRnKJOKooTXBC7MPHprE6w67gnB
         Und6mJYmumbtbJlKeqWwfxI5w7niZaP+lCHme4GVnmdYx3xD09WL5E+h32EqwgijOkq1
         Db1VpZNflseAqvfijaVLPwgZqiywjQLCX2cpSBRP/bEEBm2ujd4nVCtboQ+f16mYJWYn
         sr72zlO51BB6unmjnfPPi14/tIyTlR+Mwt9ZlZaJXnHL04V1eSezwqhYhjDN7FKfCgDp
         Cz7A==
X-Gm-Message-State: AOJu0Yw/lq8UGm73uwu6+gKRA8ABfHB/4iTX+arMSwHidr4obqJz239n
	0+y1/l6jsQA0vcPIymVQDVDvC+fd95T84Gco1EiivwMQDAfyPlF+lFzgyhdP3w/1LLpi4gHk9Cw
	yl9rzVA==
X-Gm-Gg: AR+sD10/jS6TIZgD+vnvEl/B16M3Twr9Ptv6fLLBr96WKx4A6LEtPJGsTjwFXWwJKa+
	xCJ+W4CxLZflpcCST4hEopJ68C8Pk2SLZa2orI23QN4+ZceQXu7ByCyQEDqB4fdX45cq7nnzCrY
	IgBJu/EFNOV3Z3pKcMsZyZZjdYUbcDAIQrruaik57hp3RRinxyaqtux5hZ9dXxOI7L3GRsBWPPB
	+dM9Ope7tMXyzeHyMByDYf40i4e6Wcl9BiLim6srAHOnsTaEy1NagVKVtLr32yRGDaBll/sOZ+g
	Q61LSkkHh7jH8M1iQZg/mDX78ysh92ZgVAmDwipavWtmOik16I12DQYuM2YFXOP5ZUnf2ec0zI0
	jwBdmUXxGz1V8p7DRrOfZiIF/sBrgLyMI8KEN4DTp+Src8dDuWokzaMiG2OBcKwmAKfPKhoQYS3
	l0TdA/ac5R/1QFiAs7aA1gaUBmgOfNxgH4skEEtkhpgGbYMkafRIpAcDIShscqQ0gRbbFyXbxHT
	s+2N995RkE=
X-Received: by 2002:a05:6a20:c706:b0:3c3:935a:af2c with SMTP id adf61e73a8af0-3cd00dc7d05mr10598065637.3.1787152118073;
        Wed, 19 Aug 2026 08:08:38 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc15567543fsm723762a12.18.2026.08.19.08.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:08:36 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	mcchou@chromium.org,
	apusaka@chromium.org,
	mmandlik@google.com,
	alainm@chromium.org,
	vega@nebusec.ai,
	edragain@163.com,
	weir@nebusec.ai
Subject: [PATCH v2 0/1] Bluetooth: msft: fix vendor event use-after-free during open
Date: Wed, 19 Aug 2026 23:08:42 +0800
Message-ID: <cover.1787048594.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yong Wang <edragain@163.com>

Hi Linux maintainers,

This patch fixes a race between `msft_do_open()` and `msft_vendor_evt()`.

Commit 5031ffcc79b8 ("Bluetooth: Keep MSFT ext info throughout a
hci_dev's life cycle") changed the open path to reuse the live
`hdev->msft_data` object across power cycles. As a result,
`msft_do_open()` may replace `msft->evt_prefix` while vendor events are
still being processed during device initialization.

At the same time, `msft_vendor_evt()` reads `hdev->msft_data` and checks
the event prefix before taking `hci_dev_lock()`. This can race with the
open path and lead to a use-after-free on the prefix buffer, and on the
failure path it can also observe stale `msft_data` state.

Fix this by reading the supported feature data into temporary storage
first and only publishing the updated MSFT state while holding
`hci_dev_lock()`. Also make `msft_vendor_evt()` take `hci_dev_lock()`
before inspecting the published MSFT state.

We tested the fix and verified that the crash no longer occurs. We also
verified that the existing MSFT monitor functionality still works.

Thanks,
Yong

Changes in v2:
- Rework the cover letter to present this as a race/UAF fix rather than
  a security issue.
- Trim reproducer details that are not needed for patch review.
- No functional code changes.
v1 Link: https://lore.kernel.org/all/ea4efa51cc3be16d3eb7726fe5486f0be6c47907.1786092373.git.edragain@163.com/

Yong Wang (1):
  Bluetooth: msft: fix vendor event use-after-free during open

 net/bluetooth/msft.c | 70 +++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 27 deletions(-)

-- 
2.53.0
