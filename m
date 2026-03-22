Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EDF17B505
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Mar 2026 21:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774215086; cv=pass; b=AexIF5YdGyKbrq9qGWLzv69oi3vGHYLCVr6M530jArAjyuE3Y7qDCzgXqqEhjPLMW+CJd/zM/xuHsEngYX0UiotVboL7yCvYM0P+Ud4Cbt0tfs8Kw7LOrz82l3pGEBSdQ5DzH0qgrjuBs5O+1zkmYcHjhiK1jR4ZiJnJf42DS9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774215086; c=relaxed/simple;
	bh=3OHQt0o0aajYNYQjZolPiWvtkMPQGRTB6H2erhT2TJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGhqmQmvzKAl6YipaAJEcAZmnxPdf4bHP5XbdVDQE0UOqOogLqD3PQFjeedhLhzMOIM47pGXAP0Oi/M+PDA666EthExk3u4qTLiyUvfFe6M1cXOUZxtcyCf0oWzMkriP5gpVFS+vJBbAWYSLmxPutXoamZbqt5JBgJDve6c2AJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=tKWdKG0F; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="tKWdKG0F"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ff8cq6XdTzyvd;
	Sun, 22 Mar 2026 23:31:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774215084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8zjP/fswWDD+Rmai8u8vy2W0jj9t+TzFKLDPEHkrOU=;
	b=tKWdKG0FTEVDC9K+2e5DDuXG3PuAwc5a1lhbtFKAmzo3Jm8qTHv98qwU09DX3yqqiHbmbS
	345HXl9NDLj/gG+SapPQvF0vDz2KLnSi4Gl8vzIPscMyaPcWqY9Pe5DWDUqfzbUWMy3LNo
	vVqz9TZ69z2EuAs5E0YUzB9/bLZtv04=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774215084;
	b=g5hJ7Oh/M3SZJenT0QoDDiAHPSei7P2XHSJp08bnV9Hnfw9RlAMboJoDY/EhweqeryPM7D
	5Qr7DkaVs9Xe5QLyeioxiBdhN+1xLgWgRXeR9uTQNF/8iWZDnobnQBAbxofXcgVVYOHV3M
	i8dyFIZYduXBdRHR0+yTOXWkBNe9WQw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774215084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8zjP/fswWDD+Rmai8u8vy2W0jj9t+TzFKLDPEHkrOU=;
	b=ATclt2Cr3DDke7dH4/HmKwbPuWyVidU3V3/Z/mOqLmob0/mdtTqxZfSh9978aEWAOpY72Y
	ubfyJKCF4vhwMbh9HJjdR5YbYkbD5Fmr+X8o8bP9VF4g0Mfh5L+AZSX/zudKVbkcjsaIln
	3zPF/M3c3MOInMKCymXwHihxGKybqqI=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 16/20] test: functional: impose Python code formatting
Date: Sun, 22 Mar 2026 23:31:16 +0200
Message-ID: <5dd78455edf489b925a8a20b58f02962033b12a9.1774214693.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774214693.git.pav@iki.fi>
References: <cover.1774214693.git.pav@iki.fi>
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
index 8c392ff73..ef6147a6a 100644
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

