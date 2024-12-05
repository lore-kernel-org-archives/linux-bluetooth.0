Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78EE218841
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 15:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733413941; cv=none; b=qj0tvcp2r/YTzily+s495b1ga5wFym9yJmmsH81ixc01xf4qNXrF6JJENY+OlBzpuH2ImAjVdoakHX9z6Qw/cGtCl63k4W/x61O4xBSsrNhfYNzGBYj6ccLoIB+OSqc+ky1DoX2bD2K8dYNgZv3o2fBoTQe/IIz5X8JYa9DkkrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733413941; c=relaxed/simple;
	bh=8ufeSyDuvs6sxJitxcao4HoePTUm0YDGR95PtcAhnPs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Type; b=J4w4ZeNR3ZxABAxvvjd2+4zsdVTC2dHUa61LTdWhM69QE6AxpepXaLKZgmYdJpqYcQwUa0LjkIB7GoaGS1KV/pa5+W+bS+CgmrEVm/v2Dx0YHUzjbDwQB5lufBKEqZn5GDDsN6wmI/m0WSisN5+IdCAxW6JrKE3RSfZFjhIiyQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p60YRqeh; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p60YRqeh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1733413931;
	bh=8ufeSyDuvs6sxJitxcao4HoePTUm0YDGR95PtcAhnPs=;
	h=From:To:Subject:Date:From;
	b=p60YRqeh9n3aQab5WcsD8bCYd4xBeXe3BMSpAbBYsPzVdMn43JgM+JGEBOzQ8tOg/
	 VsojpRrnCghjJazVez3lqbta9zI6dTdgqDM8B4z1XPDg9uv9Ga2VB5iREYFWWX8oUI
	 /cgrwA2hdSyVavAkLoiODyTSIbHM+/PAAUE8FyOlZLwi/6E9CjJrwGyIdYZ97VMHJX
	 DNJ05ZlwVw1L7m0emu98oe5TwKO86BlLQBFxAZt9YIavOFNtZGrv4CyO/V4gNKMcDL
	 i5SQyD6IYq7qky155CW6488LzTTDgTYnfSIJzYl0MjWefk5pU6Ch68UfyDtcZJDUL8
	 cLRFsU6WRTkRQ==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 627D917E3782
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 16:52:11 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: SCO: Add support for 16 bits transparent voice setting
Date: Thu,  5 Dec 2024 16:51:59 +0100
Message-Id: <20241205155159.461032-1-frederic.danis@collabora.com>
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

The PCM part of the voice setting is used for offload mode through PCM
chipset port.
This commits add support for mSBC 16 bits offloading, i.e. audio data
not transported over HCI.

The BCM4349B1 supports 16 bits transparent data on its I2S port.
If BT_VOICE_TRANSPARENT is used when accepting a SCO connection, this
gives only garbage audio while using BT_VOICE_TRANSPARENT_16BIT gives
correct audio.
This has been tested with connection to iPhone 14 and Samsung S24.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
v1 -> v2: Enhance commit message
v2 -> v3: Enhance commit message

 include/net/bluetooth/bluetooth.h | 1 +
 net/bluetooth/sco.c               | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index e6760c11f007..435250c72d56 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -123,6 +123,7 @@ struct bt_voice {
 
 #define BT_VOICE_TRANSPARENT			0x0003
 #define BT_VOICE_CVSD_16BIT			0x0060
+#define BT_VOICE_TRANSPARENT_16BIT		0x0063
 
 #define BT_SNDMTU		12
 #define BT_RCVMTU		13
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 7eb8d3e04ec4..7b54d8826bcc 100644
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

