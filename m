Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA0A219ED;
	Tue, 17 Sep 2024 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726570507; cv=none; b=C9SnCRIkMDJ6f42C6Dx2AGPqqfrmS1k/9N6AB3hmWe6c2KlM1yiV53hhPJ6ZXOUKNhKj8GLJEVOSRlIoMPGHS2avq0B3emXdVaHMJf2nM5ThwKY9dZOfaZ7kS8F+FMEBGA2y2UrQ6iJN3x0/cN+4Ne6iZLU+FHrAvzwAwRBGyEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726570507; c=relaxed/simple;
	bh=CLl1v7tNL9sqp0wNarKO6L4gl8/2HIzkr1LFz2APFpg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=um8YBpZp+uDIeoGErqbzoUrjYgXWmoLXOPIQTuReUMHrVwczS/fclUb5+JEKESAno7WWD2yIuhhxIPnUbEY/93LMLariEpjFvobpx3/bRQ7UV++/2lfJt/a5/ITnOSBDWiWa0M27d/g9aQwZ9uSt0wxrhITr2/CXK53+k82n1G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=jo9LQE5I; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="jo9LQE5I"
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id DD1BF100002;
	Tue, 17 Sep 2024 13:54:43 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1726570483; bh=VrqSC7yyHWGVkvMWSkMvKGyaXmdoFYc4NAZw5E45oko=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=jo9LQE5Iqpv2u8buJiBFdhlCTalp5+7kGDnTiJXjcFMbdLDQ8QUu3mrj+uDUJp77o
	 YBN936hLRsnXnIzlzF4KmfybUkHd0MRA9z686BQKovjAh5FwI7NXH52WG54oWS0QPr
	 tfucJJhg41dPpxV2MWsUuADZDRbl1Q0mIHK6IZ14HVgAl12UYdnQJzBLQHYop1f3Qg
	 BuNPOQVOEpjUzkmdc03GO2g4lDtm4BV5rYVFhz9TGwmCiDHR75ML1Tyeqk/o0/bcPv
	 Un5DEq5WYWG++HgKoEJ8NnBAboC+k32OftIfcQf5/Gxa1QSJU/LMvJCXlno6HH4LyP
	 B0yP+eU4kr3Ww==
Received: from mx1.t-argos.ru.ru (mail.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue, 17 Sep 2024 13:54:10 +0300 (MSK)
Received: from Comp.ta.t-argos.ru (172.17.44.124) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Sep
 2024 13:53:50 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Marcel Holtmann
	<marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	<linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] Bluetooth: btbcm: Handle memory allocation failure in btbcm_get_board_name()
Date: Tue, 17 Sep 2024 13:53:31 +0300
Message-ID: <20240917105331.21945-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 187796 [Sep 17 2024]
X-KSMG-AntiSpam-Version: 6.1.1.5
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 34 0.3.34 8a1fac695d5606478feba790382a59668a4f0039, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1;127.0.0.199:7.1.2, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/09/17 10:04:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/09/17 09:54:00 #26602246
X-KSMG-AntiVirus-Status: Clean, skipped

In btbcm_get_board_name() devm_kstrdup() can return NULL due to memory
allocation failure.

Add NULL return check to prevent NULL dereference.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 63fac3343b99 ("Bluetooth: btbcm: Support per-board firmware variants")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 drivers/bluetooth/btbcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index f9a7c790d7e2..84273b7f02e1 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -554,6 +554,8 @@ static const char *btbcm_get_board_name(struct device *dev)
 
 	/* get rid of any '/' in the compatible string */
 	board_type = devm_kstrdup(dev, tmp, GFP_KERNEL);
+	if (!board_type)
+		return NULL;
 	strreplace(board_type, '/', '-');
 	of_node_put(root);
 
-- 
2.30.2

