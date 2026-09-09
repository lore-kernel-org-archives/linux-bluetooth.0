Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C134A468C2F
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 19:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788981810; cv=none; b=jfgc5ZT/8ndPtfnRf/oG575p6zMIEi7lb4Zw5JL0Og1oyYlVJx9e4DKDYt0wfTlzOfW3l0Bvc2N5aelXx9uUWZL3iV8KOu9PGkLKeQaFAD6/CaXuEz4EpnqFyiLXwgBNapYQY8/MxMAyEDSAAOlwAet+Z2c5l+a+40f6cuW9Or0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788981810; c=relaxed/simple;
	bh=cbzdwbuEknIOoBZWIl5F6nV+lyogpP8JEEbVgTmbaS4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcI8LhBDOUuARQwySDfAJxwOviFTbTh9hMFcrfaXm3dPWI6/0g7N7sCgElpNdcX1MspUAnkUAEZV0NTmlvkuP0udVKSekSf3xSZVxye3YpfvlneXyO0Vbhg3LHr0DinPy0uuI1nkBsrfmS2wb6E5BEqUL+PR2rC9RtE8NrZY60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB+hWDLS; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB+hWDLS"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-966e7380109so4664067241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2026 12:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788981807; x=1789586607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iYdMIQVo+XsJissvDX+a8n+D3rlyM9Ofrwj4rXOTSNk=;
        b=bB+hWDLSRNvrqPSIDY3/Gk4bwSYHkfFEkEC8LUbqsgR29/Y7LE1hTXGzj82lVq+CG2
         CpSlBBaz+s0LgpkkZNwPpEMZTMbxlFUIzL4pOsOHODhKv+7OZHFRc++qWym8aLbuKOKY
         UTYvesKTyi0CJuoVOJj0wTFWkjTtuQHOZr4X7Bt+QypiYmsitLB4fLdkJAYyr9OiflaO
         i61vX1k4gPpfFyhNdmtOCAKf6FeCkPrhOkRPDO91ZWZb4EvqkHNYMrfrhjm7GqI5ncUW
         PRU2qHb5ut5YSNlItbPB9FZiqvcle7gz0iyVx7EGKnIOODz3u8TQfXKKTy2Cs77aiDd8
         TDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788981807; x=1789586607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=iYdMIQVo+XsJissvDX+a8n+D3rlyM9Ofrwj4rXOTSNk=;
        b=ZnWB7uejo+TWNSQrWZ0WxpwWYjFjbgPQmCOHEUyMCr1BzHS/7vUw9zFsrRH3lha7x3
         Ro4W3flTs5RHh/EZd43IuLsY5FSaM6lPv1GRIbiKZKVG71OIe/3vHBuAxdYgelV17KDI
         +6ixTlEt9Hh9hzaD3uyiMR+ArCfgdzJ6yrKNZOzLOJ4klTku6cFof/UfNtz25CP9kyW9
         NhyGrD5qRvCsI5YrjJg5dVA3MYbFty7ZQ/ooD2MPDb3LajORMmOSodMIxKytggNQLAf+
         66x5IU4YYEWs7xWDOnNBWdiZSatjQeg8EZ1RpaL7ORG0/9ZOK8I4MYg+JGltEm+y6+Ql
         29wA==
X-Gm-Message-State: AFuF++mTZexUEBrayMmdjI3+Pubgx6HinJhXO/5knVLkt1eApOaamCJC
	lhRsv7wdq087A1BybsyRFlNpoa8QUYGQecpKlF5L9+EmjVBDh1LNWV6QSby6Bs4K
X-Gm-Gg: AYBFou1zkXJfJJpAUrlcH1eWviR+aHHdC4Wfkyn2iVwAaaawEAe3T1omcGYkEphyNJG
	0b8SEvXXBn4JliBldbOYcJ4w206NTHNFLiqk93YdmKqvh6Oz2MrE6rICIfwaYbhAIu3ioEN7wAz
	6zr6aHHRL2iG35OW1cy250M+Kat9qXK7cD/udiQhnVxRdBbdKvR4i7genc1NQzRCd/k+AuhfH3w
	RDhJ9MlK2+kTrTepCekjZhukPLWFqzJjCCTgrMGzqgWtPXvsA0HrbwdlsrhFdCz9QGEOv7G4Po/
	tlAOjjywTPm2Wj37SFZ2vqpGgzLjZm4rjJqkkDI2pC7OG5jeNysDy7zVB4OSmtX/aLEdB+L93FV
	kXk8dDaQJlfV6MhoTaQN1ZiUemIHZed5YQswMFBwkhe21Is7X+fcDi3qxITOxeRqwZkfYVnUpfo
	XPVfgl1OaIiUFO0JVZ5RBXI1kDw1R2xewzNfJC91FImPsHlj2kL4vKqhJ4EiiuRGf7Vz0ZmrCKv
	XkhoND7of59pjY3PeYt3lHv5rBMsG1wBNYfZTvrTkq0cxNZlVu/kfeq5uU5n+YR6g==
X-Received: by 2002:a05:6102:54a8:b0:785:c960:ff85 with SMTP id ada2fe7eead31-78a4a8e5299mr18133037137.7.1788981807390;
        Wed, 09 Sep 2026 12:23:27 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9808ee8039csm13162744241.11.2026.09.09.12.23.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:23:26 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 10/12] test: functional: add BAP broadcast tests
Date: Wed,  9 Sep 2026 15:23:06 -0400
Message-ID: <20260909192308.1306567-11-luiz.dentz@gmail.com>
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

Add tests covering BAP broadcast via bluetoothctl: the Broadcast
Source registers a BCAA endpoint, configures it and starts the
broadcast, while the Broadcast Sink registers a BAA endpoint and scans,
syncing to the periodic advertising on its own, without a Broadcast
Assistant. Run them for a plain broadcast and for a Public Broadcast
Profile one.

test_bap_broadcast_transport_created checks a MediaTransport1 object is
created for each BIS of the BASE, and test_bap_broadcast_transport_acquire
checks selecting the transport with the broadcast code moves it to
broadcasting and acquiring it succeeds.

Assisted-by: opencode:claude-opus-5
---
 doc/functional-bap.rst      | 121 +++++++++++++++++++++++++++++++-----
 test/functional/test_bap.py |  68 ++++++++++++++++++++
 2 files changed, 172 insertions(+), 17 deletions(-)

diff --git a/doc/functional-bap.rst b/doc/functional-bap.rst
index 6b67df541e97..99a3d63eef68 100644
--- a/doc/functional-bap.rst
+++ b/doc/functional-bap.rst
@@ -13,6 +13,23 @@ suite.
 SETUP
 =====
 
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
+registration script from `client/scripts`.
+
+UNICAST
+=======
+
 Two hosts, connected over LE:
 
 .. code-block::
@@ -31,20 +48,6 @@ Two hosts, connected over LE:
 
 	--> connection is initiated by      ==> audio flows towards
 
-BAP requires the ISO socket support, so all hosts run `bluetoothd`
-with:
-
-.. code-block::
-
-	[General]
-	Experimental = true
-	KernelExperimental = true
-	ControllerMode = le
-
-`bluetoothctl` is started with ``-a auto``, so pairing and service
-authorization are accepted without prompting, and with an endpoint
-registration script:
-
 ``client/scripts/bap-source-lc3.bt`` on host0
 	Registers a local PAC Source endpoint
 	(``00002bcb-0000-1000-8000-00805f9b34fb``) with LC3. host0 is the
@@ -55,9 +58,6 @@ registration script:
 	(``00002bc9-0000-1000-8000-00805f9b34fb``) with LC3. host1 is the
 	acceptor, i.e. the device receiving audio.
 
-TEST CASES
-==========
-
 test_bap_unicast_transport_created
 ----------------------------------
 
@@ -107,3 +107,90 @@ test_bap_unicast_transport_acquire
 	The acceptor does not have to acquire its transports for the CIS to
 	be established, as `bluetoothd` sets up the ISO listener on its own
 	when the stream is enabled.
+
+BROADCAST
+=========
+
+Two hosts, with no connection between them:
+
+.. code-block::
+
+	+------------------------+                 +------------------------+
+	| host0                  |    extended +   | host1                  |
+	| Broadcast Source       |    periodic     | Broadcast Sink         |
+	| bluetoothctl -a auto   |   advertising   | bluetoothctl -a auto   |
+	| broadcast-source.bt    | --------------> | broadcast-sink.bt      |
+	| or -pbp variant        |                 |                        |
+	| BCAA endpoint (0x1852) |   BIS 0 (LC3)   | BAA endpoint (0x1851)  |
+	|                        | ==============> |                        |
+	+------------------------+                 +------------------------+
+
+	no ACL is established: the sink syncs to the periodic advertising,
+	reads the BASE from it and then syncs to the BIG
+
+	--> advertising is scanned by       ==> audio flows towards
+
+``client/scripts/broadcast-source.bt`` on host0
+	Registers a Broadcast Source endpoint
+	(``00001852-0000-1000-8000-00805f9b34fb``) with LC3, configures it
+	with the 16_2_1 preset and acquires the transport, which starts
+	the broadcast. The stream is encrypted with the broadcast code
+	`bluetoothctl` uses by default.
+
+``client/scripts/broadcast-source-pbp.bt`` on host0
+	As above, but adds the Public Broadcast Announcement service
+	(``0x1856``) to the extended advertising first, so the broadcast
+	is a Public Broadcast Profile one.
+
+``client/scripts/broadcast-sink.bt`` on host1
+	Registers a Broadcast Sink endpoint
+	(``00001851-0000-1000-8000-00805f9b34fb``) with LC3 and scans.
+
+Both test cases run for each source, i.e. with the ``lc3`` parameter
+for a plain broadcast and with ``pbp`` for a Public Broadcast Profile
+one.
+
+test_bap_broadcast_transport_created[lc3|pbp]
+---------------------------------------------
+
+:Setup: As above.
+
+:Steps:
+	1. Start `bluetoothctl` with the source script on host0.
+	2. Start `bluetoothctl` with the sink script on host1.
+	3. Sink: ``transport.show <transport>``.
+
+:Expected:
+	1. ``Endpoint /local/endpoint/ep0 registered``, then
+	   ``Acquire successful: fd <fd> MTU <read>:<write>`` on the
+	   source, i.e. it is broadcasting.
+	2. The sink syncs to the periodic advertising on its own and
+	   creates a transport per BIS described by the BASE, under
+	   ``/org/bluez/hci0/dev_XX/sidN/bisM/fdK``.
+	3. The transport reports ``Codec: 0x06`` for LC3 and
+	   ``State: idle``.
+
+:Notes: The sink does not need a Broadcast Assistant here: it scans,
+	finds the Broadcast Source and syncs by itself.
+
+test_bap_broadcast_transport_acquire[lc3|pbp]
+---------------------------------------------
+
+:Setup: As above, with the transport already created.
+
+:Steps:
+	1. Sink: ``transport.select <transport>``.
+	2. Answer ``Enter bcode[value/no]:`` with the broadcast code the
+	   source used.
+
+:Expected:
+	1. The transport moves to ``State: broadcasting``, i.e. the sink
+	   synced to the BIG.
+	2. ``Acquire successful: fd <fd> MTU <read>:<write>`` and the
+	   transport moves to ``State: active``.
+
+:Notes: Selecting the transport is what moves it out of idle, and
+	`bluetoothctl` starts acquiring it right after, so the test does
+	not issue ``transport.acquire`` itself. The broadcast code has to
+	match the one the source encrypted the BIG with, otherwise the
+	sink cannot decrypt the stream.
diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index 69430d7a6699..6b62338ac676 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -167,3 +167,71 @@ def test_bap_unicast_transport_acquire(unicast_hosts):
             f"Transport {right} State: active",
         ],
     )
+
+
+# Broadcast code used by the broadcast scripts, see BCAST_CODE in
+# client/player.c
+BCAST_CODE = (
+    "0x01 0x02 0x68 0x05 0x53 0xf1 0x41 0x5a " "0xa2 0x65 0xbb 0xaf 0xc6 0xea 0x03 0xb8"
+)
+
+BCAST_SOURCES = ["broadcast-source.bt", "broadcast-source-pbp.bt"]
+BCAST_IDS = ["lc3", "pbp"]
+
+broadcast_host_config = host_config(
+    [Bluetoothd(conf=BAP_CONF), Pexpect()],
+    [Bluetoothd(conf=BAP_CONF), Pexpect()],
+)
+
+
+def start_broadcast(hosts, source_script):
+    """
+    Source broadcasting with the given script, and sink scanning for it.
+    """
+    source_host, sink_host = hosts
+
+    source = start_bluetoothctl(source_host, source_script)
+    source.expect(r"Acquire successful: fd \d+ MTU \d+:\d+")
+
+    sink = start_bluetoothctl(sink_host, "broadcast-sink.bt")
+
+    return source, sink
+
+
+@broadcast_host_config
+@pytest.mark.parametrize("source_script", BCAST_SOURCES, ids=BCAST_IDS)
+def test_bap_broadcast_transport_created(hosts, source_script):
+    source, sink = start_broadcast(hosts, source_script)
+
+    # Sink syncs to the periodic advertising and creates a transport
+    # for each BIS described by the BASE
+    _, m = sink.expect(TRANSPORT_RE)
+    transport = m[0].decode("utf-8")
+
+    sink.send(f"transport.show {transport}\n")
+    sink.expect(f"Transport {transport}")
+    sink.expect(r"Codec: 0x06")
+    sink.expect("State: idle")
+
+
+@broadcast_host_config
+@pytest.mark.parametrize("source_script", BCAST_SOURCES, ids=BCAST_IDS)
+def test_bap_broadcast_transport_acquire(hosts, source_script):
+    source, sink = start_broadcast(hosts, source_script)
+
+    _, m = sink.expect(TRANSPORT_RE)
+    transport = m[0].decode("utf-8")
+
+    # Selecting the transport syncs to the BIG and starts acquiring it
+    sink.send(f"transport.select {transport}\n")
+    sink.expect(r"Enter bcode\[value/no\]:")
+    sink.send(f"{BCAST_CODE}\n")
+
+    expect_all(
+        sink,
+        [
+            f"Transport {transport} State: broadcasting",
+            r"Acquire successful: fd \d+ MTU \d+:\d+",
+            f"Transport {transport} State: active",
+        ],
+    )
-- 
2.55.0

