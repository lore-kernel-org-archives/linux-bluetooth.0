Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F57360ECE
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713425; cv=pass; b=TKrgURG9OnxJZB4boaDWt3XjnxyypzGvWF3AzfxpsjgeAd6uIgVO1PkXa2dYmr0mYGOTtD0CESUh0OX3kl7KD0oVpqkmK1zeRmj/ZD3ArmgJysG9Wnp0tlGy8YO4arZdbn+0a/x1pNnNHwCnePdzxxl+xltuiO+iuxUtnpX2dnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713425; c=relaxed/simple;
	bh=lmyknJAZIeRWOa89TiCcXUi0J4YwabiBlgxwMrPHQsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9EUdNQ/cqocHgTCGhM4E1r8PMof04Le9iI9WSYk4RcT219QvIvzruwkf2y78VST1gNnwT/pX7IP6+/8/0vbApKylTm7DjtusTPxmmM1VDZMF6y2GHm4yZ7tS4oBxZuxcWnPP5m8UXCF8/z5Ok4edXDZKuyW8WlyfEnhbT+ZQKI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=c3NPzMrT; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="c3NPzMrT"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hdGQt4f65zyYR;
	Sun, 06 Sep 2026 19:50:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788713415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPX6s4IhKgX11ZCd8G9D0U1fzG21KIpMDUFALAhmFzQ=;
	b=c3NPzMrTeCer9BUVqvxYTTfZEQAsiKk4g03S7pMTAoYYb1RWF/U0CSdll7HSXLbCyvAMiL
	7OqskNlV2NwSOX6JfsYh7GV5U0eVGnm3ZNjLMoc6xlKRPHTYwT3w5aFRB2k91Da8XqdGAm
	uCoS/dro4SJwev9BAwGSFo312S2hDeQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788713415;
	b=imtVmzTCIbk12cglDCFFKjPfjY3N1HoARGJq29oy4sEU4liyYc3w6ZVZyr1uEphnyyuy29
	gtO23teTCqxE2gvBgTA1AwY4npto2lTwoZsNLWLzK/aIEgzHqj1K09+RsySQ9tUT8VEQ9+
	ZWGymqLJqtu4er6uNoG5aO001sPf7M4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788713415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gPX6s4IhKgX11ZCd8G9D0U1fzG21KIpMDUFALAhmFzQ=;
	b=QHK8Ua8LhJ1ENYXDMdB990MrQGfUi9p4k2xzcHYQ1gGO4437jBk1lZSJv3fjTUGFd4DTZ8
	G2v9v/aEm4YFLJY/gw9hoOrt9VzMMZWTsTrbMbNcbrfcgs68PhhMFISBZP+8MlcSTesgAP
	FQFsGb36fc7AdRCF0ysk8bAC1I84pms=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 4/9] test: functional: impose Python code formatting
Date: Sun,  6 Sep 2026 19:49:46 +0300
Message-ID: <892ecc2a7d95dc4b8e10f77175725a9793320955.1788712996.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788712996.git.pav@iki.fi>
References: <cover.1788712996.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check Python code formatting of the functional test suite.
---
 test/functional/requirements.txt |  1 +
 test/functional/test_tests.py    | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100644 test/functional/test_tests.py

diff --git a/test/functional/requirements.txt b/test/functional/requirements.txt
index e0e3bfee6..b8a1d99ee 100644
--- a/test/functional/requirements.txt
+++ b/test/functional/requirements.txt
@@ -1,2 +1,3 @@
 pytest>=8
 pytest-bluezenv==0.1.9
+black
diff --git a/test/functional/test_tests.py b/test/functional/test_tests.py
new file mode 100644
index 000000000..d196cb1d7
--- /dev/null
+++ b/test/functional/test_tests.py
@@ -0,0 +1,24 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for the test suite itself
+"""
+
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
2.55.0

