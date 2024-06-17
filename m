Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C0716631B
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643594; cv=pass; b=a5LVk4OHPqRThQklBEn2MVBd7l3EVWarMMag3Yk/yp0S+bnX3D/1cb5Kys6O3GuRM0KSCmz14pRm9VsvztjECYLZOKoRrv8NAakZEK/PvnnIg45yxahCmIp133dALYfx68+7AOKSd+VKrUgOejYK2eMsRcrIUcOfqa4WvwtFTqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643594; c=relaxed/simple;
	bh=sBCZV3xQWlhUAkp4EPssHKjE8mjVM/W0m3L3eoc1sMM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mTx+VH2hAQLBGO3jq9Bfyi9YHHKSZPjwUTCUtstidWHo7Bq9ialea6DpI7duH/O23tMCTGJoyLJe5qvGIV0N9ccta4syxN3cn5WaD9R61J9S22aZd+qStd7gYs3oLnibsGkVePDK1SWCX7mpG7yIt23KoXgGWJBktTWkfD9l5wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Y4A6PhhA; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Y4A6PhhA"
Received: from monolith.lan (unknown [193.138.7.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4W2x2F2YwXz49Pyq;
	Mon, 17 Jun 2024 19:59:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1718643589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9AE2y6Gj7mMGlS+2EZwxrpHi3eWlrWwvC9Utw/42wkM=;
	b=Y4A6PhhALGhdBrlq5B6Rz7MYCDDk1DoeELroyTgFfU+Ql2K8kCWqGWzAcwUfIiGDUzRVXO
	ic+fnOUWWbKRcu0Z4SxfXnz16/kOIJfpQTL6NmxhUoHbCK7NI45OmC0GWqiKJ6KsCmZ2Pg
	v5F9unf4CrH1GSaZ8kqm3xd8WEaNgHsMEZeMxJ/rkQ8th+peH+MflnqK5sD6wnNgfV2M7U
	3HtBVJrj0R5hAB9bvSc+TAvTOhWei4o7godUd2vg6CyEhfgazVIjfkV/zph7wD07qcZh96
	T3ginVXKGcAdGdIqefiRaa1G7iDyK8rlsUqJcqahO+lS1bNgV12xH2OCVOzlQw==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1718643589; a=rsa-sha256;
	cv=none;
	b=EniMZNAzGHs8Nd/ZebmZlJmibaaUi9stlsd4vxSqwLjJn28d9au56POkiNLDCfqypULlKA
	GWaGxTybGZWCbkMJ/O5nxX5qFaGR926gAR0e6C576NJ9IF0NUezFS6JgfroXIqTQai/qy0
	rUkVM6ezZEMQSNLEnrbLKdbYpSJLvKZGQuYSyM6Ffw0dhTPKz9+S2GAIoTIUCq398eIrmx
	NEwawYnh+GpYE2Iztl9ym/Ioc/1kcaRhCv2ilOyFwrZduKjVQM+3/1TQVSIZexZVz3y+Rs
	M21ySvX/bNWNC7YjvffAOcONAGV5zS4UcjWoXchePMHJaUVc7ZtTSMis/DNkjg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1718643589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9AE2y6Gj7mMGlS+2EZwxrpHi3eWlrWwvC9Utw/42wkM=;
	b=VgcHsDx5hfCmqJbP9mKVSANlhKWj1e6uLLwhtvimhmXisL5xiQ7IbWlucMaPfZMpZS0FrX
	d3Cmck899F5noaetbzQmZljbUH+hTbMpAYkqzRzFKrUuDdLIX7ugGN4qw8XyCCqFqtQ1yP
	r36DjxiQzyrZe6Dkjg5uy4kF8bNcTbVE2/f5YFdSR086ToJaAe1/69PeBLKz3cWXd4Qgfl
	wUSYHYaFVfq+kdnydG1E+hFSDP5Eu+g1CJ8HIKeXziaw+i0MCNn8Cz2IKt9EMLC5NXoFOX
	vOqu+wZTd1jHpH4HoHbd8vU9Jb2AyO3sSTcGjwE8RuSQTWoPX0w17Nj6KQIG2g==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2] shared/bap: make BT_BAP_* direction defines valid bitmasks
Date: Mon, 17 Jun 2024 19:59:40 +0300
Message-ID: <8dded7c01676b68e3042dbd0021e97c198a03b49.1718643571.git.pav@iki.fi>
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

Notes:
    v2: use BIT macro

 src/shared/bap-defs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap-defs.h b/src/shared/bap-defs.h
index 2467e816f..27fefa34f 100644
--- a/src/shared/bap-defs.h
+++ b/src/shared/bap-defs.h
@@ -15,10 +15,10 @@
 #define __packed __attribute__((packed))
 #endif
 
-#define BT_BAP_SINK			0x01
-#define	BT_BAP_SOURCE			0x02
-#define	BT_BAP_BCAST_SOURCE		0x03
-#define	BT_BAP_BCAST_SINK		0x04
+#define BT_BAP_SINK			BIT(0)
+#define	BT_BAP_SOURCE			BIT(1)
+#define	BT_BAP_BCAST_SOURCE		BIT(2)
+#define	BT_BAP_BCAST_SINK		BIT(3)
 
 #define BT_BAP_STREAM_TYPE_UCAST	0x01
 #define	BT_BAP_STREAM_TYPE_BCAST	0x02
-- 
2.45.2

