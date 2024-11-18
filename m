Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A36541C71
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 08:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731919057; cv=none; b=O/JmL2CUhVLAF0eyCZulMLwjBrzHSE+V9UJheB/gCkjL5C2kDumWoMUFZY7EHLsmFL1LDvkv2Pbqp+Tlbmhb249u6jH/9OMNMbGoQq47Nd7TWu6brFKQDY4Iejs6vsWcVe10k7YTCcN8XHqeAbdhjrkfBLJMA9BCLZV6hJ1NA/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731919057; c=relaxed/simple;
	bh=VhnScgCaSUGttz6kiW1NF6OH1MGF757R+9i7YQukVL8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=ZvIhoxvZsH1PuoRahJqZa/q1BKVHMipPG86hc5rmXQg/+UZrzdyrOXDQQ/y8OSXADzQFv4vdMfJ65rscbgc7HYa7OKAKsLBolMg7XF8N3nrGvA9KzbichWY/2JlRoqvqDBfreuixs9w3R3bAYz9xIj9oNAmVARr5RDVXAD0smOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kiJr3HQa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kiJr3HQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731919053;
	bh=VhnScgCaSUGttz6kiW1NF6OH1MGF757R+9i7YQukVL8=;
	h=From:To:Subject:Date:From;
	b=kiJr3HQa+S1o1lHbWAuvkDnCM34CbbT3/S8ONOb1fpQIbvCai2UUcVWMHDtuyS/O6
	 gguMeyMqKmPdBFiVuy7C0lFG+DNoGC1GgDw2zlNz+5CNJjALtWwO44zeDK2CTxMa8h
	 pOhNxEhCfKcrl0RfRQKWUuSCChHWqI8MNONV/h4Dly1A+5ahilAvzgySjbpl9Xgs07
	 ot+yfpZnOyg+ZyK5yXmew8rs2GKimFUMo8fmkV+02hw41nflSaH3NP2sZhhkXkkGrd
	 OA5W1O/9HqdQ6NpmfuwmV/v6hlqbIbd9DiI7f5+GikioS5InHX6AKltjeedSzdi8al
	 N/bwex1SB/46w==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1031717E14D5
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2024 09:37:33 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: SCO: Add support for 16 bits transparent voice setting
Date: Mon, 18 Nov 2024 09:37:24 +0100
Message-Id: <20241118083724.25632-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The voice setting is used by sco_connect() or sco_conn_defer_accept()
after being set by sco_sock_setsockopt().

The BCM4349B1 supports 16 bits transparent data on its I2S port.
If BT_VOICE_TRANSPARENT is used when accepting a SCO connection, this
gives only garbage audio while using BT_VOICE_TRANSPARENT_16BIT gives
correct audio.
This has been tested with connection to iPhone 14 and Samsung S24.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
v1 -> v2: Enhance commit message

 include/net/bluetooth/bluetooth.h | 1 +
 net/bluetooth/sco.c               | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index f66bc85c6411..21e93640c229 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -123,6 +123,7 @@ struct bt_voice {
 
 #define BT_VOICE_TRANSPARENT			0x0003
 #define BT_VOICE_CVSD_16BIT			0x0060
+#define BT_VOICE_TRANSPARENT_16BIT		0x0063
 
 #define BT_SNDMTU		12
 #define BT_RCVMTU		13
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 1b8e468d24cf..baaac4d65a5a 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -319,7 +319,8 @@ static int sco_connect(struct sock *sk)
 	else
 		type = SCO_LINK;
 
-	if (sco_pi(sk)->setting == BT_VOICE_TRANSPARENT &&
+	if ((sco_pi(sk)->setting == BT_VOICE_TRANSPARENT ||
+	     sco_pi(sk)->setting == BT_VOICE_TRANSPARENT_16BIT) &&
 	    (!lmp_transp_capable(hdev) || !lmp_esco_capable(hdev))) {
 		err = -EOPNOTSUPP;
 		goto unlock;
@@ -922,6 +923,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 
 		/* Explicitly check for these values */
 		if (voice.setting != BT_VOICE_TRANSPARENT &&
+		    voice.setting != BT_VOICE_TRANSPARENT_16BIT &&
 		    voice.setting != BT_VOICE_CVSD_16BIT) {
 			err = -EINVAL;
 			break;
@@ -935,7 +937,8 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 		if (enhanced_sync_conn_capable(hdev) &&
-		    voice.setting == BT_VOICE_TRANSPARENT)
+		    (voice.setting == BT_VOICE_TRANSPARENT ||
+		     voice.setting == BT_VOICE_TRANSPARENT_16BIT))
 			sco_pi(sk)->codec.id = BT_CODEC_TRANSPARENT;
 		hci_dev_put(hdev);
 		break;
-- 
2.34.1

