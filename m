Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A5A36212F
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041138; cv=pass; b=Ryjw1EggVXgL4S2rdWS3BNpTVP1NanZwu1VaoKjoFxVyeT9Aion2glMIuPdnBrYnVyeTu2N2Amyl5gznMjDlXYU1Ar5d+yW5qfVsD+IT/FFqLEnX/YJFMZ0yuVgAldxTPehdcgWzvBH8pR6GQN7oowzVi85fKrOftlO4LC1jJD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041138; c=relaxed/simple;
	bh=J8v8cYp9BDm41VaLmIcdKS+2ZRxE90ICFR0tA0CuRUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oa8BSRHn8G7eXtGlk4aa8lhwTUvyokiQ3JVMi/dmyAaBWXUmtGRxgw3GtV37jLWONu718Bi/UufT3LWj17E73sjke1RFWL6+1bdlBd4ij+BiZi4NHLhjUecXWRjcb3dCm8+hnxUNXwhsnmgxisz+bCTZuA6IDeSTRYrbkFtEQsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=GN6IC6Fx; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="GN6IC6Fx"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fcwHg16B7zyRl;
	Fri, 20 Mar 2026 23:12:14 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774041135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJGj+GT6/bHWJLzpt6OTem7ZVBntoCKAj0eofSqbISw=;
	b=GN6IC6FxOa1vX1apSmfRna60ut8OkM5/emGhfTtOjcp1Fi10grtdXZgce8aLhS7cFP9I+s
	vJs/KIRXT5fxoImJkfdemYnv68Zq5rosYVyELKt7K4kIG7Eo5DT4Z17bl8KpzDatyTb8G+
	ZmEkHMj05G4UYyCm137uZ3VpyQ2/ybQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774041135;
	b=Sb5xtt++Z8NsYtig/q1pGCDMH9HRSCuKh9Pt5Ah81ItQ4bD/qhIdjU7SVVm3nHY8eqmQTw
	0xe3UemWcZiVDP6dBawF4pzvsAvKEMSVOZIVzxUoXqYZ2Dbo5bSLus8592d/9phoTQ592w
	oJp/OqwkyK8D6yBlzZpjiife/NtAAC0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774041135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJGj+GT6/bHWJLzpt6OTem7ZVBntoCKAj0eofSqbISw=;
	b=dwizwopeCsDDXnB+qBb03LMIO6eqKCMtvDZDG1Y9c/fRRMPjBs1atcZlUahJd+W9VrdMs5
	Jo4Ef62qBVhMdPGDxbzLdp4c1gYFmRxdTFBh+mA1pe3rhaM2DLpOxXDjjDBxDwmsolKDdG
	rhiLfl2T90jW+u3DWkZBF1KWwJeJgwk=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 17/20] test: functional: add option for building kernel image first
Date: Fri, 20 Mar 2026 23:12:04 +0200
Message-ID: <31c6bebd260a86e5ee4edd6a0f36081a275b1e12.1774041047.git.pav@iki.fi>
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

Add convenience option test/test-functional --kernel-build to build a
kernel image first.
---
 doc/test-functional.rst           | 21 +++++++++-
 test/pytest.ini                   |  4 ++
 test/pytest_bluez/build_kernel.py | 43 ++++++++++++++++++++
 test/pytest_bluez/plugin.py       | 65 ++++++++++++++++++++++++++++++-
 4 files changed, 131 insertions(+), 2 deletions(-)
 create mode 100644 test/pytest_bluez/build_kernel.py

diff --git a/doc/test-functional.rst b/doc/test-functional.rst
index f5b7aa7c8..311a5a4c1 100644
--- a/doc/test-functional.rst
+++ b/doc/test-functional.rst
@@ -11,6 +11,15 @@ DESCRIPTION
 kernel using multiple virtual machine environments, connected by real
 or virtual controllers.
 
+EXAMPLE
+=======
+
+.. code-block::
+
+   $ ./configure --enable-functional-testing --enable-testing --enable-tools
+   $ make -j8
+   $ test/test-functional --kernel-build -v
+
 OPTIONS
 =======
 
@@ -50,6 +59,12 @@ The following additional options apply:
 
 :--list: Output brief lists of existing tests.
 
+:--kernel-build=no/use/auto/force: Build a suitable kernel image from source.
+
+:--kernel-upstream=<GIT_URL>: URL for Git clone of kernel sources.
+
+:--kernel-branch=<GIT_BRANCH>: Git branch to build from.
+
 Tests that require kernel image or USB controllers are skipped if none
 are available. Normally, tests use `btvirt`.
 
@@ -102,7 +117,11 @@ Kernel
 ------
 
 The **test-functional(1)** tool requires a kernel image with similar
-config as **test-runner(1)**.  Simplest setup is
+config as **test-runner(1)**.  If given `--kernel-build` option, a
+suitable image is built from sources downloaded under
+`test/.pytest_cache`.
+
+Simplest setup is
 
 .. code-block::
 
diff --git a/test/pytest.ini b/test/pytest.ini
index e77d7e4ee..b99225df2 100644
--- a/test/pytest.ini
+++ b/test/pytest.ini
@@ -12,3 +12,7 @@ addopts =
 
 # Default timeout
 vm_timeout = 30
+
+# Default sources for kernel-build when requested
+kernel_upstream = https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/
+kernel_branch = master
diff --git a/test/pytest_bluez/build_kernel.py b/test/pytest_bluez/build_kernel.py
new file mode 100644
index 000000000..7aebb918a
--- /dev/null
+++ b/test/pytest_bluez/build_kernel.py
@@ -0,0 +1,43 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+import subprocess
+import shutil
+import os
+from pathlib import Path
+
+from . import utils
+
+
+def run(*cmd):
+    print("\n$", utils.quoted(cmd))
+    subprocess.run(cmd, check=True)
+
+
+def build_kernel(base_dir, upstream, branch):
+    src_dir = utils.bluez_src_dir()
+    if src_dir is None:
+        raise ValueError("Can't find BlueZ source directory")
+
+    tester_config = src_dir / "doc" / "tester.config"
+
+    base_dir = Path(base_dir)
+    repo = base_dir / "linux"
+
+    if not repo.exists():
+        run("git", "clone", "--depth", "1", upstream, str(repo))
+
+    run("git", "-C", str(repo), "remote", "set-url", "origin", upstream)
+    run("git", "-C", str(repo), "fetch", "--depth", "1", "origin", branch)
+    run("git", "-C", str(repo), "reset", "--hard", "FETCH_HEAD")
+    run("git", "-C", str(repo), "clean", "-f", "-d", "-x")
+
+    config = repo / ".config"
+    shutil.copyfile(tester_config, config)
+
+    ncpu = os.cpu_count()
+
+    run("make", "-C", str(repo), "olddefconfig")
+    run("make", "-C", str(repo), f"-j{ncpu}")
+
+    kernel = repo / "arch" / "x86" / "boot" / "bzImage"
+    return kernel
diff --git a/test/pytest_bluez/plugin.py b/test/pytest_bluez/plugin.py
index 786493ffb..2d5ab5f6f 100644
--- a/test/pytest_bluez/plugin.py
+++ b/test/pytest_bluez/plugin.py
@@ -9,7 +9,7 @@ from pathlib import Path
 
 import pytest
 
-from . import utils, env
+from . import utils, env, build_kernel
 from .btmon import Btmon
 
 
@@ -123,6 +123,37 @@ def pytest_addoption(parser):
         default="1048576",
     )
 
+    # Kernel build
+    group.addoption(
+        "--kernel-build",
+        action="store",
+        choices=("no", "use", "auto", "force"),
+        nargs="?",
+        default="use",
+        const="auto",
+        help="Build and cache a suitable kernel image if none given (no/use/auto/force)",
+    )
+    group.addoption(
+        "--kernel-upstream",
+        action="store",
+        default=None,
+        help="For building kernels: kernel upstream Git url",
+    )
+    group.addoption(
+        "--kernel-branch",
+        action="store",
+        default=None,
+        help="For building kernels: kernel upstream Git branch",
+    )
+
+    parser.addini(
+        "kernel_upstream", "Kernel upstream Git url to use for building kernels"
+    )
+    parser.addini(
+        "kernel_branch",
+        "Kernel upstream Git branch /  commit to use for building custom kernel",
+    )
+
 
 def pytest_configure(config):
     if config.option.list:
@@ -152,6 +183,38 @@ def pytest_configure(config):
             level=config.getini("log_file_level"),
         )
 
+    if config.option.kernel_build == "force":
+        config.option.kernel = _build_kernel(config)
+    elif (
+        config.option.kernel_build in ("auto", "use")
+        and config.option.kernel is None
+        and not os.environ.get("FUNCTIONAL_TESTING_KERNEL", None)
+    ):
+        cache_path = config.cache.mkdir("kernel")
+        kernel = cache_path / "bzImage"
+
+        if kernel.is_file():
+            config.option.kernel = kernel
+        elif config.option.kernel_build == "auto":
+            config.option.kernel = _build_kernel(config)
+
+
+def _build_kernel(config):
+    cache_path = config.cache.mkdir("kernel")
+    kernel = cache_path / "bzImage"
+
+    upstream = config.getoption("kernel_upstream") or config.getini("kernel_upstream")
+    branch = config.getoption("kernel_branch") or config.getini("kernel_branch")
+
+    capturemanager = config.pluginmanager.getplugin("capturemanager")
+    with capturemanager.global_and_fixture_disabled():
+        print(f"\n\n=== Building kernel in {cache_path} ===\n")
+        new_kernel = build_kernel.build_kernel(cache_path, upstream, branch)
+        print(f"\n\n=== Kernel build done ===\n")
+
+    os.rename(new_kernel, kernel)
+    return kernel
+
 
 COLLECT_ERRORS = []
 
-- 
2.53.0

