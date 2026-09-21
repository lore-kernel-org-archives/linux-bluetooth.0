Received: from mail-vs2-f16.google.com (mail-vs2-f16.google.com [74.125.227.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C303D4E73BA
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 21:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790024514; cv=none; b=BCeH+3CT8xEDjjiXUoMH599hCPYclQtrNJRfXrDKOdO+xDMBOJxtfPaLpLInzAx/MWs6cGTAqQKk2BHlBMPPT0uXLMc8OsRIDnQF54GZNw2c41kh0YIafwlGBGg5BNzV8OxB+ORjSS6Kj0YfItCCqfDH+yi1osUvl317adysDyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790024514; c=relaxed/simple;
	bh=HUzCRBXInCG79yrELn+5UE2gAU1vsdh0iwdF2hanxRo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZhBdA3i+R2H9kbi9Bvgdw8scpgiCq409Sp/l+CI0XlpJZz8IUnv8pu6JKWuJ6FWmubF8YvyMC/cEzhrMCQI6cqO1PivulZ9iT5NGqfARE+RisY3iWF94YvN92B1DWFCAfqmkjZJsZEMdXPfL1uY0MN3P1rO9uqOux+wv3OMT2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkBX130p; arc=none smtp.client-ip=74.125.227.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkBX130p"
Received: by mail-vs2-f16.google.com with SMTP id 71dfb90a1353d-5c67e5292fdso1250756e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 14:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790024511; x=1790629311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vOVL+WSUz3aFG1YKnpOf/j6fyGZ29l7IeErDxRKkIiM=;
        b=bkBX130psIaccxRFcqng9M0S7nGTBM0QGSUdnyyIaOYbcJV+Jyz6FV2XE33+Vh9Xke
         WgcgREO89bf7ieELQJi2ziQMLcg4KLmE84LEGNXheHdlU9NXytc/J7Si8kQ9RQUXeleo
         qEB2PJiD48Bx7RfL0IBA+e/zruJ7BIX5bH7tQUzZOrqVYKs5eoKxUvzHTZLHxYJr0vCm
         +sg1MtJawyHlmW0M3VpQ5EpuYrg18jmRVSr+30wokjs0QoM93pZK1g+CNRYfL5wlQUMa
         Eb49oGuy05WsVAquXoB8Kk68LWWYr0XKqWpHmi/mxDdUwhHSl7rpsmu306Ts9ZiR9Pp/
         ZD4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790024511; x=1790629311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vOVL+WSUz3aFG1YKnpOf/j6fyGZ29l7IeErDxRKkIiM=;
        b=BCTs7Bxga73g9JVskXRYyx0fw0V4qG1exJiIUdz58QNxwcGa7oL0/B7KkhJNOGLRaK
         QXyb66XjKGT+Ofl2l6WQ8QFUCwJs/4OEErMIJIio5q/RH+DyUUtpjfiGDDrQBIL9MdDu
         yxep0+YspuOjx4KG/o/vJP15lXWvDtDBB1a+eHCkENbafagHhUnNNsaiTC01xUVouFYt
         TuqGmIVMglhkdW7vC7qXCikdX9tBSejIM74sXMIDu96qUOo0UASdYte9489hP1N0UJlK
         R/ZzpJxNuVmwraodY7kkNHmyJCPTG5R/ZoOdU2CplPKyzzlqOtkA2GtkYaTJ1HFh2mBI
         VE5g==
X-Gm-Message-State: AFuF++k0VWUDw7TIzUcOjgw+xSKgkfMbkyVzi2sJVcz0RfQvIzkzlAaa
	GumU1aHL4sdM3cbjYR6ngDRewOKDnY8lcjICAjE1HumTdPKX3CVv8pznI7DgHKUm
X-Gm-Gg: AYBFou38oRZkOsYLc7K1l4A/Ls3ZKrFcnz7306H4OD8xHZ/tLxxFYbgvl921Kt2r4nr
	h1VNsEAKoqvaBIpSf2+lu+FJZY08WeGODVt2Is4NSfTw58kaCHB5dZ0bivMjDUki/kDvHDWd4yI
	891KJbwrosv+F6Ykzf+KeLAeriViylBgNyFssq9KvZK+6i3UGIBIdMVuEeORdQQA3FN+JofgrKY
	nO2yLK6NwlDRRa7gFdkqgktBWDM1+FB1UfdvvUcEOVMi/m96TUcJGBlFOICKMaabh9CKcdc7QeK
	eSdXpxy5xnJNFHyPqWKCyhh7dVnaaqXMZUEUGBF/3zPQ7fuEhLihGPW6o9gHfF0dX8UulPhWFol
	y83aNQiuW5G/MjsKyTr8I42crk0X5HhrFQ7ArSs8eDUpyF7xGMkxrpNhkrMEe3NrFpbHd4RiM/b
	8UIJZbw9lEKJjVnBODMisq4+S8rBIy1CHbWO9m0vln0dg7Wgsa3++IJYnNccIQPRDvay0+Z2DUj
	Zox2D8TCI5jxNIcTVwRhSirBpXE0NJMJKrD163nUmqwTHGF+0r+hrbSQFBFObl3
X-Received: by 2002:a05:6122:390a:b0:5c1:781:7122 with SMTP id 71dfb90a1353d-5c9b58f8e64mr5641623e0c.3.1790024508222;
        Mon, 21 Sep 2026 14:01:48 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9850c318641sm83527241.9.2026.09.21.14.01.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:01:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 6/6] test: functional: add the true wireless broadcast assistant test
Date: Mon, 21 Sep 2026 17:01:23 -0400
Message-ID: <20260921210123.3690449-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921210123.3690449-1-luiz.dentz@gmail.com>
References: <20260921210123.3690449-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Assisted-by: opencode:claude-opus-5
---
 client/scripts/broadcast-delegator-left.bt  |  32 ++++
 client/scripts/broadcast-delegator-right.bt |  32 ++++
 doc/functional-bap.rst                      |   6 +
 test/functional/test_bap.py                 | 181 ++++++++++++++++++--
 4 files changed, 239 insertions(+), 12 deletions(-)
 create mode 100644 client/scripts/broadcast-delegator-left.bt
 create mode 100644 client/scripts/broadcast-delegator-right.bt

diff --git a/client/scripts/broadcast-delegator-left.bt b/client/scripts/broadcast-delegator-left.bt
new file mode 100644
index 000000000000..818b30567be6
--- /dev/null
+++ b/client/scripts/broadcast-delegator-left.bt
@@ -0,0 +1,32 @@
+power on
+#
+#
+# Register a Broadcast Sink endpoint with LC3 taking a single channel,
+# to act as the left member of a coordinated set of Scan Delegators.
+# The members of the set are programmed with the same SIRK, see [CSIS]
+# in main.conf.
+#
+endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
+# Auto Accept: accept the configuration chosen by the peer
+y
+# Max Transports: no limit
+a
+# Locations: Front Left, so only the BIS carrying that channel is synced
+1
+# Supported Context: Media
+4
+#
+#
+# Select and acquire automatically the transports of the streams the
+# Broadcast Assistant adds.
+#
+transport.select auto
+transport.acquire auto
+#
+#
+# Advertise the Resolvable Set Identifier, so the assistant is able to
+# resolve this device as a member of the set, and connecting one member
+# connects the other.
+#
+advertise.rsi on
+advertise on
diff --git a/client/scripts/broadcast-delegator-right.bt b/client/scripts/broadcast-delegator-right.bt
new file mode 100644
index 000000000000..bfd1888987bc
--- /dev/null
+++ b/client/scripts/broadcast-delegator-right.bt
@@ -0,0 +1,32 @@
+power on
+#
+#
+# Register a Broadcast Sink endpoint with LC3 taking a single channel,
+# to act as the right member of a coordinated set of Scan Delegators.
+# The members of the set are programmed with the same SIRK, see [CSIS]
+# in main.conf.
+#
+endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
+# Auto Accept: accept the configuration chosen by the peer
+y
+# Max Transports: no limit
+a
+# Locations: Front Right, so only the BIS carrying that channel is synced
+2
+# Supported Context: Media
+4
+#
+#
+# Select and acquire automatically the transports of the streams the
+# Broadcast Assistant adds.
+#
+transport.select auto
+transport.acquire auto
+#
+#
+# Advertise the Resolvable Set Identifier, so the assistant is able to
+# resolve this device as a member of the set, and connecting one member
+# connects the other.
+#
+advertise.rsi on
+advertise on
diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 7059e0c735f1..74a6604ad285 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -648,6 +648,12 @@ test_bass_past_earbuds_transport_acquire
 	characteristic of each member is read over its own connection,
 	which is why the services of both are waited for.
 
+	The hosts are reused between tests, so the members may be bonded
+	already, in which case ``pair`` connects them instead, see
+	**bluetoothctl(1)**. What is already in place is then checked over
+	D-Bus rather than waited for on the output, as a device whose
+	services are already resolved does not report it again.
+
 	Each member gets a push of its own: BASS has no notion of a set,
 	so the assistant adds the source to the Broadcast Receive State
 	of each delegator separately, and each of them receives the
diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index bfcb43c0ad67..8d0b4489d766 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -5,6 +5,7 @@ Tests for BAP (LE Audio) using bluetoothctl in VM instances
 """
 
 import threading
+import time
 import warnings
 
 import dbus
@@ -113,7 +114,7 @@ def pair_le(host0, ctl0, host1, ctl1, advertise=True, services=False):
     ctl0.expect(f"Device {host1.bdaddr.upper()}")
     ctl0.send(f"pair {host1.bdaddr.upper()}\n")
 
-    pending = ["Pairing successful"]
+    pending = [PAIRED]
     if services:
         pending.append(f"Device {host1.bdaddr.upper()} ServicesResolved: yes")
 
@@ -170,6 +171,11 @@ def remove_device(ctl0, host):
     )
 
 
+# A device that is already paired is connected instead, see cmd_pair in
+# client/main.c, so a pairing reports one or the other
+PAIRED = r"Pairing successful|Connection successful"
+
+
 def pair_wait(ctl0, ctl1, pending):
     """
     Wait for the given events while answering the pairing requests.
@@ -326,6 +332,41 @@ def transport_paths():
     )
 
 
+@mainloop_wrap
+def device_properties(paths):
+    """Properties of the given devices, empty for those that are unknown."""
+    objects = dbus.Interface(
+        get_dbus().get_object("org.bluez", "/"),
+        "org.freedesktop.DBus.ObjectManager",
+    ).GetManagedObjects()
+    return {
+        path: {
+            str(key): bool(value)
+            for key, value in objects.get(path, {}).get("org.bluez.Device1", {}).items()
+            if key in ("Paired", "Connected", "ServicesResolved")
+        }
+        for path in paths
+    }
+
+
+def wait_properties(host, paths, name):
+    """
+    Wait for the given property of the given devices to be set.
+
+    Polled rather than waited for on the output, as a device that is
+    already in that state does not report it again.
+    """
+    deadline = time.monotonic() + DEFAULT_TIMEOUT
+
+    while True:
+        props = host.call(device_properties, paths)
+        if all(props[path].get(name) for path in paths):
+            return
+
+        assert time.monotonic() < deadline, f"{name} not set on {paths}: {props}"
+        time.sleep(0.2)
+
+
 def add_preset(ctl, name, props, metadata):
     """Make a custom preset from a transport's codec configuration and QoS."""
 
@@ -571,6 +612,28 @@ past_host_config = host_config(
 
 LOCAL_ASSISTANT_RE = r"Assistant (/org/bluez/\S+/sid\d+/bis\d+)"
 
+# Local MediaAssistant object of a given BIS of the local broadcast
+LOCAL_ASSISTANT = r"Assistant (/org/bluez/hci0/sid\d+/bis{})"
+
+
+def push_assistant(source, assistant_path, host):
+    """
+    Share the local stream of the given MediaAssistant object with the
+    given delegator, which receives the periodic advertising sync over
+    the connection (PAST).
+    """
+    source.send(f"assistant.push {assistant_path}\n")
+    source.expect(r"Enter Device \(path\):")
+    source.send(f"/org/bluez/hci0/dev_{dev_addr(host)}\n")
+
+    # The local stream may already know the broadcast code
+    idx, _ = source.expect(
+        [r"Enter Broadcast Code \(auto/value\):", r"Assistant \S+ pushed"]
+    )
+    if idx == 0:
+        source.send(f"{BCAST_CODE}\n")
+        source.expect(r"Assistant \S+ pushed")
+
 
 @past_host_config
 def test_bass_past_transport_acquire(hosts):
@@ -602,17 +665,7 @@ def test_bass_past_transport_acquire(hosts):
 
     # Share the local broadcast: the delegator receives the periodic
     # advertising sync over the connection (PAST)
-    source.send(f"assistant.push {assistant_path}\n")
-    source.expect(r"Enter Device \(path\):")
-    source.send(f"/org/bluez/hci0/dev_{dev_addr(delegator_host)}\n")
-
-    # The local stream may already know the broadcast code
-    idx, _ = source.expect(
-        [r"Enter Broadcast Code \(auto/value\):", r"Assistant \S+ pushed"]
-    )
-    if idx == 0:
-        source.send(f"{BCAST_CODE}\n")
-        source.expect(r"Assistant \S+ pushed")
+    push_assistant(source, assistant_path, delegator_host)
 
     # A transport is created on the delegator, selected and acquired
     # automatically
@@ -795,3 +848,107 @@ def test_bap_unicast_set_transport_acquire(set_hosts):
         [acquired, acquired]
         + [f"Transport {transport} State: active" for transport in transports],
     )
+
+
+def discover_set(source_host, source, left_host, right_host):
+    """
+    Scan until both members of the set have been found.
+
+    The set is resolved from the RSI of the members that are already
+    known, so connecting before both have been found would leave the
+    one found later out of it.
+    """
+    source.send("scan on\n")
+    source.expect(f"Controller {source_host.bdaddr.upper()} Discovering: yes")
+
+    expect_all(
+        source,
+        [
+            f"Device {left_host.bdaddr.upper()}",
+            f"Device {right_host.bdaddr.upper()}",
+        ],
+    )
+
+    # Stop scanning before connecting, so the discovery does not
+    # interfere with the connections to the members
+    source.send("scan off\n")
+    source.expect(f"Controller {source_host.bdaddr.upper()} Discovering: no")
+
+
+bass_set_host_config = host_config(
+    [Bluetoothd(conf=BAP_CONF), Pexpect()],
+    [Bluetoothd(conf=csip_conf(1)), Pexpect()],
+    [Bluetoothd(conf=csip_conf(2)), Pexpect()],
+)
+
+
+@bass_set_host_config
+def test_bass_past_earbuds_transport_acquire(hosts):
+    source_host, left_host, right_host = hosts
+
+    # Source broadcasting one BIS per channel, with its own streams
+    # exposed as local MediaAssistant objects, one per BIS
+    source = start_bluetoothctl(source_host, "broadcast-source-2bis.bt")
+    groups = expect_all(
+        source,
+        [LOCAL_ASSISTANT.format(1), LOCAL_ASSISTANT.format(2), ACQUIRED, ACQUIRED],
+    )
+    assistants = [m[0].decode("utf-8") for m in groups[:2]]
+
+    # Delegators advertising, selecting and acquiring automatically
+    left = start_bluetoothctl(left_host, "broadcast-delegator-left.bt")
+    right = start_bluetoothctl(right_host, "broadcast-delegator-right.bt")
+
+    # Every member has to be advertising before connecting, so the set
+    # can be resolved and the remaining members found
+    left.expect("Advertising object registered")
+    right.expect("Advertising object registered")
+
+    paths = [
+        f"/org/bluez/hci0/dev_{dev_addr(host)}" for host in (left_host, right_host)
+    ]
+
+    # The hosts are reused, so a previous test may have left the
+    # members bonded, in which case they are known already and the
+    # discovery below would report nothing for them, as only what
+    # changes is reported: they are connected directly instead.
+    props = source_host.call(device_properties, paths)
+
+    if not all(props[path].get("Paired") for path in paths):
+        discover_set(source_host, source, left_host, right_host)
+
+    # Connecting one member connects the rest of the set, so a single
+    # request covers both, and pairing a member that is bonded already
+    # connects it, see cmd_pair in client/main.c
+    source.send(f"pair {left_host.bdaddr.upper()}\n")
+    pair_wait(source, left, [PAIRED])
+
+    # The Broadcast Receive State of each member is read over its own
+    # connection, so the services of both have to be resolved, and an
+    # encrypted link is required for the read to succeed.
+    #
+    # Checked over D-Bus rather than waited for on the output, as a
+    # device whose services are already resolved does not report it
+    # again, e.g. when the members were bonded already.
+    wait_properties(source_host, paths, "ServicesResolved")
+
+    # One push per member, each carrying the BIS of its own channel:
+    # BASS has no notion of a set, so the source is added to the
+    # Broadcast Receive State of each delegator separately, and each of
+    # them receives the periodic advertising sync over its own ACL
+    for assistant, host in zip(assistants, (left_host, right_host)):
+        push_assistant(source, assistant, host)
+
+    # A transport is created on each side for the BIS that was pushed
+    # to it, and selected and acquired automatically
+    for ctl, host, bis in ((left, left_host, 1), (right, right_host, 2)):
+        transport = expect_bis_transport(ctl, host, bis)
+
+        expect_all(
+            ctl,
+            [
+                ACQUIRED,
+                f"Transport {transport} State: broadcasting",
+                f"Transport {transport} State: active",
+            ],
+        )
-- 
2.55.0

