Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB1C1E51D
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 21:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740691714; cv=pass; b=dW/Dw3j590VY6ErYV4wTPeZrDeS7W3iptuPvpT5WUXBw3xcyc/cLaSNScXm4PEzfFiFM+zEru4piCSx7Co2m68XfD3hhVq2DCRzXMKVG9Zzx8PfahHYa6nsfclgOKvkvElMESASLJnVaVX8fI7l5PoXOwRjYizH6W6BJO9ZvOC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740691714; c=relaxed/simple;
	bh=M7wNQ2vR6iQH2+CjLmR7r6YT2clAUqSR5am1IyP/AtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sn+72Oqtz36K3hvnU8yn6SIA1FnQNAKuMBRBiImIYxXW5JpDAIHw4axuKBHfWHsymBANORGAQRgdmjAouPFNXOyexDiBe+ZVbANTSdA1IOefDvhHxLwQ2tqKb5R496kshNioTsoLUSz7mD6rpk+aP2NC4itV70zlqIczFvMiTPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GRb4oTxD; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GRb4oTxD"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4Z3kwP6kfkzySr;
	Thu, 27 Feb 2025 23:28:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1740691703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rcc9NPbvDDs4USL1oA9pK81glONRSShaue6BStwAC0g=;
	b=GRb4oTxDZAQwEKxj5LpPK/EXglFZ2WdoisjIC7NcvDZIS7zXzG6fKNk4mhD5guvBEznUUL
	eGr65P3y5XcIrblg590/k+67XseqJENFSrJiK3zyiAw/xQKXtSbaZzGgTails1dOaTopQH
	ua8w92GxXZZrxYQhsBppXsEUKz7Us10=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1740691703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Rcc9NPbvDDs4USL1oA9pK81glONRSShaue6BStwAC0g=;
	b=SRPA5kVjTYcJRB4diuz/RmDHL7dB2E2XS0AC7jq7IyfCqxloYcXWjDYBeib6n7wRhXQ0mr
	YAMe2L6Yr0F65cJTD4Qk1a7A6SUihbk/JvxBNA7Y7Or0Z5UR/YIwrQb+4efhX2QmkHSF0n
	pdKn+E8aEMnSdSTMxdEKdYkWeoOG9OA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1740691703; a=rsa-sha256; cv=none;
	b=t7346wRkEEHuR86fgQ/72bIw7zgvEPh7JDLflYc/tpLh5Ru9ShBEfuVsDwvOFhD9vxPDHy
	KngE3VKMkbeZr5d6+ONOCWtHF0hMPNsqZpeyeQZf8HoSlID1q7JmU5q2heGxps3QW0ln5V
	GHZQLN2nVKPhmJTXDc5K52ilFCvnrZo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	eadavis@qq.com,
	luiz.von.dentz@intel.com
Subject: [PATCH v2] Bluetooth: SCO: fix sco_conn refcounting on sco_conn_ready
Date: Thu, 27 Feb 2025 23:28:15 +0200
Message-ID: <24279b4ca58e92b96fbe8f8214bf95d485ab73f5.1740691671.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sco_conn refcount shall not be incremented a second time if the sk
already owns the refcount, so hold only when adding new chan.

Add sco_conn_hold() for clarity, as refcnt is never zero here due to the
sco_conn_add().

Fixes SCO socket shutdown not actually closing the SCO connection.

Fixes: ed9588554943 ("Bluetooth: SCO: remove the redundant sco_conn_put")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2: missing signed-off-by, add sco_conn_hold() for clarity

 net/bluetooth/sco.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index aa7bfe26cb40..ed6846864ea9 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -107,6 +107,14 @@ static void sco_conn_put(struct sco_conn *conn)
 	kref_put(&conn->ref, sco_conn_free);
 }
 
+static struct sco_conn *sco_conn_hold(struct sco_conn *conn)
+{
+	BT_DBG("conn %p refcnt %u", conn, kref_read(&conn->ref));
+
+	kref_get(&conn->ref);
+	return conn;
+}
+
 static struct sco_conn *sco_conn_hold_unless_zero(struct sco_conn *conn)
 {
 	if (!conn)
@@ -1353,6 +1361,7 @@ static void sco_conn_ready(struct sco_conn *conn)
 		bacpy(&sco_pi(sk)->src, &conn->hcon->src);
 		bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
 
+		sco_conn_hold(conn);
 		hci_conn_hold(conn->hcon);
 		__sco_chan_add(conn, sk, parent);
 
@@ -1411,8 +1420,10 @@ static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
 		struct sco_conn *conn;
 
 		conn = sco_conn_add(hcon);
-		if (conn)
+		if (conn) {
 			sco_conn_ready(conn);
+			sco_conn_put(conn);
+		}
 	} else
 		sco_conn_del(hcon, bt_to_errno(status));
 }
-- 
2.48.1

