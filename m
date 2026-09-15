Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103FB78F2F
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 00:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430869; cv=pass; b=tVrQXJI2RXRp98QNUCDSkC9y3Ye16cjbgNUJJTzp4OwctGC+BYGhjAY/RFL2i5+Lo9UfXJvdBK/9LmECwyTxNSZpTNn9Ncg3Q2dCAiTS9QUdiSn0bl5tZpfUYLgChdCTr6/LI8jSwA8KWYcyC3FC9JPSJnELHCdLyuF3bmzLNPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430869; c=relaxed/simple;
	bh=UWlJxJdthhb0e/dgdcmnTMd0ZzaS6aCo+kZR77z3BLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pwv0IFAb7/dd1TQjycFqT5uoXCgpqin9a/6ePaitiFLRs73e4cH0cdFUQUaH2Cxdxtmzg2jhlCq7jMt0w/kaeoe+Fo0J2BRTbILkjF46f4iE0rw7W8Q9BGEmX7k34OIUDhUmRdOd3ooCIhAfD96lAeg+T2zsuOBlwhfGcbWJBf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=SAcewVFr; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="SAcewVFr"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hkMlw2PxczySb;
	Tue, 15 Sep 2026 03:07:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789430860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjOjQeBG2A6DQ+lVmO14W3zMNj9io678vzFMcHzwFso=;
	b=SAcewVFrWgFblnspqVcu3KOKAzplw7qK60oiYsx+t719tWGtHvdFxBJ+53VlIvdyh6zfb4
	mUOxW2c7jcCCqcTcPqkBaw6kjfFuNypzdqRsruwLh+6NZRY30IM2Qol2Kf4thrZCCweQm8
	FEliS/C3X3EG1ndhH/BrOfDAJmUXHY8=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789430860;
	b=dHKcOqyiLYMHIq2TY4H5DnJrrYYf1XRKjq5K/K2pqsly2pyawlgnUUNvaqJxx0J1XYuDwa
	emGw0UR7hSuggf3HMmzCn/I532daG55zWXE/Y2JRR/+S5NRHUjbAydTo75HxBahWJs9Lbt
	5cjfgFJTNKbJyfESARlOIp4ZAb9x//Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789430860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IjOjQeBG2A6DQ+lVmO14W3zMNj9io678vzFMcHzwFso=;
	b=L5lW3DJMG1mkEw83YqNcE1cfqyDSNhmtOqIpanQyBF96jy0FsTD7ZpIrA9lsetj8XV2fEU
	ehMqgo/yNesN2pAhyR2XE0vVbX2raQiwQUj3c3SrlHBOzbrWspU2PQ4IrrC+tFQwCc5Ldw
	J9wWpatiWzqWfKZeEI2LskdRGqvZttI=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 3/3] test: functional: run mpris-proxy tests over LE via MCP
Date: Tue, 15 Sep 2026 03:07:20 +0300
Message-ID: <5800834b16b20adbd6d72a19248dca7e7e142237.1789430529.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789430529.git.pav@iki.fi>
References: <cover.1789430529.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also run the mpris-proxy tests over LE, where the player is exposed via
MCS instead of AVRCP.

Add an LE advertisement helper for connecting the service.

test/functional/test_mpris_proxy.py::test_mpris_proxy_playback_control[le-vm2]
test/functional/test_mpris_proxy.py::test_mpris_proxy_track_control[le-vm2]

Assisted-by: opencode:qwen3.8-flash-next
---
 doc/functional-mpris-proxy.rst      |  91 +++++++++++-----
 test/functional/le_utils.py         | 162 +++++++++++++++++++++++++++-
 test/functional/test_mpris_proxy.py |  93 +++++++++++-----
 3 files changed, 290 insertions(+), 56 deletions(-)

diff --git a/doc/functional-mpris-proxy.rst b/doc/functional-mpris-proxy.rst
index a6936275b..17d2cc3d9 100644
--- a/doc/functional-mpris-proxy.rst
+++ b/doc/functional-mpris-proxy.rst
@@ -16,17 +16,20 @@ exports a remote ``org.bluez.MediaPlayer1`` object to the session bus
 as an MPRIS player.
 
 The upper tester drives two VM hosts, host0 as the client and host1 as
-the server, connected over BR/EDR, where the bridge is an AVRCP Target
-and Controller. The server presents a dummy MPRIS player. The client
-runs a second `mpris-proxy` with ``--export``, which exports that
-remote player on the client session bus, and the upper tester controls
-it there as an ordinary MPRIS client.
+the server. The server presents a dummy MPRIS player. The client runs
+a second `mpris-proxy` with ``--export``, which exports that remote
+player on the client session bus, and the upper tester controls it
+there as an ordinary MPRIS client. Each case runs once over BR/EDR,
+where the bridge is an AVRCP Target and Controller, and once over LE,
+where it is a Generic Media Control Service (GMCS) server and client.
 
 SETUP
 =====
 
 .. code-block::
 
+	BR/EDR:
+
 	+--------------------------------+            +--------------------------------+
 	| host0 / client                 |   BR/EDR   | host1 / server                 |
 	| bluetoothd                     |   AVCTP    | bluetoothd                     |
@@ -36,6 +39,18 @@ SETUP
 	|  <name> (session bus)          |            |  blueztest (session bus)       |
 	+--------------------------------+            +--------------------------------+
 
+	LE:
+
+	+--------------------------------+            +--------------------------------+
+	| host0 / client                 |     LE     | host1 / server                 |
+	| bluetoothd                     |    GMCS    | bluetoothd                     |
+	| mpris-proxy --export           |   (MCP)    | mpris-proxy                    |
+	| MPRIS client (upper tester)    |  ------->  | dummy MPRIS player             |
+	| org.mpris.MediaPlayer2.        |            | LE advertisement (GMCS)        |
+	|  <name> (session bus)          |            | org.mpris.MediaPlayer2.        |
+	|                                |            |  blueztest (session bus)       |
+	+--------------------------------+            +--------------------------------+
+
 The server host owns the session bus name
 ``org.mpris.MediaPlayer2.blueztest`` and exports
 ``/org/mpris/MediaPlayer2`` with the ``org.mpris.MediaPlayer2`` and
@@ -47,33 +62,45 @@ tester tells it to, and then emits
 
 The `mpris-proxy` on the server registers that player with its
 **bluetoothd** through ``org.bluez.Media1.RegisterPlayer``, so the
-server host is the AVRCP Target. The `mpris-proxy --export` on the
-client exports the ``org.bluez.MediaPlayer1`` object its bluetoothd
-creates for the remote player as ``org.mpris.MediaPlayer2.<name>``,
-where ``<name>`` is derived from the remote device alias, at
-``/org/mpris/MediaPlayer2`` on the client session bus. Both proxies use
-adapter index 0.
+server host is the AVRCP Target over BR/EDR and the GMCS server over
+LE. The `mpris-proxy --export` on the client exports the
+``org.bluez.MediaPlayer1`` object its bluetoothd creates for the
+remote player as ``org.mpris.MediaPlayer2.<name>``, where ``<name>``
+is derived from the remote device alias, at
+``/org/mpris/MediaPlayer2`` on the client session bus. Both proxies
+use adapter index 0.
+
+In the LE configuration both hosts run bluetoothd with
+``ControllerMode = le`` and ``Experimental = true``, and both hosts
+register an ``org.bluez.Agent1`` with ``NoInputNoOutput`` capability.
+The server also registers a connectable ``org.bluez.LEAdvertisement1``
+advertising GMCS (``00001849-0000-1000-8000-00805f9b34fb``) through
+``org.bluez.LEAdvertisingManager1.RegisterAdvertisement``, to connect
+the service.
 
 Before each case the upper tester does the following, and checks each
 step:
 
-	1. Pair the hosts over BR/EDR, unless they are already paired, as
-	   the host setup is reused between cases: the client discovers
-	   the server and calls ``org.bluez.Device1.Pair``, and both
-	   agents confirm the passkey.
+	1. Pair the hosts over the bearer in use, unless they are already
+	   paired, as the host setup is reused between cases. Over BR/EDR
+	   the client discovers the server and calls ``Device1.Pair``, and
+	   both agents confirm the passkey. Over LE pairing is Just
+	   Works: the server agent authorizes it.
 	2. On both hosts, set ``Trusted`` to true with
 	   ``org.freedesktop.DBus.Properties.Set`` on the
 	   ``org.bluez.Device1`` object of the peer host.
-	3. Connect on the client with ``org.bluez.Device1.ConnectProfile``
-	   and the AVRCP Controller UUID
-	   (``0000110c-0000-1000-8000-00805f9b34fb``). The call must
-	   reply, or fail with ``AlreadyConnected`` since a previous case
-	   may still be connected.
+	3. Connect on the client: ``org.bluez.Device1.ConnectProfile``
+	   with the AVRCP Controller UUID
+	   (``0000110c-0000-1000-8000-00805f9b34fb``) over BR/EDR, or
+	   ``org.bluez.Device1.Connect`` over LE. The call must reply, or
+	   fail with ``AlreadyConnected`` since a previous case may still
+	   be connected.
 	4. Wait until the client session bus has exactly one name with the
 	   prefix ``org.mpris.MediaPlayer2.``, listed with
 	   ``org.freedesktop.DBus.ListNames``. That is the exported player.
 	5. Wait until its ``PlaybackStatus``, read with
-	   ``org.freedesktop.DBus.Properties.Get``, is ``Stopped``.
+	   ``org.freedesktop.DBus.Properties.Get``, is the idle status:
+	   ``Stopped`` over BR/EDR, ``Paused`` over LE.
 
 The same connection and exported player are used by both cases.
 
@@ -84,9 +111,9 @@ After each case, also on failure, the upper tester resets the dummy
 player on the server to stopped and track 0, which emits
 ``PropertiesChanged`` for ``PlaybackStatus`` and ``Metadata``, and
 drops the method calls left over from the previous case. It then waits
-until the exported player on the client reads ``Stopped`` again. The
-hosts, both bluetoothd instances, both proxies and the connection are
-left running.
+until the exported player on the client again reads the idle status.
+The hosts, both bluetoothd instances, both proxies and the connection
+are left running.
 
 TEST CASES
 ==========
@@ -114,7 +141,12 @@ test_mpris_proxy_playback_control
 	2. The dummy player on the server receives ``Play``, ``Pause`` and
 	   ``Stop``.
 	3. The exported player on the client reports ``Playing``,
-	   ``Paused`` and ``Stopped``.
+	   ``Paused`` and ``Stopped`` over BR/EDR. Over LE, ``Stop`` is
+	   reported as ``Paused``.
+
+:Notes: GMCS has no stopped state, so a stopped player is published by
+	the server in the paused state, and reads as ``Paused`` on the
+	client.
 
 test_mpris_proxy_track_control
 ------------------------------
@@ -138,8 +170,11 @@ test_mpris_proxy_track_control
 	1. The dummy player on the server receives ``Next`` and
 	   ``Previous``.
 	2. The metadata of the new track reaches the exported player on
-	   the client: both its ``xesam:title`` and its
-	   ``xesam:trackNumber`` match the new track.
+	   the client: the title matches over both bearers, and
+	   ``xesam:trackNumber`` matches over BR/EDR.
 
 :Notes: The dummy player changes its state only once the upper tester
-	has observed the corresponding call.
+	has observed the corresponding call. Over LE bluetoothd knows
+	only the GMCS object name of the remote player, so the client
+	sees the title but no track number, which is why the track number
+	is checked over BR/EDR only.
diff --git a/test/functional/le_utils.py b/test/functional/le_utils.py
index 03bbbfb24..066644d6f 100644
--- a/test/functional/le_utils.py
+++ b/test/functional/le_utils.py
@@ -1,12 +1,172 @@
 # -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
 # SPDX-License-Identifier: GPL-2.0-or-later
-"""Generic LE helpers for functional tests."""
+"""
+Generic LE helpers for functional tests.
+
+LeAdvertiser registers a connectable org.bluez.LEAdvertisement1: in
+ControllerMode = le bluetoothd does not advertise on its own, so a host has
+to advertise itself to be discovered and connected over LE.
+"""
+
+import logging
+
+import dbus
+import dbus.exceptions
+import dbus.service
 
 from pytest_bluezenv import (
     Bluetoothd,
+    HostPlugin,
+    get_dbus,
+    mainloop_assert,
+    mainloop_wrap,
     wait_until,
 )
 
+BLUEZ_BUS_NAME = "org.bluez"
+PROPS_INTERFACE = "org.freedesktop.DBus.Properties"
+LE_ADV_INTERFACE = "org.bluez.LEAdvertisement1"
+LE_ADV_MANAGER_INTERFACE = "org.bluez.LEAdvertisingManager1"
+
+
+class LeAdvertisement(dbus.service.Object):
+    """
+    Minimal generic org.bluez.LEAdvertisement1 implementation exporting the
+    given service UUIDs over the given advertisement type.
+    """
+
+    class UnknownProperty(dbus.exceptions.DBusException):
+        _dbus_error_name = "org.freedesktop.DBus.Error.UnknownProperty"
+
+    @mainloop_assert
+    def __init__(
+        self,
+        bus,
+        path,
+        adv_type="peripheral",
+        service_uuids=(),
+        discoverable=True,
+    ):
+        self.adv_path = path
+        self._props = dbus.Dictionary(
+            {
+                "Type": dbus.String(adv_type),
+                "ServiceUUIDs": dbus.Array(
+                    [dbus.String(uuid) for uuid in service_uuids], signature="s"
+                ),
+            },
+            signature="sv",
+        )
+        if discoverable:
+            self._props["Discoverable"] = dbus.Boolean(True)
+        super().__init__(bus, path)
+
+    @dbus.service.method(PROPS_INTERFACE, in_signature="s", out_signature="a{sv}")
+    def GetAll(self, interface):
+        if interface == LE_ADV_INTERFACE:
+            return self._props
+        return dbus.Dictionary({}, signature="sv")
+
+    @dbus.service.method(PROPS_INTERFACE, in_signature="ss", out_signature="v")
+    def Get(self, interface, prop):
+        props = self.GetAll(interface)
+        if prop not in props:
+            raise self.UnknownProperty(f"No such property {prop} on {interface}")
+        return props[prop]
+
+    @dbus.service.signal(PROPS_INTERFACE, signature="sa{sv}as")
+    def PropertiesChanged(self, interface, changed, invalidated):
+        pass
+
+    @dbus.service.method(LE_ADV_INTERFACE, in_signature="", out_signature="")
+    def Release(self):
+        pass
+
+
+class LeAdvertiser(HostPlugin):
+    """
+    Host plugin registering a connectable LE advertisement, so that a remote
+    host can discover and connect to it over LE. The advertised service
+    UUIDs are given as the service_uuids argument.
+    """
+
+    name = "le_advertiser"
+    depends = [Bluetoothd()]
+
+    PATH_BASE = "/org/bluez/test/advertisement"
+
+    def __init__(
+        self,
+        service_uuids=(),
+        adv_type="peripheral",
+        index=0,
+        adapter_path="/org/bluez/hci0",
+        discoverable=True,
+    ):
+        self.service_uuids = tuple(service_uuids)
+        self.adv_type = adv_type
+        self.index = index
+        self.adapter_path = adapter_path
+        self.discoverable = discoverable
+
+    def setup(self, impl):
+        # While registering, bluetoothd reads the advertisement properties
+        # back from us, so wait for the reply outside the mainloop thread to
+        # let the mainloop serve it
+        self.log = logging.getLogger(self.name)
+
+        self.registered = False
+        self.register_error = None
+
+        self._register()
+
+        wait_until(lambda: self.registered)
+        if self.register_error is not None:
+            raise self.register_error
+
+    @mainloop_wrap
+    def _register(self):
+        self.bus = get_dbus(private=True)
+        self.adv = LeAdvertisement(
+            self.bus,
+            f"{self.PATH_BASE}{self.index}",
+            self.adv_type,
+            self.service_uuids,
+            self.discoverable,
+        )
+        self.manager = dbus.Interface(
+            self.bus.get_object(BLUEZ_BUS_NAME, self.adapter_path),
+            LE_ADV_MANAGER_INTERFACE,
+        )
+
+        self.log.info(f"Register LE advertisement {self.adv.adv_path}")
+
+        self.manager.RegisterAdvertisement(
+            self.adv.adv_path,
+            dbus.Dictionary({}, signature="sv"),
+            reply_handler=self._registered,
+            error_handler=self._register_error,
+        )
+
+    def _registered(self):
+        self.log.info(f"LE advertisement {self.adv.adv_path} registered")
+        self.registered = True
+
+    def _register_error(self, err):
+        self.log.error(f"LE advertisement {self.adv.adv_path} failed: {err}")
+        self.register_error = err
+        self.registered = True
+
+    @mainloop_wrap
+    def teardown(self):
+        self.log.info(f"Unregister LE advertisement {self.adv.adv_path}")
+        self.manager.UnregisterAdvertisement(
+            self.adv.adv_path,
+            reply_handler=lambda: None,
+            error_handler=lambda err: self.log.debug(f"Unregister: {err}"),
+        )
+        self.adv.remove_from_connection()
+
 
 def host_setup_is_le(host_setup):
     """True if the hosts run bluetoothd in LE-only mode."""
diff --git a/test/functional/test_mpris_proxy.py b/test/functional/test_mpris_proxy.py
index 15e775621..06bcae748 100644
--- a/test/functional/test_mpris_proxy.py
+++ b/test/functional/test_mpris_proxy.py
@@ -22,13 +22,15 @@ from pytest_bluezenv import (
     dbus_service_event_method,
     find_exe,
     get_dbus,
-    host_config,
     mainloop_assert,
     mainloop_wrap,
+    parametrized_host_config,
     quoted,
     wait_until,
 )
 
+from .le_utils import LeAdvertiser
+
 BLUEZ_BUS_NAME = "org.bluez"
 
 MPRIS_BUS_NAME = "org.mpris.MediaPlayer2.blueztest"
@@ -43,6 +45,10 @@ PROPS_INTERFACE = "org.freedesktop.DBus.Properties"
 
 AVRCP_CONTROLLER_UUID = "0000110c-0000-1000-8000-00805f9b34fb"
 
+GMCS_UUID = "00001849-0000-1000-8000-00805f9b34fb"
+
+LE_BLUETOOTHD_CONF = "[General]\nControllerMode = le\nExperimental = true\n"
+
 
 def mpris_player_method(*a, **kw):
     return dbus_service_event_method(MPRIS_PLAYER_INTERFACE, *a, **kw)
@@ -257,9 +263,9 @@ class MprisProxy(HostPlugin):
 
 class MprisClient(HostPlugin):
     """
-    Host plugin used by the test on the client host to discover and
-    control the player of a remote device through the MPRIS client API,
-    as exported to the session bus by `mpris-proxy --export`.
+    Host plugin used by the test on the controlling host to discover and
+    control the remote player through the MPRIS client API, as exported
+    to the session bus by `mpris-proxy --export`.
     """
 
     name = "mpris_client"
@@ -324,8 +330,13 @@ def vm_set_trusted(bdaddr):
     props.Set(BLUEZ_DEVICE_INTERFACE, "Trusted", dbus.Boolean(True))
 
 
+def idle_status(le):
+    """Playback status a stopped player reads as, MCP has no stopped state."""
+    return "Paused" if le else "Stopped"
+
+
 @pytest.fixture
-def mpris_player(paired_hosts):
+def mpris_player(paired_hosts, is_le):
     """
     Two paired and trusted hosts, the client connected to the dummy MPRIS
     player of the server, exported on the client session bus by
@@ -341,33 +352,59 @@ def mpris_player(paired_hosts):
     client.call(vm_set_trusted, server.bdaddr)
     server.call(vm_set_trusted, client.bdaddr)
 
-    client.agent.device_method(server.bdaddr, "ConnectProfile", AVRCP_CONTROLLER_UUID)
+    if is_le:
+        method, args = "Connect", ()
+    else:
+        method, args = "ConnectProfile", (AVRCP_CONTROLLER_UUID,)
+
+    client.agent.device_method(server.bdaddr, method, *args)
     event = client.agent.expect(
-        (
-            "org.bluez.Device1.ConnectProfile:reply",
-            "org.bluez.Device1.ConnectProfile:error",
-        )
+        (f"org.bluez.Device1.{method}:reply", f"org.bluez.Device1.{method}:error")
     )
     if event.kind.endswith(":error"):
         # OK if the player is already connected (reused host setup)
-        assert "AlreadyConnected" in str(
-            event.error
-        ), f"ConnectProfile failed: {event.error}"
+        assert "AlreadyConnected" in str(event.error), f"{method} failed: {event.error}"
 
     wait_until(lambda: client.mpris_client.exported_player())
     player_name = client.mpris_client.exported_player()
 
-    wait_until(lambda: client.mpris_client.get_status(player_name) == "Stopped")
+    wait_until(
+        lambda: client.mpris_client.get_status(player_name) == idle_status(is_le)
+    )
 
     yield client, server, player_name
 
     server.dummy_player.reset()
-    wait_until(lambda: client.mpris_client.get_status(player_name) == "Stopped")
+    wait_until(
+        lambda: client.mpris_client.get_status(player_name) == idle_status(is_le)
+    )
 
 
-mpris_proxy_host_config = host_config(
-    [MprisProxy(args=("--export",)), MprisClient(), Agent()],
-    [MprisProxy(), DummyMprisPlayer(), Agent()],
+mpris_proxy_host_config = parametrized_host_config(
+    [
+        # BR/EDR
+        (
+            [MprisProxy(args=("--export",)), MprisClient(), Agent()],
+            [MprisProxy(), DummyMprisPlayer(), Agent()],
+        ),
+        # LE
+        (
+            [
+                Bluetoothd(conf=LE_BLUETOOTHD_CONF),
+                MprisProxy(args=("--export",)),
+                MprisClient(),
+                Agent(capability="NoInputNoOutput"),
+            ],
+            [
+                Bluetoothd(conf=LE_BLUETOOTHD_CONF),
+                MprisProxy(),
+                DummyMprisPlayer(),
+                LeAdvertiser(service_uuids=[GMCS_UUID]),
+                Agent(capability="NoInputNoOutput"),
+            ],
+        ),
+    ],
+    ids=["bredr", "le"],
     reuse=True,
 )
 
@@ -385,13 +422,13 @@ def control_player(client, server, player_name, method, update, *args):
 
 
 @mpris_proxy_host_config
-def test_mpris_proxy_playback_control(mpris_player):
+def test_mpris_proxy_playback_control(mpris_player, is_le):
     client, server, player_name = mpris_player
 
-    for method, status in (
-        ("Play", "Playing"),
-        ("Pause", "Paused"),
-        ("Stop", "Stopped"),
+    for method, status, expected in (
+        ("Play", "Playing", "Playing"),
+        ("Pause", "Paused", "Paused"),
+        ("Stop", "Stopped", idle_status(is_le)),
     ):
         control_player(
             client,
@@ -401,11 +438,11 @@ def test_mpris_proxy_playback_control(mpris_player):
             server.dummy_player.set_status,
             status,
         )
-        wait_until(lambda: client.mpris_client.get_status(player_name) == status)
+        wait_until(lambda: client.mpris_client.get_status(player_name) == expected)
 
 
 @mpris_proxy_host_config
-def test_mpris_proxy_track_control(mpris_player):
+def test_mpris_proxy_track_control(mpris_player, is_le):
     client, server, player_name = mpris_player
 
     track_number = server.dummy_player.get_track_number()
@@ -424,5 +461,7 @@ def test_mpris_proxy_track_control(mpris_player):
             lambda: client.mpris_client.get_metadata(player_name).get("xesam:title")
             == f"Test Track {track_number}"
         )
-        metadata = client.mpris_client.get_metadata(player_name)
-        assert int(metadata["xesam:trackNumber"]) == track_number
+        if not is_le:
+            # Over LE, bluetoothd knows only the GMCS object name, no track number
+            metadata = client.mpris_client.get_metadata(player_name)
+            assert int(metadata["xesam:trackNumber"]) == track_number
-- 
2.55.0

