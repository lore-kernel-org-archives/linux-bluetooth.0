Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F4E3019D6
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392892; cv=pass; b=KzJZexy/o1c2XvfK5G/4bYDibdHDn1ydyN7F9c9NtOPxsGHZDgeMetBkw0GCs/DbKR3tmv5tsOGe6wdjoibdIE5SGx4I6+70CS/MkqWtNddsbSxg97YFqy3GoEqdTNPtCzdFKrhJXVP9GdLytiAAL5Xzl7QhkmIr2elLowP4aho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392892; c=relaxed/simple;
	bh=0+mNuQcMu6oFpJ2wnt+HjKneicOLZ/4ZsoA8drr8PKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTLQJD2+3bXWEFKh/31uPAaIRkYIA8Ng9OH4CnBfAQ7znOP8UMk04CQVNQfXSHli8efQPJPNVLv46UvkCujRMlBTFEQ75LnK3J5aE5qvoSgAaT4uiYq6McAd4y3XdhenEZ6NiqqrLGuvEyB9L45vp0sWKiebtiM52VYTo6PbJYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=g3mReZsA; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="g3mReZsA"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpXBs3XD0zyZR;
	Sun, 05 Apr 2026 15:41:25 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zt8wcTOGi7hyGcKBPJp7naomQZYpEVLJgu0uxAKCg5A=;
	b=g3mReZsApUjzNHG38dbumL2KqZHnMixw768SDZFvlwHm41hl9yo21wVKCnyGa01fnNxQal
	l+HbfctO8ZFaQ0NZgWCn0d+t/Jlv1SLAJzhTmCVnUfmnRZ2o70qcx28mm2tvuyVA4aX3UL
	FqdU360343ykZ38WifYgi3z0u1rK+GQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zt8wcTOGi7hyGcKBPJp7naomQZYpEVLJgu0uxAKCg5A=;
	b=S6eNLw5ttQxtH80UOk6lNdAMnsoMJtaF6SCuEtKxANA+mMsrq5WzncNa0qR/0D3p1ETkHN
	JLHU9TGUlRraPpsOC9slnBYP6ImWZOV6BvuJ3q2hRWC8SRtWfQPXU7qezsBLSQQoOaLnzg
	46abuUYkNMfc+l7To53d2FWje/UEG1Q=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392885;
	b=tFGnIL5DUn9GQ+H3uhNvMiJ4kom5ewoyJq+6spEsTT2fpQkjAvn0oEAfdIEpB0gzx7/ljm
	I35h+aYiAlY+JzcU3RTd7DfQxNkSTHyi4tjH7v/4Jw2IPt3L4nUsv1O1HTBf/+6f2+gkY+
	g4ZdGaidjHTvSvGvSEp87Av4X0Megjo=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 17/20] test: functional: add option for building kernel image first
Date: Sun,  5 Apr 2026 15:39:58 +0300
Message-ID: <d8c78a4ebdb2b8baaae674cc63718e02da10da63.1775392680.git.pav@iki.fi>
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

Add convenience option test/test-functional --kernel-build to build a
kernel image first.

The point in this is to make running tests simpler for contributors, so
that they don't need to read instructions what options the kernel should
be built with just for running these tests.
---
 doc/test-functional.rst           | 21 +++++++++-
 test/pytest.ini                   |  4 ++
 test/pytest_bluez/build_kernel.py | 43 ++++++++++++++++++++
 test/pytest_bluez/plugin.py       | 65 ++++++++++++++++++++++++++++++-
 4 files changed, 131 insertions(+), 2 deletions(-)
 create mode 100644 test/pytest_bluez/build_kernel.py

diff --git a/doc/test-functional.rst b/doc/test-functional.rst
index ef6147a6a..a03d2e461 100644
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
index 9f7e2b369..96de4e6da 100644
--- a/test/pytest_bluez/plugin.py
+++ b/test/pytest_bluez/plugin.py
@@ -10,7 +10,7 @@ from pathlib import Path
 
 import pytest
 
-from . import utils, env
+from . import utils, env, build_kernel
 from .btmon import Btmon
 
 
@@ -124,6 +124,37 @@ def pytest_addoption(parser):
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
@@ -153,6 +184,38 @@ def pytest_configure(config):
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

