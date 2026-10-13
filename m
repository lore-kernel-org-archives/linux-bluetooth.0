Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84143321BD
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 05:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791869533; cv=none; b=vAJx2EM1JRF3V3Py/C498bWfT/Tf1hRsyJ4CzHu6IUR9QcuLegGGwCvjYF/X/zm3O5JTecjxEb83rjsTsKtoK0zx0FTRxlpBYlTqO4oT/ZAeqDGc2sKIE+hTbuBBIzQniy3NsaInBuosXJDnA4Gk6GjwekFz7cpahZopTVpY5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791869533; c=relaxed/simple;
	bh=WgQOnPTi1tnL6fDuSFpQKEm9yu58dR/NyozQFaFmFNM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WA4RQNgwETczTbiXaT8gZpiSqLUzdmAaTbhXudzClTMBXsGA5QkWegePGRW5d6bxVP3Q9wEG7OYRbPymNUxFxdTAI36TFFF13et70LnNsb+WkPNzd5kXnVKTSARmyoTfdPUxA2uXPUodYQ0zjuQ/THD+YYjz3MX7yebqmr96pAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=pIxbmAku; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="pIxbmAku"
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0A4B73F2D6
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 05:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1791869521;
	bh=HdTkQACAxffrwnQrFwY6e5kcuV8v0fcWW79SSqTdU9M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=pIxbmAkuqA+4pOzYDiKGOBgI+vHOEY/eiLWosrnvJskHsJwUr6fYLx2D0W78k+Sdd
	 rgeKl/SY6smaTLnRgkpE5eCNlWiE0HWd/AMg46qwTTzQKL5TGJHL3wXGhqGODgc3aw
	 Hb/II4pPdENKtr3SlEVcMt9yWbbAvObXkab1n/jPSe7nV8m5yN3EoV5ZTqLj7tYgeP
	 DTQJHuW6aRFnZetyxMAvlfth+aILxMwO7nPXiYmreEglhf4ViFJz/oC+D85r/O3eCR
	 DqBp/zDyckOrMIDfbcKlGZXpZbLenIRy9qDoX4F2xXG29pAq3kXlVlZHbf9CZdTsCK
	 F6LqMxQjZcE/CB+XmPXprYrPyBV/VNiUxSVb+l6dbgTDDUfyco3knXdTiA3Gd7Dnxa
	 6lkubTh5S01jmGgucc8y0+NN7iqhMhrx51ig1slm47JNxPBbsgtUqMHZ21l8zxIX/r
	 ED9UnzgE8khCdwfO8wv7BIa0JNv3H0rZR65k2VjfY9bw8Fom8GtkCFWs2bMwx3XZgN
	 L5MPnLsSqn8OnHQMVRlWGRRGhRqWDKzrASBN5ODrYARK6+OyrQ+mAPTss/dT4Ylyvq
	 tWs8juGP6crXaGcx7UuZpjjsWcdjxaEkXVbih/faFZXrzNq/wFOh4YrdePW7vvt3vN
	 TWLFO33DWnBQzXnFEPzUFxb8=
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e876e33e6cso5290185ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 22:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791869519; x=1792474319;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HdTkQACAxffrwnQrFwY6e5kcuV8v0fcWW79SSqTdU9M=;
        b=tfwmiMS6ZvlIK3twryQZNKEvV+cj/AGwnaZnTa1k6lCfDKMxx7PxRSXRuxF3jCAVUS
         SqOvsCdfoYcAKtlh5Q03iw3Z9l5AOVwTB0eupqRTKSRqaVEM2vL3pvzjaIf8oFKEB2jb
         Ks286Lx4PDGd4XAlwx7O0PwbT94VCKQb5lechxKs1wKxJCR703+HDSkYz4bWJoE21WwW
         llvYropz0MXj6rEQWkCMZ5gRbicpUA7p4TZp8xRpvlgVV2v/qhqiFjIHDGXWba9PiNHt
         2roQ0zuiT4YeBPex7D0smZk5RDJ6CXvwVsXLokxn2ThXbldOBsnaeOYHue47X77gW3H0
         mu8w==
X-Gm-Message-State: AFq9FYK97vUiz4FJflfsykgdAl9O/uuS/bTP2zO5Oghqj5EsFTHOfdHE
	gEQXBHVaYuk75NYR4hMFC1zsHnvle6UYwMW/dRfAXX6F+jG+vHA3QyjtZjGXkMKU1lDN4kPNvr1
	szBFUWan3pPofQLQtMQGeHasulu84Q0kmtWJxWq1mvlK/JoLu9WCTuPwBuMxN85gtkViM5z+iIn
	bBHSKvSetbL7L0OjvkQg==
X-Gm-Gg: AYBFou3rIUn2EhFRBHw3uASHcEeCIvYQlU9iOIbeDEK8MAeSGXA2rodgTKtqZkH9YHL
	HODOLxsNBwZKypx00c9NGXdPCUP71pyxcei8RUA4xi0+/DPM8VUazcLUUzTPt9DGeI2W+Pt8K56
	paC41JubqGwTp7SdqYa6d72vtEuodDSHsrYkH/uXS1ApbtuL5+XQvZxgFzp2ZWUCjxtTeD3ous3
	o3A9pB52Dg9OU98QyaD6B9NDo3eYX4xcvua1NHFl5YT/4deJ0NDfkl2Pk/82ljga8qJguRtcIwq
	BJSKmZy+bRr9yCoX5djynORRCfUIaj64rG65M5flmHtPCPJKAANov0g1ZyUqRyIiSIwE/vf9tjw
	D8XTne7Entk95glbVzMehRmNpgFEUXrcGVEjOL9Ih2uHKQFWoaZ/2XTOxB4H8+oB1kUv9TZDuEF
	L/NndRScK+pn4YNWvk2RM5bExoaeVOcnSoYEYyk2E4/zJ8p28tLF+gQa8CrX68twGUfChyt3Ig0
	y3UsdbC9wEPX8z+JeYWWKYVkcXFsg/+r1bEw+rmNGs=
X-Received: by 2002:a17:903:19e8:b0:2df:8909:f719 with SMTP id d9443c01a7336-2e842aa4aaamr159737395ad.3.1791869519251;
        Mon, 12 Oct 2026 22:31:59 -0700 (PDT)
X-Received: by 2002:a17:903:19e8:b0:2df:8909:f719 with SMTP id d9443c01a7336-2e842aa4aaamr159737065ad.3.1791869518908;
        Mon, 12 Oct 2026 22:31:58 -0700 (PDT)
Received: from an-XPS-15-9520.buildd (2001-b011-2008-445c-f0c9-fe5f-a459-fd93.dynamic-ip6.hinet.net. [2001:b011:2008:445c:f0c9:fe5f:a459:fd93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8483c3dfcsm48724735ad.24.2026.10.12.22.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 22:31:58 -0700 (PDT)
From: ChunAn Wu <an.wu@canonical.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Bluetooth: btintel_pcie: guard debug dump before hdev setup
Date: Tue, 13 Oct 2026 13:31:18 +0800
Message-Id: <20261013053118.1201636-1-an.wu@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An MSI-X interrupt can reach the debug-dump helper before
btintel_pcie_setup_hdev() initializes data->hdev. The helper then
passes NULL to hci_get_drvdata() and crashes the interrupt thread.

Return early when hdev is not available. This covers the GP1 and GP0
error paths while leaving interrupt handling unchanged.

Cc: stable@vger.kernel.org
Signed-off-by: ChunAn Wu <an.wu@canonical.com>
---
 drivers/bluetooth/btintel_pcie.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index ac7193400769..8d7927bd75b6 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -297,12 +297,17 @@ static void btintel_pcie_prepare_tx(struct txq *txq, u16 tfd_index,
 
 static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hdev)
 {
-	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
+	struct btintel_pcie_data *data;
 	u16 cr_hia, cr_tia;
 	u32 reg, mbox_reg;
 	struct sk_buff *skb;
 	u8 buf[80];
 
+	if (!hdev)
+		return;
+
+	data = hci_get_drvdata(hdev);
+
 	skb = alloc_skb(1024, GFP_ATOMIC);
 	if (!skb)
 		return;

base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
-- 
2.34.1

