Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A7341ACA
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Apr 2026 12:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775392894; cv=pass; b=lbigEe1pXxW7zfWVch7d7iNaOP3dRr+5FqyD38d3QBIVJiZXutplRmMIP1myUIJui2/mP0OJe3WtpCYFUBJIgXmqSIeH0/5dfuVKtQM8afXscvnxY3IyCkWTFdjFps3+uGNVl/A4ZrpgwNrc9UaPoAWHLnboWdkY0gic85vYyBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775392894; c=relaxed/simple;
	bh=6KSwbhUtHzcUQ9cKtshbvQ/8n8MBs/kaFeO04sV/VCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhmutZZPtUCYUJAOvmR1YK5bhDEe6Q3GIpxwibRi5zCq2zlUZYqE/7CgN1Fu750oUQzWw9N8uqbjJHculae2P3wh+8oIeFew6+7/3sM9Aqbz78KoK2dJafqYIu6iI3A82DvToqwCLxpSVDu6qrmK81iNKq87vRVLc16nQUpOQcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=JkLTEmId; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="JkLTEmId"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fpXBy0X4JzyfM;
	Sun, 05 Apr 2026 15:41:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1775392890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+biOyeo4lNIZifwk4chwASHhVC8FUq0bVDbejKnY24=;
	b=JkLTEmIdSZdLV801OM1GMebPdyNGDt4g8zghFsmArWNp88G7F91xyyjkG5M/q73xyEECCi
	ACwwe61LzJ56vmYwnuS0ZWHXf5AetMhX2H04FPh+jFLkO2e0eCjuo1d8qvP9bDf/8dGGuU
	bbzz/QmGuKNgHB8jGsql9O/PqVVjTDk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1775392890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+biOyeo4lNIZifwk4chwASHhVC8FUq0bVDbejKnY24=;
	b=K4fKuNAVhFN1/v+yHmkQfqUZ+2hSn6DPqzrIjXofLrZ+0p6bklkvsqhQpfHNqppnWKuEsq
	dQlB3hqVr6yPKp2/3LvigXEFNfStrYdbCmJhTFQJfTso8j/IU5SfTOoqfi/KhivD1D1/La
	KWzO1NHGPKRmSciRpvuAjB4ebt71Rwg=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1775392890;
	b=kRieCHdsemqvwg2OZ9hF/3BRJnZi0QUxLQIKLZC3XSxRlFrqBRae1aytYTfJA1Q5O7XUdc
	+Z5WJbNKXfP46s/jHcS4raGmNT7nJ3Jx7aLv19SbeeVWaCsO5JXJhcTwXX2xusxUmQ/LLu
	JivB0i6ZxxcO7LXFwaS1vLX5qX2vHIc=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v4 18/20] test: functional: add custom Agent1 implementation for testing
Date: Sun,  5 Apr 2026 15:39:59 +0300
Message-ID: <8d1bb1376580879ceef1ab85d9def8ef3aad5f8b.1775392680.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775392680.git.pav@iki.fi>
References: <cover.1775392680.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable more precise testing of the Agent1 interface, and allow doing
operations like pairing without bluetoothctl.
---
 doc/test-functional.rst       | 137 +++++++++++++
 test/functional/test_agent.py |  46 +++++
 test/pytest_bluez/__init__.py |   1 +
 test/pytest_bluez/agent.py    | 371 ++++++++++++++++++++++++++++++++++
 4 files changed, 555 insertions(+)
 create mode 100644 test/functional/test_agent.py
 create mode 100644 test/pytest_bluez/agent.py

diff --git a/doc/test-functional.rst b/doc/test-functional.rst
index a03d2e461..48352b96f 100644
--- a/doc/test-functional.rst
+++ b/doc/test-functional.rst
@@ -729,6 +729,143 @@ Base class for host plugins. See also example above.
            """VM-side teardown"""
            pass
 
+Agent
+-----
+
+DBus org.bluez.Agent1 test implementation.
+
+.. code-block::
+
+    class Agent(env.HostPlugin):
+        """
+        Host plugin providing org.bluez.Agent1 test implementation.
+
+        Asynchronous events are handled via expect().
+
+        Example:
+
+            host.agent.device_method(host1.bdaddr, "Pair")
+            event = host.agent.expect("org.bluez.Agent1.RequestConfirmation")
+            assert event.passkey == 1234
+            host.agent.reply()
+        """
+
+        depends = [Bluetoothd()]
+        name = "agent"
+
+        def __init__(self, capability="KeyboardDisplay", path="/agent"):
+
+        def has_device(self, address):
+            """
+            Return True if device with given address exists
+            """
+
+        def device_method(self, address, method, *a, **kw):
+            """
+            Call given org.bluez.Device1 DBus method
+
+            Args:
+                address (str): bdaddr of target device
+                method (str): name of DBus method, without interface prefix
+                *a, **kw: argument passed to the DBus method call
+
+            Events:
+                AgentEvent(kind="org.bluez.Device1.{method}:reply")
+            """
+
+        def adapter_method(self, method, *a, **kw):
+            """
+            Call given org.bluez.Adapter1 DBus method
+
+            Args:
+                method (str): name of DBus method, without interface prefix
+                *a, **kw: argument passed to the DBus method call
+
+            Events:
+                AgentEvent(kind="org.bluez.Adapter1.{method}")
+            """
+
+        def adapter_set(self, key, value):
+            """
+            Set given org.bluez.Adapter1 property
+            """
+
+        def adapter_get(self, key):
+            """
+            Get given org.bluez.Adapter1 property
+            """
+
+        def get_event(self, block=True):
+            """
+            Get most recent pending AgentEvent, blocking optional
+            """
+
+        def expect(self, kinds):
+            """
+            Get most recent pending AgentEvent and assert its kind
+
+            Returns:
+                event (AgentEvent)
+            """
+
+        def reply(self, *value):
+            """
+            Provide DBus reply to the most recent pending AgentEvent
+
+            Arguments:
+                *value: DBus reply return values
+            """
+
+        def reply_error(self, err=None):
+            """
+            Provide DBus error reply to the most recent pending AgentEvent
+
+            Arguments:
+                err (dbus.DBusException): DBus error. Default: org.bluez.Error.Rejected
+            """
+
+.. code-block::
+
+    class Event:
+        """
+        Asynchronous event
+
+        Properties:
+            kind (str): event kind
+            info (dict): event properties (also available as attributes)
+        """
+
+.. code-block::
+
+   class EventPluginMixin:
+       """
+       Simple expect() / reply() pattern for handing async events in
+       host plugins.
+       """
+
+.. code-block::
+
+   def dbus_service_event_method(
+       interface, name, args=(), in_signature="", out_signature="", sync=True
+   ):
+       """
+       dbus.service.method that pushes Event instances to self.events
+
+       Example:
+
+           class AgentObject(dbus.service.Object):
+               @utils.mainloop_assert
+               def __init__(self, bus, path, events):
+                   self.events = events
+                   super().__init__(bus, path)
+
+               AuthorizeService = dbus_service_event_method(
+                   "org.bluez.Agent1",
+                   "AuthorizeService", ("device", "uuid"), "os", sync=False
+               )
+
+       """
+
 Bdaddr
 ------
 
diff --git a/test/functional/test_agent.py b/test/functional/test_agent.py
new file mode 100644
index 000000000..c548469d6
--- /dev/null
+++ b/test/functional/test_agent.py
@@ -0,0 +1,46 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for bluetoothctl using VM instances
+"""
+import sys
+import re
+import pytest
+import subprocess
+import tempfile
+
+import time
+import logging
+
+
+from pytest_bluez import host_config, Agent, wait_until
+
+pytestmark = [pytest.mark.vm]
+
+
+@host_config([Agent()], [Agent()])
+@pytest.mark.parametrize("success", [True, False], ids=["accept", "reject"])
+def test_agent_pair_bredr(hosts, success):
+    host0, host1 = hosts
+
+    host0.agent.adapter_method("StartDiscovery")
+    host0.agent.expect("org.bluez.Adapter1.StartDiscovery:reply")
+
+    host1.agent.adapter_set("Pairable", True)
+    host1.agent.adapter_set("Discoverable", True)
+
+    wait_until(host0.agent.has_device, host1.bdaddr)
+
+    host0.agent.device_method(host1.bdaddr, "Pair")
+
+    confirm_0 = host0.agent.expect("org.bluez.Agent1.RequestConfirmation")
+    confirm_1 = host1.agent.expect("org.bluez.Agent1.RequestConfirmation")
+    assert confirm_0.passkey == confirm_1.passkey
+    host0.agent.reply()
+
+    if success:
+        host1.agent.reply()
+        host0.agent.expect("org.bluez.Device1.Pair:reply")
+    else:
+        host1.agent.reply_error()
+        host0.agent.expect("org.bluez.Device1.Pair:error")
diff --git a/test/pytest_bluez/__init__.py b/test/pytest_bluez/__init__.py
index 9e967d472..cb0629d45 100644
--- a/test/pytest_bluez/__init__.py
+++ b/test/pytest_bluez/__init__.py
@@ -7,5 +7,6 @@ from .env import *
 from .utils import *
 from .host_plugins import *
 from .btmon import *
+from .agent import *
 
 from .plugin import *
diff --git a/test/pytest_bluez/agent.py b/test/pytest_bluez/agent.py
new file mode 100644
index 000000000..5a65d6bae
--- /dev/null
+++ b/test/pytest_bluez/agent.py
@@ -0,0 +1,371 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: LGPL-2.1-or-later
+"""
+VM host plugins
+"""
+import os
+import sys
+import subprocess
+import collections
+import logging
+import tempfile
+import time
+import shutil
+import queue
+from pathlib import Path
+
+import dbus
+import dbus.service
+
+from . import env, utils
+from .host_plugins import Bluetoothd
+
+__all__ = ["Agent", "Event", "EventPluginMixin", "dbus_service_event_method"]
+
+BUS_NAME = "org.bluez"
+AGENT_INTERFACE = "org.bluez.Agent1"
+AGENT_MANAGER_INTERFACE = "org.bluez.AgentManager1"
+ADAPTER_INTERFACE = "org.bluez.Adapter1"
+DEVICE_INTERFACE = "org.bluez.Device1"
+PROPS_INTERFACE = "org.freedesktop.DBus.Properties"
+
+log = logging.getLogger("agent")
+
+
+class Rejected(dbus.DBusException):
+    _dbus_error_name = "org.bluez.Error.Rejected"
+
+
+class Event:
+    """
+    Asynchronous event.
+
+    Properties:
+        kind (str): event kind
+        info (dict): event properties (also available as attributes)
+    """
+
+    def __init__(
+        self, kind, reply_cb=None, error_cb=None, reply_type=None, info=None, **kw
+    ):
+        if info is None:
+            info = {}
+        info.update(kw)
+        self.reply_cb = reply_cb
+        self.error_cb = error_cb
+        self.kind = kind
+        self.reply_type = reply_type
+        self.info = info
+
+    def __getattr__(self, name):
+        try:
+            return self.__dict__["info"][name]
+        except KeyError:
+            raise AttributeError(name)
+
+    def __getstate__(self):
+        return dict(self.__dict__, reply_cb=None, error_cb=None)
+
+
+class EventPluginMixin:
+    """
+    Simple expect() / reply() pattern for handing async events in
+    host plugins.
+
+    """
+
+    def setup(self, impl):
+        self.events = queue.SimpleQueue()
+        self.cur_event = None
+
+    def get_event(self, block=True):
+        """
+        Get most recent pending Event, blocking optional
+        """
+        if self.cur_event is not None:
+            return self.cur_event
+
+        try:
+            self.cur_event = self.events.get(block=block)
+            return self.cur_event
+        except queue.Empty:
+            return None
+
+    def expect(self, kinds):
+        """
+        Get most recent pending Event and assert its kind
+
+        Returns:
+            event (Event)
+        """
+        if isinstance(kinds, str):
+            kinds = (kinds,)
+        kinds = tuple(kinds)
+
+        event = self.get_event()
+        if event.kind not in kinds:
+            raise AssertionError(f"Got {event.kind=}, expected {kinds=}")
+        if event.reply_cb is None:
+            self.cur_event = None
+
+        log.info(f"match {event.kind=}")
+        return event
+
+    @utils.mainloop_wrap
+    def reply(self, *value):
+        """
+        Provide DBus reply to the most recent pending Event
+
+        Arguments:
+            *value: DBus reply return values
+        """
+        if len(value) == 1 and isinstance(value[0], Exception):
+            self.cur_event.error_cb(value[0])
+        else:
+            if self.cur_event.reply_type is not None:
+                value = self.cur_event.reply_type(*value)
+            self.cur_event.reply_cb(*value)
+        self.cur_event = None
+
+    def reply_error(self, err=None):
+        """
+        Provide DBus error reply to the most recent pending Event
+
+        Arguments:
+            err (dbus.DBusException): DBus error. Default: org.bluez.Error.Rejected
+        """
+        if err is None:
+            err = Rejected()
+        self.reply(err)
+
+    @utils.mainloop_assert
+    def _object_method(self, obj, method, *a, **kw):
+        iface = obj.dbus_interface
+
+        reply_handler = kw.pop("reply_handler", None)
+        error_handler = kw.pop("error_handler", None)
+
+        def reply(*values):
+            log.info(f"{iface}.{method} reply: {values!r}")
+            if reply_handler is not None:
+                reply_handler(*values)
+            self.events.put(Event(f"{iface}.{method}:reply", values=values))
+
+        def error(err):
+            log.info(f"{iface}.{method} error: {err!r}")
+            if error_handler is not None:
+                error_handler(err)
+            self.events.put(Event(f"{iface}.{method}:error", error=err))
+
+        getattr(obj, method)(*a, **kw, reply_handler=reply, error_handler=error)
+
+
+class Agent(env.HostPlugin, EventPluginMixin):
+    """
+    Host plugin providing org.bluez.Agent1 test implementation.
+
+    Asynchronous events are handled via expect().
+
+    Example:
+
+        host.agent.device_method(host1.bdaddr, "Pair")
+        event = host.agent.expect("org.bluez.Agent1.RequestConfirmation")
+        assert event.passkey == 1234
+        host.agent.reply()
+    """
+
+    depends = [Bluetoothd()]
+    name = "agent"
+
+    def __init__(self, capability="KeyboardDisplay", path="/agent"):
+        self.capability = capability
+        self.path = path
+
+    @utils.mainloop_wrap
+    def setup(self, impl):
+        EventPluginMixin.setup(self, impl)
+
+        self.bus = dbus.SystemBus(private=True)
+        self.bus.set_exit_on_disconnect(False)
+
+        self.agent = AgentObject(self.bus, self.path, self.events)
+
+        bluez = self.bus.get_object(BUS_NAME, "/org/bluez")
+        self.manager = dbus.Interface(bluez, AGENT_MANAGER_INTERFACE)
+        self.manager.RegisterAgent(self.path, self.capability)
+
+        log.info("Agent registered")
+
+        self.manager.RequestDefaultAgent(self.path)
+
+    @utils.mainloop_wrap
+    def teardown(self):
+        self.manager.UnregisterAgent(self.path)
+        log.info("Agent unregistered")
+
+    @utils.mainloop_wrap
+    def has_device(self, address):
+        """
+        Return True if device with given address exists
+        """
+        try:
+            self._find_device(address)
+            return True
+        except ValueError:
+            return False
+
+    @utils.mainloop_wrap
+    def device_method(self, address, method, *a, **kw):
+        """
+        Call given org.bluez.Device1 DBus method
+
+        Args:
+            address (str): bdaddr of target device
+            method (str): name of DBus method, without interface prefix
+            *a, **kw: argument passed to the DBus method call
+
+        Events:
+            Event(kind="org.bluez.Device1.{method}:reply")
+        """
+        device = self._find_device(address)
+        self._object_method(device, method, *a, **kw)
+
+    @utils.mainloop_wrap
+    def adapter_method(self, method, *a, **kw):
+        """
+        Call given org.bluez.Adapter1 DBus method
+
+        Args:
+            method (str): name of DBus method, without interface prefix
+            *a, **kw: argument passed to the DBus method call
+
+        Events:
+            Event(kind="org.bluez.Adapter1.{method}")
+        """
+        adapter = dbus.Interface(
+            self.bus.get_object(BUS_NAME, "/org/bluez/hci0"), ADAPTER_INTERFACE
+        )
+        self._object_method(adapter, method, *a, **kw)
+
+    @utils.mainloop_wrap
+    def adapter_set(self, key, value):
+        """
+        Set given org.bluez.Adapter1 property
+        """
+        adapter = dbus.Interface(
+            self.bus.get_object(BUS_NAME, "/org/bluez/hci0"), PROPS_INTERFACE
+        )
+        adapter.Set(ADAPTER_INTERFACE, key, value)
+
+    @utils.mainloop_wrap
+    def adapter_get(self, key):
+        """
+        Get given org.bluez.Adapter1 property
+        """
+        adapter = dbus.Interface(
+            self.bus.get_object(BUS_NAME, "/org/bluez/hci0"), PROPS_INTERFACE
+        )
+        return adapter.Get(ADAPTER_INTERFACE, key)
+
+    @utils.mainloop_assert
+    def _find_device(self, address):
+        manager = dbus.Interface(
+            self.bus.get_object(BUS_NAME, "/"), "org.freedesktop.DBus.ObjectManager"
+        )
+        objects = manager.GetManagedObjects()
+
+        for path, ifaces in objects.items():
+            device = ifaces.get(DEVICE_INTERFACE)
+            if device is None:
+                continue
+            if device["Address"].lower() == address.lower():
+                return dbus.Interface(
+                    self.bus.get_object(BUS_NAME, path), DEVICE_INTERFACE
+                )
+        else:
+            raise ValueError("Device {address=} not found")
+
+
+def dbus_service_event_method(
+    interface, name, args=(), in_signature="", out_signature="", sync=True
+):
+    """
+    dbus.service.method that pushes Event instances to self.events
+
+    Example:
+
+        class AgentObject(dbus.service.Object):
+            @utils.mainloop_assert
+            def __init__(self, bus, path, events):
+                self.events = events
+                super().__init__(bus, path)
+
+            AuthorizeService = dbus_service_event_method(
+                "org.bluez.Agent1",
+                "AuthorizeService", ("device", "uuid"), "os", sync=False
+            )
+
+    """
+
+    reply_type = {"": "None", "s": "str", "u": "dbus.UInt32"}[out_signature]
+
+    if not sync:
+        cb_args = ("_reply", "_error")
+        kw = dict(
+            in_signature=in_signature,
+            out_signature=out_signature,
+            async_callbacks=("_reply", "_error"),
+        )
+    else:
+        cb_args = ()
+        kw = dict(in_signature=in_signature, out_signature=out_signature)
+        assert not out_signature
+
+    args_str = ", ".join(args)
+    if args_str:
+        args_str = ", " + args_str
+
+    cb_args_str = ", ".join(cb_args)
+    if cb_args:
+        cb_args_str = ", " + cb_args_str
+
+    args_dict = ", ".join(f"{k}={k}" for k in args)
+
+    method_str = f"""def {name}(self{args_str}{cb_args_str}):
+        info = dict({args_dict})
+        log.info(f"{interface}.{name} {{info}}")
+        self.events.put(Event("{interface}.{name}"{cb_args_str}, reply_type={reply_type}, info=info))
+    """
+
+    ns = dict(dbus=dbus, Event=Event, log=log)
+    exec(method_str, ns)
+    return dbus.service.method(interface, **kw)(utils.mainloop_assert(ns[name]))
+
+
+def agent_method(*a, **kw):
+    return dbus_service_event_method(AGENT_INTERFACE, *a, **kw)
+
+
+class AgentObject(dbus.service.Object):
+    @utils.mainloop_assert
+    def __init__(self, bus, path, events):
+        self.events = events
+        super().__init__(bus, path)
+
+    Release = agent_method("Release")
+    AuthorizeService = agent_method(
+        "AuthorizeService", ("device", "uuid"), "os", sync=False
+    )
+    RequestPinCode = agent_method("RequestPinCode", ("device",), "o", "s", sync=False)
+    RequestPasskey = agent_method("RequestPasskey", ("device",), "o", "u", sync=False)
+    RequestConfirmation = agent_method(
+        "RequestConfirmation", ("device", "passkey"), "ou", sync=False
+    )
+    RequestAuthorization = agent_method(
+        "RequestAuthorization", ("device",), "o", sync=False
+    )
+    DisplayPasskey = agent_method(
+        "DisplayPasskey", ("device", "passkey", "entered"), "ouq"
+    )
+    DisplayPinCode = agent_method("DisplayPinCode", ("device", "pincode"), "os")
+    Cancel = agent_method("Cancel")
-- 
2.53.0

