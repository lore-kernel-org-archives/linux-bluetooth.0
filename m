Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F7D3B1BD
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 00:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430863; cv=pass; b=a5P8a5aajphQzZ6DVRnkEDBTEahyczcX84DHq6QMWJvlKXbuY705UYwkgC13Iz4DElMlxQuoF8vOs/Z2PD80RX1OfMRVkmAVjOst9MuGILD0TsJUevtwH8OUPIPlx+ubVBnpmSI+v6QUaeOO6QL4lZTRiiGpM3bD5CaYtrRsp40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430863; c=relaxed/simple;
	bh=PKjMis0BTcdnTE1gggUvBcVUu8312r672aljE5YHpzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CFxki936VaapzdBe3K9OM3LyJrCcIwMhclxrepVotYhqOZnGqQVh78bPSsDIl8JHUBEUwI9MIZuDms5jvw1i/4vUt6somqeMBowwreAoEapFcNbvdU6ZmFu1wzAiYz5Azzieg57o1qYv2+bOE6C19u4mgLUcpZAAL2wyiauLVSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=d7P6/NGm; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="d7P6/NGm"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hkMlq2lFDzyxN;
	Tue, 15 Sep 2026 03:07:35 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789430855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CAtVFZgQK/qzNrvDmUARWTDGhNZp2eqrHpdxjuM4dZQ=;
	b=d7P6/NGmFUgPCJakoyj9u3pB8+5LuHP2Og+n/pgXgg/4NoFaC9kJu0mioEpuJfdbHgZExY
	H5hTmZ9Xz8O20gc0BB/z96dxfiySWW2RGqhQeQsrwM5Ro+MDhoD7Hayrh3h1Vi6E5V+R9V
	lr6soW3QMgtrxpBtDjR3Emh7TqrWaIk=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789430855;
	b=H+frrBhluLoBcYqA8cmVccPdlCwIjqqZVGZzZ+BYIJEyhpP1GAz85KthWqNMyIrjJ0YEZF
	t5zGa3Kaz1mtOAeI7OZu4kUxs0qTWx7jEbh+V9+O0nazvIdCzjMQAeJ9g7NXxn+ScgfZgJ
	HjJch4so1DwiT0F82t5vpwD/Le2fwlo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789430855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CAtVFZgQK/qzNrvDmUARWTDGhNZp2eqrHpdxjuM4dZQ=;
	b=RFoE1RLydOiY/8WxMrCHNqLzNg+fbRdbRHD5WAiWBJFHhvl+AWiUavSf3KlvgiI8CWUD2G
	QWlUyG8Z3xanFkRWe3q4HBGetDANWBRO5nX+vQmUKSyLa/d+0H5UIesNIjAYh9jK03rwR7
	SovlbqzWUGFFtslRyhw9b7cM5JIMr6M=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/3] test: functional: deduce pairing bearer in shared fixtures
Date: Tue, 15 Sep 2026 03:07:19 +0300
Message-ID: <e708bbed36f9383b6d92b2313ee003848f87fdd7.1789430529.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789430529.git.pav@iki.fi>
References: <cover.1789430529.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make paired_hosts deduce the pairing bearer from the host
configuration instead of using BR/EDR only, with the LE pairing helper
pair_le in le_utils. No behavior change.

Assisted-by: opencode:qwen3.8-flash-next
---
 doc/functional-testing.rst          |  6 ++---
 test/functional/conftest.py         | 23 ++++++++++++++++---
 test/functional/le_utils.py         | 35 +++++++++++++++++++++++++++++
 test/functional/test_avrcp.py       |  4 ++--
 test/functional/test_mpris_proxy.py |  4 ++--
 test/functional/test_obex.py        |  8 +++----
 6 files changed, 66 insertions(+), 14 deletions(-)
 create mode 100644 test/functional/le_utils.py

diff --git a/doc/functional-testing.rst b/doc/functional-testing.rst
index 6fdc17b9a..ca7bfa672 100644
--- a/doc/functional-testing.rst
+++ b/doc/functional-testing.rst
@@ -83,9 +83,9 @@ test_agent_pair_bredr[accept]
 	   passkey.
 	4. ``org.bluez.Device1.Pair`` replies successfully.
 
-:Notes: This test is also used as the ``paired_hosts_bredr`` fixture
-	(see `test/functional/conftest.py`), which other tests reuse to
-	get two already paired hosts.
+:Notes: This test is also used by the ``paired_hosts`` fixture (see
+	`test/functional/conftest.py`), which other tests reuse to get two
+	already paired hosts.
 
 test_agent_pair_bredr[reject]
 -----------------------------
diff --git a/test/functional/conftest.py b/test/functional/conftest.py
index 6f50efe0e..ce6301319 100644
--- a/test/functional/conftest.py
+++ b/test/functional/conftest.py
@@ -5,6 +5,8 @@ import re
 from pathlib import Path
 import pytest
 
+from .le_utils import host_setup_is_le, pair_le
+
 
 def pytest_addoption(parser):
     parser.addoption(
@@ -66,11 +68,26 @@ def pytest_collection_modifyitems(session, config, items):
 
 
 @pytest.fixture
-def paired_hosts_bredr(hosts):
+def is_le(host_setup):
+    """True if the current host configuration runs bluetoothd in LE-only mode."""
+    return host_setup_is_le(host_setup)
+
+
+@pytest.fixture
+def paired_hosts(hosts, is_le):
+    """
+    Two hosts, paired over the bearer their host configuration uses.
+    """
     from .test_agent import test_agent_pair_bredr
 
-    if hosts[0].agent.has_device(hosts[1].bdaddr):
+    host0, host1 = hosts
+
+    if host0.agent.has_device(host1.bdaddr):
         return hosts
 
-    test_agent_pair_bredr(hosts, True)
+    if is_le:
+        pair_le(host0, host1)
+    else:
+        test_agent_pair_bredr([host0, host1], True)
+
     return hosts
diff --git a/test/functional/le_utils.py b/test/functional/le_utils.py
new file mode 100644
index 000000000..03bbbfb24
--- /dev/null
+++ b/test/functional/le_utils.py
@@ -0,0 +1,35 @@
+# -*- coding: utf-8; mode: python; eval: (blacken-mode); -*-
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""Generic LE helpers for functional tests."""
+
+from pytest_bluezenv import (
+    Bluetoothd,
+    wait_until,
+)
+
+
+def host_setup_is_le(host_setup):
+    """True if the hosts run bluetoothd in LE-only mode."""
+    return any(
+        "ControllerMode = le" in (p.conf or "")
+        for plugins in host_setup["setup"]
+        for p in plugins
+        if isinstance(p, Bluetoothd)
+    )
+
+
+def pair_le(client, server):
+    """
+    Pair Just Works over LE: client initiates and server authorizes, so
+    only a single RequestAuthorization is expected.
+    """
+    server.agent.adapter_set("Pairable", True)
+
+    client.agent.adapter_method("StartDiscovery")
+    client.agent.expect("org.bluez.Adapter1.StartDiscovery:reply")
+    wait_until(client.agent.has_device, server.bdaddr)
+
+    client.agent.device_method(server.bdaddr, "Pair")
+    server.agent.expect("org.bluez.Agent1.RequestAuthorization")
+    server.agent.reply()
+    client.agent.expect("org.bluez.Device1.Pair:reply")
diff --git a/test/functional/test_avrcp.py b/test/functional/test_avrcp.py
index 3b04c9615..f6ede96cb 100644
--- a/test/functional/test_avrcp.py
+++ b/test/functional/test_avrcp.py
@@ -43,8 +43,8 @@ class CheckAvrcpCrash_GHSA_m2vx_pw5f_rc8v(HostPlugin):
         Agent(),
     ],
 )
-def test_avrcp_GHSA_m2vx_pw5f_rc8v(paired_hosts_bredr):
-    client, server = paired_hosts_bredr
+def test_avrcp_GHSA_m2vx_pw5f_rc8v(paired_hosts):
+    client, server = paired_hosts
 
     client.agent.device_method(
         server.bdaddr, "ConnectProfile", "0000110c-0000-1000-8000-00805f9b34fb"
diff --git a/test/functional/test_mpris_proxy.py b/test/functional/test_mpris_proxy.py
index 54b888c79..15e775621 100644
--- a/test/functional/test_mpris_proxy.py
+++ b/test/functional/test_mpris_proxy.py
@@ -325,7 +325,7 @@ def vm_set_trusted(bdaddr):
 
 
 @pytest.fixture
-def mpris_player(paired_hosts_bredr):
+def mpris_player(paired_hosts):
     """
     Two paired and trusted hosts, the client connected to the dummy MPRIS
     player of the server, exported on the client session bus by
@@ -336,7 +336,7 @@ def mpris_player(paired_hosts_bredr):
 
     Yields (client, server, exported player bus name).
     """
-    client, server = paired_hosts_bredr
+    client, server = paired_hosts
 
     client.call(vm_set_trusted, server.bdaddr)
     server.call(vm_set_trusted, client.bdaddr)
diff --git a/test/functional/test_obex.py b/test/functional/test_obex.py
index 79a217eae..2153510c3 100644
--- a/test/functional/test_obex.py
+++ b/test/functional/test_obex.py
@@ -194,11 +194,11 @@ obex_host_config = host_config(
 
 
 @pytest.fixture
-def obex_hosts(paired_hosts_bredr):
-    host0, host1 = paired_hosts_bredr
+def obex_hosts(paired_hosts):
+    host0, host1 = paired_hosts
 
     if hasattr(host0, "session"):
-        return paired_hosts_bredr
+        return paired_hosts
 
     host0.obex.connect(host1.bdaddr)
 
@@ -208,7 +208,7 @@ def obex_hosts(paired_hosts_bredr):
 
     host0.obex.expect("org.bluez.obex.Client1.CreateSession:reply")
 
-    yield paired_hosts_bredr
+    yield paired_hosts
 
     host1.obex_agent.cleanup()
 
-- 
2.55.0

