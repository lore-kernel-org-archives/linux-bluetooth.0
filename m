Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=195.140.195.201
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793456906;
	b=pTgCDxRIldB45WVYCYDOf5INskwcs+lkqWnPfR/31dG5PRNqAXTgqUpVj7DeEh7VbQxj
	 h6x5ktBUJVnkfr75FLRKrdINJwJSms5ovHpXkvLCct1py2TpxBmsmKnWAG4/ZYij40Oqr
	 1aGs9qfoyaLV0+7j7Yaen8/NWWcu7Abdf3grjPlTtr+OXqOXGDDg5f04YbWznmUL7at7g
	 WpK7cOZNZGLBVpvH1dIw+p9TIOEgO2usMB6XrN4Ey7jPmR4MuTaZqnzM9jTr9cXITmHK+
	 oxzLO+ol+54VpJP6HapZ2z6q1JuOh4lluRip3xhQMethszqqDsMVc8YHRsV+/Ra7XHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793456906;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NiI94rLhoPPkQw5dJDYF1uRfN/k4rxabin7im7CO0VY=;
	b=TFEX9t+CE+uY80Gr4apYUoYDhYFhARYxvFcWT0LXV6jgQIXo7f/AcntPmFfM9g+5s7e5
	 2mCnuJUndhXe4m8her4f1Wp3zo4gEuiecHGlBxNk79fnLWQvEUvQBylGtNn6CqGdzlUne
	 GIClsUgB9Ea9i60yKHZoGmVLmmW5UMYGB195qQzogA2uESJpBVn/rzPr4NrwdWBkEIuLg
	 /ml40tsLJVBWMnvR4puZaEb769rnLJZxTGPbA+7t8SG2Rt5yP0GXU6jnDtspB7glpYQad
	 Ypz8JKQukMAYbsIDflU5pI08E7CC+bTqgTAyldMlvrSi9uAkd745q7Crxokxj5+vlNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iki.fi;
	spf=pass smtp.mailfrom=iki.fi;
	dkim=pass header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=meesny header.b=N4g4uJDM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=195.140.195.201
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52134606A31D
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Oct 2026 14:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52134606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iki.fi header.i=@iki.fi header.a=rsa-sha256 header.s=meesny header.b=N4g4uJDM
Received: from monolith.lan (unknown [IPv6:2a03:1b20:4:f011::999d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4jH0gc538pz10s6;
	Sat, 31 Oct 2026 16:28:12 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1793456893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NiI94rLhoPPkQw5dJDYF1uRfN/k4rxabin7im7CO0VY=;
	b=N4g4uJDMakJfE3RhI/8oiYL0L+k5yrzVqbI6GdRlrRuPb510JtrS9NrU9NqbgGYFkQKVLc
	0EV19RkauwFvmWAMPBmhRcVUCJjZfPp+dSU/Qmwu8b9BG31ET2Jvc4wTmqKG4PMgM8clgx
	KljaTUIAUltEqupGr5NLdixVVCUZPfs=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1793456893;
	b=KaeGrqyPjzTw/gDoAF4TKk6BKe9K+ND0loSbhOkWAz1wjvo2un1kYDH0XeOLGHLUdL1tNu
	JyjsbdnEDworVSZL4Nc/OZ4kivY5PQ+gutkS53C4GHetas0UFSeXHkTxdTCT4ortBOYEIr
	gMrW9fz6F0zS/YuZngWvfkFw8UvyZ3k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1793456893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NiI94rLhoPPkQw5dJDYF1uRfN/k4rxabin7im7CO0VY=;
	b=bymWSCfABz7tl/WLIn9z7+FRj8hEgeEhazt41OBz8j8UMtMKF6WHD54f178iu2hY/7Aaxa
	c81JEf4An6y7zrF9KnHv1FmOxofzDJxrFOunaOG3zZmUMNxp7MXQXj1U8fNoOs/6judHCc
	uECLE6EqTEpvzbqPHehX7VpTCKZqrQQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] monitor: Fix Conn Interval rsp group decode
Date: Sat, 31 Oct 2026 16:28:09 +0200
Message-ID: <3265e8c3d6e7628b82422ff9cad96eb0db9e7ef7.1793456788.git.pav@iki.fi>
X-Mailer: git-send-email 2.56.0
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

util_iov_pull() returns the advanced base, not the bytes pulled, so
each connection interval group was decoded six bytes past its actual
position. Use util_iov_pull_mem() instead.

Fixes: 79cfd07224ff ("monitor: Add decoding for Short Connection Interval feature")
Assisted-by: opencode:qwen3.8-flash-next
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 8a0e49ff4..fdc02fe01 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10289,7 +10289,7 @@ static void le_read_conn_interval_rsp(uint16_t index, const void *data,
 	for (i = 0; i < rsp->num_grps; i++) {
 		const struct bt_hci_le_conn_interval_group *grp;
 
-		grp = util_iov_pull(&iov, sizeof(*grp));
+		grp = util_iov_pull_mem(&iov, sizeof(*grp));
 		if (!grp) {
 			print_text(COLOR_ERROR, "  invalid group");
 			break;
-- 
2.56.0

