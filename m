Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5B36213D
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 18:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019680; cv=pass; b=p17Ioviz4L7Zb6ondWj9+NSDn5D/4tTQjBai1fnNsd8Am9zTbrsxBxHD3NDCQ0071XQEe1x3uRKJqLgJYMMZlozItZ4aFFbqrDZRS1QY2KRY8SeJE4g6emfFNeJD9fQjjHVh/o8SkLhXYxfLH6okL7k2d4XlZH6Z4UYi58lSHd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019680; c=relaxed/simple;
	bh=h15z0epoXSb2fnfgZWnBBasdb2hQbyX+lmBmBcCv3vY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFgMG47M6YGAej2EeVw5id+esfxp3hFvAaePTuOGoSKhWKLLwf8uIkte0gxbDCnl9XLpYaBuDcA+2WeW8aEbdxFOaRHkJ5jbzmfC/gF3IKCB9RwpwU4wnVM+ao65VgyQ9Qh4mYhtVYyLJdH2kBYtlGUDK1uOdYpO8wE6mRAJFd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=gB4Y4BCl; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="gB4Y4BCl"
Received: from monolith.lan (mobile-access-2e844b-114.dhcp.inet.fi [46.132.75.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fv00P3KR5zyQn;
	Sun, 12 Apr 2026 21:47:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1776019669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iISAEr/jdT9eahX9gMcxAOt2ntBAvLwrRUF7qdh1g1s=;
	b=gB4Y4BClY1HWncJXz1Tn0LEbudS8MAqLn+J9YW0BLS8vpHT2hGQGkErFDXvZ9V3gV5/X0A
	neSXDbnv+ZoNhBG0YjWiama93tRsVJ02/RifaovkekTLPAAnM1oYvsROQGZ/BFkDkHC+e+
	Gx2S+oXB2oA82aU/UfeOW/Y8ZzNxX5s=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1776019669;
	b=KXgc+GbdN62W++UsovA0wNykPlvd77542mMqNbAx8cAPLKsIM18Z5T8G+jAQoGFTQdjbks
	89dKKxtLH1esvayKXd6rN+bCmjyEuvVKPMtggzIOmKZurpc0cjw8VDAulCvGQijS60eW3j
	Z210NEkbMM3kr0n7XH5zI94pIBw6WK0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1776019669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iISAEr/jdT9eahX9gMcxAOt2ntBAvLwrRUF7qdh1g1s=;
	b=YvU+muhruKZIUMoQZaYiYgGcGEZgFd2jbeHe2XGVaNhR6XzN63ydrtzz+XWNUJHd6gulvw
	yQ938kv3dNxcUZQvuwAirY2h45udWagkOZXO4w4T3pe4UjKqxGuSnxkuM0sRhV7tPaX6ND
	NVff1ooUdjr2/Y2Fki07LmsqraESNFY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH] Bluetooth: SCO: fix sleeping under spinlock in sco_conn_ready
Date: Sun, 12 Apr 2026 21:47:42 +0300
Message-ID: <9f333a79da3f0f552ca735d549ea3e8ae0784220.1776019593.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sco_conn_ready calls sleeping functions under conn->lock spinlock.

The critical section can be reduced: conn->hcon is modified only with
hdev->lock held. It is guaranteed to be held in sco_conn_ready, so
conn->lock is not needed to guard it.

Move taking conn->lock after lock_sock(parent). This also follows the
lock ordering lock_sock() > conn->lock elsewhere in the file.

Fixes: 27c24fda62b60 ("Bluetooth: switch to lock_sock in SCO")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/sco.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 18826d4b9c0b..3a5479538e85 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1377,26 +1377,24 @@ static void sco_conn_ready(struct sco_conn *conn)
 		sk->sk_state_change(sk);
 		release_sock(sk);
 	} else {
-		sco_conn_lock(conn);
-
-		if (!conn->hcon) {
-			sco_conn_unlock(conn);
+		if (!conn->hcon)
 			return;
-		}
+
+		lockdep_assert_held(&conn->hcon->hdev->lock);
 
 		parent = sco_get_sock_listen(&conn->hcon->src);
-		if (!parent) {
-			sco_conn_unlock(conn);
+		if (!parent)
 			return;
-		}
 
 		lock_sock(parent);
 
+		sco_conn_lock(conn);
+
 		sk = sco_sock_alloc(sock_net(parent), NULL,
 				    BTPROTO_SCO, GFP_ATOMIC, 0);
 		if (!sk) {
-			release_sock(parent);
 			sco_conn_unlock(conn);
+			release_sock(parent);
 			return;
 		}
 
@@ -1417,9 +1415,9 @@ static void sco_conn_ready(struct sco_conn *conn)
 		/* Wake up parent */
 		parent->sk_data_ready(parent);
 
-		release_sock(parent);
-
 		sco_conn_unlock(conn);
+
+		release_sock(parent);
 	}
 }
 
-- 
2.53.0

