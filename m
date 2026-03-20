Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2599436897A
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774041086; cv=pass; b=XfMwv9WPjf4YbsbMmqsmwpY7iJ6Fah5pf2CpNr10al1dkHhrdndpUmaEikwbws9p4Kgz57Y5COeM55UrXmNCNHcLgV0fEZuL2pGkz6bYNh4jlHyW0o5W8FYT63bH54jKMjcfH+1Ft86ZKqgSKtT23e3x5U5PHhapsD1Yz2QEFBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774041086; c=relaxed/simple;
	bh=DuhtQZ+fdMaAkoQ5GN8M4PmiI+KGpvm/sz3yKBpKt/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBLvc8w8zvF5zY+hq90AUmaX3EArqnNZtxRpy8sLPQbUCNiDdu/lu8EZaDkRnEiArfqYercazvc5hQcqQxRaBAMSv1jsiaSg2Q54IK+CxKtogFSyT3Fnjzot+LMK8RiTpi3LI4lS8YPTKV7PX9HK1OOQqYmzb/lcsFIATcxvvPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=VKxmm+dh; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="VKxmm+dh"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:d:f011:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fcwGd60n5zygB;
	Fri, 20 Mar 2026 23:11:21 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774041082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/oLNMNMT97W5aXULRdaKwjmGoVTd5bKmheKhtbdrLM=;
	b=VKxmm+dhGyRszd7YKggEUlDMext/R8DMqvRX+1Wx+Z/de24TuS4UHetx5aRGPtErsqvZS0
	e0AwBtXP/nRjQL2kzE2yn66MUJFP7/qeQQ1rscjSjGcrn79LpRE6rZQxyOZ79Biw9NbOq7
	xi8l0kNfzevvaBXLvIbQ/85NHG3Pj60=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774041082;
	b=PNLjcAIAG2AHQf+qYsX/pl5EGKjdrGm1zGA4Gmt3WrSQfrKrfc296lLSGZaE7XQkrDCYGn
	Qv4cUlgR0tKZAmn1KwCHfVSkqtcrgJy/lV6i1rfuLxNhcdvuUDu3JLKIVPdDkHOLkQoGL8
	LkyvEmxyMRRKDhVEG2FnKERL5CSVgq4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774041082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+/oLNMNMT97W5aXULRdaKwjmGoVTd5bKmheKhtbdrLM=;
	b=dLqBsXf8r7nUz8KeOZH9SYpKVXJwNh7l528Bs3ZbXUsB7VcFKvTXOHW5juKXL3uZDQz5L9
	bN++Wdtw4Cplk+az8mInvITdncPv4Ds5tEO3kqPw/490HNmDchPEp+siTxgrtgqVhLic5t
	SC9zrPSU2cBhtZRGxUCnXvpZWK7wSfM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 13/20] test: functional: add Pipewire-using audio streaming tests
Date: Fri, 20 Mar 2026 23:10:57 +0200
Message-ID: <13fd4b0351539b1bd91381ddd9f4e831dd711d2a.1774041047.git.pav@iki.fi>
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

Add tests for Pipewire hosts connecting A2DP, BAP, and HFP to each other
and stream audio:

test/functional/test_pipewire.py::test_pipewire_a2dp
test/functional/test_pipewire.py::test_pipewire_bap_bcast
test/functional/test_pipewire.py::test_pipewire_bap_ucast
test/functional/test_pipewire.py::test_pipewire_hfp

The A2DP test would have catched the regression fixed by 066a164a524 and
the BAP test that fixed by 6b0a08776a.
---
 test/functional/test_pipewire.py | 536 +++++++++++++++++++++++++++++++
 test/pytest.ini                  |   1 +
 2 files changed, 537 insertions(+)
 create mode 100644 test/functional/test_pipewire.py

diff --git a/test/functional/test_pipewire.py b/test/functional/test_pipewire.py
new file mode 100644
index 000000000..4feb7d599
--- /dev/null
+++ b/test/functional/test_pipewire.py
@@ -0,0 +1,536 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for Pipewire audio
+
+To use uninstalled version of Pipewire, run the tests in Pipewire
+devenv::
+
+    meson devenv -C ../pipewire/builddir -w . test/test-functional -m pipewire -v
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
+    host_config,
+    find_exe,
+    Bluetoothd,
+    Bluetoothctl,
+    DbusSession,
+    LogStream,
+    wait_until,
+    mainloop_wrap,
+)
+
+pytestmark = [pytest.mark.vm, pytest.mark.pipewire]
+
+log = logging.getLogger(__name__)
+
+
+class Pipewire(HostPlugin):
+    """
+    Launch Pipewire in VM instance
+    """
+
+    name = "pipewire"
+    depends = [DbusSession(), Bluetoothd()]
+
+    def __init__(
+        self,
+        uuids=(
+            "0000110a-0000-1000-8000-00805f9b34fb",
+            "0000110b-0000-1000-8000-00805f9b34fb",
+        ),
+        roles="a2dp_sink a2dp_source",
+        config=None,
+    ):
+        self.uuids = tuple(uuids)
+        self.roles = str(roles)
+        self.config = config
+
+        # For running Pipewire from build directory
+        self.devenv = {}
+        if os.environ.get("PW_UNINSTALLED"):
+            devenv_keys = [
+                "WIREPLUMBER_MODULE_DIR",
+                "WIREPLUMBER_CONFIG_DIR",
+                "WIREPLUMBER_DATA_DIR",
+                "PIPEWIRE_CONFIG_DIR",
+                "PIPEWIRE_MODULE_DIR",
+                "SPA_PLUGIN_DIR",
+                "SPA_DATA_DIR",
+                "ACP_PATHS_DIR",
+                "ACP_PROFILES_DIR",
+                "GST_PLUGIN_PATH",
+                "ALSA_PLUGIN_DIR",
+                "LD_LIBRARY_PATH",
+                "PW_UNINSTALLED",
+                "PW_BUILDDIR",
+            ]
+            for key in devenv_keys:
+                value = os.environ.get(key)
+                if value is not None:
+                    self.devenv[key] = value
+
+    def presetup(self, config):
+        try:
+            self.exe_pw = find_exe("", "pipewire")
+            self.exe_wp = find_exe("", "wireplumber")
+            self.exe_dump = find_exe("", "pw-dump")
+
+            # check version
+            res = subprocess.run(
+                [self.exe_wp, "--version"], stdout=subprocess.PIPE, encoding="utf-8"
+            )
+            m = re.search("libwireplumber ([0-9.]+)", res.stdout)
+            if m:
+                version = tuple(int(x) for x in m.group(1).split("."))
+                if version < (0, 5, 8):
+                    raise ValueError("wireplumber too old")
+            else:
+                raise ValueError("wireplumber version unknown")
+        except (FileNotFoundError, ValueError) as exc:
+            pytest.skip(reason=f"Pipewire: {exc}")
+
+    @mainloop_wrap
+    def setup(self, impl):
+        self.play = None
+        self.record = None
+        self.log = logging.getLogger(self.name)
+
+        self.tmpdir = tempfile.TemporaryDirectory(prefix="pipewire-", dir="/run")
+        conf_dir = Path(self.tmpdir.name) / "config"
+        runtime_dir = Path(self.tmpdir.name) / "runtime"
+        state_dir = Path(self.tmpdir.name) / "state"
+
+        dropin_dir = conf_dir / "wireplumber" / "wireplumber.conf.d"
+        wp_conf = dropin_dir / "01-config.conf"
+        wp_extra_conf = dropin_dir / "02-extra-config.conf"
+
+        conf_dir.mkdir()
+        runtime_dir.mkdir()
+        dropin_dir.mkdir(parents=True)
+        state_dir.mkdir()
+
+        environ = dict(os.environ)
+        environ.update(self.devenv)
+
+        environ["XDG_CONFIG_HOME"] = str(conf_dir)
+        environ["XDG_STATE_HOME"] = str(runtime_dir)
+        environ["XDG_RUNTIME_HOME"] = str(runtime_dir)
+        environ["PIPEWIRE_RUNTIME_DIR"] = str(runtime_dir)
+        environ["XDG_STATE_HOME"] = str(state_dir)
+        environ["PIPEWIRE_DEBUG"] = "2"
+        environ["WIREPLUMBER_DEBUG"] = (
+            "spa.bluez5.iso:3,spa.bluez5*:4,s-monitors:4,m-lua-scripting:4,s-linking:4,s-device:4"
+        )
+
+        # Handle devenv
+        if "WIREPLUMBER_CONFIG_DIR" in environ:
+            environ["WIREPLUMBER_CONFIG_DIR"] = (
+                environ["WIREPLUMBER_CONFIG_DIR"] + ":" + str(conf_dir / "wireplumber")
+            )
+
+        with open(wp_conf, "w") as f:
+            text = f"""
+            monitor.bluez.properties = {{
+               bluez5.roles = [ {self.roles} ]
+               bluez5.decode-buffer.latency = 4096
+            }}
+            """
+            f.write(text)
+
+        if self.config is not None:
+            with open(wp_extra_conf, "w") as f:
+                f.write(self.config)
+
+        log.info(f"Starting pipewire: {self.exe_pw}")
+
+        self.logger = LogStream("pipewire")
+        self.pw = subprocess.Popen(
+            self.exe_pw,
+            env=environ,
+            stdout=self.logger.stream,
+            stderr=subprocess.STDOUT,
+        )
+
+        log.info(f"Starting pipewire: {self.exe_wp}")
+
+        self.wp = subprocess.Popen(
+            self.exe_wp,
+            env=environ,
+            stdout=self.logger.stream,
+            stderr=subprocess.STDOUT,
+        )
+
+        # Wait for Pipewire's bluetooth services
+        log.info("Wait for Pipewire...")
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
+        wait_until(cond)
+
+        os.environ["PIPEWIRE_RUNTIME_DIR"] = str(runtime_dir)
+
+        # Wait for wireplumber session services
+        def cond():
+            try:
+                data = json.loads(self.pw_dump())
+            except:
+                return False
+            for item in data:
+                if item.get("type", None) != "PipeWire:Interface:Client":
+                    continue
+                if item["info"]["props"]["application.name"] != "WirePlumber":
+                    continue
+                if "api.bluez" in item["info"]["props"].get("session.services", ""):
+                    return True
+            return False
+
+        wait_until(cond)
+
+        log.info("Pipewire ready")
+
+    def pw_dump(self):
+        ret = subprocess.run(["pw-dump"], stdout=subprocess.PIPE, encoding="utf-8")
+        return ret.stdout
+
+    def pw_play(self):
+        self.play = subprocess.Popen(
+            [
+                "pw-play",
+                "--raw",
+                "--rate",
+                "4000",
+                "--channels",
+                "1",
+                "--format",
+                "s8",
+                "-",
+            ],
+            stdin=subprocess.PIPE,
+        )
+        self.play_thread = threading.Thread(
+            target=self._play_thread, args=(self.play.stdin,)
+        )
+        self.play_thread.start()
+
+    def _play_thread(self, stream):
+        block = bytes([j % 256 for j in range(4096)])
+        while True:
+            try:
+                stream.write(block)
+            except:
+                self.log.info("pw_play ended")
+                break
+
+    def pw_record(self):
+        self.record = subprocess.Popen(
+            [
+                "pw-record",
+                "-P",
+                "media.class=Audio/Sink",
+                "--raw",
+                "--format",
+                "s8",
+                "--rate",
+                "4000",
+                "--channels",
+                "1",
+                "-",
+            ],
+            stdout=subprocess.PIPE,
+        )
+        self.record_thread = threading.Thread(
+            target=self._record_thread, args=(self.record.stdout,)
+        )
+        self.record_thread.start()
+        self.record_signal = threading.Event()
+
+    def _record_thread(self, stream):
+        while True:
+            try:
+                block = stream.read(256)
+                if not block:
+                    break
+            except:
+                self.log.info("pw_record failed")
+                break
+
+            # If we get anything nonzero, some signal is getting
+            # through.  Can't check exactness due to encoding and
+            # possibly heavy underruns in VM environment.
+            if any(list(block)):
+                self.log.info("pw_record signal found")
+                self.record_success = True
+                self.record_signal.set()
+                return
+            else:
+                self.log.debug("pw_record: waiting for signal")
+
+        self.log.error("pw_record: no signal found")
+        self.record_success = False
+        self.record_signal.set()
+
+    def pw_record_wait_signal(self, timeout=160):
+        res = self.record_signal.wait(timeout=timeout)
+        return res and self.record_success
+
+    def teardown(self):
+        log.info("Stop pipewire")
+        self.pw.terminate()
+        self.wp.terminate()
+        if self.play is not None:
+            try:
+                self.play.stdin.close()
+            except BrokenPipeError:
+                pass
+            self.play.terminate()
+            self.play_thread.join()
+        if self.record is not None:
+            try:
+                self.record.stdout.close()
+            except BrokenPipeError:
+                pass
+            self.record.terminate()
+            self.record_thread.join()
+        self.tmpdir.cleanup()
+
+
+@pytest.fixture
+def paired_hosts(hosts, host_setup):
+    from .test_bluetoothctl_vm import (
+        test_bluetoothctl_pair_bredr,
+        test_bluetoothctl_pair_le,
+    )
+
+    le = any(
+        "ControllerMode = le" in (p.conf or "")
+        for plugins in host_setup["setup"]
+        for p in plugins
+        if isinstance(p, Bluetoothd)
+    )
+
+    if le:
+        test_bluetoothctl_pair_le(hosts)
+    else:
+        test_bluetoothctl_pair_bredr(hosts)
+
+    return hosts
+
+
+a2dp_host = [Bluetoothctl(), Pipewire(roles="a2dp_sink a2dp_source")]
+
+
+@host_config(a2dp_host, a2dp_host)
+def test_pipewire_a2dp(paired_hosts):
+    host0, host1 = paired_hosts
+
+    # Connect
+    host1.bluetoothctl.send(f"trust {host0.bdaddr}\n")
+    host0.bluetoothctl.send(f"connect {host1.bdaddr}\n")
+
+    # Wait for pipewire devices to appear
+    check_pipewire_devices_exist(host0, "a2dp-sink")
+
+    # Test streaming
+    host1.pipewire.pw_record()
+    host0.pipewire.pw_play()
+
+    assert host1.pipewire.pw_record_wait_signal()
+
+
+bap_ucast_host = [
+    Bluetoothd(conf="[General]\nControllerMode = le\n", args=["-E", "-K"]),
+    Bluetoothctl(),
+    Pipewire(
+        roles="bap_sink bap_source", uuids=("00001850-0000-1000-8000-00805f9b34fb",)
+    ),
+]
+
+
+@host_config(bap_ucast_host, bap_ucast_host)
+def test_pipewire_bap_ucast(paired_hosts):
+    host0, host1 = paired_hosts
+
+    # Connect
+    host1.bluetoothctl.send(f"trust {host0.bdaddr}\n")
+
+    host0.bluetoothctl.send(f"scan off\n")
+    host0.bluetoothctl.send(f"connect {host1.bdaddr}\n")
+
+    # Wait for pipewire devices to appear
+    check_pipewire_devices_exist(host0, "bap-sink")
+
+    # Test streaming
+    host1.pipewire.pw_record()
+    host0.pipewire.pw_play()
+
+    assert host1.pipewire.pw_record_wait_signal()
+
+
+bcast_src_config = """
+monitor.bluez.properties = {
+  bluez5.bcast_source.config = [
+    {
+      "broadcast_code": "Test",
+      "encryption": false,
+      "bis": [ { "qos_preset": "16_2_1" } ]
+    }
+  ]
+}
+"""
+
+bap_bcast_src_host = [
+    Bluetoothd(conf="[General]\nControllerMode = le\n", args=["-E", "-K"]),
+    Bluetoothctl(),
+    Pipewire(
+        roles="bap_bcast_source",
+        uuids=("00001850-0000-1000-8000-00805f9b34fb",),
+        config=bcast_src_config,
+    ),
+]
+
+bap_bcast_snk_host = [
+    Bluetoothd(conf="[General]\nControllerMode = le\n", args=["-E", "-K"]),
+    Bluetoothctl(),
+    Pipewire(roles="bap_bcast_sink", uuids=("00001850-0000-1000-8000-00805f9b34fb",)),
+]
+
+
+@host_config(bap_bcast_src_host, bap_bcast_snk_host)
+def test_pipewire_bap_bcast(hosts):
+    host0, host1 = hosts
+
+    # Start broadcasting
+    check_pipewire_devices_exist(host0, "bap-sink")
+    host0.pipewire.pw_play()
+
+    # Connect
+    host1.bluetoothctl.send(f"scan on\n")
+
+    host0.bluetoothctl.send(f"advertise on\n")
+
+    host1.pipewire.pw_record()
+
+    idx, m = host1.bluetoothctl.expect(f"Transport (/org/bluez/hci0/.+)")
+    transport = m[0].decode("utf-8")
+
+    # BUG!: issuing transport select immediately causes failure
+    # BUG!: as it tries to enter broadcasting state while config(1)
+    # BUG!: is not finished and BROADCASTING state gets cancelled via
+    # BUG!:    transport.c:bap_state_changed()
+    # BUG!:    -> transport_update_playing(transport, FALSE)
+    # BUG!:    -> transport_set_state(transport, TRANSPORT_STATE_IDLE)
+
+    # TODO: fix the bug and go to transport.select without waiting here
+    check_pipewire_devices_exist(host1, "device")
+
+    host1.bluetoothctl.send(f"transport.select {transport}\n")
+
+    check_pipewire_devices_exist(host1, "bap-source")
+
+    # Test streaming
+    assert host1.pipewire.pw_record_wait_signal()
+
+
+hfp_hf_host = [
+    Bluetoothctl(),
+    Pipewire(
+        roles="hfp_hf",
+        uuids=("0000111e-0000-1000-8000-00805f9b34fb",),
+    ),
+]
+
+hfp_ag_host = [
+    Bluetoothctl(),
+    Pipewire(
+        roles="hfp_ag",
+        uuids=("0000111f-0000-1000-8000-00805f9b34fb",),
+    ),
+]
+
+
+@host_config(hfp_ag_host, hfp_hf_host)
+def test_pipewire_hfp(paired_hosts):
+    host0, host1 = paired_hosts
+
+    # Connect
+    host1.bluetoothctl.send(f"trust {host0.bdaddr}\n")
+
+    host0.bluetoothctl.send(f"scan off\n")
+    host0.bluetoothctl.send(f"connect {host1.bdaddr}\n")
+
+    # Wait for pipewire devices to appear
+    check_pipewire_devices_exist(host0, "hfp")
+
+    # Test streaming
+    host1.pipewire.pw_record()
+    host0.pipewire.pw_play()
+
+    assert host1.pipewire.pw_record_wait_signal()
+
+
+def check_pipewire_devices_exist(host, profile="a2dp-sink"):
+    factories = {
+        "a2dp-sink": ("api.bluez5.a2dp.sink",),
+        "a2dp-source": ("api.bluez5.a2dp.source",),
+        "hfp": ("api.bluez5.sco.sink", "api.bluez5.sco.source"),
+        "bap-sink": ("api.bluez5.media.sink",),
+        "bap-source": ("api.bluez5.media.source",),
+        "bap-duplex": ("api.bluez5.media.sink", "api.bluez5.media.source"),
+        "device": ("bluez5",),
+    }[profile]
+
+    text = ""
+
+    def cond():
+        nonlocal text
+
+        text = host.pipewire.pw_dump()
+        try:
+            data = json.loads(text)
+        except:
+            return False
+
+        seen = set()
+        for item in data:
+            if item.get("type", None) == "PipeWire:Interface:Node":
+                props = item["info"]["props"]
+                seen.add(props.get("factory.name", None))
+                continue
+            if item.get("type", None) == "PipeWire:Interface:Device":
+                props = item["info"]["props"]
+                seen.add(props.get("device.api", None))
+                continue
+
+        if not set(factories).difference(seen):
+            return True
+
+        return False
+
+    try:
+        wait_until(cond)
+    except TimeoutError:
+        assert False, f"pipewire devices not seen within timeout:\n{text}"
diff --git a/test/pytest.ini b/test/pytest.ini
index 899871fa2..e77d7e4ee 100644
--- a/test/pytest.ini
+++ b/test/pytest.ini
@@ -4,6 +4,7 @@ log_date_format = %Y-%m-%d %H:%M:%S.%f
 log_level = 0
 log_file = test-functional.log
 markers =
+    pipewire: tests requiring Pipewire
     vm: tests requiring VM image
 
 addopts =
-- 
2.53.0

