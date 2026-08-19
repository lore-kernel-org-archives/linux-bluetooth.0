Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D7F3E5A0E
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 22:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787178754; cv=none; b=pa5a1kX7dw88mlfsIN85auZS2PtRgWJy+FocORYHqPDJfoD/NreT4pMVNKVjsm9MlDvCGROPt49Win10Zhn2bdJVAAc7RppKeFaeCaTJfC3LPZ+0QgrQ5Qtd0sVt+CQ6H0J2O3f9hJsdR+vXIlNUsWn+cpgkH+RYXfDVX4c2P4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787178754; c=relaxed/simple;
	bh=1l3rzexUaz7GEwh9WL9lNAsaMkmrqex5QQxTSANiOJU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JYgIXFVBbyqvSP4iO/OwbAuf1LLIZMeWJMKIVlzCcZk1bk/8ofF4MsHKenTAZz61Uqvh47rm+gS19eG6Dn28CYSzV23ffi2bDJZCCmkbaKm8luUJz2u6+0eiZM7wPmBstSPx5yhcW1B+EJMebLX7jcCMGUpNkn5iZXo7Hjymw6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=sKyAyGbO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="sKyAyGbO"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47f3b39f2a1so1311276f8f.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 15:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1787178748; x=1787783548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XAJ3y0IQAF6RPr3AbkojqwBygLtG2ZGhdO2MnqPV/sQ=;
        b=sKyAyGbOIXHVlAV3Vo8UlIHqxFWBTuiTnzPkHXaTzyvpYilrXiH3KsAl5wZaCgTN01
         qOsrA4x3Ups/LFl78/4pfK6Jl9FdL7OqGTwwgXOGJkvWOo85gJ+UxDHfc7qZLgbZhUki
         X6h4puM6pwZ6cC2qD0Y6ccS7NDnN2c979dQJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787178748; x=1787783548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XAJ3y0IQAF6RPr3AbkojqwBygLtG2ZGhdO2MnqPV/sQ=;
        b=JC9T9bLIW4me5pjbr/v08oj2BvmehAG1kbi/uSTbF38XZVAygi4izGwv9pzmHdc2RY
         29+wFm3J4oinsnJJUZ8amiy5Rz4XF9zdXItbxgoYmprsVD56CkSUA7Qmi9PVZX//uXOw
         VwFaFz+8b7q0ggAewFvSeWIItkoSHo3Kfxrhyku00jme+DiGh9t1exvdB+aIIP5LfdaJ
         OWda4uzW0OcpLqXQN/BzlmamnhSUssZXnkPz60ISwvxRt3Sz9OQRlRMZEdGeIbAD8FAf
         Qw0brhh3rQPPx/AOGUh2o/3D8a621ozx/joQkFSZaHNtavmTU4R++3tt2vx6g9/VWiM/
         RxMw==
X-Gm-Message-State: AFuF++nzAL+30JHH21js1mE6E161CnuOm/+QtlJBmLoT0Hp3ftlRblnG
	bFVnGvoMY10I9AcWzUbaOcomJXJ9cSwkumyhMFCEgBvaHnFh4t+lb5Cwvvk3nMX4XHiv1/ktCST
	X9/J4EWY=
X-Gm-Gg: AR+sD13BLjdpBbx8OZiORim+PzWndM6ACfIXHNfVk5eknvIAvgqd8pbzyVjNToUFBiY
	zdVc7xxo7aqjONduQ3uw4wPR4ID4wL+/PoFWBaXhYBQwXN7tgUvin1vSTawwH6hc7u2BJL7o4LJ
	avUTyaNibwmvox87hWBCmhqver8sU3YMhz2TDndMNLSgKPNqDMbwGmOcdqdszSEtI6Hrqw1eP/y
	GNT+UwO6cVwMyMFvtc20yz35oOA8AJg2cgRgdNmtOJIYKk711h4mgUFf7A++IKixVn8aLZQYYQq
	KsuPmFiK77U+ih4UI8LWkvP3dyuxbXWAPAChgG/752wnao1xG6BP0SYH03NyIFcbxpi2WxcD/It
	9U24XSp2knrAd+xVBuQaa8YaUoMiF4A/z8u0akZSplUcWg6h3cT83WuYmEizU9dWfyo+XtB1u2x
	LMHfT86A+EqBNuiD/fc54av17JMvwtSq76R8yrRPnW3ZwmSI21ZY/CUX04URXqJfXfYpSA8elBb
	pIA3Wl07Ig9rBelSGOWIrx2Qp8x44O0n2XMMHx7e4eC0bIm6p4Gbs2c81GvKULMlmc+M3t+9Jo5
	qenxwgBUZkRYzpN5yxhK2cHKR01VIgaRlXAsSX8hLl+QX97jPHlo1duN+SYc714q08xlXhiY5H+
	UWIruyjAETH51M7qkCmT/oaC0K6d77TI/YcJh
X-Received: by 2002:a05:6000:420f:b0:47f:e748:3ae3 with SMTP id ffacd0b85a97d-482b1e83a3cmr13522629f8f.3.1787178747658;
        Wed, 19 Aug 2026 15:32:27 -0700 (PDT)
Received: from mkurz-macbook-pro.fritz.box (2a02-8388-82c0-2a80-5231-6791-f21f-fc93.cable.dynamic.v6.surfer.at. [2a02:8388:82c0:2a80:5231:6791:f21f:fc93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14cf0a3sm8125296f8f.32.2026.08.19.15.32.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 15:32:27 -0700 (PDT)
From: Matthias Kurz <m.kurz@irregular.at>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] test: Add Fast Pair Message Stream tool
Date: Thu, 20 Aug 2026 00:31:44 +0200
Message-ID: <20260819223144.82045-5-m.kurz@irregular.at>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819223144.82045-1-m.kurz@irregular.at>
References: <20260819223144.82045-1-m.kurz@irregular.at>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a standalone profile client that prints Fast Pair Message Stream frames
and can optionally publish left, right, and case values through
BatteryProvider1.

Publish dynamic component lifecycle signals, scope providers per adapter,
and invalidate measurements when a stream closes. Warn users to disable the
built-in Fast Pair plugin when using the external profile.

Assisted-by: Codex:gpt-5.6-sol
---
 Makefile.tools     |   2 +-
 test/test-fastpair | 561 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 562 insertions(+), 1 deletion(-)
 create mode 100755 test/test-fastpair

diff --git a/Makefile.tools b/Makefile.tools
index b3ef4ae1c..630646aff 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -552,7 +552,7 @@ test_scripts += test/bluezutils.py \
 		test/test-discovery test/test-manager test/test-adapter \
 		test/test-device test/simple-agent \
 		test/simple-endpoint \
-		test/test-network test/test-profile \
+		test/test-network test/test-profile test/test-fastpair \
 		test/service-record.dtd \
 		test/service-did.xml test/service-spp.xml test/service-opp.xml \
 		test/service-ftp.xml test/simple-player test/test-nap \
diff --git a/test/test-fastpair b/test/test-fastpair
new file mode 100755
index 000000000..c6347c9ca
--- /dev/null
+++ b/test/test-fastpair
@@ -0,0 +1,561 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: LGPL-2.1-or-later
+
+import argparse
+import os
+import signal
+
+import dbus
+import dbus.mainloop.glib
+import dbus.service
+from gi.repository import GLib
+
+
+BLUEZ_SERVICE = "org.bluez"
+BATTERY_PROVIDER_INTERFACE = "org.bluez.BatteryProvider1"
+BATTERY_PROVIDER_MANAGER_INTERFACE = "org.bluez.BatteryProviderManager1"
+DEVICE_INTERFACE = "org.bluez.Device1"
+OBJECT_MANAGER_INTERFACE = "org.freedesktop.DBus.ObjectManager"
+PROFILE_INTERFACE = "org.bluez.Profile1"
+PROFILE_MANAGER_INTERFACE = "org.bluez.ProfileManager1"
+PROPERTIES_INTERFACE = "org.freedesktop.DBus.Properties"
+
+FAST_PAIR_MESSAGE_STREAM_UUID = "df21fe2c-2515-4fdb-8886-f12c4d67927c"
+PROFILE_PATH = "/org/bluez/test/fastpair_message_stream"
+BATTERY_PROVIDER_PATH = "/org/bluez/test/fastpair_batteries"
+
+DEVICE_INFORMATION_GROUP = 0x03
+BATTERY_UPDATE_CODE = 0x03
+BATTERY_UPDATE_LENGTH = 3
+
+COMPONENT_IDENTIFIERS = ("left", "right", "case")
+
+
+class InvalidArgsException(dbus.exceptions.DBusException):
+	_dbus_error_name = "org.freedesktop.DBus.Error.InvalidArgs"
+
+
+def decode_component(identifier, value):
+	percentage = value & 0x7f
+	level_valid = percentage <= 100
+	if not level_valid:
+		percentage = None
+
+	# Battery Notification retains the status bit for an unknown level.
+	# The TWS requirements separately define 0xff as invalid when the case
+	# level is unsupported. Reserved levels have no charging state.
+	case_unavailable = identifier == "case" and value == 0xff
+	status_valid = (level_valid or
+		((value & 0x7f) == 0x7f and not case_unavailable))
+	charging = bool(value & 0x80) if status_valid else None
+
+	return percentage, charging
+
+
+class BatteryComponent(dbus.service.Object):
+	def __init__(self, bus, provider_path, device, identifier):
+		device_name = device.rsplit("/", 1)[-1]
+		path = "%s/%s/battery_%s" % (
+			provider_path, device_name, identifier)
+		super().__init__(bus, path)
+		self.path = path
+		self.device = device
+		self.identifier = identifier
+		self.percentage = None
+		self.charging = None
+
+	def get_properties(self):
+		properties = {
+			"Device": dbus.ObjectPath(self.device),
+			"Identifier": self.identifier,
+			"Source": FAST_PAIR_MESSAGE_STREAM_UUID,
+		}
+
+		if self.percentage is not None:
+			properties["Percentage"] = dbus.Byte(self.percentage)
+
+		if self.charging is not None:
+			properties["Charging"] = dbus.Boolean(self.charging)
+
+		return {BATTERY_PROVIDER_INTERFACE: properties}
+
+	def update(self, value):
+		percentage, charging = decode_component(self.identifier, value)
+		changed = {}
+		invalidated = []
+
+		if self.percentage != percentage:
+			self.percentage = percentage
+			if percentage is None:
+				invalidated.append("Percentage")
+			else:
+				changed["Percentage"] = dbus.Byte(percentage)
+
+		if self.charging != charging:
+			self.charging = charging
+			if charging is None:
+				invalidated.append("Charging")
+			else:
+				changed["Charging"] = dbus.Boolean(charging)
+
+		if changed or invalidated:
+			self.PropertiesChanged(
+				BATTERY_PROVIDER_INTERFACE,
+				changed,
+				dbus.Array(invalidated, signature="s"))
+
+	def invalidate(self):
+		invalidated = []
+
+		if self.percentage is not None:
+			self.percentage = None
+			invalidated.append("Percentage")
+
+		if self.charging is not None:
+			self.charging = None
+			invalidated.append("Charging")
+
+		if invalidated:
+			self.PropertiesChanged(
+				BATTERY_PROVIDER_INTERFACE,
+				{}, dbus.Array(invalidated, signature="s"))
+
+	@dbus.service.method(PROPERTIES_INTERFACE, in_signature="s",
+					out_signature="a{sv}")
+	def GetAll(self, interface):
+		if interface != BATTERY_PROVIDER_INTERFACE:
+			raise InvalidArgsException()
+
+		return self.get_properties()[BATTERY_PROVIDER_INTERFACE]
+
+	@dbus.service.signal(PROPERTIES_INTERFACE, signature="sa{sv}as")
+	def PropertiesChanged(self, interface, changed, invalidated):
+		pass
+
+
+class AdapterBatteryProvider(dbus.service.Object):
+	def __init__(self, bus, adapter):
+		adapter_name = adapter.rsplit("/", 1)[-1]
+		self.path = "%s/%s" % (BATTERY_PROVIDER_PATH, adapter_name)
+		super().__init__(bus, self.path)
+		self.bus = bus
+		self.adapter = adapter
+		self.components = {}
+		self.registered = False
+		self.manager = dbus.Interface(
+			self.bus.get_object(BLUEZ_SERVICE, adapter),
+			BATTERY_PROVIDER_MANAGER_INTERFACE)
+
+	def add_device(self, device):
+		for identifier in COMPONENT_IDENTIFIERS:
+			key = (device, identifier)
+			if key in self.components:
+				continue
+
+			component = BatteryComponent(
+				self.bus, self.path, device, identifier)
+			self.components[key] = component
+			if self.registered:
+				self.InterfacesAdded(
+					dbus.ObjectPath(component.path),
+					component.get_properties())
+
+	def register(self):
+		self.registered = True
+
+		def registered():
+			print("Registered component battery provider on %s" %
+					self.adapter)
+
+		def failed(error):
+			self.registered = False
+			print("Battery provider registration failed on %s: %s" %
+					(self.adapter, error))
+
+		self.manager.RegisterBatteryProvider(
+			self.path,
+			reply_handler=registered,
+			error_handler=failed)
+
+	def update(self, device, payload):
+		if len(payload) != len(COMPONENT_IDENTIFIERS):
+			return
+
+		if (device, COMPONENT_IDENTIFIERS[0]) not in self.components:
+			self.add_device(device)
+
+		for identifier, value in zip(COMPONENT_IDENTIFIERS, payload):
+			self.components[(device, identifier)].update(value)
+
+	def invalidate(self, device):
+		for identifier in COMPONENT_IDENTIFIERS:
+			component = self.components.get((device, identifier))
+			if component:
+				component.invalidate()
+
+	def unregister(self):
+		for component in list(self.components.values()):
+			if self.registered:
+				self.InterfacesRemoved(
+					dbus.ObjectPath(component.path),
+					[BATTERY_PROVIDER_INTERFACE])
+			component.remove_from_connection()
+
+		self.components.clear()
+
+		if self.registered:
+			try:
+				self.manager.UnregisterBatteryProvider(self.path)
+			except dbus.exceptions.DBusException:
+				pass
+
+		self.registered = False
+		self.remove_from_connection()
+
+	@dbus.service.method(OBJECT_MANAGER_INTERFACE,
+					out_signature="a{oa{sa{sv}}}")
+	def GetManagedObjects(self):
+		return {
+			dbus.ObjectPath(component.path): component.get_properties()
+			for component in self.components.values()
+		}
+
+	@dbus.service.signal(OBJECT_MANAGER_INTERFACE,
+					signature="oa{sa{sv}}")
+	def InterfacesAdded(self, object_path, interfaces_and_properties):
+		pass
+
+	@dbus.service.signal(OBJECT_MANAGER_INTERFACE, signature="oas")
+	def InterfacesRemoved(self, object_path, interfaces):
+		pass
+
+
+class BatteryProvider:
+	def __init__(self, bus):
+		self.bus = bus
+		self.providers = {}
+
+	def add_device(self, device):
+		adapter = device.rsplit("/dev_", 1)[0]
+		provider = self.providers.get(adapter)
+		if provider:
+			provider.add_device(device)
+			return
+
+		provider = AdapterBatteryProvider(self.bus, adapter)
+		self.providers[adapter] = provider
+		provider.add_device(device)
+		provider.register()
+
+	def update(self, device, payload):
+		if len(payload) != len(COMPONENT_IDENTIFIERS):
+			return
+
+		adapter = device.rsplit("/dev_", 1)[0]
+		if adapter not in self.providers:
+			self.add_device(device)
+
+		self.providers[adapter].update(device, payload)
+
+	def invalidate(self, device):
+		adapter = device.rsplit("/dev_", 1)[0]
+		provider = self.providers.get(adapter)
+		if provider:
+			provider.invalidate(device)
+
+	def unregister(self):
+		for provider in self.providers.values():
+			provider.unregister()
+
+		self.providers.clear()
+
+
+def format_component(name, value):
+	percentage, charging = decode_component(name, value)
+
+	if percentage is None:
+		level = "unknown"
+	else:
+		level = "%d%%" % percentage
+
+	if charging is None:
+		status = " charging=unknown"
+	elif charging:
+		status = " charging"
+	else:
+		status = ""
+
+	return "%s=%s%s" % (name, level, status)
+
+
+class MessageStreamConnection:
+	def __init__(self, profile, device, fd):
+		self.profile = profile
+		self.device = device
+		self.fd = fd
+		self.buffer = bytearray()
+		self.watch = None
+
+		os.set_blocking(self.fd, False)
+		self.watch = GLib.io_add_watch(
+			self.fd,
+			GLib.IO_IN | GLib.IO_HUP | GLib.IO_ERR | GLib.IO_NVAL,
+			self._io_event)
+
+	def close(self):
+		if self.watch is not None:
+			GLib.source_remove(self.watch)
+			self.watch = None
+
+		if self.fd >= 0:
+			os.close(self.fd)
+			self.fd = -1
+
+		self.profile.connection_closed(self.device, self)
+
+	def _io_event(self, source, condition):
+		if condition & GLib.IO_IN:
+			try:
+				data = os.read(self.fd, 4096)
+			except BlockingIOError:
+				data = None
+			except OSError as error:
+				print("Read failed for %s: %s" % (self.device, error))
+				self.close()
+				return False
+
+			if data == b"":
+				print("Message Stream closed by %s" % self.device)
+				self.close()
+				return False
+
+			if data:
+				self.buffer.extend(data)
+				if not self._parse_frames():
+					self.close()
+					return False
+
+		if condition & (GLib.IO_HUP | GLib.IO_ERR | GLib.IO_NVAL):
+			print("Message Stream disconnected from %s" % self.device)
+			self.close()
+			return False
+
+		return True
+
+	def _parse_frames(self):
+		while len(self.buffer) >= 4:
+			group = self.buffer[0]
+			code = self.buffer[1]
+			payload_length = int.from_bytes(self.buffer[2:4], "big")
+
+			frame_length = 4 + payload_length
+			if len(self.buffer) < frame_length:
+				return True
+
+			payload = bytes(self.buffer[4:frame_length])
+			del self.buffer[:frame_length]
+			self._handle_frame(group, code, payload)
+
+		return True
+
+	def _handle_frame(self, group, code, payload):
+		hex_payload = " ".join("%02x" % byte for byte in payload)
+		print("Message group=0x%02x code=0x%02x length=%d payload=%s" %
+				(group, code, len(payload), hex_payload))
+
+		if group != DEVICE_INFORMATION_GROUP or code != BATTERY_UPDATE_CODE:
+			return
+
+		if len(payload) != BATTERY_UPDATE_LENGTH:
+			print("Invalid battery update length: %d" % len(payload))
+			return
+
+		components = (
+			format_component("left", payload[0]),
+			format_component("right", payload[1]),
+			format_component("case", payload[2]),
+		)
+		print("Battery update: %s" % ", ".join(components))
+		self.profile.update_batteries(self.device, payload)
+
+
+class FastPairProfile(dbus.service.Object):
+	def __init__(self, bus, mainloop, battery_provider=None):
+		super().__init__(bus, PROFILE_PATH)
+		self.mainloop = mainloop
+		self.battery_provider = battery_provider
+		self.connections = {}
+
+	@dbus.service.method(PROFILE_INTERFACE, in_signature="", out_signature="")
+	def Release(self):
+		print("Profile released")
+		self.close_all()
+		self.mainloop.quit()
+
+	@dbus.service.method(PROFILE_INTERFACE, in_signature="", out_signature="")
+	def Cancel(self):
+		print("Connection cancelled")
+
+	@dbus.service.method(PROFILE_INTERFACE, in_signature="oha{sv}",
+					out_signature="")
+	def NewConnection(self, device, fd, properties):
+		device = str(device)
+		raw_fd = fd.take()
+
+		if device in self.connections:
+			self.connections[device].close()
+
+		print("Message Stream connected to %s" % device)
+		self.connections[device] = MessageStreamConnection(
+			self, device, raw_fd)
+
+	@dbus.service.method(PROFILE_INTERFACE, in_signature="o",
+					out_signature="")
+	def RequestDisconnection(self, device):
+		device = str(device)
+		print("Disconnect requested for %s" % device)
+
+		connection = self.connections.get(device)
+		if connection:
+			connection.close()
+
+	def connection_closed(self, device, connection):
+		if self.connections.get(device) is connection:
+			del self.connections[device]
+			if self.battery_provider:
+				self.battery_provider.invalidate(device)
+
+	def update_batteries(self, device, payload):
+		if self.battery_provider:
+			self.battery_provider.update(device, payload)
+
+	def close_all(self):
+		for connection in list(self.connections.values()):
+			connection.close()
+
+
+def find_devices(bus):
+	manager = dbus.Interface(bus.get_object(BLUEZ_SERVICE, "/"),
+				OBJECT_MANAGER_INTERFACE)
+	objects = manager.GetManagedObjects()
+	devices = []
+
+	for path, interfaces in objects.items():
+		properties = interfaces.get(DEVICE_INTERFACE)
+		if not properties:
+			continue
+
+		uuids = [str(uuid).lower() for uuid in properties.get("UUIDs", [])]
+		if FAST_PAIR_MESSAGE_STREAM_UUID not in uuids:
+			continue
+
+		devices.append((str(path), str(properties.get("Alias", path))))
+
+	return devices
+
+
+def connect_profile(bus, device_path):
+	device = dbus.Interface(bus.get_object(BLUEZ_SERVICE, device_path),
+				DEVICE_INTERFACE)
+
+	def connected():
+		print("ConnectProfile completed")
+
+	def failed(error):
+		print("ConnectProfile failed: %s" % error)
+
+	device.ConnectProfile(FAST_PAIR_MESSAGE_STREAM_UUID,
+			reply_handler=connected, error_handler=failed)
+	return True
+
+
+def parse_args():
+	parser = argparse.ArgumentParser(
+		description="Inspect Google Fast Pair Message Stream battery updates",
+		epilog="Disable bluetoothd's built-in fastpair plugin with "
+			"-P fastpair before using this external profile against an "
+			"experimental daemon.")
+	parser.add_argument(
+		"--connect",
+		metavar="DEVICE_PATH",
+		help="actively connect the profile on a BlueZ Device1 object")
+	parser.add_argument(
+		"--no-auto-connect",
+		action="store_true",
+		help="do not connect automatically when a matching device connects")
+	parser.add_argument(
+		"--publish-batteries",
+		action="store_true",
+		help="publish left, right, and case through BatteryProvider1")
+	return parser.parse_args()
+
+
+def main():
+	args = parse_args()
+
+	dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
+	bus = dbus.SystemBus()
+	mainloop = GLib.MainLoop()
+	devices = find_devices(bus)
+	battery_provider = BatteryProvider(bus) if args.publish_batteries else None
+
+	if battery_provider:
+		if args.connect:
+			battery_device = args.connect
+		elif len(devices) == 1:
+			battery_device = devices[0][0]
+		else:
+			print("--publish-batteries needs --connect when the cached "
+			      "device is not unique")
+			return 1
+
+		battery_provider.add_device(battery_device)
+
+	profile = FastPairProfile(bus, mainloop, battery_provider)
+	manager = dbus.Interface(bus.get_object(BLUEZ_SERVICE, "/org/bluez"),
+				PROFILE_MANAGER_INTERFACE)
+
+	options = {
+		"Name": "Fast Pair Message Stream battery probe",
+		"Role": "client",
+		"AutoConnect": dbus.Boolean(not args.no_auto_connect),
+		"RequireAuthentication": dbus.Boolean(True),
+	}
+	manager.RegisterProfile(PROFILE_PATH, FAST_PAIR_MESSAGE_STREAM_UUID,
+				options)
+
+	print("Registered Fast Pair Message Stream profile")
+	print("Ensure bluetoothd's built-in fastpair plugin is disabled with "
+	      "-P fastpair")
+	if devices:
+		print("Cached devices supporting the profile:")
+		for path, alias in devices:
+			print("  %s: %s" % (alias, path))
+	else:
+		print("No cached device advertises the Message Stream UUID")
+
+	if args.connect and not connect_profile(bus, args.connect):
+		return 1
+
+	def stop(signum, frame):
+		mainloop.quit()
+
+	signal.signal(signal.SIGINT, stop)
+	signal.signal(signal.SIGTERM, stop)
+
+	try:
+		mainloop.run()
+	finally:
+		profile.close_all()
+		if battery_provider:
+			battery_provider.unregister()
+		try:
+			manager.UnregisterProfile(PROFILE_PATH)
+		except dbus.exceptions.DBusException:
+			pass
+
+	return 0
+
+
+if __name__ == "__main__":
+	raise SystemExit(main())
-- 
2.55.0

