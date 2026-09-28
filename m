Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFB245D5FC
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790616791; cv=none; b=DLUTgLcvu6vtPYVHXbR3eJdLiiIQhyIrLQfJVymQTyK2ycCyr6/iLkAGKuutzKMcz8wuW6goUaFcoq9HPgnMVILbjz02RqPZ7lf3Oa2S4tf6D43JXAsk71nrnmlFw5dUEY0905S5YFRMlZsb3Jy9UM6B1ziiBbkHPvvyGNn5rR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790616791; c=relaxed/simple;
	bh=uQjFKKftxlootaE9HpKUQHACGknKQMxsUj3ZTzQXnO8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFeY59OnvxbWpPuulXlVu4Brq/NwJWLWbVDSohucnVA3fNM/8tHJIlBUAd86BN7vvUZQtk/axU+tFuMrkyr+JXFoWV7E0xBEa40g7n6YHD1FxKswCfIRDVl9pDQDwf5QT3VdDHsvnG9SBIy7q9K0XBrFo8k1jOfFME/s4nMRmPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJxk8STh; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJxk8STh"
Received: by mail-vs2-f43.google.com with SMTP id ada2fe7eead31-7b3c2da275fso1022380137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 10:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790616789; x=1791221589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vlabArBjsBIs4wXMgJDk8BKlAicZpxc5GslGkFobrzU=;
        b=fJxk8SThuk+kI7PjjPFBvVeUcqZNSrIGEqzPio752ijj2TiXmvMpCG/UIzLyLEz5sL
         T8YvVNPk7sUIowKv6PB9AOgmJfgTzPsalhUx+gCOB5ZRtcB1S9b05WKlSaHzNqSJJQZb
         ToTSaNgbWj6RIVM8liMaKB5P6yUnjsIoB6TJ9U36cNLxrg0xMn3NzmHp+q4KMyjHUxdt
         JZEbWnNTb5Fj5Rz03wy7eKiB04fa7CUDZkGpAnUItwSivgI9Q4DI9/5ik5R2JVxHnNEL
         NBqaZJiaoaKyYcYwaPY18XIGO+GDPFqMkqjr8tT4qTdixuZmZ0a+bp4F3c0+wR2roPEc
         GFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790616789; x=1791221589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vlabArBjsBIs4wXMgJDk8BKlAicZpxc5GslGkFobrzU=;
        b=riDghEXTOFd6VBH9zcowvx6T1GEelba0QwjMkXN0rY4gJqzlmEbk5SXYF3hRi+bfNm
         /Cs2n1iR9WmDKyzGNuKBzlAipjc3V4TK04xrSRNatvtH5D7UIDY8xuRHz27OTX3td3z0
         4/GCnbR6nNxOoPObmJlOjqIjUtybzof8jJP7NuZiawycWP+sbjq7/ZSRhMEQnk2Qp+GB
         nNYb1qqpyydFUHRqezjQtDIEYtrBr1bJHDTWN811mEOroP4npMDSx/PmdRJH8z0Oc5QT
         CgJzmmV6WZaRV5r/2ojDS7QdC+YbaHfvhxJQHpr4bbM3AyyZFExthfNVm09cRlJYy+zQ
         tl5w==
X-Gm-Message-State: AFq9FYILVijH4PeYSVDJq6acrp+mYxsAJHhBYpOSCznDSeUjoYWyoFxo
	B2bwLK2ckZwowylhGYOkUfsPrEGAFUNy3eT9uJP4l6Ug/LlnHtCqskRDEj9sts9rXks=
X-Gm-Gg: AYBFou1e9925ZOi6ZigivxiO7RjowaM2x8s9qqeNoj6udDkMVg+EObbTdklYz35S6fr
	Me1nXOgGdJIqTJBC/vbZ9PZFSx3qcfEJt+rKYim+fcRMhAP1Eoml71XsnxcRAA0ON49X9F083DW
	HURgfNGy/U1SbSsFbQA4g3TnG5ZySeclDfqBPWsmVsOXuRgEXJxYTLSJNdy3PcwlOOaynv5Yzeq
	uNkh4xGsFxi9otR+3Wr+NNp7dFNGa1teNAQuFImtLYvoZUfojIpWzaaFn0/cO5QKmHuQsCWJU+2
	Z0GxK7h1K46RuQ24EqYXAdkHP6hK2bhkUFRg5QAIxmDki1MoFANySl6Qc0NR4izClLIM4Suesei
	iE75MaPnPQsd1d4GJnjrhv/OhvZNMyg3ngZmng+PKEnc2n01O94a3Y7SKtOd7slpV02L4MyPbuz
	cxJPFBPbx3meHzGGH13x5UpcHzRdYahG2ZRWXGdSkhMn4WU2egxuqvC5T0tK4u9h8c8m7ZFR0v3
	nJgUaE6NE+RsFntykthuYmMKocq3xpjaKyCszs32MHLyxQ7HUxAAhM/pZX6nbmKiCUil1e8jPPW
	QBzS2zmi7j8=
X-Received: by 2002:a05:6102:8096:b0:7a1:f7d2:e81a with SMTP id ada2fe7eead31-7af1e6ef2f8mr5091009137.19.1790616786919;
        Mon, 28 Sep 2026 10:33:06 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b6a6272sm10038880137.7.2026.09.28.10.33.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:33:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 08/21] test: functional: limit the workers by the memory available
Date: Mon, 28 Sep 2026 13:32:27 -0400
Message-ID: <20260928173243.1073509-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928173243.1073509-1-luiz.dentz@gmail.com>
References: <20260928173243.1073509-1-luiz.dentz@gmail.com>
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

Assisted-by: OpenCode:claude-opus-5.5
---
 Makefile.am                 |  7 ++++-
 doc/test-functional.rst     | 25 ++++++++++++++++
 test/functional/conftest.py | 58 +++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 1 deletion(-)

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
index 826210b73ce7..e2fcf34138b3 100644
--- a/doc/test-functional.rst
+++ b/doc/test-functional.rst
@@ -474,6 +474,31 @@ pytest-xdist is required for parallel execution. To run:
 
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
index 4e0bda882de3..5ee3e15e43ea 100644
--- a/test/functional/conftest.py
+++ b/test/functional/conftest.py
@@ -208,6 +208,64 @@ def _setup_progress(config):
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
+    # Honour the override of pytest-xdist, as its own hook is not used
+    env = os.environ.get("PYTEST_XDIST_AUTO_NUM_WORKERS")
+    if env:
+        try:
+            return max(1, int(env))
+        except ValueError:
+            pass
+
+    try:
+        cpus = len(os.sched_getaffinity(0))
+    except (AttributeError, OSError):
+        cpus = os.cpu_count() or 1
+
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

