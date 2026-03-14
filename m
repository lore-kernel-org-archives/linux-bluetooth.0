Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910E4270575
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Mar 2026 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773509013; cv=none; b=RaIk6W8v8sKoMlnOPi/NbYyyMVR1U+sojkfy+MQ0XTDeQJ/AG7vf3SgRPjDnRopyZDrICgTOcCdYFpsKbr1O79fY5GTFpzYTeeFINEuv8C5F0nWizYfcRiLSyjJ4+xPTOcdqh2NNij5gFdXq9+gn+APyWoM1Jv+4hAwsyKqWVCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773509013; c=relaxed/simple;
	bh=E0BUSPyjgvb1LseqcpTygrrSN2Z3lVaqAZT7C4kGJ4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J4Wzx/Dsor/BtaCcwEiqLB/bKY407McTXVal2BhT+JPZ+rwptkhSGwoUsdJNpHABAXKBvK5mQRANR/Pr5lwuo+763GnT6/jI15BXZqG6niwpKBJuF/qRYXuJ/56M4Dx/0H16rX38naeRnBaRggOQQfwIzloL70S7xLrX9Uk3OCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YL807FJt; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YL807FJt"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82748257f5fso2473217b3a.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Mar 2026 10:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773509012; x=1774113812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Mtq4YyuwAPG+UVpZn2Qzh0Sv/d17ajCZRJYRYNkeEU=;
        b=YL807FJtTnPnL6afnSMcX5FmJlcZqSGK0yTRt6QZX0Wo2jzhbwicUontGqd0WoQNQh
         MJUfPBiPfQeUyKRAe8mRi3XRdtQAr2QoDHXmxLOkhiB5p326ROuU3EcWWKSvaqemsRRT
         XCv0bGTGub1/DkoV32sB/Bj+YKHtlfGdMiUXIDMM47YVoPiSOeUfpaZvkV+tbusreh5m
         VoCQ+LhyNaopprxCflqHL9/QcdqZHooGhCyZ9zdb2QiH1Y98DpcJ0iiZ92bOwNM41PK9
         texyjFix95q7dK41LOeG6vi+kAy7DYP0/7YbVTJ0UiDR5Oc+UOr4uSVaB6nif00pT4ga
         fnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773509012; x=1774113812;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Mtq4YyuwAPG+UVpZn2Qzh0Sv/d17ajCZRJYRYNkeEU=;
        b=j/taewgDUn8Yk20Nu8vozZtwtq4Sw394XVKIXCuW2wNUVj6LWa70cYWr5XLQaOhffH
         x9RKfrnvjvGoVBte2Db+CjuFYL07utZyNvCmrKCQ105yZdPWTXsWk8ohE20gBPnBlGYi
         cB0FeRCdqb8vuz8HRFY56/4R+L27yekz71q1JxRFOXy8vo58XQ4JIlRVP2vRvHNq6aby
         ntvUH9kRVTLszq/ZMnwNZiy/3DvvQPHPNqkOurOHgdR43LxuynhBFgAeCiFGX6t+Je3U
         wetxfpxK5l3qDUfd1t/7pOv0C4KDefle2KNWozOUauyzs4bnzuwoxKKqbuwFIdZVVPBj
         nKug==
X-Gm-Message-State: AOJu0Yz9BbPdFKMTp7DOO5+ZCxSIm/qr9WOE4xTIZZxV+IV5kJ5LOF3t
	e8nzHZt6I+na8c4jMHWDWEdiQQJz1bl5i8WeiJjZyiSkxAlC4fkab/v7onXf3IH8UWI=
X-Gm-Gg: ATEYQzy2pexmA00c3MwV7n68lOS+r9noOFnW5AKA1xaM6GRKXg0Y59s79DXnZlpJZOW
	ulmxNAz+ON130BuA35BijqJzV1Cbl06ph80LRsJp/s5RpXxkJWnEmQnka+ayiNAb72tFECGduzw
	+ycL/qcMF9x4FHxPLSH8nSCyxsYwMr/c06wtU8MfFyD2451eK1Oja2GTaDA30oH98n1RJj1Bnvy
	IzuKCOtWv6J8y0RQHXoNKZSDJzGYJRoLyst0B9//VHpafPE91E0V6ILN5LAsEvs9kvspFjBfOgu
	QiprSz44V4Y1/azqn1j4dlF8KXZjke+81t5HUggaJ0FKZQ4Lffw0lK8DVbGI+eH6mQ/dbxZVtUI
	g1DQ90OEhlQqlMCzKF88t+rkIsyuDbTJOFTxvzH629IZi552GAMAIlkKkbAVbUjcthHNPXFQdGX
	hA1T6zpmQ5mKIIuzOWkCcoxzABMq1xrt65Av8=
X-Received: by 2002:a05:6a20:4322:b0:398:7262:d6ae with SMTP id adf61e73a8af0-398d78a59fcmr10573961637.25.1773509011631;
        Sat, 14 Mar 2026 10:23:31 -0700 (PDT)
Received: from ubuntu.. ([152.58.152.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c73ebb6336bsm5466035a12.21.2026.03.14.10.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:23:31 -0700 (PDT)
From: Anas Iqbal <mohd.abd.6602@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Anas Iqbal <mohd.abd.6602@gmail.com>
Subject: [PATCH] Bluetooth: hci_ll: Fix firmware leak on error path
Date: Sat, 14 Mar 2026 16:56:39 +0000
Message-ID: <20260314165639.180559-1-mohd.abd.6602@gmail.com>
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
firmware has no data or size, the function returns immediately without
releasing the firmware, resulting in a resource leak.

Add a release_firmware() call before returning when request_firmware()
succeeds but the firmware contents are invalid.

Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>
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

