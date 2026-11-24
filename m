Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.75.76.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512683;
	b=IP3hteoSAPZoHdfjZzHf9c5umF0CCkpmiXWQg1DtXBBLrXQJGBz04wlR0C4JOltcy4tP
	 mh1XJFfkaP7PLgmwk3mkAELPuLWnr8y3BQxkEFGt8ZMfOGlC000E0M4Z6VHxza8xh5+Wl
	 7a3emoYWRPJ4iz0wRliCczcuIejS6LyWadKN0cOfRd7GGCJBlGtZ9B2qQCjF8MVTiYZV4
	 083Di8GebLu3exxJlt/WD+GVy5468ifVy9plzttxY1vSwQ3ZGCVx4DTqEajBH4Yg/YUdr
	 BHGRqGYRzH+92LvdEYQTWVu2XuJ4rqbMfue+OS7NGh12AAYxJK8rTfRz5OJuiJEqkaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512683;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=E/vY5+juqBKGKVLd19Cts9FnfOJW38omoiBgC93MpJ4=;
	b=s5tmmIFAKIB4Rg7iRwIRNe7NZSmGFA5z5IAJdfeQDzFmOULBSCEYPikaO2RFmDtaGXoR
	 /cuJojPnVEos8aqdNS7UmTa8OA8zOAFSVzxLyL0UvyONJFo6xXemes15EHZNzXn363HaX
	 mY2PTOt2FvPj6qWyNZ+wcqGPUjZC5X2yJMEBdZurlhMkifDzv/TOvKv7xUNP52MQdCdQY
	 f1+umyst1f6rSZkXcrtFEf87gpg4zIVz/FGqaL6vY55qb1OaiDaCC0RP9Ew/yLFkp6sAK
	 IgMMy6vneBXeKpcjg7nCZfkxvgCkmYxCDea2gHUIXfU7Be7PhUUXYKaka8j+einXCgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=podgorny.cz;
	spf=pass smtp.mailfrom=podgorny.cz;
	dkim=pass header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=jaz+zoSj;
	arc=none smtp.remote-ip=77.75.76.89
Received: from mxb.seznam.cz (mxb.seznam.cz [77.75.76.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF36606A326;
	Tue, 24 Nov 2026 09:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CFF36606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=podgorny.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=podgorny.cz header.i=@podgorny.cz header.a=rsa-sha256 header.s=szn1 header.b=jaz+zoSj
Received: from email.seznam.cz
	by smtpc-mxb-5bd84c9575-j92sp
	(smtpc-mxb-5bd84c9575-j92sp [2a02:598:96:8a00::1200:505])
	id 20729de0964830f925fd87a8;
	Tue, 24 Nov 2026 10:31:14 +0100 (CET)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=podgorny.cz; s=szn1;
	t=1795512674; bh=E/vY5+juqBKGKVLd19Cts9FnfOJW38omoiBgC93MpJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc;
	b=jaz+zoSjvOWbDU3OO3qdmvgSl+UuEkHB395i9UYgmqCge+2UopWRUWbAdIveHZzFV
	 MvHCEUamsXgBG5W5NtxAD4WnG11k0Pk70euxK8fXtwknqCEL61pRcOOJIBwyo0X63E
	 NBcMWAIZf+o7KanXMz2txX7HBqFnQM85fW9/1XnwZ1WbdBYDMHW6dazDkrzfF0SrMT
	 qW9s7VQemsdhvd0YWixwBPfaTOrUJmDdWBTEMoATGyxf6U3zMaWntCLBJ6x3W6Ky7i
	 RbINOLyRLQzQMNYp8hqCg+jvK/85vWCd9H4LnMJ8BS9HSblSnw2epEcHcl29TzvUDl
	 5KsQXTV3ewQBA==
Received: from [192.168.31.57] ([2a01:9422:904:1ee:e65e:37ff:feee:e29c])
	by smtpd-relay-584bc557d7-pqx9t (szn-email-smtpd/2.0.97) with ESMTPA
	id 93b309d2-9b89-4c4c-a118-6755e88030bd;
	Tue, 24 Nov 2026 10:31:01 +0100
From: Radek Podgorny <radek@podgorny.cz>
Date: Tue, 24 Nov 2026 10:30:59 +0100
Subject: [PATCH v4 3/4] Bluetooth: refuse to dial a peer whose connection
 is under its RPA
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
Message-Id: <20261124-for-upstream-le-conn-params-rpa-v4-3-f2dd5eb41f45@podgorny.cz>
References: <20261124-for-upstream-le-conn-params-rpa-v4-0-f2dd5eb41f45@podgorny.cz>
In-Reply-To: <20261124-for-upstream-le-conn-params-rpa-v4-0-f2dd5eb41f45@podgorny.cz>
To: Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
 Johan Hedberg <johan.hedberg@intel.com>, 
 Jakub Pawlowski <jpawlowski@google.com>, linux-bluetooth@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Radek Podgorny <radek@podgorny.cz>
X-Mailer: b4 0.15.2

hci_connect_le() creates the connection under the peer's RPA when the
controller cannot resolve it, and the connection stays BT_OPEN, out of
sight of hci_lookup_le_connect(), until hci_le_create_conn_sync() runs.
A second advertising report in that window looks the connection up by
the identity, misses it, creates another hci_conn and overwrites
params->conn.

When the lookup by address misses, look the peer's connection up by its
IRK and refuse with -EBUSY. That includes a scanning connection: under
an RPA, it has either been started by an earlier advertising report
already, or it belongs to an explicit connect made before the IRK was
known, and so to other params, which taking it over would hand a
reference they do not own. In that last case the explicit connect can
no longer be started either, since the peer's advertising reports now
resolve to its identity, and auto-connect to the identity waits until
the owner of the explicit connect gives it up.

Fixes: 4914c4998961 ("Bluetooth: put the peer's on-air address on air when we cannot resolve")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Radek Podgorny <radek@podgorny.cz>
---
 net/bluetooth/hci_conn.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c1583cb6c28a..791df930650e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1600,6 +1600,15 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	if (conn && !test_bit(HCI_CONN_SCANNING, conn->flags))
 		return ERR_PTR(-EBUSY);
 
+	/* A connection found by the peer's IRK instead is under one of its
+	 * RPAs. It is refused even while scanning: it has then either been
+	 * started by an earlier advertising report already, or it belongs
+	 * to an explicit connect made before the IRK was known, and so to
+	 * other params.
+	 */
+	if (!conn && le_conn_lookup_irk(hdev, dst, dst_type))
+		return ERR_PTR(-EBUSY);
+
 	/* Check if the destination address has been resolved by the controller
 	 * since if it did then the identity address shall be used.
 	 */

-- 
2.56.1

