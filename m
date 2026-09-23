Received: from mail-ua2-f17.google.com (mail-ua2-f17.google.com [74.125.226.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCAC569F19
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 19:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790191933; cv=none; b=us+227sPV40cejrWHuZwFKffIRkVRXrO/Ai3htwXGM5twOxMZOEX3xqpo3YUOoOn8kezdsZiMG/lLuqKlIxGRPLafSLRy2L87rAiIDVJu8li6wL92ha1fvxs/k4KD3Hg+dnkBj8mjwXMVzSvrP5DPxYHc8yuUMPDeayaZxtB3U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790191933; c=relaxed/simple;
	bh=KQwRYm/aNDZ1btBCRSFZPaKhe8kcUGeaUHrhlVrG8xc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNFaq9nv3HCJHOV4/NePvNZGHddwLrBwpC4u8kJEXyMF/JOte8fJaDF01H/V/pio1HeRscKmWq6KNyzDjXNolfzr/Y4ZntIa++6VV0oipmFuQDARsTsEJoN41rmqqVppb1DqsmwpFliZDo95Sse8+Picb4lpf4icmV2tFftKrvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjRTaj3j; arc=none smtp.client-ip=74.125.226.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjRTaj3j"
Received: by mail-ua2-f17.google.com with SMTP id a1e0cc1a2514c-97e7c6e580fso438402241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 12:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790191930; x=1790796730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X19tE9bayHnx+DLaAl8nIwbaEBPDQbyfMULguRiCdQI=;
        b=VjRTaj3jh5brbCgkEmK3JS+b/m6XPhKvt/FWjEI0WKyo4lWzVtgt55rKDAGZ3w3kqq
         A6CC5WPIrhENjpaPtQjgeVLUgDbbaURHExKQ/vc7NeQ+3CO6erBwVEoTeB+LZqGYSrfO
         7VDGgeXdwRJW+11jl1XV2iIJXiF0Arj3dXwt7xEYk/dGZ2i3AtPQeuXqhKnxuOX2j3mj
         kzDJwjRsCZZFhxHoIBvu5tx/zeZ4BHtF9GgtC1Fs/G/s4qkGeGQUJQwIXfHya+x/8FEf
         cSg9BDxwWlm/lqypNPGOzZLj9HgcVWMldmmEE12LH7k7GHyFlW0NkwFEiSL+u9FHdzbn
         TAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790191930; x=1790796730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=X19tE9bayHnx+DLaAl8nIwbaEBPDQbyfMULguRiCdQI=;
        b=Xa5PS6S94Yb3/DH/n+jhBy7VxLEc+USLDa9NEMIBDTMI1Gy3MMEp9ljDJKE1ol+0lS
         IJZJXkM9TcfyY9dG3JLnRKZgofkc2D9K8Aw1UL2cVyfJshVQAx0H8KRnNUzSq7YMQqTb
         I7wgwanGxmEFzFzLJxZIuvG+ab/iE31ZIdSus74dH1pzq6PhIFKnCmuc5ln4bXwKjY+Z
         UilQYkPs/gVkJ7yBcb6ty520Fx6bxycJ1JTl49e6WtszGgFEiF09+cmuLLX5SMhwohz3
         3xxWyNUMYzlSxv2TRbPC1tES6FCDAV61YOGld2kzfGmB3YJ/UHW7zMiCMzhOG41cGP+A
         TFmA==
X-Gm-Message-State: AFuF++lYm0rqurU9QCB7km16DRqMZ9ruNRh3QpJsAYGog7F26BCW21DR
	54QOm5e9OJ5g7PzFTdpQKEBXG/xgk5nKR0mX1s58NjAfuzNsGkdvFrvQIpUI6mnxyR+Uiw==
X-Gm-Gg: AYBFou1g4PxqvP2AoBwHgS9u32cZLvGiN+Vk6AfQ6fZw75muV1YvBHCGERxr7LoYeiM
	PzG0cVMXSxoQAsSmzBQlq5wfP9ZwzOZkKbzwWUvfQIdHyekv+VukDbNtCYnoNkxwO9jufW9iXiv
	QuH+CW8Jj3G3KmE30H5MVWLrkgtn1UcHNM/djO/3mWuDLYLazjPek8pXfY0AbvKpqWzm9BGD2Jk
	qu1Tnw4lmceeEBr0fzFSIs7sGvsMrmJXMR+ZMgdzMPec+O97DccEfuJAsM1VKl+wHInJ6T7CJn9
	ynTj5kFmuJUYWSNXFeDtOjI78YlGC5FtE6NJDvF9714MA1qY3JYJJlC3bLSVzrcBdeGPKHKErrd
	IvBPKfPTz2TVqTZ77ssd4STEiUe9Ahiltmv42PiHq1Ibn/yWMo6oF78UwVw1k64ov70fOr5sjvV
	g6rrf9hKg05mz78yRKSnsg4TYjhQN6XnwiPE6yrV0jnDvxnzrBHC2ILI1MNdDJoWZA/prSld2YJ
	Tcv8tOesYtIPH3OEtk7cOh/KeRR8H7K1VVEYeXBHzKTlXEsCJOf2eI++53J8eBx
X-Received: by 2002:a05:6102:580d:b0:7a7:196a:84e9 with SMTP id ada2fe7eead31-7af1f1fc312mr157171137.33.1790191930366;
        Wed, 23 Sep 2026 12:32:10 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9851691693asm4666266241.2.2026.09.23.12.32.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:32:09 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 7/7] test: functional: limit the workers by the memory available
Date: Wed, 23 Sep 2026 15:31:57 -0400
Message-ID: <20260923193157.249636-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923193157.249636-1-luiz.dentz@gmail.com>
References: <20260923193157.249636-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Each worker of pytest-xdist runs VM instances, so using one worker per
CPU could run out of memory, with the OOM killer terminating some of
them and tests failing at random.

With -n auto, limit the number of workers by the memory available,
estimating each worker needs memory for 3 VM instances of 256M of guest
memory plus the overhead of qemu, and use -n auto for check-functional
by default, which can be overridden with CHECK_FUNCTIONAL_JOBS.
---
 Makefile.am                 |  7 +++++-
 doc/test-functional.rst     | 25 ++++++++++++++++++++
 test/functional/conftest.py | 46 +++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 17348788a30b..e5587c55d2dd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -885,9 +885,14 @@ check-TESTS recheck: AM_MAKEFLAGS += -j$(CHECK_JOBS)
 
 # The functional tests are parallelized by pytest-xdist, loadgroup is required
 # since pytest-bluezenv groups the tests sharing a host/VM setup together.
+# Each worker runs VM instances, so by default the number of workers is limited
+# by the memory available (see test/functional/conftest.py), override with e.g.
+# CHECK_FUNCTIONAL_JOBS=4.
+CHECK_FUNCTIONAL_JOBS ?= auto
+
 check-functional: all
 	python3 -m pytest "$(srcdir)/test/functional" -v \
-		-n $(CHECK_JOBS) --dist loadgroup \
+		-n $(CHECK_FUNCTIONAL_JOBS) --dist loadgroup \
 		-m "not tester" \
 		--kernel="$(FUNCTIONAL_TESTING_KERNEL)" \
 		--bluez-build-dir="$(top_builddir)" \
diff --git a/doc/test-functional.rst b/doc/test-functional.rst
index 3ffcbf6dec5c..9cf0a8bb48e5 100644
--- a/doc/test-functional.rst
+++ b/doc/test-functional.rst
@@ -472,6 +472,31 @@ pytest-xdist is required for parallel execution. To run:
 
 	$ test/test-functional -n auto --dist loadgroup
 
+With ``-n auto`` the number of workers is limited by the memory
+available, rather than using one worker per CPU, as each worker runs
+VM instances and running out of memory makes the OOM killer terminate
+some of them, failing tests at random. Each worker is estimated to need
+memory for 3 VM instances (the maximum used by a test) of 256M of guest
+memory plus the overhead of qemu, see `test/functional/conftest.py`.
+The estimate is printed when starting:
+
+.. code-block::
+
+	Using 9 workers: 22 CPUs, 12159 MiB available, 1218 MiB per worker (3 VMs of 406 MiB)
+
+To use a given number of workers instead:
+
+.. code-block::
+
+	$ test/test-functional -n 4 --dist loadgroup
+
+``make check-functional`` uses ``-n auto`` as well, which can be
+overridden with ``CHECK_FUNCTIONAL_JOBS``:
+
+.. code-block::
+
+	$ make check-functional CHECK_FUNCTIONAL_JOBS=4
+
 Logging in to a test VM instance
 --------------------------------
 
diff --git a/test/functional/conftest.py b/test/functional/conftest.py
index 4e0bda882de3..4d4193a95cd9 100644
--- a/test/functional/conftest.py
+++ b/test/functional/conftest.py
@@ -208,6 +208,52 @@ def _setup_progress(config):
     )
 
 
+# Estimate of the memory used by a VM instance: 256M of guest memory, the
+# default of test-runner as the tests do not set it, plus the overhead of
+# qemu itself
+VM_MEM = (256 + 150) * 1024 * 1024
+
+# Maximum number of VM instances used by a test, i.e. by an xdist worker
+# as it runs one test at a time
+VM_MAX_HOSTS = 3
+
+
+def _mem_available():
+    try:
+        with open("/proc/meminfo") as f:
+            for line in f:
+                if line.startswith("MemAvailable:"):
+                    return int(line.split()[1]) * 1024
+    except (OSError, ValueError, IndexError):
+        pass
+
+    return None
+
+
+@pytest.hookimpl(optionalhook=True)
+def pytest_xdist_auto_num_workers(config):
+    """
+    Number of workers used with -n auto: limited by the memory available,
+    so running a VM instance per worker does not end up with the OOM
+    killer terminating some of them, instead of one worker per CPU.
+    """
+    cpus = os.cpu_count() or 1
+    mem = _mem_available()
+    if mem is None:
+        return cpus
+
+    per_worker = VM_MAX_HOSTS * VM_MEM
+    workers = max(1, min(cpus, mem // per_worker))
+
+    sys.stderr.write(
+        f"Using {workers} workers: {cpus} CPUs, {mem >> 20} MiB available,"
+        f" {per_worker >> 20} MiB per worker ({VM_MAX_HOSTS} VMs of"
+        f" {VM_MEM >> 20} MiB)\n"
+    )
+
+    return workers
+
+
 def pytest_configure(config):
     _setup_progress(config)
 
-- 
2.55.0

