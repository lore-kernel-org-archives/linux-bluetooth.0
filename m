Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44793D45FE
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 11:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778930105; cv=pass; b=Z2BsFI2AwxO6PNxBwpB40LSvGFA8rihAvC1jkPvQv9MxXXA1OHmqkbiNGaMY+KDWqL4pcThvexbKH5awAzxXuygoHZjZ7HYFu1M6UWhYZ6Of/tj16BLUeRAW9Ye8IHADFLdn4GDHPp6UrujFsbB0Ph5hIETNgNty4KjVKjvkFAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778930105; c=relaxed/simple;
	bh=yI1ayJd+zw9H0DnJDNAscB832PTgJv4CaEiO6LSYmaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q44f7vozvFvdx1eC34rV2cIgyjY5by0+c77geeNchHSEkCLPdywZuSDzcaVV1WKuWSZX1dLP0YIWTMB9vtWaUongL+VFcz8NltOAq0LMSAgsLR+oHX30f/Veaw1C0OZvRtbGwCK+JbXvUiw5c4J49GajhCxesHUlef2s3B4g+yg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=NZGq+Jol; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="NZGq+Jol"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gHhL615q5zyTf;
	Sat, 16 May 2026 14:14:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778930094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rG8TQsl1T/UuwoPA44G40W1dPklaV0zY9rBqRcpDn0=;
	b=NZGq+JoldumW0/27JQ1bpdvVToeEyXazcERNcDvDDw/vBI9l5ZsXKHxpbYJGQExReXrY8l
	fFL2VuBSOAypRUeILQw8LxdujhqeREltGzS/xESLCtKoOFsLwzqob566uvNxrSxOBf+emN
	ZiabOMLxTu761Q8+augnNwXy6WiJLrA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778930094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8rG8TQsl1T/UuwoPA44G40W1dPklaV0zY9rBqRcpDn0=;
	b=TUpzrrTvRKcWt4yhOxq8Y3//YW4PKZIZRlGfWIQkm7sNqG/eziiP3SeZCmbCymJg23Ev1k
	UhNG7HZFQZyosTGzoFwSyCwLkOrkHWTnXOXIq7ig/FPJCxyeRspKA+DyW+Psb2VZis/sEf
	zPL6pQpgpO17OxzqWl/czyGG8vT1C08=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778930094;
	b=VTj426m/yQChEfFNbFd7M1gtRAjrKHjnggCsxH+6W35uH0a+YePItdPw5p6+Im04ulaKqs
	iGUf5J8TeYXo/oO+JmgaALTL1C2msmUuM2hBLe3HYKVqeKubRjDdnn//mKvSkU38MjcXd8
	Ms/7ly2Dqk/a/USAf5TLENaMq8dYRyA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 1/5] Bluetooth: af_bluetooth: Add minimal context analysis annotations
Date: Sat, 16 May 2026 14:14:33 +0300
Message-ID: <342a530a1756cfd136542a33e5d947fd6c0a85d2.1778930064.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778930064.git.pav@iki.fi>
References: <cover.1778930064.git.pav@iki.fi>
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
index 9d68dd86023c..f42467159947 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -212,6 +212,7 @@ bool bt_sock_linked(struct bt_sock_list *l, struct sock *s)
 EXPORT_SYMBOL(bt_sock_linked);
 
 void bt_accept_enqueue(struct sock *parent, struct sock *sk, bool bh)
+	__context_unsafe(/* conditional locking */)
 {
 	const struct cred *old_cred;
 	struct pid *old_pid;
@@ -819,7 +820,8 @@ EXPORT_SYMBOL(bt_sock_wait_ready);
 
 #ifdef CONFIG_PROC_FS
 static void *bt_seq_start(struct seq_file *seq, loff_t *pos)
-	__acquires(seq->private->l->lock)
+	__acquires_shared(&((struct bt_sock_list *)
+			    pde_data(file_inode(seq->file)))->lock)
 {
 	struct bt_sock_list *l = pde_data(file_inode(seq->file));
 
@@ -835,7 +837,8 @@ static void *bt_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 }
 
 static void bt_seq_stop(struct seq_file *seq, void *v)
-	__releases(seq->private->l->lock)
+	__releases_shared(&((struct bt_sock_list *)
+			    pde_data(file_inode(seq->file)))->lock)
 {
 	struct bt_sock_list *l = pde_data(file_inode(seq->file));
 
-- 
2.54.0

