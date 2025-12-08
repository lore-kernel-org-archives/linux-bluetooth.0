Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB51221299
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765217550; cv=pass; b=BbKg15V2HiVvlVO2QXsBdEHjC3F1p1r4BfWTNsVK8Z1iKFieLOrMhdLMkIZJjqMdh4BvIIOyIRPmZTaQcjxNcMdWQibYLQ/MW/CbLQY2vMoylAXE/G09hhitZ1Feeb7NgSJcXxJJK99kEzCnrQlEMZxJcbmAMKZIP0smH6BpRmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765217550; c=relaxed/simple;
	bh=oAb2Yq/Ou3+VFvR+nTRWrJpaGCHwrC9ls45wMVIRF4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0C1RQWzYUWxCeFIhoCLENBCY4LKVAVXBKaBPy0EaQuz9aD93NTV3Pi6mqx9qfY/adc+0i8bUzZ6Bi68dN/X7YHa4PxDF+ZeGQdVKjxwwSOcsrU374DwC+MVijq8DBdrnXNJWPJK16c7le0CaGbHNPuAG9ZITx/fh7DPj/iKl74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=kAShljG0; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="kAShljG0"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dQ9762pQDzyS6;
	Mon,  8 Dec 2025 20:12:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765217538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/xkc5Owy+5OwiuN5zQjubr2TsVIiM5Uca3KgD7YfU3w=;
	b=kAShljG0ZqaGFYRhDKeAHVkqUtTCdJ56xJk7CLbEBgzasQOwPDCts0LMTiRZ8eNsksdlxg
	2xe4v+hNuIrHnb3qPNxkkW2+xWlp5A13Hring6oBYUv5i5ezLWIm0ysfrE/MWKg+Fm29JD
	iQ4sLebBTXUg0AhDjihov7dZZsV+CfM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765217538;
	b=NDE9D9uJg+H8SZN/agrFBZ1TtLmNtkOsccbe+ycdbxxfV/BJbalUSq4wWhTZzzodCrSyRk
	VOndN5c3FBc62/zU39BnFXoqo/6fyuHNrEPgAZziGRl301EB9Gd96SDMT6OXOPhrnHSDGc
	vOhJvhVyV9u6ncBupdPRGCTftajv8bQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765217538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/xkc5Owy+5OwiuN5zQjubr2TsVIiM5Uca3KgD7YfU3w=;
	b=wjLRhAtD/tSKQULH5/HKSKJ9i2ZacruOlQCybThpdSWJ9MFBNDM9gjc6s7yiaxm1qNwo3J
	pd+kxJhfm5vh0LCN4DEB4ORrnAXdxrr37hLa6KF9BJszHfDmm7IjIcLLPXA7kIhhyizjIx
	ozTelHeDVb9/mhoY3pQ/IESh7m7zDIA=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] shared/bap: fix invalid BAP server transition releasing -> qos
Date: Mon,  8 Dec 2025 20:12:15 +0200
Message-ID: <ecf6869cea8d856b63d43632c4f94db395b51944.1765217411.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When remote BAP Client requests Release during streaming, our upper
layer calls bap_ucast_disable() when releasing the transport.  This
causes invalid releasing -> qos transition.

Fix by properly checking valid states in stream_disable(); bail out also
when in DISABLING and RELEASING.  This leaves the valid states ENABLING
and STREAMING, so write them explicitly.

Log:
profiles/audio/transport.c:media_transport_suspend() Transport /org/bluez/hci1/dev_FF_FF_FF_FF_FF_FF/fd0 Owner
profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci1/dev_FF_FF_FF_FF_FF_FF/fd0: TRANSPORT_STATE_ACTIVE -> TRANSPORT_STATE_IDLE
src/shared/bap.c:stream_disable() stream 0x7c41327f1060
src/shared/bap.c:bap_ucast_set_state() stream 0x7c41327f1060 dir 0x01: releasing -> qos
---

Notes:
    Seen with Samsung Galaxy A56 which releases ASE to pause, but bails out
    when it sees BlueZ making the invalid state transition

 src/shared/bap.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index b5840d18a..6a35e4e1d 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2124,11 +2124,17 @@ static unsigned int bap_ucast_start(struct bt_bap_stream *stream,
 
 static uint8_t stream_disable(struct bt_bap_stream *stream, struct iovec *rsp)
 {
-	if (!stream || stream->ep->state == BT_BAP_STREAM_STATE_QOS ||
-			stream->ep->state == BT_BAP_STREAM_STATE_CONFIG ||
-			stream->ep->state == BT_BAP_STREAM_STATE_IDLE)
+	if (!stream)
 		return 0;
 
+	switch (stream->ep->state) {
+	case BT_BAP_STREAM_STATE_ENABLING:
+	case BT_BAP_STREAM_STATE_STREAMING:
+		break;
+	default:
+		return 0;
+	}
+
 	DBG(stream->bap, "stream %p", stream);
 
 	ascs_ase_rsp_success(rsp, stream->ep->id);
-- 
2.51.1

