Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.183.196
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535618;
	b=soGt67Pnns34NHcruoeo31PT6Gw1qtmDcm5ZyEpB0srK9V3kIxCFyiRSkCga3kzt4d9E
	 lJk1llJiCuuPWuSjOy/qTg35MI7Ui0ABttte0IcTZR3hPOskXI96yz0pT1m6Mh5oDuB5T
	 frnKsSTxbNTNBwAXmer0HN8XpjUc19IVv8lWFh/akD9en0Dn1Gq7YKqbK/wr8fU2zvwWo
	 Ox+4SFedkR+yb7PaPR7pat/dteMrQS1ZLHgx94IPwJVLusRxtTikuZRFB71T2L+jtph76
	 sf2AxL3ezJKhms7FhmMZx7sS/JJM1OaCIlmkaki0cG7zd11sZ5zaqj3BYxAHY+UPlTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535618;
	h=DMARC-Filter:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-GND-Sasl:X-GND-Score:X-GND-Cause:
	 X-GND-State;
	bh=9b9KSaVnwhSLeMS0MOiKJp9GohQZA1W9fKTU/hdNXMU=;
	b=d99yE5GgivSicix04arUhbP74x0GIpiMOfb8VoFb9HvNh4fic/GhSwS6pOunzH1qNuo/
	 HdHIAsrhDR3nnYtADmFZJ7Aj91WP0dSB3itTcdKuVMIMHQoqc/TYLPqd3VBO02C0R9MyS
	 tVNKwKyLa5c1tYO/jgykcmQyfd89MgCzp6WWnISIkUJIcEtKurkJS8iATa5Pn3EJO16h1
	 OuCgyA3E3RUotPdQEiOzBRt6SWfUZTxDb5bRDCQZJ391rrTjiOEjMIcgzOPVhatApyBUB
	 fgHAPVQtlHSrF0iT2EN3BYj7hs9PtQrqpTntOJOxnUWfxD51FQGSgOdL6xnLxY9zSMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hadess.net;
	spf=pass smtp.mailfrom=hadess.net;
	arc=none smtp.remote-ip=217.70.183.196
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC642606A696
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC642606A696
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25CDD3F5B3
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 15:53:30 +0000 (UTC)
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ v11 11/14] unit: Add command-line tool tests
Date: Tue, 24 Nov 2026 16:50:42 +0100
Message-ID: <20261124155319.1752879-12-hadess@hadess.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124155319.1752879-1-hadess@hadess.net>
References: <20261124155319.1752879-1-hadess@hadess.net>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: hadess@hadess.net
X-GND-Score: 0
X-GND-Cause: dmFkZTEoaa2s/0tV0hbUTTvXmeF3A7+P0IaNcDI/iBZ09cgHd9SZafoUrwqJOD6UEhFXD0z2Ol1wjsRt7ZyL3fhIjMoS+I67yCBNp3Uc0NE7X6Rn6WS498nuuOAzuFUOeAvYRGOHeDFcmopyxjvIDgPpaDOHAZXpLdrQSB8FSYEbKDHlOVcV6Wmuikte0DGQJiQogGuaX5fljWU+mD+RAB4F7FKC+iJ3GyjzOhk3O/EiuL/WAfv0scnFNCaDl0mKtq/9KM0hc19lTjrBWEvavTPnLTaLyhZlK9W7U2uQ6FaMiGXzVB/J2C8jtfH+5ycSJlUJn/JYEIFdncgJq+j9s6Li3D4zQSRoGWb8hc0G2j+pbgZxPBzP3AeL01mrAulcLE3C3n76IIA8Epld3zHmMhdGbvmHctPtQJys9M+ct35NAlNNfXM/XkQPKLG2vnMXT0m3PFsirdOUoUvFLbsoHju8D49394ZdzjCv1sCEYoyVYKBE632iQa8kZOm0LIe+hwlIoUKRbNW0eWMfCK7s3u9CARYln0YQ20LNAkUSZeHEJDYQ4uZCz+WesZ2opp2zb0wsnqgZ5jSRlcw4h+Y3Dum0YCKhpasJ79vaxSe9ww88mcUKZOwD7THwVWxA5oK2LjT4ZB4yF0XQe1Z1W0t8rToyJBP87y1BDLrBPZIes7RWcdR/Zw
X-GND-State: clean

Add tests for command-line tools. Those tests will start btvirt if no
Bluetooth adapters are available, start bluetoothd if not already
started, and run some of our tools in conditions where they would
have caused problems.

If a Bluetooth adapter is plugged in and bluetoothd started, the tests
will use those to run the tests against, making it easy to run tests on
a developer's machine.

If there are no available Bluetooth adapters and bluetoothd isn't
running, the tests will need to run as root, as is common on CI setups.
---
 meson.build                           |   8 +
 unit/meson.build                      |  30 +++
 unit/output_checker.py                | 214 ++++++++++++++++++++
 unit/tool-integration-test-skipped.sh |   3 +
 unit/tool-integration-test.py         | 271 ++++++++++++++++++++++++++
 unit/unittest_inspector.py            |  46 +++++
 6 files changed, 572 insertions(+)
 create mode 100644 unit/output_checker.py
 create mode 100755 unit/tool-integration-test-skipped.sh
 create mode 100755 unit/tool-integration-test.py
 create mode 100755 unit/unittest_inspector.py

diff --git a/meson.build b/meson.build
index 01582a0b5969..2bd29674b656 100644
--- a/meson.build
+++ b/meson.build
@@ -269,6 +269,14 @@ configure_file(
   configuration: config_h
 )
 
+python = import('python')
+python3 = python.find_installation('python3')
+has_pythonmodules = false
+script = 'import dbusmock\nimport pexpect'
+if run_command(python3, '-c', script, check: false).returncode() == 0
+  has_pythonmodules = true
+endif
+
 subdir('lib')
 if not get_option('tools').disabled() or get_option('client').enabled() or get_option('obex').enabled() or not get_option('tests').disabled() or not get_option('daemon').disabled()
   subdir('gdbus')
diff --git a/unit/meson.build b/unit/meson.build
index 018bfd33dfa9..023747f207c4 100644
--- a/unit/meson.build
+++ b/unit/meson.build
@@ -157,3 +157,33 @@ add_test_setup(
   # default timeout in meson is 30s
   timeout_multiplier: 4,
 )
+
+if not has_pythonmodules
+  test('tool-integration-test-skipped',
+    find_program('tool-integration-test-skipped.sh'),
+  )
+else
+  tool_integration_test = find_program('tool-integration-test.py')
+
+  envs = environment()
+  envs.set ('top_builddir', meson.global_build_root())
+  envs.set ('top_srcdir', meson.global_source_root())
+
+  test_deps = []
+
+  python3 = find_program('python3')
+  unittest_inspector = find_program('unittest_inspector.py')
+  r = run_command(unittest_inspector, files('tool-integration-test.py'), check: true)
+  unit_tests = r.stdout().strip().split('\n')
+
+  foreach ut: unit_tests
+    ut_args = files('tool-integration-test.py')
+    ut_args += ut
+    test(ut,
+      python3,
+      args: ut_args,
+      env: envs,
+      depends: test_deps
+    )
+  endforeach
+endif
diff --git a/unit/output_checker.py b/unit/output_checker.py
new file mode 100644
index 000000000000..037e248b9311
--- /dev/null
+++ b/unit/output_checker.py
@@ -0,0 +1,214 @@
+#! /usr/bin/env python3
+# Copyright © 2020, RedHat Inc.
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2.1 of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library. If not, see <http://www.gnu.org/licenses/>.
+# Authors:
+#       Benjamin Berg <bberg@redhat.com>
+
+import os
+import sys
+import fcntl
+import io
+import re
+import time
+import threading
+import select
+import errno
+
+
+class OutputChecker(object):
+    def __init__(self, out=sys.stdout):
+        self._output = out
+        self._pipe_fd_r, self._pipe_fd_w = os.pipe()
+        self._partial_buf = b""
+        self._lines_sem = threading.Semaphore()
+        self._lines = []
+        self._reader_io = io.StringIO()
+
+        # Just to be sure, shouldn't be a problem even if we didn't set it
+        fcntl.fcntl(
+            self._pipe_fd_r,
+            fcntl.F_SETFL,
+            fcntl.fcntl(self._pipe_fd_r, fcntl.F_GETFL) | os.O_CLOEXEC | os.O_NONBLOCK,
+        )
+        fcntl.fcntl(
+            self._pipe_fd_w,
+            fcntl.F_SETFL,
+            fcntl.fcntl(self._pipe_fd_w, fcntl.F_GETFL) | os.O_CLOEXEC,
+        )
+
+        # Start copier thread
+        self._thread = threading.Thread(target=self._copy, daemon=True)
+        self._thread.start()
+
+    def _copy(self):
+        p = select.poll()
+        p.register(self._pipe_fd_r)
+        while True:
+            try:
+                # Be lazy and wake up occasionally in case _pipe_fd_r became invalid
+                # The reason to do this is because os.read() will *not* return if the
+                # FD is forcefully closed.
+                p.poll(0.1)
+
+                r = os.read(self._pipe_fd_r, 1024)
+                if not r:
+                    os.close(self._pipe_fd_r)
+                    self._pipe_fd_r = -1
+                    self._lines_sem.release()
+                    return
+            except OSError as e:
+                if e.errno == errno.EWOULDBLOCK:
+                    continue
+
+                # We get a bad file descriptor error when the outside closes the FD
+                if self._pipe_fd_r >= 0:
+                    os.close(self._pipe_fd_r)
+                self._pipe_fd_r = -1
+                self._lines_sem.release()
+                return
+
+            l = r.split(b"\n")
+            l[0] = self._partial_buf + l[0]
+            self._lines.extend(l[:-1])
+            self._partial_buf = l[-1]
+
+            self._lines_sem.release()
+
+            os.write(self._output.fileno(), r)
+
+    def check_line_re(self, needle_re, timeout=0, failmsg=None):
+        deadline = time.time() + timeout
+
+        if isinstance(needle_re, str):
+            needle_re = needle_re.encode("ascii")
+
+        r = re.compile(needle_re)
+        ret = []
+
+        while True:
+            try:
+                l = self._lines.pop(0)
+            except IndexError:
+                # EOF, throw error
+                if self._pipe_fd_r == -1:
+                    if failmsg:
+                        raise AssertionError(
+                            "No further messages: " % failmsg
+                        ) from None
+                    else:
+                        raise AssertionError(
+                            "No client waiting for needle %s" % (str(needle_re))
+                        ) from None
+
+                # Check if should wake up
+                if not self._lines_sem.acquire(timeout=deadline - time.time()):
+                    if failmsg:
+                        raise AssertionError(failmsg) from None
+                    else:
+                        raise AssertionError(
+                            "Timed out waiting for needle %s (timeout: %0.2f)"
+                            % (str(needle_re), timeout)
+                        ) from None
+                continue
+
+            ret.append(l)
+            if r.search(l):
+                return ret
+
+    def check_line(self, needle, timeout=0, failmsg=None):
+        if isinstance(needle, str):
+            needle = needle.encode("ascii")
+
+        needle_re = re.escape(needle)
+
+        return self.check_line_re(needle_re, timeout=timeout, failmsg=failmsg)
+
+    def check_no_line_re(self, needle_re, wait=0, failmsg=None):
+        deadline = time.time() + wait
+
+        if isinstance(needle_re, str):
+            needle_re = needle_re.encode("ascii")
+
+        r = re.compile(needle_re)
+        ret = []
+
+        while True:
+            try:
+                l = self._lines.pop(0)
+            except IndexError:
+                # EOF, so everything good
+                if self._pipe_fd_r == -1:
+                    break
+
+                # Check if should wake up
+                if not self._lines_sem.acquire(timeout=deadline - time.time()):
+                    # Timed out, so everything is good
+                    break
+                continue
+
+            ret.append(l)
+            if r.search(l):
+                if failmsg:
+                    raise AssertionError(failmsg)
+                else:
+                    raise AssertionError(
+                        "Found needle %s but shouldn't have been there (timeout: %0.2f)"
+                        % (str(needle_re), wait)
+                    )
+
+        return ret
+
+    def check_no_line(self, needle, wait=0, failmsg=None):
+        if isinstance(needle, str):
+            needle = needle.encode("ascii")
+
+        needle_re = re.escape(needle)
+
+        return self.check_no_line_re(needle_re, wait=wait, failmsg=failmsg)
+
+    def clear(self):
+        ret = self._lines
+        self._lines = []
+        return ret
+
+    def assert_closed(self, timeout=1):
+        self._thread.join(timeout)
+
+        if self._thread.is_alive() != False:
+            raise AssertionError("OutputCheck: Write side has not been closed yet!")
+
+    def force_close(self):
+        fd = self._pipe_fd_r
+        self._pipe_fd_r = -1
+        if fd >= 0:
+            os.close(fd)
+
+        self._thread.join()
+
+    @property
+    def fd(self):
+        return self._pipe_fd_w
+
+    def writer_attached(self):
+        os.close(self._pipe_fd_w)
+        self._pipe_fd_w = -1
+
+    def __del__(self):
+        if self._pipe_fd_r >= 0:
+            os.close(self._pipe_fd_r)
+            self._pipe_fd_r = -1
+        if self._pipe_fd_w >= 0:
+            os.close(self._pipe_fd_w)
+            self._pipe_fd_w = -1
diff --git a/unit/tool-integration-test-skipped.sh b/unit/tool-integration-test-skipped.sh
new file mode 100755
index 000000000000..ac1449442020
--- /dev/null
+++ b/unit/tool-integration-test-skipped.sh
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+exit 77
diff --git a/unit/tool-integration-test.py b/unit/tool-integration-test.py
new file mode 100755
index 000000000000..7d5f8d51ea17
--- /dev/null
+++ b/unit/tool-integration-test.py
@@ -0,0 +1,271 @@
+#!/usr/bin/python3
+
+# Copyright: (C) 2025 Bastien Nocera <hadess@hadess.net>
+# Copyright: (C) 2023 cagney, for the AsciiDecoder
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+import os
+import sys
+import subprocess
+import unittest
+import time
+import re
+from output_checker import OutputChecker
+
+try:
+    import gi
+    from gi.repository import GLib
+except ImportError as e:
+    sys.stderr.write('Skipping tests, PyGobject not available for Python 3, or missing GI typelibs: %s\n' % str(e))
+    sys.exit(77)
+
+builddir = os.getenv('top_builddir', '.')
+
+try:
+    import dbusmock
+    import dbus
+except ImportError:
+    sys.stderr.write('Skipping tests, python-dbusmock not available (https://pypi.python.org/pypi/python-dbusmock).\n')
+    sys.exit(77)
+
+try:
+    import pexpect
+except ImportError:
+    sys.stderr.write('Skipping tests, pexpect not available (https://pypi.org/project/pexpect/).\n')
+    sys.exit(77)
+
+def count_adapters():
+    try:
+        for entry in os.walk('/sys/class/bluetooth'):
+            return len(entry[1])
+        return 0
+    except OSError:
+        return 0
+
+def is_root():
+    return os.geteuid() == 0
+
+# https://stackoverflow.com/a/76543345
+# CC-BY-SA 4.0 relicensed under GPLv2 or later
+# see https://web.archive.org/web/20200805075926/http://ascii-table.com/ansi-escape-sequences.php
+class AsciiDecoder(object):
+    def __init__(self):
+        self.buf = b''
+    def encode(self, b, final=False):
+        return b
+    def decode(self, b, final=False):
+        # escape sequences can be split so
+        # work on lines
+        self.buf = self.buf + b
+        i = self.buf.find(b'\n')
+        if i >= 0:
+            c = self.buf[0:i+1]
+            self.buf = self.buf[i+1:]
+            d = re.sub(rb'\x1b\[[0-9;=?]*[HfABCDsuJKmhlr]', b'*', c)
+            e = re.sub(rb'\x1b', b'<ESC>', d)
+            if e != e:
+                print(">", e, "<")
+            return e
+        return b''
+
+class Tests(dbusmock.DBusTestCase):
+
+    @classmethod
+    def setUpClass(cls):
+        super().setUpClass()
+        cls.dbus_con = cls.get_dbus(True)
+
+    @classmethod
+    def tearDownClass(cls):
+        super().tearDownClass()
+
+    def setUp(self):
+        super().setUp()
+        self.daemon_log = OutputChecker()
+
+    def stop_virt(self):
+        if self.virt:
+            try:
+                self.virt.terminate()
+            except OSError:
+                pass
+            self.assertEqual(self.virt.wait(timeout=3000), 0)
+
+        self.virt = None
+
+    def start_virt(self):
+        if not is_root():
+            self.skipTest('btvirt cannot start as we are not root')
+
+        num_adapters = count_adapters()
+
+        self.virt = subprocess.Popen(
+            [ self.btvirt_path(), '-l1' ],
+        )
+        self.addCleanup(self.stop_virt)
+
+        self.assert_eventually(lambda: count_adapters() > num_adapters)
+
+    def start_virt_if_needed(self):
+        if count_adapters() == 0:
+            self.start_virt()
+
+    def stop_daemon(self):
+        if self.daemon:
+            try:
+                self.daemon.terminate()
+            except OSError:
+                pass
+            self.assertEqual(self.daemon.wait(timeout=3000), 0)
+
+        self.daemon = None
+
+    def daemon_check(self):
+        if not self.dbus_con.name_has_owner('org.bluez'):
+            return False
+
+        try:
+            p = dbus.Interface(self.dbus_con.get_object('org.bluez', '/'),
+                               dbus_interface=dbus.INTROSPECTABLE_IFACE)
+            p.Introspect()
+            return True
+        except dbus.exceptions.DBusException as e:
+            last_exc = e
+            if '.UnknownInterface' in str(e):
+                return False
+
+    def start_daemon(self):
+        if not is_root():
+            self.skipTest('bluetoothd cannot start as we are not root')
+
+        self.daemon = subprocess.Popen(
+            [ self.bluetoothd_path(), '--nodetach', '-f', self.bluetooth_config_path() ],
+            stdout=subprocess.DEVNULL, stderr=self.daemon_log.fd
+        )
+        self.daemon_log.writer_attached()
+        self.addCleanup(self.stop_daemon)
+
+        self.assert_eventually(lambda: self.daemon_check())
+
+    def start_daemon_if_needed(self):
+        # Only start daemon if one is not already available
+        if not self.daemon_check():
+            self.start_daemon()
+
+    def binary_path(self, binary):
+        builddir = os.getenv('top_builddir', '.')
+        return os.path.join(builddir, binary)
+
+    def bluetoothctl_path(self):
+        return self.binary_path('client/bluetoothctl')
+
+    def btmgmt_path(self):
+        return self.binary_path('tools/btmgmt')
+
+    def btvirt_path(self):
+        return self.binary_path('emulator/btvirt')
+
+    def bluetoothd_path(self):
+        return self.binary_path('src/bluetoothd')
+
+    def bluetooth_config_path(self):
+        srcdir = os.getenv('top_srcdir', '.')
+        return os.path.join(srcdir, 'src/main.conf')
+
+    def assert_eventually(self, condition, message=None, timeout=5000, keep_checking=0):
+        """Assert that condition function eventually returns True.
+
+        Timeout is in milliseconds, defaulting to 5000 (5 seconds). message is
+        printed on failure.
+        """
+        if not keep_checking:
+            if condition():
+                return
+
+        done = False
+
+        def on_timeout_reached():
+            nonlocal done
+            done = True
+
+        source = GLib.timeout_add(timeout, on_timeout_reached)
+        while not done:
+            if condition():
+                GLib.source_remove(source)
+                if keep_checking > 0:
+                    self.assert_condition_persists(
+                        condition, message, timeout=keep_checking
+                    )
+                return
+            GLib.MainContext.default().iteration(False)
+
+        self.fail(message() if message else f"timed out waiting for {condition}")
+
+    def test_bluetoothctl_no_output(self):
+        self.start_virt_if_needed()
+        self.start_daemon_if_needed()
+
+        num_adapters = count_adapters()
+
+        cmd = subprocess.run([ self.bluetoothctl_path(), 'list' ], check=False, capture_output=True)
+        output = cmd.stdout.decode('UTF-8')
+        self.assertEqual(len(output.strip().split('\n')), num_adapters)
+        self.assertRegex(output, '.*\\[default\\]')
+
+    def test_btmgmt_stdin_hang(self):
+        self.start_virt_if_needed()
+
+        num_adapters = count_adapters()
+
+        cmd = subprocess.run([ self.btmgmt_path(), 'info' ], stdin=subprocess.DEVNULL, check=False, capture_output=True)
+        output = cmd.stdout.decode('UTF-8')
+        self.assertRegex(output, '.*Index list with ' + str(num_adapters) + ' item')
+
+    def test_btmgmt_help_hang(self):
+        devnull = open(os.devnull, 'w')
+        cmd_log = OutputChecker(out=devnull)
+        cmd = subprocess.Popen([ self.btmgmt_path(), '--help' ], stdout=cmd_log.fd)
+        cmd_log.writer_attached()
+
+        # Check that btmgmt --help doesn't hang
+        self.assertEqual(cmd.wait(timeout=1), 0)
+        devnull.close()
+
+        # Check that it contains the help output
+        cmd_log.check_line('Send HCI Command and wait for Event', timeout=1)
+
+    def test_bluetoothd_failed_to_set_default_config(self):
+        if self.daemon_check():
+            # We need to start bluetoothd ourselves, so skip the test
+            self.skipTest('Test requires that we start bluetoothd ourselves')
+
+        self.start_virt_if_needed()
+        self.start_daemon()
+
+        self.daemon_log.check_line('Battery Provider Manager created', timeout=1)
+        self.daemon_log.check_no_line('Failed to set default system config for',
+                                      failmsg='Error output when using stock configuration')
+
+    def test_bluetoothctl_completion_crash(self):
+        child = pexpect.spawn(self.bluetoothctl_path())
+        child._decoder = AsciiDecoder()
+        child.expect(r'\[bluetoothctl\]> ')
+        child.sendline(' \t')
+        child.expect(r'\[bluetoothctl\]> ')
+
+        time.sleep(0.5)
+
+        self.assertTrue(child.isalive())
+
+
+if __name__ == '__main__':
+    unittest.main()
diff --git a/unit/unittest_inspector.py b/unit/unittest_inspector.py
new file mode 100755
index 000000000000..fe8304686da7
--- /dev/null
+++ b/unit/unittest_inspector.py
@@ -0,0 +1,46 @@
+#! /usr/bin/env python3
+# Copyright © 2020, Canonical Ltd
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU Lesser General Public
+# License as published by the Free Software Foundation; either
+# version 2.1 of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+# Lesser General Public License for more details.
+#
+# You should have received a copy of the GNU Lesser General Public
+# License along with this library. If not, see <http://www.gnu.org/licenses/>.
+# Authors:
+#       Marco Trevisan <marco.trevisan@canonical.com>
+
+import argparse
+import importlib.util
+import inspect
+import os
+import unittest
+
+def list_tests(module):
+    tests = []
+    for name, obj in inspect.getmembers(module):
+        if inspect.isclass(obj) and issubclass(obj, unittest.TestCase) and not name.startswith('OopTests'):
+            cases = unittest.defaultTestLoader.getTestCaseNames(obj)
+            tests += [ (obj, '{}.{}'.format(name, t)) for t in cases ]
+    return tests
+
+
+if __name__ == '__main__':
+    parser = argparse.ArgumentParser()
+    parser.add_argument('unittest_source', type=argparse.FileType('r'))
+
+    args = parser.parse_args()
+    source_path = args.unittest_source.name
+    spec = importlib.util.spec_from_file_location(
+        os.path.basename(source_path), source_path)
+    module = importlib.util.module_from_spec(spec)
+    spec.loader.exec_module(module)
+
+    for machine, human in list_tests(module):
+        print(human)
-- 
2.56.0

