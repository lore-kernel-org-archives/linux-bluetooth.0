Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C71B3925
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 11:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786794999; cv=none; b=Kj0BRlaM7/CskfYviG/JnuYz/QNoj3yogPRxPw1GVuc0DDEW+BHCItEz+CivTQod8V9ST7yxNFpwzttJWF1nEmKYxX02MFrOqraLzLtIImNquFQSijnw+1qLf/RKfVGYdyAxexKYZAs6FydNkB/SHmT+mR6g1xAp/g+jaFwBfP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786794999; c=relaxed/simple;
	bh=tQfvFLCKRClSk/cNNgEhvXo9/CAf/6rf+siUuBAI1vo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SheT3LcTEL1Vdygjffl0HJCt0lsgzMPqdckumpgZUCTPUQLc2fJ6o7Wrxdy4VOqytIOo61vvPOosznnkwqm2yqprHt0dv8A+vG0V3tFi4Q+XwGCvIQ5gCoECeXGM6Yda+PPjmmHaRtWC3gIxDNCUqbEVp3TjNsEdkCLeSdCVLgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7P1Y8qz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7P1Y8qz"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-480033bdcf4so1099017f8f.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2026 04:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786794997; x=1787399797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GXrlacljC9jA0dJpbVEtwiza65imm1+twTjzq4FOwK8=;
        b=E7P1Y8qzt5HwwalA9UFagrUiBtLWkv/jkUmRXSsfq4/xpQky2KJ3qqRuWp8stDFNaZ
         btI78TTzJSj3TF6AL+/LEupCtP3KfW7ueHgvwGObeQVWKEe6k7zsnczngljBz4zcIdmp
         2guaUnAzK6IOumSZxWopiAgDZWLQf+ULcWiUYMRDyCfE0L/J+AEAgX3ve3a38o+vmUuP
         Q38S5Hx8NPRy8SggR/wffAeTo1DlecfriM2NrlqTSPNVcmqcDxSoMUNHQskNXIBVeuDb
         eompEwablmJBRG5F92K4IZIAkWULR12rvCCT6dqHcRE0jBgU+WGcH03NaxjEP4wgRbyM
         I6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786794997; x=1787399797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GXrlacljC9jA0dJpbVEtwiza65imm1+twTjzq4FOwK8=;
        b=qx3H2X86tU2V5H6zQEhKhL/7Zr1R/HNG1TB3fQU+6NuFFpexDce/unBTG12S6oFMoG
         4wXhsbdb34I5nO0KBI65i1MtWrjHQmwhLr6a4UCE1+SNUOCuNapNP+Zu28trXJFkjNkK
         v9hDTkx7CkPTZm2D4ZvTxwIztyWdoPIjSxPNGEvSIeojp8VrsMVf2i6TNvMizx7XoLAA
         DDN8PHfIs6EG3XuScgyFOtgQRy2nfJ4OPHf2lZu1cupekZhMFrt7HM6zaoLU/FZuFHQv
         G8rANrLjlbHqovjYC1GYCBa1AoRI18KTsm64ifit+d/Sda6+FxwG2jx52UWhtY4ghOcc
         uS1A==
X-Forwarded-Encrypted: i=1; AHgh+RqwH8V0GsOsQ5jE3lD+/z7IdlXOTFV0imFw5wcOwkYKaOI8VwVGqnxnpbmOHl3i81qK/jIGlT9vtryXXfOFL/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6BLXmGyarIJ9+P88dgmq/wxn/yS9oY61bnxpevWIK5+QGxDAP
	+kRUY1PYfv2bM9Tvj5XExA5bx5gjBDJXVtgLYPgoFPJtA1lhq3WVp+an
X-Gm-Gg: AR+sD11Wc83rAo7SSTFdvkk+xzdN8vo8Ah2gIihhDb7GoUuUZVOuedSnR8N/sn4Wmx9
	X9y9fhD3ikF478JyqBMS16TN1/ZAAgz6jTI5NDvr6tNo2xsrzTprJnQsKUPaTokZtScWVvtLHsF
	r2uvx7pCyySz6UCFODaQ+w5ELQPmGoxnJ7SwcKQUPtg9/jSfY71XIIWC39Nzqro20Sjh6qczvpW
	0/S4wzH8s1l4CtXzxSWEdckZVjB7IfKgfEBAw5CAlytZGhPha9oWXflCz5FdqwbbuPeludZzWZ4
	MjNaTsPwqpL14y9QLZmPyRt0Mtbixr5Jj/aoi5t/KRiXZdLr8IyGlKoGK8Gla3Z/EBX7KAoY0od
	0+nnuWY98C3AGG3eDof9YYkpC2pKoKQsfFfY6Dof6JXixzFb8eaAU9P0Jb/mUludFlngOx+LFhx
	PyzAwVkV6LDhJqAiHRcuTlOYUFDvNoeu5wIZjN3Z2Zt5eTpBL52hQOTSWXG83swJ3hsp+O4zto7
	ke7vxjLhVpD
X-Received: by 2002:a05:6000:29cf:b0:481:5f33:c2fc with SMTP id ffacd0b85a97d-4816078c9ffmr13200821f8f.29.1786794996637;
        Sat, 15 Aug 2026 04:56:36 -0700 (PDT)
Received: from archlinux.tailbe3ea7.ts.net ([185.19.153.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c129dsm16085455f8f.26.2026.08.15.04.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 04:56:35 -0700 (PDT)
From: Ismail Tarim <ismailtarim7@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: Jing Cai <jing.cai@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ismail Tarim <ismailtarim7@gmail.com>
Subject: [PATCH v2 0/2] Bluetooth: btmtk: fix subsystem reset error reporting
Date: Sat, 15 Aug 2026 14:56:22 +0300
Message-ID: <20260815115624.8309-1-ismailtarim7@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two bugs in btmtk_usb_subsys_reset() that make it report success to its
caller when the subsystem reset has actually failed.

Patch 1 covers the case where the post-reset chip id reads back as zero:
the function logs "subsys reset fail." and then returns 0.

Patch 2 restores propagation of the MTK_BT_RST_DONE poll timeout, which
has been silently overwritten since commit 3dcb122b3064 ("Bluetooth:
btusb: mediatek: return error for failed reg access") started assigning
err at the chip id read.

Found while investigating an MT7902 [13d3:3579] whose controller stops
responding and never returns to the USB bus. On that device the failing
path can be reached on demand by requesting a coredump, since btmtk asks
for a reset once the dump completes:

  # echo 1 > /sys/class/bluetooth/hci0/device/coredump

The captured firmware coredump shows the controller asserting inside its
ROM rather than in the downloadable blob, which is consistent with the
failure surviving a firmware update:

  <ASSERT> system/rom/transport/tra_usb3.c #764 - BTSYS, id=0x4 idle

Both patches only correct the error reporting; neither changes the
recovery behaviour or makes that controller recoverable. They are a
prerequisite for anything that wants to react to a failed reset, since
today the failure is not visible to the caller.

Compile tested on x86_64 (W=1, no new warnings); checkpatch --strict clean.

Changes in v2:
- 1/2: shorten the subject so the CI gitlint check passes (was 81 > 80).
- 1/2: document how the failing path can be reached on demand.
- No functional change; the diff is identical to v1.

v1: https://lore.kernel.org/linux-bluetooth/20260815110119.11301-1-ismailtarim7@gmail.com/

Ismail Tarim (2):
  Bluetooth: btmtk: Do not report success when subsys reset fails
  Bluetooth: btmtk: Do not discard the subsystem reset timeout

 drivers/bluetooth/btmtk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)


base-commit: 15ef2f78c49d20d53ec7c0f1c9b40b02e089f2d6
-- 
2.55.0

