Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF745341ACA
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392888; cv=pass; b=F+ZfElrEN+Xm9MP6UaA12m0NPjw67FXT0OdYWQ6+mpmNtBVZYZ4KdzPGnK7TRIVO4Pciy2oRW9AblAVBDiv1gdPAfaD6aL5NJVhNrMxCDO3IZYFAjijouhd34CNApm1MqOFx9j/NkLlweEvs60JwTKQyypzIo1DmZpCW+jmj1fU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392888; c=relaxed/simple;
	bh=3OHQt0o0aajYNYQjZolPiWvtkMPQGRTB6H2erhT2TJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWrYX6578kDMhImrrlhk045VCNlpgAzH7Pb5DEOV77aSGvP3ZVR3mMuIjU5nX7+jeiT5mRxsZkPE/jFPQfI8lsy1KT1dMx0tOEena4L51bJR4Zs7FEBrp8/UaBjGx6JAipF1GHjDYND8kQNRXLhj8SiAE545IINoXdBSd/0Gz8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vTBPxwgm; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vTBPxwgm"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpXBr42SZzyWt;
	Sun, 05 Apr 2026 15:41:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8zjP/fswWDD+Rmai8u8vy2W0jj9t+TzFKLDPEHkrOU=;
	b=vTBPxwgmzHVaSseCbOazQkPPEXhIKcPvMuv41w25xijXZJmEFGr3Bthq8q+lF6JZEh0vdt
	mYjNZ9jrMKW2tQE8z8eugo3iOPElmKt8+Nq7CFh5mceirkiO+FL3qIiRMsP4RwjMC40NUY
	KBc/+QEXtA9vzObM1DFrUng3nVSWMdg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8zjP/fswWDD+Rmai8u8vy2W0jj9t+TzFKLDPEHkrOU=;
	b=MqT2AEttReEfwBleIf8iFlAdkCafYu7yw4zlTAfY6UxOVN5sTmqZr7U8YG+SeRalGDaLkJ
	7qKT8yujI4gak+rXTXadphITnHr16KxoJJ+OeKsF9rcgKj2rgK46i4dAdeas1xGRVW2vFC
	vK7u2nr1JJ95H1R8fYwdXtR05+G/Z3A=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392884;
	b=ZaxBDgZvo4DEtrF/W7RfgeQ8U+lFUc1cl7t0r7/NKfB/oVLq2qGjik7Gzy55fE6tdfayBJ
	Q8hLQoOlTJ6ivxP0tyHd3l6NbrftDTXe4h0y3iRf7QRLBNTv3Sl408FXTtlbkWXysCd2Ae
	/pkC+mR4sSgWmXEAWJe/PsNTwAznOoo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 16/20] test: functional: impose Python code formatting
Date: Sun,  5 Apr 2026 15:39:57 +0300
Message-ID: <047b3cc85b11d0b47991bc6dd275a34da0cb854f.1775392680.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775392680.git.pav@iki.fi>
References: <cover.1775392680.git.pav@iki.fi>
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

