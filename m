Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.216.248.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398584;
	b=cEkFpHIpD5XPxxYJownRodgv4qq5RLRx8d5vjit4U4urtFOnC+DUXEfpJ6UNd+lInEYk
	 JQzzdCjVoYIw132mnbbLBLsf0uU9gAKtnMTiIjO34OpC4NjS6FCs1I3Vubr+cW4L4kgyM
	 j7slNer03s16gTBzDpTyCe0aG4nlyvRThFQPu0IV+Wf1ci7t/+5KJIUuARI+kw2F1qLEA
	 ybgJYfk3XekA4aVATcYcbcu0plL6ZPxvGDRA0LXyshrJhsKRayEMS/UBUrzu17eBhHPyX
	 faeFIVQqsz5PSyXnjZUg9IKXYzg3glcCEzpa7k1CjZNrODfZYEucj0aNWNIqDPxbIzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398584;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GU1rR6DOyFxE66mLliEw1hVk/Ddk8r/dNCEfmv4kUDw=;
	b=OsMcrCBLI2B/QVyrE7//UzmCAFyHt5/IVgsJIEZqg6sHv/4MIOsYCkUEfLYSKG8hqBZb
	 h6ngdC0qnfWIrKbigjyMdW12rOnjb/yQI38kxR4H3j/gB2ATwOVYCjtSYHssjRRPQCdLe
	 jxkzW0mlm0VRWZYYtdJ0n/9/fsjoIEb8NvNsYt8OVRWTTr4EnbaHFtZ1RE2C2KNwsK2p9
	 nBOWv9+F2qv79EJ3dSLOYgKCHzWA/9hDbcwbUOC15zq2mlQbAQ85RELkADxYFN7jt7UTR
	 J3VBsEOvgxP5FadpuRiuJMmOh/wMiVaLzPVRTHddHa7mftTKEwk9w3/UC6SyoZCIQ1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=deq.rocks;
	spf=none smtp.mailfrom=deq.rocks;
	dkim=pass header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=JbpPxQlk;
	arc=none smtp.remote-ip=91.216.248.207
Received: from mx5.mail-out.lima-city.de (mx5.mail-out.lima-city.de [91.216.248.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59458606B60E;
	Wed, 11 Nov 2026 12:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59458606B60E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=deq.rocks
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=deq.rocks
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deq.rocks header.i=@deq.rocks header.a=rsa-sha256 header.s=securedbylima-20251205 header.b=JbpPxQlk
From: Andre Eikmeyer <dev@deq.rocks>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=deq.rocks;
	s=securedbylima-20251205; t=1794398575;
	bh=yawQ4E02fUTwAlaYm0llbngJGLthGeeE2ZDGDd72jJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JbpPxQlkys15RVAJz3GjgfOx3YBNrGh80v6rH8HnDaHjqxID5IuXUqB6zQ2vd660j
	 jGtbdlcNKFhOb6V386Wy4c5KKcrd9ELSJEtC4U3VFdWt0cVYVndEibYWDXyuw3BNqM
	 8mrUTHkB41bMQoshQjFj9YYORvHnoDQqGK2fLAqC1xV8Et/xjDJVpQzs0h9Y4crNUY
	 PpPoKx4x8qjr2Ir2D7x2fvUAgLm/QwneO44IZFkoLJLEH7Hq9H9Q///wtWMrUO4ASR
	 kvYiPjMvCAsyNOjU4cBeqdkuZhIL3pjcCPt6OgpdH2E8FEZeyHUUiSWy7tJto7VTSL
	 CiCz4Be2+tXBg==
To: sven@kernel.org,
	marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: j@jannau.net,
	neal@gompa.dev,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andre Eikmeyer <dev@deq.rocks>
Subject: [PATCH v2 1/3] Bluetooth: hci_bcm4377: treat only negative hci_register_dev() returns as errors
Date: Wed, 11 Nov 2026 13:02:46 +0100
Message-ID: <20261111120248.21062-2-dev@deq.rocks>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111120248.21062-1-dev@deq.rocks>
References: <20261111120248.21062-1-dev@deq.rocks>
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

If another controller already holds hci0, a USB Bluetooth dongle for
example, the BCM4377 is registered as hci1 and probe returns 1. The PCI
core takes that as success, but the devm action that unregisters the
controller is never added, so it stays registered after unbind while
its driver data is freed.

hci_register_dev() returns the index of the new controller on success.
Check for a negative return, as the other drivers do.

Fixes: 8a06127602de ("Bluetooth: hci_bcm4377: Add new driver for BCM4377 PCIe boards")
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
---
 drivers/bluetooth/hci_bcm4377.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm4377.c
index 66d49b47154..da0a48c2be3 100644
--- a/drivers/bluetooth/hci_bcm4377.c
+++ b/drivers/bluetooth/hci_bcm4377.c
@@ -2410,7 +2410,7 @@ static int bcm4377_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		return ret;
 
 	ret = hci_register_dev(hdev);
-	if (ret)
+	if (ret < 0)
 		return ret;
 	return devm_add_action_or_reset(&pdev->dev, bcm4377_hci_unregister_dev,
 					hdev);
