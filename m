Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C753B637E
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 16:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713436; cv=pass; b=ZboBIK741uoF2XwRdVD/pSv/tkfjyYop7WF6sRj/0GSHBgii8b3ppuPD8r8gilkc/G1u7ZWtVK9hf7XaBdgqaJb5SW94Yr13VOArrGlO5WU0ZI9nTEG5m18k3C/HQUfLP+Z36YVKjySZ8gYw4T5M3TP+KNzq7pNvtBG632654rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713436; c=relaxed/simple;
	bh=Y/Ur25g45iX7sLDIxYBD73HfO3xrzyo1cZCHmxT5f/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QXvGLBhhAnjLTqxut4NewoEocBorb79q/C77HrdNU9b+OjHRscsqGHLLjcWxwniwBCSmgLSonD84L7aZy3TzIrZ+es0yvLMHXVhz4dnnHRiV0UivZxWT19s0HXJc88UzOgLeCb8Ptq3G0ejORQUWf2wOGjw4fh8y3yRfBv30M0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vZ2okgax; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vZ2okgax"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hdGR41XJfz10Sn;
	Sun, 06 Sep 2026 19:50:24 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788713424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/GaygpmhuUfaNjfwsnRlOl/8k/6atFeBHKD1whYfpE=;
	b=vZ2okgaxK6Xzn0xoeqRTlStPYxQAdxLrZhyD4KACZHghEj2Rhjog8P4C5+C1vcGbdcJsaq
	fvmb9Nwxbm7l92MGaW3reuTG03jwZZ8OvL5LUWtG95s8caMTztmOCIPl7nxWAWigTrpnXx
	oKE9rU6vsNQF1G5dLP0YScuiwUW72FM=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788713424;
	b=pURWyMm96SQRzA/mIJzBpLb2EhTZCmIbSJzQ798kI9xcQJX5rA5WL5wX1bBOEGxTUiH2LJ
	iB59SY3RbnSCqmYEXixKbEWCKvnsQyOxcpUgiLR721+892NqxQaOdNUG+N2TiBzlRgSdvV
	HM8ywbgQe1d53iMKqIhRGnVKMsLAFak=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788713424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z/GaygpmhuUfaNjfwsnRlOl/8k/6atFeBHKD1whYfpE=;
	b=yOicsa414UO9PmrCo7u5M1o1GfFP8gDLIKZAC141ArmzZJN9Xe2N881wU9yVlu1+p8ukPU
	tccThqCc5ghukOiFwEcwiqbmtoGNlTt6NTdUBl9lpJULtEWgF9y+Xh94zUbW2bYnaXfHcO
	BIbyQ29Sd1XN3xm1M8RwfFPVMOebv4A=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 6/9] test: functional: add basic obex file transfer tests
Date: Sun,  6 Sep 2026 19:49:48 +0300
Message-ID: <1f97f1bdf961feaaa86b28cede4a1752e193b2d1.1788712996.git.pav@iki.fi>
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

Add tests for Obex DBus API and obexctl

test/functional/test_obex.py::test_obex_ftp_get
test/functional/test_obex.py::test_obex_ftp_list
test/functional/test_obex.py::test_obexctl_list
---
 test/functional/test_obex.py | 286 +++++++++++++++++++++++++++++++++++
 1 file changed, 286 insertions(+)
 create mode 100644 test/functional/test_obex.py

diff --git a/test/functional/test_obex.py b/test/functional/test_obex.py
new file mode 100644
index 000000000..345b61326
--- /dev/null
+++ b/test/functional/test_obex.py
@@ -0,0 +1,286 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: LGPL-2.1-or-later
+"""
+Tests for Obex
+"""
+
+import sys
+import os
+import re
+import pytest
+import subprocess
+import tempfile
+import time
+import logging
+import json
+import dbus
+import threading
+from pathlib import Path
+
+import pytest
+
+from pytest_bluezenv import (
+    HostPlugin,
+    Agent,
+    host_config,
+    find_exe,
+    Bluetoothd,
+    Bluetoothctl,
+    Obexd,
+    LogStream,
+    wait_until,
+    mainloop_wrap,
+    mainloop_assert,
+    Event,
+    EventPluginMixin,
+    dbus_service_event_method,
+    Pexpect,
+    utils,
+)
+
+pytestmark = [pytest.mark.vm]
+
+log = logging.getLogger(__name__)
+
+
+BUS_NAME = "org.bluez.obex"
+PATH = "/org/bluez/obex"
+AGENT_MANAGER_INTERFACE = "org.bluez.obex.AgentManager1"
+AGENT_INTERFACE = "org.bluez.obex.Agent1"
+CLIENT_INTERFACE = "org.bluez.obex.Client1"
+SESSION_INTERFACE = "org.bluez.obex.Session1"
+FILE_TRANSFER_INTERFACE = "org.bluez.obex.FileTransfer1"
+TRANSFER_INTERFACE = "org.bluez.obex.Transfer1"
+
+FTP_UUID = "00001106-0000-1000-8000-00805f9b34fb"
+
+
+class ObexAgent(HostPlugin, EventPluginMixin):
+    depends = [Bluetoothd()]
+    name = "obex_agent"
+
+    def __init__(self, path="/obexagent"):
+        self.path = path
+
+    @mainloop_wrap
+    def setup(self, impl):
+        EventPluginMixin.setup(self, impl)
+
+        self.bus = dbus.SessionBus()
+        self.bus.set_exit_on_disconnect(False)
+
+        self.agent = ObexAgentObject(self.bus, self.path, self.events)
+
+        bluez = self.bus.get_object(BUS_NAME, PATH)
+        self.manager = dbus.Interface(bluez, AGENT_MANAGER_INTERFACE)
+        self.manager.RegisterAgent(self.path)
+
+        log.info("Obex agent registered")
+
+    def cleanup(self):
+        path = Path("/run/obex")
+        for f in path.iterdir():
+            f.unlink()
+
+
+def agent_method(*a, **kw):
+    return dbus_service_event_method(AGENT_INTERFACE, *a, **kw)
+
+
+class ObexAgentObject(dbus.service.Object):
+    @mainloop_assert
+    def __init__(self, bus, path, events):
+        self.events = events
+        super().__init__(bus, path)
+
+    AuthorizePush = agent_method("AuthorizePush", ("path",), "o", "s", sync=False)
+    Cancel = agent_method("Cancel")
+
+
+def write_obex_file(name, content):
+    with open(f"/run/obex/{name}", "w") as f:
+        f.write(content)
+
+
+def read_file(name):
+    with open(name, "r") as f:
+        return f.read()
+
+
+#
+# Direct Obex Python client API tests
+#
+
+
+class ObexClient(HostPlugin, EventPluginMixin):
+    name = "obex"
+
+    @mainloop_wrap
+    def setup(self, impl):
+        EventPluginMixin.setup(self, impl)
+
+        self.transferred = 0
+        self.transfer_path = None
+        self.transfer_size = 0
+
+        self.bus = dbus.SessionBus()
+        self.bus.set_exit_on_disconnect(False)
+        self.log = logging.getLogger(self.name)
+        self.client = dbus.Interface(
+            self.bus.get_object(BUS_NAME, PATH), CLIENT_INTERFACE
+        )
+
+        self.bus.add_signal_receiver(
+            self.properties_changed,
+            dbus_interface="org.freedesktop.DBus.Properties",
+            signal_name="PropertiesChanged",
+            path_keyword="path",
+        )
+
+    @mainloop_wrap
+    def connect(self, bdaddr):
+        def reply(path):
+            obj = self.bus.get_object(BUS_NAME, path)
+            self.session = dbus.Interface(obj, SESSION_INTERFACE)
+            self.ftp = dbus.Interface(obj, FILE_TRANSFER_INTERFACE)
+
+        self._object_method(
+            self.client, "CreateSession", bdaddr, {"Target": "ftp"}, reply_handler=reply
+        )
+
+    @mainloop_assert
+    def properties_changed(self, interface, properties, invalidated, path):
+        if path != self.transfer_path:
+            return
+
+        if "Status" in properties and (
+            properties["Status"] == "complete" or properties["Status"] == "error"
+        ):
+            self.events.put(
+                Event(
+                    f"{FILE_TRANSFER_INTERFACE}:{properties['Status']}",
+                    properties=properties,
+                )
+            )
+            self.log.debug(f"Transfer {properties['Status']}")
+
+        if "Transferred" not in properties:
+            return
+
+        value = properties["Transferred"]
+        speed = (value - self.transferred) / 1000
+        self.log.debug(
+            f"Transfer progress {value}/{self.transfer_size} at {speed} kBps"
+        )
+        self.transferred = value
+
+    @mainloop_wrap
+    def ftp_list_folder(self):
+        return self.ftp.ListFolder()
+
+    @mainloop_wrap
+    def ftp_get_file(self, dst, src):
+        path, properties = self.ftp.GetFile(dst, src)
+        self.transfer_path = path
+        self.transfer_size = properties["Size"]
+        return properties["Filename"]
+
+
+@pytest.fixture
+def paired_hosts(hosts):
+    from .test_agent import test_agent_pair_bredr
+
+    if hosts[0].agent.has_device(hosts[1].bdaddr):
+        return hosts
+
+    test_agent_pair_bredr(hosts, True)
+    return hosts
+
+
+obex_host_config = host_config(
+    [Agent(), Obexd(), ObexClient(), Pexpect()],
+    [Agent(), Obexd(), ObexAgent()],
+    reuse=True,
+)
+
+
+@pytest.fixture
+def obex_hosts(paired_hosts):
+    host0, host1 = paired_hosts
+
+    if hasattr(host0, "session"):
+        return paired_hosts
+
+    host0.obex.connect(host1.bdaddr)
+
+    service = host1.agent.expect("org.bluez.Agent1.AuthorizeService")
+    assert service.uuid == FTP_UUID
+    host1.agent.reply()
+
+    host0.obex.expect("org.bluez.obex.Client1.CreateSession:reply")
+
+    yield paired_hosts
+
+    host1.obex_agent.cleanup()
+
+
+@obex_host_config
+def test_obex_ftp_list(obex_hosts):
+    host0, host1 = obex_hosts
+
+    host1.call(write_obex_file, "test", "1234")
+
+    (item,) = host0.obex.ftp_list_folder()
+    assert item["Type"] == "file"
+    assert item["Name"] == "test"
+    assert item["Size"] == 4
+
+
+@obex_host_config
+def test_obex_ftp_get(obex_hosts):
+    host0, host1 = obex_hosts
+
+    host1.call(write_obex_file, "test", "1234")
+
+    filename = host0.obex.ftp_get_file("", "test")
+    host0.obex.expect("org.bluez.obex.FileTransfer1:complete")
+    assert host0.call(read_file, filename) == "1234"
+
+
+#
+# obexctl tests
+#
+
+
+@pytest.fixture
+def obexctl(obex_hosts):
+    host0, host1 = obex_hosts
+
+    exe = find_exe("tools", "obexctl")
+    obexctl = host0.pexpect.spawn([exe])
+
+    obexctl.expect("Client /org/bluez/obex")
+    obexctl.send(f"connect {host1.bdaddr} {FTP_UUID}\n")
+
+    service = host1.agent.expect("org.bluez.Agent1.AuthorizeService")
+    assert service.uuid == FTP_UUID
+    host1.agent.reply()
+
+    obexctl.expect("Connection successful")
+    obexctl.send(f"select /org/bluez/obex/client/session1\n")
+
+    yield obexctl
+
+    obexctl.close()
+
+
+@obex_host_config
+def test_obexctl_list(obex_hosts, obexctl):
+    host0, host1 = obex_hosts
+
+    host1.call(write_obex_file, "test", "1234")
+
+    obexctl.send(f"ls\n")
+    obexctl.expect(f"Type: file")
+    obexctl.expect(f"Name: test")
+    obexctl.expect(f"Size: 4")
-- 
2.55.0

