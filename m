Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5410FD
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 Jan 2026 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767478471; cv=pass; b=YGtzcIyuyKAo2/CoM6N3k9poFPUOVN6qgiNkGBQZmw/yl7DvgjlXgihiI3shrM0tmavaYtdWlM52eX1frS4N6LYDsiABPO+8QpSEZuWlWoVryqhse4YAkdc8Anu6lCDXbBaGx3aJbFK/THDWedk2TYmwYHAdGnmfg6SOGCD2kZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767478471; c=relaxed/simple;
	bh=JJZUbc+JczIk3YqanlCxJfdA5ABxb/cXGLkAX7C6TAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T1dcX0c0busDptfrzQTaHHrT67DmwkCvkfUhUHhQSccWWWeRoqmywtgXBv/HifJ0YCqS3CzFh+dhdxySjxkuCF5YgHFd7dkVx0cSn54L0gvr/1ZKFAaqnBRiRZahjLz2ctGXZMnVdWN9f5EaEIoooRkwSkk/IVNa4LyVrcVZHso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=W6K3yFyh; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=S7KTpb/3; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="W6K3yFyh";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="S7KTpb/3"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4dkFGM1wCnz49PwN
	for <linux-bluetooth@vger.kernel.org>; Sun, 04 Jan 2026 00:14:19 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1767478459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezJ/4hVKgVxuO/SuSRKLa47ZMUT9aPPCyNPYeE0zkd0=;
	b=W6K3yFyhXwzsR8xojs7QGF5uGngdrRAJh2HKCvM9CRKCZgnJ0YXAbjUVJwY+fBbvE0E5Ni
	KhG0A6qKn6HRbsgs+5uldUUoIB9GiBze7CmvggmTbc9gHzxM0Q5/+x3id1xQ0ezrsgh0uY
	LVa/zOndK6yh177kW1W8hvHumFcdXcjU2pIW6Xc96/74whTdJ6E407+PNR3I0h74HrahxX
	Pb4zkRTy7po0KVND9DLrm5JOgj09ks4S9AujDf2dyh32c3Jsl+saEa8B9rKM9GqeLNJljP
	C8liHDHbYCJQOTUuGNucXUrVwUxqMQu+nXrZnjp0UbQllnjgZM7xCzgiKw14xw==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dkFGC0r7nzyWD;
	Sun, 04 Jan 2026 00:14:11 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1767478451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezJ/4hVKgVxuO/SuSRKLa47ZMUT9aPPCyNPYeE0zkd0=;
	b=S7KTpb/3/+Iw+qJQvJhEzSBJhTS6yYeTyor7+EWW+vbEfx2iixk8c5WrJ3/rPZREmqjcjK
	WoqHCkpE4RkSIi5YWdMIbwTzx9SMJRiV077JVDBR8JQmD2r/q5cN6/qHkE3FrYVTgH5+/T
	HRT9ZMUQXF6iXKBfhrDwV9vBwq1fygA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1767478451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ezJ/4hVKgVxuO/SuSRKLa47ZMUT9aPPCyNPYeE0zkd0=;
	b=bqCPJFdlox76cIdEbq+CVlWKa1T0gJAeBMBvGDJXrvOF95q3UJF1NW5yVW1jh3OhlgQHuI
	td0o/+oDA1PMlrIFnC0KKC06H+ppIZ5OTw4hXul4CnCFX6kbJsx61iynzcA6KVAaIvVuSP
	UF8cyL681JLTB7jPlMjjb3ZbqGLnSzQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1767478451;
	b=TUIYbmAyS/V8Nf+EirDWKTZubvHUihYwO2mIVMETGOTTDHrEmB/F6sKA/40P/2iRmNnJUL
	2yBXs05KPsgzf2JvcD+iZSQM/s/bGDAHvaB52BF4JNcy8idwal0ixSN+tGFVPYGjDAISNf
	YmX5qhw8srRGmv1ARlImc9LVA1WmtaU=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RESEND PATCH BlueZ 2/2] 6lowpan-tester: re-enable previously crashing test
Date: Sun,  4 Jan 2026 00:14:07 +0200
Message-ID: <b7a413038cf035b573de61b7b38445c006ad5a4b.1767478380.git.pav@iki.fi>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <d7f5c6978db76b58f9db1b6f93254d2f38c1e365.1767478380.git.pav@iki.fi>
References: <d7f5c6978db76b58f9db1b6f93254d2f38c1e365.1767478380.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable test that previously crashed kernel, fixed in v6.18

Client Recv Raw - Success
---
 tools/6lowpan-tester.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/6lowpan-tester.c b/tools/6lowpan-tester.c
index 7fdacefeb..65dba173b 100644
--- a/tools/6lowpan-tester.c
+++ b/tools/6lowpan-tester.c
@@ -337,7 +337,6 @@ static const struct client_data client_recv_raw = {
 	.send_expect_data_len = sizeof(dgram_data) - 1,
 	.sk_type = SOCK_RAW,
 	.disconnect = true,
-	.skip_by_default_reason = "kernel BUG at net/core/skbuff.c:212"
 };
 
 static const uint8_t iphc_dgram_data[64+2] = {
-- 
2.52.0

