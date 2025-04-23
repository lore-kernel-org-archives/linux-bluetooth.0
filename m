Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691AA27FD40
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 14:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745419266; cv=none; b=K7LNRWTHPWsNdJ/bJrIbmh2vbSSNkidPaCwb9wveTgO+OE27CqCGXEAwhphP8XXwGFE2fSt0r8V4GYjc19vQeV/9C5Zl+oXA/mAEq3HbA/UMekaMw4LYCUpBWwEs/+8J0iMKfx0njcA9b6iJxeW5HPjdqTFbHRwtqEuKMxZYc4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745419266; c=relaxed/simple;
	bh=uuYoWM0z8ZYKuclZoBNj0fnrDjQcjPdNMFMyg6E2rio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P2UE8EmznETtIAJrI1m7++ompLASgktQZck/g3mQ2p9xThu5RFUjChqkgB7rWIp3C6HQEb0Dsapnqt5qKNKw3tfp3P+uXkt+jcutgrpC177bgCFBgVt2ImoZV/VmTaYqQJdiTPOMaQkhk+is3FTfQjhPZ6PbxTwWlTvrfVsymZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gnqMmxIT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gnqMmxIT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745419260;
	bh=uuYoWM0z8ZYKuclZoBNj0fnrDjQcjPdNMFMyg6E2rio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gnqMmxITyRukY9J+OeJ74Arge8VWF6GDgGA7mZ8XVGm9is3kHDK6gllc08E7kK7Z9
	 VX1gBR57dgpCRxiXae1q0gdFj76CoxTQl04b8XWsZ7oF28pZUT2L8mUlUPsEqb9dsV
	 LXc2CbG4DhlrJcP1R9DwcUAKR9GJ5V9e1hhkekb1ZbWW4kLBEkyD94U2QWGQbTGWDc
	 e4USI4V10c3vFcktR5OiY/RD3xxICu3XiVnGEisjUn+wAy0NwVIE8ua69h7ljFmp0F
	 Ri/6wDfWcuapEAmh1OlGpyTq2mrfEDpiWOQdvkAl9XmkPeApnnJxub62kgoE5NthZN
	 AlLYLaGALyXzA==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 80B2817E36BB;
	Wed, 23 Apr 2025 16:41:00 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v2 7/8] sixaxis: Set security level when adding a sixaxis device
Date: Wed, 23 Apr 2025 16:40:19 +0200
Message-ID: <20250423144020.358828-8-ludovico.denittis@collabora.com>
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

When doing the cable pairing for a sixaxis, we may need to change the
listening input server security level.
This is because sixaxis gamepads can only work with the level
BT_IO_SEC_LOW.
---
 plugins/sixaxis.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index 84dd3891b..0e5f1e420 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -36,6 +36,7 @@
 #include "src/plugin.h"
 #include "src/log.h"
 #include "src/shared/util.h"
+#include "profiles/input/server.h"
 #include "profiles/input/sixaxis.h"
 
 struct authentication_closure {
@@ -301,6 +302,8 @@ static void agent_auth_cb(DBusError *derr, void *user_data)
 						 SIXAXIS_HID_SDP_RECORD);
 
 		device_set_sixaxis_cable_pairing(closure->device, true);
+
+		server_set_sixaxis_cable_pairing(adapter_bdaddr, true);
 	}
 
 	ba2str(&closure->bdaddr, device_addr);
-- 
2.49.0

