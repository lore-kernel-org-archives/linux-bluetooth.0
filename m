Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFCCB200B8B
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424829; cv=none; b=R4mtq99tCtIObOGrcs42HtrjO3SrvXyibJxoMUwINTqXyD/AHYtxUg2jmPift/c1hg7gCDxTW9ky3ZyaZQp91SO4BzTMOb7CjjWBiDpOHyd9oR0PTy7xIqC2EjirWGEtL+/NZx7srDupy4nGQqW0tj0XCe+YAc8fsUqEblt9e0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424829; c=relaxed/simple;
	bh=JNLi3orHI1r+rI3gWiLTzspUI7+lZ1vpclg6HOYdR8U=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=BnBE7CVVqUvoq8b5NVoCH16LD5+hIJQYlMT85xpXNieHKCz6E8ICLn+6L1+lz5n5cuCcKT01ibIC7IaJsrM7OXiqZoZe2+jpYxL7xiRXa18JZh6ea98jkfQtkgUSBOE4QxjGNRn5qMhRVoxYP8wkQZ8VtoaPeIxJtxfI+23dYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jjMaU6lo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jjMaU6lo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731424825;
	bh=JNLi3orHI1r+rI3gWiLTzspUI7+lZ1vpclg6HOYdR8U=;
	h=From:To:Subject:Date:From;
	b=jjMaU6loJx3W+ZLmJyTzBBOBYQSR11thydw6jmSbuwtjNNyF1s3uVCHBTjAsFG9NZ
	 Dpb3FayiPoRP7PO8AxmMai15ixTAdTsTLm64peytaMyddbu9cUOsXKdf54Te5attdX
	 FRUM43uatoEmYK3qGafwroZm7HfZi7wvdgnST//jMphcOcxaRetKqis4Kc8y88bsp6
	 hjN5y1J5mOj9p+haSVj9upC6htaARIfpRkEEK//wWrb0OBTaKjL07VYYYYlLqCuSx6
	 J2M486InZdP+gnzDmqK+gLgz4meE4iFEC63XCuSMQOFUqQnFGsmg/pSjMELr5cTuUs
	 2Orl0DO0puLxA==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8CE0117E3694
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 16:20:25 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: SCO: Add support for 16 bits transparent voice setting
Date: Tue, 12 Nov 2024 16:20:20 +0100
Message-Id: <20241112152020.147178-1-frederic.danis@collabora.com>
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

The BCM4349B1 supports 16 bits transparent data on its I2S port.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
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

