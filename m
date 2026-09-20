Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2CA38A299
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789936570; cv=pass; b=Jf6LimXC/LWzgC0+r/1WdiYwjIoUveuWwI3Ryi8sSKNugxyIR5SDqg+f2kZAvFcDpy1yu2q7qfBsKDRXNmvKU0h0f+mUi4K52kyRvQ4ismQer3BAx+LeWwx15kfJx8rtJRZXftv814pYWEAIawA/owyfH7KJd5KsNRP0Zxnb5j8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789936570; c=relaxed/simple;
	bh=b+n03nb5cVD/Ccv0BbDLTClyyTGj4+hw3QyosmH4mwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mGHCBh7+OeZk+rgJhBIukLQ3yyjknB1bf//f+0U4eCmb0NFcU3zdR1FrTs9UFT9cptlhwVw90ljBR22H8HVLV2jOezaM6nTsJRYw5FyxgT/gfG5QR1hhR9CjEAQJ8n9tnjPNXhhMkcjQDLZtn1lNNmRi43KAmLZya/vwCGCwLyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=LJR+xhpx; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="LJR+xhpx"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:4:f011::d901])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hnymy6hxHzyYL;
	Sun, 20 Sep 2026 23:36:02 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789936563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2ModwruJFFCIpAItGP1bzQnK0r7mPhYEea0x8od0YE=;
	b=LJR+xhpxnBCmKHkHPjKL2hKblwnzprm5muUusbdceDgvioGuYedJJbTzyyZCYTsqcjrbC3
	6ccAgMORxyrdjxK8sixjQ3BN3MuesjnLP9rQkg5vhCO6TINbxsMklee4ekww1l5MBJ3XH+
	4UrwWV842XsM8QfH78c8ExPdFb3spEo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789936563;
	b=n3/rr7mH9p7OrlWgM8wGBLYeqinzZZ6xFVI9kOLNhNE3KuCJGqz45hgjJdowNgTNi9kz4h
	GqY0NFiwktkBmkGPFuQsU5rm8XJZC0pBJt54jbJShWtTO0g6ARh1Qw/iJTjw2P94hicY8I
	eOY5TXKbEzDjlnIk699cXkN0JZHpDVk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789936563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2ModwruJFFCIpAItGP1bzQnK0r7mPhYEea0x8od0YE=;
	b=r0Qy+Vnjluf0em7a2NTmbz+Y11zRtQYXzIuMtYc2uHfPTbaw5E66Jvwva04n37+NJ52Ppi
	qo4cVH5GohxUGd1Olv3/HCTkiam7ejfZ3OPdqca6v/dmSwj2P9ci71ROusDnIXZSpZN26Z
	mLSU60edhRqNktXVDggcjviSEi/EpWk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/5] mgmt-tester: Report unexpected status as test failure
Date: Sun, 20 Sep 2026 23:35:12 +0300
Message-ID: <920e305c22381373634bb7482be33ce9563375dc.1789934710.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789934710.git.pav@iki.fi>
References: <cover.1789934710.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

command_generic_callback() used tester_test_abort() when the command
status differed from the expected one, making the test result in
"Not Run" and hiding real failures from the summary. Treat such status
mismatches as a test failure, warning with both statuses. Mismatches
tolerated through fail_tolerant are unaffected.

Assisted-by: opencode:qwen3.8-flash-next
---
 tools/mgmt-tester.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index a89d38ece..5a183a8e5 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -7656,7 +7656,12 @@ static void command_generic_callback(uint8_t status, uint16_t length,
 
 	if (status != test->expect_status) {
 		if (!test->fail_tolerant || !!status != !!test->expect_status) {
-			tester_test_abort();
+			tester_warn("Unexpected status got %s (0x%02x) "
+							"expected %s (0x%02x)",
+				mgmt_errstr(status), status,
+				mgmt_errstr(test->expect_status),
+				test->expect_status);
+			tester_test_failed();
 			return;
 		}
 
-- 
2.55.0

