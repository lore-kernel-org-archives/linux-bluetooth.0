Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.78.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512682;
	b=OhTW6AdbNsfzJXmxUlfq1gdUNv0ggKZ5sCcXOfM/CakqLHwv9owKAxMirQXZAVeNsiZk
	 pZBAgWd4zA7FkwGkLN9Njv803bGhiMbWxv0vCJluisqqT/rjb9b2RLBzaexi2pENSY+cb
	 TZ13AGhaQo8v2ET6GKoMD7Q541GSegGzAYKDSQe6FXCUqQNEWyF4mcuAD1tCXUAhncexr
	 odIu4mX/gc3PkaLljbBKsMh9UC3HAWng4a/tKby6EYEK/VISSe5FEFjztaSdnXBqw6YoF
	 g/HYxaLPSxItV0w7IEgoM6fWzN/AuU5ay9EufU3DKaF0GsLurYHu2uxLOLggc/wAt+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512682;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=l7oJgEnMllXSsAMHfGtn03t91byFAvQE4XPmvoFfsoo=;
	b=FgRol08K+0Wgy/3UkNiSvSaZGo3dXlG98ixJFXku/pEBtjlD9RZY6mNMIZUCPx2IYaBX
	 BUooyPNmY1xbZx5ahDLhwnASXlnv+gkQHtCDkpIE9dxVaWbWCIk/8uokmiQMQYJfAIxWb
	 DagwnTc53Kv3dGjFm2Kw4xoi//5zNhU/AgaHr7nxDCD7AvHLsEMLHIWovcQdqqSFpxAqe
	 oQzgeGCRLwA5qh7fWN08az+LYbpnO1wOFnhFM5xqxecKrSjHiXY2JD9aolaAIj9nAmGBW
	 y6222SNLyHF3GRzvxtK3EGfQOGytnWLbShUgpn0Jly3gKSbpi9guVPV7vNvgIvkHDHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=nEal3Rsb;
	arc=none smtp.remote-ip=77.75.78.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.78.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4CE606A331;
	Tue, 24 Nov 2026 09:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C4CE606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=nEal3Rsb
Received: from email.seznam.cz
	by smtpc-mxb-67bf8c997c-nxznx
	(smtpc-mxb-67bf8c997c-nxznx [2a02:598:128:8a00::1000:93f])
	id 6f9cc9ffd9a664e66a13d3b7;
	Tue, 24 Nov 2026 10:31:11 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1795512671; bh=l7oJgEnMllXSsAMHfGtn03t91byFAvQE4XPmvoFfsoo=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc;
	b=nEal3RsblCkMRmFJqTqCSdB0IPvWOKr69xxt+UTW4R71uL90FkSDxOBjtwx4sSnkJ
	 sOvIGrvPElI44/x4P5idmzaVevHf4f/KxwAtt14ywV/HSR+5SmpB8rpZqzWvnz8+C0
	 pOqN7fh1vt/EQTWQEJTxEDIoxl9zF8vnXbV06JUg9t3ISg0evlKPnq30vW5KpsG/OX
	 S4D0WK2fP7kPa/S59rTx4KRBBs+TiVbifraAi9eXxuJiEmwiOakx6OUZA71Rv9uGqz
	 XjHhssI39OiX07JKkGrWhZFsoTrdsesIJwdMR6A7woK8Q1l6yc35p6fU/rXVgxpPvr
	 /1tAiQ/LFt+GQ==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-584bc557d7-pqx9t (szn-email-smtpd/2.0.97) with ESMTPA
	id f5aa1c78-c562-4295-9a85-cad43979fe7b;
	Tue, 24 Nov 2026 10:31:00 +0100
From: Radek Podgorny <radek@podgorny.cz>
Date: Tue, 24 Nov 2026 10:30:57 +0100
Subject: [PATCH v4 1/4] Bluetooth: copy the peer's RPA out of its IRK under
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
Message-Id: <20261124-for-upstream-le-conn-params-rpa-v4-1-f2dd5eb41f45@podgorny.cz>
References: <20261124-for-upstream-le-conn-params-rpa-v4-0-f2dd5eb41f45@podgorny.cz>
In-Reply-To: <20261124-for-upstream-le-conn-params-rpa-v4-0-f2dd5eb41f45@podgorny.cz>
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

