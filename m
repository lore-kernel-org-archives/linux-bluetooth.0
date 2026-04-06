Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5D63128A2
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 12:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775477186; cv=pass; b=ROGd3QtBGsvo2m+s2UgmrWJmPKQkHDLziLXDH5ls5lk3CdcLZeUgPrfu2s5Dqj03vWf+BoCfUIjGbPzP2iZysHEEfH0TTQYlDbKcziobOjswfRqW//xJdWmwjtpfBca0MrqhlsfmBZJsX6eHopY9hHpkUC8cJBv7pAwFB5KBRuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775477186; c=relaxed/simple;
	bh=GiaDKYxruZQS0EcDtSxt2ELnfPUNDSbNelcMw138VNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IfPtqopLH6Ulv9uRB/Lvio+b/3cp5uc5GShVPEHorOGLaGCM3koCRDg1+zPNRpHdhlNq9wltMVSrRUqnWsvj41QmRLkMNLjAMoN+gJC0hi0s2OPDidfq6z6IO1b2xkaqqiyErc9Y4/ZIGvz9KrORrXnsRQRh9R5TO5A2ycuFZ1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=rZwF/S8+; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="rZwF/S8+"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fq7My4HFXzyTm;
	Mon, 06 Apr 2026 15:06:22 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775477182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=un8NpWu2rCVSy4N/gj81BxWbldMz/PkZb6wxxEi02MY=;
	b=rZwF/S8+tSFbA1ig9IV8HyDCDUjOb8MsGy7J3L9B56x//jzfl1XHU/lhmrL60OS6iEy/f1
	W9l4tqgES0qxaIvGmrmaY3+4CX+CjJnLmDluDLqO1gbxli5Z9kRq8No/uil3vIvrs8pi2s
	2q3ySuFS4K2Lm2icLrKJ8pnNYEb552s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775477182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=un8NpWu2rCVSy4N/gj81BxWbldMz/PkZb6wxxEi02MY=;
	b=bbJu8AmIC4c0ovHBjof1xK5XV7KPXPkpn513GOEJ1d2uklUGC8YKwmNCjvrgpkV1Y6o4WC
	lK/wvXEZAlLK/D20Eg/BxbZoMMen4oLn05LoTAs1XqRInY8hSbEmy5KYh8A4gM2rKZJNBJ
	MQ9Tm3T8lITZx/wST7Bqy8801cd2avw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775477182;
	b=QerJP4sLQgJoyEaYbkG84SnjwWTDiLhLpOWKQuxbxRPTTWwwEa+VKwwxktz1RkDP8meYSR
	BB4rLnQJ0XxGHyYl0XVFuso/uq8pbrxQSmEZSFRCWeUlYBcVeIaz3UKi8CfZPcCRlHpOac
	dq0y2az3gGBXzq5lMC1p9KMOgXyyBgQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/2] tools/smp-tester: don't write array out of bounds
Date: Mon,  6 Apr 2026 15:06:19 +0300
Message-ID: <2ea7fb22224bbe69de6bbbd93f9d18f0cf5045f5.1775477129.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix accessing pdu data out of bounds in SMP Server - Invalid Request.
---
 tools/smp-tester.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/smp-tester.c b/tools/smp-tester.c
index 6c3de6451..04b7ee088 100644
--- a/tools/smp-tester.c
+++ b/tools/smp-tester.c
@@ -536,19 +536,25 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 	tester_print("Pairing succeedded");
 }
 
-static const void *get_pdu(const uint8_t *pdu)
+static const void *get_pdu(const uint8_t *pdu, size_t len)
 {
 	struct test_data *data = tester_get_data();
 	const struct smp_data *smp = data->test_data;
 	uint8_t opcode = pdu[0];
 	static uint8_t buf[65];
 
+	g_assert(len > 0);
+
 	switch (opcode) {
 	case 0x01: /* Pairing Request */
-		memcpy(data->preq, pdu, sizeof(data->preq));
+		g_assert(len <= sizeof(data->preq));
+		memset(data->preq, 0, sizeof(data->preq));
+		memcpy(data->preq, pdu, len);
 		break;
 	case 0x02: /* Pairing Response */
-		memcpy(data->prsp, pdu, sizeof(data->prsp));
+		g_assert(len <= sizeof(data->prsp));
+		memset(data->prsp, 0, sizeof(data->prsp));
+		memcpy(data->prsp, pdu, len);
 		break;
 	case 0x03: /* Pairing Confirm */
 		buf[0] = pdu[0];
@@ -686,7 +692,7 @@ next:
 
 		req = &smp->req[test_data->counter];
 
-		pdu = get_pdu(req->send);
+		pdu = get_pdu(req->send, req->send_len);
 		bthost_send_cid(bthost, test_data->handle, SMP_CID, pdu,
 								req->send_len);
 		if (req->expect)
@@ -756,7 +762,7 @@ static void smp_new_conn(uint16_t handle, void *user_data)
 
 	tester_print("Sending SMP PDU");
 
-	pdu = get_pdu(req->send);
+	pdu = get_pdu(req->send, req->send_len);
 	bthost_send_cid(bthost, handle, SMP_CID, pdu, req->send_len);
 
 	if (!req->expect)
-- 
2.53.0

