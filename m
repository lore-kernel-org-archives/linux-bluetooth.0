Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.76.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795649828;
	b=2AYRZgzm4lKIGP4Ng6DajTjQwScKk6o1fEiXaaB1TlW05O+dcPkhFZ2210BHy7kJZSdo
	 MGr8cXAQEIrMFkQqNXUR5CAJVJLs/whKWgH+RAEKsWl22W5ylERvvNbUBJozgsdfY3SWY
	 XbOyCoqL2lcpLhLAx6qDXa+o/iFmK2XixvO4hPd6i5Gdy+mfjYYYnYRbwbOwdyv01BNMU
	 bDpZfKdPCfAMSHMFgXzLDlB9jVYzTUMaad2jKINudyVquTi9WglEDeRfXKA4d089jC0nc
	 ImIeapYGTNG9W5QyxRwAne9Mhp6d1GNQ1XotlDq3CDIfyehAyH+8KPkeLLTmEKDm+FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795649828;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=l7oJgEnMllXSsAMHfGtn03t91byFAvQE4XPmvoFfsoo=;
	b=NTk1amTSboebt5jbIPlMJE1a2Q7FLQl0eReICB2MO+xT1S0PU2Mlu+LaXRg4k2JFmPu/
	 0+8BB9mjhyea/MdBmF1qAGCwnQTJYn1tXQdnGSER+HLubFGtyrrDaEpTbVOXX5HZud8+O
	 o9Pj/2db/7z9yMidkxQ3Lf2R2QXZ457lfPjVJRrvlBYVuLnN/Kj2b0s2fHmPyh+6XQs3t
	 aFmWj4/PCFZx43MvyUgwqMpG3wq4TtlA7befVWqOxB9sclWj+cJEVsZnSzJJoP4rFVNrM
	 qIOjje+aB/N8ba3kpYUXrUNcoUMaSYN5/tfKnPNJ/Aa5ey+01G/vzfCvXGO2GnZWdTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=zaxFJFzz;
	arc=none smtp.remote-ip=77.75.76.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E75606A31E;
	Wed, 25 Nov 2026 23:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48E75606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=zaxFJFzz
Received: from email.seznam.cz
	by smtpc-mxb-5bd84c9575-j92sp
	(smtpc-mxb-5bd84c9575-j92sp [2a02:598:96:8a00::1200:505])
	id 5af8826becc22f725f779823;
	Thu, 26 Nov 2026 00:36:59 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1795649819; bh=l7oJgEnMllXSsAMHfGtn03t91byFAvQE4XPmvoFfsoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc;
	b=zaxFJFzzzP+j/+U77L1/UFldd91J3lZbRTpWhcKZ6UYCch2yC81POncw+4acStTOj
	 GgUQQky/VWIYrQ9SejNgr3LieGAybBlWGHRvCAYvC7FTx+4bM5n/BMf6FloRuYQJ1O
	 uIftCbir470KZq6mMACAebkO12Mvh0523SBzA5982TtEXZ8o0ax/30YeRUTe9AR/fO
	 2PywS92r9oRdhwPz/Je4xMoIpgsNKbW2qTqODhyfIwquVHNO1/fmihK0Dg+uT5gSLo
	 prt0CS9mwouh2/xDRf9LZ353PbMJB1yHpzsZUeuhCb4IKmTqOONgjOCDovcdfz3uHr
	 O4AbL1vgfY8oA==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-86b589c786-pdzw7 (szn-email-smtpd/2.0.97) with ESMTPA
	id 74ad5d32-a6d2-4519-916b-5c585896daed;
	Thu, 26 Nov 2026 00:36:52 +0100
From: Radek Podgorny <radek@podgorny.cz>
Date: Thu, 26 Nov 2026 00:36:48 +0100
Subject: [PATCH v5 1/4] Bluetooth: copy the peer's RPA out of its IRK under
 RCU
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-for-upstream-le-conn-params-rpa-v5-1-b7f015a35023@podgorny.cz>
References: <20261126-for-upstream-le-conn-params-rpa-v5-0-b7f015a35023@podgorny.cz>
In-Reply-To: <20261126-for-upstream-le-conn-params-rpa-v5-0-b7f015a35023@podgorny.cz>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Johan Hedberg <johan.hedberg@intel.com>, 
 Jakub Pawlowski <jpawlowski@google.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Radek Podgorny <radek@podgorny.cz>
X-Mailer: b4 0.15.2

hci_connect_le() looks up the peer's IRK with hci_find_irk_by_addr()
and points dst at irk->rpa, which it later copies into the connection.
The IRK list is RCU protected, and SMP removes and frees an IRK with
kfree_rcu() without hdev->lock, which is all the caller holds, so the
IRK can be freed while dst still points into it.

Copy the RPA out under rcu_read_lock() instead.

Fixes: 759331d7cc66 ("Bluetooth: Fix clearing SMP keys if pairing fails")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
 net/bluetooth/hci_conn.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 0b76df1bc5fd..8638b7f8dee3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1526,6 +1526,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn *conn;
 	struct smp_irk *irk;
+	bdaddr_t rpa;
 	int err;
 
 	/* Let's make sure that le is enabled.*/
@@ -1564,11 +1565,14 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		 * be resolved back into the original identity address
 		 * from the connect request.
 		 */
+		rcu_read_lock();
 		irk = hci_find_irk_by_addr(hdev, dst, dst_type);
 		if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
-			dst = &irk->rpa;
+			bacpy(&rpa, &irk->rpa);
+			dst = &rpa;
 			dst_type = ADDR_LE_DEV_RANDOM;
 		}
+		rcu_read_unlock();
 	}
 
 	if (conn) {

-- 
2.56.1

