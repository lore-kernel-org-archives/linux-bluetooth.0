Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB06C365
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 20:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715719321; cv=pass; b=MMgUjn+FFQK50rp5quLe5H+M5dWqKl0b1cFmYmtSWGDjbsxFQrLMQ+vn1Nn8aTH87i7FCMegwVaV8BO7VQ8xLrb3/Q4QZriqavBqm8vYwuMwFktM9CjnQ3S1eNi6hpxzrtRqoSNLC/1JFwTa+ebKShXnNLvkE9WKwippwyA+ZTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715719321; c=relaxed/simple;
	bh=o7xea0l3cdI7iKOBK11360xGhye9BD2hvlCxYhBNhok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SFxmcr97dAh1qBWG5rBbQ1V6J4WkrLiB+JzqQsHs/3C9tq1scLhIfop83WuWwcKkIY+gdAzoTDrbLNxfOhCwgXQyyYfYrHHD0joww1S0YAacFNA3/r758C64+Um3u6MjBXDo5haKkt3qS5XtEzpgax0xi3K11dlqu0lQnpvIhUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=FBlFdIAu; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="FBlFdIAu"
Received: from monolith.lan (unknown [193.138.7.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Vf7ZB1dSRz49Pxk;
	Tue, 14 May 2024 23:41:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1715719314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n5Q3RcNn6aqRf9vxqs0zp6Q/tBJ32vbsd0o+j0yspsE=;
	b=FBlFdIAubvxdeZcJ2K+q5ij0obYuB0cb9TVZU5w01tNlbz6mGy6xbnquhlP6VAiUVvDaLF
	RRAf/0a6qPQUQOZqI2p956ilKhRHSKkSdIUb8Hmim7Njcj133BjOSCHuDhgGLTP3QZIcye
	W97Xzq/z+CNIkb4NvwBKmYB6lMTQCGGTpQvzE+4IWhJLk8/BE+9FE1e9WC/7AgsopmWGlI
	9SRYvRe2ZqBOUEQq1Z9M5RGqGkL6B7sAhTH/JUMYVktZdzYHxDMSwHOwkHeaT3CB0Q9m9R
	4RGVtL3d6RAd9rdubwcEesosxcPfun7/KyYLsDt+Ab5QxUxJVhsdCXcdbK8G8Q==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1715719314; a=rsa-sha256;
	cv=none;
	b=KGyk3HWd1O/4PHkMAU6oRG+q4TLI4F9YTSxTaY7+hI0604qswTUu3wUiIYasdyN244MlON
	PUl0i/j+ZEO33ae38JAIcAi2o1HVxG/yyCCEZ4UO6WTGYTTydlBU8Pos25nDEZrlq4UoAL
	faopaIu5woIYSEiwva1dlA/O3JHrK+wlzUgBXHsJxiKK1YSsSCc0EoXXPQC8ck5kP9G6yl
	GBLAufuQvhTg/LP2VuaAyf4Fe6cNgzmsyjMDLrvSmV8ZpPWrMKWQaC3HvETjCuO0twzYt1
	4rAYLK99D0sOvsDj1DjKr5LVhmUPnO/l9f9a0ExcNjdNMe+th5HW1Hc+WwVDsg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1715719314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n5Q3RcNn6aqRf9vxqs0zp6Q/tBJ32vbsd0o+j0yspsE=;
	b=EfAEOPYzQtYFMLz0Zl4X0p3jYVr47lYhbNtpSxa0YNVrGiphmNOFLpzwvmGko/FGeeW0hh
	3rlqbbCkLY1Pmw2+HY8gUnH+J8bZKK43imoU3ctV4yB1WPqXDe2dRFt3v8Sa6P124FBI/e
	nqRoVOc/m9jjyCZIRTF6fBlBRtI4jhtrDb5SGmy7Yqk1lkuC5gY74jQUEB/T4Ly22ORlgC
	/ITCpkF/ZC/FavkWmX0eCwzXDGJtivahs74YTKilTjnDfxyuShv7qqGdv2P9e4mSIQLwPP
	X5BfvMKTCzolw9MD3HFXgq3/yo1/be/kvFWVgevX3eya8zqJ3ZnhwmMGsfNRDw==
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/3] shared/tester: add ability to skip tests unless explicitly selected
Date: Tue, 14 May 2024 23:41:48 +0300
Message-ID: <d832a406db3b7f8509fdc67d0e9f2775c6ea7b6d.1715719254.git.pav@iki.fi>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it possible to skip running a test, and skip running if the test
was not explicitly selected on command line.
---

Notes:
    This series disables the TX timestamping related tests by default for
    now. The TX timestamping itself should be OK, and the assumption is we'd
    re-enable these tests again once the kernel feature is reworked.
    
    I left the BT_POLL_ERRQUEUE parts in aside from the tests for now, not
    yet clear where if that is going to go further yet.

 src/shared/tester.c | 32 ++++++++++++++++++++++++++++++++
 src/shared/tester.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index a1ee5b687..56c8cba6f 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -563,6 +563,38 @@ void tester_pre_setup_failed(void)
 	g_idle_add(done_callback, test);
 }
 
+void tester_pre_setup_abort(void)
+{
+	struct test_case *test;
+
+	if (!test_current)
+		return;
+
+	test = test_current->data;
+
+	if (test->stage != TEST_STAGE_PRE_SETUP)
+		return;
+
+	if (test->timeout_id > 0) {
+		timeout_remove(test->timeout_id);
+		test->timeout_id = 0;
+	}
+
+	print_progress(test->name, COLOR_YELLOW, "not run");
+
+	g_idle_add(done_callback, test);
+}
+
+bool tester_pre_setup_skip_by_default(void)
+{
+	if (!option_prefix && !option_string) {
+		tester_pre_setup_abort();
+		return true;
+	}
+
+	return false;
+}
+
 void tester_setup_complete(void)
 {
 	struct test_case *test;
diff --git a/src/shared/tester.h b/src/shared/tester.h
index 16f41022d..1f8138434 100644
--- a/src/shared/tester.h
+++ b/src/shared/tester.h
@@ -59,6 +59,8 @@ void *tester_get_data(void);
 
 void tester_pre_setup_complete(void);
 void tester_pre_setup_failed(void);
+void tester_pre_setup_abort(void);
+bool tester_pre_setup_skip_by_default(void);
 
 void tester_setup_complete(void);
 void tester_setup_failed(void);
-- 
2.45.0

