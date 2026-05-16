Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465703D47AF
	for <linux-bluetooth@vger.kernel.org>; Sat, 16 May 2026 11:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778930105; cv=pass; b=tq3mJUuNXGgWKytaTMrHMAF5bg/nXCFaKViAJrWLxZ29cW0FKLofzOVa+WF0YUNDoBejSIkoTdqpPKeL+18pTRQ/ILAo0PuxijZr5gD9zSxEIJRIVo0iwTRRMJta9NXPs2aUKSUYwp7GV15Nldhzhz0vQqjIrs+TuFpmzDSXm0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778930105; c=relaxed/simple;
	bh=/Rbo7TpbjzghAVsxFpPiOKTl5rnQNfqyXBiggM2hs1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmZUWsASObGwv9342PsOybAxGj+kUYb1ZnFHZXN9ucyKVq8DTJMpcuPnMLqd8e3imu8Cht1tsF50zrq/1FJciOrTfslMEc4g5w6uYWXhf/GjODsxazBHMHbMrE5SC0kFGV9Tef6YFK+9Ct9Sx9yN/u+gcPedvtAtuOE8fAjF49k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=iZye8d+J; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="iZye8d+J"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gHhL84cvBzydJ;
	Sat, 16 May 2026 14:14:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778930097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyCVYdMFbcquXByPI4NBrQXenyDtFxcc296x9QAlozg=;
	b=iZye8d+JgRz0WymvuIWSFAtCK4RpyOQN8oadn+NDUhu0Jo+oiBsOcEwu+O1SfVV0OIWHHi
	iIoqN/HVYs6wD/oV+HCczZ+tt4ULA0or65N9ITY+2OENSZhtxP/1MsTkJbtCGF4OkuSbZ7
	VY+01iGHS5vi8deceQ/UEQ/nZUpD/9M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778930097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QyCVYdMFbcquXByPI4NBrQXenyDtFxcc296x9QAlozg=;
	b=Iqza3IpuS1xUJhFnT/VVuXsSOCDW2Viu1JSyCJiCXcFq21M29s5cPIReiB1LDGJAdLdjNe
	PmP1j/MXTzsmgVrkCas3FikYndIwj9ZthC1pbzNj9viunzKhF80zCICWptCd1xLjHXaRex
	IoKc1Be+qRfin0YjCUqDjqlX9Ahw65I=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778930097;
	b=LdCHu4Ik2emh5VDdM90o30TDTuviXO9cVeHtf74Y4WKo4t6aHBxbKLECb9Y5ma2i5rPGcr
	heD2DMGzNaEdA22xaIu0I8x4C3A0I5Ppg5tkTSGK6ZdPwLf46Za2qpSA6viPctPXQbADBu
	4c7tRHEG1VgFNEfmKUEvIat/raayitE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 4/5] Bluetooth: L2CAP: Add minimal context analysis annotations
Date: Sat, 16 May 2026 14:14:36 +0300
Message-ID: <ec6d9a59a3ce5bff8fe21402fb4f320fd7f9e96f.1778930064.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778930064.git.pav@iki.fi>
References: <cover.1778930064.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Context analysis has what looks like false positive vs. taking
conn->lock in l2cap_sock_shutdown().

chan->conn may be deleted concurrently and become NULL while retaking
chan->lock, but since chan shall not be reused, chan->conn cannot be
replaced by a different l2cap_conn.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/l2cap_sock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index cf590a67d364..bbf883098b7f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1336,6 +1336,7 @@ static int __l2cap_wait_ack(struct sock *sk, struct l2cap_chan *chan)
 }
 
 static int l2cap_sock_shutdown(struct socket *sock, int how)
+	__context_unsafe(/* complex chan->conn locking */)
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan;
-- 
2.54.0

