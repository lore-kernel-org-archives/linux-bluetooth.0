Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDDA42AA5
	for <linux-bluetooth@vger.kernel.org>; Sun, 16 Feb 2025 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739720947; cv=pass; b=V7BgKZTCgQ8yos35ZjwkpzQ9R13vrAPHfbtkOeil37X6eC/w3V+Rxz5tvenk8t0LZPk/ML6YhXDdD6GuKO8UUr7oXJM/Vm2qki8TzA+RJH25yfNGFf3cvQgsxhY9Zos7fwLiuocuCjRx8ASMq7EvEyt4nwdxxwNx45ING91OlMA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739720947; c=relaxed/simple;
	bh=gYSKsawVk4aJRtX1Y13BpduMO7F67Id14OhxngQ1tOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K3ajPApAWnQ5OgLlzb3RelHSfFnmEJcxGbJBAnG4xk+iku2D1nRTnoxx6Nscu3Vjj+Fv5Pzfxjulm1xFTdhmKtWjHQ9P4we2Qgo+UPyGFjOGB0i5L9ANhowPNM7i6k+4QCwIPwv3ULEpEArtGLMfF2yJ1scY4XTCnl0eEwe2Vao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=a2wgcy5x; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="a2wgcy5x"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Ywqvr5H9bz49Pxd;
	Sun, 16 Feb 2025 17:48:56 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1739720937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DlZUd2wHKkDklwGNPCkzpSzDakK6pqWAUEUygtagjAM=;
	b=a2wgcy5x4RnCgWia4OWbNwmbrZKf3T57WbgCdny6f5fD5i0R1WhPyCcZruMt7IjAB0+62H
	UxP3cU/hDwxW00XXxBKLlguDnabay3aLI3xjbJxArCq28gBDMkPO1CKw5gfoUOivJivI5W
	2P1hmPTRR8dfmTw2lbBNuaxXTSDCdyYJaRnGSvLosCaQ6wZwJY3M7vDGfI4Y6MN8xw7OYj
	08ocO1BkkqblZcw1gKp98JPKLOi4XTpFl0CAf7BxhkMp0dIeKJs1t/VQoa0nrutJt4eQpA
	e/1fIemzuNv74Rs8rRm1WBsHOIzogu+DNztnl/v3NL+Ni40Dq93dZB9CANB1xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1739720937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DlZUd2wHKkDklwGNPCkzpSzDakK6pqWAUEUygtagjAM=;
	b=D90nbg381dmE1y/SkGnT+5HDffm4RmbVVXTKosjP+tGmxZQdYP21DkUOlTy3pSTeHC3pPj
	M9KUTAyUNbyD65QvSU0wJPdXL+mUGQ1HtUF5kBcUoaJAIhelH1T/Vi66WcigeNYcjiny83
	XdscOjizHqyqSO+1kHsnPRjSVUq7t4/FD/5RrY1qK3/KUHjF2E9foLZVeD0xtcPDCfI26G
	Wy8rhjXRsUULqu1LVvfn7DaVMNBq+4w4LNxloh3AGF6bCq7flA8dSvSAUQtuRapjBjMP/a
	jHdMLpZEXPUAkxXEkhT7ULY4hXsV6AFS4WaSJec+r9pXX9qKEaV4kkvSbgxRRQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1739720937; a=rsa-sha256;
	cv=none;
	b=o7CL4C2h6UzOrNZt8aV7yUdvFnc2Ala7MnpO11DMV/R+tbs0R/bO2aXQzHoB/Kk0Ev7gMM
	ZIKD9j0NoHwc2XqY6xuI0fpCbccR3wU82yUGt2HzPHiTWVoZFv9hOVNsgNEumQYT3b4ksP
	ocCDmSGP2XO6cdTUAkPzWXmiFz6C7/g4MemZt0T/3CWQBbBzURnJgPZ/ba9GXv88LJNoSf
	zYyStfHbq/4qGFTOOj0m+2CgGXmIw/8zg9EBvd8/HMp+uwcnwxFaFkbpuxdDhdtdbe9jCJ
	aZ+hEh6GFubGkoD6bPEvBT7BsDslW8XjuOqsAlgt2sqkcg+SxnlgIah5o4+1Kw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/vcp: fix setting volume back to current value
Date: Sun, 16 Feb 2025 17:48:54 +0200
Message-ID: <11cdbf4619d9eda9cd40c84728a2f5cc87d42d2e.1739720857.git.pav@iki.fi>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is a volume change request in flight, always update pending
volume. Otherwise, setting the value back to old value before
notification arrives, is wrongly ignored.

Fixes: e77884accdb2 ("shared/vcp: have only one volume change in flight at a time")
---
 src/shared/vcp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index f0887ad62..321686774 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -2119,15 +2119,15 @@ static bool vcp_set_volume_client(struct bt_vcp *vcp, uint8_t volume)
 	 * the current one completes. This may skip over some volume changes,
 	 * as it only sends a request for the final value.
 	 */
-	if (vcp->volume == volume) {
+	if (vcp->pending_op.timeout_id) {
+		vcp->pending_op.volume = volume;
+		vcp->pending_op.resend = true;
+		return true;
+	} else if (vcp->volume == volume) {
 		/* Do not set to current value, as that doesn't generate
 		 * a notification
 		 */
 		return true;
-	} else if (vcp->pending_op.timeout_id) {
-		vcp->pending_op.volume = volume;
-		vcp->pending_op.resend = true;
-		return true;
 	}
 
 	req.op = BT_VCS_SET_ABSOLUTE_VOL;
-- 
2.48.1

