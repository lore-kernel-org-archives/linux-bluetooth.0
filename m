Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD7270EBC
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Apr 2025 17:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745860747; cv=pass; b=q/zXQsVXKX3QuF5iFKA3e11SgYQrKXQLbxftT6aOoVZsQu4MoViRe6xol+kCwNnRVYfcUrbEOBpYH/bH5Mf5SHLWJoIcMbXkw9kUB5rxDS4/WIRbx7HpMjUeRHqRqiWjFsUj2w8oomME35FFueM+FevzrnFjzg29ug5gKiHzo/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745860747; c=relaxed/simple;
	bh=V5yVRB6msPSU0nzctUEg0kzyG4O9nHaFYufQk42BUwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/bUBGtUvELpPLUxkgM6Wn0rP1MKs/b0pB9/CuA4nGGtM38riNskck/+8nwpvfO8ZQBYsLzsfsXB8WNJMtp8yVuC/xvLO2cQDATD/a7KlW59sSdWgrz9IhdkRybGhEo3TM/KwdVkpdK1svIZZaZE+sGvXwfGHMdOEYUCee2rdpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Sp9Om7q0; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Sp9Om7q0"
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ZmVXx0qF2zyVQ;
	Mon, 28 Apr 2025 20:18:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1745860737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rBc5dhDs5crErV0QyaGZ8VG+K+gpVJDMwq8QNuS42Mw=;
	b=Sp9Om7q0gysZp0oY0B5/C7OCgrVZwf+7GrLcowq/hmyItMCteCC6lbvn5MgNyTPN7/VuuA
	2TCkEBM0fFKLl0Uxqfap/bgA6f9xENpbEIXvyZgPZEZVYaF0SfU0Y4uKUvt+BknEWmnzpp
	mw5tRZS5fZfFgkJB99Qic2jIA12Q9Cs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1745860737;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rBc5dhDs5crErV0QyaGZ8VG+K+gpVJDMwq8QNuS42Mw=;
	b=averGzBQ5ZHyCXEuBakSC2Hb1BVthsr0G6WJ8f0cZYTc/YY4cYRSD3z4bfzr46m6AME9NI
	zRuq8svS4VAdwL1T5f8aPFCPqX7qB8JqBiHR0l1na/essH2+ex4jFNLV0AeLNgjttj6Et2
	1vQtoGsu4+D/+/1uGO/GrgwuZe65hCs=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1745860737; a=rsa-sha256; cv=none;
	b=HC6vyWyIkTPmUbZIR+o7R/hH/GChU9C366vMh5FZFKxpuCX6daKuu/iEFcl1jwH7AYqT7l
	a5YRcB4Uzga3dxQHzG5twSihFhCoB5rDUSjRIiFs+B97AWvWSOhmFn/0peL3sJHXNuyJ6n
	RkrjB/23dC83dBkJzy39XwJWyAgmKfo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] hciemu: fix accessing wrong/uninitialized variables
Date: Mon, 28 Apr 2025 20:18:53 +0300
Message-ID: <1ac4f119e79c10da2da2d41f9458daaf170d466f.1745860619.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: aeeb4fd64adf ("hciemu: set bthost ACL MTU to match btdev")
Fixes: a112d4345771 ("bthost: implement fragmenting to ACL MTU")
---
 emulator/btdev.c  | 2 +-
 emulator/bthost.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index cf5c36bb4..7bb40670c 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -7466,7 +7466,7 @@ void btdev_get_mtu(struct btdev *btdev, uint16_t *acl, uint16_t *sco,
 	if (acl)
 		*acl = btdev->acl_mtu;
 	if (sco)
-		*acl = btdev->sco_mtu;
+		*sco = btdev->sco_mtu;
 	if (iso)
 		*iso = btdev->iso_mtu;
 }
diff --git a/emulator/bthost.c b/emulator/bthost.c
index 214583cc5..f53b4382d 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -688,7 +688,7 @@ static void send_iov(struct bthost *bthost, uint16_t handle, uint16_t cid,
 
 	/* Fragment to ACL MTU */
 
-	payload_mtu = bthost->acl_mtu - pdu[0].iov_len - pdu[1].iov_len;
+	payload_mtu = bthost->acl_mtu - sizeof(pkt) - sizeof(acl_hdr);
 
 	flag = 0x00;
 	do {
-- 
2.49.0

