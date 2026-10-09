Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB762392C50
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 18:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569109; cv=none; b=NNt/NQR+4NopyjzdiaXsm88TeoGe8k5oqrHDf4mZfG8lmljE1MVJKr2DptQzvBzv4bqcuKztP4TocWeN4bQ7qaZfRI04+08+ZGpmEbXDV1ps8SF1S4TASNOpv0vp9O2wdb1D5uvAEoJCE4ZNLTvhUKOGnTIsuyryvecHRCKojDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569109; c=relaxed/simple;
	bh=YhPhL2of2cjSNCVKCYQDo18PB+6z1iCijGV2JWZe3Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjyRBwWL48KdFopCEF+cWFyH7ChfX+lRFQYmjg2wFwBjIJ+2gV5toguenagI5WBe58xIveg/jJUZK0qfhYiw467qPY5bt+QwXELPjYyLBsDCZMaVY8cEUuf0JAZuIM6iwz0wIqrxE4SdU0Z79LqzmJggM5sJe+2DZXfozA8d8fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org; spf=pass smtp.mailfrom=californiaopensource.com; dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b=MfXY2w0B; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=simpleble.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=californiaopensource.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simpleble.org header.i=@simpleble.org header.b="MfXY2w0B"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso9124428eec.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 11:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=simpleble.org; s=google; t=1791569107; x=1792173907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2hFnsjLQGT/tp1m5oi81uHZ6NH6jyUNTRvaF2Lc+pmQ=;
        b=MfXY2w0Bg36nHGOvZriMco33DicjWFa090xMQEgV8ygw3XJtQ/nY5Y/XI0hnBwCl+Q
         HCCXIe4CotxmQFqQ0ptJhU8nt+7BEYufWCkGixiiEBj3NmxRDCRuBABJQt8uQoM1SpfM
         lAujWwW5IO7McF6ieRDBwCl00FBMc3Z6QHlDg6QU/w4Vs/qJW7uYf2Fugh9HTuot9OJd
         9KV+nSNniEqMEoDvObu7AsBiZI5Qpg45eVKcqnH29oABjqxkIq7oN+RCPkIWwHBqSEnV
         Cjt9+/JZdDssabPM6m32qS4+BwxT7DQPpouX7G5WxHgo2xE9ubff2WMnEXGcG5H71A7y
         bkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791569107; x=1792173907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2hFnsjLQGT/tp1m5oi81uHZ6NH6jyUNTRvaF2Lc+pmQ=;
        b=ph/1B8+oQtZT9zV7ATbjV7t6016cim0UwY6rb261E7haMHOVuf19mwvObCt3Ud6wQg
         PZe20sMOmnFsRkD0ncysRWO5coINGxcJnMLh8l+BOlEH1Nm+a6/5SsNURDFfPo8mXjqk
         iqrX5eXTvJ/slryJ9D/fCGEpQcMU8Yu36Q4wCnjjx0M+d5ZZfCAkBpXrHfoY/lv5MEuP
         hVkJI0kgc+3OBjQhHfv7Tg2YTnv+/luPoVY0APugtbCgAiPAswL/kQEkZdBlvA2WRTU1
         vPs0/XiaTwTHUfJiwclBM01Y3d8fQTA8aSiQfcgvkWlU6q73gx2ilm9eU+pfInZKpwg1
         sYLw==
X-Gm-Message-State: AFuF++m3c++/fSqU4QHaon4KfT7RUAhys3po1KweNDHNKllpQcqjLnMg
	i8kMYVtWaaIESWPduuGoDnHNKtHH7zbzCE7DVFqVPVyi/7WIpsJgFMXNfrg+2FP+IAjNkrhLBh6
	iRBTi
X-Gm-Gg: AYBFou31OV2pk1XNuHsCVAs6ccPZnPQtFTEHpKpYIBAuRtV0TVdYctTucBnjKwq4Qlz
	xdUb8YVKonnZWC26ZTC+2T+MVGO60ge0bcS0yzG93B7fL5fa593WvQH8tLERG/FnxWtmCKfBg79
	YmXjp7TzTTZrghJ9p21YeKlszSC5L46F1MSTYvvVRB1gOrE72EviXS4Yz6PJYJiCsBUj9RlQxGg
	KvvxKYpudRwcn2/fw/IAurSfZeihlKEo0Eiw65Kdb6xxkH9ixTuw4dGN7QL3JDw7bTkA/u3NtKp
	PqC+ct+4xvgHif9p5IjQDcvm8371Hw4klIFYfFMRZOCZVIb7KqanXwVUhH7UP0cMxmvAKglgmyd
	1RVJQBsjc6M2g5UeN48wVoizSCHbBFtfxNL/aKhUtZCEuSzigzMHSUZvwy8QBf9Gx+X4qkCXaEH
	WbB4CFta4FaJBrstcmEKBHPFwak6fBaN+FXtDByipXA+2py0m06dN6Fc8kLQm8rsJaDZUjIk4pw
	ZXKmazzFIrSesLaRg7d+ff3mbk+frg30C5dNwbYq3KbMZApnj2TYrMimb6R2ZoqiVQgiNOVO+1A
	qCXJIHl+KAacQJRKT2KWOF1zTdO5U3RrlXhLKos=
X-Received: by 2002:a05:701b:4308:b0:13d:19da:9370 with SMTP id a92af1059eb24-16a60de3e9dmr2897077c88.17.1791569105716;
        Fri, 09 Oct 2026 11:05:05 -0700 (PDT)
Received: from localhost.localdomain ([12.158.218.17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6be0sm16111163c88.13.2026.10.09.11.05.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 11:05:05 -0700 (PDT)
From: Kevin Dewald <kevin@simpleble.org>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kevin Dewald <kevin@simpleble.org>
Subject: [PATCH BlueZ v3 5/5] test: functional: add bearer tests
Date: Fri,  9 Oct 2026 11:04:48 -0700
Message-ID: <20261009180448.29117-6-kevin@simpleble.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261009180448.29117-1-kevin@simpleble.org>
References: <20261009180448.29117-1-kevin@simpleble.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests where host0 connects to or pairs with host1 over LE or
BR/EDR, and both hosts check the properties and the Disconnected
signal of the bearer interfaces of the device object they have for the
other, including the LE Role of each side of the connection.

See doc/functional-bearer.rst for details.

Assisted-by: Claude:claude-opus-5.5
---
 test/functional/test_bearer.py | 302 +++++++++++++++++++++++++++++++++
 1 file changed, 302 insertions(+)
 create mode 100644 test/functional/test_bearer.py

diff --git a/test/functional/test_bearer.py b/test/functional/test_bearer.py
new file mode 100644
index 000000000..9d2f3346d
--- /dev/null
+++ b/test/functional/test_bearer.py
@@ -0,0 +1,302 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for the org.bluez.Bearer.LE1 and org.bluez.Bearer.BREDR1 interfaces
+
+host0 connects to or pairs with host1, and each host checks the bearer
+interfaces of the device object it has for the other.
+"""
+
+import logging
+
+import dbus
+import pytest
+
+from pytest_bluezenv import (
+    Agent,
+    Bluetoothd,
+    EventPluginMixin,
+    HostPlugin,
+    get_dbus,
+    host_config,
+    mainloop_wrap,
+    wait_until,
+)
+
+from .le_utils import LeAdvertiser, pair_le
+from .test_agent import test_agent_pair_bredr as pair_bredr
+
+pytestmark = [pytest.mark.vm]
+
+BUS_NAME = "org.bluez"
+PROPS_INTERFACE = "org.freedesktop.DBus.Properties"
+DEVICE_INTERFACE = "org.bluez.Device1"
+LE_INTERFACE = "org.bluez.Bearer.LE1"
+BREDR_INTERFACE = "org.bluez.Bearer.BREDR1"
+
+# The bearer interfaces are experimental
+CONF = "[General]\nExperimental = true\n"
+LE_CONF = CONF + "ControllerMode = le\n"
+
+# bluetoothd only creates device objects for advertisers that are
+# discoverable, which a broadcaster is not
+SCANNER_CONF = LE_CONF + "FilterDiscoverable = false\n"
+
+# Identifies the broadcast advertisement of host1 on host0, as it is sent
+# from a non-resolvable private address rather than from host1's address
+BROADCAST_UUID = "6e2c1d84-7a3b-4f50-9c1e-5b8d2a7f0e13"
+
+# The MIDI profile asks to pair as soon as it finds the MIDI service the
+# other host exports, which would need an agent reply in every test
+ARGS = ("-P", "midi")
+
+
+class Bearers(HostPlugin, EventPluginMixin):
+    """
+    Host plugin calling the bearer interfaces of remote devices, reading
+    their properties and recording their Disconnected signals.
+    """
+
+    name = "bearers"
+    depends = [Bluetoothd()]
+
+    @mainloop_wrap
+    def setup(self, impl):
+        EventPluginMixin.setup(self, impl)
+
+        self.log = logging.getLogger(self.name)
+        self.bus = get_dbus(private=True)
+        self.disconnected = []
+
+        self.bus.add_signal_receiver(
+            self._disconnected,
+            signal_name="Disconnected",
+            bus_name=BUS_NAME,
+            path_keyword="path",
+            interface_keyword="interface",
+        )
+
+    def _disconnected(self, reason, message, path=None, interface=None):
+        if interface not in (LE_INTERFACE, BREDR_INTERFACE):
+            return
+
+        self.log.info(f"{path} {interface}.Disconnected: {reason}")
+        self.disconnected.append((str(path), str(interface), str(reason)))
+
+    def _devices(self):
+        manager = dbus.Interface(
+            self.bus.get_object(BUS_NAME, "/"), "org.freedesktop.DBus.ObjectManager"
+        )
+
+        for path, ifaces in manager.GetManagedObjects().items():
+            device = ifaces.get(DEVICE_INTERFACE)
+            if device is not None:
+                yield str(path), device
+
+    def _device_path(self, address):
+        for path, device in self._devices():
+            if device["Address"].lower() == address.lower():
+                return path
+
+        return None
+
+    @mainloop_wrap
+    def find_address(self, uuid):
+        """
+        Return the address of the device advertising the given service
+        UUID, or None if there is none.
+        """
+        for path, device in self._devices():
+            if uuid in [str(u).lower() for u in device.get("UUIDs", [])]:
+                return str(device["Address"])
+
+        return None
+
+    @mainloop_wrap
+    def get(self, address, interface, name):
+        """
+        Return a bearer property of the device with the given address, or
+        None if the device, the bearer or the property is not there.
+        """
+        path = self._device_path(address)
+        if path is None:
+            return None
+
+        props = dbus.Interface(self.bus.get_object(BUS_NAME, path), PROPS_INTERFACE)
+        try:
+            value = props.Get(interface, name)
+        except dbus.exceptions.DBusException:
+            return None
+
+        if isinstance(value, dbus.Boolean):
+            return bool(value)
+
+        return str(value)
+
+    @mainloop_wrap
+    def call(self, address, interface, method):
+        """
+        Call a bearer method of the device with the given address.
+
+        Events:
+            Event(kind="{interface}.{method}:reply")
+        """
+        path = self._device_path(address)
+        bearer = dbus.Interface(self.bus.get_object(BUS_NAME, path), interface)
+        self._object_method(bearer, method)
+
+    @mainloop_wrap
+    def disconnect_reasons(self, address, interface):
+        """
+        Return the reasons of the Disconnected signals received on the
+        given bearer of the device with the given address, in order.
+        """
+        path = f"/org/bluez/hci0/dev_{address.upper().replace(':', '_')}"
+        return [r for p, i, r in self.disconnected if p == path and i == interface]
+
+
+le_config = host_config(
+    [
+        Bluetoothd(conf=LE_CONF, args=ARGS),
+        Agent(capability="NoInputNoOutput"),
+        Bearers(),
+    ],
+    [
+        Bluetoothd(conf=LE_CONF, args=ARGS),
+        LeAdvertiser(),
+        Agent(capability="NoInputNoOutput"),
+        Bearers(),
+    ],
+)
+
+bredr_config = host_config(
+    [Bluetoothd(conf=CONF, args=ARGS), Agent(), Bearers()],
+    [Bluetoothd(conf=CONF, args=ARGS), Agent(), Bearers()],
+)
+
+
+def start_discovery(host):
+    host.agent.adapter_method("StartDiscovery")
+    host.agent.expect("org.bluez.Adapter1.StartDiscovery:reply")
+
+
+def discover(host, remote):
+    start_discovery(host)
+    wait_until(host.agent.has_device, remote.bdaddr)
+
+
+def peers(host0, host1):
+    """Both hosts, each with the other"""
+    return ((host0, host1), (host1, host0))
+
+
+def disconnect(host0, host1, interface):
+    """
+    Disconnect the bearer from host0, and check it is reported as
+    disconnected on both hosts with the reason seen from each side.
+    """
+    host0.bearers.call(host1.bdaddr, interface, "Disconnect")
+    host0.bearers.expect(f"{interface}.Disconnect:reply")
+
+    for host, remote, reason in (
+        (host0, host1, "org.bluez.Reason.Local"),
+        (host1, host0, "org.bluez.Reason.Remote"),
+    ):
+        wait_until(
+            lambda: host.bearers.disconnect_reasons(remote.bdaddr, interface)
+            == [reason]
+        )
+        assert host.bearers.get(remote.bdaddr, interface, "Connected") is False
+
+
+@le_config
+def test_bearer_le_connect(hosts):
+    host0, host1 = hosts
+
+    discover(host0, host1)
+
+    host0.bearers.call(host1.bdaddr, LE_INTERFACE, "Connect")
+    host0.bearers.expect(f"{LE_INTERFACE}.Connect:reply")
+
+    for host, remote in peers(host0, host1):
+        wait_until(
+            lambda: host.bearers.get(remote.bdaddr, LE_INTERFACE, "Connected") is True
+        )
+
+    assert host0.bearers.get(host1.bdaddr, LE_INTERFACE, "Role") == "peripheral"
+    assert host1.bearers.get(host0.bdaddr, LE_INTERFACE, "Role") == "central"
+
+    disconnect(host0, host1, LE_INTERFACE)
+
+    for host, remote in peers(host0, host1):
+        assert host.bearers.get(remote.bdaddr, LE_INTERFACE, "Role") is None
+
+
+@host_config(
+    [Bluetoothd(conf=SCANNER_CONF, args=ARGS), Agent(), Bearers()],
+    # A broadcaster, so neither connectable nor discoverable
+    [
+        Bluetoothd(conf=LE_CONF, args=ARGS),
+        LeAdvertiser(
+            adv_type="broadcast",
+            service_uuids=[BROADCAST_UUID],
+            discoverable=False,
+        ),
+    ],
+)
+def test_bearer_le_not_connectable(hosts):
+    host0, host1 = hosts
+
+    start_discovery(host0)
+    wait_until(lambda: host0.bearers.find_address(BROADCAST_UUID) is not None)
+    address = host0.bearers.find_address(BROADCAST_UUID)
+
+    wait_until(
+        lambda: host0.bearers.get(address, LE_INTERFACE, "Connectable") is not None
+    )
+    assert host0.bearers.get(address, LE_INTERFACE, "Connectable") is False
+
+
+@le_config
+def test_bearer_le_connectable(hosts):
+    host0, host1 = hosts
+
+    discover(host0, host1)
+
+    wait_until(
+        lambda: host0.bearers.get(host1.bdaddr, LE_INTERFACE, "Connectable") is not None
+    )
+    assert host0.bearers.get(host1.bdaddr, LE_INTERFACE, "Connectable") is True
+
+
+@le_config
+def test_bearer_le_pair(hosts):
+    host0, host1 = hosts
+
+    pair_le(host0, host1)
+
+    for host, remote in peers(host0, host1):
+        for name in ("Paired", "Bonded", "Connected"):
+            wait_until(
+                lambda: host.bearers.get(remote.bdaddr, LE_INTERFACE, name) is True
+            )
+
+        assert host.bearers.get(remote.bdaddr, BREDR_INTERFACE, "Paired") is None
+
+
+@bredr_config
+def test_bearer_bredr_pair(hosts):
+    host0, host1 = hosts
+
+    pair_bredr(hosts, True)
+
+    for host, remote in peers(host0, host1):
+        for name in ("Paired", "Bonded", "Connected", "Connectable"):
+            wait_until(
+                lambda: host.bearers.get(remote.bdaddr, BREDR_INTERFACE, name) is True
+            )
+
+        # Role is only reported for LE
+        assert host.bearers.get(remote.bdaddr, BREDR_INTERFACE, "Role") is None
+
+    disconnect(host0, host1, BREDR_INTERFACE)
-- 
2.54.0 (Apple Git-157)

