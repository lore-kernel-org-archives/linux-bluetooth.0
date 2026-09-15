Received: from mail-vs2-f41.google.com (mail-vs2-f41.google.com [74.125.227.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7BE4A4EE2
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506944; cv=none; b=Ge5aKUqKqgK65zlF1C0W/dqkXu3QamuPPIZ6MWYS7fmehUZYcFd/ZiofdD0QkjVDWlT28JA5oDvFRNBDcltyXJzWbPcutlrO6/L3ZjJs47trE9dr3Z+ulGFrmAq3U4hnX+h7zUADR4CFzUTaUHnCeUPdoCOb6cmQAGZ9Go2Pcj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506944; c=relaxed/simple;
	bh=ZuGhiAytHycMa++qYNaPTdqI3QYvmu31YULopbcIPkM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qz//me3REKonhGVV/8E+vo0QKEMvJ8Ng9eL9fl6anTSTtACfsSOEO+jSHiewcH2vRoJaN3lgYbIApboEWatnRh135K1Um2nlfHSYNoaxNKfRJ75IafyQTq3w2ypUMoPlNgMoB3ag+dhOtOwMGZ6/5f7TIjWJAZasbjiLx/E0lMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/PUdX4w; arc=none smtp.client-ip=74.125.227.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/PUdX4w"
Received: by mail-vs2-f41.google.com with SMTP id ada2fe7eead31-78564319a92so63901137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789506941; x=1790111741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P0w/94cSyG9sgIkFkG56EtF53YBl2X3wnRflfpaD64E=;
        b=V/PUdX4wXTm1DhvgPwcEiv8hVr0uj6v/s9jgrysqb8ydIvjhHe/EV9OrEbVBDhvJRk
         bbdnfn9GQ+vQY/+/XEQdhIFaR9Vn0QAl6Xmhl9wW5VrjC4+Z9E8GMopgKvNC5tUn2mLy
         6eZjsQdrDOfg5q/qiIPEKkeNMoy32c4Dg89iRlPmAe+/BO111iElg5j/4V9EIlNLAUJM
         bWQoTm5+McjLmQWAQrzovZ51d0xQCwU3Y3No/C0eB+GytQGDfaPnxSwTwEX11BeWC3p1
         gUn5TL22xJ+bTYZPoyz3YCuPWkA4nbkvnJvawhCLmhWZ1X9LNZgO1Vj2r6vnvc9KqZUF
         NKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506941; x=1790111741;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=P0w/94cSyG9sgIkFkG56EtF53YBl2X3wnRflfpaD64E=;
        b=sDSbuYOVGDocCQ7OFLIEwhwR0h6Af5I3Be2yaNog+RocR2vtf5eKwga01nESblnpxe
         T3XHB3hwgEzOxh0TxiwA98aeSB6aK7RVp40DuRAP6DYdfbvU6FksHhBehl3aZ25LfSwi
         xeCGLobvjd7lEhQPlvUwEq/3chtCZy8aJUkz5dkyy1tOqgVCNTifjv29EP8YTd4QwjmT
         HF/5tsEpQi0RHQgRVsF8j1oR0C6OxjQ87Y94bomdood8FY7us7NVhUJPpt9f95tCCc86
         dj1vivQX5YRZt14lPQGQnqQ25J4h0cEMpyop4sPed347BnCKYpn+S1HAC/jbokZd/Igr
         v/dg==
X-Gm-Message-State: AFuF++ni3p49eQ7say5+diRLZl359+shP8eK25AjvhDkTjjdG3FiIAky
	7XMinGmG0WoGzOoe4vpscqwzOPltfH+J3V0/p/vK0YBOQ/6hVP3Vtd9dXllvKvnb
X-Gm-Gg: AYBFou0d2AiQe/r8ruVUXtGQnsOW8JvpGjoP/HcDOniJLKbnGrTv/1OTI+79VQxOPfB
	nQvt4SqMftaaGU1NylQrk7CNY6yRoRLftWKMow2pS0GncSXvZMj2RYGPiPZzKk5NeypVEiBIlvM
	ClTlKO8pfoMBGLGXZTKH4mFGxOyexaKnngOCfaJsiIQUQ0/lsHdk7tHyTk8IJqppyd7KED78oA9
	xkw5jT3wHHXiyBSowGmHf8cbUvkLo4npat30l1s/sHqr5F8vPcEhrbr7W6eJEzG5/2BTRVy/8DH
	wcs2plj2V9MT7V+4L2ExiwKfemNqM+9Vv42XupBJ7Pj0WiJ2v+Ko65A0YpoIxIJlWmuMSebz/FZ
	6oZ0hiEd135H5vo7Tzm4QXcnsejYiI3lafMxH82Tqlie12RX/DpRA2zyUTteoMytlgqXrnXPaJB
	EDoSVIRwikDPtiWH+kI429bEI/tN9d6vDG15p+m0phggdj2ZxZqjt1/MgZZR9xackJ7uwh/zDhr
	p//g7Y+MGUKIH0enjCjoIc300N/LgTXC2C5hT+hjQGD/Ak4g9UWJEAld/dE0LYycE9T3TtCOAeN
X-Received: by 2002:a05:6102:5493:b0:789:5f54:2367 with SMTP id ada2fe7eead31-7a026088a71mr427988137.4.1789506940831;
        Tue, 15 Sep 2026 14:15:40 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98314dd7ceasm746860241.1.2026.09.15.14.15.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:15:40 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 03/11] test: functional: report what a test is waiting for
Date: Tue, 15 Sep 2026 17:15:20 -0400
Message-ID: <20260915211528.1223784-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915211528.1223784-1-luiz.dentz@gmail.com>
References: <20260915211528.1223784-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

A test that is stuck gives no clue about what it is waiting for until it
times out, which makes it hard to tell a slow test from a hung one.

Report the calls that take too long, along with how much of their
timeout is left. When the terminal can be updated in place the report is
refreshed as it goes and erased once the call completes, so only the
waits that are actually slow are visible. The workers of pytest-xdist
share the terminal, and none of them can update a line of its own, so
they report whole lines instead, prefixed with the worker they come
from.

The report goes to the terminal directly, as pytest captures the output
at file descriptor level, and is disabled when there is none, e.g. under
CI, or with --progress=no.

Assisted-by: opencode:claude-opus-5
---
 test/functional/conftest.py | 201 ++++++++++++++++++++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/test/functional/conftest.py b/test/functional/conftest.py
index ce6301319031..4e0bda882de3 100644
--- a/test/functional/conftest.py
+++ b/test/functional/conftest.py
@@ -2,9 +2,14 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 import os
 import re
+import sys
+import threading
+import time
 from pathlib import Path
 import pytest
 
+from pytest_bluezenv import rpc, utils
+
 from .le_utils import host_setup_is_le, pair_le
 
 
@@ -15,15 +20,211 @@ def pytest_addoption(parser):
         default=None,
         help=("List tests"),
     )
+    parser.addoption(
+        "--progress",
+        action="store",
+        default=None,
+        choices=["yes", "no"],
+        help=("Show what a test is waiting for (default: yes on a tty)"),
+    )
+
+
+# Wait for this long before reporting what a call is waiting for, so the
+# calls that complete right away do not produce any output
+PROGRESS_DELAY = 1.0
+PROGRESS_INTERVAL = 0.25
+
+# When the line cannot be updated in place the report is repeated at this
+# interval instead, and only once the call is taking clearly too long
+PROGRESS_LINE_DELAY = 5.0
+PROGRESS_LINE_INTERVAL = 10.0
+
+PROGRESS_STREAM = None
+
+
+class Status:
+    """
+    Status line telling what a test is waiting for, updated in place by
+    the terminal reporter of pytest so the report it writes itself is
+    left alone.
+    """
+
+    def __init__(self, reporter):
+        self.reporter = reporter
+        self.shown = False
+
+    def show(self, text):
+        # Leave the line pytest is on, so what it reports there is not
+        # overwritten by the status. Nothing is written when the line
+        # is already one of ours.
+        if not self.shown:
+            self.reporter.ensure_newline()
+            self.shown = True
+
+        self.reporter.rewrite(text, erase=True, light=True)
+
+    def clear(self):
+        if not self.shown:
+            return
+
+        self.reporter.rewrite("", erase=True)
+        self.shown = False
+
+
+def _progress_desc(name, method, a):
+    """
+    Describe what a call is waiting for, e.g.
+
+        host.0.1: pexpect.expect 'Pairing successful'
+    """
+    if method == "call_plugin" and len(a) > 1:
+        plugin, func, args = a[0], a[1], a[2:]
+
+        # Drop the identifier of the spawned process, if any
+        if args and isinstance(args[0], int):
+            args = args[1:]
+
+        desc = f"{plugin}.{func}"
+    else:
+        desc, args = str(method), a
+
+    if args:
+        arg = args[0]
+        # Calls running something on a host pass the function itself
+        arg = getattr(arg, "__name__", None) or str(arg)
+        if len(arg) > 60:
+            arg = arg[:57] + "..."
+        desc = f"{desc} {arg!r}"
+
+    return f"{name}: {desc}" if name else desc
+
+
+def _progress_status(elapsed, timeout):
+    if timeout:
+        left = max(0.0, timeout - elapsed)
+        return f"{elapsed:.0f}s, {left:.0f}s left"
+
+    return f"{elapsed:.0f}s"
+
+
+def _progress_run(status, desc, timeout, done, stream=None, prefix=""):
+    start = time.monotonic()
+    next_line = PROGRESS_LINE_DELAY
+
+    while not done.wait(PROGRESS_INTERVAL if status else 0.5):
+        elapsed = time.monotonic() - start
+
+        if status:
+            if elapsed < PROGRESS_DELAY:
+                continue
+
+            status.show(f"waiting {desc} [{_progress_status(elapsed, timeout)}]")
+            continue
+
+        # The line cannot be updated in place, so report it as it goes
+        if elapsed < next_line:
+            continue
+
+        next_line = elapsed + PROGRESS_LINE_INTERVAL
+        stream.write(
+            f"{prefix}waiting {desc}" f" [{_progress_status(elapsed, timeout)}]\n"
+        )
+        stream.flush()
+
+    if status:
+        status.clear()
+
+
+def _progress_call(orig, status=None, stream=None, prefix=""):
+    def call(self, method, *a, **kw):
+        # The timeout of the calls waiting for something on a host is the
+        # one used by the plugin serving them
+        timeout = kw.get("timeout")
+        if not timeout and method == "call_plugin" and "expect" in a[:2]:
+            timeout = utils.DEFAULT_TIMEOUT
+
+        name = getattr(self.log, "name", "")
+        name = name[len("rpc.") :] if name.startswith("rpc.") else ""
+
+        done = threading.Event()
+        progress = threading.Thread(
+            target=_progress_run,
+            args=(status, _progress_desc(name, method, a), timeout, done),
+            kwargs={"stream": stream, "prefix": prefix},
+            daemon=True,
+        )
+        progress.start()
+
+        try:
+            return orig(self, method, *a, **kw)
+        finally:
+            done.set()
+            progress.join()
+
+    return call
+
+
+def _setup_progress(config):
+    """
+    Report what a test is waiting for, so it is possible to tell when one
+    is taking longer than it should.
+    """
+    global PROGRESS_STREAM
+
+    if config.option.progress == "no":
+        return
+
+    # The workers of pytest-xdist run in their own process and share the
+    # terminal with each other and with the controller reporting the
+    # results, so none of them can update a line of its own: report the
+    # calls taking too long as whole lines instead
+    worker = getattr(config, "workerinput", None)
+
+    if not worker:
+        reporter = config.pluginmanager.get_plugin("terminalreporter")
+
+        # No markup means no terminal to update a line on, e.g. when the
+        # output is redirected or under CI
+        if not reporter or not reporter.hasmarkup:
+            return
+
+        rpc.Connection.call = _progress_call(
+            rpc.Connection.call, status=Status(reporter)
+        )
+        return
+
+    # The output of a worker is captured at file descriptor level and
+    # forwarded to the controller, so it goes to the terminal directly
+    try:
+        PROGRESS_STREAM = open("/dev/tty", "w", buffering=1)
+    except OSError:
+        # Not running from a terminal, e.g. under CI
+        return
+
+    rpc.Connection.call = _progress_call(
+        rpc.Connection.call,
+        stream=PROGRESS_STREAM,
+        prefix=f"[{worker['workerid']}] ",
+    )
 
 
 def pytest_configure(config):
+    _setup_progress(config)
+
     if config.option.list:
         config.option.reportchars = "A"
         config.option.no_header = True
         config.option.verbose = -2
 
 
+def pytest_unconfigure(config):
+    global PROGRESS_STREAM
+
+    if PROGRESS_STREAM:
+        PROGRESS_STREAM.close()
+        PROGRESS_STREAM = None
+
+
 COLLECT_ERRORS = []
 
 
-- 
2.55.0

