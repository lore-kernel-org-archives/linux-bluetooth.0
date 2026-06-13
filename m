Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAF73FDBFE
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jun 2026 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781365744; cv=pass; b=BiEepf4z+AhGy+ZB1ecnKfNftuQM4EJiFdXy2HlvqPS1fgBvoFWx/XdlLPgXma1lCWJv4THufFYK+yoP6GZ8KLrUb/v99WV+dG6dmAk7r6pAvX4bY+mAQrjANNeNG4G/10xl1QSs3FLN9voexrqQ4BsnagtX1hsy1dvX5DMny/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781365744; c=relaxed/simple;
	bh=bATZebX0CVc/Thceid5aVLdRj6hlk4ZoD2bHh98MxEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h7zBwy0Ks/GXi+lgkIpGDRVBqz9qgUXFIYVJ4VfAdL8aQj/RwO9puO4D1fUUrfvEc8L2jDoxSO3sIsSI4kyDgDAEEXJhngC/amDjCPiXzg3m5rspzj1Q7FtWvcBPoGjQsk/cXbi1RMCeG63Nr8Aeh/yzS/CJBlRnPHWUjOZ0ubs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=V+Qrv95g; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="V+Qrv95g"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gd15S59gtzygC;
	Sat, 13 Jun 2026 18:49:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1781365740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aJvYovroQIQ0jEMpNYJKyI2nTdREdfHHiUSEXNMsj8=;
	b=V+Qrv95gqbOHZDfNkfn+c5hqvPRtMpQQ+7C3AuOxqQxH197NNp+tUEh/xd+nx3R0LkF2WV
	fvXcY41kZQIFQwTzLvhQrlRpI6ayWOXphR8vef2tr4wKI3GvrpdoyyXUnlLVoz/PCG7dtp
	FjIZGQojv/SInUuRDjFwD+GdBrp54wM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1781365740;
	b=OydqwgPTBa6wzAmNKSshKFRQWzFywULKxfjkJ1bgyg3eEj8bUwiDHamkirJ1XPRKjoSjgL
	wx/exbvJHYWDzc98SNj1xEJFMFX5EOvGaFZjC1X2h7lF4OCRWq+YcN8U3AMsJ98bnxhInF
	NdMcGhfa5VqVwpkIwUkD1kmeEEgkF10=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1781365740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aJvYovroQIQ0jEMpNYJKyI2nTdREdfHHiUSEXNMsj8=;
	b=K54SqX+Z4sXT7H738AL5dzqloklydl5YJ8mQUZMAFz62dNJBSK8KUAZZhdymjMUB3OQFa2
	eSZHnQaSda5yKyZQxTrQxZ6Nv2Rnag7tPvUA4jXP7IYtny9HDJd4DpEnAFzhAQjNgnATDL
	+eR3y8ESP2CWxxDkeRUtVUCD/OYHwbo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v6 4/6] test: functional: impose Python code formatting
Date: Sat, 13 Jun 2026 18:48:50 +0300
Message-ID: <092297f43c569af469650284b483dd2f80841989.1781365708.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1781365708.git.pav@iki.fi>
References: <cover.1781365708.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check Python code formatting of the functional test suite.
---
 test/functional/test_tests.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 test/functional/test_tests.py

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
2.54.0

