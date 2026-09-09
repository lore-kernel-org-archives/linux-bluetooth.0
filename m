Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D708545D8D
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981810; cv=none; b=eMxtheBh5pCxgEb6oEuFbrSPpkrv6PbgPtRt1uAiEpjyCWIyNlUihClgOFGdu/DKD8naptxHNl6mA+2seicsMQFLL7gXLqAjP9ZdyHykWq/gEORlg8xazJ/O8upMP8nCdpIeKY6Kl3QNaXcmeS37KhwCwQs8y7Wpy79DC13WKJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981810; c=relaxed/simple;
	bh=5yVq3MPDv83tYEJSB54XIIf7D1n0VLGjUMZMfvOPqHA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=op3S+hdA/4ND13K8fHvcj6QDckRyTjZ5sWVe0W5S+4r5imVXTOZK+ZVXkJFuDwCxUp4wM7yhvGHcxlCzD3ex423/7zIaRVYfyM5w9EbpSiCf1+8E0KMCscbZD3eLaB/NTvI57ZpPHDhfXMuWyo7305BSJIXpHxIvV9dx/3n5Cew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g4wq1XUi; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4wq1XUi"
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7855bfd6ab6so1896647137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 12:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981807; x=1789586607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8GTFwJW+QwxW5c+jownu4GkvVFfu/4gqSDObb3XdT5M=;
        b=g4wq1XUiwQpQdavzhMLJT1XhOKuBiUTT4tokhtKdvUIjvVtGdxUXZhYh3gM668fLuw
         +8K/1cd7tqylK0rPtP2a7zlrNsdX69eeju1fllTuNGIfUcS+YfzBNTQTFbUHWQaaQCvd
         5Flnq9ghe6HxlkzYJXBT44kQ5LYFHaguSjrq3QNOp5Du9uLuIlc5Vdb79SLGENYhD/IE
         2q441RQuJmgSEIG8ryw+3Zd64hpu4I29XwCh+f7Od6WXGIQaSWq3o+ohLXvHKITwrxlk
         LWM+Ias9Tv5ZavaJ4YPwXse/0inrcrTiocP0OnzbTh+umy9hSMaCLBJHSpGdQDMZ/V32
         /5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981807; x=1789586607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8GTFwJW+QwxW5c+jownu4GkvVFfu/4gqSDObb3XdT5M=;
        b=j8M3FmHwpcnomI+DEj1rVcBttnQXI1olx3NW09SPx4KXlpewpI+naXzDSDTej/r/HJ
         yFil7D7qpOEIMJQ2rjRzAy7oZOpJOx+UXDJWBr9FJZJYlD+eVXGrUEqMtW+0XLpgD3It
         0B26lmwdNLoEWXFWFFJhTag6mFPHRIeVnudNHgYJ9EXuu+x3iVhzKlBiW6boBB5P7vU+
         M9qUNyiHVKMVjaZH8oH00iGkGIbpNlzA8xieZoDf7i0tgARomPM0wYJn8YkYulFIPGRV
         VsbjJbfdQz439WqhzHmU0dAC+yzniXwnKNjhtzDOyJ0JNuFwyIjsPiXAZViPEuWXmty2
         P7JA==
X-Gm-Message-State: AFuF++mqzSm6nlTUs/xE80GQBxFlVQpBJNP5whtNGXP8gwOuVxqfIZgB
	Gy4nA1R59MnJVALfUw72luX52NXmX6VfE2lV0TvjSmGdqIqyR79h+MMqKaI8RYhR
X-Gm-Gg: AYBFou2NDEIKU8OamQFyxckB4YpGUK5EOmrkqufECpQZ23KyA6SJtinlrjWKmALe3D7
	wxvQqvThcpmv7O0nINJNljbTMHOMboDXiPelE+GLeUw0fetVysaxg/xj4Ppo3BakS+hyHiJy3QY
	6bwPoPd4K0FSWJ8HGJstS2QzgmjQPJtcGNLEEBIlfNYieX4R+TcO4wiDzoPgXwfU8gdzK8np9QM
	H6qrQyo0lFc1zkA5Zgc7CjaN2CoHo3XmGoXeoIoNeMRNiAuuMunL+uKGDsFVyBThGnIJrVsAWmP
	Wg6b8nBOrJJjSyxROKCGcrzX99qLeDVGv7PYNC5wy7oYCqfzaNHqHS3Yf8Dfur//XxyWc6MBPel
	JfxhlCOT1jxuZxlVD9pXeYUHv917FcufA1WGhq3XsGLi9LBGrNZTNUkGtsbTQdsI0iFvHD3MwBw
	9bpeBlAHOXnyKS1KQxuxebbLD9eqOheXxJPmYYCnsTkz5Nn//wxTzL6ZKL24lti375vIbJd2teb
	NWfuGz4BvPuOZCZLw88pogX8axOrAGdMQ0xxzaCv1bcj5dQmQAi/9Q0p2j0uf99zA==
X-Received: by 2002:a05:6102:5487:b0:77a:2268:9fdb with SMTP id ada2fe7eead31-78a4a995f6cmr15357028137.7.1788981806423;
        Wed, 09 Sep 2026 12:23:26 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee8039csm13162744241.11.2026.09.09.12.23.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:23:25 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 09/12] test: functional: add BAP unicast tests
Date: Wed,  9 Sep 2026 15:23:05 -0400
Message-ID: <20260909192308.1306567-10-luiz.dentz@gmail.com>
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

Add tests covering BAP unicast via bluetoothctl: the initiator
registers a PAC Source endpoint, the acceptor a PAC Sink endpoint, and
after pairing the initiator configures the remote endpoint with a
preset.

test_bap_unicast_transport_created checks a MediaTransport1 object is
created on both sides with the expected endpoint, codec and state, and
test_bap_unicast_transport_acquire checks the initiator can acquire
them.

The endpoints are configured for stereo, so a stream is created per
location, each with its own CIS in the same CIG. All the transports
have to be acquired, as the CIS are only created once every CIS of the
CIG is ready.

Assisted-by: opencode:claude-opus-5
---
 Makefile.am                 |   1 +
 doc/functional-bap.rst      | 109 +++++++++++++++++++++++
 doc/functional-testing.rst  |   1 +
 test/functional/test_bap.py | 169 ++++++++++++++++++++++++++++++++++++
 4 files changed, 280 insertions(+)
 create mode 100644 doc/functional-bap.rst
 create mode 100644 test/functional/test_bap.py

diff --git a/Makefile.am b/Makefile.am
index 2eef04edd760..efab756242e9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -500,6 +500,7 @@ EXTRA_DIST += doc/assigned-numbers.rst doc/supported-features.txt \
 				doc/functional-testing.rst \
 				doc/functional-a2dp.rst \
 				doc/functional-avrcp.rst \
+				doc/functional-bap.rst \
 				doc/functional-obex.rst \
 				doc/settings-storage.txt
 
diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
new file mode 100644
index 000000000000..6b67df541e97
--- /dev/null
+++ b/doc/functional-bap.rst
@@ -0,0 +1,109 @@
+==============
+functional-bap
+==============
+
+DESCRIPTION
+===========
+
+BAP (LE Audio) functional tests, `test/functional/test_bap.py`, driven
+through **bluetoothctl(1)**. See **functional-testing(7)** for the
+conventions used here, and **test-functional(1)** for how to run the
+suite.
+
+SETUP
+=====
+
+Two hosts, connected over LE:
+
+.. code-block::
+
+	+------------------------+                 +------------------------+
+	| host0                  |      LE ACL     | host1                  |
+	| initiator (central)    | --------------> | acceptor (peripheral)  |
+	| bluetoothctl -a auto   |                 | bluetoothctl -a auto   |
+	| bap-source-lc3.bt      |  CIS 0x00 (LC3) | bap-sink-lc3.bt        |
+	| PAC Source endpoint    | ==============> | PAC Sink endpoint      |
+	|                        |  CIS 0x01 (LC3) |                        |
+	|                        | ==============> |                        |
+	+------------------------+                 +------------------------+
+
+	one CIG holding one CIS per audio location
+
+	--> connection is initiated by      ==> audio flows towards
+
+BAP requires the ISO socket support, so all hosts run `bluetoothd`
+with:
+
+.. code-block::
+
+	[General]
+	Experimental = true
+	KernelExperimental = true
+	ControllerMode = le
+
+`bluetoothctl` is started with ``-a auto``, so pairing and service
+authorization are accepted without prompting, and with an endpoint
+registration script:
+
+``client/scripts/bap-source-lc3.bt`` on host0
+	Registers a local PAC Source endpoint
+	(``00002bcb-0000-1000-8000-00805f9b34fb``) with LC3. host0 is the
+	initiator, i.e. the device sending audio.
+
+``client/scripts/bap-sink-lc3.bt`` on host1
+	Registers a local PAC Sink endpoint
+	(``00002bc9-0000-1000-8000-00805f9b34fb``) with LC3. host1 is the
+	acceptor, i.e. the device receiving audio.
+
+TEST CASES
+==========
+
+test_bap_unicast_transport_created
+----------------------------------
+
+:Setup: As above.
+
+:Steps:
+	1. Start `bluetoothctl` with the scripts on both hosts.
+	2. Pair over LE: ``scan on`` on the initiator, ``advertise on`` on
+	   the acceptor, then ``pair``.
+	3. Initiator: ``endpoint.config <remote endpoint>
+	   /local/endpoint/ep0 16_2_1``, using the remote PAC Sink endpoint
+	   exposed once the services are resolved.
+	4. Initiator: ``transport.show <transport>`` for each transport.
+
+:Expected:
+	1. ``Endpoint /local/endpoint/ep0 registered`` on both hosts.
+	2. ``Pairing successful``.
+	3. The remote endpoint appears as
+	   ``Endpoint /org/bluez/hci0/dev_XX/pac_sinkN``, and configuring it
+	   creates one transport per location on *both* hosts.
+	4. Each transport of the initiator reports the local PAC Source
+	   UUID (``00002bcb-...``), ``Codec: 0x06`` for LC3, ``Device:``
+	   pointing at the acceptor device object, and ``State: idle``.
+
+:Notes: The endpoints are registered with the locations and contexts
+	`bluetoothctl` uses itself, ``0x0fff`` for the sink and ``0x000f``
+	for the source. With narrower Supported Contexts the acceptor
+	rejects the ``Enable`` with ``Invalid Metadata``, because the
+	metadata of the stream carries the ``Unspecified`` context.
+
+test_bap_unicast_transport_acquire
+----------------------------------
+
+:Setup: As above, with the transports already created.
+
+:Steps: Initiator: ``transport.acquire <transport> <transport>``, for
+	all the transports that were created.
+
+:Expected: ``Acquire successful: fd <fd> MTU <read>:<write>`` for each
+	transport, and each of them moves to ``State: active``.
+
+:Notes: *All* the transports have to be acquired: the controller only
+	creates the CIS once every CIS of the CIG is ready, so acquiring a
+	single transport leaves the stream waiting until it times out,
+	without ``LE Create CIS`` ever being sent.
+
+	The acceptor does not have to acquire its transports for the CIS to
+	be established, as `bluetoothd` sets up the ISO listener on its own
+	when the stream is enabled.
diff --git a/doc/functional-testing.rst b/doc/functional-testing.rst
index 03539dfea0a5..60c6762dee73 100644
--- a/doc/functional-testing.rst
+++ b/doc/functional-testing.rst
@@ -14,6 +14,7 @@ are documented separately:
 
 - **functional-a2dp(7)**: `test/functional/test_a2dp.py`
 - **functional-avrcp(7)**: `test/functional/test_avrcp.py`
+- **functional-bap(7)**: `test/functional/test_bap.py`
 - **functional-obex(7)**: `test/functional/test_obex.py`
 
 Each test case is described as:
diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
new file mode 100644
index 000000000000..69430d7a6699
--- /dev/null
+++ b/test/functional/test_bap.py
@@ -0,0 +1,169 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Tests for BAP (LE Audio) using bluetoothctl in VM instances
+"""
+
+import warnings
+
+import pytest
+
+from pytest_bluezenv import Bluetoothd, Pexpect, find_exe, host_config
+from pytest_bluezenv.utils import bluez_src_dir
+
+pytestmark = [pytest.mark.vm]
+
+PAC_SINK_UUID = "00002bc9-0000-1000-8000-00805f9b34fb"
+PAC_SOURCE_UUID = "00002bcb-0000-1000-8000-00805f9b34fb"
+
+# BAP requires the ISO socket support, which is kernel experimental
+BAP_CONF = """[General]
+Experimental = true
+KernelExperimental = true
+ControllerMode = le
+"""
+
+PRESET = "16_2_1"
+
+TRANSPORT_RE = r"Transport (/org/bluez/\S+/fd\d+)"
+
+
+def dev_addr(host):
+    return host.bdaddr.upper().replace(":", "_")
+
+
+def expect_all(ctl, patterns):
+    """
+    Expect all the given patterns, in any order.
+    """
+    patterns = list(patterns)
+
+    while patterns:
+        idx, _ = ctl.expect(patterns)
+        patterns.pop(idx)
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
+    exe = find_exe("client", "bluetoothctl")
+    # -a auto: accept pairing and authorize services without prompting
+    ctl = host.pexpect.spawn([exe, "-a", "auto", "--init-script", script(init_script)])
+    ctl.expect("Endpoint /local/endpoint/ep0 registered")
+    return ctl
+
+
+def pair_le(host0, ctl0, host1, ctl1):
+    ctl0.send("scan on\n")
+    ctl0.expect(f"Controller {host0.bdaddr.upper()} Discovering: yes")
+
+    ctl1.send("advertise on\n")
+    ctl1.expect("Advertising object registered")
+
+    ctl0.expect(f"Device {host1.bdaddr.upper()}")
+    ctl0.send(f"pair {host1.bdaddr.upper()}\n")
+
+    # See test_bluetoothctl_pair_le: passkey confirmation is handled by
+    # the auto agent, but legacy passkey entry still needs an answer
+    idx, m = ctl0.expect([r"\[agent\].*Passkey:.*m(\d+)", "Pairing successful"])
+
+    if idx == 0:
+        warnings.warn(
+            "BUG: we got passkey authentication, bluetoothd/kernel should be fixed"
+        )
+        key = m[0].decode("utf-8")
+        ctl1.expect(r"\[agent\] Enter passkey \(number in 0-999999\):")
+        ctl1.send(f"{key}\n")
+        ctl0.expect("Pairing successful")
+
+    ctl0.send("scan off\n")
+
+
+unicast_host_config = host_config(
+    [Bluetoothd(conf=BAP_CONF), Pexpect()],
+    [Bluetoothd(conf=BAP_CONF), Pexpect()],
+)
+
+
+@pytest.fixture
+def unicast_hosts(hosts):
+    """
+    Initiator (host0) with a local PAC Source endpoint and acceptor
+    (host1) with a local PAC Sink endpoint, paired over LE, with the
+    remote PAC Sink endpoint configured.
+    """
+    host0, host1 = hosts
+
+    initiator = start_bluetoothctl(host0, "bap-source-lc3.bt")
+    acceptor = start_bluetoothctl(host1, "bap-sink-lc3.bt")
+
+    pair_le(host0, initiator, host1, acceptor)
+
+    # Remote PAC Sink endpoint is exposed once services are resolved
+    _, m = initiator.expect(r"Endpoint (/org/bluez/\S+/pac_sink\d+)")
+    remote = m[0].decode("utf-8")
+
+    initiator.send(f"endpoint.config {remote} /local/endpoint/ep0 {PRESET}\n")
+
+    yield host0, host1, initiator, acceptor
+
+
+def expect_transports(ctl):
+    """
+    The endpoint is configured for stereo, so one stream per location is
+    created, each with its own CIS in the same CIG.
+    """
+    _, m = ctl.expect(r"Transport (/org/bluez/\S+/fd0)")
+    left = m[0].decode("utf-8")
+    _, m = ctl.expect(r"Transport (/org/bluez/\S+/fd1)")
+    right = m[0].decode("utf-8")
+
+    return left, right
+
+
+@unicast_host_config
+def test_bap_unicast_transport_created(unicast_hosts):
+    host0, host1, initiator, acceptor = unicast_hosts
+
+    left, right = expect_transports(initiator)
+    expect_transports(acceptor)
+
+    for transport in (left, right):
+        initiator.send(f"transport.show {transport}\n")
+        initiator.expect(f"Transport {transport}")
+        initiator.expect(rf"UUID: .*\({PAC_SOURCE_UUID}\)")
+        initiator.expect(r"Codec: 0x06")
+        initiator.expect(f"Device: /org/bluez/hci0/dev_{dev_addr(host1)}")
+        initiator.expect("State: idle")
+
+
+@unicast_host_config
+def test_bap_unicast_transport_acquire(unicast_hosts):
+    host0, host1, initiator, acceptor = unicast_hosts
+
+    left, right = expect_transports(initiator)
+
+    # The CIS are only created once every CIS of the CIG is ready, so
+    # all the transports need to be acquired
+    initiator.send(f"transport.acquire {left} {right}\n")
+
+    acquired = r"Acquire successful: fd \d+ MTU \d+:\d+"
+    expect_all(
+        initiator,
+        [
+            acquired,
+            acquired,
+            f"Transport {left} State: active",
+            f"Transport {right} State: active",
+        ],
+    )
-- 
2.55.0

