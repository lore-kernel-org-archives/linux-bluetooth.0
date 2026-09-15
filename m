Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A576F4ACC74
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 21:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506954; cv=none; b=fJxl0jaBUz8CnvOQG87EFdYBqMkWRiMhTi3c6A+5UGW+Ml4CxmCqZYp6PLKoeGk2AqQqonKQndYWkpaH/RlK21D23fDsUVLdfGa0ZYfndxYs8BE3CanunG5lReYOOp5tLjq0XOfLlh4eP0DQxng/yYVwOtvSOkEaIK7NrgxFKzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506954; c=relaxed/simple;
	bh=mmipRyGJ95bYdrQa2SDOJ1KxruuRa0lVWwJVU4LzrHQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZN2dTIQMqQ3tLAYQqLjfiLvGwfRbPlyPuOQI44HktyvJ6ezZ4HJi+Y18fwtGTGZfD6wjwX0iSoQp2Abx48ZNuBQBzzCmZOoEOQrQ3BciuDyjCSxo0Qmln8rsBqBJ65nxaRcWiguCUczlvMACvCItoJZiGt6far3tMdp8n2oKH4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmhZmzrt; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmhZmzrt"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9830aa5523bso816157241.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 14:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789506951; x=1790111751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2GdwAhuBggSaA1f1sjicx2nM5uTEYSUkXLE6O7ek7Bo=;
        b=KmhZmzrtNQejdehgUAuD92LCuWgNAGCLQEPvhlUOOrxine+fLM1G2JVilbxxXkjMCL
         UJl7TKs63TA74C3FIvmOC6/PESBMLG2O/UjpofVewq0fWFMelImJ4BOovYkV6nk4aQY/
         zcQ/aiukvzM9GApNG9sUgGjIZDFqikFXzQKiioa8iQzyDebneasq6vsjLQn0g1rFiMQ9
         hHZsa/EDyw6pGt51FqGD9kg+TeSbrjKfQ+S3HG6Etg6edDBQuQoL306aJrXG+y70suAZ
         Zc1FxRJH/SsR76gOoa73/zx2jMak7ZbYernYEkF/oruHn3ZhbcWdt8WMuaC/Jzso+M8W
         Vbpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506951; x=1790111751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2GdwAhuBggSaA1f1sjicx2nM5uTEYSUkXLE6O7ek7Bo=;
        b=uRbd7FF3Re0zxDUPAetdLWyeZSh8a1viwKhpqyVlElhUWaxn9Tu/SzmL8X+DVTCw08
         hgKQYXlV6TlIJ4U1gRAIAD7RYMjc3Vrb5Tt+jih+OqLOUslt2MPA/4cIzOUpgjqTn8xK
         Z68euSDfDedh2qiu0Z8Av83aDJKAW+Wwz9jEGTAj6s9L1aH45deNVVAuNVVWuxFsssEh
         i+ZKfO0+NdbjHZBc+Ug3ikhSGnSUuh3EXjx5XmaWENRY/wZ7OVQO3F4KKx14pjRf2jgM
         vVoVKG5Gwryr//kQSYUScwPqgYyB1AnbzzXOHSGMORbMHA3wXmzU28JUhMyu9nA6zLnt
         AKJg==
X-Gm-Message-State: AFuF++nab6/y9sJj7qZVugoAGs4BV/UNTyJIBesLA4Te5lTZuA9nnZ86
	4HnNUqrtNW7v6czrTQfbPKPaiYXoxOvAxp9iIbGA1lo/62P3gUIQKpCMH2qksEwu
X-Gm-Gg: AYBFou2mnF42Wp10KQvNIp1xjcGUmdK1duM0F4zxMI+GJSXsUI9dA4vXp8SVuT0FYBw
	OvTXmuccoo3EMNA8bcjxlFADHDhQSDNqt9hmWVhfxaiZyPCQmwUPqrpkH6snymi3uKcHT2FRc+c
	H2c6k2IHhcXkXhxRBwtwriYzSxUtjj/qATwQqWDJU6qXSQDfA8ZkCs1otl8HCySKz5FcxGRRYHn
	GrN+n3tO9z9PRK9cczTnYkupiK1ddEaZjkNiOd92Y9GSSIiGjAIjqmITTfyT+sdObsXgbh5qgJj
	gYSdjmMhfWb9Cs2bh5fBLLsodVrqGu3dw0haFugGc8K0J56YcjRw25GRDpmg1wFwqfvFVT/B/HL
	uxKXOiLASJX0XhSy1EAU9FYZMVT2ltt8sCkHPIlZ1qiM6HeHeKsZo+u5KNYHPQ8CmK6T1OHO+di
	HsuObn7zJB/wx/F9iGGJJmb+0srLU3TIBmGiUDnVuhVx5HOafRJ2n8k88B86VmDunAM6u0Iag9j
	c5JOFVicvbgg0sSmE9CCbAGa3FqfJlfoCmlkQdq/gdF3S2PU/pnF9drQk1MwTfwhQ==
X-Received: by 2002:a05:6102:2597:10b0:79f:aa0:3790 with SMTP id ada2fe7eead31-79f0aa04788mr2162547137.19.1789506951250;
        Tue, 15 Sep 2026 14:15:51 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98314dd7ceasm746860241.1.2026.09.15.14.15.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:15:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 11/11] test: functional: add the BAP coordinated set tests
Date: Tue, 15 Sep 2026 17:15:28 -0400
Message-ID: <20260915211528.1223784-12-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915211528.1223784-1-luiz.dentz@gmail.com>
References: <20260915211528.1223784-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Cover a stereo unicast stream to a coordinated set of two acceptors,
one taking the left channel and one the right, which is what a pair of
earbuds does.

The acceptors advertise the RSI of the set and are configured with the
same SIRK, so the initiator resolves them into a single DeviceSet and
connects the second one on its own once the first is paired.

The endpoints are not configured by the test, as the daemon configures
a stream for them by itself, and the transports of both members are
acquired, as the CIS of a CIG are only created once every one of them
is active.

Assisted-by: opencode:claude-opus-5
---
 client/scripts/bap-sink-lc3-left.bt  |  30 ++++
 client/scripts/bap-sink-lc3-right.bt |  30 ++++
 doc/functional-bap.rst               |  38 +++--
 test/functional/test_bap.py          | 229 ++++++++++++++++++++++++++-
 4 files changed, 309 insertions(+), 18 deletions(-)
 create mode 100644 client/scripts/bap-sink-lc3-left.bt
 create mode 100644 client/scripts/bap-sink-lc3-right.bt

diff --git a/client/scripts/bap-sink-lc3-left.bt b/client/scripts/bap-sink-lc3-left.bt
new file mode 100644
index 000000000000..9ad8aad97f7a
--- /dev/null
+++ b/client/scripts/bap-sink-lc3-left.bt
@@ -0,0 +1,30 @@
+power on
+#
+#
+# Register a PAC Sink endpoint with LC3 taking a single channel, to act
+# as the left member of a coordinated set. The members of the set are
+# programmed with the same SIRK, see [CSIS] in main.conf.
+#
+endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
+# Auto Accept: accept the configuration chosen by the peer
+y
+# Max Transports: no limit
+a
+# Locations: Front Left, so only its own channel is configured
+1
+# Supported Context: same as the contexts bluetoothctl registers with
+0x0fff
+# Context
+0x0fff
+# CIG: assigned automatically
+a
+# CIS: assigned automatically
+a
+#
+#
+# Advertise the Resolvable Set Identifier, so the initiator is able to
+# resolve this device as a member of the set, otherwise it is streamed
+# to on its own.
+#
+advertise.rsi on
+advertise on
diff --git a/client/scripts/bap-sink-lc3-right.bt b/client/scripts/bap-sink-lc3-right.bt
new file mode 100644
index 000000000000..a6107383adf2
--- /dev/null
+++ b/client/scripts/bap-sink-lc3-right.bt
@@ -0,0 +1,30 @@
+power on
+#
+#
+# Register a PAC Sink endpoint with LC3 taking a single channel, to act
+# as the right member of a coordinated set. The members of the set are
+# programmed with the same SIRK, see [CSIS] in main.conf.
+#
+endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
+# Auto Accept: accept the configuration chosen by the peer
+y
+# Max Transports: no limit
+a
+# Locations: Front Right, so only its own channel is configured
+2
+# Supported Context: same as the contexts bluetoothctl registers with
+0x0fff
+# Context
+0x0fff
+# CIG: assigned automatically
+a
+# CIS: assigned automatically
+a
+#
+#
+# Advertise the Resolvable Set Identifier, so the initiator is able to
+# resolve this device as a member of the set, otherwise it is streamed
+# to on its own.
+#
+advertise.rsi on
+advertise on
diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 78411f4dd47d..3fc3439c118e 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -316,6 +316,9 @@ each side, so the initiator has to discover both before it can stream:
 	both acceptors share the same SIRK, so they are resolved into a
 	single set, and one CIS per member carries its channel
 
+	connecting one member connects the rest of the set, so the
+	initiator only connects once
+
 	--> connection is initiated by      ==> audio flows towards
 
 The acceptors run `bluetoothd` with the same SIRK, so the initiator
@@ -356,24 +359,30 @@ test_bap_unicast_set_transport_created
 
 :Steps:
 	1. Start `bluetoothctl` with the scripts on the three hosts.
-	2. Pair the initiator with each acceptor over LE.
-	3. Initiator: ``endpoint.config <remote endpoint>
-	   /local/endpoint/ep0 16_2_1``, for the remote PAC Sink endpoint
-	   of each member.
+	2. Pair the initiator with one of the acceptors over LE.
 
 :Expected:
 	1. ``Endpoint /local/endpoint/ep0 registered`` on the three hosts.
-	2. ``Pairing successful`` for both, and the members are resolved
-	   into a single set, reported as
-	   ``[NEW] DeviceSet /org/bluez/hci0/set_<sirk>`` listing both
-	   devices.
+	2. ``Pairing successful``, the members are resolved into a single
+	   set, reported as
+	   ``[NEW] DeviceSet /org/bluez/hci0/set_<sirk>``, and the other
+	   member is bonded on its own, without the initiator connecting
+	   or pairing it.
 	3. A transport is created for each member, one per channel, i.e.
 	   one for the Front Left endpoint and one for the Front Right
 	   one.
 
-:Notes: Without the same SIRK, or without the RSI in the advertising,
-	the members are not resolved into a set and each is streamed to
-	on its own, which is not what this test covers.
+	The endpoints are not configured by the test: the daemon
+	configures a stream for them on its own, and configuring them
+	again would add a CIS to the CIG for every extra configuration.
+
+:Notes: Only one member is connected: finding a member of a set
+	triggers connecting the remaining ones, so a single
+	**org.bluez.Device(5)** ``Connect`` covers the whole set.
+
+	Without the same SIRK, or without the RSI in the advertising, the
+	members are not resolved into a set, each is connected on its own
+	and the set behaviour this test covers does not happen.
 
 test_bap_unicast_set_transport_acquire
 --------------------------------------
@@ -386,6 +395,7 @@ test_bap_unicast_set_transport_acquire
 :Expected: ``Acquire successful: fd <fd> MTU <read>:<write>`` for each
 	transport, and both move to ``State: active``.
 
-:Notes: As for a stereo stream to a single acceptor, the CIS are only
-	created once every CIS of the CIG is ready, so the transports of
-	both members have to be acquired.
+:Notes: As for a stereo stream to a single acceptor, the CIS of a CIG
+	are only created once every one of them is active, so the
+	transports of both members have to be acquired: acquiring only
+	one leaves the group incomplete and no CIS is created at all.
diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 6ffbf0371e0e..ce11dc38dc32 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -4,6 +4,7 @@
 Tests for BAP (LE Audio) using bluetoothctl in VM instances
 """
 
+import re
 import warnings
 
 import pytest
@@ -78,8 +79,18 @@ def script(name):
 
 def start_bluetoothctl(host, init_script):
     exe = find_exe("client", "bluetoothctl")
-    # -a auto: accept pairing and authorize services without prompting
-    ctl = host.pexpect.spawn([exe, "-a", "auto", "--init-script", script(init_script)])
+    # Accept pairing and authorize services without prompting, with a
+    # capability pairing Just Works, as there is no one to answer the
+    # entry of a passkey
+    ctl = host.pexpect.spawn(
+        [
+            exe,
+            "-a",
+            "auto:NoInputNoOutput",
+            "--init-script",
+            script(init_script),
+        ]
+    )
     ctl.expect("Endpoint /local/endpoint/ep0 registered")
     return ctl
 
@@ -99,10 +110,69 @@ def pair_le(host0, ctl0, host1, ctl1, advertise=True, services=False):
     if services:
         pending.append(f"Device {host1.bdaddr.upper()} ServicesResolved: yes")
 
+    pair_wait(ctl0, ctl1, pending)
+
+    ctl0.send("scan off\n")
+
+
+# Transport of the remote PAC Sink endpoint of a device
+TRANSPORT = r"Transport (/org/bluez/hci0/dev_{}/pac_sink\d+/fd\d+)"
+
+# What a command reports is printed as it runs, unlike what the peers
+# report over the air, so waiting the default timeout for it only makes
+# a failure slower
+REPLY_TIMEOUT = 5
+
+
+def list_transports(ctl0, hosts):
+    """
+    List the transports already available for the given hosts, giving
+    None for those that are not.
+
+    The listing has no end of its own, so a command with a known output
+    is issued after it to tell when everything has been listed.
+    """
+    patterns = [TRANSPORT.format(dev_addr(host)) for host in hosts]
+
+    ctl0.send("transport.list\nversion\n")
+
+    transports = [None] * len(patterns)
+
+    while True:
+        idx, m = ctl0.expect([r"Version \d"] + patterns, timeout=REPLY_TIMEOUT)
+        if not idx:
+            return transports
+
+        transports[idx - 1] = m[0].decode("utf-8")
+
+
+def remove_device(ctl0, host):
+    """
+    Remove the given host, so the test starts from a state where it is
+    neither paired nor connected.
+    """
+    addr = host.bdaddr.upper()
+
+    ctl0.send(f"remove {addr}\n")
+
+    # Not matched with expect_all: a device that is not available is
+    # simply one with nothing to remove, not a failure
+    ctl0.expect(
+        rf"Device has been removed|Device {addr} not available",
+        timeout=REPLY_TIMEOUT,
+    )
+
+
+def pair_wait(ctl0, ctl1, pending):
+    """
+    Wait for the given events while answering the pairing requests.
+    """
     # See test_bluetoothctl_pair_le: passkey confirmation is handled by
     # the auto agent, but legacy passkey entry still needs an answer
     legacy = r"\[agent\].*Passkey:.*m(\d+)"
 
+    pending = list(pending)
+
     while pending:
         idx, m = ctl0.expect(FAILURES + [legacy] + pending)
 
@@ -123,8 +193,6 @@ def pair_le(host0, ctl0, host1, ctl1, advertise=True, services=False):
 
         pending.pop(idx - 1)
 
-    ctl0.send("scan off\n")
-
 
 unicast_host_config = host_config(
     [Bluetoothd(conf=BAP_CONF), Pexpect()],
@@ -337,3 +405,156 @@ def test_bass_past_transport_acquire(hosts):
             f"Transport {transport} State: active",
         ],
     )
+
+
+# Key shared by the members of the set, see [CSIS] in main.conf
+SIRK = "861FAE703ED681F0C50B34155B6434FB"
+
+# A set is exposed under the SIRK of its members, in reverse byte order
+SET_PATH = "set_" + bytes.fromhex(SIRK)[::-1].hex()
+
+
+def csip_conf(rank):
+    """
+    Configuration of a member of a coordinated set: the key and the size
+    describe the set, so they are the same for every member, while the
+    rank identifies the member within it.
+    """
+    return BAP_CONF + f"""
+[CSIS]
+SIRK = {SIRK}
+Encryption = true
+Size = 2
+Rank = {rank}
+"""
+
+
+set_host_config = host_config(
+    [Bluetoothd(conf=BAP_CONF), Pexpect()],
+    [Bluetoothd(conf=csip_conf(1)), Pexpect()],
+    [Bluetoothd(conf=csip_conf(2)), Pexpect()],
+)
+
+
+@pytest.fixture
+def set_hosts(hosts):
+    """
+    Initiator (host0) and two acceptors forming a coordinated set, one
+    taking the left channel (host1) and one the right (host2), paired
+    over LE.
+    """
+    host0, host1, host2 = hosts
+
+    initiator = start_bluetoothctl(host0, "bap-source-lc3.bt")
+    left = start_bluetoothctl(host1, "bap-sink-lc3-left.bt")
+    right = start_bluetoothctl(host2, "bap-sink-lc3-right.bt")
+
+    # Every member has to be advertising before connecting, so the set
+    # can be resolved and the remaining members found. The acceptors
+    # advertise themselves, as they have to include the RSI.
+    #
+    # Matched before anything else is read from them, as an expect
+    # discards everything before what it matches.
+    left.expect("Advertising object registered", timeout=REPLY_TIMEOUT)
+    right.expect("Advertising object registered", timeout=REPLY_TIMEOUT)
+
+    # A previous test may have left everything in place, in which case
+    # there is nothing to set up and the transports are used as they
+    # are
+    transports = list_transports(initiator, (host1, host2))
+
+    if all(transports):
+        yield host0, host1, host2, initiator, left, right, transports
+        return
+
+    # Otherwise the setup starts from a clean state: a device kept from
+    # a previous test would already be paired, connected and part of
+    # the set, so none of the events waited for below would be
+    # reported again
+    remove_device(initiator, host1)
+    remove_device(initiator, host2)
+    remove_device(left, host0)
+    remove_device(right, host0)
+
+    initiator.send("scan on\n")
+    initiator.expect(
+        f"Controller {host0.bdaddr.upper()} Discovering: yes",
+        timeout=REPLY_TIMEOUT,
+    )
+
+    # Connect only once every member has been found: the set is resolved
+    # from the RSI of the members that are already known, so a member
+    # found later would not be part of it
+    expect_all(
+        initiator,
+        [
+            f"Device {host1.bdaddr.upper()}",
+            f"Device {host2.bdaddr.upper()}",
+        ],
+    )
+
+    # Stop scanning before connecting, so the discovery does not
+    # interfere with the connections to the members
+    initiator.send("scan off\n")
+    initiator.expect(
+        f"Controller {host0.bdaddr.upper()} Discovering: no",
+        timeout=REPLY_TIMEOUT,
+    )
+
+    initiator.send(f"pair {host1.bdaddr.upper()}\n")
+
+    # Finding a member of a set connects the remaining ones, so the
+    # other member is neither connected nor paired by the test: it is
+    # bonded as reading its services requires an encrypted link, which
+    # is what is waited for. Its connection is not, as the link of a
+    # previous test may still be up, in which case the device is
+    # reported as connected from the start and never changes.
+    #
+    # The streams are configured by the daemon, so the transports are
+    # created without the test configuring the endpoints.
+    #
+    # The two members report independently, so their events interleave
+    # and have to be matched in any order, in a single pass including
+    # the pairing: an expect only reports what it matches and discards
+    # everything before it, so waiting for one event at a time drops
+    # the ones that happen meanwhile, e.g. a transport created while
+    # the pairing is still being waited for.
+    groups = expect_all(
+        initiator,
+        [
+            "Pairing successful",
+            f"DeviceSet /org/bluez/hci0/{SET_PATH}",
+            f"Device {host2.bdaddr.upper()} Bonded: yes",
+            TRANSPORT.format(dev_addr(host1)),
+            TRANSPORT.format(dev_addr(host2)),
+        ],
+    )
+
+    transports = [m[0].decode("utf-8") for m in groups[-2:]]
+
+    yield host0, host1, host2, initiator, left, right, transports
+
+
+@set_host_config
+def test_bap_unicast_set_transport_created(set_hosts):
+    host0, host1, host2, initiator, left, right, transports = set_hosts
+
+    # One transport per member, each taking a single channel
+    left.expect(TRANSPORT_RE)
+    right.expect(TRANSPORT_RE)
+
+
+@set_host_config
+def test_bap_unicast_set_transport_acquire(set_hosts):
+    host0, host1, host2, initiator, left, right, transports = set_hosts
+
+    # The CIS of a CIG are only created once every one of them is
+    # active, so the transports of both members have to be acquired
+    initiator.send("transport.acquire {} {}\n".format(*transports))
+
+    acquired = r"Acquire successful: fd \d+ MTU \d+:\d+"
+    expect_all(
+        initiator,
+        [acquired, acquired]
+        + [f"Transport {transport} State: active" for transport in transports],
+    )
-- 
2.55.0

