Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72F490BE0
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 17:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786727728; cv=none; b=jHKM/TZGOkSgKTGZq/37NSSV7gRZBt19XTc4hHnma5go6wjDQ19nnonaxg41YYOcgdPeB4EggL0S1kn4kRuSWMcAypEn/qhew2+fd3whgv4fYpLxaHOzk/fc1bXPzaKKgAVJJGCo/Y88XlidBIOGcOy86g82AlvVaRDW4qgW3yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786727728; c=relaxed/simple;
	bh=PdwSVh1m2noCaYpQ4pBbEWTeQEFQNhww10+UT/Lh9+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CmxrQvvpypXkw9q0Z3XdmgcQaVWFIXrOrXfB7sryLt4XSwRTQxYr22Jj6X5asKx8yp+KP44rE85TonZFdkKDdQLIKJA173GoUZLPVC5b+mgPAdzaIx1W9yg90Sh3LwNPHJatVXaaOAnbi3yGg0zt1bhMFqLy1AyS/VB3GNB+kkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxTiifO8; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxTiifO8"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d049069377so14253775ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786727725; x=1787332525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ixYtoj+XjtvI8L7Upds4AZfaN4qSfYVwO3/g8PBQNAw=;
        b=hxTiifO8altvhNW3y7yhRU0tmQdon0FS5/AKHiQciU74u9zDKV2R9vbjpJmaJrv+yb
         mKUmjG1hLxbwblhXoOoavHf9moxrr/yffDqfZqFDj/2h91BCGpgPxZ3S17Y4gcDVtW4n
         VamO3sEsR9ZWrfedgaiCqpNuXDUvs5XEWJP8iIe7uGMQs2gPyv2vilsanjZWUwq5y8rb
         xIVx9S/U4QCwZB69CknBR5SADFV4R/PEeDbaAD9+ICotLe4GuYRfqiE03NdxNB5esgeQ
         0jULKXsf8AOESsHyK+Opth5aoYys1nqVKXO8XGs+PgJXaNI9ew24+F4KOrjjRzJ70KF8
         ob/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786727725; x=1787332525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ixYtoj+XjtvI8L7Upds4AZfaN4qSfYVwO3/g8PBQNAw=;
        b=EqQXJIxfPiIyzTsnDtQzCAJu5WpozrITdLmPuWGBGIrNvBOvK0xrveJaPAQinRtPQT
         4a0XVGIUD/sccd5cqSPB1EqxPmVsMQAomxiQzP9lcq5QAbUrEdCN+4ptqm1YyTqmxCsY
         OBg3YBGrZtjLHgDouA9z2msKez3/+5CWZjAB91SILH1iW377wr9UgWUQvoPEwHlMkq0N
         mq+G5hA+1AYdyMH2Y4XfX6HpwdJeDyb5njmtgsrC9iET9uedhFas/XCZ1z/kgWfzp/Kp
         zU5ye04FxRVGxk3TAS+ETeMvBb+wbh+Zvn1Fx4sZHrG0RqjU12RJiAouS7OYrSUV+mPU
         V+nA==
X-Gm-Message-State: AOJu0YyZyQbqJyG7cgI9r6s+cV5Hxa+rRD+iIo4u+eUuza38jQ/TPD0j
	R01G+iKXsgUvPPSrYYn7g6fGWuhQL9mRueg2thd3ATMYW+MxhBiDwrrgDisWqpUj
X-Gm-Gg: AR+sD12hfQRVVwj8vcKlWenA0IlmAL1At2NI4k+YVIVWlq0ArYXT0TXEv053uJ3y+NU
	Ln13SeKg9MzUWXShjQpUaid375xyxHbjnEGYx9ueUcxPYKntGJukkvUD7FngRW7tCOvENgl2zUh
	Zs3Orv8DqTjF+MwQ4lA+ThF34D57eqSqW91t260SQ3yZlPMiVhguZG5vet2kFkwXoNUdFNSRXag
	MP/xmUSN4niNLQYjFdUmZtcP5AMoX6LKD3uUfkGJmsYQeJiuEXIQt4/wyyeLF7b15s1FoLEsQvz
	ikfatPZ1rAj1pBzKIC3sNzFGdw48EQIhzuwcSwZe5mQRGUdmsUWfIUqZAaD1ntksY5hbMxoNFn7
	vqJNe1OjbEpLqx8mW7iy0d1q7uwIlLNZrurltY0H3kvdtDzChrU/cY0qSArkpo89Hl3A6JDl5tJ
	wJjsuSYl5CRe0rHRUQTgw8eCeudiMnD4ys6ADZtBYInIxxZ4crIno0z9xiHux1mLxiq67qI6vKe
	wN6G3+Xc3a1xpjasvxKnCn/S6Ho0VVrERbKErt7SYu8e3DSMXAXSW9LtbLk2NkXPPiZbJWSUf3E
	VHsaZTSu2B/ufoXoswB6NNQ4Kqps6MvfbLwiIPCvVCIcyC82A/dlFz6DB5dpOZWjFSQJ8+Yk7k6
	jDV4HM6V8aqa1jEFA/CP3jy33Fz/dvj+LedmFzmr2PjOXIibL
X-Received: by 2002:a17:903:1850:b0:2ca:f21a:a6c5 with SMTP id d9443c01a7336-2d3b0aeeb01mr94809315ad.1.1786727725569;
        Fri, 14 Aug 2026 10:15:25 -0700 (PDT)
Received: from localhost.localdomain ([101.251.7.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea2f787fsm6182234eec.20.2026.08.14.10.15.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Aug 2026 10:15:24 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	ali@iusegentoo.com,
	raghuram.hegde@intel.com,
	kiraank@gmail.com,
	kiran.k@intel.com,
	ravishankar.srivatsa@intel.com,
	amit.k.bag@intel.com
Subject: [PATCH v2 3/3] Bluetooth: btintel: propagate version TLV parsing errors
Date: Fri, 14 Aug 2026 23:00:03 +0545
Message-ID: <20260814171503.42684-4-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260814171503.42684-1-acharyalaxman8848@gmail.com>
References: <20260814171503.42684-1-acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btintel_read_version_tlv() ignores the parser return value, so setup
continues with partially initialized version data after a malformed TLV
causes parsing to stop.

Return the parser error to the caller so an invalid response fails setup
instead of being treated as successful. Keep this behavioral change
separate from the bounds checks so it can be reverted independently if
an existing controller sends malformed data.

Assisted-by: Codex:gpt-5 sparse
Signed-off-by: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
---
 drivers/bluetooth/btintel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index c204e9a1cd0f..934775e449db 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -720,6 +720,7 @@ static int btintel_read_version_tlv(struct hci_dev *hdev,
 {
 	struct sk_buff *skb;
 	const u8 param[1] = { 0xFF };
+	int err;
 
 	if (!version)
 		return -EINVAL;
@@ -738,10 +739,10 @@ static int btintel_read_version_tlv(struct hci_dev *hdev,
 		return -EIO;
 	}
 
-	btintel_parse_version_tlv(hdev, version, skb);
+	err = btintel_parse_version_tlv(hdev, version, skb);
 
 	kfree_skb(skb);
-	return 0;
+	return err;
 }
 
 /* ------- REGMAP IBT SUPPORT ------- */
-- 
2.51.2

