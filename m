Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A84296BD3
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763207838; cv=pass; b=QbWsSxtU3Fz+BuFj7zNcWo9cQkBcvO5sFKeTgRgH+79TAc/o2gTQZI/uBOnYlN6Fc3xsuPyNCO/K1WGGmTssOE9pEmyLMUbG7M50bUtX2m1vD8UYEoLoWTgJrblf+OnQyna7tGshi4lQ1muXCQ9kblHa5ZNA7znPBV3P6v2UG4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763207838; c=relaxed/simple;
	bh=iJPjMhg8w2f1kQj+XRW4xowXfTzz9Z9Tf/utzYfnYFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A3mHvy6oztTObw7JEJlj7wsvIT8byeDALGoNT5mzMzRDQ/WRdudPcVdnjkyJXVVu0HaALjZLxpQE5anSLGJJVYD5/dd31BSTK4cNc/j7p+z/k+Y2kVRoN6sgVwELKxOb1j+4C8Yz2aRZ/bxDhx3hT7zu0WlctjB/bG0OoDDVnmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=N+qcdfns; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="N+qcdfns"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d7sts0MgPz104y;
	Sat, 15 Nov 2025 13:57:09 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1763207829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jm55ed0L9EGr4w3SIbWJoMMBeWLdGT5cM7eaUCI52Io=;
	b=N+qcdfnso92p3jx8ru87Q3K7uCvoqQXY3P+DsGFpXpnM1IyGtcifg7C1Nw5INlqLnQpmGu
	xphK6Ji2j1w9XzsRoQ2Z5i+teFmo/a+owJCJRBPcmIOKBf8K0txjL0wPBzWVdsdk8R1kEu
	CCmwV4NuM4kGU3cw0OQlxYwVWXz5GA0=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1763207829;
	b=qgYZRUw8gdKINE68CAxyCq5PS0EnJVOSuSfb36KfhnDlynfr+fvBDdThJFJGqMimXmCEmi
	c+Pj3fGEXrkvKuJkP0DpAkmdevd0WZhfJpkb2Q8YHm0P5qu9MifLgrE6I9/C7SxC7udzTc
	AIYs3CFmqg361Wys3I4jNQoEbuutQRU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1763207829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jm55ed0L9EGr4w3SIbWJoMMBeWLdGT5cM7eaUCI52Io=;
	b=PDP80tBbKUh3mHxDqR1BYddK9d11YMIGoQC+MJYRRNbuEr8LOPKtr8gxNkP5dwVMdyBnjG
	dy3g9237G/NcxzstZ58l1/crNFxm64+WTUDgyTLEeEpj1Zd94+8wgrhGYCTcLA4crBO1UY
	/cKvtOEEfoyxYq998OMEKZAuNWP+bS4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 4/6] shared/tester: better debug output on io memcmp failure
Date: Sat, 15 Nov 2025 13:57:04 +0200
Message-ID: <c4558b04f5a06eacb5cab40e0c3abc1c233df0e2.1763207813.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <69ef74b5d531804f4f793f42032da508d1497d1b.1763207813.git.pav@iki.fi>
References: <69ef74b5d531804f4f793f42032da508d1497d1b.1763207813.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---

Notes:
    v3:
    - new patch

 src/shared/tester.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index d1e872b8f..1f59322bc 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -983,10 +983,11 @@ static bool test_io_recv(struct io *io, void *user_data)
 	if (test->iovcnt && !iov->iov_base)
 		iov = test_get_iov(test);
 
-	g_assert_cmpint(len, ==, iov->iov_len);
+	if (memcmp(buf, iov->iov_base, len) || (size_t)len != iov->iov_len)
+		tester_monitor('!', 0x0004, 0x0000, iov->iov_base,
+							iov->iov_len);
 
-	if (memcmp(buf, iov->iov_base, len))
-		tester_monitor('!', 0x0004, 0x0000, iov->iov_base, len);
+	g_assert_cmpint(len, ==, iov->iov_len);
 
 	g_assert(memcmp(buf, iov->iov_base, len) == 0);
 
-- 
2.51.1

