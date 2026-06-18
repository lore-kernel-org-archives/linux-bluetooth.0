Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631E130274D
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jun 2026 02:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781751179; cv=none; b=YOurFp4PdEq8ncQ9zGbdSXzcjednlvrc3eoqXBCyTtK4z2r8nVr9W1+DlZklUMByJCXmYot32uK4q05JLOonIc+L15U7/FWunlqQcVB03GHLAJax3oBC4JjDK8XNwV2JCPxO2qbBPDy2CQak0k9J/t7aetgbau8clzGNo6ZupgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781751179; c=relaxed/simple;
	bh=fYhZ/6I3zy4JkLNyQI5vhqnG6eRoIeDl4n8RaFU/2Z4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ATszWsbELPGFDgGYCAwg9oOxEpz2aGNgxRhUKWAhb4BuP2BFttN42Wz/ok1LBDxKP56aS0yENcyyc8KM+pkJufx7Qa++0kBUbpI9vzopwyY596Dm8xRmPUAKCzM81l2H3amtf4H4J0XjoNbGrX/L3Dej/mbP+pl3syGTQ8LxD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=GdXEKvZl; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GdXEKvZl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=kW
	TDdqZD6fUy0JE2IcZh0k+r8qvuDwbEfTol5AfuRSs=; b=GdXEKvZl7OYKG9wpDN
	msETFI0yDc3hdnkKOiJpXbwGe8Fre3hkIvZqkEfch5ulzFJJGse7NuTwFzono0dT
	9/GkC/WpxptjO8dXVYeA3qi/btl/Abc0HiI38iXWofbuxV2tOASJs8+gPrzqKv9x
	7DrfACRUtgq2gIk1h/2ft4bRA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgD3fwh6XTNqPYdYCg--.35065S2;
	Thu, 18 Jun 2026 10:52:43 +0800 (CST)
From: zhangchen200426@163.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Zhang <zhangchen01@kylinos.cn>
Subject: [PATCH BlueZ] set: Abandon the use of the existing set gatt-db
Date: Thu, 18 Jun 2026 10:52:39 +0800
Message-Id: <20260618025239.420860-1-zhangchen200426@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgD3fwh6XTNqPYdYCg--.35065S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4xGry7Jr1DXryfAw17GFg_yoW8Gr4kpF
	WkWa93trW5Xr1Ig3Z7ur4Uur1Uu39Yqw4rtr1UKw10gF15AryfJrWfJryYq34kCrZxZF4Y
	kFZ8t397WrW8G3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Um1v-UUUUU=
X-CM-SenderInfo: x2kd0whfkh0jaqqujli6rwjhhfrp/xtbCvxvceWozXXvADwAA3x

From: Chen Zhang <zhangchen01@kylinos.cn>

When pairing and connecting a pair of earbuds, if you attempt to connect the
second earbud while one earbud is already connected, reusing the existing
set gatt-db will interrupt the GATT procedure. Subsequently, the attribute
values will no longer be read, and the ASE state will not switch. This will
eventually prevent the second earbud from creating a CIS, resulting in no sound
output from the later-connected earbud during music playback.

Signed-off-by: Zhang Chen <zhangchen01@kylinos.cn>
---
 src/set.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/src/set.c b/src/set.c
index 4ca2f78c3..0f2e9613c 100644
--- a/src/set.c
+++ b/src/set.c
@@ -282,20 +282,6 @@ static void foreach_rsi(void *data, void *user_data)
 	if (memcmp(ad->data, res, sizeof(res)))
 		return;
 
-	/* Attempt to use existing gatt_db from set if device has never been
-	 * connected before.
-	 *
-	 * If dbs don't really match bt_gatt_client will attempt to rediscover
-	 * the ranges that don't match.
-	 */
-	if (gatt_db_isempty(btd_device_get_gatt_db(set->device))) {
-		struct btd_device *device;
-
-		device = queue_get_entries(set->devices)->data;
-		btd_device_set_gatt_db(set->device,
-					btd_device_get_gatt_db(device));
-	}
-
 	device_connect_le(set->device);
 }
 
-- 
2.25.1

