Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE64A3F32
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264813; cv=none; b=Frzfab1ANi1PJ/o9F7p4K9zuFLmlE/xaQjfg5yOkicil0TH/JuYMEJio9IKzkL9HmBftX5jLwE8lAr6ncoIeaUgo5doIc7ORgxDFqHcmWHq2o/7gDhac/V7gYhdWZ1hVC7Ke8BuMKfskPzc+MRAFi6UWftNXc7fQdObUD33OoPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264813; c=relaxed/simple;
	bh=KQwRYm/aNDZ1btBCRSFZPaKhe8kcUGeaUHrhlVrG8xc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIy9Yql9NG5gXUHEZGbyH+5DhgHsj9DeA3/cVKR8N6Aw817a+s2r99RL/c86vkaqA8E9roeM7/ehGqjECQeMI7rFxqIZikSdlNe4HoaNpkylDXtQkFBw6z8EOXMPGTSiUjEF859yLm/yFtGVS24MvTX1Tw4vX4T+3U9IbxkzOiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkqOpe3o; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkqOpe3o"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-79028ca9371so832657137.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790264811; x=1790869611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X19tE9bayHnx+DLaAl8nIwbaEBPDQbyfMULguRiCdQI=;
        b=BkqOpe3oHA2hlFy3KAMLv9OLzRbJEj9bvoJ4Fk03TYG8AGhQdxosyUvqi0lMYaKFsa
         LLuIrRUlDWhl9poHhTV7cMO+mjvO66jv87sIJgguqvE5yuspOLaSfjoZST+O6eXsfOuM
         s/TwkB0zdgwPyNMjk1JFUehenhT6BL++he4d3dxGJEpw0kK4vEqSWYT5BLL4zDJ2fIb8
         TBVVHwybbP5BgUBLgUQvIsbCyu2VQ4HwfzUZ9843X3se9bDo4JmlPXVCwYw+fCUFgETW
         AqiK8PcOA+SbiSTR/w0XWSN+i85fYAIR4Hon2pD4Kh9hQ9ah7UbuA3YBjBLsCjvNKmAG
         yBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790264811; x=1790869611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=X19tE9bayHnx+DLaAl8nIwbaEBPDQbyfMULguRiCdQI=;
        b=HH7F7Mhg7V39vsO8ub3WKQ6K2wko6ClWd1TYhF4AwNMzRZO3eLo0apSSVr/QMVQO/U
         XNQADqDU46InS87Y6FzbszsxMlfbl0GG4+o+dFLhrZyu0cDIBmQlxbMseCVt/ZPhGWkE
         lDGAZqieQfz4BTz7w7DzKwRcIWCMZKp89kvweR38tn3Qv4pwPZCCblClT9bkhLAYU9Z9
         TngBW2O3QPaJF824KqJYAdoXY8aoc8aMTgTl7C+cE4ZVj5wSAX9ORTEQHPU2jb5lZ99x
         jPFtvYEvEDD/2u8YRWZAK3icmdzp44HbbvnrDvX5KzjQ6M1g5zbCRbL1YcMzsD7zgOHW
         YNnA==
X-Gm-Message-State: AFuF++mVwVI2gUrNIM/1XF3fvdhi1g+9UR4478297k8XT3IXjdW2y33o
	bMQtVe5jQZufIOSa254oZeIbw/SwwDVhzyrwzi814GY9JT2AG+31nlJVkeanOttGiy7Gzg==
X-Gm-Gg: AYBFou37umAOQeEzDaJBzMYfbYviXVZSU8R0PU+nydKmKoXJ1clH7wY9RBA6EnIOTmh
	4r/tE+20SthaNjb01uHE69G9t+lVTYL1GAr/0o0w+q16dvvoKuo159yUxNCh7No+yd+RinhdQFl
	OKhkowVhzlPokdWEfpMwKyR+g5w8Rf9qGJDqIBV+Z02LSy54HtqnTGy7dwnZIQjrO73nURcapfG
	zVbaW3xDXwQw21VI8aXSLiG62D1fcHzq/B8BvRuvCwLe7Sg1xvFQS7iYOH2Jg0EKM273l29H6TL
	e8yotPSOk5DKawFA/a8UkVcqUiTdE5JC3LN5PZLK9qpRX3WSZBMaxN/Fv4ir28tz1gbA1KpBkkG
	6+MRyOg3dziNqGflmbzKOvzIsp72extOCqxDwVrWDG4nJvaQIp/CKpl0ylvkUdozfEq68Euhlbw
	+L0RISSpLxnOD8rDgrsn0ucX9RUf7m4CGByXADN92mHcSKpuU3NEFSxwuJKNEbPcNDTwRFPtaKr
	qccrQyy6urIG7odBk5fqEdNTXyvj0WhOJGVrispPkoOagi3gbW7r0zq1HSsCOqm
X-Received: by 2002:a05:6102:2907:b0:7a8:1b8b:6d04 with SMTP id ada2fe7eead31-7af1c9a1ce8mr1464686137.2.1790264811112;
        Thu, 24 Sep 2026 08:46:51 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7abf5674f44sm7412428137.3.2026.09.24.08.46.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 08:46:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 9/9] test: functional: limit the workers by the memory available
Date: Thu, 24 Sep 2026 11:46:31 -0400
Message-ID: <20260924154631.369299-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924154631.369299-1-luiz.dentz@gmail.com>
References: <20260924154631.369299-1-luiz.dentz@gmail.com>
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

