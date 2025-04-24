Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694881AA1F4
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745506180; cv=none; b=BX40JbnxQJ5fTrIsp6z7+ne7Jd0jZ16rTb0isTJ3GTHWXT/tmcJEfdQHnQQ4Xh8yiL+PNOUVkpT48C40M6l2iqMQMHBygQHbQkrDu+LHc9Jcwg+EpwtA3hK1cQ7JnC34fPjzH83usMrkto8G0DYMt5rvzLYfTbc9wAYBw36aalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745506180; c=relaxed/simple;
	bh=sO2suyNYTHAjKiC5MF2Eyb4a1RhA3eniOwJ0ja+qevw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gl8EOgErukbkuJAxcLJhpSQ0AewQqdI4loB3FljYvxZRlu4sXkj/DOLNsGkCN6XZ2gDYm30TcMaJP6bHpqsU7UjjwJt2NR5bbrA0TrAXJWUxd2KhqBuHrlbn/2+ahXf/+aZNcBcuyUbZcFWBrnWHj7R3QQxW0loo74nr1qdo+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=N/kAoQLa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="N/kAoQLa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1745506169;
	bh=sO2suyNYTHAjKiC5MF2Eyb4a1RhA3eniOwJ0ja+qevw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N/kAoQLa1OgZezCU++pNFq/9WfhEJg4T4VKBEqSeaPoPf5O3ddU/ceDai8r/xqNgN
	 TCDIC90Dnrv/poTD02F3NR61EPnubdu8IS8wQNzSSbV7/TApSXQULdUHn8f6KdkH4N
	 sxjiGbggnyaSq78HuVWs7xC602aWg0ORPqGwNDjZv8DJwgnvN0m13yUzPudKm0GIbw
	 kq9xZBb2gNPJv1UQEWe2HSdFS+312KLKYb521ypKeMooHMYMaEn+OAko0CmmaX0I93
	 8U3WyO8V3K2qYdEG8yEUYhCgbkszxhmd5wn4UUCM3EtpFKhMV1XIrZf43c2isewmIw
	 HSUuWFRLAa4zg==
Received: from localhost.localdomain (unknown [81.56.51.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: denittis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E034A17E362C;
	Thu, 24 Apr 2025 16:49:28 +0200 (CEST)
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: [PATCH BlueZ v3 6/7] adapter: Set server security level in load_devices()
Date: Thu, 24 Apr 2025 16:48:30 +0200
Message-ID: <20250424144831.95766-7-ludovico.denittis@collabora.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424144831.95766-1-ludovico.denittis@collabora.com>
References: <20250424144831.95766-1-ludovico.denittis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After loading known devices from storage, change the security level if
we have a device with `CablePairing`.
This will allow it to successfully establish a connection.
---
 src/adapter.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index fd425e6d2..8d875013c 100644
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
 
+	if (btd_adapter_has_cable_pairing_devices(adapter)) {
+		DBG("There is at least one known cable paired device, setting the "
+			"listening input server security level accordingly");
+		server_set_cable_pairing(&adapter->bdaddr, true);
+	}
+
 	closedir(dir);
 
 	load_link_keys(adapter, keys, btd_opts.debug_keys);
-- 
2.49.0

