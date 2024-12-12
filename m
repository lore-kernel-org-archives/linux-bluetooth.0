Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3B3229698
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 16:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020094; cv=none; b=OQM2Dh2CfCpsewUHKQaCiltrUbyO3HTuoM5uCshCBxw7ucqpoEngOivgQNb2516eee8w3hVHHNga1iYCChkMLI1073F1QWk5LUmLb4kyxlgq1it0GbsfvWMFttdFGC8sgDP5y6rVy0UOA0bCP6Za86V9fShYeF/ElZO7FZdgA/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020094; c=relaxed/simple;
	bh=75k8vQfAdxNCyc8upk6BS2mFTnwef5NOPkGdceviGNk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F5GTUV2GLPkwcW6TrU6fOOj53wXn6l3wvd+8d0L9tCqL+A73DqucCWK9VtMBHkSdK/Dju0T342th0IDO7mJplcCard7QFSRcApbJ4FMaWlez+hkYTW7B0G1sGyP7kYIDAGP/BLaOX2qTjUQGDxR09c0GI3w+admjdSeiM6kvuZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fcwJHgut; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fcwJHgut"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734020090;
	bh=75k8vQfAdxNCyc8upk6BS2mFTnwef5NOPkGdceviGNk=;
	h=From:To:Subject:Date:From;
	b=fcwJHgutx/kwln77xB1H9DsYxbh76u6aHN5P2+ED7CJX7SzECG7Xkp+Atriv0CBva
	 iNjQ05+i/ViH+e4uaQn4EYxXFCMyol63gvYWY2wANsfEkd5dVHNby4cSDfR4EpTm7N
	 MvzwOAss17kxAj/MV4jOObzRmLUZW+aVPXnQ+dZraFii3UIFXs9PGodTB6B+0xNWmb
	 nIKGxvnAN58z07n2otlMbndfd/tTXPf1Q/mcuC+I38HlnMUVBW3Fg+h6dgPkd/Lweq
	 LsYVynNZlmc8SvlRmGq22Xxq4JF54+ZvhRY6ysOkjvw1htbWcU8ad3gCUQEIRxXnLZ
	 5DVWU9B89qLog==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B380017E37A8
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Dec 2024 17:14:50 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] lib: Add constant for 16 bits transparent voice setting
Date: Thu, 12 Dec 2024 17:14:45 +0100
Message-Id: <20241212161445.298083-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add 16 bits, 2s complement, transparent air coding format for mSBC.
Corresponding commit implements functionality on kernel side.

The voice setting is used by sco_connect() or sco_conn_defer_accept()
after being set by sco_sock_setsockopt().

The PCM part of the voice setting is used for offload mode through PCM
chipset port.
This commits add support for mSBC 16 bits offloading, i.e. audio data
not transported over HCI.

The BCM4349B1 supports 16 bits transparent data on its I2S port.
If BT_VOICE_TRANSPARENT is used when accepting a SCO connection, this
gives only garbage audio while using BT_VOICE_TRANSPARENT_16BIT gives
correct audio.
This has been tested with connection to iPhone 14 and Samsung S24.
---
 lib/bluetooth.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 073ed875d..32e58678b 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -111,6 +111,7 @@ struct bt_voice {
 
 #define BT_VOICE_TRANSPARENT			0x0003
 #define BT_VOICE_CVSD_16BIT			0x0060
+#define BT_VOICE_TRANSPARENT_16BIT		0x0063
 
 #define BT_PHY			14
 
-- 
2.34.1

