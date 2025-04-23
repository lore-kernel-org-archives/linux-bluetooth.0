Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F630143736
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419264; cv=none; b=T0PHzvD7pWIK2UekuJ91ZuU9xISQsVl4a//LiXW+DLz/5gYUJ1F4npE6Os2o+VFzSXXVR1qCvC4kb3JQb+IE8cN0FhYRsx7rkG/FNlbe/UKvbQWUFKzSONJB966d2QEq594ypQPXV+NAM8SCmUt9KL4syDobVk0H7YBSFJUWVgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419264; c=relaxed/simple;
	bh=2pe6XjjC0mhZG7nI/GV4gZgYITk5arIObQn1QvX8Yng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRCLxHpQ1W1QmDXzaWBZrOnm0TAmsTuRshuUJBJj198K30b9hfNz7apQtfylvBnxgPMym7Whq/k2HdfJ8pSCC/Q69RkH5V+wscwuEUp+ga+XEpseii0vnzpWYBeaflFNHnZov2mO4GNIbGFMzsWNr3dknEMr0PPFhPj6Z5HHHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KdIk1789; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KdIk1789"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745419259;
	bh=2pe6XjjC0mhZG7nI/GV4gZgYITk5arIObQn1QvX8Yng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KdIk1789b5qQvXs1Wge2b7G1ATneXCh3G/v5UIOAO4CudrRmLEmqW5Jc7Tk3QD5Mq
	 45Sfgthml952CtrN575xIGaVhcCtYgsninKn9TUAmQHHTCJZcjEpsxbuYFymfgf+HC
	 0pqDcCepFdQZTBf4FG6+5JOsnn6JGLIsCwFSVScgp2F4ej3sP//e8cba1djSd1Dj99
	 wENgLVeORCZ1z39iyE+Hkf5AQDSW1JeD8E0AakldRU3xcEBAsURzHV3EAkbFEAeUwg
	 CEm3L29a5xJt5Bjvj8LDLUWbZj+/VCQ1RHHsQXkvi1R00D+Q5ODzpu1+YRxOI/2+W2
	 eJ/nRTWzMhBUw==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2C76817E3613;
	Wed, 23 Apr 2025 16:40:59 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v2 3/8] plugins: Set SixaxisCablePairing property when pairing a sixaxis with USB
Date: Wed, 23 Apr 2025 16:40:15 +0200
Message-ID: <20250423144020.358828-4-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423144020.358828-1-ludovico.denittis@collabora.com>
References: <20250423144020.358828-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If we are pairing a Sixaxis device using a USB cable, we set the
SixaxisCablePairing property to flag that event.
---
 plugins/sixaxis.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 3e69f1dd2..84dd3891b 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -296,10 +296,13 @@ static void agent_auth_cb(DBusError *derr, void *user_data)
 	remove_device = false;
 	btd_device_set_temporary(closure->device, false);
 
-	if (closure->type == CABLE_PAIRING_SIXAXIS)
+	if (closure->type == CABLE_PAIRING_SIXAXIS) {
 		btd_device_set_record(closure->device, HID_UUID,
 						 SIXAXIS_HID_SDP_RECORD);
 
+		device_set_sixaxis_cable_pairing(closure->device, true);
+	}
+
 	ba2str(&closure->bdaddr, device_addr);
 	ba2str(&central_bdaddr, central_addr);
 	ba2str(adapter_bdaddr, adapter_addr);
-- 
2.49.0

