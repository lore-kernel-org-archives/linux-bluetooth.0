Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6961E5209
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742304117; cv=none; b=IcJxDQgiNf6Lqqdg7HwmdDyFOw41iZ1um+ryMSQ2AlNO0aTiGBmJ6bl4sVhiNFNPumpsn1hdTPjfndO3MTarFCk2l9yCmPhSZWenL+snn2jYEWkY7locddynKVhLrS476UavnuCVM1dRrxv9sJq7acxMeJmmHUUQsvr1UEONtXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742304117; c=relaxed/simple;
	bh=Yzhf+J98kCEGRVJHH3H+b+If1zsZ709J73MXxrLoMKI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S6UObqmMM5autKpZrtrnmHTk7iW0Q+3FIsgrD3yhVGTCWgwHWwynSNXqHxgX6G1VNb9rA2hj5is/gUUC/SenCgBamGVEsUYarCA7s/4EVmSSarL2er3S6suoq8pus5LGcdLRSGGCF787mAOS9P20jDEZyOmZb92T4FNuH6o2gAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FfRPxxW9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FfRPxxW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742304112;
	bh=Yzhf+J98kCEGRVJHH3H+b+If1zsZ709J73MXxrLoMKI=;
	h=From:To:Subject:Date:From;
	b=FfRPxxW9L9cbuSPF6lHNvMZ3N2rtJw7oa20hk2+++W1tOXvgUuomsXAQjZqO4TKUW
	 +34kCqb/UsBr1sep+EMyeQEmS9Tg/BurPN5vvUsU+/Dpd90SvAVzsUy2OP1oq5b08r
	 9aEpCABGmL1igKlEncJhI5DxGiucNCkrf76Kd4MAO8owspfK04f4siPSIkxz/6mRIp
	 YoVESC5rlxnUXOsmy0ayPvUkacAA5tjg+4BsaKBXdRodZPCl8pwjb+M0U09Kz1/KPu
	 p5kCjYuv1pp8UBjKTGff58GMoVxxl194DL/s9DGi8bS+pACVKYhGn1rpOSvYNtwMxU
	 Gbt+tdS6cYAgw==
Received: from fdanis-XPS-13-9370.. (2a02-8428-af44-1001-9FeE-4CcC-db1B-A287.rev.sfr.net [IPv6:2a02:8428:af44:1001:9fee:4ccc:db1b:a287])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9579A17E0848
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 14:21:52 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] obex: Fix typo
Date: Tue, 18 Mar 2025 14:21:47 +0100
Message-ID: <20250318132147.91774-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

---
 obexd/plugins/bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index 51afdc9d0..afb2215bd 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -338,7 +338,7 @@ static void name_released(DBusConnection *conn, void *user_data)
 {
 	GSList *l;
 
-	DBG("org.bluez disappered");
+	DBG("org.bluez disappeared");
 
 	for (l = profiles; l; l = l->next) {
 		struct bluetooth_profile *profile = l->data;
-- 
2.43.0

