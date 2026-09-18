Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187F22C08AC
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 00:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789689783; cv=pass; b=DlvFhqH7W0y6Y+VOI6ln6MsHF7kDrmXU86H0xu3zq7Ot036x7zEgbRuJiWQtHTE7X57QNR2aivmjGvgmmipPSq97YLR7tU21oM0mwN6msBNnaaH126mkKp5YWf8fJQ3uMG7dqfV+X1XJpMy6BHY0xngG/7K6vnS5nANTkHdMmXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789689783; c=relaxed/simple;
	bh=JfKPoRM/dLDjfW/Ldzh5LoibZjehSCoOkCUarMEj+Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJCbdWPPQIZfQrFkexl4nQWUD+s7t0KEVgw2GvWSXEfrfHNDva0+PzJIiUFuTOBEvlfSNUuvx9CxhLolxQdPWKa8rj9u0FXgfQ+7QMaqfmr1u2Ml4UvtTzPxYHctpAIQC3GTfNOzOt1s+ZQncXz16deFUTXv4MqxCoB/CN332lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=R5bVaLdv; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="R5bVaLdv"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::dc01])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hmCW00dV4zycB;
	Fri, 18 Sep 2026 03:02:51 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789689772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWpA1b6P91fEwFthcMMX5mbRqCu7Q9l2aZcvke6dpng=;
	b=R5bVaLdvO1nlTZt+VjKNzZ4M6XHQ1PLU21PlnRIdiN9dDLD2x41duBnOnjQj21SjyWVbWt
	ec0l1jFUzrtpozWzU9ZG1jlGN34jjl3l5wfbkt6ab/yL9ueNl5m5Sa/k0AlZU7VS3ZMSRN
	x+Ujqs8CGVeBlgUWxDvTq7eVeQYeFiw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789689772;
	b=i6lIAoSW4lloFM/CrMFb4nvaRr403jmiDzY65dkpv/j3yNUyIexnLKgANTwvMnawO/x0Di
	GX9qNJ2sxkakmgXKUDCR8uHBtDwtyM0q8GyyeQHfRZyy4v6C1gBW/kDhecSMebYjDzANBp
	qq+uF2dLdrP6Y5zzaA0zlBkW6+sh2rA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789689772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWpA1b6P91fEwFthcMMX5mbRqCu7Q9l2aZcvke6dpng=;
	b=b4TqyW50c5k1C6AdAlLzhStDw4+OSvkfBvOJ6yTmfRUGL6U/6+Rc9akx1DsT9Q0QTMPRpu
	5/P9tSS8NLN16IpnfOZOwBBYDe9V558ai4MDjijD/UCNOmGLYcmJIoIAmfYrg6/bHLpU4y
	MmAx39siTkUlQ5BdH5STxgyn8pTK5/8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 4/4] test: functional: run CSIP test for Secure Connections & Legacy Pairing
Date: Fri, 18 Sep 2026 03:02:29 +0300
Message-ID: <6f7c74f4cbd467f2923e9b17c1883d0b6c4a8415.1789689632.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789689632.git.pav@iki.fi>
References: <cover.1789689632.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parametrize test_bap_unicast_set_transport_created() to test CSIP with
and without Secure connections, toggling it with btmgmt before pairing.

test/functional/test_bap.py::test_bap_unicast_set_transport_created[hosts7-vm3-sc]
test/functional/test_bap.py::test_bap_unicast_set_transport_created[hosts7-vm3-legacy]
---
 test/functional/test_bap.py | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/test/functional/test_bap.py b/test/functional/test_bap.py
index ce11dc38d..2f3334387 100644
--- a/test/functional/test_bap.py
+++ b/test/functional/test_bap.py
@@ -9,7 +9,7 @@ import warnings
 
 import pytest
 
-from pytest_bluezenv import Bluetoothd, Pexpect, find_exe, host_config
+from pytest_bluezenv import Bluetoothd, Pexpect, find_exe, host_config, run
 from pytest_bluezenv.utils import bluez_src_dir
 
 pytestmark = [pytest.mark.vm]
@@ -437,7 +437,19 @@ set_host_config = host_config(
 
 
 @pytest.fixture
-def set_hosts(hosts):
+def secure_connections(hosts, request):
+    """Set Secure Connections from fixture param"""
+
+    if getattr(request, "param", None) is None:
+        return
+
+    btmgmt = find_exe("tools", "btmgmt")
+    for host in hosts:
+        host.call(run, [btmgmt, "sc", request.param], check=True)
+
+
+@pytest.fixture
+def set_hosts(hosts, secure_connections):
     """
     Initiator (host0) and two acceptors forming a coordinated set, one
     taking the left channel (host1) and one the right (host2), paired
@@ -535,8 +547,11 @@ def set_hosts(hosts):
     yield host0, host1, host2, initiator, left, right, transports
 
 
+@pytest.mark.parametrize(
+    "secure_connections", ["on", "off"], ids=["sc", "legacy"], indirect=True
+)
 @set_host_config
-def test_bap_unicast_set_transport_created(set_hosts):
+def test_bap_unicast_set_transport_created(secure_connections, set_hosts):
     host0, host1, host2, initiator, left, right, transports = set_hosts
 
     # One transport per member, each taking a single channel
-- 
2.55.0

