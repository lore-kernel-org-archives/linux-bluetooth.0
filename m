Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37460343D63
	for <linux-bluetooth@vger.kernel.org>; Sat, 29 Aug 2026 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788043694; cv=pass; b=S8PgHeSNI16ybjUSQDDIVY3Ur3uVKFsgO/k9X45bAjuqKcJWLQ4+N1Pwqgps8wuMScJ0YCxZvjEK3rEfCs5CAn/0qgd270ze3tyQDj0mUtOKu9n2YBOs1AWRcrGh4ldjBiYoW1MiJMC69+wcs6JPg4PChbKJSKLPfLcF9SFiV7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788043694; c=relaxed/simple;
	bh=066C5kCrC9z2LYxg5QD6zxRDW/gBhnbW/aEm7xyeIEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZDu/JijDe5H1l4Gsn7XxvJu53SueXe2NcqwAcImGWaqFD6rqBkCfGD/oI0kNCJDqWiZDNGmKVxMFl0U/9QAyXe56nc+XvfH2+SZptXzCiEkEUWr386NOobW1oRDK+beWTTmIrjpXps7T1XK1Zf0scf+P+9iG9Q3OR2IFNa/p3nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Qo8i5Nek; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Qo8i5Nek"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:e011::d701])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hXVlT5r65zyS4;
	Sun, 30 Aug 2026 01:48:05 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788043686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Er+tl+WsobQOfmqWyHtXkm0MWfPhIRno7ye+gX6uUpY=;
	b=Qo8i5NekrQXKUVsmezun7D+ME7f6snW7utNEPrvMd+CklQf542DvaxazsiZHLyrXlJUozL
	Zmvc8whM2U4YRMyXbSKG615ZcGmooK916dpFGnNDYsbZQIJeuWh4uhV9YDmPhh47602D1V
	8fe46KV3lc/vjMrWpepLH0ansOKY5sM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788043686;
	b=dABP7I86azu9wagtO2fq7uNH09xE5cxHljMuZfo48U9XNiWRlBu8x6kG3GT2U8a0hbEMY1
	V9vdCK+U4Hlp4Uw4slBQaM9WDtGuayQkzUCbw6WNz/l4Fns8IxsiIN1JpVbjekPdPmXLsr
	xtB3REOLilKSuEkZZcJpYyhDfH3aieI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788043686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Er+tl+WsobQOfmqWyHtXkm0MWfPhIRno7ye+gX6uUpY=;
	b=OdALdD84TfLkNCM5VT4uEg/Na/FFT8zOXdj6eGWSf7F/obL/FUI3+vTQ5trE21mD9nmp7v
	E9KGqyjHEbPQtDV5hJh6bbrml89tcjAbIec5Zxso3+j1FA31FToJEutS+bfiI5UDERkje+
	MefWYVHn+L0AyhLIcK0ChP5f68kpGuI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] emulator: bthost: don't crash on ecred_conn_req with too many scid
Date: Sun, 30 Aug 2026 01:47:58 +0300
Message-ID: <fab8ccab695b50d726bdc00423d8ca915edcf11e.1788043574.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

l2cap_ecred_conn_req() crashes if the request contains more SCID than
specification allows (5).

Respond 0x000C - All connections refused – invalid parameters to such
invalid requests.
---
 emulator/bthost.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index 46c6a52f5..d23b709ea 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -2607,6 +2607,13 @@ static bool l2cap_ecred_conn_req(struct bthost *bthost, struct btconn *conn,
 	len -= sizeof(rsp.pdu);
 	num_scid = len / sizeof(*req->scid);
 
+	if (num_scid > (int)ARRAY_SIZE(rsp.dcid)) {
+		rsp.pdu.result = cpu_to_le16(0x000c); /* Refuse all - Invalid */
+		bthost_debug(bthost, "invalid ECRED_CONN_REQ (num_scid = %d)",
+								num_scid);
+		goto respond;
+	}
+
 	for (; i < num_scid; i++)
 		rsp.dcid[i] = cpu_to_le16(conn->next_cid++);
 
-- 
2.55.0

