Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0037A27F755
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419265; cv=none; b=e74eGser6Uq+a8jflDBfJNWaykUwIddFaVAzhBZqHtzREUgY2RP8wi60t1hgZLENiE5ZONBBHtoBB5ydixHX6C1xzbPwfEvj/aIeYTROwOGGAPahAXhNUMKdgMc0TOsdm1fgZwVaL1OMTR02N9VsCxs0Wx87pu3bwKpSSMS7MSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419265; c=relaxed/simple;
	bh=vESiskUifPX4kpb/cAZ81l4+4EaRIuV5cj8KsP2/r2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scjdwednN791IJgrS/0+9fGl9twR5sHnRfsbUVW8KqYLLK+NAfESaHxkqboOmOwglOzxBP222X1Hg3wMlElYdj/RDvZ5IyRUs6xYrHdB3NgWU+6O7iMmHTDswwupu7H9mxpOrLtPvmxh6G7YAz5Zekb9ZJoiNNHRTEdsNffaA4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=iqFVD5u9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="iqFVD5u9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745419260;
	bh=vESiskUifPX4kpb/cAZ81l4+4EaRIuV5cj8KsP2/r2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqFVD5u9tdubtYZGuG2Eism0MHcYujmPvcM2D0xUZitZfiOP54gCZ6Eh/SSK4Y6Ln
	 JqynSIaTF4/HO9OEsxW9/x/soUb5f3b6iKbNE9eI0ByrUGr0uxlAuDhIg/kmviYDmW
	 LNY3BlALrac9Sk7qT/To4rNhx3JpXsI/rZ//KCxFy9hEsv8MXfAkc/Z2T0rS2EbvOZ
	 Y5h2YqZDrJbrVRrLhAguRInWwcbxhF/TCetn9IJh5May5DpiRAZOuAdpwS5wxtm4K1
	 1uLWB8pcsNVV3B51wzxye2htKRHWxHUyHCd8cdzCG0vP+XldvmjaVe+O+gwgfC/+2k
	 or8ArJy1WqvBg==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2E93E17E362C;
	Wed, 23 Apr 2025 16:41:00 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v2 6/8] adapter: Set server security level in load_devices()
Date: Wed, 23 Apr 2025 16:40:18 +0200
Message-ID: <20250423144020.358828-7-ludovico.denittis@collabora.com>
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

After loading known devices from storage, change the security level if
we have a sixaxis device.
This will allow it to successfully establish a connection.
---
 src/adapter.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 75b962b5d..03d946444 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -68,6 +68,7 @@
 #include "adv_monitor.h"
 #include "eir.h"
 #include "battery.h"
+#include "profiles/input/server.h"
 
 #define MODE_OFF		0x00
 #define MODE_CONNECTABLE	0x01
@@ -5090,6 +5091,12 @@ free:
 		g_key_file_free(key_file);
 	}
 
+	if (btd_adapter_has_sixaxis_cable_pairing(adapter)) {
+		DBG("There is at least one known sixaxis device, setting the "
+			"listening input server security level accordingly");
+		server_set_sixaxis_cable_pairing(&adapter->bdaddr, true);
+	}
+
 	closedir(dir);
 
 	load_link_keys(adapter, keys, btd_opts.debug_keys);
-- 
2.49.0

