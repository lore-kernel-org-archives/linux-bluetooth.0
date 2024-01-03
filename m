Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2FD182B9
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 09:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lwiUvDT6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1704274100;
	bh=9Kz/CBJ1xa85T1s7BSJUDW2yUvNmKNKfOZGpQzCjQ/0=;
	h=From:To:Subject:Date:From;
	b=lwiUvDT6rl8rJ/+FYvdZckCjGcBtj/3IFcoEU3HRHLnfSvI5SP+c+/lryZSjRX752
	 SlvvXf2Yz9NxTx5xQTJnWdkDQmn0ZPHbTS1w9Je0rbtmBEF3yWRv3edgNNvRvNJhUW
	 huRGeYlUJyETQc6lba2HxiAClMk66pMh+XPu7zcmVu/npt54tndNJGgn3CoKCjQ7U1
	 Hh7jwi9aFXD90y1+hSSTdbwwT88CJwk9IRn0cNkikNrK92ryh3blH4IL/KVd1uSBT8
	 dj5K3iPzTUH+TW0aBkZpw6ylTDw5o2GJ3/AnwTpqH7MVxpBID5CXv8kka+ABNHGj7c
	 tZV8qrIYIvLhA==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BA9953780629
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jan 2024 09:28:20 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-db: Fix munmap_chunk invalid pointer
Date: Wed,  3 Jan 2024 10:28:16 +0100
Message-Id: <20240103092816.22952-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

PTS test GATT/CL/GAD/BV-03-C published a service starting at handle 0xfffd
and ending at 0xffff.
This resets the next_handle to 0 in gatt_db_insert_service() instead of
setting it to 0x10000. Other services are added later.
This could end-up by a crash in db_hash_update() if not enough space has
been allocated for hash.iov and some entries are overwritten.
---
 src/shared/gatt-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 676f963ec..d32c9a70f 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -58,7 +58,7 @@ struct gatt_db {
 	struct bt_crypto *crypto;
 	uint8_t hash[16];
 	unsigned int hash_id;
-	uint16_t next_handle;
+	uint32_t next_handle;
 	struct queue *services;
 
 	struct queue *notify_list;
-- 
2.34.1

