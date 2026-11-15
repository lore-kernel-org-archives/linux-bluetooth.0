Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794726592;
	b=WgBKw40Da5l3lL9XMBKt5CNvkPGN2wtNuGPdVSz7Q1TviwnlmQBDaFs7sSMU6djHaXAf
	 ucSVExaKMZenJAOgq1QsGd+X1JY+IYMlcZJzJU4cTDoc+wyg34ZTI1NFJuvWiz5x1KWyU
	 FY8zzUTsXRfgb1AxC4WWJXjzbCZ7w509AaoBivAuruV6v3H42T7R7PNwMu+XeUMQf/Ojq
	 JMO2xbdsNrAwdvfutOlZkNQT6b4swrYTFmT3i5CKYx1hDDx7XgndoHXkeNYauFSM9VQBk
	 l7/zxPqlSkLV0ObkfRKmA5mSfbdK5AO4F2AY6ktxxxOSJZZBS5SjLPVgh/Oefpr+FiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794726592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uBLzkq0sfdjElKI2azDbJASTVB8haM5Yuxloh62ZCgY=;
	b=thnLDAf2pN60g/XHfGI9pltD98F+mXe7g1vjVoMvK0firRYG2d/maTx5qgivJxjBB8aa
	 /yvt7gegLCn7JWq7P14n1Su5p75S3ukhLAo+AFlfZXxBPCa565HskzGILwRuJAttkKEaM
	 Hq8T4axxMczIzpxUcqXoFrayIToHdWtJfelvOZB9Nxeu8WN2eUB8fxAwwCdsgFXWKC+PC
	 HRQg8m3D24aFXrBEhhZe2hEjl9CFHRXIYycbx+y3yy9V01x9RrEd00yb2mkrg7VxVfiAE
	 aMsYTUfPjYFPsLh/N7hTTiYJyelXAGIKoXq3PRjUpOWvXmTQSw/l/jtL5AWT6UahEew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q8i3ianu;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BBC606A329
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 07:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0BBC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q8i3ianu
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7cc013095d4so687566137.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 23:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794726591; x=1795331391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBLzkq0sfdjElKI2azDbJASTVB8haM5Yuxloh62ZCgY=;
        b=Q8i3ianuolOrf57vMQgmg5mXLEZ6cZqpopivgQvyn9XBuTvPyWeCxONJzisqp3QGh8
         20CLf9xp11mbTfv9V0e70UOIIOWwlcQa07TZpnIjJNL6/VV4y3qe7PoNiz2XloTX8nqF
         SfE2s8/0R4n5AR3ecyMT0ZxFwdcoC9kQ7C76QS6xvTUR+8g9+cNcYxk8jHCzYBU4Min5
         4hQ8p2zWM9bSaZG7ti4G4k56dY6Tb4VAapja95kDP3z2cS2RpNCtwVGhmaNoaUJCNS5S
         peYdIioHZ0HNldAivjnPBiDHX+lMkEWSKs8r2oN8LueZf8K6mi4fVcqEWBGnGY9mUyk7
         H3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794726591; x=1795331391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uBLzkq0sfdjElKI2azDbJASTVB8haM5Yuxloh62ZCgY=;
        b=YKbkO1ZV5KeaQ3GYJQy8DEZqhOGmpZLev5oc1VwNEh2y4e8v8cxpj7tPUZULQpJFJs
         5JWCUePtcSZge6TK+EjrQzW1vaKOc3h2W0SFd3BBfWzOJgAvnvYHJlz9uM2cXtlWWKBS
         s3aJrFxChkCLay8KUv5YLxTPusieCELmzNc9N6SzP77DrZ7vyHYUU2FKLcBIG5KM6z2j
         dIRnJH2DSoOS0Xc9RO6tz9AHRnMcBHxnqxlz2zRZUEJk3zb1SKapGNenU8CMqyI6Wtzk
         v7XUzoVgCF1eph59rCfbSYJ/t2psEbMwRyf/oTQk+j9PKILkdTRKfoWWYHlFwRL8iqwq
         0BiQ==
X-Gm-Message-State: APuU4Z91/L+43Tdrzr5FmJ9/zCRA4LLUW+CZ8q9Cmh/Sa4I+UbN+alGb
	c9ZStBua4Yl1KcAWGgvzyT1fCb95jhYgTE8eFWZL4gCs8HkFwbEfftkafqiu4RVZ
X-Gm-Gg: AYBFou1R1Z4FxXpGk7O35NPT/JPv53Wv3i89LyPDj/YUuGNAU88mNItcHO62vEO9rP5
	iXwmCgpNPb0IpqR9LCErOTeTJh3+DUD/bCYZ6CM/YvNhQXYXjMAmzG6leaustNrU7mPoqhBh45e
	KKLIfzrl6ODsJFfyB6Z47ZXVSIqU5eCpYdgpR8yYcCgWH+xOi0g+o0mvvBATJPalAXG7tM1VMbA
	wtcePCuNbt5mIy94xIvHfoFR/vOVbz+da4Xz0eCrDwi+X6oblQVsCzdUKupTCT702Zhb9kMCCtj
	CEqr0loqyznFLMeGHMIw2bHSL4rQZpQQLEkbWGpCzZpLOCGyXamYULxHDDC6j5YeApBlhVosW88
	frb3d802TuykTirIkjB3vsE29LdINOIDYRkRPs/4n8pkCuzVw5wHHPnqlKiC1xER3SLpIYlz+Ts
	Lg7H6mBL8zjGohzLrnkEq7o4i/p9Qyz8PyFaIHG6VMHtSUYpKy9+hl1ps33Q95bAF4spy+ZIHQt
	lUlnCd6nZ+6CibmlIfUhacuul0vFVFsJmuychKsGJwpZOARXmr6czUVqfDN6N/hoRQsnXsWFR1J
	NNLbnaMxDhLnOEEsCz4oIz7Iql2QtmIzKpoW0US45yT43N1IDx55Sz5RH1Y++JjNp0AiECW6Ni2
	ppFFgYCycAVNp97wPdnZ6NyMKobAybToBFGKDzbTv
X-Received: by 2002:a05:6102:2c82:b0:7cc:2152:4f79 with SMTP id ada2fe7eead31-7d64d75729emr2222633137.16.1794726590359;
        Sat, 14 Nov 2026 23:09:50 -0800 (PST)
Received: from fishcake-omen-transcend.uwaterloo.ca (wn-res-nat-129-97-125-18.dynamic.uwaterloo.ca. [129.97.125.18])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64c4b47aesm4580080137.7.2026.11.14.23.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:09:49 -0800 (PST)
From: Muxian Li <muxianli5401@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Muxian Li <muxianli5401@gmail.com>
Subject: [PATCH BlueZ 2/2] test: functional: Cover SDP records without handle
Date: Sun, 15 Nov 2026 02:00:55 -0500
Message-ID: <20261115070055.45999-2-muxianli5401@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115070055.45999-1-muxianli5401@gmail.com>
References: <20261115070055.45999-1-muxianli5401@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make host1 answer SDP like a Nintendo Switch 2, whose records lack the
ServiceRecordHandle attribute. Check that bluetoothd on host0 keeps
and caches each record once, also when a record is returned by both of
its searches.

Assisted-by: Claude:claude-opus-5-5
---
 doc/functional-testing.rst  |  48 ++++++++
 test/functional/test_sdp.py | 239 ++++++++++++++++++++++++++++++++++++
 2 files changed, 287 insertions(+)
 create mode 100644 test/functional/test_sdp.py

diff --git a/doc/functional-testing.rst b/doc/functional-testing.rst
index 371258261..fd8760d8e 100644
--- a/doc/functional-testing.rst
+++ b/doc/functional-testing.rst
@@ -237,6 +237,54 @@ test_btmgmt_info
 :Notes: Skipped if `btmgmt` is not built. Checks the mgmt interface is
 	usable without a daemon.
 
+test_sdp.py
+===========
+
+test_sdp_records_without_handle[switch2]
+----------------------------------------
+
+:Setup: Two hosts. host0 runs `bluetoothd` with an agent. host1 runs no
+	`bluetoothd`: `btmgmt` makes it connectable and discoverable, and it
+	answers SDP on PSM 1 itself with the records of a Nintendo Switch 2,
+	none of which has the ServiceRecordHandle attribute.
+
+	.. code-block::
+
+		+--------------------+                 +--------------------+
+		| host0              |      BR/EDR     | host1              |
+		| bluetoothd, agent  | --------------> | SDP server, PSM 1  |
+		| discovers, browses |                 | no bluetoothd      |
+		+--------------------+                 +--------------------+
+
+:Steps:
+	1. host0 calls ``org.bluez.Adapter1.StartDiscovery`` until it has a
+	   device object for host1, then ``StopDiscovery``.
+	2. host0 calls ``org.bluez.Device1.Connect``, which browses the SDP
+	   records of host1.
+	3. Wait until ``org.bluez.Device1.UUIDs`` of host1 contains the Audio
+	   Source UUID of its first record.
+
+:Expected:
+	1. ``UUIDs`` also contains the A/V Remote Control Target, A/V Remote
+	   Control and PnP Information UUIDs of the other records.
+	2. The cache file of host1 in the state directory of host0 holds
+	   each of the 4 records once.
+
+:Notes: Records without a handle all keep the 0xffffffff placeholder, so
+	a duplicate check that compares handles only keeps the first record
+	and drops the others, and records cached under their handle
+	overwrite each other. Skipped if `btmgmt` is not built.
+
+test_sdp_records_without_handle[duplicate]
+------------------------------------------
+
+:Setup: As above, but host1 also returns the PnP Information record for
+	the L2CAP search, so host0 receives it from both of its searches.
+
+:Steps: As above.
+
+:Expected: As above: the PnP Information record is cached once.
+
 test_adv_monitor.py
 ===================
 
diff --git a/test/functional/test_sdp.py b/test/functional/test_sdp.py
new file mode 100644
index 000000000..47bf5389c
--- /dev/null
+++ b/test/functional/test_sdp.py
@@ -0,0 +1,239 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for the bluetoothd SDP client using VM instances
+"""
+
+import configparser
+import glob
+import os
+import socket
+import struct
+import subprocess
+import threading
+
+import dbus
+import pytest
+
+from pytest_bluezenv import (
+    host_config,
+    Agent,
+    HostPlugin,
+    find_exe,
+    run,
+    wait_until,
+    mainloop_wrap,
+    get_dbus,
+)
+
+pytestmark = [pytest.mark.vm]
+
+SDP_PSM = 0x0001
+SDP_SVC_SEARCH_ATTR_REQ = 0x06
+SDP_SVC_SEARCH_ATTR_RSP = 0x07
+L2CAP_UUID = 0x0100
+PNP_INFO_UUID = 0x1200
+
+# Attribute lists sent by a Nintendo Switch 2 for the L2CAP and PnP searches
+# of bluetoothd, over the full attribute range. None of its records has the
+# ServiceRecordHandle attribute (0x0000).
+SWITCH2_RECORDS = {
+    L2CAP_UUID: bytes.fromhex(
+        "36009c"
+        # Audio Source
+        "360030090001350319110a090004351035061901000900193506190019090103"
+        "0900093508350619110d090104090311090000"
+        # A/V Remote Control, A/V Remote Control Controller
+        "360033090001350619110e19110f090004351035061901000900173506190017"
+        "0901040900093508350619110e090106090311090002"
+        # A/V Remote Control Target
+        "360030090001350319110c090004351035061901000900173506190017090104"
+        "0900093508350619110e090106090311090001"
+    ),
+    PNP_INFO_UUID: bytes.fromhex(
+        "36002e"
+        "36002b0900013503191200090200090103090201090553090202092060090203"
+        "0901000902042801090205090001"
+    ),
+}
+
+
+def search_uuids(params):
+    """UUID16 values of the ServiceSearchPattern of a request"""
+    if params[0] == 0x35:
+        size, pos = params[1], 2
+    elif params[0] == 0x36:
+        size, pos = struct.unpack(">H", params[1:3])[0], 3
+    else:
+        return set()
+
+    pattern = params[pos : pos + size]
+    return {
+        struct.unpack(">H", pattern[i + 1 : i + 3])[0]
+        for i in range(0, len(pattern) - 2, 3)
+        if pattern[i] == 0x19
+    }
+
+
+def search_attr_rsp(tid, attr_lists):
+    params = struct.pack(">H", len(attr_lists)) + attr_lists + b"\x00"
+    return struct.pack(">BHH", SDP_SVC_SEARCH_ATTR_RSP, tid, len(params)) + params
+
+
+class Switch2SdpServer(HostPlugin):
+    """
+    SDP server without bluetoothd that answers Service Search Attribute
+    requests with the records of a Nintendo Switch 2.
+    """
+
+    name = "switch2_sdp"
+
+    def presetup(self, config):
+        try:
+            self.btmgmt = find_exe("tools", "btmgmt")
+        except FileNotFoundError as exc:
+            pytest.skip(reason=f"btmgmt: {exc!r}")
+
+    def setup(self, impl):
+        self.records = dict(SWITCH2_RECORDS)
+
+        for cmd in (("connectable", "on"), ("power", "on"), ("discov", "yes")):
+            run(
+                [self.btmgmt, "--index", "0", *cmd],
+                check=True,
+                stdin=subprocess.DEVNULL,
+            )
+
+        self.sock = socket.socket(
+            socket.AF_BLUETOOTH, socket.SOCK_SEQPACKET, socket.BTPROTO_L2CAP
+        )
+        self.sock.bind((socket.BDADDR_ANY, SDP_PSM))
+        self.sock.listen(1)
+        threading.Thread(target=self.serve, daemon=True).start()
+
+    def serve(self):
+        while True:
+            try:
+                conn, _ = self.sock.accept()
+            except OSError:
+                return
+
+            with conn:
+                self.answer(conn)
+
+    def answer(self, conn):
+        while True:
+            try:
+                pdu = conn.recv(1024)
+            except OSError:
+                return
+
+            if not pdu:
+                return
+
+            if len(pdu) < 6 or pdu[0] != SDP_SVC_SEARCH_ATTR_REQ:
+                continue
+
+            tid = struct.unpack(">H", pdu[1:3])[0]
+            attr_lists = b"\x35\x00"
+            for uuid in search_uuids(pdu[5:]):
+                attr_lists = self.records.get(uuid, attr_lists)
+
+            conn.send(search_attr_rsp(tid, attr_lists))
+
+    def answer_pnp_in_l2cap_search(self):
+        """
+        Also return the PnP Information record for the L2CAP search, so
+        that bluetoothd gets it from both of its searches.
+        """
+        l2cap = self.records[L2CAP_UUID][3:]
+        pnp = self.records[PNP_INFO_UUID][3:]
+        self.records[L2CAP_UUID] = (
+            struct.pack(">BH", 0x36, len(l2cap) + len(pnp)) + l2cap + pnp
+        )
+
+    def teardown(self):
+        self.sock.close()
+
+
+@mainloop_wrap
+def device_uuids(address):
+    bus = get_dbus()
+    manager = dbus.Interface(
+        bus.get_object("org.bluez", "/"), "org.freedesktop.DBus.ObjectManager"
+    )
+
+    for ifaces in manager.GetManagedObjects().values():
+        device = ifaces.get("org.bluez.Device1")
+        if device is not None and device["Address"].lower() == address.lower():
+            return [str(uuid) for uuid in device.get("UUIDs", [])]
+
+    return []
+
+
+@mainloop_wrap
+def bluetoothd_state_directory():
+    """State directory of the bluetoothd that owns org.bluez"""
+    bus = get_dbus()
+    bus_daemon = dbus.Interface(
+        bus.get_object("org.freedesktop.DBus", "/org/freedesktop/DBus"),
+        "org.freedesktop.DBus",
+    )
+    pid = bus_daemon.GetConnectionUnixProcessID("org.bluez")
+
+    with open(f"/proc/{pid}/environ", "rb") as f:
+        env = dict(var.split(b"=", 1) for var in f.read().split(b"\0") if b"=" in var)
+
+    # Set by the Bluetoothd plugin; src/textfile.c uses its first path
+    return env[b"STATE_DIRECTORY"].split(b":")[0].decode()
+
+
+def cached_records(address):
+    """Service records in the cache file bluetoothd keeps for a device"""
+    state_dir = bluetoothd_state_directory()
+    paths = glob.glob(os.path.join(state_dir, "*", "cache", address.upper()))
+    assert len(paths) == 1, paths
+
+    cache = configparser.ConfigParser(interpolation=None)
+    cache.optionxform = str
+    cache.read(paths[0])
+
+    if not cache.has_section("ServiceRecords"):
+        return []
+
+    return list(cache["ServiceRecords"].values())
+
+
+@host_config([Agent()], [Switch2SdpServer()])
+@pytest.mark.parametrize("duplicate", [False, True], ids=["switch2", "duplicate"])
+def test_sdp_records_without_handle(hosts, duplicate):
+    host0, host1 = hosts
+
+    if duplicate:
+        host1.switch2_sdp.answer_pnp_in_l2cap_search()
+
+    host0.agent.adapter_method("StartDiscovery")
+    host0.agent.expect("org.bluez.Adapter1.StartDiscovery:reply")
+
+    wait_until(host0.agent.has_device, host1.bdaddr)
+
+    host0.agent.adapter_method("StopDiscovery")
+    host0.agent.expect("org.bluez.Adapter1.StopDiscovery:reply")
+
+    # Connecting browses the SDP records of host1; host1 offers no profile
+    # to connect, so the result of Connect itself does not matter.
+    host0.agent.device_method(host1.bdaddr, "Connect")
+
+    # All UUIDs of a browse are added at once
+    audio_source = "0000110a-0000-1000-8000-00805f9b34fb"
+    wait_until(lambda: audio_source in host0.call(device_uuids, host1.bdaddr))
+
+    uuids = host0.call(device_uuids, host1.bdaddr)
+    assert "0000110c-0000-1000-8000-00805f9b34fb" in uuids
+    assert "0000110e-0000-1000-8000-00805f9b34fb" in uuids
+    assert "00001200-0000-1000-8000-00805f9b34fb" in uuids
+
+    # Each record is cached once, also the PnP record received twice
+    records = host0.call(cached_records, host1.bdaddr)
+    assert len(records) == 4
+    assert len(set(records)) == 4
-- 
2.53.0

