Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5DBD53B
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Jun 2024 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718457248; cv=pass; b=FPo1DDJyp0gujcSQivXwAvC1LM9ochar6cElb6jfN7BvP1Qz4yvcm5fpoiHWn9fm9HiMkOWBFa/hJVfKFqQKtCVL2QJI5Z19s31XdDBDn3CqdQ638P/PmfDHNEfWaLmbxBiMQbEnW0InLUyK2hXYJSQbh9wjRIUm7MHK4Ddndp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718457248; c=relaxed/simple;
	bh=l6w2Pw/ju+7r8kEw24JIM7gdlzS9ATuAOPRZxwvRYqM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EvoObZDaO2SEs+Db3swsQLLAY8sS68iv9rpHyc+M69aFUMjcHam+t/b3lI6EwhLVUL4W20/TkW82bl9uh43jDNLTDSJvj7sdzhZDTgt29AUMgllIt6Fd1SUiY4hsQ7ex+lVGgS8cIj4reJLlSw0+zY/7CD+lEidZkSyoNIN2dRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=l5ruHWtY; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="l5ruHWtY"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4W1c6d0PGRz49Pxk;
	Sat, 15 Jun 2024 16:14:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1718457241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CNCi1bDEIrmnmmERkcYkWdYIvA9CKagD4g24QyTeIX4=;
	b=l5ruHWtYGCWp1kFl1oz6tgGaJ4/v78PP14qITTgROY0Wiltl0RbUnCMGDU3dJ2JP3gNd3l
	Sv69T26TFDy9pKhYwZ2XGSdyHGji0E1mZyB8BewbvxbA4BCLWXMI3WBSUVBp1DhdnlyC8m
	ByvHSUbm0XZOdOW6R2nrUvWZs8OlLCnCD3OP0a4PdFBoM7OEDL8nENKLVvwSinNN9yKQjG
	Br+qqX/U2Cpp1xxPL5t9h8OZBAVOmNNmPKQBumaTah/jyUXJe/uQSDYYgtF5Uya+2QzwTG
	b3YPIOWzgqgSHNoHnIt1kZwIm49HAUdZtLRYKBlhR1+9yWWjPY7/4SGrXpdywQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1718457241; a=rsa-sha256;
	cv=none;
	b=gKzHm6PnuJcoshR4Ek3DciGQFS0cSr/JhtLYkp3YkM0vq2lg2FHmkalxMKPXiUD5u6xJV/
	DBdM1Om1DjWU3JrPH4OwbYmA4+vM3rtBv0ewsNcQ9U84Lw/2oWNzu052yroVDPUtx883oD
	IH3/Xqs+xAZ/DmMCoB8jFSgZKQaBN4TKrJw2jHfaavUZFlRW9oqNNtjZprTDe0jvO+HqOS
	0QFKvPfxT+bB9WyM+UucI6nfbPlYGyRh41A1oIbWzjdETFfT+IJS/fi3fojNOK8NAC6EUD
	cdZ04lxEZyI0eARpOAv1cGE1jVyQOiaZq8AQunwmI0sEPKKvq03s6IjcYKzvFw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1718457241;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CNCi1bDEIrmnmmERkcYkWdYIvA9CKagD4g24QyTeIX4=;
	b=I/dPmBAJztp0D6uTGM75QccobVvvoGjBcy2h9zJZ87Fr5doGo8KM/qM24eoYuxs5TkAGud
	nnSiD1ew1e1Kp4r0a1LPof7KhWj+7lcWJ1wCL4NbfTw2c93sluFpVNdmiUDpAOEisT8HBl
	HJNs59AIt4G+N0IN6uTGAY95H91y4qwHjz9fWIJGKACFyOHq5nkQuYWBthsRLCVnZ+dHpe
	kYd8TCTTKO404WMYT/QVBvR9TXtvXir14b6kn4qheel3cLY9m6rYDZYjgTNU6+jxsUr70K
	KdhJG8UEYqJADO+H7tE+5TSoCAlQI6arwbVrNNOjSMJH2wuTBIdgFoSISHxbhg==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/bap: make BT_BAP_* direction defines valid bitmasks
Date: Sat, 15 Jun 2024 16:13:56 +0300
Message-ID: <70a822d15a7e82ec6dc83c4b42e54799c3e45e05.1718457098.git.pav@iki.fi>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The directions appear to be intended as bitmasks, as
bt_bap_stream_io_dir() will bitwise or linked stream directions.

Fix the defines to be separate bits.

Fixes confusion due to BT_BAP_BCAST_SOURCE == BT_BAP_SINK|BT_BAP_SOURCE,
which causes e.g. unicast transports to be in PENDING state after QoS
although this does not make sense for BAP unicast Client.
---
 src/shared/bap-defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap-defs.h b/src/shared/bap-defs.h
index 2467e816f..75e6950ea 100644
--- a/src/shared/bap-defs.h
+++ b/src/shared/bap-defs.h
@@ -17,8 +17,8 @@
 
 #define BT_BAP_SINK			0x01
 #define	BT_BAP_SOURCE			0x02
-#define	BT_BAP_BCAST_SOURCE		0x03
-#define	BT_BAP_BCAST_SINK		0x04
+#define	BT_BAP_BCAST_SOURCE		0x04
+#define	BT_BAP_BCAST_SINK		0x08
 
 #define BT_BAP_STREAM_TYPE_UCAST	0x01
 #define	BT_BAP_STREAM_TYPE_BCAST	0x02
-- 
2.45.2

