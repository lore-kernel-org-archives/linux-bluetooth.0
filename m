Received: from smtp.smtpout.orange.fr (smtp-77.smtpout.orange.fr [80.12.242.77])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D606D7262E;
	Sun,  9 Aug 2026 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786280489; cv=none; b=cLj9kiXTyZaZqjAzBvyWTxGaz563Cj6eP4upAjyKHmFxWE1LD4+DrECKgj6m5p54LG+vPtudDXWRvHoNHVaTCQOsSVeKqlt5HY4KtEKmwB0rHvEluZFttHM9/8BNMhXSEPk1gDk34zqdGfYBChxoDe6W/v0cpxxmnVid/8xOvug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786280489; c=relaxed/simple;
	bh=8JxPF2wVFEsqGB4GhHJNW//qUV8h15k0uLWlBkJTV+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BwAeXne3sRiNCmw+mlaSYrU/LGbOh5DPrMcpMh7WgrUPNMI+XBFNEpBUDBD5s3ymyx6s5OtiRWER/YHrwPR2gKiFvr39Z8NHyKLfG0kMWsEDouzDFnKN3RIb4lNd/6TZoAq+YLklBKD5lDg6zT8ygVhksCEogx35JK5TEVHKi6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=CeR1oguz; arc=none smtp.client-ip=80.12.242.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="CeR1oguz"
Received: from device-101.home ([10.65.86.62])
	by smtp.orange.fr with ESMTP
	id t38MwuRNFK3UAt38MwZjAV; Sun, 09 Aug 2026 15:00:10 +0200
Received: from device-101.home ([IPv6:2a01:cb10:785:b00:6128:9b8c:c203:905])
	by smtp.orange.fr with ESMTPSA
	id t38EwyWsFw9Fct38Ew8OlJ; Sun, 09 Aug 2026 15:00:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1786280402;
	bh=iZkCY5PHbl/Gm2au6WQ1GHf7TeI3Ibsat+covrHw/nk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=CeR1oguzmj11cc/x1UFAo1Va2CfB7ZwnLlu8tHxTKml2o2hU02vNsNXq9xLONL5u9
	 Y6Sx4u08uO6RYbNjngDBkHDkfvSuqpTHfR64xfY3qalB9HcRTvHM23IVHDB/g2vfiE
	 ctqmWLYH0LtAWLg/Cs3hbXz0MOddKoFw0MvBNLLRka0dpKgqLk2t7wcR3FrEanXu/u
	 M75mHTWCBjawDBKLE5XxtrJAeVtcAdh8vwI/fRjYxe2ikjEkfo12JuwH1PuEkmqoJd
	 4mFZ8phYyzx/57/xJit5G9J7VIhHX2O9dU814n4/FGzJwxHXGIKqfHx6y6aO/mfy2b
	 kFWhO9ypFUmOA==
X-ME-Helo: device-101.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 Aug 2026 15:00:02 +0200
X-ME-IP: 2a01:cb10:785:b00:6128:9b8c:c203:905
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btmrvl: Slightly simplify btmrvl_process_event()
Date: Sun,  9 Aug 2026 14:59:59 +0200
Message-ID: <9fc342cc7dd726868216174cd83d196d1ca18f94.1786280385.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In btmrvl_process_event(), all error handling paths except one do a direct
return. Update the only one that makes a goto to be consistent.

This does not change the behavior because ret is known to be != 0 when
'exit' is reached.

This simplifies the code, saves 2 LoC and pleases one of my coccinelle
script that tries to spot erroneously mixed goto and return statements.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/bluetooth/btmrvl_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index e25930351f64..d449fbdde464 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -87,8 +87,7 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 	event = (struct btmrvl_event *) skb->data;
 	if (event->ec != 0xff) {
 		BT_DBG("Not Marvell Event=%x", event->ec);
-		ret = -EINVAL;
-		goto exit;
+		return -EINVAL;
 	}
 
 	switch (event->data[0]) {
@@ -165,7 +164,6 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 		break;
 	}
 
-exit:
 	if (!ret)
 		kfree_skb(skb);
 
-- 
2.55.0

