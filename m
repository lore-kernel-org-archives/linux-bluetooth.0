Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34123DC4CC
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 19:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981812; cv=none; b=kyBP/gkgG6liJDwuTb7Nc+38WZEFyOBU0QJe40lq1fJ955qMFQ6NYQY8VqlXIkt5/W7odLXz8nqGdVFavAvetjZMPxUI8wU1jV1ENFx/b1tmbBJa2gTmef61x+uwzudcpioq+YBSicn1brYG5jOLS1dQMIEIaIkQFuQPl0Lkiqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981812; c=relaxed/simple;
	bh=4DWtJWIyBgZowJHq0LoRUM/uIe//X6506JstLpQrRew=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfXBDigecMjwJ9qN6OiFshc7aZ2mCRxyxn37H5h146Q9j3kDMYMl1jokl5jYBFKh1PuGryHlA4NbMZD9/f7w9t5YgJJ4HBP90YqR4QOsj0KmXCeM+JPnrubRoOXD76hYX6fo4EtJYsjC+wqqyWDlQrTMdvO2GPtzqY1WT/vS5ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYh+EZUO; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYh+EZUO"
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-782e0fc1e55so2072002137.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 12:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981808; x=1789586608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5LGGv3ipVQbp/7Rp2WXLGcmN527tC/GnR6d15Vbyc7U=;
        b=KYh+EZUOhrhIUZGRyWnVTw2fMdE5vhFVE38Z0Sv/17OrIVlh9uvkWt2fzpgvxvLxNy
         q8BknFMLDPd2dxxKZDemq/1NXmCNLKSw4VieCdDtL+tNdKzQ96qL3cMiiFsBYt4ZT5Ig
         yRJ35KZ1UVCRhdxIdPLZvXL0KJbM9/Y9aBI3uGguL/Z6LHvN4yYLvdyxOzvaIIzrDo6G
         WzMoDbQO8oP3KZBwFr14UPcKDpHr1zG95IUyKMaDEKxLOo0vAfDwGHBsa79m9i6NSJ46
         nTs2bt6i3VjRzHz5dROyvStRbBXXDBodhCaigIM2U5uNe96uaI8n6nOywyKIFGKf/Hcj
         /87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981808; x=1789586608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5LGGv3ipVQbp/7Rp2WXLGcmN527tC/GnR6d15Vbyc7U=;
        b=OqzY3cDUdxaBXSvOT+vniOdyjTSgoImwT+xED2y4MdLTVyr9fx8BgZsUErJbOnDjcU
         7eFgHXS5cpilpXxe7ACMyMgxLzQyZbL/Fq35IPcM9+C1uwElPzLlF8Vq/EYa/xzFuDrG
         J6zPSNqUA130fOMkmgymWI4sE9xYhwjU8STXMPn1pJEEpWhLnUoA3Ubmys+rvN9LyMvK
         jWn3wbJ5H6M4tunTyqM5JHbj3/8Hs/kd0/zHm6GkNZImEWk3EbEE7wfpMp5GcjkME/pU
         9TCfo24PBxdl89NqZQ97lgLOpooLzbqhDKD8gkQTW3knVxz4dI1EbIbd56i0ZGJEfuYo
         u8KQ==
X-Gm-Message-State: AFuF++lJ1B2mOkuU3jsYBb97pD7KyoTjFVdktAOGfjUow3oYsvXvWGjv
	4QKBVnQs4QTW7jKNz6TCvJO4x28RQctkhZnD/+T3wSSSyDrC/TdSIjdjlo4U2t6b
X-Gm-Gg: AYBFou3iiDxNs1ULKci3namFVNaLMR8NElVNlaW2isSHBNCZCLraYN1UzZe6LGtQN/o
	QfAHEvkhMe3l2FX0aRroEK7P+7h4CavxXq3o5VpyGhjizi1hMKlvOOdugiYWObyIAnjSI0UlQ0W
	GWTv8/eKvZbqdWN5Tgmpr4B6TdSxAw1Lt4y2OKE3+N8aahMhBVUyskrZI0yMkPiq0pfmugl99CB
	QvPJb2o7Qe73Cy0dbmk6T7dCB4TnhREQPoLl/obDSs6M3C9aG2xyE6cWX7MyjcFoCrdAZnb1DCt
	/mwMjnKif5l9TAw0ytPy+aqSJRmkAvle54ssOAeE1bY+Jcf1dtK3308VbkSrASRWkppdMpMVHOR
	N1d8dme23wopZtghmz7c4chdYwAR/9gAkbdhgeZdpxCJrfbOJ3CKmV5HSSHeJrIWUdyDVztnxu4
	DxU5xohD8yhNhEvqTVQ3JNOzmysrBtcQdE272PzOy+Cc3wiP/CXYFzXfKR+ctogNxmcy7J9AmG9
	WOoY/0U2v1QxpKRMWWa16To/RtyTuslIS2blMzOBEHqIWolY0XIE5sxH/DLz3S8nw==
X-Received: by 2002:a05:6102:f83:b0:784:94dd:5389 with SMTP id ada2fe7eead31-78a4a9ae110mr15836442137.13.1788981808256;
        Wed, 09 Sep 2026 12:23:28 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee8039csm13162744241.11.2026.09.09.12.23.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:23:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 11/12] test: functional: add BAP broadcast assistant test
Date: Wed,  9 Sep 2026 15:23:07 -0400
Message-ID: <20260909192308.1306567-12-luiz.dentz@gmail.com>
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

Add a test covering the Broadcast Assistant sharing a broadcast with a
Scan Delegator, with the Broadcast Source and the Broadcast Assistant
colocated so the assistant shares its own broadcast. The delegator
receives the periodic advertising sync over the connection to the
assistant (PAST), instead of scanning the source itself.

The topology where the assistant relays a source it scanned, which
does not use PAST, needs the assistant on a third host and can be
added later.

Assisted-by: opencode:claude-opus-5
---
 doc/functional-bap.rst      |  94 +++++++++++++++++++++++++++++
 test/functional/test_bap.py | 115 ++++++++++++++++++++++++++++++------
 2 files changed, 192 insertions(+), 17 deletions(-)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 99a3d63eef68..f9392bd2dbce 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -194,3 +194,97 @@ test_bap_broadcast_transport_acquire[lc3|pbp]
 	not issue ``transport.acquire`` itself. The broadcast code has to
 	match the one the source encrypted the BIG with, otherwise the
 	sink cannot decrypt the stream.
+
+BROADCAST ASSISTANT
+===================
+
+Two hosts, with the Broadcast Source and the Broadcast Assistant
+colocated on host0, sharing its own broadcast with the Scan Delegator:
+
+.. code-block::
+
+	+------------------------+                 +------------------------+
+	| host0                  |                 | host1                  |
+	| Broadcast Source       |   extended +    | Scan Delegator         |
+	| + Broadcast Assistant  |  periodic adv   | (Broadcast Sink)       |
+	| bluetoothctl -a auto   | --------------> | bluetoothctl -a auto   |
+	| broadcast-source.bt    |                 | broadcast-delegator.bt |
+	| BCAA endpoint (0x1852) |   BIG (BIS 1)   | BAA endpoint (0x1851)  |
+	|                        | ==============> |                        |
+	|                        | ACL, BASS, PAST |                        |
+	|                        | --------------> |                        |
+	+------------------------+                 +------------------------+
+
+	--> advertising is scanned by          ==> audio flows towards
+
+	The assistant connects to the delegator over ACL and shares the
+	local broadcast with it: the delegator receives the periodic
+	advertising sync over that connection (PAST), rather than scanning
+	the source itself.
+
+``client/scripts/broadcast-source.bt`` on host0
+	Registers a Broadcast Source endpoint
+	(``00001852-0000-1000-8000-00805f9b34fb``) with LC3, configures it
+	with the 16_2_1 preset and acquires the transport, which starts
+	the broadcast. The stream is encrypted with the broadcast code
+	`bluetoothctl` uses by default.
+
+``client/scripts/broadcast-delegator.bt`` on host1
+	Registers a Broadcast Sink endpoint
+	(``00001851-0000-1000-8000-00805f9b34fb``) with LC3, enables
+	automatic transport selection and acquisition, and advertises, so
+	the Broadcast Assistant can discover it and connect.
+
+The local broadcast of host0 is exposed as a MediaAssistant object in
+the ``local`` state, under the adapter path, e.g.
+``/org/bluez/hci0/sid0/bis1``. The push is driven through the commands
+of the assistant submenu, see **bluetoothctl-assistant(1)**.
+
+test_bass_past_transport_acquire
+--------------------------------
+
+:Setup: As above.
+
+:Steps:
+	1. Start `bluetoothctl` with the source script on host0 and the
+	   delegator script on host1.
+	2. Assistant: ``scan on``, wait for the delegator device, then
+	   ``connect`` it.
+	3. Assistant: ``assistant.push <local assistant path>``, answering
+	   the device prompt with the delegator device path and, if asked,
+	   the broadcast code prompt with the code the stream is encrypted
+	   with.
+
+:Expected:
+	1. ``Acquire successful: fd <fd> MTU <read>:<write>`` on the
+	   source, i.e. it is broadcasting, and the local stream is
+	   exposed as ``[NEW] Assistant <adapter>/sid0/bis1``. On the
+	   delegator, ``Advertising object registered``.
+	2. ``Connection successful``, with the delegator authorizing the
+	   assistant.
+	3. ``Assistant <path> pushed``.
+	4. On the delegator a transport is created for the BIS, and
+	   selected and acquired automatically, reaching
+	   ``State: broadcasting``, i.e. it synced to the BIG, and then
+	   ``State: active``.
+
+:Notes: The delegator does not scan the source: it syncs to the
+	periodic advertising over the ACL to the assistant, as pushing a
+	local stream requests PAST. When instead the assistant scans and
+	relays a *remote* source, it shares the stream without PAST and
+	the delegator has to sync by scanning itself; that topology, with
+	the assistant on a third host, is left to be added later.
+
+	The broadcast code of the local stream is handed to the delegator
+	by the push, so its automatic transport selection does not have to
+	prompt for it, and the push itself is only asked for the device to
+	share the stream with.
+
+	The delegator is paired first: the Broadcast Receive State
+	characteristic requires an encrypted link, and without it the
+	assistant fails to read it and the push is rejected with
+	``org.bluez.Error.InvalidArguments``.
+
+	The stream is verified on the delegator rather than through the
+	state of the MediaAssistant object, as an object created for a
+	local stream stays in the ``local`` state.
diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 6b62338ac676..bc9bcfb83ad8 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -34,13 +34,18 @@ def dev_addr(host):
 
 def expect_all(ctl, patterns):
     """
-    Expect all the given patterns, in any order.
+    Expect all the given patterns, in any order, returning the groups
+    each of them matched.
     """
-    patterns = list(patterns)
+    pending = list(enumerate(patterns))
+    groups = [None] * len(patterns)
 
-    while patterns:
-        idx, _ = ctl.expect(patterns)
-        patterns.pop(idx)
+    while pending:
+        idx, m = ctl.expect([pattern for _, pattern in pending])
+        groups[pending[idx][0]] = m
+        pending.pop(idx)
+
+    return groups
 
 
 def script(name):
@@ -63,28 +68,39 @@ def start_bluetoothctl(host, init_script):
     return ctl
 
 
-def pair_le(host0, ctl0, host1, ctl1):
+def pair_le(host0, ctl0, host1, ctl1, advertise=True, services=False):
     ctl0.send("scan on\n")
     ctl0.expect(f"Controller {host0.bdaddr.upper()} Discovering: yes")
 
-    ctl1.send("advertise on\n")
-    ctl1.expect("Advertising object registered")
+    if advertise:
+        ctl1.send("advertise on\n")
+        ctl1.expect("Advertising object registered")
 
     ctl0.expect(f"Device {host1.bdaddr.upper()}")
     ctl0.send(f"pair {host1.bdaddr.upper()}\n")
 
+    pending = ["Pairing successful"]
+    if services:
+        pending.append(f"Device {host1.bdaddr.upper()} ServicesResolved: yes")
+
     # See test_bluetoothctl_pair_le: passkey confirmation is handled by
     # the auto agent, but legacy passkey entry still needs an answer
-    idx, m = ctl0.expect([r"\[agent\].*Passkey:.*m(\d+)", "Pairing successful"])
+    legacy = r"\[agent\].*Passkey:.*m(\d+)"
 
-    if idx == 0:
-        warnings.warn(
-            "BUG: we got passkey authentication, bluetoothd/kernel should be fixed"
-        )
-        key = m[0].decode("utf-8")
-        ctl1.expect(r"\[agent\] Enter passkey \(number in 0-999999\):")
-        ctl1.send(f"{key}\n")
-        ctl0.expect("Pairing successful")
+    while pending:
+        idx, m = ctl0.expect([legacy] + pending)
+
+        if idx == 0:
+            warnings.warn(
+                "BUG: we got passkey authentication, bluetoothd/kernel "
+                "should be fixed"
+            )
+            key = m[0].decode("utf-8")
+            ctl1.expect(r"\[agent\] Enter passkey \(number in 0-999999\):")
+            ctl1.send(f"{key}\n")
+            continue
+
+        pending.pop(idx - 1)
 
     ctl0.send("scan off\n")
 
@@ -235,3 +251,68 @@ def test_bap_broadcast_transport_acquire(hosts, source_script):
             f"Transport {transport} State: active",
         ],
     )
+
+
+past_host_config = host_config(
+    [Bluetoothd(conf=BAP_CONF), Pexpect()],
+    [Bluetoothd(conf=BAP_CONF), Pexpect()],
+)
+
+LOCAL_ASSISTANT_RE = r"Assistant (/org/bluez/\S+/sid\d+/bis\d+)"
+
+
+@past_host_config
+def test_bass_past_transport_acquire(hosts):
+    source_host, delegator_host = hosts
+
+    # Source broadcasting, and its own stream exposed as a local
+    # MediaAssistant object
+    source = start_bluetoothctl(source_host, "broadcast-source.bt")
+    groups = expect_all(
+        source,
+        [LOCAL_ASSISTANT_RE, r"Acquire successful: fd \d+ MTU \d+:\d+"],
+    )
+    assistant_path = groups[0][0].decode("utf-8")
+
+    # Delegator advertising, selecting and acquiring automatically
+    delegator = start_bluetoothctl(delegator_host, "broadcast-delegator.bt")
+    delegator.expect("Advertising object registered")
+
+    # Pair with the delegator: the Broadcast Receive State requires
+    # an encrypted link to be read
+    pair_le(
+        source_host,
+        source,
+        delegator_host,
+        delegator,
+        advertise=False,
+        services=True,
+    )
+
+    # Share the local broadcast: the delegator receives the periodic
+    # advertising sync over the connection (PAST)
+    source.send(f"assistant.push {assistant_path}\n")
+    source.expect(r"Enter Device \(path\):")
+    source.send(f"/org/bluez/hci0/dev_{dev_addr(delegator_host)}\n")
+
+    # The local stream may already know the broadcast code
+    idx, _ = source.expect(
+        [r"Enter Broadcast Code \(auto/value\):", r"Assistant \S+ pushed"]
+    )
+    if idx == 0:
+        source.send(f"{BCAST_CODE}\n")
+        source.expect(r"Assistant \S+ pushed")
+
+    # A transport is created on the delegator, selected and acquired
+    # automatically
+    _, m = delegator.expect(TRANSPORT_RE)
+    transport = m[0].decode("utf-8")
+
+    expect_all(
+        delegator,
+        [
+            r"Acquire successful: fd \d+ MTU \d+:\d+",
+            f"Transport {transport} State: broadcasting",
+            f"Transport {transport} State: active",
+        ],
+    )
-- 
2.55.0

