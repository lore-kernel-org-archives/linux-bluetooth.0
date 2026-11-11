Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429482;
	b=bG1aizjSUQDCN6W+UFpsGYXjY6JuiCtdHY59kS8Ej0dvqCtPSIZOQRMgekw2tp1/qZY1
	 mkuOZVqE9eDS3n2tJZysytOOVXStsWcpoHfVp2P2PEVEMsZMjLVJnt0nQK0ScwofJI2Or
	 799iwTe8sSo7Z1Q31DZ3shtopF5gHVfRuLGJU2JTgK3NBWKObAE1ZqG/0NYyZnxMOwxSv
	 3hd0tPRdeQxIl6RHlzllcWRnU853phBOwBzR1Ue9KMD+f6KSGywGT0TdCLKLU0JurO2yT
	 0WzsYcS6rMXfbdVEyG2JIz0RGtxbpBrseE26XYhMuUp4N37JmHlX2NUJTlot2my012A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429482;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fREsc+FGFyQIdLhTNAfUBN0dhUbVqVBQ3xCMWFoFPFE=;
	b=RwnjI+CWsEhb7UDJa8iLpC17UX3dDBp5QCTX35R7F/Ij8QyLyrVQD6IDVLb24ubwlyGQ
	 fQULk7jz+qeFoS/MEUF5U7VhllNphCcbPtgkwV/ZNcAyHRIYSg+5dCswcwF4yZ8IXMFyG
	 MATym4TWmuI2IDdpwqyQ1RNhjbvNAV0zzR5l1zxJ9mUSdyUfLJ/14aU4+NvQ1BbwdFO+F
	 5RJuZnLE5MMzJVWT0huprVATsa86MdC6Vu8l6Pes6CmPdz4OJd600Gkw6cf2Zdc+FEV75
	 3Xi8+bmD136ctAR+ZNojypJfYC8kp40seP/PeP4uMjlqfM9SuebbiMkz8izFuiq2trg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qx5yrx3d;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C009760A263C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C009760A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qx5yrx3d
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-980c4258105so1722069241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429481; x=1795034281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fREsc+FGFyQIdLhTNAfUBN0dhUbVqVBQ3xCMWFoFPFE=;
        b=Qx5yrx3dhEYrDeI6v5dCX5wBPeqCEmitjrkoBGJLw9o/XJiYT6vXMlWVY07WEPNTqL
         2cHroPnl64XkcZ+3fB//MYe709epEK8lRriGQTrr2qjkgq8EKOt9gxXHGL/cHlcvdYH5
         HpuqZN7KEmNHOzKuS6o/CvSUzRY7KEmMs1a4oasx8LUL2hwa9qnL2j6ctWq2as+EfiWw
         Az0SPGHGM4jr6iKloBTjt9x+KSdVT+gj/J4U2eaCpGSnDzDf3IW5kEWDj1Js5rPJ6QHx
         VSe2vhHYPpPMzuDSKy2K/WI/dHGukpIvjAUKLJaA8c0VELOoryZQPXDPu6pBzU1mL5Zl
         CM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429481; x=1795034281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fREsc+FGFyQIdLhTNAfUBN0dhUbVqVBQ3xCMWFoFPFE=;
        b=EXU+dlvkx46DWr8SeKyN3CgJnR35hkA4LmM2MbyasjCytVIqYPHpN1m33pOBLxFvl/
         UTZCQN/9Cw9HnIMos4rHiydZfJe7UGH1mcUM1lUoJ4dEAjH/gna/LbOg9qwcYFGlGeWB
         vzvRRS46ZsQU4NA1DyO9skXLSxOPVUAoWnQTVvUF7Cm21tvdEhrzWyf83rzNSLRnBYV6
         7oDOpH701a+gzQmZQTA04bCNsCkXMwb5Xj2X5jf5soCJ7wHu369ATMSlPtOteJazRz3y
         TnkHqsQKEl+j1oZ70JukIRrE7g0BcsLGXUdxyNXjaRdOhNXt2gzR8Oq9BIvBADlKecK6
         i9Hg==
X-Gm-Message-State: APuU4Z/6LHVC2mAM5E6f7NRYGLeGzHUPKmvL9wGrsz7AMF9FlVARTTxo
	8lFlrDPjdzRuYg4JPNaAOA3XaK0zirgPSYyS+2tuctzvjjdKuvTLMyIs/WJHUA==
X-Gm-Gg: AYBFou1LSKcdXcUxHMOye3Qrd9Ze1xAEhzNg58ZVZpXsMESUOU4cbD7XINMLQebM+UK
	/SbAcv5Eo2flP1mCFWeP1/TFyQJ+VrGxOmtp6FCUAKNTg5qP/vWd8fV5vjINOJnQINiljcoAXiw
	Ugs8mC5yG5TKr9oo5eFSj8VpVaybDtKsFjYxTN9VpIwxhyF8prPAm7kfbSDBygpNixj8HLNmiMk
	qvMM513knulIa9+hUDC4grB9N2lUwnsMIeiSM3pSJxYT+syOC0T0LKayj8iljENU+9T/tpfA3k0
	QfBEsQYvpZ8xHQtPZIs+WM5htWS4CurpQUEL4Mk9hDzLlg5mQ41zJCB5vxmmbcOu1/wsrZihX9t
	CZA0Mv83cNKLgUfIzVn1JwSfaiVimeKxeyyHvjrinaXvMPiRS1XEwjycKrYjBiDFXWvVLUUU1ew
	LFPEgjNQMJUhKMUsknseuxiSXIzEK4D5EFmhjRVMLHqnQsnijLknVPdKV1Tp5CCn/B/BKSw3Ini
	sJrjiBXopK4JkhEKjAzNKCMqnyezOXt0zRPU/UwOtr3K/aSbNHz8Z1Zqpt5UidmkFfkynz8GkBF
	mhZG6wRyMLbrXScqiGrawhfO4y3TMc84f7qPB9rujVUboI3ItU/K9bjHPDLTbIB0H4oYaLOP322
	YptJcVGKGHNlTdMOzntjawD+osqkjTs2OTa/jp09mZP3OBulH6g1F1PoRA/5tkHb0obdE3He9xt
	urPbk=
X-Received: by 2002:a05:6102:1608:b0:7d2:7654:86ac with SMTP id ada2fe7eead31-7d4ee4c61dcmr1744737137.4.1794429480728;
        Wed, 11 Nov 2026 12:38:00 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:38:00 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/8] transport: Don't hand the owner over while releasing
Date: Wed, 11 Nov 2026 15:37:38 -0500
Message-ID: <07eac67b88248b126fcec9d784db800a69ac3e0c.1794428234.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794428234.git.luiz.von.dentz@intel.com>
References: <cover.1794428234.git.luiz.von.dentz@intel.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

As a server, handing the owner over to a link still streaming also
happened when the audio server released the transport. Release sets the
transport to suspending before disabling its ASE, and disabling a Sink
ASE reaches the handover synchronously, before the request of Release
is installed. The handover cleared the owner of the transport, so the
removal of the owner by Release did nothing, and the link, which kept
the owner, was left owned and never moved to idle:

  transport_set_state() fd0: ACTIVE -> SUSPENDING
  bap_handover_owner() fd1 Owner :1.2 handed over to fd0
  transport_set_state() fd1: SUSPENDING -> IDLE

Don't hand the owner over when the transport is being released, as
Release removes the owner itself, nor when the owner has a request
pending, as it would stay with the link although it was made through
the transport, which is the one that completes it.

Assisted-by: Claude:claude-opus-5-5
---
 profiles/audio/transport.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 41aa8b78e3f3..ad2fc2c1cbf5 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2459,8 +2459,12 @@ static bool bap_handover_owner(struct media_transport *transport)
 	struct bt_bap_stream *stream;
 	struct media_transport *link;
 
-	if (!owner || !owner->watch || !bap->linked || bap->desync ||
-				bt_bap_stream_is_client(bap->stream))
+	/* A pending request is answered through its transport, and a transport
+	 * being released has its owner removed by Release itself.
+	 */
+	if (!owner || owner->pending || !owner->watch || !bap->linked ||
+			bap->desync || bt_bap_stream_is_client(bap->stream) ||
+			transport->state == TRANSPORT_STATE_SUSPENDING)
 		return false;
 
 	stream = queue_find(bt_bap_stream_io_get_links(bap->stream),
-- 
2.56.0

