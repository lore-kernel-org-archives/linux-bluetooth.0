Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565B4325490
	for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779029721; cv=none; b=PWWmo24UF9QLf7K4HIRlGvwompYu0wH4995qpLkAFVHew1aVA3xjiJ+aNPEUOz2NnLYStzXFKxi5tvKeMLRUj4Cau5MG5Nl2TBx6pOBx98Cf+yYiGQB5cIrNP04TvmhSsiVCauq+xKzDihdbHEivhFxdOc+A8/kb8VQ3g81I6k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779029721; c=relaxed/simple;
	bh=i5BLItaK7oOYPrFOtKeP2AkbysLIvxhDNelq+76nRF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pn+0O3uoXES3wrS0G2LJuXPYCni+8lcgUP0JHeSQaFZq7wZ+3e3n45/F240/+qjYjsWh2dIbYJn9IFAYd2ahCwz9E9An0em9rqtE39nIa/Wu6yITQeuf0C6FuWOTcnpJtIYRslteVnUOgANNCry/Dmdgf4P/a4KTBlACrZi3Vj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6cISo2p; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6cISo2p"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d7645adbdso794080f8f.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 May 2026 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779029719; x=1779634519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/l4dCK28Qtpju1OTSn9skmQqRPcoauwVCiaFA7ILGc=;
        b=X6cISo2pQ4YeGP/UrHyE5bt0efVaZfNSN0nAoEtFWPv/hqIzCkqfQKwTX2h6541PLF
         T4d9PuDBo0Ke55yFxVcF0o3K2Dd7NCRnGZP5h2KyRSLHPsTDmxrnpArjWT6s3aQ+fQwR
         uZEW283QuK6In4qDPAThr3SKwz2y1JW2m3ZJ9FhJTGvRRIAzUK3mkwxDyJ+b+Wohnre8
         v7J+3KT38uAzXJEiXCDqVodT0V1VxsMPQhO41/CD0QRkw5ViOfaYCDkIBPgWsGhegl7N
         +zdC7r0BxaLXcR7uXWcm5dQLEJHikmBYysKth98vLbcei0Niob32kuG3ASxrV1uA2G3o
         j9eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779029719; x=1779634519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z/l4dCK28Qtpju1OTSn9skmQqRPcoauwVCiaFA7ILGc=;
        b=shHBIsbXb+6W8Qgtqmrx+tAGXD51AiNl4Ji4MxOBk665uM8Ewcl366c/oQ4rOFcFZp
         zitikapD//ocUcXFaMQ0+EpqmMbHXj13Sr7oSECJq0vuykYemZq4S7vLS5KEzWi/hZ2G
         ghe1kf71gYDhIp2Tp9gvSMlTCdRU/ttsRGaT7gVy+SYxjl2qbCesxswi5yFzQ/7eIXAY
         +KDKOo/Jvl2PdKeum5JQLNYJ5k0Z2AwxzRKuvpbptoaqjlCytRjO+wW9ygQA3Wo+Cm8j
         o7C86hjxloXfVKC7khNtoZH8WRzm4cyjX3nidAMsBiusU5CHrVKG1v1Q6Wta1li1mjt+
         iQwQ==
X-Gm-Message-State: AOJu0Yw7N6sVEAJqaNrFfgzT10WwLAgs2tYK2rv7/+qYWwgk41TpyJ+s
	hLiDubnEdSdR52poAFSR7jOwbdp1DxhH3eD113AGfntmjTgetXtWjJ4PZlVXh7qwEIlJQyhb
X-Gm-Gg: Acq92OFpgqfGPlbyBBSqqFaKiBtSraNbSZWlldUe2HqmicLVRUo4IvOkUWbCbHo2d5k
	zTNtZoJ+Qrw+czJDmCVElndSA+AuEaNORgI6Y4GFmpQae1QR/69F93gyl7pJuOrqTjFb4ps0emw
	5wz4jtZj61/oy8fX6xG6xfCi7TxlQFGxpNxc0mQbCO1R9czuUxHFhQdwP3Dy3FSQZ1D0u0sWF3g
	WUZ186CYnilX3yKWdSZ1YSwdU60bAO7ZVbuXi+87y4YdKfhP8BsbWHBpfIkkkDN4BZ4x8QB35mA
	h1yhYMU9bbSYcNGppXb073TJcrlX2X18nVk59fq9vnKFI6Lt0UMxVUk1LU/XBytmWCeS/oCXvOa
	h2ZHDxnG5xaFxuyZcorbddWHJTdYPxSxwz8yrzdKX9yrqHwt5s5CQRwnRg8dbhWojRXF54xzlEt
	zpQ8n6DwTJS4S7kCP/vctPy8Ktans+E2d6QoEKSIj79fWSklXKJiZ2j2nvC/ZOsPU4ZWyNrVwoR
	A==
X-Received: by 2002:a05:600c:8901:b0:487:1108:48b8 with SMTP id 5b1f17b1804b1-48fe60e367fmr150620875e9.2.1779029718624;
        Sun, 17 May 2026 07:55:18 -0700 (PDT)
Received: from node ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fead1c364sm62260885e9.8.2026.05.17.07.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:55:18 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@gmail.com,
	stable@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>
Subject: [PATCH] Bluetooth: SMP: add missing skb len check in smp_cmd_keypress_notify
Date: Sun, 17 May 2026 10:54:17 -0400
Message-ID: <20260517145417.31910-1-meatuni001@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

smp_cmd_keypress_notify() accesses the received payload as
struct smp_cmd_keypress_notify without verifying that skb->len
contains enough data.

smp_sig_channel() removes the opcode byte before dispatching to
command handlers, so a SMP_CMD_KEYPRESS_NOTIFY packet without a
payload leaves skb->len equal to zero on entry to the handler,
causing a 1-byte out-of-bounds read from the heap.

Add a length check before accessing the payload and return
SMP_INVALID_PARAMS when the packet is too short, matching the
pattern used by other SMP command handlers.

Fixes: 1408bb6efb04 ("Bluetooth: Add dummy handler for LE SC keypress notification")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/bluetooth/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 98f1da4f5..4c98e2a3a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2932,6 +2932,9 @@ static int smp_cmd_keypress_notify(struct l2cap_conn *conn,
 {
 	struct smp_cmd_keypress_notify *kp = (void *) skb->data;
 
+	if (skb->len < sizeof(*kp))
+		return SMP_INVALID_PARAMS;
+
 	bt_dev_dbg(conn->hcon->hdev, "value 0x%02x", kp->value);
 
 	return 0;
-- 
2.54.0

