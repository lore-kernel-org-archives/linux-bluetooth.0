Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDB927F751
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510609; cv=none; b=t4YCIXqtai3cdWnCj7eI6Ck1sCC8DFhKMwWqt/hjpMO8f7ar2J/CSYlo5QlX241ObJ86h3PwORm+fxw1tREdMO7Yl2CH0lHtOLYefJr4rVV+9pC3LB88Ki7sxRwBUej3NE/qOyaiC5ObQ6kqA4O+iW/gg8WHqIQbtk0cXoH7MRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510609; c=relaxed/simple;
	bh=hHHfXQPELtG6DWgR/nCNtb6UfaVSn0ZO1qZBFKpyzm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnZuBOA/OOe31qS1S6UC5iqxeQscB51mZscvo3U0yQBIKYgpwL30H9GOIo8R24IsomQIYXeE223QbYGtk4ykMefm36UB7pjEXEAKXqlHeEpiOLUVehSnBMFMd6rBEOksEN8HJmflPxswh5YBp+hWzhQTJTyP8TSDH2o569mcITA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DAyjFrG9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DAyjFrG9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745510605;
	bh=hHHfXQPELtG6DWgR/nCNtb6UfaVSn0ZO1qZBFKpyzm4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DAyjFrG9YWfBX3q2s/kg+S3TNHdRyecdQdanngDBcCqbIVp59yDtkHJ3vTyk0LuG+
	 9+faMw5ttxTyH8MkK3IH2ttUBYryyt6jCYAttHZSNWuMr4m7mzRAP9TE3GhvEwgipX
	 cxg/DS8xsWMNAJe7RiStCtTX0rv737f3d4DAt+N6Yv8M//WYxzyUjEZOG2yYiLGR4j
	 +tRovBDmFnG8zaccMOMPVcryeVv8PaKWDb5VZxO6d1RRwTO90uKIvsLky1TdEoG8W3
	 iM+VXKPGSh7ulkqCi6sG9caDxiPbMez4pIsPSs9YXHQ44kXT6HJZ4SJDvby+KHtsJP
	 bLiQnCPuLC5xg==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F14017E3614;
	Thu, 24 Apr 2025 18:03:25 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v4 3/6] sixaxis: Set CablePairing when pairing a Sixaxis with USB
Date: Thu, 24 Apr 2025 18:02:33 +0200
Message-ID: <20250424160236.179982-4-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424160236.179982-1-ludovico.denittis@collabora.com>
References: <20250424160236.179982-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sixaxis gamepads don't support encryption. When doing the USB cable
pairing, set the CablePairing property to keep the connection to the
device unencrypted.
---
 plugins/sixaxis.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 3e69f1dd2..ea160c65d 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -296,10 +296,13 @@ static void agent_auth_cb(DBusError *derr, void *user_data)
 	remove_device = false;
 	btd_device_set_temporary(closure->device, false);
 
-	if (closure->type == CABLE_PAIRING_SIXAXIS)
+	if (closure->type == CABLE_PAIRING_SIXAXIS) {
 		btd_device_set_record(closure->device, HID_UUID,
 						 SIXAXIS_HID_SDP_RECORD);
 
+		device_set_cable_pairing(closure->device, true);
+	}
+
 	ba2str(&closure->bdaddr, device_addr);
 	ba2str(&central_bdaddr, central_addr);
 	ba2str(adapter_bdaddr, adapter_addr);
-- 
2.49.0

