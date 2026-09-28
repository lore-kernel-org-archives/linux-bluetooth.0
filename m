Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com [74.125.227.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951074F7CA1
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790625663; cv=none; b=DvKu9CXTlmzUZtuefr4fd5m9PuQP0Sw1/NYWLqyZ7HhiHUJBu66IYBNscb2r80L+ecgFDTzY46iRM2XaLbHZd6sgJ75p7Hsya9LG8r9CGwXfgJvjmvC0DiArQUxvCtEAyurJ8YovYwbV4Z0BDFlozw38hBorR5OVJboBiFVPNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790625663; c=relaxed/simple;
	bh=/gZvnzo2fk5i4++SMU8LU+1TF11LvdHLM5N4ISNHDwM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhfM0X8FtM7i/Z35+bl/f2AeH4yDYegs/fuFDnZ/rm+srS9vYwKIJJrMwltUusTq15JQGTdkvu0qY2EcVj96qhi/3Psf0P05BfQdrQP3w0zN81zl4LMh7mXRTN14SWpreiboJyF5QXhdBMJMvP65870l+8ahNVJeObu0ey5lWSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSZXQi7K; arc=none smtp.client-ip=74.125.227.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSZXQi7K"
Received: by mail-vs2-f37.google.com with SMTP id 71dfb90a1353d-5cfe8de4f54so1112480e0c.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 13:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790625660; x=1791230460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=EgvwXPEmAB/GBBILPXVv7PbHqG9ow0Kq/TKbS70/1lk=;
        b=qSZXQi7KYPu4LKMeLK3yRbKbH+XHiE4kMl/txECMOR3bLSlVL3J3KXqGhLsti+K5uu
         ECLGr0c+ij19mTNFiwsoinrUozk/d0rzq6k8/AQiBB3PiPpFssLBEFjcdfxVRxO6OrTc
         2EuC6ceQckiXrEtt04U7xPkD5vq+2fltkRf9zZop8wZwUL1kKN9mIt82n0/EqxSVqwqf
         Iw8DXpsLM5C5dI7xlfoVPmyuGsJQNYW7UBd3pyjkrcI+dJyQZ+hRyOxjTYQTzhrS4WeR
         mIu7w8dp+Pfm1UtV/Jn6SIpJ6v9fpv6Dwz3mGejZ54BMclxDNSgmpv91dJOrzEmBJseo
         stNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790625660; x=1791230460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=EgvwXPEmAB/GBBILPXVv7PbHqG9ow0Kq/TKbS70/1lk=;
        b=BL6EFOiYzA81y4sIGBhX8osor1NO/+BaOfTexBX3+tWiVtIGndnsXEU7qSyZBXLxo+
         +Qevu2c2bhM0wKCmvDZAcnTwYOLK4aQSr1MTMmcbyoM+EbpO1W9JzfZlI1aX2THGbIP6
         LyyVmrFjz8m/fpYNPtj41kSg3cmO8YT6oxMgW1PEdV9ikUbziEGMlbntb1HPqEgQlCqR
         4loqiDFM26HVOlfUSH2tZe3BhWqfjV6TH9WAdbdJ8Bo6BvNck5Xo8EvgrGP8kbiJ1v44
         smG6D+7sLU25YMHgXNnn4e3PK4syNOibKqVJHXMN7fcvtbRm9KnA3p2qNjRckwTVRw69
         eivQ==
X-Gm-Message-State: AFq9FYILHtSdAs9LIVyXhAruaU5/FBxzLE03D7HWF/wtCNtbBYrnCKMa
	rPxf8WcU5u11uhZrYVr49DBvbDrz4GZY9yYcXvyva1w2ASLA/I9fZQOdEJlP9TwWVFg=
X-Gm-Gg: AYBFou19SjUu425NRQ8g9osv/4Ld8KZ0z9+BT0sCQikzmGYZEoDSQFjqlLKjfURl04k
	ebBGu0cLdjMdqxGaCG/sZuGDWwwvMobpygOcNLM+xnmEOTrwEqKNzAerPNG+2ZeeZBlpNDfRGuz
	RHESw3OfK1HZZWABWBpZ801QJyTvGmQX2qRVrtTLfgDad2ik8XNbo22R1DK4D4WaiIvedSyo9P5
	+o2w5Y7tyCPARgqveLSvZ4B3MP/LM5Bzn1Elxe6SROI/plSBfet8WWYOacm+Vxfevo1ODqAYCWN
	2kza+vA0V8UoaE9M/bNLVy8wZY30QrS7bjNkcDvwgpnWHimqpfM1FvxDbzqVej6SSOtFBGoUy1a
	C8iilpCsuxGCvB6vxgoPc2mAf8IObrW8LFXJDWspaiukTdShol9NERAxB2VxNGh5pe/Vh8VTNIC
	tLk+GXvLTES5NtveTnul9ucYZilAbIHY6/+xhG/onEH5TGBDOmJJ5+miPUBqeUA4w2QXET9OzrQ
	Q1z5jpY9B9PiwjOgUQU0tnDjEQvM9yZp9XHllyPpV1uSJwZxHSF0VsGf3ufpCla
X-Received: by 2002:a05:6122:3295:b0:5c9:a60c:273f with SMTP id 71dfb90a1353d-5cb0c04e48emr5957052e0c.23.1790625659946;
        Mon, 28 Sep 2026 13:00:59 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5d1d23f8dc2sm749638e0c.6.2026.09.28.13.00.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:00:59 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v6 08/23] test: functional: limit the workers by the memory available
Date: Mon, 28 Sep 2026 16:00:14 -0400
Message-ID: <20260928200031.1209311-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260928200031.1209311-1-luiz.dentz@gmail.com>
References: <20260928200031.1209311-1-luiz.dentz@gmail.com>
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
index c88e81f937ff..439811492216 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -890,9 +890,14 @@ check-TESTS recheck: AM_MAKEFLAGS += -j$(CHECK_JOBS)
 
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

