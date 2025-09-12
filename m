Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1A21E097
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 21:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757713053; cv=pass; b=elaG8fEXSiF+ybIw4AnyZOPk00reAK8Tp833LgLkC20OVqlhZR7mYt1aLK94SWl0kHlUC39grpmtxQycxU98ZcaQm8ZH6RcoifaVLfR03C20LUsNU7CD/4586791TtWDO4OaceOoo1zbYdlgqHRWmw2PQwxYZn8nyaXgIVyllUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757713053; c=relaxed/simple;
	bh=UIvCtaQJ9Oo1uUK0yngfoe0VPq+nICKZTFpFZon0Gi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjXe2n0LwNQzxLD3aAbqLUoTMWfItpBVSZ6ClpOyT8te5pAq7ZPPHifwr1QkOjAvTBSB4AzxRAsNkIHa+aRToslyBkTKWmkbz2JKU/5F4xjp3+q3kyp2LbdqR9bqjGHNmYSw7SGALCAtoH4irEb/UwFEBNkRJSLyczj+zbCuTKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=YqwxFaLE; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="YqwxFaLE"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cNnns1D3pzyWN;
	Sat, 13 Sep 2025 00:37:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1757713041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cr+zVzKbxG3t07xWgBeQaCa3zlbGJ+AnzOPkb9wfVo=;
	b=YqwxFaLEk/679FKs7yLRetr/VLs9yuPExi7n+2iPpWsUrJ5E4D/XyUAxayr29MOWCsvxBk
	ygQr1ICMsR0bN0YW6zZrxVsYyFMaaczln6nZhR7jqQ9aH3wyh+TX4RdfMSxxF6NNIUV3Wy
	KzmJxuRHvmh2DkfSwkl/UxPPbr26HNc=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1757713041; a=rsa-sha256; cv=none;
	b=A5sgEC1QiUbaBhZpCedsgcQYX6OhEukXN4nExSSU2RalZyBBhM9pGCqSc7Fssu0dHrsRNi
	cls2ligpZfSUcf//WfsOWFOkIZOOy6w/ZhSOqAWPsKlF4AvF0GPSiXwmW7PjYMWUY1IJt9
	pr45E1HuJCl4luAKnGbKrUK2xy3ZycY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1757713041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6cr+zVzKbxG3t07xWgBeQaCa3zlbGJ+AnzOPkb9wfVo=;
	b=PZJwoG3PxIT9bsSHBFQoyIFH4GG69HLdc5UZjGCk9BrDh3xhkoloD9vEiHJyOrOubZorA+
	1GEngehpKB+zNmIpWVhruC3OBFoZ5s4HaBs6DzX25nM3hhMMjSiY7e7vAaf64F7MVVNfT2
	n73GARS/rCNuB++JMM/MQxnhouBN8Cw=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 2/2] Bluetooth: hci_core: add lockdep check to hci_conn_valid()
Date: Sat, 13 Sep 2025 00:37:12 +0300
Message-ID: <b9b65e1e560f42ade5ae77ade75972d11237fca4.1757712988.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <7fed0c48a73265242c440611825888c096c4c93a.1757712988.git.pav@iki.fi>
References: <7fed0c48a73265242c440611825888c096c4c93a.1757712988.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Typically hci_conn_valid(conn) is used to check whether conn is still
alive, after which it is dereferenced.  This check only makes sense
within rcu_read_lock() or hci_dev_lock() critical section.

With improper locking, it is potential UAF, as conn may be deleted after
hci_conn_valid() check was done. If hci_conn_get() refcount is held,
there is no UAF but the hci_conn_valid() check itself is useless, as it
does not guarantee conn has not been deleted.

Add lockdep splat to hci_conn_valid() to catch callers with wrong
locking.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/hci_core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0a77813fef1f..0c6c29bb2818 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1114,6 +1114,8 @@ static inline bool hci_conn_valid(struct hci_dev *hdev, struct hci_conn *conn)
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
 
+	HCI_CONN_HASH_LOCKDEP_CHECK(hdev);
+
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-- 
2.51.0

