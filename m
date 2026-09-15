Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED678F2F
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 00:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430864; cv=pass; b=AJPw0HOlHyw0+ORq6KY6Z8qe4ZYJWgo+w4pkae9cfs3hTOb5TfFVO+OpBV+/yRbQPDsOsUb5/qYH+jqaehBB/1AiEtjWvGgJOs3zIWw2NY+vtJec6Ul1rkUQlJ0naHFV0hbyimrnnamFpi3Cc9kBCij2b034HKFjxWCwhmyIBXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430864; c=relaxed/simple;
	bh=9xU9NHEdQ82iLugPFZDpT7F7yvYdmTVeJOQx1QB1A5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uFFWqXIr+p5FtWrz0R5Np0xuWqPUCPvm9nXL1SGAvU9Fx7XO3O3dw/lcdc79w+NvdJJBM8c//rVIslqTMrGbXgJZnhMYAG69/RDiwI843T/aJT04I9BMcLGcwSCk0H3/rKmuIpd5nB1Qq5yNF2c5seRnFWsrSfuupnWQx9Xeaww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=XX3WMXbH; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="XX3WMXbH"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hkMlk24Qdzyc9;
	Tue, 15 Sep 2026 03:07:30 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789430850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGVEkrE+LbZDhkrLckva46wQ9+8MGmIn5+A6DatXKhc=;
	b=XX3WMXbHGcXV+ceOElX0JjHrAiGgKzWx6xe0R1nCHtLVZ54/kla89kpebpSkV776mV4N2T
	e50wqN2731ITXIV0RSSKQsFKPspHZPmJIhBbWzKAXgjs9eGngoGzgG1mU69+aRnO4g3dBb
	RQBEeM8m1Bqy3tmvbrOxyfnClezxyIQ=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789430850;
	b=mRgW5NPBmoPRYNSDqKpd3eTIMxh9J2oada+DY2BaZ7JgnsVIaWy3v806/11Immzb0kyYh9
	b05Kk1XNTxPfomhGy36J4TmDJWpl/TpwfjAhW/78AfBrnM1meonavxoxdhnDWqCVwYcMMO
	FXO0Esl2FH0T9pdu2o/+aB3WU6cAcvE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789430850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGVEkrE+LbZDhkrLckva46wQ9+8MGmIn5+A6DatXKhc=;
	b=jkplKXKLO5oRXMXLyYKxtvhoMj+jPeqRyc1nv8qqaSEriUSboDy5O7hPMPZru5EroKNOHR
	PaHkF1rBqGQFoT/F4p1QZWMGE3zE7QpQ555fqkAJwAL6a51P8JMclFZREpPo9tiHWSF4Om
	LZpc7JRpoKz0CjGddSgW1Kxr6djviO4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/3] test: functional: add mpris-proxy BR/EDR test cases
Date: Tue, 15 Sep 2026 03:07:18 +0300
Message-ID: <8b99b164de814997898f380e9418f8b88aec65cc.1789430529.git.pav@iki.fi>
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

Add functional tests for mpris-proxy over BR/EDR: a dummy MPRIS player
on the server is bridged by mpris-proxy to an AVRCP Target, and a
second mpris-proxy on the client, run with --export, exports the
remote player back to the client session bus as an MPRIS player, which
the tests control as MPRIS clients.

test/functional/test_mpris_proxy.py::test_mpris_proxy_playback_control
test/functional/test_mpris_proxy.py::test_mpris_proxy_track_control

Assisted-by: opencode:qwen3.8-flash-next
---
 Makefile.am                         |   1 +
 doc/functional-mpris-proxy.rst      | 145 ++++++++++
 doc/functional-testing.rst          |   1 +
 test/functional/test_mpris_proxy.py | 428 ++++++++++++++++++++++++++++
 4 files changed, 575 insertions(+)
 create mode 100644 doc/functional-mpris-proxy.rst
 create mode 100644 test/functional/test_mpris_proxy.py

diff --git a/Makefile.am b/Makefile.am
index cef28673a..1d46b9b93 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -501,6 +501,7 @@ EXTRA_DIST += doc/assigned-numbers.rst doc/supported-features.txt \
 				doc/functional-a2dp.rst \
 				doc/functional-avrcp.rst \
 				doc/functional-bap.rst \
+				doc/functional-mpris-proxy.rst \
 				doc/functional-obex.rst \
 				doc/settings-storage.txt
 
diff --git a/doc/functional-mpris-proxy.rst b/doc/functional-mpris-proxy.rst
new file mode 100644
index 000000000..a6936275b
--- /dev/null
+++ b/doc/functional-mpris-proxy.rst
@@ -0,0 +1,145 @@
+======================
+functional-mpris-proxy
+======================
+
+DESCRIPTION
+===========
+
+mpris-proxy functional tests in `test/functional/test_mpris_proxy.py`.
+See **functional-testing(7)** for the conventions used here, and
+**test-functional(1)** for how to run the suite.
+
+`mpris-proxy` bridges MPRIS 2.2 players and **bluetoothd**: it
+registers a local session bus player with **bluetoothd** using
+``org.bluez.Media1.RegisterPlayer``, and, run with ``--export``,
+exports a remote ``org.bluez.MediaPlayer1`` object to the session bus
+as an MPRIS player.
+
+The upper tester drives two VM hosts, host0 as the client and host1 as
+the server, connected over BR/EDR, where the bridge is an AVRCP Target
+and Controller. The server presents a dummy MPRIS player. The client
+runs a second `mpris-proxy` with ``--export``, which exports that
+remote player on the client session bus, and the upper tester controls
+it there as an ordinary MPRIS client.
+
+SETUP
+=====
+
+.. code-block::
+
+	+--------------------------------+            +--------------------------------+
+	| host0 / client                 |   BR/EDR   | host1 / server                 |
+	| bluetoothd                     |   AVCTP    | bluetoothd                     |
+	| mpris-proxy --export           |  PSM 0x17  | mpris-proxy                    |
+	| MPRIS client (upper tester)    |  ------->  | dummy MPRIS player             |
+	| org.mpris.MediaPlayer2.        |            | org.mpris.MediaPlayer2.        |
+	|  <name> (session bus)          |            |  blueztest (session bus)       |
+	+--------------------------------+            +--------------------------------+
+
+The server host owns the session bus name
+``org.mpris.MediaPlayer2.blueztest`` and exports
+``/org/mpris/MediaPlayer2`` with the ``org.mpris.MediaPlayer2`` and
+``org.mpris.MediaPlayer2.Player`` interfaces. Its player starts
+stopped, at track 0. Every MPRIS method call it receives is reported
+to the upper tester. It changes its properties only when the upper
+tester tells it to, and then emits
+``org.freedesktop.DBus.Properties.PropertiesChanged``.
+
+The `mpris-proxy` on the server registers that player with its
+**bluetoothd** through ``org.bluez.Media1.RegisterPlayer``, so the
+server host is the AVRCP Target. The `mpris-proxy --export` on the
+client exports the ``org.bluez.MediaPlayer1`` object its bluetoothd
+creates for the remote player as ``org.mpris.MediaPlayer2.<name>``,
+where ``<name>`` is derived from the remote device alias, at
+``/org/mpris/MediaPlayer2`` on the client session bus. Both proxies use
+adapter index 0.
+
+Before each case the upper tester does the following, and checks each
+step:
+
+	1. Pair the hosts over BR/EDR, unless they are already paired, as
+	   the host setup is reused between cases: the client discovers
+	   the server and calls ``org.bluez.Device1.Pair``, and both
+	   agents confirm the passkey.
+	2. On both hosts, set ``Trusted`` to true with
+	   ``org.freedesktop.DBus.Properties.Set`` on the
+	   ``org.bluez.Device1`` object of the peer host.
+	3. Connect on the client with ``org.bluez.Device1.ConnectProfile``
+	   and the AVRCP Controller UUID
+	   (``0000110c-0000-1000-8000-00805f9b34fb``). The call must
+	   reply, or fail with ``AlreadyConnected`` since a previous case
+	   may still be connected.
+	4. Wait until the client session bus has exactly one name with the
+	   prefix ``org.mpris.MediaPlayer2.``, listed with
+	   ``org.freedesktop.DBus.ListNames``. That is the exported player.
+	5. Wait until its ``PlaybackStatus``, read with
+	   ``org.freedesktop.DBus.Properties.Get``, is ``Stopped``.
+
+The same connection and exported player are used by both cases.
+
+TEARDOWN
+========
+
+After each case, also on failure, the upper tester resets the dummy
+player on the server to stopped and track 0, which emits
+``PropertiesChanged`` for ``PlaybackStatus`` and ``Metadata``, and
+drops the method calls left over from the previous case. It then waits
+until the exported player on the client reads ``Stopped`` again. The
+hosts, both bluetoothd instances, both proxies and the connection are
+left running.
+
+TEST CASES
+==========
+
+test_mpris_proxy_playback_control
+---------------------------------
+
+:Setup: As above.
+
+:Steps: For each of ``Play``, ``Pause`` and ``Stop``, in that order:
+
+	1. The upper tester calls the method on the exported player
+	   ``org.mpris.MediaPlayer2.Player`` interface on the client
+	   session bus, and waits for the reply.
+	2. It waits until the dummy player on the server reports the same
+	   MPRIS method call.
+	3. It then lets the dummy player react as a player application
+	   would, setting ``PlaybackStatus`` to ``Playing``, ``Paused``
+	   and ``Stopped``, emitted as ``PropertiesChanged``.
+	4. It waits until the exported player on the client reports the
+	   expected ``PlaybackStatus``.
+
+:Expected:
+	1. Each call is answered on the client session bus.
+	2. The dummy player on the server receives ``Play``, ``Pause`` and
+	   ``Stop``.
+	3. The exported player on the client reports ``Playing``,
+	   ``Paused`` and ``Stopped``.
+
+test_mpris_proxy_track_control
+------------------------------
+
+:Setup: As above.
+
+:Steps:
+	1. The upper tester reads the current track number of the dummy
+	   player on the server.
+	2. It calls ``Next`` on the exported player on the client session
+	   bus and waits for the reply.
+	3. It waits until the dummy player reports ``Next``, and then has
+	   it increment the track number and emit the new ``Metadata``,
+	   whose ``xesam:title`` is ``Test Track <n>``.
+	4. It waits until the exported player on the client reports that
+	   title in ``Metadata``.
+	5. It repeats the same for ``Previous``, which decrements the
+	   track number.
+
+:Expected:
+	1. The dummy player on the server receives ``Next`` and
+	   ``Previous``.
+	2. The metadata of the new track reaches the exported player on
+	   the client: both its ``xesam:title`` and its
+	   ``xesam:trackNumber`` match the new track.
+
+:Notes: The dummy player changes its state only once the upper tester
+	has observed the corresponding call.
diff --git a/doc/functional-testing.rst b/doc/functional-testing.rst
index 60c6762de..6fdc17b9a 100644
--- a/doc/functional-testing.rst
+++ b/doc/functional-testing.rst
@@ -15,6 +15,7 @@ are documented separately:
 - **functional-a2dp(7)**: `test/functional/test_a2dp.py`
 - **functional-avrcp(7)**: `test/functional/test_avrcp.py`
 - **functional-bap(7)**: `test/functional/test_bap.py`
+- **functional-mpris-proxy(7)**: `test/functional/test_mpris_proxy.py`
 - **functional-obex(7)**: `test/functional/test_obex.py`
 
 Each test case is described as:
diff --git a/test/functional/test_mpris_proxy.py b/test/functional/test_mpris_proxy.py
new file mode 100644
index 000000000..54b888c79
--- /dev/null
+++ b/test/functional/test_mpris_proxy.py
@@ -0,0 +1,428 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+End-to-end tests for mpris-proxy.
+"""
+
+import logging
+import subprocess
+
+import dbus
+import dbus.exceptions
+import dbus.service
+import pytest
+
+from pytest_bluezenv import (
+    Agent,
+    Bluetoothd,
+    DbusSession,
+    EventPluginMixin,
+    HostPlugin,
+    LogStream,
+    dbus_service_event_method,
+    find_exe,
+    get_dbus,
+    host_config,
+    mainloop_assert,
+    mainloop_wrap,
+    quoted,
+    wait_until,
+)
+
+BLUEZ_BUS_NAME = "org.bluez"
+
+MPRIS_BUS_NAME = "org.mpris.MediaPlayer2.blueztest"
+MPRIS_PATH = "/org/mpris/MediaPlayer2"
+MPRIS_ROOT_INTERFACE = "org.mpris.MediaPlayer2"
+MPRIS_PLAYER_INTERFACE = "org.mpris.MediaPlayer2.Player"
+
+MPRIS_BUS_PREFIX = "org.mpris.MediaPlayer2."
+
+BLUEZ_DEVICE_INTERFACE = "org.bluez.Device1"
+PROPS_INTERFACE = "org.freedesktop.DBus.Properties"
+
+AVRCP_CONTROLLER_UUID = "0000110c-0000-1000-8000-00805f9b34fb"
+
+
+def mpris_player_method(*a, **kw):
+    return dbus_service_event_method(MPRIS_PLAYER_INTERFACE, *a, **kw)
+
+
+class MprisPlayerService(dbus.service.Object):
+    """
+    Dummy implementation of the MPRIS 2.2 root and player interfaces on
+    the session bus. Method calls are pushed as events to the owner
+    plugin event queue, like AgentObject does.
+    """
+
+    class UnknownProperty(dbus.exceptions.DBusException):
+        _dbus_error_name = "org.freedesktop.DBus.Error.UnknownProperty"
+
+    @mainloop_assert
+    def __init__(self, bus_name, owner):
+        self.events = owner.events
+        self.owner = owner
+        super().__init__(bus_name, MPRIS_PATH)
+
+    Play = mpris_player_method("Play")
+    Pause = mpris_player_method("Pause")
+    Stop = mpris_player_method("Stop")
+    Next = mpris_player_method("Next")
+    Previous = mpris_player_method("Previous")
+
+    @dbus.service.method(PROPS_INTERFACE, in_signature="ss", out_signature="v")
+    def Get(self, interface, prop):
+        props = self._properties(interface)
+        if prop not in props:
+            raise self.UnknownProperty(f"No such property {prop} on {interface}")
+        return props[prop]
+
+    @dbus.service.method(PROPS_INTERFACE, in_signature="s", out_signature="a{sv}")
+    def GetAll(self, interface):
+        return self._properties(interface)
+
+    @dbus.service.signal(PROPS_INTERFACE, signature="sa{sv}as")
+    def PropertiesChanged(self, interface, changed, invalidated):
+        pass
+
+    def _properties(self, interface):
+        if interface == MPRIS_ROOT_INTERFACE:
+            return self.owner.root_properties()
+        if interface == MPRIS_PLAYER_INTERFACE:
+            return self.owner.player_properties()
+        return dbus.Dictionary({}, signature="sv")
+
+
+class DummyMprisPlayer(HostPlugin, EventPluginMixin):
+    """
+    Host plugin providing a dummy MPRIS player on the session bus under the
+    name org.mpris.MediaPlayer2.blueztest. mpris-proxy picks it up and
+    registers it to BlueZ as a media player.
+
+    Method calls received by the player are pushed as asynchronous
+    events, named org.mpris.MediaPlayer2.Player.<method>. Tests use
+    expect() to observe them, and update the player state explicitly with
+    the setter methods, which emit MPRIS PropertiesChanged.
+    """
+
+    name = "dummy_player"
+    depends = [DbusSession()]
+
+    PLAYER_NAME = "BlueZ Test Player"
+
+    @mainloop_wrap
+    def setup(self, impl):
+        EventPluginMixin.setup(self, impl)
+
+        self.log = logging.getLogger(self.name)
+
+        self.status = "Stopped"
+        self.track_number = 0
+
+        self.bus = get_dbus(session=True)
+        self.bus_name = dbus.service.BusName(MPRIS_BUS_NAME, bus=self.bus)
+        self.service = MprisPlayerService(self.bus_name, self)
+
+        self.log.info(f"MPRIS player {MPRIS_BUS_NAME} exported")
+
+    @mainloop_wrap
+    def teardown(self):
+        self.service.remove_from_connection()
+        self.bus_name = None
+        self.service = None
+
+    @mainloop_wrap
+    def set_status(self, status):
+        # Emit unconditionally: the test relies on PropertiesChanged being
+        # sent for every update it requests
+        self.status = status
+        self._emit_properties_changed(PlaybackStatus=dbus.String(status))
+
+    @mainloop_wrap
+    def advance_track(self, delta):
+        self.track_number = max(0, self.track_number + delta)
+        self._emit_properties_changed(Metadata=self.metadata())
+
+    @mainloop_wrap
+    def get_track_number(self):
+        return self.track_number
+
+    @mainloop_wrap
+    def reset(self):
+        # Emit unconditionally so that the remote state follows the reset,
+        # then drop any events left over from the previous test
+        self.status = "Stopped"
+        self.track_number = 0
+        while self.get_event(block=False) is not None:
+            pass
+        self._emit_properties_changed(
+            PlaybackStatus=dbus.String(self.status), Metadata=self.metadata()
+        )
+
+    def _emit_properties_changed(self, **changed):
+        self.service.PropertiesChanged(
+            MPRIS_PLAYER_INTERFACE,
+            dbus.Dictionary(changed, signature="sv"),
+            dbus.Array([], signature="s"),
+        )
+
+    def metadata(self):
+        return dbus.Dictionary(
+            {
+                "xesam:title": dbus.String(f"Test Track {self.track_number}"),
+                "xesam:artist": dbus.Array([dbus.String("Test Artist")], signature="s"),
+                "xesam:album": dbus.String("Test Album"),
+                "xesam:trackNumber": dbus.Int32(self.track_number),
+                "mpris:trackid": dbus.ObjectPath(
+                    f"/org/mpris/MediaPlayer2/Track/{self.track_number}"
+                ),
+            },
+            signature="sv",
+        )
+
+    def root_properties(self):
+        return dbus.Dictionary(
+            {
+                "Identity": dbus.String(self.PLAYER_NAME),
+                "CanQuit": dbus.Boolean(False),
+                "CanRaise": dbus.Boolean(False),
+                "HasTrackList": dbus.Boolean(False),
+            },
+            signature="sv",
+        )
+
+    def player_properties(self):
+        return dbus.Dictionary(
+            {
+                "PlaybackStatus": dbus.String(self.status),
+                "LoopStatus": dbus.String("None"),
+                "Shuffle": dbus.Boolean(False),
+                "Rate": dbus.Double(1.0),
+                "MinimumRate": dbus.Double(1.0),
+                "MaximumRate": dbus.Double(1.0),
+                "Volume": dbus.Double(1.0),
+                "Metadata": self.metadata(),
+                "CanGoNext": dbus.Boolean(True),
+                "CanGoPrevious": dbus.Boolean(True),
+                "CanPlay": dbus.Boolean(True),
+                "CanPause": dbus.Boolean(True),
+                "CanSeek": dbus.Boolean(True),
+                "CanControl": dbus.Boolean(True),
+            },
+            signature="sv",
+        )
+
+
+class MprisProxy(HostPlugin):
+    """
+    Host plugin running the mpris-proxy tool.
+
+    Args:
+        args: extra command line arguments, e.g. ("--export",) to also
+            export the remote players found by BlueZ as MPRIS players on
+            the session bus
+    """
+
+    name = "mpris_proxy"
+    depends = [Bluetoothd(), DbusSession()]
+
+    def __init__(self, args=()):
+        self.extra_args = list(args)
+
+    def presetup(self, config):
+        try:
+            self.exe = find_exe("tools", "mpris-proxy")
+        except FileNotFoundError as exc:
+            pytest.skip(reason=f"mpris-proxy: {exc!r}")
+
+    @mainloop_wrap
+    def setup(self, impl):
+        self.log = logging.getLogger(self.name)
+        self.log_stream = LogStream(self.name)
+
+        cmd = [self.exe, "--index", "0"] + self.extra_args
+        self.log.info("Start mpris-proxy: {}".format(quoted(cmd)))
+
+        self.job = subprocess.Popen(
+            cmd,
+            stdin=subprocess.DEVNULL,
+            stdout=self.log_stream.stream,
+            stderr=subprocess.STDOUT,
+        )
+
+    def teardown(self):
+        self.log.info("Stop mpris-proxy")
+        self.job.terminate()
+
+
+class MprisClient(HostPlugin):
+    """
+    Host plugin used by the test on the client host to discover and
+    control the player of a remote device through the MPRIS client API,
+    as exported to the session bus by `mpris-proxy --export`.
+    """
+
+    name = "mpris_client"
+    depends = [DbusSession()]
+
+    _missing_errors = (
+        "org.freedesktop.DBus.Error.UnknownProperty",
+        "org.freedesktop.DBus.Error.InvalidArgs",
+    )
+
+    @mainloop_wrap
+    def exported_player(self):
+        """Return the bus name of the single exported remote player, or None."""
+        bus = get_dbus(session=True)
+        obj = bus.get_object("org.freedesktop.DBus", "/org/freedesktop/DBus")
+        names = [
+            str(name)
+            for name in dbus.Interface(obj, "org.freedesktop.DBus").ListNames()
+            if str(name).startswith(MPRIS_BUS_PREFIX)
+        ]
+        assert len(names) <= 1, f"unexpected exported players: {names}"
+        return names[0] if names else None
+
+    def _get(self, name, interface, prop):
+        bus = get_dbus(session=True)
+        props = dbus.Interface(bus.get_object(name, MPRIS_PATH), PROPS_INTERFACE)
+        try:
+            return props.Get(interface, prop)
+        except dbus.exceptions.DBusException as exc:
+            if exc.get_dbus_name() in self._missing_errors:
+                return None
+            raise
+
+    @mainloop_wrap
+    def get_status(self, name):
+        value = self._get(name, MPRIS_PLAYER_INTERFACE, "PlaybackStatus")
+        return str(value) if value is not None else None
+
+    @mainloop_wrap
+    def get_metadata(self, name):
+        metadata = self._get(name, MPRIS_PLAYER_INTERFACE, "Metadata")
+        if metadata is None:
+            return {}
+        return {str(key): str(value) for key, value in metadata.items()}
+
+    @mainloop_wrap
+    def call_method(self, name, method):
+        """Call given org.mpris.MediaPlayer2.Player method synchronously."""
+        bus = get_dbus(session=True)
+        player = dbus.Interface(
+            bus.get_object(name, MPRIS_PATH), MPRIS_PLAYER_INTERFACE
+        )
+        getattr(player, method)()
+
+
+@mainloop_wrap
+def vm_set_trusted(bdaddr):
+    """Mark the device with the given address as trusted."""
+    path = "/org/bluez/hci0/dev_" + bdaddr.upper().replace(":", "_")
+    bus = get_dbus()
+    props = dbus.Interface(bus.get_object(BLUEZ_BUS_NAME, path), PROPS_INTERFACE)
+    props.Set(BLUEZ_DEVICE_INTERFACE, "Trusted", dbus.Boolean(True))
+
+
+@pytest.fixture
+def mpris_player(paired_hosts_bredr):
+    """
+    Two paired and trusted hosts, the client connected to the dummy MPRIS
+    player of the server, exported on the client session bus by
+    mpris-proxy --export.
+
+    The dummy player is reset also on failure, so the tests are
+    order-independent.
+
+    Yields (client, server, exported player bus name).
+    """
+    client, server = paired_hosts_bredr
+
+    client.call(vm_set_trusted, server.bdaddr)
+    server.call(vm_set_trusted, client.bdaddr)
+
+    client.agent.device_method(server.bdaddr, "ConnectProfile", AVRCP_CONTROLLER_UUID)
+    event = client.agent.expect(
+        (
+            "org.bluez.Device1.ConnectProfile:reply",
+            "org.bluez.Device1.ConnectProfile:error",
+        )
+    )
+    if event.kind.endswith(":error"):
+        # OK if the player is already connected (reused host setup)
+        assert "AlreadyConnected" in str(
+            event.error
+        ), f"ConnectProfile failed: {event.error}"
+
+    wait_until(lambda: client.mpris_client.exported_player())
+    player_name = client.mpris_client.exported_player()
+
+    wait_until(lambda: client.mpris_client.get_status(player_name) == "Stopped")
+
+    yield client, server, player_name
+
+    server.dummy_player.reset()
+    wait_until(lambda: client.mpris_client.get_status(player_name) == "Stopped")
+
+
+mpris_proxy_host_config = host_config(
+    [MprisProxy(args=("--export",)), MprisClient(), Agent()],
+    [MprisProxy(), DummyMprisPlayer(), Agent()],
+    reuse=True,
+)
+
+
+def control_player(client, server, player_name, method, update, *args):
+    """
+    Call an MPRIS Player method on the remote player exported on the
+    client session bus, wait for the dummy player to receive the matching
+    MPRIS call, and run update(*args) to update the dummy player state, as
+    a player application would react to the call.
+    """
+    client.mpris_client.call_method(player_name, method)
+    server.dummy_player.expect(f"{MPRIS_PLAYER_INTERFACE}.{method}")
+    update(*args)
+
+
+@mpris_proxy_host_config
+def test_mpris_proxy_playback_control(mpris_player):
+    client, server, player_name = mpris_player
+
+    for method, status in (
+        ("Play", "Playing"),
+        ("Pause", "Paused"),
+        ("Stop", "Stopped"),
+    ):
+        control_player(
+            client,
+            server,
+            player_name,
+            method,
+            server.dummy_player.set_status,
+            status,
+        )
+        wait_until(lambda: client.mpris_client.get_status(player_name) == status)
+
+
+@mpris_proxy_host_config
+def test_mpris_proxy_track_control(mpris_player):
+    client, server, player_name = mpris_player
+
+    track_number = server.dummy_player.get_track_number()
+
+    for delta, method in ((1, "Next"), (-1, "Previous")):
+        track_number += delta
+        control_player(
+            client,
+            server,
+            player_name,
+            method,
+            server.dummy_player.advance_track,
+            delta,
+        )
+        wait_until(
+            lambda: client.mpris_client.get_metadata(player_name).get("xesam:title")
+            == f"Test Track {track_number}"
+        )
+        metadata = client.mpris_client.get_metadata(player_name)
+        assert int(metadata["xesam:trackNumber"]) == track_number
-- 
2.55.0

