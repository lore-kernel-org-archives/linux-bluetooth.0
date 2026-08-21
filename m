Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A3485CFB
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328522; cv=none; b=hPBklWkllLVQ4SFrNHPmZFJjLLpO03N7w8Twz8idjPgl9X4klod3Bg527lQyn7fDC+3GnspGaqgrrAAkGfJkhjlhTlDHgnZXmtk1swfIUXrmsvYkw2fEqRwz9ZjpyfHuD3ClQ2Xg/ce9v4GIYgHxm5RrHfC9yw9hiK90BnYHdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328522; c=relaxed/simple;
	bh=gLI0c01tvfBMusdahTF8z76GMzJHYOgB6k3n9zcGvvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=omegHkjzsn5lpTTWsJJjh7bxwjIiF9B35TtAJBxRML8skXA2LRHDw/SCtNwQomR6yLRT2MUrz7pC8uR5/Ttg6Gd8XI+piAHK3zEsGJIot9k63A0/sICz7llPojW4E5SL2YXbhMM5vSPaX1M4wtLUADGALQMvatFS1K8RF8kujiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at; spf=pass smtp.mailfrom=irregular.at; dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b=rcynJzCv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irregular.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irregular.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=irregular.at header.i=@irregular.at header.b="rcynJzCv"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1670dad7a8so216340366b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 09:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=irregular.at; s=google; t=1787328518; x=1787933318; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UxP5KDIrQXDInt7WeS5KfmBS2/pmMjg/HsQEYEZPm4c=;
        b=rcynJzCvCSXTLerGt/xKiXY07VuaOZyFpVzzvRupXD+SLxylpNDOrf9qTO6RfBxXu8
         PsDCEWRPNocb5bF4cqwJG0aReq8E1C4bbEuP1ax/bAs+oUtRhASVu+GcIGEZidZagUVI
         tef62BLlaGzFfF8Sil411Y1bQEfNpJzuQ0HfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787328518; x=1787933318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UxP5KDIrQXDInt7WeS5KfmBS2/pmMjg/HsQEYEZPm4c=;
        b=TnNmQ6VU+poq8Mb1N06dllHMvmvfWNzLoL5Aai23FKmUWdRQHvfFUBZr1sevW2mlfD
         Opye4xgDuJbNYjug9YlIawi3cOoyRl7FoQ0W/1LKKQknDoEzaubRqHC45X6xRK2561gQ
         aOEuGqVxG2k5XEyYgrFhNuNJQ6za5RAWFff7FGF9A0vrLgG8zO01VeVnbE4vscUt4bcH
         LLedui/X7uqxMequQG0Iv1k5T9kSIfTj+LDhbPiogpDNgdhP4pxx971WmTcvTesxeoWL
         XG/+u0G0oD0P4GJ6Zg24tocyaEvf/j38aJaN+VJzKv502pU7Kw4oYnjiVklFeot9/cx9
         kkjg==
X-Gm-Message-State: AFuF++kkxAdCj2G/JTDqNM9720frBmn4Wh0m2lr0ovrBekuxdD71jPQO
	N7IWbVQI6sZk5+pPIOcRouPE5+JavQ8tNYwVSHWH6MQSJ4LqSrEw/69Tcc5Px1d5rqXurzLhldI
	qHPD/6yw=
X-Gm-Gg: AR+sD12HmDSbjn6CK1srzJx6ZfrMnxndpCWbqtW8ys/fV44qDXfhIJRwv+2hggAf/OL
	0uzBIQUrr2knDw+CiWfeOcFla8OfHXo92cNpc6AyNcdmWYCXVXT19hAt+0y42Q9Wuh6BD7XIYYW
	hHk5jCOSRuWoKA2gJR+KyWfE7XBxyFKE8FIyVdXIWkbwKAXt0+M5X0Et/koQQtSUD4qDgJ6X2PT
	yPSPwmn7NsM0f6gQXrxnlXQfciKf3ajOG6Xbu7Iq4cFLdV2Tm88GaXaJf+fPQIKg5MfvhvQY4nC
	L4cvpuxsX7x6Sf5HbGreV9vZwBM1AedOOkJ1tMZWaOj/hz/s8wlD5XEfgEEHQ/9L0R9fvuidQir
	7ZTI2MIoUBYunvoYQhc6eT31LjqNcfgHxnXjI3p2W4EJcFtJA8l+7s3xd1YpqAerW3oes933iaO
	UjPqDv9w2G+wMafm3ArP/0OjQW+PllfdiSn71VZSuH/zcvpzVOyYw8U4wDmM/Y8SofeMlLbwn+M
	CM/D6UVrhUX7Ynrj4IyP+Yxxr7vjsP+/P9fJJ3CC1N3MPwLByMJTi3NehvJgMwUW03k3z0R+k3E
	YipgRM/9UKabiPTTkV4YrGMl1BbCsARHTlFXShpUMaC+RmkYxDAsTQbvBSnxjTBa+NXYgTr4dYW
	MLPQBEd4lqHIloqIsZ/CrUzeOZCq4aZw1XPMTdZes+8T4w4g=
X-Received: by 2002:a17:907:3cc2:b0:c21:180c:d82d with SMTP id a640c23a62f3a-c246a725749mr782935566b.20.1787328517979;
        Fri, 21 Aug 2026 09:08:37 -0700 (PDT)
Received: from mkurz-macbook-pro.fritz.box (2a02-8388-82c0-2a80-5231-6791-f21f-fc93.cable.dynamic.v6.surfer.at. [2a02:8388:82c0:2a80:5231:6791:f21f:fc93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24591df29esm471299366b.47.2026.08.21.09.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 09:08:37 -0700 (PDT)
From: Matthias Kurz <m.kurz@irregular.at>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH BlueZ v2 4/4] test: Add Fast Pair Message Stream tool
Date: Fri, 21 Aug 2026 18:08:03 +0200
Message-ID: <db68c5aacb63a032720877e2f54c3a2c1104cc35.1787327795.git.m.kurz@irregular.at>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787327795.git.m.kurz@irregular.at>
References: <cover.1787327795.git.m.kurz@irregular.at>
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
 test/test-fastpair | 568 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 569 insertions(+), 1 deletion(-)
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
index 000000000..9db85a122
--- /dev/null
+++ b/test/test-fastpair
@@ -0,0 +1,568 @@
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
+BATTERY_LEVEL_MASK = 0x7f
+BATTERY_CHARGING_MASK = 0x80
+BATTERY_LEVEL_MAX = 100
+BATTERY_LEVEL_UNKNOWN = BATTERY_LEVEL_MASK
+BATTERY_CASE_UNAVAILABLE = 0xff
+
+COMPONENT_IDENTIFIERS = ("left", "right", "case")
+
+
+class InvalidArgsException(dbus.exceptions.DBusException):
+	_dbus_error_name = "org.freedesktop.DBus.Error.InvalidArgs"
+
+
+def decode_component(identifier, value):
+	percentage = value & BATTERY_LEVEL_MASK
+	level_valid = percentage <= BATTERY_LEVEL_MAX
+	if not level_valid:
+		percentage = None
+
+	# Battery Notification retains the status bit for an unknown level.
+	# The TWS requirements separately define 0xff as invalid when the case
+	# level is unsupported. Reserved levels have no charging state.
+	case_unavailable = (identifier == "case" and
+		value == BATTERY_CASE_UNAVAILABLE)
+	status_valid = (level_valid or
+		((value & BATTERY_LEVEL_MASK) == BATTERY_LEVEL_UNKNOWN and
+		 not case_unavailable))
+	charging = bool(value & BATTERY_CHARGING_MASK) if status_valid else None
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

