Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723002EF653
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781432832; cv=pass; b=C+ZM5N0uVUe1k1+MqPUvI8YplNKGAAgQeKKng3i+ViVDLN1M7Yad02k+uAEYgxyjeeWEcOs4Z8vVkeebap2hrnRgmfNAVaK2y7amEAbRH2wCVcmQqmL7PKdvL7Wkee/d5W8kYK3BcUqihjrkQaGRU0wx2YHV5LtDoEnjaMt2RMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781432832; c=relaxed/simple;
	bh=5BYquKLadXiFypwCc+y5s0/M9ntHjm5PYAyvFAwgLJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFJT3p4SUmPzXGrBtUfGKmLHnu2j46Mv/2JiRaY/uPOI7o7CVzt2dJ/DaEDPnRq8KOp0/iwQky5zQfwIYZGLyNph5QKEkOCtqeBS3Mzc/5wO5nR1nEJGr7Dz5sruxFBc7QH2pLHEeT560oj6WS1qNf2Szqv08WOzY0UjvSKx6bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=AWHAHZYF; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="AWHAHZYF"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gdTvd5nH1zyb9;
	Sun, 14 Jun 2026 13:27:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1781432829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NB0i4RvvkTngyuXJXEgruzTnKT48WmGYdYfmJJXq2uI=;
	b=AWHAHZYFPAO3h/RbDKkHS2v3JTi1SJxaNuKti39ncpCOF8ju3Xgpc7J84Mu8iDU7FR8thO
	fQxazblQpXjdVPetvxH/RPhcHHG5YVb3/6aNa010Y2Ww2Z3uf9XGLYXkD7MYajdWzy9uRl
	4QSmzcgB98WgAtnOKRSKdfQSjDz6vKo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1781432829;
	b=N+GpBFcLqHyoKCmj42L5oGrBOoHsP6GQbsnncp/CHYbJLfm5tlq9mwkncWfkN9a6wUWdKA
	sZ5dnHL2rs1FaHWClPdGp1ke6gtZOxcJ+gBNVkJXsnZntbCbT+wnA47pP1twizZwimWBCo
	0OT5lXB1Wq7J9m62YC0XhK3ynNl2WNg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1781432829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NB0i4RvvkTngyuXJXEgruzTnKT48WmGYdYfmJJXq2uI=;
	b=dnoOKHBvpq4guD/4hEh9vR6BQd8Rom5DA8/4jQAfpmnZZu+htCrc7cQ8/kZ//ZX4V9JqTM
	nKik1YRv4WY8uvLzMstAKorUNMgeRPYUtK/uDUVcH4oJ7uluDcBHi1wHvyIGQuxoqGHRKt
	WAtBAlzcWWXr2g8TpzkJ0eyptJUYh6s=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 1/5] Bluetooth: af_bluetooth: Add minimal context analysis annotations
Date: Sun, 14 Jun 2026 13:27:02 +0300
Message-ID: <ad7f2913bb19e81661bae8bc51ae89144fce433e.1781432726.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781432726.git.pav@iki.fi>
References: <cover.1781432726.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add minimal compiler context analysis annotations, required for
compilation to pass.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/af_bluetooth.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index bcbc11c9cb15..62b751203fb0 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -209,6 +209,7 @@ bool bt_sock_linked(struct bt_sock_list *l, struct sock *s)
 EXPORT_SYMBOL(bt_sock_linked);
 
 void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
+	__context_unsafe(/* conditional locking */)
 {
 	const struct cred *old_cred;
 	struct pid *old_pid;
@@ -826,7 +827,8 @@ EXPORT_SYMBOL(bt_sock_wait_ready);
 
 #ifdef CONFIG_PROC_FS
 static void *bt_seq_start(struct seq_file *seq, loff_t *pos)
-	__acquires(seq->private->l->lock)
+	__acquires_shared(&((struct bt_sock_list *)
+			    pde_data(file_inode(seq->file)))->lock)
 {
 	struct bt_sock_list *l = pde_data(file_inode(seq->file));
 
@@ -842,7 +844,8 @@ static void *bt_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 }
 
 static void bt_seq_stop(struct seq_file *seq, void *v)
-	__releases(seq->private->l->lock)
+	__releases_shared(&((struct bt_sock_list *)
+			    pde_data(file_inode(seq->file)))->lock)
 {
 	struct bt_sock_list *l = pde_data(file_inode(seq->file));
 
-- 
2.54.0

