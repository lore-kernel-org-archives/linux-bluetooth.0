Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934A368972
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041141; cv=pass; b=q0lNyzSSmqll82RWxwEen3cbWGPjrJcmd/f6wKkzgRq77ixpHRU1lDj2yMgcjWV3Yfpw09F1o1FASAT1gmXYkhjObfTgXg8d32tOTgxb511ufkg8LIg6sXBiM/KOzqoGuRfhk7NDgyFTwj0ySOBHS0QX9zdN2xqUkDSYHClIFsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041141; c=relaxed/simple;
	bh=Fa+3O/kCXpK7End/Epo7MsQGWB0qDK7/uwfEgpx6yT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NWaehBUK57x4YcjAsyjjJypLDQsabH+WT46SbxqJ3iooHpQPk8X83HPxI29Fc9Va9WmTSkey/yo897UFOsGzD7C3ljEb+4O/cWrIfTALa7Ar8XkTfoeTaKdbxOcQQ454ef0pcNiZ8fm1uW0eV7Vkl48FgGJrGR2Je3noXxmFTPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qXoRSNks; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qXoRSNks"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fcwHk1hpDzyTn;
	Fri, 20 Mar 2026 23:12:18 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774041138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIN07/3Wg3sI1kQ8GMuj508n59GUm9mPA4ku+G4g2ak=;
	b=qXoRSNksyZUr1cQ7XkdnM6Rl1PWNTapWY27QfiJYWX+gns/w9j+KQZ85xePnwuC3Yba89V
	LVhbbXXal/0Oi2jU5YExiXPbVJj9QdMILIyVaMhiDxxz4UULin/m5ECXkpNO1iUufxmS8T
	LQ90j3KHpkBWXDMhoPfo8jhdBRYti8c=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774041138;
	b=GkHMcl7CTeAFqpm6byfNYsg2mJX42LZ5s50EoPNa6nVZjWhK0LsNSooiSdbR7reqHo3Yj3
	3oDvIzsxqXqh/Yp0oU4/HzUtHDjt7l37i40WDaCufNAB8fCvMp2PVyttSOpt23qdaJg2qK
	rAudPIQdXHbIFZY8AtxD8y5gfkZfZfQ=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774041138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gIN07/3Wg3sI1kQ8GMuj508n59GUm9mPA4ku+G4g2ak=;
	b=Ny0dN9ObeiX9sqG+Q+fPj2Z3bCKQ7kll9JpK++CxjwFOYcoaFJ1d0bH9G5EOd1SJlaJFrX
	xkrztTWaMFXW8pZg8+mAlA6Jct7VHF7aMI9uMSoKiMD8KU6toLXFkDk7RSY8F3lKY6lprE
	zrLf2OcvRs5BfHXc1aGiSCkfa+HjLic=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 20/20] test: functional: add basic obex file transfer tests
Date: Fri, 20 Mar 2026 23:12:07 +0200
Message-ID: <52acd3144d379e5e5a80d666ecb1238f68ec2610.1774041047.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774041047.git.pav@iki.fi>
References: <cover.1774041047.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests

test/functional/test_obex.py::test_obex_ftp_get
test/functional/test_obex.py::test_obex_ftp_list
test/functional/test_obex.py::test_obexctl_list
---
 test/functional/test_obex.py      | 285 ++++++++++++++++++++++++++++++
 test/pytest_bluez/host_plugins.py |  61 +++++++
 2 files changed, 346 insertions(+)
 create mode 100644 test/functional/test_obex.py

diff --git a/test/functional/test_obex.py b/test/functional/test_obex.py
new file mode 100644
index 000000000..6b9275520
--- /dev/null
+++ b/test/functional/test_obex.py
@@ -0,0 +1,285 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: LGPL-2.1-or-later
+"""
+Tests for Obex
+"""
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
+from pytest_bluez import (
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
+    host0.pexpect.expect(obexctl, "Client /org/bluez/obex")
+
+    host0.pexpect.send(obexctl, f"connect {host1.bdaddr} {FTP_UUID}\n")
+
+    service = host1.agent.expect("org.bluez.Agent1.AuthorizeService")
+    assert service.uuid == FTP_UUID
+    host1.agent.reply()
+
+    host0.pexpect.expect(obexctl, "Connection successful")
+    host0.pexpect.send(obexctl, f"select /org/bluez/obex/client/session1\n")
+
+    yield obexctl
+
+    host0.pexpect.close(obexctl)
+
+
+@obex_host_config
+def test_obexctl_list(obex_hosts, obexctl):
+    host0, host1 = obex_hosts
+
+    host1.call(write_obex_file, "test", "1234")
+
+    host0.pexpect.send(obexctl, f"ls\n")
+    host0.pexpect.expect(obexctl, f"Type: file")
+    host0.pexpect.expect(obexctl, f"Name: test")
+    host0.pexpect.expect(obexctl, f"Size: 4")
diff --git a/test/pytest_bluez/host_plugins.py b/test/pytest_bluez/host_plugins.py
index 678afc764..dd8ffaed6 100644
--- a/test/pytest_bluez/host_plugins.py
+++ b/test/pytest_bluez/host_plugins.py
@@ -16,6 +16,7 @@ import signal
 import functools
 import threading
 import resource
+import shutil
 from pathlib import Path
 
 import pytest
@@ -34,6 +35,7 @@ __all__ = [
     "Call",
     "DbusSession",
     "DbusSystem",
+    "Obexd",
     "Pexpect",
     "Rcvbuf",
 ]
@@ -263,6 +265,65 @@ class Bluetoothd(env.HostPlugin):
         self.log_stream.close()
 
 
+class Obexd(env.HostPlugin):
+    """
+    Host plugin starting obexd.
+    """
+
+    name = "obexd"
+    depends = [Bluetoothd(), DbusSession()]
+
+    def __init__(self):
+        self.uuids = ("00001133-0000-1000-8000-00805f9b34fb",)
+
+    def presetup(self, config):
+        try:
+            self.exe = utils.find_exe("obexd/src", "obexd")
+        except FileNotFoundError as exc:
+            pytest.skip(reason=f"Obexd: {exc!r}")
+
+    @utils.mainloop_wrap
+    def setup(self, impl):
+        self.log = logging.getLogger(self.name)
+
+        self.path = Path("/run/obex")
+        self.path.mkdir()
+
+        cmd = [self.exe, "--nodetach", f"--root={self.path}", "-d", "*"]
+        self.log.info("Start obexd: {}".format(utils.quoted(cmd)))
+
+        self.log_stream = utils.LogStream("obexd")
+        self.job = subprocess.Popen(
+            cmd,
+            stdin=subprocess.DEVNULL,
+            stdout=self.log_stream.stream,
+            stderr=subprocess.STDOUT,
+        )
+
+        # Wait for the service
+        self.log.info("Wait for obexd...")
+        bus = dbus.SystemBus()
+        bus.set_exit_on_disconnect(False)
+        adapter = dbus.Interface(
+            bus.get_object("org.bluez", "/org/bluez/hci0"),
+            "org.freedesktop.DBus.Properties",
+        )
+
+        def cond():
+            uuids = [str(uuid) for uuid in adapter.Get("org.bluez.Adapter1", "UUIDs")]
+            return all(uuid in uuids for uuid in self.uuids)
+
+        utils.wait_until(cond)
+
+        self.log.info("Obexd ready")
+
+    def teardown(self):
+        self.log.info("Stop obexd")
+        self.job.terminate()
+        self.log_stream.close()
+        shutil.rmtree(self.path)
+
+
 class Pexpect(env.HostPlugin):
     """
     Host plugin for starting and controlling processes with pexpect.
-- 
2.53.0

