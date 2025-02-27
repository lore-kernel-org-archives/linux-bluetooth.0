Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E951D26FA66
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740687117; cv=pass; b=hsbvZtBfnC4KwcsqN4W+gyhebbdrMPXicq2ZtniXkzd5A7xNxBdu2ArhFvhC1jlQ5B8/hBcqr2NxEu4G1tEjjoKqp3hVl5e/LcdchF8tT5As4THV2ywvQosVp9+AQicGV1h5UYKSzWTzdT81cJxG3vCXmCNp2bLlBaWf0MrjkDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740687117; c=relaxed/simple;
	bh=GC5yKdZxbRS4+k0yr3zGaZULX/TLjUfiN2iAku5dfU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mnGAMLd983Ry2Flr/0A9ohx77Jibbe5zZJyJd3gZopSenvZ2RJG57MwFZrx67UPlo1kBY3tHJHLC01yc7QRGhueooiy0u/0oFQIQaTrOwnq2R1lbfUXRAViDfzCDrPqgruq4oJlW0Vbpm6ghpaCIEHGvafo/+gcix6eyC80Urzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=HfYuYUiM; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="HfYuYUiM"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z3jD56zk8z4BKGt;
	Thu, 27 Feb 2025 22:11:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1740687111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rNazFXBG2ck38umknB/JMmo6zena/7cLmnXUFxVZfzI=;
	b=HfYuYUiMUPodJubtS70IYRMW2Hm72TZAppniI0df8uH8OkLwqtlltwKf99Uqk/xxyyHT52
	rOFp5dzsf1SPzc4glI9i4lXhEjKt+kbJVABrPGOypSyNZZN6Es0EUnKBU48dElwjQNWE/S
	YgwpgGMpXBe0aDTXbGVXe9ktrJ12R3pDOJzn1xFw2WsyyaOrE47hSslv8DEL9mg6PsAUON
	Q+QycUz9TEuYaw1yMBKVWEh/nP4PW4x/JYqDdfbZPhvsTbPGuKA5svoqRBN0+8O9S5Z2T9
	WrnWBVDcqmVXy+Kj2PHa53SFh5cpo5/Tt4G4gEGamA4+mBB5xUo5RgMARYKzaQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1740687111; a=rsa-sha256;
	cv=none;
	b=dQZM/gNZKZYiHg2slZ054mjv/+tLTGF9r+uqV4APaXOorQb8jnhl5daP5u86y/5QJ5DdbC
	zFOR1fxCoe6EbtGNLUjnlJb3OePeyo802fBoGHUWhGlCkrnDlqZygwDJtdegxdpUNkGMtI
	dCOhlNJwrosarcurnEFTmYEeNx1cWgpPwAJ2rZazysFNARfg7mKDoUwTuL4R8/FzoOs6RI
	OLx/4++SHChau7QksxT6wyPbPQH8WX0K7eE3V+/zzISxjTwg4PWrf+WbRA0q2N5+BwKzZF
	fwkuYUnXX3/q24MtkUH2xw5QhdpBpBaCWhuIWeAHPx3nWAwxQwTjBZb5wMnyjA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1740687111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rNazFXBG2ck38umknB/JMmo6zena/7cLmnXUFxVZfzI=;
	b=HuuTFms17A3pBebzm4AfQ9uvqSj4xrveTLyZltzA960N31FbuE9SygrCGtWzZYUQI/2YrQ
	vnPGG64hFKf8GDke/U4bvEh/K5zgejurYBfwW0uw8ETK6bk9ebYf5X7+vXwpJ5LJra5tmE
	wx+OiVkYXAZAH7fNr3jlaFcVUpi9NSBid5moNH6id8hpwIZ2W2/5sXi+nKsZNA8IeBQetl
	UkxvKpIEabX29wh78WUQjlyEjlZd+/G3kFj8mBbnZRNbpEP24ImITazLVGafPvkTzSLEYI
	mixc8qqWVD8n2F1/wXx8L0GuoTLC8znw4N2jpMEbzvNwRrNJg5ctbenHJ/jLeQ==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	eadavis@qq.com,
	luiz.von.dentz@intel.com
Subject: [PATCH] Bluetooth: SCO: fix sco_conn refcounting on sco_conn_ready
Date: Thu, 27 Feb 2025 22:11:44 +0200
Message-ID: <dd9eaa0aee1e2fbeeb2015b807a3a2701af3a1bf.1740686998.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sco_conn refcount shall not be incremented a second time if the sk
already owns the refcount.

Fixes SCO socket shutdown not actually closing the SCO socket.

Fixes: e6720779ae61 ("Bluetooth: SCO: Use kref to track lifetime of sco_conn")
---

Notes:
    Making the sco_conn_add refcounts consistent in ed9588554943 exposed the
    issue here.
    
    I think this should fix the situation, but didn't yet test this in real
    use, only the sco-tester test case.

 net/bluetooth/sco.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index aa7bfe26cb40..ad09b1b8e89a 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1353,6 +1353,7 @@ static void sco_conn_ready(struct sco_conn *conn)
 		bacpy(&sco_pi(sk)->src, &conn->hcon->src);
 		bacpy(&sco_pi(sk)->dst, &conn->hcon->dst);
 
+		sco_conn_hold_unless_zero(conn);
 		hci_conn_hold(conn->hcon);
 		__sco_chan_add(conn, sk, parent);
 
@@ -1411,8 +1412,10 @@ static void sco_connect_cfm(struct hci_conn *hcon, __u8 status)
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

