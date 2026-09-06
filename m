Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BDC3515D7
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713440; cv=pass; b=O9Jc61VoE0Z5nnmZsDX8N8bMtgB6U4ngCvTGWN4rMPI5nsmxFyQPvP8m3QS3EjDKlMHjmOceJNvPBCqT6lC4p/HX16X+mW8Bg3i1sUu0Xqm4ANGoTQU1INmgSduCQBBG0+bF9y4L9jfuQ/e139B026ltgWQrcwsyk5AT6Hx4Xg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713440; c=relaxed/simple;
	bh=C2Yij+CQ9qCSWuENxIt6n39fAKC+fKVm+Kv9NhxL6Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uIl2uutkfluv9wavJSw3X2+dT9DU0bmY/gXJ8cYrCPlBA0lPieMnfhjv+2sPqNovRY+MS8bV8gJyf0RuvN4yVzoslw0SgcD9zviziTBOAQnzn/JW0g99TFhgL2Lbms5nf65yFYGsvPqqrG1YVLGnkVcXH3XaOMh6Pb42hUfw0i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=oMuy26/L; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="oMuy26/L"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hdGR902SRzyYR;
	Sun, 06 Sep 2026 19:50:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788713429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAEQH7XPeDe03mxHawZya0P87UNcw8kQ7wdyYLL8Q3s=;
	b=oMuy26/La/ipEu606FVJaP+FSsryd+W4qu8HOWr0BjJxVEo27/Q/oOCwfPgMyBODkQSlWj
	Ixj4YQP81bFN88NsIhcpJDwAOuhhavhd7bpYFZPN9Y8n48TSecBBJSnLRo4D1JQqqVF9ux
	v5RW+g40bgcd5/oB5cHyGEFfS2kMNB8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788713429;
	b=L/+T7mgKmHCG5Emyp1mfMxzdmqlRQtEfsiqB9jW3w9G41eJIQWj207tFtVPprPiqRtzeij
	+H+E7VUdfC814auGrDmqs1CIWZZwH92K3EcVg5v2hzY+ffDgvn9Nm5rYJnRsF/vc3UjD7I
	oVVj0pUSFEov5tdjBeImqAvDaLEyEyg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788713429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JAEQH7XPeDe03mxHawZya0P87UNcw8kQ7wdyYLL8Q3s=;
	b=SmJTZmegEAcEhDhOMMgsBcq72lsvI0q2BGbuLAyD6AtmPNz3mZH9w+GWWz65jkD7RjFS3n
	hA4+AcWUDuv+QTWr/mtfAf8LdJiEy8vhD+YNyjoSPFsyGTKcW7BJbWY04FmTRkDd6nr5I1
	8bcL1To9XHfIIhiOIah1uS5b0wF1s+Y=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 7/9] test: functional: add tests running the various kernel testers
Date: Sun,  6 Sep 2026 19:49:49 +0300
Message-ID: <8d645995156954770244ef4350875431e06e92b4.1788712996.git.pav@iki.fi>
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

It's more convenient to have simple local test runner for these.
---
 test/functional/test_kernel_testers.py | 178 +++++++++++++++++++++++++
 test/pytest.ini                        |   1 +
 2 files changed, 179 insertions(+)
 create mode 100644 test/functional/test_kernel_testers.py

diff --git a/test/functional/test_kernel_testers.py b/test/functional/test_kernel_testers.py
new file mode 100644
index 000000000..bfdfb03e7
--- /dev/null
+++ b/test/functional/test_kernel_testers.py
@@ -0,0 +1,178 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for the test suite itself
+"""
+
+import re
+import sys
+import subprocess
+import warnings
+from pathlib import Path
+
+import pytest
+
+from pytest_bluezenv import find_exe, host_config, run
+from pytest_bluezenv.utils import DEFAULT_TIMEOUT
+
+# Testers that can reuse the VM instance
+TESTERS = [
+    "mgmt-tester",
+    "smp-tester",
+    "l2cap-tester",
+    "rfcomm-tester",
+    "sco-tester",
+    "iso-tester",
+    "mesh-tester",
+    "ioctl-tester",
+    "bnep-tester",
+    "userchan-tester",
+    "6lowpan-tester",
+]
+
+XFAIL = {
+    "mesh-tester": {
+        # Always fail:
+        "Mesh - Send cancel - 1",
+        "Mesh - Send cancel - 2",
+    },
+    "mgmt-tester": {
+        # Always fail:
+        "Read Exp Feature - Success",
+        # Flaky, randomly fail:
+        "LL Privacy - Add Device 1 (Add to AL)",
+        "LL Privacy - Add Device 2 (2 Devices to AL)",
+        "LL Privacy - Add Device 3 (AL is full)",
+        "LL Privacy - Set Device Flag 1 (Device Privacy)",
+        "LL Privacy - Set Flags 1 (Add to RL)",
+        "LL Privacy - Set Flags 2 (Enable RL)",
+        "LL Privacy - Set Flags 3 (2 Devices to RL)",
+        "LL Privacy - Set Flags 4 (RL is full)",
+        "LL Privacy - Set Flags 5 (Multi Adv)",
+        "LL Privacy - Set Flags 6 (Multi Dev and Multi Adv)",
+        "LL Privacy - Start Discovery 2 (Disable RL)",
+    },
+}
+
+host_setup = host_config([], controller=False, reuse=True)
+
+
+def run_tester(hosts, tester):
+    (host,) = hosts
+    xfails = set(XFAIL.get(tester, ()))
+
+    tester = find_exe("tools", tester)
+    res = host.call(
+        run,
+        [tester],
+        stdout=subprocess.PIPE,
+        timeout=2 * DEFAULT_TIMEOUT + 60,
+        encoding="utf-8",
+        errors="surrogateescape",
+    )
+
+    passed, failed, not_run = _parse_tester_output(res.stdout)
+    xfailed = []
+
+    for name in list(failed):
+        if name in xfails:
+            failed.remove(name)
+            xfailed.append(name)
+            xfails.remove(name)
+
+    assert failed == [], failed
+
+    if xfails:
+        warnings.warn("XPASS: " + ", ".join(xfails))
+
+    if xfailed:
+        pytest.xfail(reason=", ".join(xfailed))
+
+
+@pytest.mark.tester
+@pytest.mark.parametrize("tester", TESTERS)
+@host_setup
+def test_kernel_tester(hosts, tester):
+    run_tester(hosts, tester)
+
+
+@host_setup
+def test_kernel_selftest(hosts):
+    (host,) = hosts
+
+    tester = find_exe("tools", "check-selftest")
+    res = host.call(
+        run,
+        [tester],
+        stdout=subprocess.PIPE,
+        timeout=2 * DEFAULT_TIMEOUT + 60,
+        encoding="utf-8",
+        errors="surrogateescape",
+    )
+    assert res.returncode == 0
+
+    if not res.stdout.strip():
+        pytest.skip("CONFIG_BT_SELFTEST not enabled")
+
+    assert "PASS" in res.stdout, res.stdout
+    assert "FAIL" not in res.stdout, res.stdout
+
+
+def _parse_tester_output(output):
+    total_count = 0
+    passed_count = 0
+    failed_count = 0
+    not_run_count = 0
+
+    passed = []
+    failed = []
+    not_run = []
+
+    in_summary = False
+    for line in output.splitlines():
+        line = line.strip()
+
+        if "Test Summary" in line:
+            in_summary = True
+            continue
+        if not in_summary:
+            continue
+        if "----" in line or "Overall execution time" in line or not line:
+            continue
+
+        m = re.search(
+            r"Total: (\d+).*Passed: (\d+).*Failed: (\d+).*Not Run: (\d+)", line
+        )
+        if m:
+            total_count += int(m.group(1))
+            passed_count += int(m.group(2))
+            failed_count += int(m.group(3))
+            not_run_count += int(m.group(4))
+            continue
+
+        m = re.match(r"^([\x20-\xff]+)\s+.*(Passed|Failed|Not Run|Timed out)", line)
+        assert m, line
+
+        name = m.group(1).strip()
+        verdict = m.group(2).strip().lower()
+
+        if verdict == "passed":
+            passed.append(name)
+        elif verdict in ("failed", "timed out"):
+            failed.append(name)
+        elif verdict == "not run":
+            not_run.append(name)
+        else:
+            raise ValueError("Unknown {verdict=!r}")
+
+    # Check we parsed everything
+    if len(passed) != passed_count:
+        raise ValueError(f"Invalid {passed_count=}, {passed=}")
+    if len(failed) != failed_count:
+        raise ValueError(f"Invalid {failed_count=}, {failed=}")
+    if len(not_run) != not_run_count:
+        raise ValueError(f"Invalid {not_run_count=}, {not_run=}")
+    if total_count == 0:
+        raise RuntimeError(f"No tests ran")
+
+    return passed, failed, not_run
diff --git a/test/pytest.ini b/test/pytest.ini
index 92820e819..6b97c6525 100644
--- a/test/pytest.ini
+++ b/test/pytest.ini
@@ -5,6 +5,7 @@ log_level = 0
 log_file = test-functional.log
 markers =
     vm: tests requiring VM image
+    tester: kernel testers
 
 addopts =
     -p pytest_bluezenv
-- 
2.55.0

