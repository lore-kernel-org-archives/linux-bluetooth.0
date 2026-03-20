Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39870368269
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041137; cv=pass; b=ONUPtm6tl8wJcjo1MGfMcMtD8i7wb5Q4e5jmBXnUyUc5NykppB3tXXU9A2bfo42EAFuVQdeP0Sqqcjc24okIwXlDQ18mGGkQnEKCPWMl6uvzWkser9lhGI8T54BBzV7+qw3RCND3srAzc0ForzjHUi6eYBs2qSmpiugw6z/GeqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041137; c=relaxed/simple;
	bh=AU7QlXglcLq1RioXARAyXzeFNFV/9WKUfxZSGR2yBC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UR9MbrUr8riQh9pvk9qcxfY/JKC/Gjesb+DrT/B8J2/P1lkbCHX5fNznQfxxvgzGgxqCgB390XAi04INjIvknqeDvLsr3sm6BH0C6pa207/eS9cGiiAcHSPXzH1Px+ZwJ7+MO0Lw4s5nYqjbPNvs3DWNRu/C6yhAOQUn0teWGa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vb5xfozC; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vb5xfozC"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fcwHd3hsqzygB;
	Fri, 20 Mar 2026 23:12:13 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774041134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYYVZ45Yb+9dpFVuCMIcgwcQbjEwDIpE1Q/n4zGsLPA=;
	b=vb5xfozC5qHUrm2x4oE7ToYBnEFJ6PXe0cfHe5GV8WFcwsvoXTHG0eW5jcFwJG4dTBInIh
	ujm5Y3I5tAU9T5dsQrSSgXxJnJ7wmRhBkitdj4X/LnkS1QqINfMkAnJTJIwH6BuXEA4bYi
	a0zSQT6axJDd9t/TBDnlecdP/tTWXDo=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774041134;
	b=gJIsTbBvaMGeQ11b5RLei1Aqa0I1xHZRTDhWgWPKgKX7Fqs94L4KWi30AioUwH9vgfAVKu
	ZA1gtgoGKcDa/uCc8OsMhpXXcCRM7piWd6BzgELiDUjh48ZHj2F6m0F7AsbyWhqhioa5zq
	JQaPvtLoXjP/JoN4U+nZ7ArjWjJiMnk=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774041134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYYVZ45Yb+9dpFVuCMIcgwcQbjEwDIpE1Q/n4zGsLPA=;
	b=tM/s3zFnJjzSOOYDM3xwkuXvq/jFDBFXYVza8I02hwd8LoZfrVGDI0o79Ybe6vtg1vxP+B
	mgA0ls4v+LJLFf7sjYL1H8RKtR+Sls3wNKUfOHcKmnsebxqlV7YoCfNB9UHr+4/lWuTR/P
	5NoaFBjOU9hSqD5uXh2nZnkz0ajNcFo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 16/20] test: functional: impose Python code formatting
Date: Fri, 20 Mar 2026 23:12:03 +0200
Message-ID: <bd509dc26c3c118a9fffa5d15384be4bf38366a5.1774041047.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774041047.git.pav@iki.fi>
References: <cover.1774041047.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check Python code formatting of the functional test suite.
---
 doc/test-functional.rst       |  3 +++
 test/functional/test_tests.py | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 test/functional/test_tests.py

diff --git a/doc/test-functional.rst b/doc/test-functional.rst
index 6254f01c1..f5b7aa7c8 100644
--- a/doc/test-functional.rst
+++ b/doc/test-functional.rst
@@ -271,6 +271,9 @@ The functional tests are written in files (test modules) names
 `test/functional/test_*.py`.  They are written using standard Pytest
 style.  See https://docs.pytest.org/en/stable/getting-started.html
 
+Use `Black <https://black.readthedocs.io/en/stable/>`__ to autoformat
+Python test code.
+
 Example: Virtual machines
 -------------------------
 
diff --git a/test/functional/test_tests.py b/test/functional/test_tests.py
new file mode 100644
index 000000000..561b04703
--- /dev/null
+++ b/test/functional/test_tests.py
@@ -0,0 +1,23 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for the test suite itself
+"""
+import sys
+import subprocess
+import warnings
+from pathlib import Path
+
+import pytest
+
+
+def test_formatting():
+    pytest.importorskip("black")
+
+    result = subprocess.run(
+        [sys.executable, "-mblack", "--check", "--diff", "-q", Path(__file__).parent],
+        stdout=subprocess.PIPE,
+        encoding="utf-8",
+    )
+    if result.returncode != 0:
+        warnings.warn(f"Formatting incorrect:\n{result.stdout}")
-- 
2.53.0

