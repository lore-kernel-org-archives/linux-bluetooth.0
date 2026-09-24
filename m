Received: from mail-vs2-f29.google.com (mail-vs2-f29.google.com [74.125.227.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078C93FC5C3
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 22:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790289067; cv=none; b=CI95CUIuWM3VfGrvebx2lcFXL/FUmGz3vEL46fDpGKAzd3MpQ56UNYWZMJHdt8dwvpiVfri6s3pD+zOYf6vze4ZA0sVRg4zzBiggz5OPPiX5gMURLJEgaWLNNaF6/hSkz4axdZ3hYBWmUIKtPD3u149pC69Lm95skPdG3dLE0zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790289067; c=relaxed/simple;
	bh=uQjFKKftxlootaE9HpKUQHACGknKQMxsUj3ZTzQXnO8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdOgFf1Yi51iLk1MSoMCAkl2EAr49e++6e9FDmH5dYFa+AM134v4Fs5bfsY2wrXnzvegMdzUgkkMUnHQ2z0dYd5mZVFF82HmJI5qMhLrP103pR8UZBX2wyJw3e7AW5msd+HqvQfrrGhei60XlbP8yAkEVThZUcutdEHyXjSDm7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fz5/IQO4; arc=none smtp.client-ip=74.125.227.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fz5/IQO4"
Received: by mail-vs2-f29.google.com with SMTP id 71dfb90a1353d-5c67e5059f9so139455e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790289064; x=1790893864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vlabArBjsBIs4wXMgJDk8BKlAicZpxc5GslGkFobrzU=;
        b=Fz5/IQO48H3CXPxyygVDDiOsxNmSuacqEz8MvNmKam3Cg4WClXbcZWRGOph23GCM3Y
         j3eq20W7OghRL2Va9u7vbTS14CTB5GOAelUL8uSq48VOFkDtpWg5T6DIeZYUO8iYqPOf
         bm9f0PWFg079Y9ixhtsDJKb68a84FUdfu36NMF5u/kBekTe/vbXM1Y3Jr5rR5msSwpuT
         v0dvCBAmyWU2zuWhd0PO1RqRFz20wcO86KnXNjgz6ASuTkjysP6F/psaGwA5Gq6RPcQZ
         OTus1KGvgMjbWLj4TUlCD0Co6MRUrtKAz3bxxsafFDNHp2GnddQ4idHmwcuznOJthcEF
         dvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790289064; x=1790893864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vlabArBjsBIs4wXMgJDk8BKlAicZpxc5GslGkFobrzU=;
        b=zD1rcoXg26Unwea33bNgVy9kTvVKvYynzGijtPDrezgPhudS3c1p7Ggg9jcBBArCu5
         R9cz02jmcOWjs076y3rq1zb+MsEwg0r6/itEv2Yq+0V3vVhIY8yjudj3SPOfHtJUA5HY
         aM/GEmuRwqlc1lcOQvmFG86O6tpzKTDrIM+uXkvL9O+V61diLvh15YCXI0f7BssObnhw
         pqEXxiKGZ//e3v34QDxOiMeeciZSFF5SIFKNLnUzTXYNL5G+C6WRfIi6REHKo2TT3mhC
         0ZUEmRur6dXuU/TfrKAOKEpKLcF72y9jSUQM5OJbgPE6TkSySlu1xJkzVawCyMFdbU5K
         hY8w==
X-Gm-Message-State: AFuF++nhjzAe4J7y+1TX+FqKIFSWbZHV9KCsDUGivigtx/QXza99/WjO
	tgDkfB2NJydeOljyvOn7qoDNyPiuRJqFQQY5/AnaiQvMOQgJShUPAlRfwzl+RwsJEHs4Vw==
X-Gm-Gg: AYBFou2rwqPuUI93gp6Imk8DLzG+OKgOivM28r6CeNu0agi+56+VtFVmz4IEzNLksA5
	8PHZH5eRlqUQIFuMj45Pg732pFrqsvK1KDkLASieoTluBq/Gy1UyMdK/zDMzqXTn5vYtkI1DepZ
	jHCdLLck+pAqUtkuxCCH+r3qZPL7JXTUVAjXV3cb0zYxS/uKS/MACjV7R8By4HQUF37fp5kHjX0
	7B+bx1wDk91uJSiuyT2vr9RI6Bqlv+C1lPi5k8pI524TRmqeG3vqoSIyymH8zTnq+TZXmHL8Jqz
	1oC3jnBfQu7bBcx57Vd5N3iv8vJwyIl1FWp4eIKr22PzVeOMmJKEI25dK7GeefWFXjAC8AsqX7z
	wGLoIo8nXTW7UYC1n8qQQWbrVj4SyIq3KLpa15qJVX1W4eUYKNPyf21pznAdkb3aff5K046ro0W
	/akRLFilxisw4bz0JAUuWg7CZUvMzMluZa6z7jsxNSRo7emTE/kaRYsJNULGMx2IQDQO2O5UiOS
	PvrRHOwax2KIaNt52hVm6QdBsYYKOEXTizshQ7PfVOmP8DCn5J4pV/iriGjK4p/
X-Received: by 2002:a05:6122:4694:b0:5c9:a617:5811 with SMTP id 71dfb90a1353d-5cb0b58497dmr2222878e0c.14.1790289063743;
        Thu, 24 Sep 2026 15:31:03 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5cc64f9c59csm890924e0c.11.2026.09.24.15.31.02
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:31:03 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 08/20] test: functional: limit the workers by the memory available
Date: Thu, 24 Sep 2026 18:30:33 -0400
Message-ID: <20260924223046.605543-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924223046.605543-1-luiz.dentz@gmail.com>
References: <20260924223046.605543-1-luiz.dentz@gmail.com>
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

