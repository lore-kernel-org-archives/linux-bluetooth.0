Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7D3309EE2
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 13:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774791793; cv=pass; b=NPucYjuKe/i83BSC36wcFPjUfOUKIc8VrA0VQ/dOr9tVFTqXxU7hxGmgGFEMA4ScBuV/tFozo0wJBseykB3lqpXo207ss4CGYXGPr7baF6pdjIzRzZguNfQDZkq1km1IVlnIYjOaWDXwz2o/XSssQnBi9QXETnIOlUJ5k0BPVf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774791793; c=relaxed/simple;
	bh=LUN0TB1y+EUPkR+t8vcFvE8PiHtrfcFIcacIQzZ9wN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIK9VdVYlw4hZ2aPNtEMSdxHXXI0mxYZZrccJ0STnv5SgnxdNh8DAiiy0I3xjCRhJrIJ1MtsjIxbieb0/kwQni3ezuxM5mjoIIshOT6XzcU7dtWboaFa8ALl34N353SWZklh2aOkuFpnJgSaxxyjJUcD3RA99ksAgCVSfJRURd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=OpdnrRwA; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="OpdnrRwA"
Received: from monolith.lan (unknown [IPv6:2a02:6ea0:1508:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fkFvL0vwtzyTs;
	Sun, 29 Mar 2026 16:43:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774791790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbndaXZt+GV5THQ8Mj3nYnkMnYXEWuejd7pGOjCJcFI=;
	b=OpdnrRwA3SeX07BiGQwccoYywOAcE4GJQAzuR7+INv8SAOIsb2xYjENveLgIPsF7ZU9ohm
	HmAQMobR/xwPX0Rh9z+pwva+WknwM8n42NhDHvyyLuMBGKM2VlFMuwSwKlqr2bqUUQwRCZ
	xnMwjEWA0LJbIZk0yhjJyaEqzppxnXM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774791790;
	b=GAmYYG1bfZoHyIfl6+QUbDerSsN1E0oMptWmToAJ3YfxSdvVl3sRQGB5fxbUpM7z4Twazi
	nyyFLaTyHdh4FLML02UzM3lJtmyxmJ3pSKSCLsi0zqDQC5yFqpwpWtW3FJu1QJo/kDPe2a
	Hh2C6zMTEXnRlywBY2zocFR5IuOW+IE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774791790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qbndaXZt+GV5THQ8Mj3nYnkMnYXEWuejd7pGOjCJcFI=;
	b=KqiHJTCqjtym0OOMIdOjSQn4p+fH6ci7F235DfLzeGXZ5UP8bbU4QvN8q1rUyNlaI+SdJJ
	SEzQUnUfmllRxb1ikFOJyBh/PVT4EkB9EqRgr1+M/soJNofZP9Vujm9ykBLD8Fa3wiGIMy
	OUK6853Ho9Y64sqs7Xk50FJObx931PU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v3] Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync
Date: Sun, 29 Mar 2026 16:43:01 +0300
Message-ID: <5d61842fafed29f489f472bc6cb324e41f568083.1774787573.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <089f435fb4668921bb416a3d60fa0f232456e054.1774791296.git.pav@iki.fi>
References: <089f435fb4668921bb416a3d60fa0f232456e054.1774791296.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn lookup and field access must be covered by hdev lock in
set_cig_params_sync, otherwise it's possible it is freed concurrently.

Take hdev lock to prevent hci_conn from being deleted or modified
concurrently.  Just RCU lock is not suitable here, as we also want to
avoid "tearing" in the configuration.

Fixes: a091289218202 ("Bluetooth: hci_conn: Fix hci_le_set_cig_params")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v3:
    - no code changes, clearer commit message
    v2:
    - no change

 net/bluetooth/hci_conn.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8cc2cc58c3f8..3a0592599086 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1843,9 +1843,13 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 	u8 aux_num_cis = 0;
 	u8 cis_id;
 
+	hci_dev_lock(hdev);
+
 	conn = hci_conn_hash_lookup_cig(hdev, cig_id);
-	if (!conn)
+	if (!conn) {
+		hci_dev_unlock(hdev);
 		return 0;
+	}
 
 	qos = &conn->iso_qos;
 	pdu->cig_id = cig_id;
@@ -1884,6 +1888,8 @@ static int set_cig_params_sync(struct hci_dev *hdev, void *data)
 	}
 	pdu->num_cis = aux_num_cis;
 
+	hci_dev_unlock(hdev);
+
 	if (!pdu->num_cis)
 		return 0;
 
-- 
2.53.0

