Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C9046F483
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762492; cv=none; b=JpCnqNWEscN8gIU8h/x8qVihDu7lJXWLGS9yitoXAA4q8k/Efw9UYu0C6anEjxsXq7o/Yy5NuTjWCwM8OeCi+jUpNiQwQcwMFSEdfRK9IpZp4JwHdDyzCgNC3kNVODhDcvhQSzjJn59sRGrOxnoqVPUlBpezxBbRbYUGaxzShik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762492; c=relaxed/simple;
	bh=DmagMpMNU5UAy3anwEGmrpphNqniEsm8tu8+k/ySxwQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PQ71+YdxHxvDjGN/PAgimc1M9mLHxBxirOFTC7Ndbi8eBDskq167Z4eo+Y6MRZVCyssHn7pZgpRjK02mzos7cxg4htToTN1uDNF/9TFpPVMUnHvZ65qqptvffWwikrsvNTfDHZjVQP/0NoJ34CrUHK8xAsIckjFXDy5rID6ClBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HU5G5JUF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HU5G5JUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787762472;
	bh=DmagMpMNU5UAy3anwEGmrpphNqniEsm8tu8+k/ySxwQ=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=HU5G5JUF5HlPxdT4ffPCIWBW1q0il7ceHO0HtaO5PlluTuUAxe3j+cphiyV5xkdpM
	 WN4jUx3s7g+2UyykQ4kcj+fo0ISGLD3umtBfnwPvUVB8pA3Ly++yjr9Y9opxKILkZU
	 Q0l5ccBeHoGC2pwmRlipU+BQvb+r5wusK6jyMt3l9s+7XIhLqJnnHKUzDaZMcvf0q6
	 2cfwrKth0Dk+wkQZFOsOmiP+vix+S8b2IcPJuqv5Zqh/QhUT54hMIRT/bwH/S9gmrU
	 kWYdPKeAkbXN5ZtQxcIyj+dBpPsygCyyyXgKG2mTHGD9rL2YytggfRmOKiHP1Z84i5
	 hcfqkHvPOBAJw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0DB0517E0BDC
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Aug 2026 18:41:12 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] profiles/input: disable force-active for Nintendo Switch Pro v1
Date: Wed, 26 Aug 2026 18:41:06 +0200
Message-ID: <20260826164106.293951-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826164106.293951-1-frederic.danis@collabora.com>
References: <20260826164106.293951-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

For Nintendo Switch Pro v1 controllers (VID:PID 057e:2009), set
BT_IO_OPT_FORCE_ACTIVE to BT_POWER_FORCE_ACTIVE_OFF on the HID interrupt
channel during connection setup.

This avoids repeated host-triggered Exit Sniff requests and reduces
Sniff/Exit Sniff churn linked to unexpected disconnects.
---
 profiles/input/device.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index 5b1be2b16..c2abe2451 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -1065,6 +1065,9 @@ static gboolean encrypt_notify(GIOChannel *io, GIOCondition condition,
 	return FALSE;
 }
 
+#define NINTENDO_VENDOR_ID 0x057e
+#define NINTENDO_PRO_CONTROLLER_PID 0x2009
+
 static int hidp_add_connection(struct input_device *idev)
 {
 	struct hidp_connadd_req *req;
@@ -1101,6 +1104,19 @@ static int hidp_add_connection(struct input_device *idev)
 		goto cleanup;
 	}
 
+	if ((req->vendor == NINTENDO_VENDOR_ID) &&
+		(req->product == NINTENDO_PRO_CONTROLLER_PID)) {
+		if (!bt_io_set(idev->intr_io, &gerr,
+					BT_IO_OPT_FORCE_ACTIVE,
+					BT_POWER_FORCE_ACTIVE_OFF,
+					BT_IO_OPT_INVALID)) {
+			error("btio: %s", gerr->message);
+			g_error_free(gerr);
+			err = -EFAULT;
+			goto cleanup;
+		}
+	}
+
 	/* Encryption is mandatory for keyboards */
 	/* Some platforms may choose to require encryption for all devices */
 	/* Note that this only matters for pre 2.1 devices as otherwise the */
-- 
2.43.0

