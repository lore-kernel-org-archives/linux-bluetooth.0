Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010725;
	b=wIzM5fRqwWZsQkR34XWMZ6+nYASDQcPUDSILqc+l5ldSKOSUagVp69iIzT70iS4Dgwa0
	 HSP9yTFcPNNPAnNTKcIoM6dsUwA7LQKf9SzdKtDOiKV6OgHt+Vk2WksQkdJSEoEiliYrR
	 aG0xxUtKc2fxenTn021qdf+LkEgqgWAFPxWqSgS2fuwPPkqS+5SVudDShcQjg2Zj7vZ+L
	 S/FvmP2aF2n7J3WCeEZn/OHxApCz8qZ2ErIy3h6uOQAobVNWjPgSTIGS0vG9S3X6Bk6rr
	 H5AXhw6ti8U1d788xnr3GnAMrXezM5wQpYRr5Nefm6xgfkoTHLT/QzYVDmYrJLr0DRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HrU8Bh5T1SPlOOXv7Kk39fzwLPRearCIicsjvDtC2VE=;
	b=BINx3Nz/A9pme4tQ6j+gt2lb4wgIy1Id3c8lYjsq3nd3VT/QVUAl+zuhLeb93dj4oV7E
	 /z9e7imV4Gu3DLeTe7raaoMdy5N7rO3QkMEZzNH/yJ8ZfpJ+lP117fJnlJxiYUY+FEM6t
	 I+QJbC3AaF2X7nxhxnVPhSNRp907nkUWDQRmjnEHDOgb5OrLHkCXaYRm3lrp6RhaTDQuR
	 P65wHuTHc8yYlguU1pt+2Sa7q5ybfybHveHcXDwIMCRmOM1eRBMR7SgkCuPHj/XydDbPe
	 Q5fiDEwJYEOSjcuIJ2DR01jJ9hdCEvWX5RLwlDIBBELzoTOxXz56tWgD0NK6k0E2P+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h8sYUXDy;
	arc=none smtp.remote-ip=209.85.217.52
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB4460A261D
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 14:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEB4460A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h8sYUXDy
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-7d2db1b9bf2so306808137.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 06:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795010724; x=1795615524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HrU8Bh5T1SPlOOXv7Kk39fzwLPRearCIicsjvDtC2VE=;
        b=h8sYUXDyYGdCF0v4JXqRlANrOX8ZWhPV2H47HS9aykGD4e8d5hRsMNZf+AAV4yndbR
         IamRY7QTxUzr/fgiSIp3/B6Y0k33eWyDJw56FpPjRGJYo5iMcqGOp5aF0iu1EWSftO2j
         ixxpPqNSrVJ+pu+7qdS7dPIR2x8HUZtvogcboE+81985s+8hnNKStGwRAVR0bZ5UTZfg
         iKnYc1OAoMlS8X3CjFZi8ajf8HXnuD2abBpC+vYWOmuTdFEAh1QraSMEPY5CBOX+7Vlg
         tOMbtj9SnlDQMQD9saxqzTyF7K+GJukfEtUvRuMl271z/rKDpSDSY+SQ9b6f9JZkZjoH
         O4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010724; x=1795615524;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HrU8Bh5T1SPlOOXv7Kk39fzwLPRearCIicsjvDtC2VE=;
        b=T8+qdJq0hv8YpOSy8dRnN84ynqnmQiQdjz7M/dkkmPHUMG37CeJaRzjXUrpaRuroXx
         hNf+n5NtQcqWn0ag+Cl53alUBM4qlp86hVPpRKMmsrryGl9x4ks8gAT/MoblwchC0A1j
         vCsGAHbk8O8fj9b3djbjlBkvj+RJHCbzWbVr5RFAMHnmSBU3576BKbGWic40jYEMjlRK
         rzhvFOTid2QFmm70R8naZMh93S+TEkt1l8sP+1gTF0bO/WZON0JG7CJoBvGfj8PgGY09
         K5IrWgiPwQQQB4oHbFbZ+guaNtX0MOUFcu0/nsGuBrlC1dxbTadyN/nA01Nj//7nOCt3
         +j5Q==
X-Gm-Message-State: APuU4Z9MX4Y/pJfd+D9VFiUkfMn3jEQZdzEjcEXGv31bV5GDCA34lhxg
	LR44iWm3wNFev/lGElwfzUWmBm2uMK48et4T9DG1gJb+O8+i7PVToCVTxA0twN1o
X-Gm-Gg: AYBFou3Dhz1S6XBSjbKI13+rVd9J4jCje8lwW3Q60teARUpa7+8hMH8mzxVycteVM3W
	VbMo5kqUBcJ8lcNie+UJPzI9+5ECIExhJmII+TX0NuX5duXmDiOyR2zwGKxlTeRwk9hJWynX4zz
	4eyTj1DuCh663Ht94bEyORFD7vDfd39rfX/DKFTwec1ZqqVoyraAfsuRDf7jfWR9DoNrTbISzjh
	wrzyhcdVl0f0etypEOwrzSgq5flmRE7pKjkuEeb+BWthISV4XJMoRZR1bNAWA957d0tM2CrazHG
	3qBermBI2bO3xFZ8k7qzuNl2bJ9LVwiFYRqG6y0EXZgt6YrTs5CogNAMfcZ2gSAUgQ4dLgtR8FB
	ZsieOYcWG9VLnf7k3cUXLsDqZTu9pjUctBeoKZ7ujJEvdAMTb1jC8QBSHxOCKh2lFcmcCOrV9Bq
	7/IL7z0qnHpIxNTlWvCGBK+A654u8bJCkzP0+/ojEzH4E6rehUlgN1bj3pFyh4pNdhCWIB2NCls
	NTCOAgx/dYjP0AASXCmTc677VGAq9kPb4DVojQ+gOJ3IpUleMRRlLw8mywM/pVLuMl11tvZ1qWG
	hX5e3UfYdlbmNKrJMo2bBeHMYVmVBE83SFS30PZ3DjqoPAx4JfNPUu5DDn20LNaui1eEs1rjRqs
	CcIOuoY5jWT0zU4LTTodTw6WeACyPFrxN0sn2mrd2h5pqAdn/IZHSCpSITKmk26A1NbKPomtwN/
	IcWL0=
X-Received: by 2002:a05:6102:a4b:b0:7c2:635a:4f4b with SMTP id ada2fe7eead31-7d6ba43fab2mr844417137.29.1795010723567;
        Wed, 18 Nov 2026 06:05:23 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6b914e10esm1697639137.3.2026.11.18.06.05.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 06:05:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 04/17] Bluetooth: hci_sync: Hold hdev->lock in hci_schedule_adv_instance_sync()
Date: Wed, 18 Nov 2026 09:05:05 -0500
Message-ID: <20261118140518.59878-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118140518.59878-1-luiz.dentz@gmail.com>
References: <20261118140518.59878-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The advertising instance returned by hci_find_adv_instance() was
dereferenced without hdev->lock and could be freed concurrently.

Reported-by: sashiko.dev (linux-616b1f8e-06ec-4634-a907-5eb4e82f66df)
Fixes: cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
Assisted-by: OpenCode:claude-fable-5.2
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9cbf2e3009ac..a1f272c14a1e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2207,9 +2207,13 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 	if (hdev->adv_instance_timeout)
 		return -EBUSY;
 
+	hci_dev_lock(hdev);
+
 	adv = hci_find_adv_instance(hdev, instance);
-	if (!adv)
+	if (!adv) {
+		hci_dev_unlock(hdev);
 		return -ENOENT;
+	}
 
 	/* A zero timeout means unlimited advertising. As long as there is
 	 * only one instance, duration should be ignored. We still set a timeout
@@ -2239,6 +2243,8 @@ int hci_schedule_adv_instance_sync(struct hci_dev *hdev, u8 instance,
 					       secs_to_jiffies(timeout));
 	}
 
+	hci_dev_unlock(hdev);
+
 	/* If we're just re-scheduling the same instance again then do not
 	 * execute any HCI commands. This happens when a single instance is
 	 * being advertised.
-- 
2.56.0

