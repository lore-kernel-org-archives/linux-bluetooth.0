Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E3A3CF039
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 20:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789936575; cv=pass; b=eOCf/db0XDeigi6xiRKy5EuItYriZLanL45CtyOMYQo9ijeBE+QIX51gpRLti5BarRjbHIoRSb0p1jypbGyzrJDuCfC5Mw2I8rMCnD+6FcZAhvbdz4l3zgWGNYl0jYczBM2uPyEvsIc7iS/58m2KY/40P1FzeipFb9zXJmT89Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789936575; c=relaxed/simple;
	bh=ssma0IlAA0p3v0J+aBmc94QVcF+GudLV9aI8hTEYEyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLOor2Ko52ZbTPMHjsMVyNjQwBRt36q3AieSj4nppezbNZL2L/LQWhDO6OOxn/NkegIQbLrlODhowNnuk1b70tmcb/EEYxU8K55u2i518G2L+RyMHuRsT7PuIKbj2DgTibihsvMMerA4hWLMfiWMO3Q+si49pKmJhNAu+U9Sn9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=JB3XGF7I; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="JB3XGF7I"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:4:f011::d901])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hnyn34xhRzyxN;
	Sun, 20 Sep 2026 23:36:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789936568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NixDsMVULeLqFFy+LfTXI3R7XZlfin8MRIr0mlv99qw=;
	b=JB3XGF7IbSunNeMwhCQhtsnhory46BdhT/+w1Kg+1axVqCDYWRZl/F04Zqk9WcacCN+biK
	fS2ukxR7QSAY1zUALZDCAUkbNi2qk7wDUJ70oflB+1JwNIjZwQixuGtjcPgGyyUeosTb/g
	j0/G9oAqR0UE4hxNjgoOf3unsnkrtz8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789936568;
	b=UCttb/Vc7QYlWVtMDVid0hw5gou2ffVSpn/7zr10deaAx80qFJrwA1gY8O0ktBGbkRpYur
	W01fot4870t8DMjQ2MIv+E6LXIl6pniSHONjMPIC9sNTybg3LZEWbsd1b9vWoyhaBKY2eY
	vUzmfaGCE+03JYNHSa8agCXWwHE96BQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789936568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NixDsMVULeLqFFy+LfTXI3R7XZlfin8MRIr0mlv99qw=;
	b=YIev0PNDNqPhMRWt/p3FtIx+B2m1FwLMaroRH13J835zd9diYCH1tobLGhuYEP3dLUQFIh
	BAJEftjWezSgO+czcBQkHp5rwRAOrdFbS4UDkXqVYBQCOfZtUGVU3o4O23u0E4MSOZk0iI
	e3lRWhJJAYXY2kcibTKXXR9VbLYIKiY=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 5/5] shared/tester: Count setup failures as test failures
Date: Sun, 20 Sep 2026 23:35:13 +0300
Message-ID: <fcbafe2932c7040a2036a2a1816985f7ee7802af.1789934710.git.pav@iki.fi>
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

A test whose setup stage fails ends up as "Not Run", without counting as
a failure.

Make them count as TEST_RESULT_FAILED. Setup failures are real failures,
and should not be considered same as skipped tests.

Intentional skips through tester_pre_setup_abort() still report "Not
Run".

Assisted-by: opencode:qwen3.8-flash-next
---
 src/shared/tester.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index 7a0145b46..e99cc452c 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -558,6 +558,8 @@ void tester_pre_setup_failed(void)
 		test->timeout_id = 0;
 	}
 
+	test->result = TEST_RESULT_FAILED;
+
 	print_progress(test->name, COLOR_RED, "pre setup failed");
 
 	g_idle_add(done_callback, test);
@@ -624,6 +626,7 @@ void tester_setup_failed(void)
 	if (test->stage != TEST_STAGE_SETUP)
 		return;
 
+	test->result = TEST_RESULT_FAILED;
 	test->stage = TEST_STAGE_POST_TEARDOWN;
 
 	if (test->timeout_id > 0) {
-- 
2.55.0

