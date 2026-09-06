Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71A3A9D8B
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713415; cv=pass; b=Vjub5ChF1q/i89YH9WBzCy3QObP9xNNsrvWHevlXuCfF1BBNY4EAtcNTT6s4FVkODmJHfFfr9cVQPoRzCoiNm14M2OVxB69XDwtu1Kfos1GZ3lu4sbTbSRdhPfLR+jDwCxk24ju3D84CwGQMiZrZeAEwFGba+VD7ZjWKQhmZvBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713415; c=relaxed/simple;
	bh=XVB6t4yF0JWb6zJ3nA+x2eKWhgwI4x6dOkctvRZThwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODcQjl9F8XBApjAnpEtDrT4/JNpxiO2rvIWcuc3GIa2N84cfhxnCG4GX2Nu6Nh9E221f9OJjwoGUNTPXdfJCclJHVq0kGPqLtABdqj3ay/kLK5KS4VHwVGH6UUBZ6cP1dGcrQRv1V8s6lB/jSRbiH61+rJjOembfFudUyCN00TU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=jmBgNNOO; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="jmBgNNOO"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hdGQb4bTBzylX;
	Sun, 06 Sep 2026 19:49:59 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788713400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSUhHgxBbmwNybFjjVxCgbxi6TNwaOzzvj/XPdjPR7Q=;
	b=jmBgNNOOEKm1KWU41qd8ZZ9Ol7IKpZc9lEspeKG8qR7Ks9TtJPMtZ7WfLffJqpuN3h2xfi
	prohOOC+YOhIofWfQl9HOi5DLuVSjxuxShyOMP/SBTsgLdY+kvFmwMz8wJC92XM63TZq+p
	Y0oZfFmG07Cow9leKgKqyrBgXdQDl/4=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788713400;
	b=SQGWiQxscH9x4csMBBcxZEInOaoxXhu/NYq6fHu9H02hM9IJ6Y7lYLQhjcjD0hPXinzg6m
	crI1SMRXGwGgu+yFyOMGAw42wDesOWQy3fw9nhGLVbIzwwuKlivP7tERa1YI91CsUVBqQy
	ckpgxgDn4PAGm4jXmzP9xqYTS2LVr2A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788713400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aSUhHgxBbmwNybFjjVxCgbxi6TNwaOzzvj/XPdjPR7Q=;
	b=luYgK9KbVbf+0Fzur4q3vjqEXIk2dqcV5LTluaDy6t3KqOdtZeCubnqb9nd5eRyj+qRFRb
	egKLTHZ7Ubnjsqmsk9GOTJEwcYhR5ARGUYO8LzC8p9D8c1wYiGmxtcklskw9UCoiUg7y0f
	qJk6qjlmKuQL0odoVwMHOrCkhD6gC/k=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 1/9] doc: add functional/integration testing documentation
Date: Sun,  6 Sep 2026 19:49:43 +0300
Message-ID: <f5138d545e2edb8cbc0116acdb7c0384ef09f2a8.1788712996.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788712996.git.pav@iki.fi>
References: <cover.1788712996.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation for functional/integration test suite.
---
 doc/test-functional.rst | 331 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 331 insertions(+)
 create mode 100644 doc/test-functional.rst

diff --git a/doc/test-functional.rst b/doc/test-functional.rst
new file mode 100644
index 000000000..e23b1eeb9
--- /dev/null
+++ b/doc/test-functional.rst
@@ -0,0 +1,331 @@
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
+   $ python3 -mpip install -r test/functional/requirements.txt
+   $ ./configure --enable-functional-testing --enable-testing --enable-tools
+   $ make -j8
+   $ test/test-functional --kernel-build -v
+
+Or, if you already have a kernel image:
+
+.. code-block::
+
+   $ test/test-functional --kernel /pathto/bzImage -v
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
+``--list``
+	Output brief lists of existing tests.
+
+``--kernel=<image>``
+        Kernel image (or built Linux source tree root) to
+	use.  See **test-runner(1)** and `tester.config` for required
+	kernel config.
+
+	If not provided, value from `FUNCTIONAL_TESTING_KERNEL`
+	environment variable is used. If none, no image is used.
+
+``--usb=hci0,hci1``
+        USB controllers to use in tests that require use of
+	real controllers.
+
+	If not provided, value from `FUNCTIONAL_TESTING_CONTROLLERS`
+	environment variable is used. If none, all USB controllers
+	with suitable permissions are considered.
+
+``--force-usb``
+        Force tests to use USB controllers instead of `btvirt`.
+
+``--bluez-build-dir=<path>``
+        Path to build directory where to search for BlueZ
+        executables.
+
+``--bluez-src-dir=<path>``
+        Path to build BlueZ source directory.
+
+``--log-filter=[+-]<pattern>,[+-]<pattern>,...``
+        Allow/deny lists
+	for filtering logging output. The pattern is a shell glob matching
+	to the logger names.
+
+``--no-log-reorder``
+	Don't reorder logs to timestamp order.
+
+``--vm-timeout=<seconds>``
+        Specify timeout for communication with VM hosts.
+
+``--btmon``
+        Launch btmon on all hosts to log events, and dump traffic to
+	test-bluezenv-\*.btsnoop
+
+``--kernel-build=no/use/auto/force``
+        Build a suitable kernel image from source.
+
+``--kernel-upstream=<GIT_URL>``
+        URL for Git clone of kernel sources.
+
+``--kernel-branch=<GIT_BRANCH>``
+        Git branch to build from.
+
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
+	pytest-bluezenv==0.1.6
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
+Test output is logged in ``test-functional.log``.
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
+	$ test/test-functional -k 'not btmgmt'
+
+Don't run tests with a given marker (see `test/pytest.ini` for defined markers):
+
+.. code-block::
+
+	$ test/test-functional -m "not tester"
+
+To exclude kernel testers from the run.
+E.g. run only security advisory regression tests:
+
+.. code-block::
+
+	$ test/test-functional -m sa
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
+This can be combined with the test selection options above.
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
+Tests will still prefer using emulated btvirt controller when
+possible.  To force all tests use the USB controllers:
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
2.55.0

