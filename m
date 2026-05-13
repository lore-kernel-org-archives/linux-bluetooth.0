Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B5E426D33
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689128; cv=pass; b=g+alWL2rZUPMU8f0aFZA0kJTqwLaucmfUA9PamzvMv+eKG2NoYfW369S2VIOolYS+SoWbUEBI/EodXbgRDriZNFlKFQovQcPOJ4tq4z9rkpuhvYh3lbf+NncXQPZMf33SWxSDBjmsxeBUd/UZIa+vKnGWTlimhfENKGWbuRDaUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689128; c=relaxed/simple;
	bh=bATZebX0CVc/Thceid5aVLdRj6hlk4ZoD2bHh98MxEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mXzkX0lqJidSham6UTck0z4FLKSOM3XnvYuuNBeKPVQ8bhspeYdYlgsZzLEq8rRYTCTEq22Y+8+/3MQ+BM3NvXaBuTgeX6OHDvi9is8cv8AdKr6leCXpmj/GZOKh9SI3LCkPkO+t7YpwxWVFXAgfizVl0ZpnbJoGmmWKsZ/BA3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=knzNld+D; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="knzNld+D"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gFzD54Jr6z10PB;
	Wed, 13 May 2026 19:18:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778689125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aJvYovroQIQ0jEMpNYJKyI2nTdREdfHHiUSEXNMsj8=;
	b=knzNld+DbWx/A/SCZ1r6uNShk4nQSfCDKnAb+vPx/lyD723RDCDtT1hsQGa4iPeAg2YgN5
	9xsMkrrxFwz8MPg64Dy2IN0jmUXOtP+WYbQlCnhQopuj5JsKRF6cGoLZA1I5STwRCrzkTy
	N5l9K/XeA14yJW6+iiIDqCTxbXCZbt0=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778689125;
	b=EqfKeiKOIApdNOCKYFDtJbOol16hth9iImEnJr3lOk/qELQJ0w4YkAp2unUCanjojfmrZ/
	eseILlELhI4Fj6pv2iI/7v9qre9/kX5SG++4yI24dGkXMy5CEDDbGCaM39TCd1tnSzw+Tb
	E1x2gAukuvyYy9AlHGc5fnBA9iIKCKQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778689125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aJvYovroQIQ0jEMpNYJKyI2nTdREdfHHiUSEXNMsj8=;
	b=LR8ioeleQDJqGraBKcvAmncpvT7CLJnQFb7cSQhV30CPuU3T9aHu3FPNS+/Pp45JqCxxcx
	zUbnuTJrzXRieE5EPNHlB/I2BB7RQvIDApVRTStYB8NoxlW30xd0VRghdDqmGO/oRwJ+TP
	dlOF9KdTnLGOGsn8VuLAm8wTQRtIIzk=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 14/16] test: functional: impose Python code formatting
Date: Wed, 13 May 2026 19:17:31 +0300
Message-ID: <f19d7fde3314e9d1f03919b4cf60c92b750ab036.1778688966.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778688966.git.pav@iki.fi>
References: <cover.1778688966.git.pav@iki.fi>
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

