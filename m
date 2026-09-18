Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FE14DA9B0
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789728804; cv=none; b=K2dIB74t1N+tv0j+QD2K+vCTm41DY9mrcgJXbefxrD3TJ3Ztqo9VhSPwVcBCsgEyS+exvcum6vocX0dSQFkbVc1uOf0AMS4EjIGw2Glhl92xFgxuNMF4yUXQOV8IHzZ+BHVF4nJ4WLSu67msy//ZZk4L9jserOPoav1aw6FLrYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789728804; c=relaxed/simple;
	bh=sUIo4J9sgY/l2QXvdaw/TJQA4BnLcsVhc0Di39akJtU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SesHiQqnZR8ooaNolZmMpP1UaK34jlbwNDbHCEIWa4BxjW4anszydyvNrd9yTOBa0YQfQMk7KeDC5mK0HyseJ1c8uDw8pqEia60NsLshvDqyr9Nw4c3YGtFPwAITZp0adUw4cr/F4LRWcssxpdSEkhm00B+bf0fhKGn7BCWAlAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kZmDi5j/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i4wBzwzz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kZmDi5j/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i4wBzwzz"
Date: Fri, 18 Sep 2026 12:53:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789728799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=17bunrb+PPPmbHmf8iUWt0t3E5kLCszSkie89gk4y38=;
	b=kZmDi5j/ReEnY+Zf053inN/ZWuGtA6cEEhG5gEdU1ghBpguHScj3p/fopNFtUtHcrlrPvZ
	r1WKUwZWO8PXVuTd/8X7RJi45zemXN0U5VamjDhYKCnzqURHmGVc8Tpl45fWoPEVhgikYp
	BgwI+hLd2difTty/gpdm8TUpbn4LtGpipuJ/xpcV6F14qURSFmjWiEZokJoVc7c44i1oK2
	+lu6fz83Ebxb7/95KnEEADULVqIBGsMuk/qydf6z8RsaglNCkCvKEllfuFoyLkPq4jJSfi
	Jo0PR1YknXI7aKnDcGBv42V/hITZQ1arDiSI5577fXjHuR8d1mgLRKrh4yFERg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789728799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=17bunrb+PPPmbHmf8iUWt0t3E5kLCszSkie89gk4y38=;
	b=i4wBzwzzZ1lRvRDBJe04Qp5KmmoCZALM5m5xrzkpe7J4OAQ2GKrXOYsDqElF6ADPCho+ZK
	AFB3t5Ouy9Tr9YDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH] Bluetooth: Remove %pK formatting
Message-ID: <20260918105318.PdvCbvuJ@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Commit 71338aa7d050c ("net: convert %p usage to %pK") which is from
2011 and changed the %p annotation for pointer to %pK. Back then the
default behaviour for %p was to print the pointer. The %pK modifier was
introduced to able to control the behaviour of specific pointer values
without changing the behaviour of %p for everyone. It was dedicated to
avoid leaking pointers via /proc.
With the introduction of bt_procfs_init(), bluetooth followed this %pK
semantic.

Things changed over time. Since printing the pointer did not add any
value, networking prints now 0 instead of the socket pointer.

Replace %pK with 0 value, update the header line to match column names.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

The relevant net commit is 7c0ec6288b497 ("net: Replace %pK output with
0") which is net-next.

 net/bluetooth/af_bluetooth.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 411d66f24393d..8dc06fc1811ec 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -846,7 +846,7 @@ static int bt_seq_show(struct seq_file *seq, void *v)
 	struct bt_sock_list *l = pde_data(file_inode(seq->file));
 
 	if (v == SEQ_START_TOKEN) {
-		seq_puts(seq, "sk               RefCnt Rmem   Wmem   User   Inode  Parent");
+		seq_puts(seq, "sk  RefCnt Rmem   Wmem   User   Inode  Parent");
 
 		if (l->custom_seq_show) {
 			seq_putc(seq, ' ');
@@ -859,8 +859,7 @@ static int bt_seq_show(struct seq_file *seq, void *v)
 		struct bt_sock *bt = bt_sk(sk);
 
 		seq_printf(seq,
-			   "%pK %-6d %-6u %-6u %-6u %-6llu %-6llu",
-			   sk,
+			   " 0  %-6d %-6u %-6u %-6u %-6llu %-6llu",
 			   refcount_read(&sk->sk_refcnt),
 			   sk_rmem_alloc_get(sk),
 			   sk_wmem_alloc_get(sk),
-- 
2.55.0

