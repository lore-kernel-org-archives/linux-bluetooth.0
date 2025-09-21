Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D78274669
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482099; cv=pass; b=SxyyAvo9mzcMNppkuXHsZQ5nxmDXhbNIcWzKlFkgPOeA35SXB5GmIGraOU9TS4jTu+8NmaB4QCyWJxxV1mdF/cXGh1gNtKggEJ0l2v/22N0HfVJrNgJ7+bGHFRLc+2FjxtpSCJyUN3LzmP4yhikweNDOysJbWVQQcwnClf6atyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482099; c=relaxed/simple;
	bh=tGSyaf+bHQPMBwL3pNAXluBMpv0OFoca/ngZ5PJdSw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEL/IsA5qnITlC/TS41GN6aCqkWEcD8ZD4f145KUl6IWCH+mV5pdtakBeznce6iYtCujy/ERlAPqwBPV8P0YS8c7Fl1+yVgH82NUEF5JrmTXMS90Hb8tDCY6x2LXNDfvknbnzy0oTFggfBZWbo5dlulCeHTmsk62EVnIwM6CbIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=f2a/ReGC; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="f2a/ReGC"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cVGCD6GHqz10H4;
	Sun, 21 Sep 2025 22:14:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1758482089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqZCgepMpVdYOQnZoI2FZQiKh1D/AoecqVF++woOdCI=;
	b=f2a/ReGC3Gry44bE0vzuAVvDRnu9ZAJRBxUkw58CmujmcxyTsa/XC2zfK2sKBkWQSPMGpR
	e7nvsWSMnbxCuIM2W2lCsMwWpqXRca6Y6EefE8GRYY5cYdMPOxu2yoUQzmZWYrksAD53pA
	X7bwHfnuVTO7zhB4BhLaw1kxNndtTIU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1758482089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eqZCgepMpVdYOQnZoI2FZQiKh1D/AoecqVF++woOdCI=;
	b=rkmR8EcXAHgCnGvIaX/3wgGfS9xUYc5TYA7BvkrZLe/jgXLIWh5yRNZgepaz3p5b6uPgiK
	F3rS2Ot8wzYDliZuxMHPL1+lRJ1eWh99ZJuduLxx1fr4UcaHWazlDb4QvV6961eXny0Bv2
	vvSvJ2WpxB05kKX8sUu8J9bNjhnwVRM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1758482089; a=rsa-sha256; cv=none;
	b=v3oTRsrPxca+mZdh08h5bWyFXMQP5/24/umiUCGzwhMf2fnsrEXks/qoCsZc4b6SbU35Kr
	zE4oXC4jgp/7I+WIivguZ9VJVeCZnGFndLWuD/LA6AXd/9vaK6xXnlFtAZkdF0U+DEaE2O
	ahlqWk1nrkGCqfuYcK4wocExWLfEqno=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 10/24] Bluetooth: hci_conn: extend conn_hash lookup RCU critical sections
Date: Sun, 21 Sep 2025 22:14:25 +0300
Message-ID: <b31306a3db524ad8170e41dc38f37a5119df04ca.1758481869.git.pav@iki.fi>
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

When doing hci_conn_hash lookups with only RCU, extend critical section
to cover also the handling of the return value.

This avoids any concurrent hci_conn_del from deleting the conn before we
are done dereferencing it.

Fixes: a091289218202 ("Bluetooth: hci_conn: Fix hci_le_set_cig_params")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1d914d95cb6d..b6c3ee60024f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1813,9 +1813,13 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 	u8 aux_num_cis = 0;
 	u8 cis_id;
 
+	rcu_read_lock();
+
 	conn = hci_conn_hash_lookup_cig(hdev, cig_id);
-	if (!conn)
+	if (!conn) {
+		rcu_read_unlock();
 		return 0;
+	}
 
 	qos = &conn->iso_qos;
 	pdu->cig_id = cig_id;
@@ -1854,6 +1858,8 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 	}
 	pdu->num_cis = aux_num_cis;
 
+	rcu_read_unlock();
+
 	if (!pdu->num_cis)
 		return 0;
 
-- 
2.51.0

