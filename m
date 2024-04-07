Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD1939AFE
	for <linux-bluetooth@vger.kernel.org>; Sun,  7 Apr 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712503130; cv=pass; b=aWelmXHzfYmUtsKBcYTxMPQvR6bGnuXrkwjTiqOMsojTRyZ9HbQjoBZPtdvFM3Y69IYFXMapedzHMW4CRFEk1qDNneSueamM8XB8O6B6N8h3XtQjg6GFdEMRL5hNhiqdLHTnEaR6Q86i08DuTvB4w/IbAef7hK6ZylY4T5W0y2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712503130; c=relaxed/simple;
	bh=cGTvvZwDMjuLgtt78extSnJNHQmmf37PS1y8Xqt8soI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KUzHaVviKj5/A06um+VnwlbALXPxZtR06/SZKGJUhspB2PjggE7her13xHoq1gXrqWUH0CgNsixtz6+S/8yHkMDIoCk1zC2k4RmjqRbK2etWnFz+qKvtsgvpoEJ6osrkEHjFyTuUs9UfGDxLn2ap9hnS0KIJBb427+JaGqkzg/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=CD50lGtK; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="CD50lGtK"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VCG8P6RPKz49Q4P;
	Sun,  7 Apr 2024 18:18:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1712503126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGni8G/HbfPGiuILInXjh8i667wl3mUsEU7q/qnORcE=;
	b=CD50lGtKmkBPR1+p8ETiaNb2dZqSpMvPwavm0Vsnconxx50EvvbEnHSqW++5qX3wNVe/ca
	lzvCeonep4A1mlNsGPV8h7uLQqbPT/j7EfLnC0/NsibqydCHD3zJ3rIuakxilfbIAEgKgx
	Ld4gc1sZ216m1JANbNCheXWIYDhrH9rlnBk2L9InrZdmPypRlSCwXhTkk06M7X6FIRwxKW
	LpmatU8TzO4a6q9YY0/bXn1P4J8BaXvVYqckLm8wdynGf8g/zROg9GGNFHJfR11J46QQXw
	cB0cDMpvFeLWNbpMn8kt1Oxo0/v9lUxl4m7rlzKaIFhJFmJDg0DnQQkwnyGvJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1712503126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGni8G/HbfPGiuILInXjh8i667wl3mUsEU7q/qnORcE=;
	b=WmMseD1x2g0mVSPxHVurUflCacWQrgEA25sc7Naz4d5WMDFo6XG0uE9dWERd3fPF28jCIb
	T00/qbedGtlVMKd+2tx2pYET185d6wyGVDeb1eHlxrocf4q+3saQhi+3UYBGP8qaEGwrKH
	AaMl/Q2w5Z1o3JjkGlDM7ID9IAjL1/6vlMXlzdv/amiBttBIZL1sP78ygek2xS2d1Luvh9
	iUou2nZk//QCiQ7se15xfOnoD156etnbZOlVkiEVryQjIFigdK48JtDhlj0M8aLwrmGU2G
	YgRTrRrSuWg9th91sMtHxXEsWBGUAzPo8wdrHXLunPx+ElFB9+yEDQ+Qg87uww==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1712503126; a=rsa-sha256;
	cv=none;
	b=NO3ubCCYI91GYYQ86fwNGdW5/Qv6NcyYys6T/aSjjb2fgJRGoHiFFZQX2vTLQjqt4aKDek
	fg2AY5hrEqd1Twjdh8JK/iBiH37iTTGQd4QHGN+hehJD+l86WJHBKyah1DxCXhV0u1UT/J
	saUFbguCaXKmluPTlyTf437zeilFhuDnxPF8mJHS56YLh4IR5NtuPUSZVL/zH57mlyxfQD
	CPjfHkMCfTFKozTvHIiWCYT8JC+sLSte68k8ryj1jkXNtO2kNsUSbc0v3WwTQvdBBE70bc
	jsWxZOUy9EHTNNuIJlRUZELnvVgi2c+HT1HNUyso+12R1cav6XjQWZsvDtOMfw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/5] mgmt-tester: update for Poll Errqueue experimental fature
Date: Sun,  7 Apr 2024 18:18:36 +0300
Message-ID: <e7bec2cd79c604efca08d2ce5b1d66c08009f512.1712503074.git.pav@iki.fi>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712503073.git.pav@iki.fi>
References: <cover.1712503073.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update Read Exp Feature - Success (Index None) for new experimental
feature Poll Errqueue.
---
 tools/mgmt-tester.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 8a4fbc2eb..81636200e 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -9985,7 +9985,7 @@ static const struct generic_data read_exp_feat_success = {
 
 
 static const uint8_t read_exp_feat_param_success_index_none[] = {
-	0x02, 0x00,				/* Feature Count */
+	0x03, 0x00,				/* Feature Count */
 	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c,	/* UUID - Debug */
 	0x01, 0xab, 0x9f, 0x46, 0xec, 0xb9,
 	0x30, 0x25, 0x99, 0xd4,
@@ -9994,6 +9994,10 @@ static const uint8_t read_exp_feat_param_success_index_none[] = {
 	0x85, 0x98, 0x6a, 0x49, 0xe0, 0x05,
 	0x88, 0xf1, 0xba, 0x6f,
 	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0x33, 0x57, 0x7b, 0xb4, 0x21, 0xc0,	/* UUID - Poll Errqueue */
+	0xc1, 0x8b, 0x79, 0x46, 0x9f, 0xb6,
+	0x4c, 0x8c, 0x51, 0x69,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
 };
 
 static const struct generic_data read_exp_feat_success_index_none = {
-- 
2.44.0

