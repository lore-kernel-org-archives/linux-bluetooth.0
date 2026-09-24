Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com [74.125.226.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05BD3368AC
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 13:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790258183; cv=none; b=k9ipYaU4tYZsRC4bJjFPEJDFxtrV+zTMlVngh84WWUYqPkqFJVNISBwvhD4fSAPjvhEqXgHvKmYupV7WVfa4t3xZ1LrClbQaAMynPXQzMB0sLWgGUVT8Fvi/8wWnyz8aM1IGus7lwuuQIx9QJYYtWYWB4Sv6SK2YUvLoeBHjGKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790258183; c=relaxed/simple;
	bh=KQwRYm/aNDZ1btBCRSFZPaKhe8kcUGeaUHrhlVrG8xc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=et5bfuhpUTOmqO5GV4D2UgNR/cnAhTYY+h7burauEmAvCo5zN7QhLYg3WN/KABVfI3RKz2QV9P9EAMp+xP+9+OwNq3jjl9uNz0LdUM/b8V1NUYyqcO1xqjyxdd9JpSF2z1DzNbqtFctwQKyoRy6xPhlf39pW7PladxiaHuPARaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADZq2GMR; arc=none smtp.client-ip=74.125.226.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADZq2GMR"
Received: by mail-ua2-f12.google.com with SMTP id a1e0cc1a2514c-97e7c72bfe7so725099241.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 06:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790258179; x=1790862979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X19tE9bayHnx+DLaAl8nIwbaEBPDQbyfMULguRiCdQI=;
        b=ADZq2GMRdJ8dNf/pYRWQdqlFchaHFPNS0eEsZyjuR7vIeYcFFPOsvrcioLgfWdFj+P
         zF5Eut89KHnvGPQM/iJbOhvFPHbIR76NnTI4GR/87nXaDCwSmugsJCRCUj39b2KJQ0qp
         5QFHvkzSy0fj5yAe4NVuFmn14ouKWDjY3B8KzjPG6sWIdQ0aSNfoOMlpsToOWXids1aU
         t+wEYe2fMJzpr57mYNjyxEzr0dVsu6NNXNU0cZJmc4cRwGF+t0IRfM5zSm4qAYQCeTZN
         xDkU3FrZXT/kefKhMk6JDom6qAf6dEkVC/5sJdGQWwHqYsX/znTobbwFJ3amG54hAUNP
         8hFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790258179; x=1790862979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=X19tE9bayHnx+DLaAl8nIwbaEBPDQbyfMULguRiCdQI=;
        b=GfcIPbnXq0N8wZUilFoVB90oj464xzkiN/5R87teOqSFegiy5LHTnyfbpEYfptgSBp
         QhJ1rucjWQn5o7Uencu+plIaFlZEKXdHkDIa1B1NknZKZHxY1PDsSyN1SsgByMRiLxUb
         k/h+OW+mRGqRo8dlxrwksFOqutBC5Yk9wz0QDG4DwpUWJ9uexWWm0CqZ+7DUgBGrsF/6
         X144uD0ILFLhixU1z2H2NWs2/jL8qeXnLfl0K8aV5cF0ms7AiAR+jlCb8sr/1BlS0+8g
         itqsyAJrWZ/qkUSUCq3dUIMxts8aVuPDJgdiW+3h05gxJI6tY+OrUtqDcTqXX3WClBhn
         GNNQ==
X-Gm-Message-State: AFuF++nvOQT602AGQR1t4ovWJhdUvtujS0+yxDXzF70f0hhbRUnXVZl8
	GWjzgwRIdFo6rO8e9jzZRnGKVz5g2J5D9JUJvlaIMNk+oSrQ8I/WvaS9DF/0Hl0usp/2LQ==
X-Gm-Gg: AYBFou1dYHSbYf6IVPKhCoejb8/ouUDe7v67M42OQqnh8wF7PRoNF0TeO4dP3ywYHkg
	+NymSRQ9kEJU3lWDQlqu3xNxwZhsQU1vzjOVGqyMSlmT/mYKvGjFfvV6PKlU4JF9zy2TZpqiuZ3
	VP8YCq/cFaSfiJshRnhw3xf2+4V/dbxXxRhx8O8vbAtr2XAS36u7hfcagu7vaLjP0YE+5xL9SJA
	mkF0cxAvFY0M1rm/Y8nXH1lx4nvi12aH+8iQiI7KZVVkdSj3XZ61uy1XqvMjoB8OBx10vvaY1vH
	3G/B+xD6SGxfzD/AdNBljeQ9F5MBjRK+IE6Ib/GQjvs+ckhXVXsgjs82Kx1d6QyAiorXN8r8Ozd
	Ru1tX6d75277hK2QsHgGZiarrCO8lSDyb0+h7aE7oHi0cRtJVcFdvFeGJxc6QH/Mdg8IsaYI2Tb
	XcEAqdxIxbzP5kxVk4byBh9EQumBw60BHHr4KvqeXTQZjrO2e8mp24BzGeHuuUIgj7Wb4JAmesk
	uaaCFFBh5CzuHY/m8iB+36BpTbr2WUEZSQwZWM/rqTWXiCNQR/0r3WMs5H4ugms
X-Received: by 2002:a05:6102:4410:b0:7a7:198a:c2c4 with SMTP id ada2fe7eead31-7af1eff6ad3mr1186927137.34.1790258179463;
        Thu, 24 Sep 2026 06:56:19 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7af8bdcde81sm1493194137.10.2026.09.24.06.56.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:56:19 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 8/8] test: functional: limit the workers by the memory available
Date: Thu, 24 Sep 2026 09:56:01 -0400
Message-ID: <20260924135601.330277-9-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924135601.330277-1-luiz.dentz@gmail.com>
References: <20260924135601.330277-1-luiz.dentz@gmail.com>
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

