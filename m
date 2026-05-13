Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9797A36A35A
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689127; cv=pass; b=kUWbmzEtk3Yf9STSygEy/Vh10bjZJjvVng3AYcXg2762e5mX3I+dOPnzq3rG1VmvbaBBM6WP0OVqeTd+BK7U0dHciJP5UJ0lxvz4vNl71aUhf4encwJutQD0WDq3RGrtHF6o/liVwHA9RbjtftF9naQh6HG43ce6JtTwvh7NxIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689127; c=relaxed/simple;
	bh=VfJMfVeR0kZ5VGBDXMevzCZI3ZRDBvvUDOMaBUo9eSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2mR8NBb5Cvq25i2pQXjpJvy5wXSXujLHaoJFPHc2CBrhJhbhRnq8f3xmxWWkfl7M4vQqEQpcvK9lJwYNlkl90esCcho4F+z3eRyWo2R2zLaJMq18sInHOZsTC3BwyziayOpJBMpz5QpT9RssuJ9FLictDUU26Je4zlpP+mW6vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=itywHa+z; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="itywHa+z"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gFzD35KRTzyVG;
	Wed, 13 May 2026 19:18:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778689123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3olKAalH8HCBkG9qbiM6O8wcpt6gRYAM73bF104WBk=;
	b=itywHa+zcK5jaxUPoE1cKv3jkiGNbiyWzeueGowQtcPQagz3xWk6soypDj1QZq9Vaf1aTT
	oaDDHakrIZoXEQLsNlboqrzASCHd/DyBtx6gQigK/MwlVlYUugg/AzQEWoOqQ9l+7ztIDH
	8xeaL6sKTPXQymPQHwERJAZWUCUchdI=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778689123;
	b=kXfGZcadMv7iB8Y2sgw2slmm+PT5+f0mTiIC68wqdAe65r2F2bsLsFgre6myV6n2aY/QbY
	RpmFfBSnUrQFUSNtyYSHvLcGKduDr38IwCReR7CjRcRBIuwS2k2Yok/HnaA1Wfo25yASt9
	6cRz+gLnWE0k2cAPFFQAEqCwiwS9ohI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778689123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z3olKAalH8HCBkG9qbiM6O8wcpt6gRYAM73bF104WBk=;
	b=p7682W4ngM6jZCRTFa/WhU/HLfFkTEs6cak2RyCScP3C+SllIV36Q5XOiO+o4JKHAzLgON
	PzGSjMd1GDVO7DPkGJ0WJkOHT5bsMkeMDTBBsd0fm+11TCH98quW53MWYktISoKOqGfKxJ
	sL6d2VhHBVnU9LabLaFIEV9xgTSan8U=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 11/16] doc: add functional/integration testing documentation
Date: Wed, 13 May 2026 19:17:28 +0300
Message-ID: <45bf35d18fac96a70295f6233c1acc0f37b903b7.1778688966.git.pav@iki.fi>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1778688966.git.pav@iki.fi>
References: <cover.1778688966.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for functional/integration test suite.
---
 doc/test-functional.rst | 299 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 299 insertions(+)
 create mode 100644 doc/test-functional.rst

diff --git a/doc/test-functional.rst b/doc/test-functional.rst
new file mode 100644
index 000000000..bda7366e0
--- /dev/null
+++ b/doc/test-functional.rst
@@ -0,0 +1,299 @@
+===============
+test-functional
+===============
+
+**test-functional** [*OPTIONS*]
+
+DESCRIPTION
+===========
+
+**test-functional(1)** is used for functional testing of BlueZ and
+kernel using multiple virtual machine environments, connected by real
+or virtual controllers.
+
+It uses https://pypi.org/project/pytest-bluezenv as VM-based test
+framework. For details, see its documentation.
+
+QUICK EXAMPLE
+=============
+
+Install `qemu-system-x86_64` first. Then,
+
+.. code-block::
+
+   $ ./configure --enable-functional-testing --enable-testing --enable-tools
+   $ make -j8
+   $ python3 -mpip install -r test/functional/requirements.txt
+   $ test/test-functional --kernel-build -v
+
+OPTIONS
+=======
+
+The `test-functional` script simply runs `Pytest
+<https://pytest.org>`__ which can take the following options:
+https://docs.pytest.org/en/stable/reference/reference.html#command-line-flags
+
+The following additional options apply:
+
+:--kernel=<image>: Kernel image (or built Linux source tree root) to
+	use.  See **test-runner(1)** and `tester.config` for required
+	kernel config.
+
+	If not provided, value from `FUNCTIONAL_TESTING_KERNEL`
+	environment variable is used. If none, no image is used.
+
+:--usb=hci0,hci1: USB controllers to use in tests that require use of
+	real controllers.
+
+	If not provided, value from `FUNCTIONAL_TESTING_CONTROLLERS`
+	environment variable is used. If none, all USB controllers
+	with suitable permissions are considered.
+
+:--btmon: Launch btmon on all hosts to log events, and dump traffic to
+	test-functional-\*.btsnoop
+
+:--force-usb: Force tests to use USB controllers instead of `btvirt`.
+
+:--vm-timeout=<seconds>: Specify timeout for communication with VM hosts.
+
+:--log-filter=[+-]<pattern>,[+-]<pattern>,...: Allow/deny lists
+	for filtering logging output. The pattern is a shell glob matching
+	to the logger names.
+
+:--build-dir=<path>: Path to build directory where to search for BlueZ
+        executables.
+
+:--list: Output brief lists of existing tests.
+
+:--kernel-build=no/use/auto/force: Build a suitable kernel image from source.
+
+:--kernel-upstream=<GIT_URL>: URL for Git clone of kernel sources.
+
+:--kernel-branch=<GIT_BRANCH>: Git branch to build from.
+
+Tests that require kernel image or USB controllers are skipped if none
+are available. Normally, tests use `btvirt`.
+
+VM instances share a directory ``/run/shared`` with host machine,
+located on host usually in ``/tmp/bluez-func-test-*/shared-*``.  Core
+dumps etc. are copied out from it before test instance is shut down.
+
+REQUIREMENTS
+============
+
+General
+-------
+
+The following are needed:
+
+- QEmu (x86_64)
+- ``dbus-daemon`` available
+
+Recommended:
+
+- KVM-enabled x86_64 host system
+- Preferably built BlueZ source tree
+- ``chronyd`` available
+- ``util-linux`` tools available
+- ``agetty`` available
+
+Python
+------
+
+The following Python packages are required:
+
+.. code-block::
+
+	pytest>=8
+	pytest-bluezenv==0.1.5
+
+To install them via pip::
+
+	python3 -m pip install -r test/functional/requirements.txt
+
+On Fedora / RHEL, the dependencies aside from `pytest-bluezenv` can be
+installed via::
+
+	sudo dnf install python3-pytest python3-pexpect python3-dbus
+
+Kernel
+------
+
+The **test-functional(1)** tool requires a kernel image with similar
+config as **test-runner(1)**.  If given `--kernel-build` option, a
+suitable image is built from sources downloaded under
+`test/.pytest_cache`.
+
+Simplest setup is
+
+.. code-block::
+
+	cp ../bluez/doc/tester.config .config
+	make olddefconfig
+	make -j8
+
+To get log timestamps right, the kernel should have the following
+configuration enabled:
+
+.. code-block::
+
+	CONFIG_HYPERVISOR_GUEST=y
+	CONFIG_PARAVIRT=y
+	CONFIG_KVM_GUEST=y
+
+	CONFIG_PTP_1588_CLOCK=y
+	CONFIG_PTP_1588_CLOCK_KVM=y
+	CONFIG_PTP_1588_CLOCK_VMCLOCK=y
+
+USB
+---
+
+Some tests may require a hardware controller instead of the virtual `btvirt` one.
+
+EXAMPLES
+========
+
+Run all tests
+-------------
+
+.. code-block::
+
+	$ test/test-functional --kernel=/pathto/bzImage
+
+	$ export FUNCTIONAL_TESTING_KERNEL=/pathto/bzImage
+	$ test/test-functional
+
+Show output during run
+----------------------
+
+.. code-block::
+
+	$ test/test-functional --log-cli-level=0
+
+Show only specific loggers:
+
+.. code-block::
+
+	$ test/test-functional --log-cli-level=0 --log-filter=rpc,host
+
+	$ test/test-functional --log-cli-level=0 --log-filter=*.bluetoothctl
+
+Filter out loggers:
+
+.. code-block::
+
+	$ test/test-functional --log-cli-level=0 --log-filter=-host
+
+	$ test/test-functional --log-cli-level=0 --log-filter=host,-host.*.1
+
+Run selected tests
+------------------
+
+.. code-block::
+
+	$ test/test-functional test/functional/test_cli_simple.py::test_bluetoothctl_script_show
+
+	$ test/test-functional -k test_bluetoothctl_script_show
+
+	$ test/test-functional -k 'test_btmgmt or test_bluetoothctl'
+
+Don't run tests with a given marker:
+
+.. code-block::
+
+	$ test/test-functional -m "not pipewire"
+
+Don't run known-failing tests:
+
+.. code-block::
+
+	$ test/test-functional -m "not xfail"
+
+Note that otherwise known-failing tests would be run, but with
+failures suppressed.
+
+Run previously failed and stop on failure
+-----------------------------------------
+
+.. code-block::
+
+	$ test/test-functional -x --ff
+
+List all tests
+--------------
+
+.. code-block::
+
+	$ test/test-functional --list
+
+Show errors from know-failing test
+----------------------------------
+
+.. code-block::
+
+	$ test/test-functional --runxfail -k test_btmgmt_info
+
+Redirect USB devices
+--------------------
+
+.. code-block::
+
+	$ test/test-functional --usb=hci0,hci1
+
+	$ export FUNCTIONAL_TESTING_CONTROLLERS=hci0,hci1
+	$ test/test-functional -vv
+
+This does not require running as root. Changing device permissions is
+sufficient. In verbose mode (``-vv``) some instructions are printed.
+
+Run all tests using the USB controllers:
+
+.. code-block::
+
+	$ test/test-functional --usb=hci0,hci1 --force-usb
+
+Run tests in parallel
+---------------------
+
+pytest-xdist is required for parallel execution. To run:
+
+.. code-block::
+
+	$ test/test-functional -n auto
+
+To reduce VM setup/teardowns:
+
+.. code-block::
+
+	$ test/test-functional -n auto --dist loadgroup
+
+Logging in to a test VM instance
+--------------------------------
+
+While test is running:
+
+.. code-block::
+
+	$ test/test-functional-attach
+
+For this to be useful, usually, you need to pause the test
+e.g. by running with ``--trace`` option.
+
+To do it manually, when starting the tester will log a line like::
+
+	TTY: socat /tmp/bluez-func-test-q658swgi/bluez-func-test-tty-0 STDIO,rawer
+
+with the location of the socket where the serial is connected to.
+
+WRITING TESTS
+=============
+
+The functional tests are written in files (test modules) names
+`test/functional/test_*.py`.  They are written using standard Pytest
+style.  See https://docs.pytest.org/en/stable/getting-started.html
+
+See https://pypi.org/project/pytest-bluezenv/ for documentation of
+how to write VM-using tests.
+
+Use `Black <https://black.readthedocs.io/en/stable/>`__ to autoformat
+Python test code.
-- 
2.54.0

