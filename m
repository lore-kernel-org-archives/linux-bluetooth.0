Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327CD142912
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715850231; cv=none; b=KyXekzDzHAPQJEvVbbGJZhXmmd4wBXjxoeTHYqwyKBGnG1gLgg06U7KJLON2trWd18NYV6wEdWf/agDsrXWMukf/sk+YfCqgMJTmXINg7kY3JNwPLyponaFtwld4j0W+6SNnn2fwct8OUUGmRCenU+84Mrh4ThQrdi49D06KGB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715850231; c=relaxed/simple;
	bh=KoK9Uxs4odh+a3x9TyxMTRK8Zm7JWwsNCXZajcs4rZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVMwm9OcHHIqjTrKnD/0NQB+zyDfo9nTNq2kiBqxdJiJtkLuJS4N2WHqnaY0tIKee4RSyRNJEdlHJz1UUvLBnbly04HDkrai9GWQRllOQxQh5IbqhDsFmxi3Y9Dyfuqxcka7uAYgTBnO/RvMrlZOSfzntJHetx+6c0sXLF6JciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2F63F1C0014;
	Thu, 16 May 2024 09:03:42 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [BlueZ 04/15] tools/mesh-cfgclient: Fix uninitialised variable usage
Date: Thu, 16 May 2024 11:03:08 +0200
Message-ID: <20240516090340.61417-5-hadess@hadess.net>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240516090340.61417-1-hadess@hadess.net>
References: <20240516090340.61417-1-hadess@hadess.net>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net

Error: UNINIT (CWE-457): [#def64] [important]
bluez-5.75/tools/mesh-cfgclient.c:1992:2: var_decl: Declaring variable "result" without initializer.
bluez-5.75/tools/mesh-cfgclient.c:2041:3: uninit_use: Using uninitialized value "result". Field "result.last_seen" is uninitialized.
2039|							l_queue_length(devices) + 1);
2040|			dev = l_malloc(sizeof(struct unprov_device));
2041|->			*dev = result;
2042|
2043|		} else if (dev->rssi < result.rssi)

Error: UNINIT (CWE-457): [#def65] [important]
bluez-5.75/tools/mesh-cfgclient.c:1992:2: var_decl: Declaring variable "result" without initializer.
bluez-5.75/tools/mesh-cfgclient.c:2044:3: uninit_use: Using uninitialized value "result". Field "result.last_seen" is uninitialized.
2042|
2043|		} else if (dev->rssi < result.rssi)
2044|->			*dev = result;
2045|
2046|		dev->last_seen = time(NULL);
---
 tools/mesh-cfgclient.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 6d2d34409fe3..e39f145c6241 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -2021,6 +2021,7 @@ static struct l_dbus_message *scan_result_call(struct l_dbus *dbus,
 	result.server = server;
 	result.rssi = rssi;
 	result.id = 0;
+	result.last_seen = time(NULL);
 
 	if (n > 16 && n <= 18)
 		result.oob_info = l_get_be16(prov_data + 16);
@@ -2043,8 +2044,6 @@ static struct l_dbus_message *scan_result_call(struct l_dbus *dbus,
 	} else if (dev->rssi < result.rssi)
 		*dev = result;
 
-	dev->last_seen = time(NULL);
-
 	l_queue_insert(devices, dev, sort_rssi, NULL);
 
 done:
-- 
2.44.0

