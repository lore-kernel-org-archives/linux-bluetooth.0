Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AE023BCF7
	for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780245053; cv=none; b=c9vm6dpNxz7k/z5AFeEJxKdAprpCjZs5A0Aa/3ZiSbcYX5KIAFPtBCFZb+EW13LOMxU1mkGGw3IQyICmtIMRIqscVuBYo8hGc4lfN6PJNddTFZ8oSaO0hCvpJ/pm6DUwZUYRhkQxgeEtVYnWAPIoSPPcy2xXX3SywHI67ZMqayg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780245053; c=relaxed/simple;
	bh=BKpWdDBH0q5XbXkYHQvTzJ4xU8ZGMPGgjKqByfrlbrg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dXbCQMzmE6E99Ak/tEnj5WMfy9CAJFD2qBsXG/3U7YhJxPUaB2NPyDfoGCv4P4b3zLRLqItcHc8WjVsYnLWv/oYaxYVQAJbSGsKro8mnUEPbDauYxbQltfGS0ZRUFaV70ezlzGNnwNLGJLYxdeXnOA2Nwz52zwgj2VQw7qYHaaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/VU8ZE0; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/VU8ZE0"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c0c35980fdso6242285ad.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 31 May 2026 09:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780245052; x=1780849852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NqmLYNcIEslqSqBVNAmUXjHek2/MRlTehLfPs1lYa3A=;
        b=O/VU8ZE0Cz/y1w2aPJYud8ssKZANWzo8+QMwC3MLeyjipMt7Lp9Gzgs0MgbwGOObpD
         VIx1uL/bwh6Y9fKFa0pnHn7SGMauC38HlMKYCiEBHtmYOumqhg5xZgcfqU85AkmX9kXu
         G6R7PBDNFIFLAZLHAwi4S3BXmLvI/OHCLxEP5rEI5ttdW5UU0a3dzodyQPMQCIeztwYu
         Em3QjcTlB0g8mSzvbazBbhuLFZVA6vpqdoRS4Tuanjm9k37XnGHX6R1Fi7BSLChSWO7L
         oW+8ju96MObPJFPZPq3mTCF9rAvkE2makTeoegh1yD56cDReT5NYht1bCJtHGfIq3IVh
         VC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780245052; x=1780849852;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqmLYNcIEslqSqBVNAmUXjHek2/MRlTehLfPs1lYa3A=;
        b=eDWzHPy1+9wf14M4zfD4hnuJgF0YNAmkcXv7HKxiZLbpghtILkCFLPb5BjVlVPbqC1
         Bn1n3Cpwbg0jPbTRIjIjF/Piq5KbjGeUsb4fo++6/i8Ew5a6pcbAUEYu0lK7iRouZSll
         ta6jYw9skHkn/uQPaESr1CfN56XdKllgloh9q5KLhgkNbkEGXm4mdmCd1jzD5Ha+3OzQ
         XWRQKxyeoq6HayXxrpbREeDRkI7nJhfSwjfZ0lfoZ6Z+n/DWlcd70MUuA0gyyQSHDHV0
         BwYZPdFcnWYfmJx3OE47TBmuBt7i5TEwmBfMeqkFLBti/4jtl7Wha39LI4Q3JIyxlDg6
         26sQ==
X-Gm-Message-State: AOJu0YymgfdGnvLOZnBpiijSH1YfzCu/2cMXf0rjvEpBYwnUDD4r/Gjd
	++FfUlpZvw8gmYWZpN7kYfp7ZQrHWmwBJLTceSJbbIxrHy9ynN2szRucMISWiwY83hk=
X-Gm-Gg: Acq92OG2POqVCA+Y34ggNd9EddAYViO1BZJCvQvS/XD25A6JOHMRQX9mkXGpVZaFVwb
	udOAp9Ba/JSsarThjx1LztMBjKsd8pd400ocuT+k1S3s+CLuqQCLc/zB8W1229OLwUgcO+PY3SU
	i/Kh8tiztjXsLq1v2uPkjbFvWoot4Zj4RulheT8ytuiNfpnPHBKp07xrn6QnvgR/FMXEGc2XFjt
	UYwhIIXJwcaIlQARrAKARWs+o5pQ/djqHZDscz3RZNCACCPUihQ3LcvO+72rbXbeST8SteTGNyF
	HpQF1oBgyZpeJI2qR2TdfjUaOhjjb5NXfSgvlD88/eKtbNr3kprtMlh11bkepKed1m8oyOkn+Rk
	wPueCEuSB8igAGABkJOB3Hv37q5m0AP2wV4M7wegUlZ/aWKEno+ifHnm/huoeP+nqFghxb5FMZa
	K5u9ZhRFgHxem6TYJJLBR8YNXkshOhw5uTRctY72YAijSA7Iu5MHB0lTnlXLM8CKgh9/iM8L9xc
	CFHB+faHKQGCQM8FbyXE39KIf3nsQ==
X-Received: by 2002:a17:903:2f05:b0:2bd:c925:3a16 with SMTP id d9443c01a7336-2bf367b1670mr88163165ad.2.1780245051500;
        Sun, 31 May 2026 09:30:51 -0700 (PDT)
Received: from rustle-HP-Pavilion-Laptop-14-dv2xxx.. ([49.205.241.70])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c43f0asm110782775ad.77.2026.05.31.09.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 09:30:50 -0700 (PDT)
From: Bharath Reddy <kbreddy.rpbc@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bharath Reddy <kbreddy.rpbc@gmail.com>,
	syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com
Subject: [PATCH v2] Bluetooth: fix memory leak in error path of hci_alloc_dev()
Date: Sun, 31 May 2026 22:00:32 +0530
Message-Id: <20260531163032.102728-1-kbreddy.rpbc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Early failures in Bluetooth HCI UART configuration leak SRCU percpu
memory.

When device initialization fails before hci_register_dev() completes,
the HCI_UNREGISTER flag is never set. As a result, when the device
reference count reaches zero, bt_host_release() evaluates this flag as
false and falls back to a direct kfree(hdev).

Because hci_release_dev() is bypassed, the SRCU struct initialized
early in hci_alloc_dev() is never cleaned up, resulting in a leak of
percpu memory.

Fix the leak by explicitly calling cleanup_srcu_struct() in the
fallback (unregistered) branch of bt_host_release() before freeing
the device.

Reported-by: syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com
Tested-by: syzbot+535ecc844591e50588a5@syzkaller.appspotmail.com
Signed-off-by: Bharath Reddy <kbreddy.rpbc@gmail.com>
---
 net/bluetooth/hci_sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 041ce9adc378..74131f2c3be6 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -85,8 +85,10 @@ static void bt_host_release(struct device *dev)
 
 	if (hci_dev_test_flag(hdev, HCI_UNREGISTER))
 		hci_release_dev(hdev);
-	else
+	else {
+		cleanup_srcu_struct(&hdev->srcu);
 		kfree(hdev);
+	}
 	module_put(THIS_MODULE);
 }
 
-- 
2.34.1

