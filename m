Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301473DC4BD
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981806; cv=none; b=ihr1oNodhyfkoX6jqm3fu0jW4Y5mao64lQyJUNDoXG6zAXjMohtwSFw3SSTQCzEhIDJGSrTa8UZ1pvKG4AJKURqtPsRajrQAg/ed3ZDjksxSCkqzFVQi/0iZO6P9Xws6z/LT47fjXBY/8tdMkcJvIEnNZMyo7AlcrG0cgAIXVT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981806; c=relaxed/simple;
	bh=plddrKgVe722JpYHLdM6ejzD1XlR2ycqa5VIfNg8GrU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXRdxkEURCC7c6UiNDvnNcsc/0GZCCEo/DFs666kUEul4sX5shGA38vmXFr1L07hxXSoPfj4LyzYUfeH0HiNxkS4Hr5wdFteiq7sRqAxpsnlJg4p5bCZfruAPFTz6+rInIMB/SKwqcfmLG9tcHPn9Ky+Z+lb99hdGbjDmzMxuCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ofbBZ+SB; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofbBZ+SB"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7466771f1caso2106201137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 12:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981803; x=1789586603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=T4El0lFGSTWHvTWGjJrL1TuN7m+3jIBsqyoOuCHCrq4=;
        b=ofbBZ+SBDRrrN8hnZZNhYxENKs3Qz35LGQNqdTpJbDy92rZaV2iCz1G3ftR3nRvpEs
         9O/H6Sl1UAaz2biC5oHL2h9jiUI2EvrI0N9uWB6aWT1I0YLS69qsnoUCmxXA673ulo8S
         M3nGQJNymSOUFtBXXpXVpCUFeq4GmDeO5uLKwiuuDIZFUfsD/cURHxKmdt0ba4ZTLTHJ
         Bn2Q3NP4jZtuDaOC5aD/hb1LyNUqw89z2i2HTzfaDjs3FqelgF2DA8RrbNfYSmlYOD0z
         qzk01Yw+lRJcL7tTpfzl2tto1fTJ/rMoMKuNPyriUho/rF8/NzbyuD5bhS5eSoAuPKry
         qHKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981803; x=1789586603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=T4El0lFGSTWHvTWGjJrL1TuN7m+3jIBsqyoOuCHCrq4=;
        b=MoxgZyhpgL2RfOnAxWuPKVPI+rvi3jkJ7Z6zVau0O6pWat6brHXr+O/dgNXc9x4rJV
         iPftbdNh0zThc+sbVbQu6Z8RIHhy/y35FvDWIalO6xREaPK8FKzk+ciIXlJ6AzoTZHRH
         RMjuStAL6HJhX2wc6uxRvMzkMqiH8WbK7CQDPf/HNcd/UlKqZMUHTFD8cydfJixAh/Wo
         lyfz3E2Bn8E6T2FSvV6NdzMbWJj28cQEsj5aJSfli0lP3MGLRboTa26ueakb6qkvL/DY
         yPHCy24YBXbe2DOu8/F2YUojEsA1Zzc6uKKh/ZvC5wWQWckg1rNuJGmayBmg1lLuJL6X
         FDIQ==
X-Gm-Message-State: AFuF++lQdy+MqQDRCr8xIz5zt95UdpTtKcuL7JxBZuwPce58nvDraYAo
	K/yN2hWpAlrG0cQZPYnT4up+oG/6KQEHCHTy7CTeBgc+aiNVJOt4uxuNoFpKhlML
X-Gm-Gg: AYBFou3Ovb3crRv8fnFbKu23btubuTzAzjtHhZMy2yqyjEMQFvtzDgOwkMSHhiOpBJf
	Npnmot9LQs5tUd4Mm3GORXKYouh2knCznKIDKpUxZsw2/E3FFkry34iko30jY2zA3zQNbLPgVbN
	z6tAdudg9yi0Hy8RDzTIxvG4/i14eb3fIvEcwG3WjsgP4zJ1daFaO8BpdiLJohkSAxfUkhAs1qO
	eRstinfH2oktAK6fAve9R0//EirSGjwVvuDIWi2vyOSmafq97chM1UkobU9me86DQZ+ueA3fl/1
	OvZRm4z34LrT3rt1XY4dVRdJHr6WQkT0MX93rQFTLAv98SbD75ilx5WRlscHvLR9/xUMNNrv+bU
	z8EPSKuG0o1qw7JEWJtDp4+NBD/L0PURwCzn/Xtqr4qqQ3XOJIM6WlEW9A31f76flzX9rVzGlJ5
	5WCBmwA3yNVdrAf38ja/L73ZWbiqGbJjvfHViKWT7U3q8bOTUwWDDPYJ/kqMFwIVIvWigVWngeo
	XE+lTgFGMm6tCqS6pMDn3XLEzANFhduU77SkHgS6fdmZtKUOs7f5CqvjWJ57bWR3A==
X-Received: by 2002:a05:6102:50aa:b0:787:74cc:2cff with SMTP id ada2fe7eead31-78a4a72d914mr12796850137.3.1788981802842;
        Wed, 09 Sep 2026 12:23:22 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee8039csm13162744241.11.2026.09.09.12.23.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:23:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 05/12] test: functional: add A2DP tests
Date: Wed,  9 Sep 2026 15:23:01 -0400
Message-ID: <20260909192308.1306567-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909192308.1306567-1-luiz.dentz@gmail.com>
References: <20260909192308.1306567-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add tests covering A2DP via bluetoothctl: the central registers an
A2DP Source endpoint and the peripheral an A2DP Sink endpoint, using
the endpoint registration scripts. The endpoints are registered before
pairing so the SDP records are in place when the peer resolves the
services.

test_a2dp_transport_created checks a MediaTransport1 object is created
on both sides with the expected endpoint, codec and state, and
test_a2dp_transport_acquire checks the central can acquire it.

Assisted-by: opencode:claude-opus-5
---
 Makefile.am                  |   1 +
 doc/functional-a2dp.rst      |  99 ++++++++++++++++++++++++
 doc/functional-testing.rst   |   1 +
 test/functional/test_a2dp.py | 144 +++++++++++++++++++++++++++++++++++
 4 files changed, 245 insertions(+)
 create mode 100644 doc/functional-a2dp.rst
 create mode 100644 test/functional/test_a2dp.py

diff --git a/Makefile.am b/Makefile.am
index afa213cf0b8c..2eef04edd760 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -498,6 +498,7 @@ EXTRA_DIST += doc/assigned-numbers.rst doc/supported-features.txt \
 				doc/test-runner.rst \
 				doc/test-functional.rst \
 				doc/functional-testing.rst \
+				doc/functional-a2dp.rst \
 				doc/functional-avrcp.rst \
 				doc/functional-obex.rst \
 				doc/settings-storage.txt
diff --git a/doc/functional-a2dp.rst b/doc/functional-a2dp.rst
new file mode 100644
index 000000000000..779bcdcc0ff8
--- /dev/null
+++ b/doc/functional-a2dp.rst
@@ -0,0 +1,99 @@
+===============
+functional-a2dp
+===============
+
+DESCRIPTION
+===========
+
+A2DP functional tests, `test/functional/test_a2dp.py`, driven through
+**bluetoothctl(1)**. See **functional-testing(7)** for the conventions
+used here, and **test-functional(1)** for how to run the suite.
+
+SETUP
+=====
+
+Two hosts, connected over BR/EDR:
+
+.. code-block::
+
+	+------------------------+                 +------------------------+
+	| host0                  |     BR/EDR      | host1                  |
+	| central                | --------------> | peripheral             |
+	| bluetoothctl           |                 | bluetoothctl           |
+	| a2dp-source.bt         |   AVDTP (SBC)   | a2dp-sink.bt           |
+	| A2DP Source endpoint   | ==============> | A2DP Sink endpoint     |
+	+------------------------+                 +------------------------+
+
+	--> connection is initiated by      ==> audio flows towards
+
+Both hosts start `bluetoothctl` with an endpoint registration script:
+
+``client/scripts/a2dp-source.bt`` on host0
+	Registers a local A2DP Source endpoint
+	(``0000110a-0000-1000-8000-00805f9b34fb``) with SBC. host0 is the
+	central, i.e. the device sending audio.
+
+``client/scripts/a2dp-sink.bt`` on host1
+	Registers a local A2DP Sink endpoint
+	(``0000110b-0000-1000-8000-00805f9b34fb``) with SBC. host1 is the
+	peripheral, i.e. the device receiving audio.
+
+The endpoints are registered *before* pairing, so the SDP records are
+in place when the peer resolves the services. The hosts are then paired
+over BR/EDR, trust each other, and the central connects.
+
+TEST CASES
+==========
+
+test_a2dp_transport_created
+---------------------------
+
+:Setup: As above.
+
+:Steps:
+	1. Start `bluetoothctl` with the scripts on both hosts.
+	2. Pair over BR/EDR: ``scan on`` on the central,
+	   ``pairable on`` and ``discoverable on`` on the peripheral,
+	   ``pair``, and confirm the passkey on both sides.
+	3. ``trust`` the peer on both sides.
+	4. Central: ``connect <peripheral bdaddr>``.
+	5. Central: ``transport.show <transport>``.
+	6. Peripheral: ``transport.show <transport>``.
+
+:Expected:
+	1. ``Endpoint /local/endpoint/ep0 registered`` on both hosts.
+	2. ``Pairing successful``.
+	3. ``trust succeeded`` on both hosts.
+	4. ``Connection successful``, the stream is configured and a
+	   transport appears on *both* hosts.
+	5. The central transport reports
+	   ``UUID: Audio Source (0000110a-...)``, ``Codec: 0x00``,
+	   ``Media Codec: SBC``, ``Device:`` pointing at the peripheral
+	   device object, and ``State: idle``.
+	6. The peripheral transport reports
+	   ``UUID: Audio Sink (0000110b-...)`` and ``Codec: 0x00``.
+
+:Notes: A transport reports the UUID of the *local* endpoint it was
+	created for, which is why the two sides differ. The transport
+	paths differ as well: the central knows the remote SEP, so it uses
+	``.../dev_XX/sepN/fdN``, while the peripheral uses
+	``.../dev_XX/fdN``.
+
+	Registering the endpoints after pairing makes ``connect`` fail
+	with ``org.bluez.Error.BREDR.ProfileUnavailable``, as the services
+	were already resolved. Without ``trust``, the peripheral blocks on
+	an ``org.bluez.Agent1.AuthorizeService`` prompt.
+
+test_a2dp_transport_acquire
+---------------------------
+
+:Setup: As above, with the transport already created.
+
+:Steps: Central: ``transport.acquire <transport>``.
+
+:Expected:
+	1. ``Acquire successful: fd <fd> MTU <read>:<write>``.
+	2. The transport moves to ``State: active``.
+
+:Notes: Acquiring on the source side starts the stream, so the
+	peripheral does not have to acquire its own transport.
diff --git a/doc/functional-testing.rst b/doc/functional-testing.rst
index 29436d4454c0..03539dfea0a5 100644
--- a/doc/functional-testing.rst
+++ b/doc/functional-testing.rst
@@ -12,6 +12,7 @@ configure and run the suite, see **test-functional(1)**.
 This document covers the core test cases. Tests for a specific profile
 are documented separately:
 
+- **functional-a2dp(7)**: `test/functional/test_a2dp.py`
 - **functional-avrcp(7)**: `test/functional/test_avrcp.py`
 - **functional-obex(7)**: `test/functional/test_obex.py`
 
diff --git a/test/functional/test_a2dp.py b/test/functional/test_a2dp.py
new file mode 100644
index 000000000000..f176e4296439
--- /dev/null
+++ b/test/functional/test_a2dp.py
@@ -0,0 +1,144 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for A2DP using bluetoothctl in VM instances
+"""
+
+import pytest
+
+from pytest_bluezenv import Bluetoothd, Pexpect, find_exe, host_config
+from pytest_bluezenv.utils import bluez_src_dir
+
+pytestmark = [pytest.mark.vm]
+
+A2DP_SOURCE_UUID = "0000110a-0000-1000-8000-00805f9b34fb"
+A2DP_SINK_UUID = "0000110b-0000-1000-8000-00805f9b34fb"
+
+TRANSPORT_RE = r"Transport (/org/bluez/\S+/fd\d+)"
+
+
+def dev_addr(host):
+    return host.bdaddr.upper().replace(":", "_")
+
+
+def script(name):
+    src = bluez_src_dir()
+    if src is None:
+        pytest.skip("BlueZ source directory not known")
+
+    path = src / "client" / "scripts" / name
+    if not path.exists():
+        pytest.skip(f"{path} not found")
+
+    return str(path)
+
+
+def start_bluetoothctl(host, init_script):
+    """
+    Start bluetoothctl registering the endpoints of the given script.
+
+    The endpoints are registered before pairing, so that the SDP
+    records are in place when the peer resolves the services.
+    """
+    exe = find_exe("client", "bluetoothctl")
+    ctl = host.pexpect.spawn([exe, "--init-script", script(init_script)])
+    ctl.expect("Endpoint /local/endpoint/ep0 registered")
+    return ctl
+
+
+def pair(host0, ctl0, host1, ctl1):
+    ctl0.send("scan on\n")
+    ctl0.expect(f"Controller {host0.bdaddr.upper()} Discovering: yes")
+
+    ctl1.send("pairable on\n")
+    ctl1.expect("Changing pairable on succeeded")
+    ctl1.send("discoverable on\n")
+    ctl1.expect(f"Controller {host1.bdaddr.upper()} Discoverable: yes")
+
+    ctl0.expect(f"Device {host1.bdaddr.upper()}")
+    ctl0.send(f"pair {host1.bdaddr}\n")
+
+    idx, m = ctl0.expect(r"Confirm passkey (\d+).*:")
+    key = m[0].decode("utf-8")
+
+    ctl1.expect(f"Confirm passkey {key}")
+
+    ctl0.send("yes\n")
+    ctl1.send("yes\n")
+
+    ctl0.expect("Pairing successful")
+
+    ctl0.send("scan off\n")
+
+    # Avoid service authorization prompts when connecting
+    ctl1.send(f"trust {host0.bdaddr}\n")
+    ctl1.expect("trust succeeded")
+    ctl0.send(f"trust {host1.bdaddr}\n")
+    ctl0.expect("trust succeeded")
+
+
+a2dp_host_config = host_config(
+    [Bluetoothd(), Pexpect()],
+    [Bluetoothd(), Pexpect()],
+)
+
+
+@pytest.fixture
+def a2dp_hosts(hosts):
+    """
+    Two hosts with A2DP endpoints registered via bluetoothctl: host0 is
+    the central with an A2DP Source endpoint, host1 the peripheral with
+    an A2DP Sink endpoint. The hosts are paired and connected, so that
+    a stream is configured.
+    """
+    host0, host1 = hosts
+
+    source = start_bluetoothctl(host0, "a2dp-source.bt")
+    sink = start_bluetoothctl(host1, "a2dp-sink.bt")
+
+    pair(host0, source, host1, sink)
+
+    source.send(f"connect {host1.bdaddr}\n")
+    source.expect("Connection successful")
+
+    yield host0, host1, source, sink
+
+
+@a2dp_host_config
+def test_a2dp_transport_created(a2dp_hosts):
+    host0, host1, source, sink = a2dp_hosts
+
+    # Transport is created on both sides once the stream is configured
+    _, m = source.expect(TRANSPORT_RE)
+    transport = m[0].decode("utf-8")
+
+    _, m = sink.expect(TRANSPORT_RE)
+    sink_transport = m[0].decode("utf-8")
+
+    # Central holds the A2DP Source endpoint
+    source.send(f"transport.show {transport}\n")
+    source.expect(f"Transport {transport}")
+    source.expect(rf"UUID: Audio Source\s+\({A2DP_SOURCE_UUID}\)")
+    source.expect(r"Codec: 0x00")
+    source.expect("Media Codec: SBC")
+    source.expect(f"Device: /org/bluez/hci0/dev_{dev_addr(host1)}")
+    source.expect("State: idle")
+
+    # Peripheral holds the A2DP Sink endpoint
+    sink.send(f"transport.show {sink_transport}\n")
+    sink.expect(f"Transport {sink_transport}")
+    sink.expect(rf"UUID: Audio Sink\s+\({A2DP_SINK_UUID}\)")
+    sink.expect(r"Codec: 0x00")
+
+
+@a2dp_host_config
+def test_a2dp_transport_acquire(a2dp_hosts):
+    host0, host1, source, sink = a2dp_hosts
+
+    _, m = source.expect(TRANSPORT_RE)
+    transport = m[0].decode("utf-8")
+
+    source.send(f"transport.acquire {transport}\n")
+    source.expect(r"Acquire successful: fd \d+ MTU \d+:\d+")
+
+    source.expect(f"Transport {transport} State: active")
-- 
2.55.0

