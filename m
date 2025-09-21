Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FA12750FE
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482100; cv=pass; b=Iv3W2iLcNbQkKyVR/Raq8YRwKnMp83yh71CXV4CpzB8rgB6Amdn2UqpilJp0RqKn7pSC3l4bY3xHo5kbtb5ThplOup7/xp25srgtad/3p4L1OWHXT4bZiO5W4xkX6ecBHpoyjaBETHBDb/QgL65GwTb6eOCn5VZqvDFQZrQq7q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482100; c=relaxed/simple;
	bh=o9GyWUuhIy0WpJd22yCXIHCY/oT17x4Mueb9VD3OA/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iye38f+OWnuld34bZN6FgBvuLJvbMWKIob9gq6y76KZrADWLzewRbVo9YbNlS4fPrFfYvtemSPmkcmdjLjDcXPJUpQW8AQsFPKfGpe/UfLuN7tMghHrJT45hY/ASDcE2JNSw/pK1oUD0sXyyrrWXjALF9Qv4bSd0TCTUCxasFBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=JY9FOP4o; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="JY9FOP4o"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cVGCF2bqDz10Gx;
	Sun, 21 Sep 2025 22:14:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1758482089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIXaEeOTNIKFhA0GoT0X+WowQhkUe+BUTHPcoQAzNw0=;
	b=JY9FOP4oUsaJ6KztsZuWzzW77M6K/Xna4sI3r0bXCI9Nw3DP7xKZ/+8aRIOxBtFhvnQp2f
	nWRTNhO5wkm2pHc7vz5LymnW9e+YDUyvKvxgkkiYh0xs9+eIgeSLJRTnukmvC66oB/hIDU
	j+n/VYrIyfIXvQABFq6ej5PV9ce1EDM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1758482089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIXaEeOTNIKFhA0GoT0X+WowQhkUe+BUTHPcoQAzNw0=;
	b=wmZdkSdkZG181Rfgcv71m09MeKYlwzvElr63ttR0td/p24CDInBKVRatJqkee5M/VwIPDM
	EFUfGFqb9Pvh7B/ZNig0y97PohS2ah/BL4IsvCuzMuPL8HWSKeg12esFBDPVPIv4xk3MQS
	ifIQX/iSrk/lDvGNEMVqOlGiMaQ6dwM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1758482089; a=rsa-sha256; cv=none;
	b=tfJfHcIk6+BJ5ZvvnZypG09eruI9SZ30yDQ4B6lElZomUgfAf/e3wW1ffAT2PlakoYjvie
	k2ag2YOnYtj5Bi/KPVUw3yJAtCRR9KtpylJnD/suyr0VYuzQHoCNFb8XRyDBZ+N7/+7VNY
	5IzboVIuSy32hrmkp1soTEN8sFfSap0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 12/24] Bluetooth: hci_core: add lockdep check to hci_conn_valid()
Date: Sun, 21 Sep 2025 22:14:27 +0300
Message-ID: <683103a67f4770f3f820d3a82e33753085e0f928.1758481869.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758481869.git.pav@iki.fi>
References: <cover.1758481869.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers of hci_conn_valid() shall hold hdev->lock/rcu_read_lock covering
dereferencing and other usage of the returned conn.

Typically hci_conn_valid(conn) is used to check whether conn is still
alive, after which it is dereferenced.  This is potential UAF if there
is no proper locking, as conn may be deleted after hci_conn_valid()
check was done. If hci_conn_get() refcount is held, there is no UAF but
the call to hci_conn_valid() is useless as it doesn't guarantee
anything.

Add lockdep splat to hci_conn_valid() to catch callers with wrong
locking.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 include/net/bluetooth/hci_core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b0f2adfdd5b4..68a5c3214cfe 100644
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

