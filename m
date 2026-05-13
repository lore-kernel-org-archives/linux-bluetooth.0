Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18FF4C8FED
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 May 2026 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689130; cv=pass; b=T4CCfw4Q4QO7YaBhWXDDA92rZTvWMvj5BeAHlRib6Them6uUB3rMXFsw4i5rbVmDTLW3g+f/O3yF0Q2h22GFdQ28jMo3QIhhAtCpkeMFuD50V+VJ1GWNMbbcYTHC7UweD6odzLlgV6wG79RvLyimzTSzv/jS7KgbVmac0ZIjXpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689130; c=relaxed/simple;
	bh=mmip1nGGok3YTp7qVWn78pJjfteNGoHbYiV+cxj3fV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJmK47DbdyZ3qUGGX/0SHDi1OZMGEx4r8a9U0Gg8bLvVfZcROIGK7QtzFEqDV9289rSm+zFsFogPDu2/3/d6wuWqwZ0D28q2MoSEKmmQmBBeZgKruBuUHHylNY6ae+ze+h73eu5n3dsqvgbpTRrQawMO5My0W2Oyx+DjIui4H00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=HL6i027d; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="HL6i027d"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gFzD625Cjz10PV;
	Wed, 13 May 2026 19:18:46 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1778689126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPtT5jvBgD2PGbghV8/qPJSerav2kahqUsTmpurLpsQ=;
	b=HL6i027dqVR4NVm8jzs7MsxsMLXr0HLA8TObCtXRhWbkTlxUi/m5eLHXTO+b5lvrF/Oq2r
	PUVRimi6tG9ylK2DcWHrlAk+oqh0DLSv56L1NYhJ8++g4HZVlzff4I3qNdOkbrWN+1zwus
	aS0JScNxYCgweMRSzFZ+0YPqf04+4N8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1778689126;
	b=qcKRn6ojS5ilDW/KfAfIdkbOYP5+qfNY2WdUS7H7loqGvHoPxY58Y2Frt88pAokLDAbv0l
	+JnF5OSlrykpNzl0CGOCqL4aB/4VDFhew/mV7rvbS110/vgLFzcXp0aEy1EfDi9d3DxX3s
	+2vbYlviBRJODn19UgvqizIc/sldvlU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1778689126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sPtT5jvBgD2PGbghV8/qPJSerav2kahqUsTmpurLpsQ=;
	b=iP6nqAbYkih5hJQT6U7Od0M0FWSMYCS+OIHaxIrTfp96b09JYLG+WEbTakHi60DhXcnFBV
	THNzwmEb8Tc7g36zWWFzMsgd9IA1iouIE2D/X9wzkTQK5iMXoZjBsV5qvw+LjjFfnmTyEk
	dWMMaVawglNY7G4k80b4DDZoAigs5tY=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v5 16/16] test: functional: add basic obex file transfer tests
Date: Wed, 13 May 2026 19:17:33 +0300
Message-ID: <fe916fbf2a14cb2b53d0f29018a04419d73673a4.1778688966.git.pav@iki.fi>
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

Add tests for Obex DBus API and obexctl

test/functional/test_obex.py::test_obex_ftp_get
test/functional/test_obex.py::test_obex_ftp_list
test/functional/test_obex.py::test_obexctl_list
---
 test/functional/test_obex.py | 285 +++++++++++++++++++++++++++++++++++
 1 file changed, 285 insertions(+)
 create mode 100644 test/functional/test_obex.py

diff --git a/test/functional/test_obex.py b/test/functional/test_obex.py
new file mode 100644
index 000000000..fcb9105e5
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
2.54.0

